Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D7DC433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 08:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFD7280D97;
	Thu, 25 Nov 2021 08:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fXDVbaKjP6LQ; Thu, 25 Nov 2021 08:30:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95F8080D7A;
	Thu, 25 Nov 2021 08:30:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58FF9C001C;
	Thu, 25 Nov 2021 08:30:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01347C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5613403E1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:30:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g8onRrhvvBAP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:30:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48975403B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:30:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="232966200"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; d="scan'208";a="232966200"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2021 00:30:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; d="scan'208";a="457781077"
Received: from devel-wwang.sh.intel.com ([10.239.48.106])
 by orsmga006.jf.intel.com with ESMTP; 25 Nov 2021 00:30:07 -0800
From: Wei Wang <wei.w.wang@intel.com>
To: mst@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 davem@davemloft.net, asias@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio/vsock: fix the transport to work with VMADDR_CID_ANY
Date: Thu, 25 Nov 2021 02:15:54 -0500
Message-Id: <20211125071554.16969-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
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

The VMADDR_CID_ANY flag used by a socket means that the socket isn't bound
to any specific CID. For example, a host vsock server may want to be bound
with VMADDR_CID_ANY, so that a guest vsock client can connect to the host
server with CID=VMADDR_CID_HOST (i.e. 2), and meanwhile, a host vsock
client can connect to the same local server with CID=VMADDR_CID_LOCAL
(i.e. 1).

The current implementation sets the destination socket's svm_cid to a
fixed CID value after the first client's connection, which isn't an
expected operation. For example, if the guest client first connects to the
host server, the server's svm_cid gets set to VMADDR_CID_HOST, then other
host clients won't be able to connect to the server anymore.

Reproduce steps:
1. Run the host server:
   socat VSOCK-LISTEN:1234,fork -
2. Run a guest client to connect to the host server:
   socat - VSOCK-CONNECT:2:1234
3. Run a host client to connect to the host server:
   socat - VSOCK-CONNECT:1:1234

Without this patch, step 3. above fails to connect, and socat complains
"socat[1720] E connect(5, AF=40 cid:1 port:1234, 16): Connection
reset by peer".
With this patch, the above works well.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 net/vmw_vsock/virtio_transport_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 59ee1be5a6dd..5c60fae10569 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1298,9 +1298,6 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	space_available = virtio_transport_space_update(sk, pkt);
 
-	/* Update CID in case it has changed after a transport reset event */
-	vsk->local_addr.svm_cid = dst.svm_cid;
-
 	if (space_available)
 		sk->sk_write_space(sk);
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
