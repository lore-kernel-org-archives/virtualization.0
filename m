Return-Path: <SRS0=KkKJ=DO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD43C47095
	for <virtualization@archiver.kernel.org>; Wed,  7 Oct 2020 13:20:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE3520789
	for <virtualization@archiver.kernel.org>; Wed,  7 Oct 2020 13:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE3520789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0A19087264;
	Wed,  7 Oct 2020 13:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93qU0hh+jpNC; Wed,  7 Oct 2020 13:20:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D32D5869D8;
	Wed,  7 Oct 2020 13:20:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C33F3C07FF;
	Wed,  7 Oct 2020 13:20:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8953BC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 13:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 76A9B86214
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 13:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ejy9k-aMiYn
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 13:20:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B9C89861CE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 13:20:33 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 12A15AC6D;
 Wed,  7 Oct 2020 13:20:32 +0000 (UTC)
Subject: Re: [PATCH v3 2/7] drm/ttm: Add ttm_kmap_obj_to_dma_buf_map() for
 type conversion
To: Daniel Vetter <daniel@ffwll.ch>
References: <20200929151437.19717-1-tzimmermann@suse.de>
 <20200929151437.19717-3-tzimmermann@suse.de>
 <8fad0114-064a-4ed5-c21d-d1b4294de0a1@amd.com>
 <2614314a-81f7-4722-c400-68d90e48e09a@suse.de>
 <8a84f62b-33f3-f44c-52af-c859a0e0d1fb@gmail.com>
 <07972ada-9135-3743-a86b-487f610c509f@suse.de>
 <b569b7e3-68f0-edcc-c8f4-170e9042d348@gmail.com>
 <20200930094712.GW438822@phenom.ffwll.local>
 <8479d0aa-3826-4f37-0109-55daca515793@amd.com>
 <CAKMK7uH0U36NG8w98i0x6HVGeogiwnYDRiKquLW-8znLa7-0yg@mail.gmail.com>
 <20201002095830.GH438822@phenom.ffwll.local>
 <5bf40546-8da9-1649-22da-a982f1e8d9c3@suse.de>
 <CAKMK7uEu0vwiG9Uz0_Ysyus0ZAF-1HNxvPZjcG3xZS=gkKgJLw@mail.gmail.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <26ac0446-9e16-1ca1-7407-3d0cd7125e0e@suse.de>
Date: Wed, 7 Oct 2020 15:20:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uEu0vwiG9Uz0_Ysyus0ZAF-1HNxvPZjcG3xZS=gkKgJLw@mail.gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Nouveau Dev <nouveau@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Wilson,
 Chris" <chris@chris-wilson.co.uk>, Melissa Wen <melissa.srw@gmail.com>,
 Huang Rui <ray.huang@amd.com>, Qiang Yu <yuq825@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Emil Velikov <emil.velikov@collabora.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, lima@lists.freedesktop.org,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Steven Price <steven.price@arm.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Luben Tuikov <luben.tuikov@amd.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Ben Skeggs <bskeggs@redhat.com>,
 The etnaviv authors <etnaviv@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Hans de Goede <hdegoede@redhat.com>,
 "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>,
 "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>,
 Sean Paul <sean@poorly.run>, apaneers@amd.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Sandy Huang <hjc@rock-chips.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Qinglang Miao <miaoqinglang@huawei.com>, Kukjin Kim <kgene@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4323762590719954972=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4323762590719954972==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0t1cYEjuOo3ZVuYcbyfHXuvT4PSflGI9R"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0t1cYEjuOo3ZVuYcbyfHXuvT4PSflGI9R
