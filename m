Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0201BC43457
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:46:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01AE22282
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UC61EvUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01AE22282
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 52D1E87475;
	Mon, 19 Oct 2020 15:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zbjFiumb6aBf; Mon, 19 Oct 2020 15:46:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 074D286852;
	Mon, 19 Oct 2020 15:46:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8465C0052;
	Mon, 19 Oct 2020 15:46:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40FA5C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2AFA18751D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:46:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y58osjf9DFpU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:46:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9A9348751B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:46:48 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id x7so290887wrl.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=HO1NWy71VB/XmKCrtzy6L4ESvVEPBzXrL3scn+Up8bc=;
 b=UC61EvUAH1ghGWvhgPIvwb0tJKvmN85XcCXlrZCX7WhPqQ5Kal9er+D9EGMj6Qy1Mw
 fLsBXywmZ7A82r1QjiPvCD/FrGiVsWYE0GJST415xH593KKFVZRAlHpTMAzkBzgOwrUv
 csDczr2hma4nlAuIXgtB1TgmwV8Q0Ey3gd2fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HO1NWy71VB/XmKCrtzy6L4ESvVEPBzXrL3scn+Up8bc=;
 b=JeXfSSpvaB/irOIcb8S3KpgPIzLD8lJzQr7Qm34Kjw/80hyf/oqmZydVy445RWP94k
 bjSZg4rQDvoj0Mc0Qw7ri2zy86cVVLr7cbRPjDRrPJzAUS8xBrxOz5e48dfKadTWX4DB
 y+G3pN1vhPbtKKdIt7RQO9WCS9X8aTWc3po8ZAvB9o6CZN58KyoN2kvn2vYCH1BHXfMP
 DCsETXgq6+RrKajvjyoX+b3DI3bbW9Jkv1dOoVJ8BjVeon9DdwPa1Dkzm745fE1xp1qW
 tQk9JTvEMSVK7sAj7KlMaWsrjTJ6Gn0XxzeXc8QeoZfFJmpWYNJEbV+BDfHWFUNbzAg8
 h2cQ==
X-Gm-Message-State: AOAM532FcsRDxO2OA9pf13yWEsz0MyMBxEfe5NcoFI9y+VPX6qXmOtot
 KgSxMItj2zCoP0lVtgfImLnleQ==
X-Google-Smtp-Source: ABdhPJw3AhcfVn5Ol/2itQNrpLAPMvDH8DFfv/LdwaotJFWGF+wLGszDKhZ9OSoAyWYoQMAHgXYlBQ==
X-Received: by 2002:adf:ea4d:: with SMTP id j13mr121871wrn.345.1603122406591; 
 Mon, 19 Oct 2020 08:46:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id s11sm138139wrm.56.2020.10.19.08.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:46:45 -0700 (PDT)
Date: Mon, 19 Oct 2020 17:46:42 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v4 05/10] drm/ttm: Add vmap/vunmap to TTM and TTM GEM
 helpers
Message-ID: <20201019154642.GF401619@phenom.ffwll.local>
References: <20201015123806.32416-1-tzimmermann@suse.de>
 <20201015123806.32416-6-tzimmermann@suse.de>
 <935d5771-5645-62a6-849c-31e286db1e30@amd.com>
 <87c7c342-88dc-9a36-31f7-dae6edd34626@suse.de>
 <9236f51c-c1fa-dadc-c7cc-d9d0c09251d1@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9236f51c-c1fa-dadc-c7cc-d9d0c09251d1@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: luben.tuikov@amd.com, heiko@sntech.de, airlied@linux.ie,
 nouveau@lists.freedesktop.org, linus.walleij@linaro.org,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 melissa.srw@gmail.com, eric@anholt.net, ray.huang@amd.com, sam@ravnborg.org,
 sumit.semwal@linaro.org, emil.velikov@collabora.com, robh@kernel.org,
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
 lima@lists.freedesktop.org, oleksandr_andrushchenko@epam.com, krzk@kernel.org,
 steven.price@arm.com, linux-rockchip@lists.infradead.org, kgene@kernel.org,
 bskeggs@redhat.com, linux+etnaviv@armlinux.org.uk,
 xen-devel@lists.xenproject.org, alyssa.rosenzweig@collabora.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 etnaviv@lists.freedesktop.org, mripard@kernel.org, inki.dae@samsung.com,
 hdegoede@redhat.com, christian.gmeiner@gmail.com,
 spice-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 sean@poorly.run, apaneers@amd.com, linux-arm-kernel@lists.infradead.org,
 linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
 tomeu.vizoso@collabora.com, sw0312.kim@samsung.com, hjc@rock-chips.com,
 kyungmin.park@samsung.com, miaoqinglang@huawei.com, yuq825@gmail.com,
 Thomas Zimmermann <tzimmermann@suse.de>, alexander.deucher@amd.com,
 linux-media@vger.kernel.org, l.stach@pengutronix.de
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Oct 19, 2020 at 11:45:05AM +0200, Christian K=F6nig wrote:
> Hi Thomas,
> =

