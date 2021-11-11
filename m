Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A8FC433EF
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 07:58:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D4A6115A
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 07:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24D4A6115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB23240500;
	Thu, 11 Nov 2021 07:58:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vTZKEsJxWNHy; Thu, 11 Nov 2021 07:58:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8301D404EC;
	Thu, 11 Nov 2021 07:58:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5175CC001F;
	Thu, 11 Nov 2021 07:58:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03182C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 07:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE77F404EC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 07:58:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfMJEp6_nuNl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 07:58:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBDAC404EB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 07:58:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="230332788"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; d="scan'208";a="230332788"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2021 23:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; d="scan'208";a="501802989"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2021 23:58:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 23:58:33 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 23:58:31 -0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Thu, 11 Nov 2021 15:58:29 +0800
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [RFC] hypercall-vsock: add a new vsock transport
Thread-Topic: [RFC] hypercall-vsock: add a new vsock transport
Thread-Index: AdfR7PQwhDKKIu84SJaS6/iA/MsV5gD8LVgAADoZqGA=
Date: Thu, 11 Nov 2021 07:58:29 +0000
Message-ID: <dcaf10bed215456ab689956275d4b998@intel.com>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110054121-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211110054121-mutt-send-email-mst@kernel.org>
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
 "srutherford@google.com" <srutherford@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "erdemaktas@google.com" <erdemaktas@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kleen, Andi" <andi.kleen@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wednesday, November 10, 2021 6:50 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 10, 2021 at 07:12:36AM +0000, Wang, Wei W wrote:
>
> hypercalls are fundamentally hypervisor dependent though.

Yes, each hypervisor needs to support it.
We could simplify the design and implementation to the minimal, so that each hypervisor can easily support it.
Once every hypervisor has the support, the guest (MigTD) could be a unified version.
(e.g. no need for each hypervisor user to develop their own MigTD using their own vsock transport)

> Assuming you can carve up a hypervisor independent hypercall, using it for
> something as mundane and specific as vsock for TDX seems like a huge overkill.
> For example, virtio could benefit from faster vmexits that hypercalls give you
> for signalling.
> How about a combination of virtio-mmio and hypercalls for fast-path signalling
> then?

We thought about virtio-mmio. There are some barriers:
1) It wasn't originally intended for x86 machines. The only machine type in QEMU
that supports it (to run on x86) is microvm. But "microvm" doesn’t support TDX currently,
and adding this support might need larger effort.
2) It's simpler than virtio-pci, but still more complex than hypercall.
3) Some CSPs don't have virtio support in their software, so this might add too much development effort for them.

This usage doesn’t need high performance, so faster hypercall for signalling isn't required, I think.
(but if hypercall has been verified to be much faster than the current EPT misconfig based notification,
it could be added for the general virtio usages)

> 
> > 2)       It is simpler. It doesn’t rely on any complex bus enumeration
> >
> > (e.g. virtio-pci based vsock device may need the whole implementation of
> PCI).
> >
> 
> Next thing people will try to do is implement a bunch of other device on top of
> it.  virtio used pci simply because everyone implements pci.  And the reason
> for *that* is because implementing a basic pci bus is dead simple, whole of
> pci.c in qemu is <3000 LOC.

This doesn’t include the PCI enumeration in seaBIOS and the PCI driver in the guest though.

Virtio has high performance, I think that's an important reason that more devices are continually added.
For this transport, I couldn’t envision that a bunch of devices would be added. It's a simple PV method.


> 
> >
> > An example usage is the communication between MigTD and host (Page 8
> > at
> >
> > https://static.sched.com/hosted_files/kvmforum2021/ef/
> > TDX%20Live%20Migration_Wei%20Wang.pdf).
> >
> > MigTD communicates to host to assist the migration of the target (user) TD.
> >
> > MigTD is part of the TCB, so its implementation is expected to be as
> > simple as possible
> >
> > (e.g. bare mental implementation without OS, no PCI driver support).
> >
> >
> 
> Try to list drawbacks? For example, passthrough for nested virt isn't possible
> unlike pci, neither are hardware implementations.
> 

Why hypercall wouldn't be possible for nested virt?
L2 hypercall goes to L0 directly and L0 can decide whether to forward the call the L1 (in our case, I think no need as the packet will go out), right?

Its drawbacks are obvious (e.g. low performance). 
In general, I think it could be considered as a complement to virtio.
I think most usages would choose virtio as they don’t worry about the complexity and they purse high performance.
For some special usages that think virtio is too complex to suffice and they want something simpler, they would consider to use this transport。

Thanks,
Wei

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