Content-Type: multipart/mixed; boundary="savrqrLWkICrB7uZmjWpjSJFgaQuM1qd4";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Luben Tuikov <luben.tuikov@amd.com>, Dave Airlie <airlied@linux.ie>,
 Nouveau Dev <nouveau@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "Wilson, Chris" <chris@chris-wilson.co.uk>,
 Melissa Wen <melissa.srw@gmail.com>, Huang Rui <ray.huang@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Emil Velikov <emil.velikov@collabora.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, lima@lists.freedesktop.org,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Steven Price <steven.price@arm.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Kukjin Kim <kgene@kernel.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>,
 The etnaviv authors <etnaviv@lists.freedesktop.org>,
 Hans de Goede <hdegoede@redhat.com>,
 "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>,
 "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>,
 Sean Paul <sean@poorly.run>, apaneers@amd.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK"
 <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Sandy Huang <hjc@rock-chips.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Qinglang Miao <miaoqinglang@huawei.com>, Qiang Yu <yuq825@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <26ac0446-9e16-1ca1-7407-3d0cd7125e0e@suse.de>
Subject: Re: [PATCH v3 2/7] drm/ttm: Add ttm_kmap_obj_to_dma_buf_map() for
 type conversion
References: <20200929151437.19717-1-tzimmermann@suse.de>
 <20200929151437.19717-3-tzimmermann@suse.de>
 <8fad0114-064a-4ed5-c21d-d1b4294de0a1@amd.com>
 <2614314a-81f7-4722-c400-68d90e48e09a@suse.de>
 <8a84f62b-33f3-f44c-52af-c859a0e0d1fb@gmail.com>
 <07972ada-9135-3743-a86b-487f610c509f@suse.de>
 <b569b7e3-68f0-edcc-c8f4-170e9042d348@gmail.com>
 <20200930094712.GW438822@phenom.ffwll.local>
 <8479d0aa-3826-4f37-0109-55daca515793@amd.com>
 <CAKMK7uH0U36NG8w98i0x6HVGeogiwnYDRiKquLW-8znLa7-0yg@mail.gmail.com>
 <20201002095830.GH438822@phenom.ffwll.local>
 <5bf40546-8da9-1649-22da-a982f1e8d9c3@suse.de>
 <CAKMK7uEu0vwiG9Uz0_Ysyus0ZAF-1HNxvPZjcG3xZS=gkKgJLw@mail.gmail.com>
In-Reply-To: <CAKMK7uEu0vwiG9Uz0_Ysyus0ZAF-1HNxvPZjcG3xZS=gkKgJLw@mail.gmail.com>

