Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD664C6FA86
	for <virtualization@archiver.kernel.org>; Tue,  6 Sep 2022 20:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AAA560BAF;
	Tue,  6 Sep 2022 20:05:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AAA560BAF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=BIZ0Q/uk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UiDriGqEQaxC; Tue,  6 Sep 2022 20:05:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8371860B61;
	Tue,  6 Sep 2022 20:05:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8371860B61
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58A0BC0033;
	Tue,  6 Sep 2022 20:05:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33201C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 20:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09036404A6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 20:05:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09036404A6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=BIZ0Q/uk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id brDDX846bWgr
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 20:05:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90F4940C1D
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90F4940C1D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 20:05:42 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 m3-20020a05600c3b0300b003a5e0557150so8642527wms.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:to:from
 :date:from:to:cc:subject:date;
 bh=c/UsxweYx46AtL1DrAVsnOTkZkntK4Jt2WwuEBuVBzE=;
 b=BIZ0Q/ukdR5e8iBKd7CK7xTCph8PA4xDeCDAuT0ilInjv6/CXXpk2vswtwj06vQTut
 jSztYj68KfnrEQ1l+jMYYFIp1TaZ9AHjui7bxO2qIXvmXnfIT6zdQzp36XPDWemNsC1E
 yz6w1C0iA2azNn9h4SAmSijOrJiZ0W178kjP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:to:from
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=c/UsxweYx46AtL1DrAVsnOTkZkntK4Jt2WwuEBuVBzE=;
 b=b0N91kLWXMKaziFqUV5QFTZEIlxQwkhlZS5yJGKjPzdEARAeKxwb5U/gP9J+ySwxb7
 GsYu06BFmh56/YPULckMbc7JoF1S7/i38P1WtbGK2HvDXYwwIKhBZ6lsNRzYGzmKQEGX
 FTGR6CA6hS+hF6SrY0qNlxQSIMGit7JpBLReyKKwaCaa5ZUzBRe9xhXWIR91qJB5n3yg
 UBNyrpTEd64EAmvx3aY1JM/Ryq+w4hooJHuBugOkNUnvACG05TSdm42sTKTF5TyLSyaC
 DB0x3zOFbqhxb4DmnZnOCg9p2H+yK9/LH6hrHvq1qgfClkYnO9zvWX8hR9w01qHgtmig
 364w==
X-Gm-Message-State: ACgBeo15BQFfiM8TK4NxWrt/8jwgv9ymjz0fhYLaSXl/aG7C2zHoLuPB
 L+d9H7OLAhdqyk5cWoEyeOsHAA==
X-Google-Smtp-Source: AA6agR52xlQCRWj/b3iUB8MkVLnvM+veWz5+Ya5VF/kMkQLeItZ5yTKo+e9fQ+u56AttgY9ZLonVMQ==
X-Received: by 2002:a05:600c:19cb:b0:3a8:4622:ad3d with SMTP id
 u11-20020a05600c19cb00b003a84622ad3dmr14508871wmq.37.1662494740716; 
 Tue, 06 Sep 2022 13:05:40 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c378c00b003a5f4fccd4asm21521437wmr.35.2022.09.06.13.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Sep 2022 13:05:40 -0700 (PDT)
Date: Tue, 6 Sep 2022 22:05:38 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 Trigger Huang <Trigger.Huang@gmail.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, kvm@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v1] drm/ttm: Refcount allocated tail pages
Message-ID: <YxeoEr6xAtlZ+IrU@phenom.ffwll.local>
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
 <YxenK8xZHC6Q4Eu4@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxenK8xZHC6Q4Eu4@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
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

On Tue, Sep 06, 2022 at 10:01:47PM +0200, Daniel Vetter wrote:
> On Mon, Aug 15, 2022 at 12:05:19PM +0200, Christian K=F6nig wrote:
> > Am 15.08.22 um 11:54 schrieb Dmitry Osipenko:
> > > Higher order pages allocated using alloc_pages() aren't refcounted an=
d they
> > > need to be refcounted, otherwise it's impossible to map them by KVM. =
This
> > > patch sets the refcount of the tail pages and fixes the KVM memory ma=
pping
> > > faults.
> > > =

> > > Without this change guest virgl driver can't map host buffers into gu=
est
> > > and can't provide OpenGL 4.5 profile support to the guest. The host
> > > mappings are also needed for enabling the Venus driver using host GPU
> > > drivers that are utilizing TTM.
> > > =

> > > Based on a patch proposed by Trigger Huang.
> > =

> > Well I can't count how often I have repeated this: This is an absolutely
> > clear NAK!
> > =

> > TTM pages are not reference counted in the first place and because of t=
his
> > giving them to virgl is illegal.
> > =

> > Please immediately stop this completely broken approach. We have discus=
sed
> > this multiple times now.
> =

