From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3 01/19] drm: Add |struct drm_gem_vram_object| and helpers
Date: Tue, 30 Apr 2019 11:23:27 +0200
Message-ID: <20190430092327.GA13757__17639.1071568773$1556616254$gmane$org@ravnborg.org>
References: <20190429144341.12615-1-tzimmermann@suse.de>
	<20190429144341.12615-2-tzimmermann@suse.de>
	<20190429195855.GA6610@ravnborg.org>
	<1d14ef87-e1cd-4f4a-3632-bc045a1981c6@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1d14ef87-e1cd-4f4a-3632-bc045a1981c6@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@linux.ie, puck.chen@hisilicon.com, Jerry.Zhang@amd.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, zourongrong@gmail.com, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Thomas.

> >> +
> >> +/**
> >> + * Returns the container of type &struct drm_gem_vram_object
> >> + * for field bo.
> >> + * @bo:		the VRAM buffer object
> >> + * Returns:	The containing GEM VRAM object
> >> + */
> >> +static inline struct drm_gem_vram_object* drm_gem_vram_of_bo(
> >> +	struct ttm_buffer_object *bo)
> >> +{
> >> +	return container_of(bo, struct drm_gem_vram_object, bo);
> >> +}
> > Indent funny. USe same indent as used in other parts of file for
> > function arguments.
> 
> If I put the argument next to the function's name, it will exceed the
> 80-character limit. From the coding-style document, I could not see what
> to do in this case. One solution would move the return type to a
> separate line before the function name. I've not seen that anywhere in
> the source code, so moving the argument onto a separate line and
> indenting by one tab appears to be the next best solution. Please let me
> know if there's if there's a preferred style for cases like this one.

Readability has IMO higher priority than some limit of 80 chars.
And it hurts readability (at least my OCD) when style changes
as you do with indent here. So my personal preference is to fix
indent and accect longer lines.

But you ask for a preferred style - which I do not think we have in this
case. So it boils down to what you prefer.

Enough bikeshedding, thanks for the quick response.

	Sam
