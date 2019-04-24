From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2 02/17] drm: Add |struct drm_gem_vram_object| callbacks
	for |struct ttm_bo_driver|
Date: Wed, 24 Apr 2019 14:13:05 +0000
Message-ID: <158d4016-74b6-cf0f-3f30-5232c0a17eaf__25499.9492944748$1556115202$gmane$org@amd.com>
References: <20190424114842.4723-1-tzimmermann@suse.de>
	<20190424114842.4723-3-tzimmermann@suse.de>
	<0fb26281-af29-5d94-6d45-6617fc886e45@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0fb26281-af29-5d94-6d45-6617fc886e45@suse.de>
Content-Language: en-US
Content-ID: <A506DC19ECAFCF498BAFB4214AACE334@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "airlied@linux.ie" <airlied@linux.ie>, "kraxel@redhat.com" <kraxel@redhat.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Zhang, Jerry" <Jerry.Zhang@amd.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "zourongrong@gmail.com" <zourongrong@gmail.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am 24.04.19 um 14:05 schrieb Thomas Zimmermann:
> Hi Christian,
>
> Am 24.04.19 um 13:48 schrieb Thomas Zimmermann:
>> +
>> +/*
>> + * Helpers for struct ttm_bo_driver
>> + */
>> +
>> +static bool drm_is_gem_vram(struct ttm_buffer_object *bo)
>> +{
>> +	return (bo->destroy == ttm_buffer_object_destroy);
>> +}
>> +
>> +/**
>> + * drm_gem_vram_bo_driver_evict_flags() - \
>> +	Implements &struct ttm_bo_driver.evict_flags
>> + * @bo:	TTM buffer object. Refers to &struct drm_gem_vram_object.bo
>> + * @pl:	TTM placement information.
>> + */
>> +void drm_gem_vram_bo_driver_evict_flags(struct ttm_buffer_object *bo,
>> +					struct ttm_placement *pl)
>> +{
>> +	struct drm_gem_vram_object *gbo;
>> +
>> +	/* TTM may pass BOs that are not GEM VRAM BOs. */
>> +	if (!drm_is_gem_vram(bo))
>> +		return;
>> +
>> +	gbo = drm_gem_vram_of_bo(bo);
>> +	drm_gem_vram_placement(gbo, TTM_PL_FLAG_SYSTEM);
>> +	*pl = gbo->placement;
>> +}
> For drm_is_gem_vram(), I'm not quite sure what else to test for. So
> there are still a few things I'd like to discuss.
>
>   1) If this test is about the placement flags, then it's unrelated to
> the actual DRM driver. All buffers of type |struct drm_gem_vram_object|
> share the same placement flags.
>
>   2) I tested the code to work with ast and mgag200.
>
>   3) If this test is really about individual instances of each DRM
> driver, then the current implementations are already broken. In this
> scenario TTM should sort out BOs with a BO device different from the one
> that triggered the eviction process; or pass the original BO device to
> the evict_flags callback, so we can sort out buffers here.

Just go ahead with the current approach for now. It could be that we see 
fallout, but that is really unlikely.

Christian.

>
> Best regards
> Thomas
>