> Yeah we need to get this stuff closed for real by tagging them all with
> VM_IO or VM_PFNMAP asap.

For a bit more context: Anything mapping a bo should be VM_SPECIAL. And I
think we should add the checks to the gem and dma-buf mmap functions to
validate for that, and fix all the fallout.

Otherwise this dragon keeps resurrecting ...

VM_SPECIAL _will_ block get_user_pages, which will block everyone from
even trying to refcount this stuff.

Minimally we need to fix this for all ttm drivers, and it sounds like
that's still not yet the case :-( Iirc last time around some funky amdkfd
userspace was the hold-up because regressions?
-Daniel

> =

> It seems ot be a recurring amount of fun that people try to mmap dma-buf
> and then call get_user_pages on them.
> =

> Which just doesn't work. I guess this is also why Rob Clark send out that
> dma-buf patch to expos mapping information (i.e. wc vs wb vs uncached).
> =

> There seems to be some serious bonghits going on :-/
> -Daniel
> =

> > =

> > Regards,
> > Christian.
> > =

> > > =

> > > Cc: stable@vger.kernel.org
> > > Cc: Trigger Huang <Trigger.Huang@gmail.com>
> > > Link: https://www.collabora.com/news-and-blog/blog/2021/11/26/venus-o=
n-qemu-enabling-new-virtual-vulkan-driver/#qcom1343
> > > Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # AMDGPU (=
Qemu and crosvm)
> > > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > ---
> > >   drivers/gpu/drm/ttm/ttm_pool.c | 25 ++++++++++++++++++++++++-
> > >   1 file changed, 24 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm=
_pool.c
> > > index 21b61631f73a..11e92bb149c9 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > @@ -81,6 +81,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_=
pool *pool, gfp_t gfp_flags,
> > >   	unsigned long attr =3D DMA_ATTR_FORCE_CONTIGUOUS;
> > >   	struct ttm_pool_dma *dma;
> > >   	struct page *p;
> > > +	unsigned int i;
> > >   	void *vaddr;
> > >   	/* Don't set the __GFP_COMP flag for higher order allocations.
> > > @@ -93,8 +94,10 @@ static struct page *ttm_pool_alloc_page(struct ttm=
_pool *pool, gfp_t gfp_flags,
> > >   	if (!pool->use_dma_alloc) {
> > >   		p =3D alloc_pages(gfp_flags, order);
> > > -		if (p)
> > > +		if (p) {
> > >   			p->private =3D order;
> > > +			goto ref_tail_pages;
> > > +		}
> > >   		return p;
> > >   	}
> > > @@ -120,6 +123,23 @@ static struct page *ttm_pool_alloc_page(struct t=
tm_pool *pool, gfp_t gfp_flags,
> > >   	dma->vaddr =3D (unsigned long)vaddr | order;
> > >   	p->private =3D (unsigned long)dma;
> > > +
> > > +ref_tail_pages:
> > > +	/*
> > > +	 * KVM requires mapped tail pages to be refcounted because put_page=
()
> > > +	 * is invoked on them in the end of the page fault handling, and th=
us,
> > > +	 * tail pages need to be protected from the premature releasing.
> > > +	 * In fact, KVM page fault handler refuses to map tail pages to gue=
st
> > > +	 * if they aren't refcounted because hva_to_pfn_remapped() checks t=
he
> > > +	 * refcount specifically for this case.
> > > +	 *
> > > +	 * In particular, unreferenced tail pages result in a KVM "Bad addr=
ess"
> > > +	 * failure for VMMs that use VirtIO-GPU when guest's Mesa VirGL dri=
ver
> > > +	 * accesses mapped host TTM buffer that contains tail pages.
> > > +	 */
> > > +	for (i =3D 1; i < 1 << order; i++)
> > > +		page_ref_inc(p + i);
> > > +
> > >   	return p;
> > >   error_free:
> > > @@ -133,6 +153,7 @@ static void ttm_pool_free_page(struct ttm_pool *p=
ool, enum ttm_caching caching,
> > >   {
> > >   	unsigned long attr =3D DMA_ATTR_FORCE_CONTIGUOUS;
> > >   	struct ttm_pool_dma *dma;
> > > +	unsigned int i;
> > >   	void *vaddr;
> > >   #ifdef CONFIG_X86
> > > @@ -142,6 +163,8 @@ static void ttm_pool_free_page(struct ttm_pool *p=
ool, enum ttm_caching caching,
> > >   	if (caching !=3D ttm_cached && !PageHighMem(p))
> > >   		set_pages_wb(p, 1 << order);
> > >   #endif
> > > +	for (i =3D 1; i < 1 << order; i++)
> > > +		page_ref_dec(p + i);
> > >   	if (!pool || !pool->use_dma_alloc) {
> > >   		__free_pages(p, order);
> > =

> =

> -- =

> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
