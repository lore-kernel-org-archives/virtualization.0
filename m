Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23441C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 00:25:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADAD64DED
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 00:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADAD64DED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E411870FA;
	Tue,  9 Feb 2021 00:25:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JmrFMbb9QGmb; Tue,  9 Feb 2021 00:25:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0829870E8;
	Tue,  9 Feb 2021 00:25:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA574C0891;
	Tue,  9 Feb 2021 00:25:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6F75C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 00:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 903FD86964
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 00:25:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O8TjRpSYHPUo
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 00:25:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BF102868E3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 00:25:08 +0000 (UTC)
IronPort-SDR: RfGPSvDmMCNcYbRiw00CrUZOlMzDb4/arrd+4u0Gxa42tICOlwBm8jtEMi5VKr1yFYorO6szwM
 j1NWtv6HxJQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181869277"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="181869277"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 16:25:08 -0800
IronPort-SDR: 8cXSzg6B06Zwof+mHWXy6smKkPSQ+JKRoAEUvaZZxmOIT96pmjvWFFeEffAGf1gRiT1gIId+KE
 4eXyAgtKGpJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="585866831"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga005.fm.intel.com with ESMTP; 08 Feb 2021 16:25:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 16:25:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 16:25:06 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2106.002;
 Mon, 8 Feb 2021 16:25:06 -0800
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Thread-Topic: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Thread-Index: AQHW+gCTpvRVWdGfdEuO7KEMCe95EKpKQvKAgAQvVwCAABxAAIAAXFfg
Date: Tue, 9 Feb 2021 00:25:06 +0000
Message-ID: <8ba4ad64be3546bda9a2ed2129bf98e4@intel.com>
References: <20210203073517.1908882-1-vivek.kasireddy@intel.com>
 <20210203073517.1908882-3-vivek.kasireddy@intel.com>
 <YB1sRx1GrT8rATEg@phenom.ffwll.local>
 <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
 <YCEGrrT0/eqqz/ok@phenom.ffwll.local>
In-Reply-To: <YCEGrrT0/eqqz/ok@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.22.254.132]
MIME-Version: 1.0
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "Vetter, 
 Daniel" <daniel.vetter@intel.com>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Gerd, Daniel,

> -----Original Message-----
> From: Daniel Vetter <daniel@ffwll.ch>
> Sent: Monday, February 08, 2021 1:39 AM
> To: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>; Kasireddy, Vivek <vivek.kasireddy@intel.com>;
> virtualization@lists.linux-foundation.org; dri-devel@lists.freedesktop.org; Vetter, Daniel
> <daniel.vetter@intel.com>; daniel.vetter@ffwll.ch; Kim, Dongwon
> <dongwon.kim@intel.com>; sumit.semwal@linaro.org; christian.koenig@amd.com;
> linux-media@vger.kernel.org
> Subject: Re: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
> 
> On Mon, Feb 08, 2021 at 08:57:48AM +0100, Gerd Hoffmann wrote:
> >   Hi,
> >
> > > > +/* extract pages referenced by sgt */ static struct page
> > > > +**extr_pgs(struct sg_table *sgt, int *nents, int *last_len)
> > >
> > > Nack, this doesn't work on dma-buf. And it'll blow up at runtime
> > > when you enable the very recently merged CONFIG_DMABUF_DEBUG (would
> > > be good to test with that, just to make sure).
[Kasireddy, Vivek] Although, I have not tested it yet but it looks like this will
throw a wrench in our solution as we use sg_next to iterate over all the struct page *
and get their PFNs. I wonder if there is any other clean way to get the PFNs of all 
the pages associated with a dmabuf.

