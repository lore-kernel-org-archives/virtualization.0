Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9600C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 09:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51E87408D7;
	Thu, 25 Nov 2021 09:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTFzPtykdtVp; Thu, 25 Nov 2021 09:27:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06525408CF;
	Thu, 25 Nov 2021 09:27:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0063C0012;
	Thu, 25 Nov 2021 09:27:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB0B4C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 09:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4EC082741
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 09:27:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hh9PBY1BVTDJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 09:27:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8009282735
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 09:27:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="321715479"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; d="scan'208";a="321715479"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2021 01:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; d="scan'208";a="475587501"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga002.jf.intel.com with ESMTP; 25 Nov 2021 01:27:43 -0800
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 01:27:42 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 17:27:40 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Thu, 25 Nov 2021 17:27:40 +0800
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "asias@redhat.com"
 <asias@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Topic: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Index: AQHX4daqV2Omz/OJfUqBSDdTk17B0qwT+K9Q
Date: Thu, 25 Nov 2021 09:27:40 +0000
Message-ID: <7992566c682b46dc9ec2502e44a2fb04@intel.com>
References: <20211125071554.16969-1-wei.w.wang@intel.com>
In-Reply-To: <20211125071554.16969-1-wei.w.wang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.239.127.36]
MIME-Version: 1.0
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

On Thursday, November 25, 2021 3:16 PM, Wang, Wei W wrote:
> -	/* Update CID in case it has changed after a transport reset event */
> -	vsk->local_addr.svm_cid = dst.svm_cid;
> -
>  	if (space_available)
>  		sk->sk_write_space(sk);
> 

Not sure if anybody knows how this affects the transport reset.

Thanks,
Wei
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
