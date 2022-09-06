Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C6BC54EE9
	for <virtualization@archiver.kernel.org>; Tue,  6 Sep 2022 20:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5576A41634;
	Tue,  6 Sep 2022 20:01:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5576A41634
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=OJjVDKh3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QnyrV6dmDZPl; Tue,  6 Sep 2022 20:01:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6A325416BE;
	Tue,  6 Sep 2022 20:01:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A325416BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19163C0033;
	Tue,  6 Sep 2022 20:01:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D606C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 20:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50B99817E4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 20:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50B99817E4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=OJjVDKh3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D1z9bA2vV110
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 20:01:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0901E817AC
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0901E817AC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 20:01:51 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 i188-20020a1c3bc5000000b003a7b6ae4eb2so10282358wma.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date;
 bh=O5EcAc3lvXGI4JQrr9YrLyEGo4R9/Yu+CBbQ8ensU3s=;
 b=OJjVDKh3fcI/VQtO8L3fMXmkefvnaZ2TPXs4g3bDwXhiEMKG2tIGFa9WR1Rh+3uUBR
 zdGGM9Rmc74vfA+iORlSEN0n6yp66wZtNXZv0fPfYCTohNw3OZcMD+6dfcpdnPYyiwnh
 QoNnAEdgtugwvr2kaVFYcJT6RkBCn/qtM199k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=O5EcAc3lvXGI4JQrr9YrLyEGo4R9/Yu+CBbQ8ensU3s=;
 b=mMU0cHcXXAwFDp2exq0sWMIlaPRiDP4Ba1C5cAl0wW0MuC3D8vfipWLc6sixgzkHb0
 /XxeHMSKyX1OzaQN2TCwkVbjvpzJYZMk/IILUuzbiH3Cm0gpAscxwvVkRzo7WY1Zgs4V
 ENvgF8uaoi8I1CWFFm8M+XEwFbZ4/pEF62kVfEIi0/opg+vxWOjsOjIlb/iA6w0nMcBR
 KE/nuh40H7viqJ00LjBFAok28/QqoLGJ8KT/WzJ/Gj3MUUsIIPmgWnnEmkXrQcH3IC7A
 zJ4uWzKn36g4cP+oesqt2xB3tjckcbc+RwixlGsz3ARBxSH/PYiWBWPcpT3AevbwmL1O
 QrAQ==
X-Gm-Message-State: ACgBeo0KTlkvKRdN1L5ftqMh6IUBkmDODxQvB1TDCjZhHi8a0/MCm7+E
 nJgyPdfWBalODcwHS0fGRLYJBQ==
X-Google-Smtp-Source: AA6agR65s22H1tafLgmg1vAilgOCZbkdlz33Ij5qA3Rkmxo9dxUOa6iRjfhaDOHPYMF30Bz5WXKt1A==
X-Received: by 2002:a05:600c:34d2:b0:3a5:afe5:3eb5 with SMTP id
 d18-20020a05600c34d200b003a5afe53eb5mr14724108wmq.122.1662494510204; 
 Tue, 06 Sep 2022 13:01:50 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 y2-20020adfd082000000b0021d6924b777sm13896061wrh.115.2022.09.06.13.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Sep 2022 13:01:49 -0700 (PDT)
Date: Tue, 6 Sep 2022 22:01:47 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v1] drm/ttm: Refcount allocated tail pages
Message-ID: <YxenK8xZHC6Q4Eu4@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 Trigger Huang <Trigger.Huang@gmail.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, kvm@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20220815095423.11131-1-dmitry.osipenko@collabora.com>
 <8230a356-be38-f228-4a8e-95124e8e8db6@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8230a356-be38-f228-4a8e-95124e8e8db6@amd.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Gert Wollny <gert.wollny@collabora.com>, Huang Rui <ray.huang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, virtualization@lists.linux-foundation.org,
 Trigger Huang <Trigger.Huang@gmail.com>
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

On Mon, Aug 15, 2022 at 12:05:19PM +0200, Christian K=F6nig wrote:
> Am 15.08.22 um 11:54 schrieb Dmitry Osipenko:
> > Higher order pages allocated using alloc_pages() aren't refcounted and =
they
> > need to be refcounted, otherwise it's impossible to map them by KVM. Th=
is
> > patch sets the refcount of the tail pages and fixes the KVM memory mapp=
ing
> > faults.
> > =

> > Without this change guest virgl driver can't map host buffers into guest
> > and can't provide OpenGL 4.5 profile support to the guest. The host
> > mappings are also needed for enabling the Venus driver using host GPU
> > drivers that are utilizing TTM.
> > =

