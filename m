Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6772C433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 08:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EBE260FDB;
	Mon, 16 May 2022 08:42:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JpFBjptOZ5Jd; Mon, 16 May 2022 08:42:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20D2760BAE;
	Mon, 16 May 2022 08:42:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7617C0032;
	Mon, 16 May 2022 08:42:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59E31C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34E0E40AF6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fRpcXgMbUdU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:42:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DC2A40396
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652690547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zsjSQ0E4x4apOOovvgvIeCzdF5L3Muj7tY5Ce1u0fFA=;
 b=HiMCBmcefGwx78a3Rgmxr8Jrj342i6wwNlIx8JWF50z4Yj0vNwEWiRy7NfOYaRkKhnqmEC
 sSMw3naw4qT9wFzSGCtKn1Kr8Ln/PGqolRkLRGONrnCclXvq2uxjwHMbtbg0EVQUX0zA4v
 ydE7nT6/Nu1boypEAzjNeWIPmzeiMyg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-hrKwPFoVP6as52qPJiqDgw-1; Mon, 16 May 2022 04:42:20 -0400
X-MC-Unique: hrKwPFoVP6as52qPJiqDgw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A4BF29AB44D;
 Mon, 16 May 2022 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-125.pek2.redhat.com
 [10.72.13.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6111A7C52;
 Mon, 16 May 2022 08:42:16 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: viro@zeniv.linux.org.uk, mst@redhat.com, jasowang@redhat.com,
 kvm@vger.kernel.org
Subject: [PATCH] vhost_net: fix double fget()
Date: Mon, 16 May 2022 16:42:13 +0800
Message-Id: <20220516084213.26854-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, davem@davemloft.net
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

From: Al Viro <viro@zeniv.linux.org.uk>

Here's another piece of code assuming that repeated fget() will yield the
same opened file: in vhost_net_set_backend() we have

        sock = get_socket(fd);
        if (IS_ERR(sock)) {
                r = PTR_ERR(sock);
                goto err_vq;
        }

        /* start polling new socket */
        oldsock = vhost_vq_get_backend(vq);
        if (sock != oldsock) {
...
                vhost_vq_set_backend(vq, sock);
...
                if (index == VHOST_NET_VQ_RX)
                        nvq->rx_ring = get_tap_ptr_ring(fd);

with
static struct socket *get_socket(int fd)
{
        struct socket *sock;

        /* special case to disable backend */
        if (fd == -1)
                return NULL;
        sock = get_raw_socket(fd);
        if (!IS_ERR(sock))
                return sock;
        sock = get_tap_socket(fd);
        if (!IS_ERR(sock))
                return sock;
        return ERR_PTR(-ENOTSOCK);
}
and
static struct ptr_ring *get_tap_ptr_ring(int fd)
{
        struct ptr_ring *ring;
        struct file *file = fget(fd);

        if (!file)
                return NULL;
        ring = tun_get_tx_ring(file);
        if (!IS_ERR(ring))
                goto out;
        ring = tap_get_ptr_ring(file);
        if (!IS_ERR(ring))
                goto out;
        ring = NULL;
out:
        fput(file);
        return ring;
}

Again, there is no promise that fd will resolve to the same thing for
lookups in get_socket() and in get_tap_ptr_ring().  I'm not familiar
enough with the guts of drivers/vhost to tell how easy it is to turn
into attack, but it looks like trouble.  If nothing else, the pointer
returned by tun_get_tx_ring() is not guaranteed to be pinned down by
anything - the reference to sock will _usually_ suffice, but that
doesn't help any if we get a different socket on that second fget().

One possible way to fix it would be the patch below; objections?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 28ef323882fb..0bd7d91de792 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1449,13 +1449,9 @@ static struct socket *get_raw_socket(int fd)
 	return ERR_PTR(r);
 }
 
-static struct ptr_ring *get_tap_ptr_ring(int fd)
+static struct ptr_ring *get_tap_ptr_ring(struct file *file)
 {
 	struct ptr_ring *ring;
-	struct file *file = fget(fd);
-
-	if (!file)
-		return NULL;
 	ring = tun_get_tx_ring(file);
 	if (!IS_ERR(ring))
 		goto out;
@@ -1464,7 +1460,6 @@ static struct ptr_ring *get_tap_ptr_ring(int fd)
 		goto out;
 	ring = NULL;
 out:
-	fput(file);
 	return ring;
 }
 
@@ -1551,8 +1546,12 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		r = vhost_net_enable_vq(n, vq);
 		if (r)
 			goto err_used;
-		if (index == VHOST_NET_VQ_RX)
-			nvq->rx_ring = get_tap_ptr_ring(fd);
+		if (index == VHOST_NET_VQ_RX) {
+			if (sock)
+				nvq->rx_ring = get_tap_ptr_ring(sock->file);
+			else
+				nvq->rx_ring = NULL;
+		}
 
 		oldubufs = nvq->ubufs;
 		nvq->ubufs = ubufs;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
