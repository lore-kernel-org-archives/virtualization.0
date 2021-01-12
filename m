Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ADDC433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 19:42:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0F823117
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 19:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0F823117
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3BA4C86D82;
	Tue, 12 Jan 2021 19:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E99sIn8r0I2y; Tue, 12 Jan 2021 19:42:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3D2B86D37;
	Tue, 12 Jan 2021 19:42:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78987C088B;
	Tue, 12 Jan 2021 19:42:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF82C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 542AD20431
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SQvxFqilROGO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:42:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by silver.osuosl.org (Postfix) with ESMTPS id 5FA0720361
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:42:12 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id g8so2972285wme.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 11:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZIRhmzhJTza1eg/duDC8aSWDJ8wELCNq6nzGwLtOGgE=;
 b=d9NxmNZSQNFWQVyP7EOF6ws9upmBjMm7Uu4vcCvAagQcJvjqLbg5+r9m2RsQFFiJis
 Phmfncl8NVLjetiCUd7//m3Bmb/XboSynU2+TTlz7fnQQrc7Jpxc4hbmaw8FZqV5TH7y
 sRRNBzmxv6jAlGIonq5UpuL7dMdRW+ftT3cnGIa3N0L2U2c/1jaGnLRqD4+8bMh4rAPo
 vOvc7I+Tm890KsTLrvzdfciGgT5p7v9XHa51iZ9aT1MwsRe8bYEEqZSNxG/W4qodptly
 zpZ2A26Vz1arJqMbfke1ek2319CmQxsbEOY6yJmN8LiK+JJsd/aLYiWW1hD2hgKV/tZM
 NhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZIRhmzhJTza1eg/duDC8aSWDJ8wELCNq6nzGwLtOGgE=;
 b=VjsdHAAwWjtlPevLrmXHY8VBJX1zQTfkR5S5ElsYjfxilMAfDVrLggVBr3AeLxmTNI
 y/i2oxt+MnkHvo+BumGWKvgWBK1MflZtzMC1fUn+0GeDXDrGaZoxCc+Pt9VI6orCe8ev
 ll6c8P0flaxRMVRGWj9xJTYELOSV53QtWf3KxeQ2pJ0oWK6Tir1GGgPvC0x5atqkZPx6
 wtMXSyzpZb0BtV0GsAul6G2uZAjT1XPguVIQkbkKUA2+6Dg+SzfjpkyfqkLZmng9IbqY
 CHFya3bBkR39iIUpt7e09chDfUtq/5cfHNstobjzqP9TWV77bLRd95lREXIfPzWC097x
 YUPA==
X-Gm-Message-State: AOAM532Bx0ZUkVU01L+WlzcfbY7uqLn7yMe0r93wHAkubf9EZqd1Yk7m
 9THM77OoCt7FjOhuZf/c+Y3nQw==
X-Google-Smtp-Source: ABdhPJxgkunWSUTHmZ71tMmXeTXU/QgKZnSQGKYYciKcgoVgRx0jy5oBLeyU4zrM4dUfJdLaLRdw1g==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr755038wmi.91.1610480530694;
 Tue, 12 Jan 2021 11:42:10 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net.
 [79.183.72.147])
 by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.42.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 11:42:09 -0800 (PST)
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
Subject: [RFC PATCH 5/7] tun: add ioctl code TUNSETHASHPOPULATION
Date: Tue, 12 Jan 2021 21:41:41 +0200
Message-Id: <20210112194143.1494-6-yuri.benditovich@daynix.com>
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

User mode program calls this ioctl before loading of
BPF program to inform the tun that the BPF program has
extended functionality, i.e. sets hash value and returns
the virtqueue number in the lower 16 bits and the type
of the hash report in the upper 16 bits.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c           | 12 +++++++++++-
 include/uapi/linux/if_tun.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 18c1baf1a6c1..45f4f04a4a3e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -197,6 +197,7 @@ struct tun_struct {
 	struct sock_fprog	fprog;
 	/* protected by rtnl lock */
 	bool			filter_attached;
+	bool                    bpf_populates_hash;
 	u32			msg_enable;
 	spinlock_t lock;
 	struct hlist_head flows[TUN_NUM_FLOW_ENTRIES];
@@ -2765,6 +2766,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 
 		tun->align = NET_SKB_PAD;
 		tun->filter_attached = false;
+		tun->bpf_populates_hash = false;
 		tun->sndbuf = tfile->socket.sk->sk_sndbuf;
 		tun->rx_batched = 0;
 		RCU_INIT_POINTER(tun->steering_prog, NULL);
@@ -2997,7 +2999,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	struct net *net = sock_net(&tfile->sk);
 	struct tun_struct *tun;
 	void __user* argp = (void __user*)arg;
-	unsigned int ifindex, carrier;
+	unsigned int ifindex, carrier, populate_hash;
 	struct ifreq ifr;
 	kuid_t owner;
 	kgid_t group;
@@ -3298,6 +3300,14 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = open_related_ns(&net->ns, get_net_ns);
 		break;
 
+	case TUNSETHASHPOPULATION:
+		ret = -EFAULT;
+		if (copy_from_user(&populate_hash, argp, sizeof(populate_hash)))
+			goto unlock;
+		tun->bpf_populates_hash = !!populate_hash;
+		ret = 0;
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 454ae31b93c7..0fd43533da26 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -61,6 +61,7 @@
 #define TUNSETFILTEREBPF _IOR('T', 225, int)
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
+#define TUNSETHASHPOPULATION _IOR('T', 228, int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