--savrqrLWkICrB7uZmjWpjSJFgaQuM1qd4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.10.20 um 15:10 schrieb Daniel Vetter:
> On Wed, Oct 7, 2020 at 2:57 PM Thomas Zimmermann <tzimmermann@suse.de> =
wrote:
>>
>> Hi
>>
>> Am 02.10.20 um 11:58 schrieb Daniel Vetter:
>>> On Wed, Sep 30, 2020 at 02:51:46PM +0200, Daniel Vetter wrote:
>>>> On Wed, Sep 30, 2020 at 2:34 PM Christian K=C3=B6nig
>>>> <christian.koenig@amd.com> wrote:
>>>>>
>>>>> Am 30.09.20 um 11:47 schrieb Daniel Vetter:
>>>>>> On Wed, Sep 30, 2020 at 10:34:31AM +0200, Christian K=C3=B6nig wro=
te:
>>>>>>> Am 30.09.20 um 10:19 schrieb Thomas Zimmermann:
>>>>>>>> Hi
>>>>>>>>
>>>>>>>> Am 30.09.20 um 10:05 schrieb Christian K=C3=B6nig:
>>>>>>>>> Am 29.09.20 um 19:49 schrieb Thomas Zimmermann:
>>>>>>>>>> Hi Christian
>>>>>>>>>>
>>>>>>>>>> Am 29.09.20 um 17:35 schrieb Christian K=C3=B6nig:
>>>>>>>>>>> Am 29.09.20 um 17:14 schrieb Thomas Zimmermann:
>>>>>>>>>>>> The new helper ttm_kmap_obj_to_dma_buf() extracts address an=
d location
>>>>>>>>>>>> from and instance of TTM's kmap_obj and initializes struct d=
ma_buf_map
>>>>>>>>>>>> with these values. Helpful for TTM-based drivers.
>>>>>>>>>>> We could completely drop that if we use the same structure in=
side TTM as
>>>>>>>>>>> well.
>>>>>>>>>>>
>>>>>>>>>>> Additional to that which driver is going to use this?
>>>>>>>>>> As Daniel mentioned, it's in patch 3. The TTM-based drivers wi=
ll
>>>>>>>>>> retrieve the pointer via this function.
>>>>>>>>>>
>>>>>>>>>> I do want to see all that being more tightly integrated into T=
TM, but
>>>>>>>>>> not in this series. This one is about fixing the bochs-on-spar=
c64
>>>>>>>>>> problem for good. Patch 7 adds an update to TTM to the DRM TOD=
O list.
>>>>>>>>> I should have asked which driver you try to fix here :)
>>>>>>>>>
>>>>>>>>> In this case just keep the function inside bochs and only fix i=
t there.
>>>>>>>>>
>>>>>>>>> All other drivers can be fixed when we generally pump this thro=
ugh TTM.
>>>>>>>> Did you take a look at patch 3? This function will be used by VR=
AM
>>>>>>>> helpers, nouveau, radeon, amdgpu and qxl. If we don't put it her=
e, we
>>>>>>>> have to duplicate the functionality in each if these drivers. Bo=
chs
>>>>>>>> itself uses VRAM helpers and doesn't touch the function directly=
=2E
>>>>>>> Ah, ok can we have that then only in the VRAM helpers?
>>>>>>>
>>>>>>> Alternative you could go ahead and use dma_buf_map in ttm_bo_kmap=
_obj
>>>>>>> directly and drop the hack with the TTM_BO_MAP_IOMEM_MASK.
>>>>>>>
>>>>>>> What I want to avoid is to have another conversion function in TT=
M because
>>>>>>> what happens here is that we already convert from ttm_bus_placeme=
nt to
>>>>>>> ttm_bo_kmap_obj and then to dma_buf_map.
>>>>>> Hm I'm not really seeing how that helps with a gradual conversion =
of
>>>>>> everything over to dma_buf_map and assorted helpers for access? Th=
ere's
>>>>>> too many places in ttm drivers where is_iomem and related stuff is=
 used to
>>>>>> be able to convert it all in one go. An intermediate state with a =
bunch of
>>>>>> conversions seems fairly unavoidable to me.
>>>>>
>>>>> Fair enough. I would just have started bottom up and not top down.
>>>>>
>>>>> Anyway feel free to go ahead with this approach as long as we can r=
emove
>>>>> the new function again when we clean that stuff up for good.
>>>>
>>>> Yeah I guess bottom up would make more sense as a refactoring. But t=
he
>>>> main motivation to land this here is to fix the __mmio vs normal
>>>> memory confusion in the fbdev emulation helpers for sparc (and
>>>> anything else that needs this). Hence the top down approach for
>>>> rolling this out.
>>>
>>> Ok I started reviewing this a bit more in-depth, and I think this is =
a bit
>>> too much of a de-tour.
>>>
>>> Looking through all the callers of ttm_bo_kmap almost everyone maps t=
he
>>> entire object. Only vmwgfx uses to map less than that. Also, everyone=
 just
>>> immediately follows up with converting that full object map into a
>>> pointer.
>>>
>>> So I think what we really want here is:
>>> - new function
>>>
>>> int ttm_bo_vmap(struct ttm_buffer_object *bo, struct dma_buf_map *map=
);
>>>
>>>   _vmap name since that's consistent with both dma_buf functions and
>>>   what's usually used to implement this. Outside of the ttm world kma=
p
>>>   usually just means single-page mappings using kmap() or it's iomem
>>>   sibling io_mapping_map* so rather confusing name for a function whi=
ch
>>>   usually is just used to set up a vmap of the entire buffer.
>>>
>>> - a helper which can be used for the drm_gem_object_funcs vmap/vunmap=

