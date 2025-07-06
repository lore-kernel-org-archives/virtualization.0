Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B221A9B3D;
	Sun,  6 Jul 2025 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802858; cv=none; b=fZhes2B0gMNAp+iqSanM4P1OF9/LMGRGTSLG22aqFXMl+L8dooA02sDnsJ0OQ8y7+D0UNOwjw+xmczly0SGG7YtDATc0gYFJjdaCWnL0PYQkglcNyGAKm93wNu/XTYqLHsbwuKQKiIEgWnGG0IE37nA3OSShAOborqrKJU76+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802858; c=relaxed/simple;
	bh=/Rk9sfLfT+CrTTGA7nes1n4QUGawwUqe9ECurv5LKRQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=irtnD3PuYmpWjOsUVdQ+PnrnHa3oK84SD182TJBELzjw6U1Ec52iCb3G3iNx6NBjqIYF+Ja4kvJn5/Ej6IK5SGOBzBqiJOr4dbT6zoPi/oLiBykeljrlxEW0KwJltTAOJsYy5TXujb2aMjadaYm9iRXmYuh8VSinEq5/s3/YCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O87PtNPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O87PtNPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66D3C4CEED;
	Sun,  6 Jul 2025 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802858;
	bh=/Rk9sfLfT+CrTTGA7nes1n4QUGawwUqe9ECurv5LKRQ=;
	h=Subject:To:Cc:From:Date:From;
	b=O87PtNPnhNjhSq/tQnciEk6FytUh2O6gvBa6YVshIWa1Z4xokmO8/Rr9S+wVoBYVn
	 4ve/g4bDu8wqKypNdmqdQ1xE+yDZwMSH/dq+/nogjq90PZRtCGttJ7id48RZwCHejD
	 tr2bWUV/AE3Y8+zJNOL5ACCDjc6mfsVXDeiiMjKs=
Subject: Patch "vsock/vmci: Clear the vmci transport packet properly when initializing it" has been added to the 5.4-stable tree
To: bryan-bt.tan@broadcom.com,davem@davemloft.net,edumazet@google.com,gregkh@linuxfoundation.org,harshavardhana.sa@broadcom.com,horms@kernel.org,kuba@kernel.org,pabeni@redhat.com,sgarzare@redhat.com,stable@kernel.org,virtualization@lists.linux.dev,vishnu.dasa@broadcom.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:53:59 +0200
Message-ID: <2025070659-data-finer-380f@gregkh>
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

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     vsock-vmci-clear-the-vmci-transport-packet-properly-when-initializing-it.patch
and it can be found in the queue-5.4 subdirectory.

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
@@ -125,6 +125,8 @@ vmci_transport_packet_init(struct vmci_t
 			   u16 proto,
 			   struct vmci_handle handle)
 {
+	memset(pkt, 0, sizeof(*pkt));
+
 	/* We register the stream control handler as an any cid handle so we
 	 * must always send from a source address of VMADDR_CID_ANY
 	 */
@@ -137,8 +139,6 @@ vmci_transport_packet_init(struct vmci_t
 	pkt->type = type;
 	pkt->src_port = src->svm_port;
 	pkt->dst_port = dst->svm_port;
-	memset(&pkt->proto, 0, sizeof(pkt->proto));
-	memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));
 
 	switch (pkt->type) {
 	case VMCI_TRANSPORT_PACKET_TYPE_INVALID:


Patches currently in stable-queue which might be from harshavardhana.sa@broadcom.com are

queue-5.4/vsock-vmci-clear-the-vmci-transport-packet-properly-when-initializing-it.patch
