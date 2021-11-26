Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A96C433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 02:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED38E403E9;
	Fri, 26 Nov 2021 02:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qqj83wXB40pw; Fri, 26 Nov 2021 02:16:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9B29B4034C;
	Fri, 26 Nov 2021 02:15:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7ABBBC001C;
	Fri, 26 Nov 2021 02:15:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76817C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54DBA40106
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:15:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ReXQ_J8oHdp4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:15:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61C9340012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:15:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235533375"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="235533375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2021 18:15:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="650863628"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2021 18:15:53 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 18:15:50 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 26 Nov 2021 10:15:48 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Fri, 26 Nov 2021 10:15:48 +0800
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: RE: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Topic: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Index: AQHX4daqV2Omz/OJfUqBSDdTk17B0qwT+K9Q//+PVgCAAXxRUA==
Date: Fri, 26 Nov 2021 02:15:48 +0000
Message-ID: <97be1440032248a29b5eb75619f8ac4d@intel.com>
References: <20211125071554.16969-1-wei.w.wang@intel.com>
 <7992566c682b46dc9ec2502e44a2fb04@intel.com>
 <20211125104046.wxupkn6uogvohioi@steredhat>
In-Reply-To: <20211125104046.wxupkn6uogvohioi@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.239.127.36]
MIME-Version: 1.0
Cc: "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "asias@redhat.com" <asias@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thursday, November 25, 2021 6:41 PM, Stefano Garzarella wrote:
> On Thu, Nov 25, 2021 at 09:27:40AM +0000, Wang, Wei W wrote:
> >On Thursday, November 25, 2021 3:16 PM, Wang, Wei W wrote:
> >> -	/* Update CID in case it has changed after a transport reset event */
> >> -	vsk->local_addr.svm_cid = dst.svm_cid;
> >> -
> >>  	if (space_available)
> >>  		sk->sk_write_space(sk);
> >>
> >
> >Not sure if anybody knows how this affects the transport reset.
> 
> I believe the primary use case is when a guest is migrated.
> 
> After the migration, the transport gets a reset event from the hypervisor and
> all connected sockets are closed. The ones in listen remain open though.
> 
> Also the guest's CID may have changed after migration. So if an application has
> open listening sockets, bound to the old CID, this should ensure that the socket
> continues to be usable.

OK, thanks for sharing the background.

> 
> The patch would then change this behavior.
> 
> So maybe to avoid problems, we could update the CID only if it is different
> from VMADDR_CID_ANY:
> 
> 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> 		vsk->local_addr.svm_cid = dst.svm_cid;
> 
> 
> When this code was written, a guest only supported a single transport, so it
> could only have one CID assigned, so that wasn't a problem.
> For that reason I'll add this Fixes tag:
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")

Sounds good to me.

Thanks,
Wei
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