>>>   functions for all ttm drivers. We should be able to make this fully=

>>>   generic because a) we now have dma_buf_map and b) drm_gem_object is=

>>>   embedded in the ttm_bo, so we can upcast for everyone who's both a =
ttm
>>>   and gem driver.
>>>
>>>   This is maybe a good follow-up, since it should allow us to ditch q=
uite
>>>   a bit of the vram helper code for this more generic stuff. I also m=
ight
>>>   have missed some special-cases here, but from a quick look everythi=
ng
>>>   just pins the buffer to the current location and that's it.
>>>
>>>   Also this obviously requires Christian's generic ttm_bo_pin rework
>>>   first.
>>>
>>> - roll the above out to drivers.
>>>
>>> Christian/Thomas, thoughts on this?
>>
>> I agree on the goals, but what is the immediate objective here?
>>
>> Adding ttm_bo_vmap() does not work out easily, as struct ttm_bo_kmap_o=
bj
>> is a central part of the internals of TTM. struct ttm_bo_kmap_obj has
>> more internal state that struct dma_buf_map, so they are not easily
>> convertible either. What you propose seems to require a reimplementati=
on
>> of the existing ttm_bo_kmap() code. That is it's own patch series.
>>
>> I'd rather go with some variant of the existing patch and add
>> ttm_bo_vmap() in a follow-up.
>=20
> ttm_bo_vmap would simply wrap what you currently open-code as
> ttm_bo_kmap + ttm_kmap_obj_to_dma_buf_map. Removing ttm_kmap_obj would
> be a much later step. Why do you think adding ttm_bo_vmap is not
> possible?

The calls to ttm_bo_kmap/_kunmap() require an instance of struct
ttm_bo_kmap_obj that is stored in each driver's private bo structure
(e.g., struct drm_gem_vram_object, struct radeon_bo, etc). When I made
patch 3, I flirted with the idea of unifying the driver's _vmap code in
a shared helper, but I couldn't find a simple way of doing it. That's
why it's open-coded in the first place.

Best regards
Thomas

> -Daniel
>=20
>=20
>> Best regards
>> Thomas
>>
>>>
>>> I think for the immediate need of rolling this out for vram helpers a=
nd
>>> fbdev code we should be able to do this, but just postpone the driver=
 wide
