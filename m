Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243DCC433E0
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:06:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854D122CAD
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854D122CAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AB86186101;
	Tue, 12 Jan 2021 20:06:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id It+MFuvayhqj; Tue, 12 Jan 2021 20:06:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 08F1D85C8F;
	Tue, 12 Jan 2021 20:06:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4FDDC0893;
	Tue, 12 Jan 2021 20:06:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D239C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 409A1848F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:06:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y1S-iVU90OWS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:06:08 +0000 (UTC)
X-Greylist: delayed 00:17:41 by SQLgrey-1.7.6
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 95CEA8442D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:06:08 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id ga15so5291542ejb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vbacyc4brsO7fCWWmN34VX2kLRLEZOENYLDCsoU/LjI=;
 b=frDPSNM1J/dOImSb6yTvFEc5DFfgGXbEaLLgKaM0mONN1LJTeaMDvsD7N43EhUuKwM
 OzKSpdv9zyp8xkewtP83v/WGTWyMClGmamwcnslMUaaz1lav+C2aXiTjba4BdOhqxWXs
 YOItPqRzhgs4NU2YffFSmcJDQxMpi6pdbU7itsTGkKpcxuOJWziSQooRJUBKdpBzUYxD
 xIoivLmBPS3zxn3DPlnmaHb6St45vGGHON4Tw0XUnv4jTlfHbt6WSZPGEcTHqdLKQA8A
 oh9+TRaqxpOgBEf5HrtBEHkkj3ACTaqZOa/BiIncvZJTrHDMblqXE+TF/HZ3Eh4T7R9X
 TU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vbacyc4brsO7fCWWmN34VX2kLRLEZOENYLDCsoU/LjI=;
 b=Irsgm5VIbb5btncWH6Ikpg81EMf0lYWAo5UGNRBm4ON+YkqZoshlip2IJHGL5kZ/O0
 toDnwbjBaTNC7jfez2QXcFI9r0+1c4zLjDItus7zXU/LgtxgG2nIIe0TCrGQb32uasjH
 I19fYjRX7Py+oZ8qQjXTC8zxyeJ9CNLX7cFAY/b9/WKyFhp39DfJx0SlWQ9h8iKAQn4C
 lFulfL6BJ0isi0EzsQbEkzvZ0qrObFBvIxR3pK68slc8u5nBahAP24HwurfgYBBOtuDZ
 HngY63bb9m++YwoaR70UO9dlnPz3lSFO7qF5ufWVXoip0VJl5WpNpCWPCAZPK/CgmFgu
 RUFg==
X-Gm-Message-State: AOAM532ETy/QgShtXKCwghva/9VuVyPbe92dDA+ZfIr2RZqjmeyXvMK3
 D4w1i0GiTSoASHbLl8Qx5huNWj1NA9XGmrDu
X-Google-Smtp-Source: ABdhPJzR2K4OZsCoyd0N4J9iZegxzvR23ddSEOzUWZ1flur5F4V7qRoMhDvf+/K03T/6v7gHKGCucw==
X-Received: by 2002:adf:df08:: with SMTP id y8mr431800wrl.278.1610480533859;
 Tue, 12 Jan 2021 11:42:13 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net.
 [79.183.72.147])
 by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.42.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 11:42:13 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
 gustavoars@kernel.org, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
 decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, elver@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
Subject: [RFC PATCH 6/7] tun: populate hash in virtio-net header when needed
Date: Tue, 12 Jan 2021 21:41:42 +0200
Message-Id: <20210112194143.1494-7-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
Cc: yan@daynix.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

If the BPF program populated the hash in the skb the tun
propagates the hash value and hash report type to the
respective fields of virtio-net header.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 45f4f04a4a3e..214feb0b16fb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -556,15 +556,20 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 {
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u32 ret = 0;
 
 	numqueues = READ_ONCE(tun->numqueues);
 	if (!numqueues)
 		return 0;
 
 	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
+	if (prog) {
 		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+		if (tun->bpf_populates_hash) {
+			*skb_hash_report_type(skb) = (__u8)(ret >> 16);
+			ret &= 0xffff;
+		}
+	}
 
 	return ret % numqueues;
 }
@@ -2062,6 +2067,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 
 	if (vnet_hdr_sz) {
 		struct virtio_net_hdr gso;
+		__u16 extra_copy = 0;
 
 		if (iov_iter_count(iter) < vnet_hdr_sz)
 			return -EINVAL;
@@ -2085,7 +2091,20 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		if (tun->bpf_populates_hash &&
+		    vnet_hdr_sz >= sizeof(struct virtio_net_hdr_v1_hash)) {
+			struct virtio_net_hdr_v1_hash hdr;
+
+			hdr.hdr.num_buffers = 0;
+			hdr.hash_value = cpu_to_le32(skb_get_hash(skb));
+			hdr.hash_report = cpu_to_le16(*skb_hash_report_type(skb));
+			hdr.padding = 0;
+			extra_copy = sizeof(hdr) - sizeof(gso);
+			if (copy_to_iter(&hdr.hdr.num_buffers, extra_copy, iter) != extra_copy)
+				return -EFAULT;
+		}
+
+		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso) - extra_copy);
 	}
 
 	if (vlan_hlen) {
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