> >
> > > Aside from this, for virtio/kvm use-cases we've already merged the
> > > udmabuf driver. Does this not work for your usecase?
> >
> > udmabuf can be used on the host side to make a collection of guest
> > pages available as host dmabuf.  It's part of the puzzle, but not a
> > complete solution.
> >
> > As I understand it the intended workflow is this:
> >
> >   (1) guest gpu driver exports some object as dma-buf
> >   (2) dma-buf is imported into this new driver.
> >   (3) driver sends the pages to the host.
> >   (4) hypervisor uses udmabuf to create a host dma-buf.
> >   (5) host dma-buf is passed on.
> >
> > And step (3) is the problematic one as this will not work in case the
> > dma-buf doesn't live in guest ram but in -- for example -- gpu device
> > memory.
> 
> Yup, vram or similar special ram is the reason why an importer can't look at the pages
> behind a dma-buf sg table.
[Kasireddy, Vivek] To exclude such cases, would it not be OK to limit the scope 
of this solution (Vdmabuf) to make it clear that the dma-buf has to live in Guest RAM?
Or, are there any ways to pin the dma-buf pages in Guest RAM to make this
solution work?

> 
> > Reversing the driver roles in the guest (virtio driver allocates pages
> > and exports the dma-buf to the guest gpu driver) should work fine.
> 
> Yup, this needs to flow the other way round than in these patches.
[Kasireddy, Vivek] That might work but I am afraid it means making invasive changes
to the Guest GPU driver (i915 in our case) which we are trying to avoid to
keep this solution more generic.

> 
> > Which btw is something you can do today with virtio-gpu.
> > Maybe it makes sense to have the option to run virtio-gpu in
> > render-only mode for that use case.
> 
> Yeah that sounds like a useful addition.
> 
> Also, the same flow should work for real gpus passed through as pci devices. What we
> need is some way to surface the dma-buf on the guest side, which I think doesn't exist yet
> stand-alone. But this role could be fulfilled by virtio-gpu in render-only mode I think. And
> (assuming I've understood the recent discussions around virtio dma-buf sharing using
> virtio ids) this would give you some neat zero-copy tricks for free if you share multiple
> devices.
> 
> Also if you really want seamless buffer sharing between devices that are passed to the
> guest and devices on the host side (like displays I guess?
> or maybe video encode if this is for cloug gaming?), then using virtio-gpu in render mode
> should also allow you to pass the dma_fence back&forth.
> Which we'll need too, not just the dma-buf.
> 
> So at a first guess I'd say "render-only virtio-gpu mode" sounds like something rather
> useful. But I might be totally off here.
[Kasireddy, Vivek] Let me present more details about the use-case we are trying to solve;
Sorry for the crude graphic below:

Guest:						Host:
+-----------+					+----------------+
|   Weston  |					|    Qemu UI	|
|(Headless)|					|		|
+-----------+					+-^--------------+
         |  (1. Export prime fd	  (3.Share UUID |	       |  (4. Qemu calls Import using this UUID and a gets a new Dmabuf
         |   of scanout buffer)	     with Qemu)   |	       |   fd that is used with EGL_LINUX_DMA_BUF_EXT)
+-----v-------------+				+------------v-----+
|Virtio-Vdmabuf  |------------------------------->|Vhost-Vdmabuf|
|                            | (2.Generate & share UUID|	                |
+--------------------+ and PFNs for this buffer) +------------------+

Here is a link to the Weston Headless backend that we tested:
https://github.com/vivekkreddy/Intel-Distribution-of-Weston/blob/vdmabuf/libweston/backend-headless/headless.c#L287
And, here is the link to the Qemu part:
https://lists.nongnu.org/archive/html/qemu-devel/2021-02/msg02976.html

IIUC, Virtio GPU is used to present a virtual GPU to the Guest and all the rendering 
commands are captured and forwarded to the Host GPU via Virtio. However, in our
use-case, we are passthrough'ing a real GPU (claimed by i915 running in the Guest)
that is Headless; hence, we need to use Weston with the headless backend. The 
rendering in the Guest is accomplished via the unmodified native stack that includes 
Iris and i915. Therefore, it would not be efficient to use virtio-gpu for rendering or
for any other purpose in the Guest given that we could use the native stack which
is definitely faster. 

We really want to make this solution GPU driver (Host and Guest) agnostic and for
that reason it would need to rely on Dmabuf interfaces/APIs and preferrably avoid
making modifications to the native DRM drivers.

Thanks,
Vivek

> 
> Cheers, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
