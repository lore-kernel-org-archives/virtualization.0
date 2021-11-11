Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E589C433EF
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 08:14:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE85C6109D
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 08:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE85C6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A70540450;
	Thu, 11 Nov 2021 08:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 61N1qG9MzZbi; Thu, 11 Nov 2021 08:14:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 089A640404;
	Thu, 11 Nov 2021 08:14:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEAEBC0020;
	Thu, 11 Nov 2021 08:14:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C80EC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 08:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26A1180CED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 08:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VQBtuOEchOis
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 08:14:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D13780CE3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 08:14:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="296311045"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; d="scan'208";a="296311045"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 00:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; d="scan'208";a="583171608"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2021 00:14:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 00:14:15 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 00:14:13 -0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Thu, 11 Nov 2021 16:14:11 +0800
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: RE: [RFC] hypercall-vsock: add a new vsock transport
Thread-Topic: [RFC] hypercall-vsock: add a new vsock transport
Thread-Index: AdfR7PQwhDKKIu84SJaS6/iA/MsV5gD9INQAADxfhIA=
Date: Thu, 11 Nov 2021 08:14:11 +0000
Message-ID: <9901a74b149d4245b0e6c998b5cde7af@intel.com>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110111718.5cvt6vgory3fzqld@steredhat>
In-Reply-To: <20211110111718.5cvt6vgory3fzqld@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.239.127.36]
MIME-Version: 1.0
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kleen, Andi" <andi.kleen@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Andra Paraschiv <andraprs@amazon.com>
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

On Wednesday, November 10, 2021 7:17 PM, Stefano Garzarella wrote:


> Adding Andra and Sergio, because IIRC Firecracker and libkrun emulates
> virtio-vsock with virtio-mmio so the implementation should be simple and also
> not directly tied to a specific VMM.
> 

OK. This would be OK for KVM based guests.
For Hyperv and VMWare based guests, they don't have virtio-mmio support.
If the MigTD (a special guest) we provide is based on virtio-mmio, it would not be usable to them.

Thanks,
Wei

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
