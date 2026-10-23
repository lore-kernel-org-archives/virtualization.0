Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755449;
	b=ULCcSKn225wW1Qh+dsD2dr13W7vpI7NuJxLNNHdi8nEZ9xVMExMdWJfKLcyBekbJCTu4
	 oi/eajhwOYMMVTn4BuVSzELSxESbT2wpg6Nmv0Um/ktP469OuGeXWue1Fxr02e5NafAYc
	 5KM1Ld+EdEoyqJfkgQsMqsG4wM2AsaRNJ+uiVS4j0VJqZciINFsw5QkUxhNQ09Sj1Kv9j
	 vPjerWC56vj2H0ruzSoSbtPYJsF6VbEBXvdUmpt9q4FRQkZdKWpzyQ+QbitS7uHukMCWA
	 AOM0UCaBwrbNx5fQodzeMGXQX0woN6TiBh+xtcO7RQEksXztJkOMxmALK3hhZD8AEVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755449;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XLlV9O6j8cojHKstWOoQP9wgp5SmAko7Hyc+l00NrYs=;
	b=kX2dgOnkMOZEHj7treHOFC3/MI4agO11NJ884Y6hbAi7NHPU9+UEEx3LBze4bRiypWJc
	 cgZSQDRnwotqRL7+D1G9meUYJmjNoo2ZR7AYdWHrLOno9mYRcqW1wPs+a10R7Yn+bxXEf
	 RC4TPGMtg0G7hYlM9iy2LDDrETYf9XGtjzmjLVpZ0PFGa3kA287k8hcbS9CAh719d/kvy
	 fVMlVGAG5gOC5KIIoUhEeTVn8Qj3rsAjc3AnSZULa3LgF7B1Wwr1bG61xuejzb9eCJePm
	 5FCY+i8OzQ5v6/R0z6Dbu2Bw+qWEcgSR59rj5sy4YVemS+hYnpP1FDQK+ZFjdmYFHjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=e7BYo4bN;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BE606A31B
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 11:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 388BE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=e7BYo4bN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792755444; bh=XLlV9O6j8cojHKstWOoQP9wgp5SmAko7Hyc+l00NrYs=;
	h=From:To:Cc:Subject:Date;
	b=e7BYo4bNDl1P+pXOJHoF1uMV78YoOV4PWzR1FzMsepUr11xgoerjSPYS5cIrv+fYY
	 C+afxrmr6WmUDlSYwqEsPuXgcAqSDK5dOzB5j/paveUZqXDWW/i2lBjJyKuKAYDUYi
	 iapkjEM1CCIigUD/MxbqTKOgpD93orpVNFVCCwlo=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 9559A08E; Fri, 23 Oct 2026 19:37:21 +0800
X-QQ-mid: xmsmtpt1792755441tkuckw11p
Message-ID: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>
X-QQ-XMAILINFO: OV65e10zTgieRLB/ISjk57I3I/ACNqrV9ETr8cRtQhEGIMkbue3N1uA9CWsDL6
	 gxXXR0JzHir1WmRwzcMYeoRgEc1AD+GsZFoBGNBhy3ych4dOmoviNqNIOHOZqLHDUX1Ve3R54jmb
	 vKqvUcYSFrsIkbH72Xf3tkMFuRVPEOvo0f8aD8XD0fqTfxW5kq2oH/YoH7JbgDm3Iz+7WzwkCfpr
	 VZWNKKpW7GnhRiK4F+wafNQHDHDWn789DmgMXpUwjX4CXTWD/bmIpFi3GcjeJEp1hE5vAX21se6A
	 2xAfnF35bWILeF6x5NMsi6oK+siXcQYq09Ip+JzohXtKXfWRjNaioODjBnPVlhmDgyYtOkApIzKw
	 TdWAGJMBEpCjX9ZF5SQAWbmVe9iQRTh268iFVWej7//Lw5onR3YFv6HuQ3RgQx1yBRPGrXKcSW18
	 cGLWKnFoVeclDhq5G2NeeZGxnU3avoC4Jn4c2zZBccRYAA2zR0Tca4m8bxS1ujA4f1nA4+2VUUCJ
	 MDyWqCMFq8b+VDRt5tNbjTR9IQ0u3oGTjd3RQJgySPW2luu0p3HdQ6cEDvoi83uqrm1+li4YL62z
	 Z336c2uxDhsO9SoZgu9E+Fbmd7IFHXP4YvSPtXchNFwc0+NHcTuT5v4nRqI93lD/G6MV/1Ufhto3
	 5zx2y4W87AuwxKgond+xSTG2DdVF7aflUNYQwlj9mko0wV2ThWFlTzjwANN51Lg5PJqpO4w3VrDs
	 yP49B3lmvZjmFp3uDjjLtni/70fs49q8ZL5ZSCluI06Sn+FID6mNOR5b/eZqYRBHWas3aHbzom4Y
	 ciIQj9rhYLpOX2TmNp75XsiGQUBA2K+5zU/q6RMCiE/YC6iy9fBAYlOlopSaDHphTarudOdBKJbG
	 Xlvteow+vM7V3+5iB5i0mgfPkOEqWd59OkTO5scMV/W9XCR8yJPacIh+9jnNezz/Rtgq7lJk1e6P
	 bMVC6weZNzr3f39D1CdoP0x7DtkUw7UxruNkup0oXxTZm6kTh/JY5uefhAm9vcTFlCo7pvVfUsEJ
	 7bie9zybauGEXBCluj+Tm7aIIUoEbbcfRepWNfUQfJeTeokXpk
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Guikun Yang <yangguikun19@qq.com>
To: Michael S. Tsirkin <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Eugenio Perez <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/net: initialize the whole negotiated RX vnet header
Date: Fri, 23 Oct 2026 19:37:20 +0800
X-OQ-MSGID: <20261023193720.39712-vhost-yangguikun19@qq.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When VHOST_NET_F_VIRTIO_NET_HDR is negotiated, handle_rx() builds the
virtio-net header itself and writes it into the guest buffer.  Since
commit bbca931fce26 ("vhost/net: enable gso over UDP tunnel support.")
vhost_net_set_features() raises vhost_hlen to
sizeof(struct virtio_net_hdr_v1_hash_tunnel) as soon as one of the UDP
tunnel GSO features is enabled, but handle_rx() still copies only
sizeof(struct virtio_net_hdr) (10 bytes) and then writes num_buffers at
offset 10.

