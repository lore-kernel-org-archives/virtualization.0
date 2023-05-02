Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D22C77B73
	for <virtualization@archiver.kernel.org>; Tue,  2 May 2023 17:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A01EE813F8;
	Tue,  2 May 2023 17:44:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A01EE813F8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=agLweq+H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p2HTYH2VFEml; Tue,  2 May 2023 17:44:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AFFD813F6;
	Tue,  2 May 2023 17:44:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AFFD813F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF5A7C0037;
	Tue,  2 May 2023 17:44:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34B9CC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 17:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 074F0813F8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 17:44:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 074F0813F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XiV03YXzhTAb
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 17:44:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AA8F813F6
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AA8F813F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 17:44:11 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-54fae5e9ec7so57934007b3.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 May 2023 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683049450; x=1685641450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ws5j/dI0nYox1o3GIO+GjjxWpnPjNPrD+4R2eJ37G04=;
 b=agLweq+Hgw+KwpZ9g96mCqhPUpKHetp5atMN3v05x2Sdxul/yfjMV/m20XmAoa1VaR
 ry9Z2l+6XrPC1qlxSer7soKE1KTJCb8bgS/w5aY0X3NYke8q02WfEy7Ne51BBDWLnZm8
 1DfYdqhmrA0jgxKzMmQqz/LZYqrvl/kj/UUwyFIHsHKeV21lVP5BM+awqWYcpDrcIkSc
 B7g/ERQrGD2PwT621z+okSUjq8+vXI7bUZZ2C+H72L2o8VYiCFlgeE5K9dnpjhqNKcA4
 9M0FfBSodScePvz32bkP4isvv2GrNF/WxyiDxipuWnUsjF1VyDosuFt8AcPtjOX+y8de
 74zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683049450; x=1685641450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ws5j/dI0nYox1o3GIO+GjjxWpnPjNPrD+4R2eJ37G04=;
 b=kgnA1GebTMC0+6oh2v7psgSWl7mTetHasJF2gYfNuEe3EKAvw48z1L2A9++2nmhkJr
 c8Q+PBT+x2NMD6HJ5uiQMssbw4C7d/BBcZjsWqxhPTaIAzYpUbXCjHqm/n6mDuIIeG1m
 MZ5JMyGKgNYpORtJ2ZrUR53dKZT7juvktqE5cgZ/ZwN8t8elnv+HY8cxZS249CPmw0yW
 6mxLt6Ko5eVXeYaxi7RZy/geTWUoNR6A1tl+PDyCNI5I/5TiimHfhoRqDRtbQvqnqVCM
 91z4qtzUCFNoOmWym+OZYahl8paTpu5/rN+ywvw0LQ5NbV7n25KUoC59Ecio138PcOxh
 cnXw==
X-Gm-Message-State: AC+VfDxkZU8eM7w2DrrIantNNTlBgjRndGLvIj8xEK9M5kQwGZiH9Elt
 BZHCT+VCy11Dt/N8ngf9KEo=
X-Google-Smtp-Source: ACHHUZ6aPaZ7dpAAkU/aHe6CXoJqaQ94S0jCVnLuk/UrtTvAemcSK41fHAgqYgZcTp3A/voySR9+fw==
X-Received: by 2002:a25:d288:0:b0:b9a:74f6:2738 with SMTP id
 j130-20020a25d288000000b00b9a74f62738mr17204611ybg.38.1683049450089; 
 Tue, 02 May 2023 10:44:10 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:65a0:ab60:42a1:f9ec:2dbe:d4e])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a252e07000000b00b98dbbedb73sm7018211ybu.43.2023.05.02.10.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 May 2023 10:44:09 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Subject: [Patch net] vsock: improve tap delivery accuracy
Date: Tue,  2 May 2023 10:44:04 -0700
Message-Id: <20230502174404.668749-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

From: Cong Wang <cong.wang@bytedance.com>

When virtqueue_add_sgs() fails, the skb is put back to send queue,
we should not deliver the copy to tap device in this case. So we
need to move virtio_transport_deliver_tap_pkt() down after all
possible failures.

Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/vmw_vsock/virtio_transport.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index e95df847176b..055678628c07 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -109,9 +109,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 		if (!skb)
 			break;
 
-		virtio_transport_deliver_tap_pkt(skb);
-		reply = virtio_vsock_skb_reply(skb);
-
 		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
 		sgs[out_sg++] = &hdr;
 		if (skb->len > 0) {
@@ -128,6 +125,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 			break;
 		}
 
+		virtio_transport_deliver_tap_pkt(skb);
+		reply = virtio_vsock_skb_reply(skb);
 		if (reply) {
 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
 			int val;
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
