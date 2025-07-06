Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC8212F98;
	Sun,  6 Jul 2025 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751803126; cv=none; b=QxJUQm4JDNZZHVBqT+0Tn3sHLHkYz8jEEhEXNtylvfZ7q98grxVdSe+zsdhLJmx7hWqKDoQQMhZ9GYTcWMDGpN50qF7iknmwY/L/GWAqfhQcuTWz41HCqP8VGkFiMq9Q1Y2b6X2uqsL5adA4znhLiRMRj32Hh43unPbE9xWERCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751803126; c=relaxed/simple;
	bh=1OIA8CfMZJSrYoOdycxC5OZvTCoK8Dtc65mqmi2WNEs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U8OJuNFCIJ1OW+5fTUc7IW1uUwnAwuWbk18KDoiqDIYFt3AJ8VgInylmZmk+Jbb9xm8cA0OacuPbCmQGXkOX4N4onF2jSRAcBlQYwJupPbf/n3Tx2id93IzKYXttbNKZx8b0Ho1/soA78a4efNwMFekCS0x1MDyYiZeAl5uxVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHaErVbI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHaErVbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD3CC4CEED;
	Sun,  6 Jul 2025 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751803125;
	bh=1OIA8CfMZJSrYoOdycxC5OZvTCoK8Dtc65mqmi2WNEs=;
	h=Subject:To:Cc:From:Date:From;
	b=hHaErVbINzzwEB8ikKwgdIBL7VDw6HVjChT0aiWDBhsbI+y5eilBzjQMbdK9Env0g
	 hEt09R8BHkr8aagwejtgVMvdiBq/reuMUQo/608B0kzP49acgmFOZKGSYsrrAPWSiF
	 HKXEDPsb9Bj1YDX70KWcDGUnctvdVCBT9P7o88Wg=
Subject: Patch "vsock/vmci: Clear the vmci transport packet properly when initializing it" has been added to the 6.15-stable tree
To: bryan-bt.tan@broadcom.com,davem@davemloft.net,edumazet@google.com,gregkh@linuxfoundation.org,harshavardhana.sa@broadcom.com,horms@kernel.org,kuba@kernel.org,pabeni@redhat.com,sgarzare@redhat.com,stable@kernel.org,virtualization@lists.linux.dev,vishnu.dasa@broadcom.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:55:19 +0200
Message-ID: <2025070619-audibly-renovator-cf4f@gregkh>
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

to the 6.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     vsock-vmci-clear-the-vmci-transport-packet-properly-when-initializing-it.patch
and it can be found in the queue-6.15 subdirectory.

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

queue-6.15/vsock-vmci-clear-the-vmci-transport-packet-properly-when-initializing-it.patch