The remaining 12 bytes of the 24 byte header (hash_value_lo,
hash_value_hi, hash_report, padding, outer_th_offset and
inner_nh_offset) are therefore never initialized, and the guest sees
whatever its RX buffer contained before in fields whose layout the
negotiated feature set defines.

Reproduced on 7.3.0-rc7 with a userspace vhost-net "guest" that fills its
RX buffer with 0xaa and negotiates VHOST_NET_F_VIRTIO_NET_HDR,
VIRTIO_F_VERSION_1 and VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: offsets 0..9
hold the vnet header, num_buffers is at 10..11, the payload correctly
starts at offset 24, and offsets 12..23 still contain 0xaa.  Without the
tunnel features the payload starts at offset 12 and nothing is left
uninitialized.

Copy the whole vhost_hlen out of a zero initialized header of the
largest layout, and rewind the iterator so that num_buffers keeps its
position right after the legacy header.

Fixes: bbca931fce26 ("vhost/net: enable gso over UDP tunnel support.")
Signed-off-by: Guikun Yang <yangguikun19@qq.com>
---
 drivers/vhost/net.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1161,9 +1161,15 @@ static void handle_rx(struct vhost_net *net)
 		.msg_controllen = 0,
 		.msg_flags = MSG_DONTWAIT,
 	};
-	struct virtio_net_hdr hdr = {
-		.flags = 0,
-		.gso_type = VIRTIO_NET_HDR_GSO_NONE
+	/*
+	 * The negotiated header is struct virtio_net_hdr when only the legacy
+	 * layout is used, but struct virtio_net_hdr_v1_hash_tunnel (or the
+	 * v1/v1_hash layouts) when the corresponding features are enabled:
+	 * size it for the largest layout and let vhost_hlen select how much
+	 * of it is sent.
+	 */
+	struct virtio_net_hdr_v1_hash_tunnel hdr = {
+		.hash_hdr.hdr.gso_type = VIRTIO_NET_HDR_GSO_NONE,
 	};
 	size_t total_len = 0;
 	int err, mergeable;
@@ -1260,17 +1266,26 @@ static void handle_rx(struct vhost_net *net)
 		}
 		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
 		if (unlikely(vhost_hlen)) {
-			if (copy_to_iter(&hdr, sizeof(hdr),
-					 &fixup) != sizeof(hdr)) {
+			/*
+			 * vhost_hlen is never larger than the header above.
+			 * Copy all of it: the fields vhost does not provide
+			 * (hash and UDP tunnel information) have to be zeroed
+			 * instead of being left with the previous content of
+			 * the guest buffer.
+			 */
+			if (copy_to_iter(&hdr, vhost_hlen, &fixup) != vhost_hlen) {
 				vq_err(vq, "Unable to write vnet_hdr "
 				       "at addr %p\n", vq->iov->iov_base);
 				goto out;
 			}
+			/* num_buffers follows the legacy header */
+			iov_iter_revert(&fixup,
+					vhost_hlen - sizeof(struct virtio_net_hdr));
 		} else {
 			/* Header came from socket; we'll need to patch
 			 * ->num_buffers over if VIRTIO_NET_F_MRG_RXBUF
 			 */
-			iov_iter_advance(&fixup, sizeof(hdr));
+			iov_iter_advance(&fixup, sizeof(struct virtio_net_hdr));
 		}
 		/* TODO: Should check and handle checksum. */
 
--
2.39.5