>>> roll-out for now.
>>>
>>> Cheers, Daniel
>>>
>>>> -Daniel
>>>>
>>>>>
>>>>> Christian.
>>>>>
>>>>>> -Daniel
>>>>>>
>>>>>>> Thanks,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> Best regards
>>>>>>>> Thomas
>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> Best regards
>>>>>>>>>> Thomas
>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>> Christian.
>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>>>>>>>>> ---
>>>>>>>>>>>>     include/drm/ttm/ttm_bo_api.h | 24 ++++++++++++++++++++++=
++
>>>>>>>>>>>>     include/linux/dma-buf-map.h  | 20 ++++++++++++++++++++
>>>>>>>>>>>>     2 files changed, 44 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/=
ttm_bo_api.h
>>>>>>>>>>>> index c96a25d571c8..62d89f05a801 100644
>>>>>>>>>>>> --- a/include/drm/ttm/ttm_bo_api.h
>>>>>>>>>>>> +++ b/include/drm/ttm/ttm_bo_api.h
>>>>>>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>>>>>>     #include <drm/drm_gem.h>
>>>>>>>>>>>>     #include <drm/drm_hashtab.h>
>>>>>>>>>>>>     #include <drm/drm_vma_manager.h>
>>>>>>>>>>>> +#include <linux/dma-buf-map.h>
>>>>>>>>>>>>     #include <linux/kref.h>
>>>>>>>>>>>>     #include <linux/list.h>
>>>>>>>>>>>>     #include <linux/wait.h>
>>>>>>>>>>>> @@ -486,6 +487,29 @@ static inline void *ttm_kmap_obj_virtua=
l(struct
>>>>>>>>>>>> ttm_bo_kmap_obj *map,
>>>>>>>>>>>>         return map->virtual;
>>>>>>>>>>>>     }
>>>>>>>>>>>>     +/**
>>>>>>>>>>>> + * ttm_kmap_obj_to_dma_buf_map
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * @kmap: A struct ttm_bo_kmap_obj returned from ttm_bo_kma=
p.
>>>>>>>>>>>> + * @map: Returns the mapping as struct dma_buf_map
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * Converts struct ttm_bo_kmap_obj to struct dma_buf_map. I=
f the memory
>>>>>>>>>>>> + * is not mapped, the returned mapping is initialized to NU=
LL.
>>>>>>>>>>>> + */
>>>>>>>>>>>> +static inline void ttm_kmap_obj_to_dma_buf_map(struct ttm_b=
o_kmap_obj
>>>>>>>>>>>> *kmap,
>>>>>>>>>>>> +                           struct dma_buf_map *map)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    bool is_iomem;
>>>>>>>>>>>> +    void *vaddr =3D ttm_kmap_obj_virtual(kmap, &is_iomem);
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (!vaddr)
>>>>>>>>>>>> +        dma_buf_map_clear(map);
>>>>>>>>>>>> +    else if (is_iomem)
>>>>>>>>>>>> +        dma_buf_map_set_vaddr_iomem(map, (void __force __io=
mem *)vaddr);
>>>>>>>>>>>> +    else
>>>>>>>>>>>> +        dma_buf_map_set_vaddr(map, vaddr);
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>>     /**
>>>>>>>>>>>>      * ttm_bo_kmap
>>>>>>>>>>>>      *
>>>>>>>>>>>> diff --git a/include/linux/dma-buf-map.h b/include/linux/dma=
-buf-map.h
>>>>>>>>>>>> index fd1aba545fdf..2e8bbecb5091 100644
>>>>>>>>>>>> --- a/include/linux/dma-buf-map.h
>>>>>>>>>>>> +++ b/include/linux/dma-buf-map.h
>>>>>>>>>>>> @@ -45,6 +45,12 @@
>>>>>>>>>>>>      *
>>>>>>>>>>>>      *    dma_buf_map_set_vaddr(&map. 0xdeadbeaf);
>>>>>>>>>>>>      *
>>>>>>>>>>>> + * To set an address in I/O memory, use dma_buf_map_set_vad=
dr_iomem().
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * .. code-block:: c
>>>>>>>>>>>> + *
>>>>>>>>>>>> + *    dma_buf_map_set_vaddr_iomem(&map. 0xdeadbeaf);
>>>>>>>>>>>> + *
>>>>>>>>>>>>      * Test if a mapping is valid with either dma_buf_map_is=
_set() or
>>>>>>>>>>>>      * dma_buf_map_is_null().
>>>>>>>>>>>>      *
>>>>>>>>>>>> @@ -118,6 +124,20 @@ static inline void dma_buf_map_set_vadd=
r(struct
>>>>>>>>>>>> dma_buf_map *map, void *vaddr)
>>>>>>>>>>>>         map->is_iomem =3D false;
>>>>>>>>>>>>     }
>>>>>>>>>>>>     +/**
>>>>>>>>>>>> + * dma_buf_map_set_vaddr_iomem - Sets a dma-buf mapping str=
ucture to
>>>>>>>>>>>> an address in I/O memory
>>>>>>>>>>>> + * @map:        The dma-buf mapping structure
>>>>>>>>>>>> + * @vaddr_iomem:    An I/O-memory address
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * Sets the address and the I/O-memory flag.
>>>>>>>>>>>> + */
>>>>>>>>>>>> +static inline void dma_buf_map_set_vaddr_iomem(struct dma_b=
uf_map *map,
>>>>>>>>>>>> +                           void __iomem *vaddr_iomem)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    map->vaddr_iomem =3D vaddr_iomem;
>>>>>>>>>>>> +    map->is_iomem =3D true;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>>     /**
>>>>>>>>>>>>      * dma_buf_map_is_equal - Compares two dma-buf mapping s=
tructures
>>>>>>>>>>>> for equality
>>>>>>>>>>>>      * @lhs:    The dma-buf mapping structure
>>>>>>>>>>> _______________________________________________
>>>>>>>>>>> dri-devel mailing list
>>>>>>>>>>> dri-devel@lists.freedesktop.org
>>>>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D=
02%7C01%7Cchristian.koenig%40amd.com%7C472c3d655a61411deb6708d86525d1b8%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637370560438965013&amp;sdata=3D=
HdHOA%2F1VcIX%2F7YtfYTiAqYEvw7Ag%2FS%2BxS5VwJKOv5y0%3D&amp;reserved=3D0
>>>>>>>>>> _______________________________________________
>>>>>>>>>> amd-gfx mailing list
>>>>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%=
7C01%7Cchristian.koenig%40amd.com%7C472c3d655a61411deb6708d86525d1b8%7C3d=
d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637370560438965013&amp;sdata=3DH=
%2B5HKCsTrksRV2EyEiFGSTyS79jsWCmJimSMoJYusx8%3D&amp;reserved=3D0
>>>>>>>>> _______________________________________________
>>>>>>>>> dri-devel mailing list
>>>>>>>>> dri-devel@lists.freedesktop.org
>>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D02=
%7C01%7Cchristian.koenig%40amd.com%7C472c3d655a61411deb6708d86525d1b8%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637370560438965013&amp;sdata=3D=
HdHOA%2F1VcIX%2F7YtfYTiAqYEvw7Ag%2FS%2BxS5VwJKOv5y0%3D&amp;reserved=3D0
>>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> amd-gfx mailing list
>>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C=
01%7Cchristian.koenig%40amd.com%7C472c3d655a61411deb6708d86525d1b8%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637370560438965013&amp;sdata=3DH%2=
B5HKCsTrksRV2EyEiFGSTyS79jsWCmJimSMoJYusx8%3D&amp;reserved=3D0
>>>>>
>>>>
>>>>
>>>> --
>>>> Daniel Vetter
>>>> Software Engineer, Intel Corporation
>>>> http://blog.ffwll.ch
>>>
>>
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
>> (HRB 36809, AG N=C3=BCrnberg)
>> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>>
>=20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--savrqrLWkICrB7uZmjWpjSJFgaQuM1qd4--

--0t1cYEjuOo3ZVuYcbyfHXuvT4PSflGI9R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl99wJsUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiP16gf+MAiAf+Uq4sRUXeFXHiI+JaHLKESL
G19zoVsU0zvLfJzfn2OBUKogUiHNPcV/nSwAC2PVWC0F1TcMt5Do32z3eR+weU+A
qWqK+roLoPOUK3HQaEvCqJ+6wy/We6m6ZEEhSMpEkmWd88by218Api5shkZJdfDW
+59khIgd+QAkgWmyb2HBFnlppmF9jOmGFhPLxzC6UPXdpnB+sytnBFfjIGujR1oK
BarNzdsdqJQQf4AWdVraC4GzVIpOS+2mbKyWiFJ9qE9OHtzgbmbNJbE2F3ymff+u
WTZx5dwK7/Ed06WYgCyI5m0lVlAy3HVLkKrXJKvG/snJ8KK/b3IgQlqtKg==
=UOQ/
-----END PGP SIGNATURE-----

--0t1cYEjuOo3ZVuYcbyfHXuvT4PSflGI9R--

--===============4323762590719954972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4323762590719954972==--
