Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6620E01E;
	Sun,  6 Jul 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802949; cv=none; b=GqL35oYZXCrlYlKlpBuwBtBA/2OtQ5HN+qzlZY495kMDsl4UL4FBxOCuTBm0HJzjzSWg2IbP5NunVXWWNhHklMH/Lbeytonl+Mt+RSKvI5Bj61f81/YfFJf/buXfJMhVNSyyLnmYYWMUdEkGRRQaMdI7GK/YdkwjMTBmFwS43D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802949; c=relaxed/simple;
	bh=3t34YMXb3m17KloD9NdlNgqjElHhAZOqvwrkbzVUFeA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f3SVnyfnO9hD4PJmInTd+bhWbQeYXBUxB75h0j39N4pYCmhj1DKtMv76kl+JHi6Wbn2vGzxZ+YtbDaDdBalIqQ0q4WH5nWgAgMyrpaBjvziSbWcrRghTtsUQhvMnCSShCFvCRMPVt/xyDHK1zUoBCN4CroPV/6irVW/F4n5tfyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1tJ62ftN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1tJ62ftN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1C7C4CEED;
	Sun,  6 Jul 2025 11:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802948;
	bh=3t34YMXb3m17KloD9NdlNgqjElHhAZOqvwrkbzVUFeA=;
	h=Subject:To:Cc:From:Date:From;
	b=1tJ62ftNsq6pUfsQlw/fIlT03ma4B7kKVLXCfUP7YNDN+242vlSGzZYYtJG0nMiuA
	 gyz3/LCXquprwcTzTLEoLaUrLm+sZj5PheSrJCtubuyT4bAJZAcl8Nra+IbSyjuAwX
	 SM3aZWQT4FcG7HT3lVz2OpaHgyieqlFqC7HX/GcA=
Subject: Patch "vsock/vmci: Clear the vmci transport packet properly when initializing it" has been added to the 6.1-stable tree
To: bryan-bt.tan@broadcom.com,davem@davemloft.net,edumazet@google.com,gregkh@linuxfoundation.org,harshavardhana.sa@broadcom.com,horms@kernel.org,kuba@kernel.org,pabeni@redhat.com,sgarzare@redhat.com,stable@kernel.org,virtualization@lists.linux.dev,vishnu.dasa@broadcom.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:54:51 +0200
Message-ID: <2025070651-vessel-fax-787c@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    vsock/vmci: Clear the vmci transport packet properly when initializing it

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     vsock-vmci-clear-the-vmci-transport-packet-properly-when-initializing-it.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 223e2288f4b8c262a864e2c03964ffac91744cd5 Mon Sep 17 00:00:00 2001
From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
Date: Tue, 1 Jul 2025 14:22:54 +0200
Subject: vsock/vmci: Clear the vmci transport packet properly when initializing it

From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>

commit 223e2288f4b8c262a864e2c03964ffac91744cd5 upstream.

In vmci_transport_packet_init memset the vmci_transport_packet before
populating the fields to avoid any uninitialised data being left in the
structure.

Cc: Bryan Tan <bryan-bt.tan@broadcom.com>
Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>
Cc: Broadcom internal kernel review list
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: stable <stable@kernel.org>
Signed-off-by: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20250701122254.2397440-1-gregkh@linuxfoundation.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/vmci_transport.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -119,6 +119,8 @@ vmci_transport_packet_init(struct vmci_t
 			   u16 proto,
 			   struct vmci_handle handle)
 {
+	memset(pkt, 0, sizeof(*pkt));
+
 	/* We register the stream control handler as an any cid handle so we
 	 * must always send from a source address of VMADDR_CID_ANY
 	 */
@@ -131,8 +133,6 @@ vmci_transport_packet_init(struct vmci_t
 	pkt->type = type;
 	pkt->src_port = src->svm_port;
 	pkt->dst_port = dst->svm_port;
-	memset(&pkt->proto, 0, sizeof(pkt->proto));
-	memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));
 
 	switch (pkt->type) {
 	case VMCI_TRANSPORT_PACKET_TYPE_INVALID:


Patches currently in stable-queue which might be from harshavardhana.sa@broadcom.com are

queue-6.1/vsock-vmci-clear-the-vmci-transport-packet-properly-when-initializing-it.patch
