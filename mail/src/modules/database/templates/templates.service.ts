import { Injectable } from "@nestjs/common";
import { Model } from "mongoose";
import { Template } from "./templates.model";
import { CreateTemplateDto, UpdateTemplateDto } from "./templates.dto";
import { InjectModel } from "@nestjs/mongoose";

@Injectable()
export class TemplatesService {
    constructor(@InjectModel("Template") private readonly templatesModel: Model<Template>) {
    }

    public async create(createTemplateDto: CreateTemplateDto) {
        const template = new this.templatesModel(createTemplateDto);
        return template.save();
    }

    public async findAll(): Promise<Template[]> {
        return this.templatesModel.find().exec();
    }

    public async findOne(name: string): Promise<Template> {
        return this.templatesModel.findOne({ name: name }).exec();
    }

    public async update(name: string, updateTemplateDto: UpdateTemplateDto) {
        return this.templatesModel.update({ name: name }, updateTemplateDto).exec();
    }

    public async remove(name: string) {
        return this.templatesModel.remove({ name: name }).exec();
    }
}