> [SNIP]
> > > >  =A0 +int ttm_bo_vmap(struct ttm_buffer_object *bo, struct dma_buf_=
map *map)
> > > > +{
> > > > +=A0=A0=A0 struct ttm_resource *mem =3D &bo->mem;
> > > > +=A0=A0=A0 int ret;
> > > > +
> > > > +=A0=A0=A0 ret =3D ttm_mem_io_reserve(bo->bdev, mem);
> > > > +=A0=A0=A0 if (ret)
> > > > +=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > +
> > > > +=A0=A0=A0 if (mem->bus.is_iomem) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 void __iomem *vaddr_iomem;
> > > > +=A0=A0=A0=A0=A0=A0=A0 unsigned long size =3D bo->num_pages << PAGE=
_SHIFT;
> > > Please use uint64_t here and make sure to cast bo->num_pages before
> > > shifting.
> > I thought the rule of thumb is to use u64 in source code. Yet TTM only
> > uses uint*_t types. Is there anything special about TTM?
> =

> My last status is that you can use both and my personal preference is to =
use
> the uint*_t types because they are part of a higher level standard.

Yeah the only hard rule is that in uapi headers you need to use the __u64
and similar typedefs, to avoid cluttering the namespace for unrelated
stuff in userspace.

In the kernel c99 types are perfectly fine, and I think slowly on the
rise.
-Daniel

> =

> > > We have an unit tests of allocating a 8GB BO and that should work on a
> > > 32bit machine as well :)
> > > =

> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (mem->bus.addr)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vaddr_iomem =3D (void *)(((u8 *)=
mem->bus.addr));
> > I after reading the patch again, I realized that this is the
> > 'ttm_bo_map_premapped' case and it's missing from _vunmap(). I see two
> > options here: ignore this case in _vunmap(), or do an ioremap()
> > unconditionally. Which one is preferable?
> =

> ioremap would be very very bad, so we should just do nothing.
> =

> Thanks,
> Christian.
> =

> > =

> > Best regards
> > Thomas
> > =

> > > > +=A0=A0=A0=A0=A0=A0=A0 else if (mem->placement & TTM_PL_FLAG_WC)
> > > I've just nuked the TTM_PL_FLAG_WC flag in drm-misc-next. There is a =
new
> > > mem->bus.caching enum as replacement.
> > > =

> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vaddr_iomem =3D ioremap_wc(mem->=
bus.offset, size);
> > > > +=A0=A0=A0=A0=A0=A0=A0 else
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vaddr_iomem =3D ioremap(mem->bus=
.offset, size);
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (!vaddr_iomem)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 dma_buf_map_set_vaddr_iomem(map, vaddr_iomem=
);
> > > > +
> > > > +=A0=A0=A0 } else {
> > > > +=A0=A0=A0=A0=A0=A0=A0 struct ttm_operation_ctx ctx =3D {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .interruptible =3D false,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .no_wait_gpu =3D false
> > > > +=A0=A0=A0=A0=A0=A0=A0 };
> > > > +=A0=A0=A0=A0=A0=A0=A0 struct ttm_tt *ttm =3D bo->ttm;
> > > > +=A0=A0=A0=A0=A0=A0=A0 pgprot_t prot;
> > > > +=A0=A0=A0=A0=A0=A0=A0 void *vaddr;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 BUG_ON(!ttm);
> > > I think we can drop this, populate will just crash badly anyway.
> > > =

> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D ttm_tt_populate(bo->bdev, ttm, &ctx);
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * We need to use vmap to get the desired =
page protection
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * or to make the buffer object look conti=
guous.
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > +=A0=A0=A0=A0=A0=A0=A0 prot =3D ttm_io_prot(mem->placement, PAGE_KE=
RNEL);
> > > The calling convention has changed on drm-misc-next as well, but shou=
ld
> > > be trivial to adapt.
> > > =

> > > Regards,
> > > Christian.
> > > =

> > > > +=A0=A0=A0=A0=A0=A0=A0 vaddr =3D vmap(ttm->pages, bo->num_pages, 0,=
 prot);
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (!vaddr)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 dma_buf_map_set_vaddr(map, vaddr);
> > > > +=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0 return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(ttm_bo_vmap);
> > > > +
> > > > +void ttm_bo_vunmap(struct ttm_buffer_object *bo, struct dma_buf_map
> > > > *map)
> > > > +{
> > > > +=A0=A0=A0 if (dma_buf_map_is_null(map))
> > > > +=A0=A0=A0=A0=A0=A0=A0 return;
> > > > +
> > > > +=A0=A0=A0 if (map->is_iomem)
> > > > +=A0=A0=A0=A0=A0=A0=A0 iounmap(map->vaddr_iomem);
> > > > +=A0=A0=A0 else
> > > > +=A0=A0=A0=A0=A0=A0=A0 vunmap(map->vaddr);
> > > > +=A0=A0=A0 dma_buf_map_clear(map);
> > > > +
> > > > +=A0=A0=A0 ttm_mem_io_free(bo->bdev, &bo->mem);
> > > > +}
> > > > +EXPORT_SYMBOL(ttm_bo_vunmap);
> > > > +
> > > >  =A0 static int ttm_bo_wait_free_node(struct ttm_buffer_object *bo,
> > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool dst_us=
e_tt)
> > > >  =A0 {
> > > > diff --git a/include/drm/drm_gem_ttm_helper.h
> > > > b/include/drm/drm_gem_ttm_helper.h
> > > > index 118cef76f84f..7c6d874910b8 100644
> > > > --- a/include/drm/drm_gem_ttm_helper.h
> > > > +++ b/include/drm/drm_gem_ttm_helper.h
> > > > @@ -10,11 +10,17 @@
> > > >  =A0 #include <drm/ttm/ttm_bo_api.h>
> > > >  =A0 #include <drm/ttm/ttm_bo_driver.h>
> > > >  =A0 +struct dma_buf_map;
> > > > +
> > > >  =A0 #define drm_gem_ttm_of_gem(gem_obj) \
> > > >  =A0=A0=A0=A0=A0 container_of(gem_obj, struct ttm_buffer_object, ba=
se)
> > > >  =A0 =A0 void drm_gem_ttm_print_info(struct drm_printer *p, unsigne=
d int
> > > > indent,
> > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct d=
rm_gem_object *gem);
> > > > +int drm_gem_ttm_vmap(struct drm_gem_object *gem,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dma_buf_map *map);
> > > > +void drm_gem_ttm_vunmap(struct drm_gem_object *gem,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dma_buf_map *map);
> > > >  =A0 int drm_gem_ttm_mmap(struct drm_gem_object *gem,
> > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct vm_area_struct *=
vma);
> > > >  =A0 diff --git a/include/drm/ttm/ttm_bo_api.h
> > > > b/include/drm/ttm/ttm_bo_api.h
> > > > index 37102e45e496..2c59a785374c 100644
> > > > --- a/include/drm/ttm/ttm_bo_api.h
> > > > +++ b/include/drm/ttm/ttm_bo_api.h
> > > > @@ -48,6 +48,8 @@ struct ttm_bo_global;
> > > >  =A0 =A0 struct ttm_bo_device;
> > > >  =A0 +struct dma_buf_map;
> > > > +
> > > >  =A0 struct drm_mm_node;
> > > >  =A0 =A0 struct ttm_placement;
> > > > @@ -494,6 +496,32 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo,
> > > > unsigned long start_page,
> > > >  =A0=A0 */
> > > >  =A0 void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map);
> > > >  =A0 +/**
> > > > + * ttm_bo_vmap
> > > > + *
> > > > + * @bo: The buffer object.
> > > > + * @map: pointer to a struct dma_buf_map representing the map.
> > > > + *
> > > > + * Sets up a kernel virtual mapping, using ioremap or vmap to the
> > > > + * data in the buffer object. The parameter @map returns the virtu=
al
> > > > + * address as struct dma_buf_map. Unmap the buffer with ttm_bo_vun=
map().
> > > > + *
> > > > + * Returns
> > > > + * -ENOMEM: Out of memory.
> > > > + * -EINVAL: Invalid range.
> > > > + */
> > > > +int ttm_bo_vmap(struct ttm_buffer_object *bo, struct dma_buf_map *=
map);
> > > > +
> > > > +/**
> > > > + * ttm_bo_vunmap
> > > > + *
> > > > + * @bo: The buffer object.
> > > > + * @map: Object describing the map to unmap.
> > > > + *
> > > > + * Unmaps a kernel map set up by ttm_bo_vmap().
> > > > + */
> > > > +void ttm_bo_vunmap(struct ttm_buffer_object *bo, struct dma_buf_map
> > > > *map);
> > > > +
> > > >  =A0 /**
> > > >  =A0=A0 * ttm_bo_mmap_obj - mmap memory backed by a ttm buffer obje=
ct.
> > > >  =A0=A0 *
> > > > diff --git a/include/linux/dma-buf-map.h b/include/linux/dma-buf-ma=
p.h
> > > > index fd1aba545fdf..2e8bbecb5091 100644
> > > > --- a/include/linux/dma-buf-map.h
> > > > +++ b/include/linux/dma-buf-map.h
> > > > @@ -45,6 +45,12 @@
> > > >  =A0=A0 *
> > > >  =A0=A0 *=A0=A0=A0 dma_buf_map_set_vaddr(&map. 0xdeadbeaf);
> > > >  =A0=A0 *
> > > > + * To set an address in I/O memory, use dma_buf_map_set_vaddr_iome=
m().
> > > > + *
> > > > + * .. code-block:: c
> > > > + *
> > > > + *=A0=A0=A0 dma_buf_map_set_vaddr_iomem(&map. 0xdeadbeaf);
> > > > + *
> > > >  =A0=A0 * Test if a mapping is valid with either dma_buf_map_is_set=
() or
> > > >  =A0=A0 * dma_buf_map_is_null().
> > > >  =A0=A0 *
> > > > @@ -118,6 +124,20 @@ static inline void dma_buf_map_set_vaddr(struct
> > > > dma_buf_map *map, void *vaddr)
> > > >  =A0=A0=A0=A0=A0 map->is_iomem =3D false;
> > > >  =A0 }
> > > >  =A0 +/**
> > > > + * dma_buf_map_set_vaddr_iomem - Sets a dma-buf mapping structure =
to
> > > > an address in I/O memory
> > > > + * @map:=A0=A0=A0=A0=A0=A0=A0 The dma-buf mapping structure
> > > > + * @vaddr_iomem:=A0=A0=A0 An I/O-memory address
> > > > + *
> > > > + * Sets the address and the I/O-memory flag.
> > > > + */
> > > > +static inline void dma_buf_map_set_vaddr_iomem(struct dma_buf_map =
*map,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 void __iomem *vaddr_iomem)
> > > > +{
> > > > +=A0=A0=A0 map->vaddr_iomem =3D vaddr_iomem;
> > > > +=A0=A0=A0 map->is_iomem =3D true;
> > > > +}
> > > > +
> > > >  =A0 /**
> > > >  =A0=A0 * dma_buf_map_is_equal - Compares two dma-buf mapping struc=
tures
> > > > for equality
> > > >  =A0=A0 * @lhs:=A0=A0=A0 The dma-buf mapping structure
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C01%7C=
christian.koenig%40amd.com%7C07bc68af3c6440b5be8d08d8740e9b32%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637386953433558595%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;sdata=3DRlGCmjzyZERvqfnl4kA1bEHez5bkLf3F9OlKi2ybDAM%3D&amp;reserved=3D0
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
