From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v3 01/19] drm: Add |struct drm_gem_vram_object| and helpers
Date: Tue, 30 Apr 2019 09:35:33 +0000
Message-ID: <6e07e6c9-2ce7-c39f-8d55-46e811c61510__2143.75344091735$1556616978$gmane$org@amd.com>
References: <20190429144341.12615-1-tzimmermann@suse.de>
	<20190429144341.12615-2-tzimmermann@suse.de>
	<20190429195855.GA6610@ravnborg.org>
	<1d14ef87-e1cd-4f4a-3632-bc045a1981c6@suse.de>
	<20190430092327.GA13757@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190430092327.GA13757@ravnborg.org>
Content-Language: en-US
Content-ID: <FFF87B914E479B42AFD5434C88750B98@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>, "Zhang,
	Jerry" <Jerry.Zhang@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "Huang, Ray" <Ray.Huang@amd.com>, "zourongrong@gmail.com" <zourongrong@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Am 30.04.19 um 11:23 schrieb Sam Ravnborg:
> [CAUTION: External Email]
>
> Hi Thomas.
>
>>>> +
>>>> +/**
>>>> + * Returns the container of type &struct drm_gem_vram_object
>>>> + * for field bo.
>>>> + * @bo:           the VRAM buffer object
>>>> + * Returns:       The containing GEM VRAM object
>>>> + */
>>>> +static inline struct drm_gem_vram_object* drm_gem_vram_of_bo(
>>>> +  struct ttm_buffer_object *bo)
>>>> +{
>>>> +  return container_of(bo, struct drm_gem_vram_object, bo);
>>>> +}
>>> Indent funny. USe same indent as used in other parts of file for
>>> function arguments.
>> If I put the argument next to the function's name, it will exceed the
>> 80-character limit. From the coding-style document, I could not see what
>> to do in this case. One solution would move the return type to a
>> separate line before the function name. I've not seen that anywhere in
>> the source code, so moving the argument onto a separate line and
>> indenting by one tab appears to be the next best solution. Please let me
>> know if there's if there's a preferred style for cases like this one.
> Readability has IMO higher priority than some limit of 80 chars.
> And it hurts readability (at least my OCD) when style changes
> as you do with indent here. So my personal preference is to fix
> indent and accect longer lines.

In this case the an often used convention (which is also kind of 
readable) is to add a newline after the return values, but before the 
function name. E.g. something like this:

static inline struct drm_gem_vram_object*
drm_gem_vram_of_bo(struct ttm_buffer_object *bo)

Regards,
Christian.

>
> But you ask for a preferred style - which I do not think we have in this
> case. So it boils down to what you prefer.
>
> Enough bikeshedding, thanks for the quick response.
>
>          Sam
