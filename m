Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CDC433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 08:52:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D2E64DD3
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 08:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D2E64DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 942646F522;
	Mon, 22 Feb 2021 08:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aZrQouf1qJfe; Mon, 22 Feb 2021 08:52:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83FC660590;
	Mon, 22 Feb 2021 08:52:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60FDBC000B;
	Mon, 22 Feb 2021 08:52:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3387C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CE14D848C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5p7c7VP-gxLX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:52:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 946D18462E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:52:39 +0000 (UTC)
IronPort-SDR: T3fFj3mBcfHTv11qSEBOoJQt6MyvOrz8DrR3uVU5iDLn1RPKjXBU6eSdRS0MFFxemwl1N/PViG
 D9aXS70dOmWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="269311161"
X-IronPort-AV: E=Sophos;i="5.81,196,1610438400"; d="scan'208";a="269311161"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 00:52:38 -0800
IronPort-SDR: 0twkZkBUwsao/I/fnAmgvSnMGMYP0oORkdCThigG63zVCwlMhUsz3n8Znp4NAPKkeSWhrtpPYb
 yDc+GImtn6+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,196,1610438400"; d="scan'208";a="366085233"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga006.jf.intel.com with ESMTP; 22 Feb 2021 00:52:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Feb 2021 00:52:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Feb 2021 00:52:37 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2106.002;
 Mon, 22 Feb 2021 00:52:37 -0800
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Thread-Topic: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Thread-Index: AQHW+gCTpvRVWdGfdEuO7KEMCe95EKpKQvKAgAQvVwCAABxAAIAAXFfggAEm5oCAAH4bcIABHRyAgAJ/T4CAAMKwAIAPAfWQ
Date: Mon, 22 Feb 2021 08:52:37 +0000
Message-ID: <ace6db071cdf4cb89c4155006b19792d@intel.com>
References: <20210203073517.1908882-1-vivek.kasireddy@intel.com>
 <20210203073517.1908882-3-vivek.kasireddy@intel.com>
 <YB1sRx1GrT8rATEg@phenom.ffwll.local>
 <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
 <YCEGrrT0/eqqz/ok@phenom.ffwll.local>
 <8ba4ad64be3546bda9a2ed2129bf98e4@intel.com>
 <20210209084453.5oqepy7zdwtxgrpu@sirius.home.kraxel.org>
 <2ef01dc941684a15a4f30e6239ae42df@intel.com>
 <20210210091641.ahjtgcdalw7viuei@sirius.home.kraxel.org>
 <bad576177eb24085a73570e8ad03d2cc@intel.com>
 <20210212110140.gdpu7kapnr7ovdcn@sirius.home.kraxel.org>
In-Reply-To: <20210212110140.gdpu7kapnr7ovdcn@sirius.home.kraxel.org>
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
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Vetter, Daniel" <daniel.vetter@intel.com>,
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

Hi Gerd,

> 
> On Fri, Feb 12, 2021 at 08:15:12AM +0000, Kasireddy, Vivek wrote:
> > Hi Gerd,
> > [Kasireddy, Vivek] Just to confirm my understanding of what you are
> > suggesting, are you saying that we need to either have Weston allocate
> > scanout buffers (GBM surface/BO) using virtio-gpu and render into them
> > using i915; or have virtio-gpu allocate pages and export a dma-buf and
> > have Weston create a GBM BO by calling gbm_bo_import(fd) and render into the BO
> using i915?
> 
> Not sure what the difference between the former and the latter is.
[Kasireddy, Vivek] Oh, what I meant is whether you were suggesting that we 
create a GBM device and create a GBM surface and BOs using this device or
just create a raw/dumb GEM object and create a GBM BO by importing it. As
we just discovered, the former means we have to initialize virgl which complicates
things so we went with the latter.

> 
> > [Kasireddy, Vivek] We are only interested in Qemu UI at the moment but
> > if we were to use virtio-gpu, we are going to need to add one more vq
> > and support for managing buffers, events, etc.
> 
> Should be easy and it should not need any virtio-gpu driver changes.
[Kasireddy, Vivek] Vdmabuf v4, that implements your suggestion -- to have
Vdmabuf allocate pages --  is posted here:
https://lists.freedesktop.org/archives/dri-devel/2021-February/297841.html
and tested it with Weston Headless and Qemu:
https://gitlab.freedesktop.org/Vivek/weston/-/blob/vdmabuf/libweston/backend-headless/headless.c#L522
https://lists.nongnu.org/archive/html/qemu-devel/2021-02/msg02976.html

Having said that, after discussing with Daniel Vetter, we are now switching our
focus to virtio-gpu to compare and contrast both solutions. 

> 
> You can use virtio-gpu like a dumb scanout device.  Create a dumb bo, create a
> framebuffer for the bo, map the framebuffer to the crtc.
> 
> Then export the bo, import into i915, use it as render target.  When rendering is done flush
> (DRM_IOCTL_MODE_DIRTYFB).  Alternatively allocate multiple bo's + framebuffers
> and pageflip.
[Kasireddy, Vivek] Since we are testing with Weston, we are looking at pageflips (4 color
buffers). And, this part so far seems to work where virtio-gpu is used for kms (max_outputs=1)
and Iris/i915 is used for rendering. We are currently glueing virtio-gpu and i915 in Weston but
eventually the plan is to glue them (virgl/virtio-gpu and Iris) in Mesa if possible using KMSRO
(KMS render only) to avoid having to change Weston or X or other user-space components.

> 
> Pretty standard workflow for cases where rendering and scanout are handled by different
> devices.  As far I know not uncommon in the arm world.
> 
> Right now this will involve a memcpy() for any display update because qemu is a bit
> behind on supporting recent virtio-gpu features.
[Kasireddy, Vivek] IIUC, I think you are referring to creating the Pixman image in set_scanout.
What additional features need to be implemented or what is your recommendation in terms of
what needs to be done to turn the memcpy() into a dma-buf? Also, how should we ensure that
access to the guest fb/dmabuf is synchronized to ensure that the Guest and the Host do not access
the backing storage of the dmabuf at the same time?

Thanks,
Vivek

> 
> take care,
>   Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
