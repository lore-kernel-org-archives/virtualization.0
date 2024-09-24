Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777C185B5E
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168502; cv=none; b=H2e345DNg10AFzgJMWDYLrNS7T80iH3S/SzPYecwT9TJO7RJm8VAkJbCx2bee1zJHmt28RIa/8IAa6CR5iwmkdueoBCRrXJAAORGoPAjnBZGeaA3j0t3LY+SSOJms68kUEs8VqmfNoMMvPsXYpulRHmhfs9K4jHNCLkp2ryQJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168502; c=relaxed/simple;
	bh=2fqPz17MRcLXtYYBT9jcWjUzidfYf/z7eYbmCSZjWTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=u6QclQu/gFCEfXvP8LxD+88fQ1kHuGY5sU80zDaMXrG6SheduwwSK/JMZMTV31BjD7hk7BQ+v/45lMEmFZQCaLUKrliUWsgNXo+MfihCk02GF5wbwJON9wd/EavqIHOMgEmeVU+opdymwPp7G7g4T+aIlvgoWNZceUKNc/zA6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Kbe9LoZy; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Kbe9LoZy"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 917764013B
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eXvGpKcLDPxS for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Sep 2024 09:01:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 73DC44024A
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73DC44024A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Kbe9LoZy
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 73DC44024A
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:37 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5c718af3354so329764a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168495; x=1727773295; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldxygdAUBk4mdAzGg1OPlp5HlR7yVW+p2ali8303Ccc=;
        b=Kbe9LoZycg8zFbpl2ogrN2gYo7KPQkKerWhQpp/TC7r6QL5lgviHerUTDOjqxOsiOa
         gjwJJLpS9rTFrULFOADZT/g4GPo2huop/kKeHXNTA1/168eyIOUZNsi3v/zzOWM6eJB2
         24VA9Heqaq4rCD0n7Fm8xN6iJR52kYCWXop7UJYQXu+Qf7abpe+5JE2i9LXT5g15Fso0
         +zYVTxT/mq3i1ksUQeizqMXP1PhZD3KGrKDrI3NFWIh0qG4rZ3nfPeau48vneWaALbW6
         brSR/NGMXKMxVObPQXsMLtdXi8oQ6GSitwCyv27pmzFnxvM8JvwPGKOKAoUY4NxlA9wV
         j5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168495; x=1727773295;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldxygdAUBk4mdAzGg1OPlp5HlR7yVW+p2ali8303Ccc=;
        b=CWlCVWo3ir4/Y63H6llfuteH3lIF4eVltbZposDvxeUcjV49grlgQkcabgDnvp6f+u
         TDWtgzUxh7A8PeF5NN/mf2BuE8XNXuw69SsgxEsfIPE82fR8Xa+GMurG9mxtqs6AQkEo
         gyKTzqxqaCFoWzPMlVe+6QcXm5kA0tuezWSAQQ8SPVaame+Tfx5DpggV0UsjXGOqJmOJ
         7c5oS1Q3t221F2XwsED8UuqUXKiomy/yXuUVtwOcFtiLhsMFe283uswnTT4x5s5PJQ/q
         HtOavG0ctnx04AZQQTWmDC7xdMieQUgaV8HXLTgcO5+cNws1KaCzavbCv99wGPxjx74Q
         ih+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtOyGj6GH8Ld9VeyfWdilVzc19xH99kWnrfeVQPKeFLXIW2nSt4J0/jZj+lHrxyh2+2dYi+8lpzeGMz5mrxA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwQf8F7vCBx6clzXgrcKbZTcpXbIxbk97Vq6F6wEw0VWpQAkMzj
	BnsVNh94yaPM7k8HQxonzJppcC/MNFsYv6/JAOYQRmHstJQ1wuFkYQMnHYqDcTs=
X-Google-Smtp-Source: AGHT+IFFGNZvMoEmnxV4kikQ2H333bCCtXL26WeV3JaDRS2Q6nCPUSS8kmDRZE0LD3ZUPP5h6fZgnQ==
X-Received: by 2002:a05:6402:354a:b0:5c6:34c5:e5d7 with SMTP id 4fb4d7f45d1cf-5c634c5e97fmr874444a12.7.1727168495205;
        Tue, 24 Sep 2024 02:01:35 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c5cf48c04esm527645a12.14.2024.09.24.02.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:14 +0200
Subject: [PATCH RFC v4 9/9] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-9-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/vhost/net.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f16279351db5..ec1167a782ec 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -73,6 +73,7 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			 (1ULL << VIRTIO_NET_F_HASH_REPORT) |
 			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
@@ -1604,10 +1605,13 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 	size_t vhost_hlen, sock_hlen, hdr_len;
 	int i;
 
-	hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			       (1ULL << VIRTIO_F_VERSION_1))) ?
-			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
-			sizeof(struct virtio_net_hdr);
+	if (features & (1ULL << VIRTIO_NET_F_HASH_REPORT))
+		hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			     (1ULL << VIRTIO_F_VERSION_1)))
+		hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	else
+		hdr_len = sizeof(struct virtio_net_hdr);
 	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
@@ -1688,6 +1692,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_FEATURES)
 			return -EOPNOTSUPP;
+		if ((features & ((1ULL << VIRTIO_F_VERSION_1) |
+				 (1ULL << VIRTIO_NET_F_HASH_REPORT))) ==
+		    (1ULL << VIRTIO_NET_F_HASH_REPORT))
+			return -EINVAL;
 		return vhost_net_set_features(n, features);
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;

-- 
2.46.0

