Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F1DC433EF
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 01:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6506E80CE7;
	Tue, 30 Nov 2021 01:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ppxyWopu8Ja; Tue, 30 Nov 2021 01:34:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F2BD380CE3;
	Tue, 30 Nov 2021 01:34:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C44C6C0012;
	Tue, 30 Nov 2021 01:34:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE01FC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 01:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8FEF40163
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 01:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ENWbNn8_R-a9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 01:34:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA7E840422
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 01:34:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="322355866"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; d="scan'208";a="322355866"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2021 17:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; d="scan'208";a="676605092"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP; 29 Nov 2021 17:34:23 -0800
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 17:34:22 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 09:34:20 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2308.020;
 Tue, 30 Nov 2021 09:34:20 +0800
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: RE: [PATCH v2] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Topic: [PATCH v2] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Index: AQHX4m3Zj4b3Qhf8bE+JSA6gud1FyqwU+0CAgAZQX3A=
Date: Tue, 30 Nov 2021 01:34:20 +0000
Message-ID: <2853d4c373aa4cf0961a256622014eed@intel.com>
References: <20211126011823.1760-1-wei.w.wang@intel.com>
 <20211126085341.wiab2frkcbmkg4ca@steredhat>
In-Reply-To: <20211126085341.wiab2frkcbmkg4ca@steredhat>
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
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
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

Hi Michael,

Do you plan to merge this patch through your tree?
If not, I'll resend to have it applied to the net tree.

Thanks,
Wei

On Friday, November 26, 2021 4:54 PM, Stefano Garzarella wrote:
> On Thu, Nov 25, 2021 at 08:18:23PM -0500, Wei Wang wrote:
> >The VMADDR_CID_ANY flag used by a socket means that the socket isn't
> >bound to any specific CID. For example, a host vsock server may want to
> >be bound with VMADDR_CID_ANY, so that a guest vsock client can connect
> >to the host server with CID=VMADDR_CID_HOST (i.e. 2), and meanwhile, a
> >host vsock client can connect to the same local server with
> >CID=VMADDR_CID_LOCAL (i.e. 1).
> >
> >The current implementation sets the destination socket's svm_cid to a
> >fixed CID value after the first client's connection, which isn't an
> >expected operation. For example, if the guest client first connects to
> >the host server, the server's svm_cid gets set to VMADDR_CID_HOST, then
> >other host clients won't be able to connect to the server anymore.
> >
> >Reproduce steps:
> >1. Run the host server:
> >   socat VSOCK-LISTEN:1234,fork -
> >2. Run a guest client to connect to the host server:
> >   socat - VSOCK-CONNECT:2:1234
> >3. Run a host client to connect to the host server:
> >   socat - VSOCK-CONNECT:1:1234
> >
> >Without this patch, step 3. above fails to connect, and socat complains
> >"socat[1720] E connect(5, AF=40 cid:1 port:1234, 16): Connection reset
> >by peer".
> >With this patch, the above works well.
> >
> >Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> >Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Usually fixes for net/vmw_vsock/* are applied through the net tree
> (netdev@vger.kernel.org) that seems not CCed. Please
> use ./scripts/get_maintainer.pl next time.
> 
> Maybe this one can be queued by Michael, let's wait a bit, otherwise please
> resend CCing netdev and using "net" tag.
> 
> Anyway the patch LGTM:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