> > Based on a patch proposed by Trigger Huang.
> =

> Well I can't count how often I have repeated this: This is an absolutely
> clear NAK!
> =

> TTM pages are not reference counted in the first place and because of this
> giving them to virgl is illegal.
> =

> Please immediately stop this completely broken approach. We have discussed
> this multiple times now.

Yeah we need to get this stuff closed for real by tagging them all with
VM_IO or VM_PFNMAP asap.

It seems ot be a recurring amount of fun that people try to mmap dma-buf
and then call get_user_pages on them.

Which just doesn't work. I guess this is also why Rob Clark send out that
dma-buf patch to expos mapping information (i.e. wc vs wb vs uncached).

There seems to be some serious bonghits going on :-/
-Daniel

> =

> Regards,
> Christian.
> =

> > =

> > Cc: stable@vger.kernel.org
> > Cc: Trigger Huang <Trigger.Huang@gmail.com>
> > Link: https://www.collabora.com/news-and-blog/blog/2021/11/26/venus-on-=
qemu-enabling-new-virtual-vulkan-driver/#qcom1343
> > Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # AMDGPU (Qe=
mu and crosvm)
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >   drivers/gpu/drm/ttm/ttm_pool.c | 25 ++++++++++++++++++++++++-
> >   1 file changed, 24 insertions(+), 1 deletion(-)
> > =

> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_p=
ool.c
> > index 21b61631f73a..11e92bb149c9 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -81,6 +81,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_po=
ol *pool, gfp_t gfp_flags,
> >   	unsigned long attr =3D DMA_ATTR_FORCE_CONTIGUOUS;
> >   	struct ttm_pool_dma *dma;
> >   	struct page *p;
> > +	unsigned int i;
> >   	void *vaddr;
> >   	/* Don't set the __GFP_COMP flag for higher order allocations.
> > @@ -93,8 +94,10 @@ static struct page *ttm_pool_alloc_page(struct ttm_p=
ool *pool, gfp_t gfp_flags,
> >   	if (!pool->use_dma_alloc) {
> >   		p =3D alloc_pages(gfp_flags, order);
> > -		if (p)
> > +		if (p) {
> >   			p->private =3D order;
> > +			goto ref_tail_pages;
> > +		}
> >   		return p;
> >   	}
> > @@ -120,6 +123,23 @@ static struct page *ttm_pool_alloc_page(struct ttm=
_pool *pool, gfp_t gfp_flags,
> >   	dma->vaddr =3D (unsigned long)vaddr | order;
> >   	p->private =3D (unsigned long)dma;
> > +
> > +ref_tail_pages:
> > +	/*
> > +	 * KVM requires mapped tail pages to be refcounted because put_page()
> > +	 * is invoked on them in the end of the page fault handling, and thus,
> > +	 * tail pages need to be protected from the premature releasing.
> > +	 * In fact, KVM page fault handler refuses to map tail pages to guest
> > +	 * if they aren't refcounted because hva_to_pfn_remapped() checks the
> > +	 * refcount specifically for this case.
> > +	 *
> > +	 * In particular, unreferenced tail pages result in a KVM "Bad addres=
s"
> > +	 * failure for VMMs that use VirtIO-GPU when guest's Mesa VirGL driver
> > +	 * accesses mapped host TTM buffer that contains tail pages.
> > +	 */
> > +	for (i =3D 1; i < 1 << order; i++)
> > +		page_ref_inc(p + i);
> > +
> >   	return p;
> >   error_free:
> > @@ -133,6 +153,7 @@ static void ttm_pool_free_page(struct ttm_pool *poo=
l, enum ttm_caching caching,
> >   {
> >   	unsigned long attr =3D DMA_ATTR_FORCE_CONTIGUOUS;
> >   	struct ttm_pool_dma *dma;
> > +	unsigned int i;
> >   	void *vaddr;
> >   #ifdef CONFIG_X86
> > @@ -142,6 +163,8 @@ static void ttm_pool_free_page(struct ttm_pool *poo=
l, enum ttm_caching caching,
> >   	if (caching !=3D ttm_cached && !PageHighMem(p))
> >   		set_pages_wb(p, 1 << order);
> >   #endif
> > +	for (i =3D 1; i < 1 << order; i++)
> > +		page_ref_dec(p + i);
> >   	if (!pool || !pool->use_dma_alloc) {
> >   		__free_pages(p, order);
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
