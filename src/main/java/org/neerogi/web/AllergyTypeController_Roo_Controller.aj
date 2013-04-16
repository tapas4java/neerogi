// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.neerogi.web;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.neerogi.domain.Allergy;
import org.neerogi.domain.AllergyType;
import org.neerogi.web.AllergyTypeController;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect AllergyTypeController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String AllergyTypeController.create(@Valid AllergyType allergyType, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, allergyType);
            return "allergytypes/create";
        }
        uiModel.asMap().clear();
        allergyType.persist();
        return "redirect:/allergytypes/" + encodeUrlPathSegment(allergyType.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String AllergyTypeController.createForm(Model uiModel) {
        populateEditForm(uiModel, new AllergyType());
        return "allergytypes/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String AllergyTypeController.show(@PathVariable("id") Integer id, Model uiModel) {
        uiModel.addAttribute("allergytype", AllergyType.findAllergyType(id));
        uiModel.addAttribute("itemId", id);
        return "allergytypes/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String AllergyTypeController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("allergytypes", AllergyType.findAllergyTypeEntries(firstResult, sizeNo));
            float nrOfPages = (float) AllergyType.countAllergyTypes() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("allergytypes", AllergyType.findAllAllergyTypes());
        }
        return "allergytypes/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String AllergyTypeController.update(@Valid AllergyType allergyType, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, allergyType);
            return "allergytypes/update";
        }
        uiModel.asMap().clear();
        allergyType.merge();
        return "redirect:/allergytypes/" + encodeUrlPathSegment(allergyType.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String AllergyTypeController.updateForm(@PathVariable("id") Integer id, Model uiModel) {
        populateEditForm(uiModel, AllergyType.findAllergyType(id));
        return "allergytypes/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String AllergyTypeController.delete(@PathVariable("id") Integer id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        AllergyType allergyType = AllergyType.findAllergyType(id);
        allergyType.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/allergytypes";
    }
    
    void AllergyTypeController.populateEditForm(Model uiModel, AllergyType allergyType) {
        uiModel.addAttribute("allergyType", allergyType);
        uiModel.addAttribute("allergys", Allergy.findAllAllergys());
    }
    
    String AllergyTypeController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}