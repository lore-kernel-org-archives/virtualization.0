Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AAF1E3DCF
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017377; cv=none; b=ABFYah1OKzJnUBOhy5fWrG1neHpx8zITkukhIG0jwXCL1Gj4wZDziM+TlgGBs+cxeIQIfrWdmsznAUBx5YrOkrVawGKLkUpLGnpjI1CDwh77/jEISuTBPdd5y/nz+bLK8tgFGUrL7Yv9LYZFouVjwL9/xen9gM5PlVnYOijn0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017377; c=relaxed/simple;
	bh=xktwRXpJMJv986Qo4eDPxj726JXR+3eKG4eS+/XdbOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZhOHkoXcdi8eV86ekBVIB6nfIHuS4tj1u3yZAHyvSVHN1Nt4rhMS/olol2tLl+VQuB9vSRLpfQEhzJpbkSPv0TIgPr3H2fdAYorpZTBLWqnkeeeW3ATPTj/jEMFmepcXisaAbY5WFEAUkIx/IB6ZhsPQPQUlcRtjPiGKaKyFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3HgbmpO3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3HgbmpO3"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so1458823a91.3
        for <virtualization@lists.linux.dev>; Wed, 19 Feb 2025 18:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017374; x=1740622174; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ouoTtMMhd3rb00vY+DSWvls3bj0wfOCkxx6qaQ7XOwM=;
        b=3HgbmpO3Y6LBETRmw3B0e0CPyiAr10aEH4y5u+Z6kRQPxew9kOvTRJ2AD/30EnxqnT
         H5aiaRC4zF3dgIvnWEZCbsFErS8E90tpVdsiPWBlIhf4rPT66UC/O6DRuveQPVc3biZ/
         cGZoAawn6Gm0d8um8VgG9QBW8mSI1tWU4/H320BKVXW3uooIHr1Yyp67fU/JQAsFzBtB
         Wl4S87wpg/qEDfeeUO2IJvd3k0efZZy5v6WcDI5WSl+YSkmtXzHx1JOGYS9JaHUE8dzQ
         ZR7tonhIqrPBjD83du9b263abYPeFXU68Xvnwr/eRiKH+Rsx3fYZdKGDuzaDpleqIaeG
         csrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017374; x=1740622174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouoTtMMhd3rb00vY+DSWvls3bj0wfOCkxx6qaQ7XOwM=;
        b=VvQkNFlN1x0znfikbiROuyf2Yv7zH4OTswJ41hRSP1j/MQpFi75Btr3aB+WgnaeGjM
         3BThgtobo8DC1GKlUPoxiRQKmNgp/sMiwj31HaCPM38Nv+LomPGLyYSOa3Hv6BKT+Pnj
         QlWOGbW0VOhOQvHOVANkdFWUBW1QlE+R9+hdanN2O1aaRvV32jRELpedztWhC/FZnG+/
         S/7m9wJkPhBmzJmMdBLaUeYTlI/U8z54XNf6epabkx/DE1U66JXlYdpa6b15jWOAHZYh
         nwsZwESTGFqHeno3qvbZ1TC1w422lGPAsmehM1WNez71B/kk9oJOYRFPbGociRvkUtyD
         fMXg==
X-Forwarded-Encrypted: i=1; AJvYcCWlQhu1RfaJ5AUloAw3V/N57lFqygPTTdlAlg6/Nz7iJ0ST9p1URL+we6FT5DrlvHXLTimDyN4TDU0PcgOuBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywm5wytPPMei1x/Xp1PdNddRa1ySNCydB+csVY4Y4Hm85kVS60z
	jhq8FIj35/MROFpvywNoxYTZ9Rv7XbGjS1SSqqokEucwyxM6XRQ0TDADEL3eT4StaVYcOa5FKjc
	ZXPqQOAm+bUMKUgukJMSC3w==
X-Google-Smtp-Source: AGHT+IE63Y1j485C5r+SG910yHgU7D0EniRUvxRKp0z0ZOdOvF2csyUI5aFQVIvnQkQW3zk2gmV0Mv7QAnOs+6jCLQ==
X-Received: from pjc8.prod.google.com ([2002:a17:90b:2f48:b0:2eb:12d7:fedd])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5202:b0:2fc:3264:3657 with SMTP id 98e67ed59e1d1-2fcb56f6d59mr11204857a91.0.1740017374316;
 Wed, 19 Feb 2025 18:09:34 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:13 +0000
In-Reply-To: <20250220020914.895431-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-9-almasrymina@google.com>
Subject: [PATCH net-next v4 8/9] net: check for driver support in netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v4:
- New patch

---
 net/core/dev.c         | 3 +++
 net/core/netdev-genl.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index ebc000b56828..f65a2b41a2c3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3850,6 +3850,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 
 	skb = validate_xmit_xfrm(skb, features, again);
 
+	if (!skb_frags_readable(skb) && !dev->netmem_tx)
+		goto out_kfree_skb;
+
 	return skb;
 
 out_kfree_skb:
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1faa2cf4057f..a154480a6e22 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -970,6 +970,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	if (!netdev->netmem_tx) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Driver does not support netmem TX");
+		goto err_unlock;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
 					 info->extack);
 	if (IS_ERR(binding)) {
-- 
2.48.1.601.g30ceb7b040-goog

