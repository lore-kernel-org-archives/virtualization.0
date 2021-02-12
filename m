Return-Path: <SRS0=ygFP=HO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FA8C433E0
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 08:36:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4553564DEA
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 08:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4553564DEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3C816F486
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 08:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xzejGcygxrbg for <virtualization@archiver.kernel.org>;
	Fri, 12 Feb 2021 08:36:55 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 531E96F524; Fri, 12 Feb 2021 08:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72DF06E56C;
	Fri, 12 Feb 2021 08:36:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49537C0174;
	Fri, 12 Feb 2021 08:36:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EB5EC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 08:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EC106E56C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 08:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PmT6LQiYnUON
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 08:36:50 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id AD8EF6F486; Fri, 12 Feb 2021 08:36:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 369E46E56C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 08:36:49 +0000 (UTC)
IronPort-SDR: izDVf4CfdDe27Nn+Wot046Prjkq390vubjrup9A/qdjUBhkt/UOWcUEyKDB6aG+yjk6zNde61a
 +lIfsNxIGXMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="243872967"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; d="scan'208";a="243872967"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2021 00:36:46 -0800
IronPort-SDR: QUomUn6GF7IRl2CrcExR/qIj5JqxA0On8b8Z5x0sj+79oToDKfk7epDr3YDf0XgUktQ4MaLR1K
 mjToj06XNF1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; d="scan'208";a="490835235"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2021 00:36:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Feb 2021 00:36:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Feb 2021 00:36:44 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2106.002;
 Fri, 12 Feb 2021 00:36:44 -0800
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
Subject: RE: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Thread-Topic: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Thread-Index: AQHW+gCTpvRVWdGfdEuO7KEMCe95EKpKQvKAgAQvVwCAABxAAIAAXFfggAEm5oCAAH4bcIABCTWAgAKhj6A=
Date: Fri, 12 Feb 2021 08:36:44 +0000
Message-ID: <fd23d4d08ea84ca3b8a7610a8fb866d5@intel.com>
References: <20210203073517.1908882-1-vivek.kasireddy@intel.com>
 <20210203073517.1908882-3-vivek.kasireddy@intel.com>
 <YB1sRx1GrT8rATEg@phenom.ffwll.local>
 <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
 <YCEGrrT0/eqqz/ok@phenom.ffwll.local>
 <8ba4ad64be3546bda9a2ed2129bf98e4@intel.com>
 <20210209084453.5oqepy7zdwtxgrpu@sirius.home.kraxel.org>
 <2ef01dc941684a15a4f30e6239ae42df@intel.com>
 <8ac10b1d-3d64-4e39-42e6-6c65b61f0794@amd.com>
In-Reply-To: <8ac10b1d-3d64-4e39-42e6-6c65b61f0794@amd.com>
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

Hi Christian,

> 
> Hi Vivek,
> 
> > [Kasireddy, Vivek] What if I do mmap() on the fd followed by mlock()
> > or mmap() followed by get_user_pages()? If it still fails, would
> > ioremapping the device memory and poking at the backing storage be an
> > option? Or, if I bind the passthrough'd GPU device to vfio-pci and tap
> > into the memory region associated with the device memory, can it be made to work?
> 
> get_user_pages() is not allowed on mmaped DMA-bufs in the first place.
> 
> Daniel is currently adding code to make sure that this is never ever used.
> 
> > And, I noticed that for PFNs that do not have valid struct page
> > associated with it, KVM does a memremap() to access/map them. Is this an option?
> 
> No, even for system memory which has a valid struct page touching it when it is part of a
> DMA-buf is illegal since the reference count and mapping fields in struct page might be
> used for something different.
> 
> Keep in mind that struct page is a heavily overloaded structure for different use cases. You
> can't just use it for a different use case than what the owner of the page has intended it.
[Kasireddy, Vivek] What is your recommended/acceptable way for doing what I am trying to 
do?

Thanks,
Vivek

> 
> Regards,
> Christian.
> 
> >
> >
> > Thanks,
> > Vivek
> >> take care,
> >>    Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
