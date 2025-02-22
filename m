Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B821517C
	for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251736; cv=none; b=PoOchhPg/XG7tm9KH3qSGLhTj+hlshw6RokxrvTCvFyj5XTNp602f3Eala3ZLj0o60t3QFZbaIsHjtuHa5u+zfySfg/Ekn9WxIbaEhH+5WwcmhwEaG6qhFc/LAOAdHEiDckstqV3cqIQ2dh6pc5HY1YZBeEz3bNLsSaggVEQr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251736; c=relaxed/simple;
	bh=8Y2ZMgshy3DSser0k2/0xpJbIFztqzldqJ0EgMTN7TA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q2qoJxfZuuIUN2y/BW7JvN6yBvHlhzfdZgEET3Grbfz/d9Dj+qBkNYqwnvtr2FRZuOvSCZ3HcylVzYo28i7G9XDMsDs3E1hoLdr5O71H3/hAWk1Bg3OZvPxAMAxGi3H2UzKjMmS643BJ2P8DLPiWsxZaCc6cnDzMFaatfuzl7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bO+FWVMA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bO+FWVMA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6cb3097bso84734665ad.3
        for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 11:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740251734; x=1740856534; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bokme88KuMNdn1f3MKxdjhr0HIEvbFywaglPVkH9x/0=;
        b=bO+FWVMAuv2Y6It5pcMW9AQLKZDCdaQNQTE9EwXG73qVAbPcewKRcNOqH6Vs43/HSj
         HBCunVzS/5ceULFbhkYU+FGv2Vp+jjkJIV60VctChDuwoxrRutcDsdAivQmtfRF9/lVq
         KaQ3q9DpBJKzMvRfNEGp43kEkY4aYkWQvIKrxNh3+PWBnWqKMzNZPTtwedoW5/27u9RB
         YsWhsR5kCsCAfI2O+A1dWd2PBdM0j/VZRO0pZILte99MV6Hvlu6GX09K+hZZu6mtQe6c
         7U8gMk3rBqYSp17cIptKNkwgtKylMQpE2mCPIQyVMh2HRUBd29urHYWL/DOCpdwerKJL
         HycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251734; x=1740856534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bokme88KuMNdn1f3MKxdjhr0HIEvbFywaglPVkH9x/0=;
        b=puH25Me0HsbOnbE11tZ69Q2CX+9oRmKqM4eYBGru1Ylgrsyec8535LtdFtz/RK1Ci/
         P1Ze2Hb8yEEdUMB8XTOdqNoxjWbq/KcqwhKJH5lUU8TbKjSIWdlIwOASYqIV6tvF4r+Y
         IYA4fSkG5hIpK/wed4ypzUC15hBs0lR79Sf3RhTX/lhtAqJxOGY5wtXYZ0C2I5X6xRhL
         4S7BW/mllV+OhuGHWfLa/USaLdnEM6HFPkZD1embxobCstkMIPovSxOKkz1EZnKChdqG
         04aUwjbxuEiysuSIyHw0l9lYaG1ZRYFRVBt3fp4D5/H5XCsDoapJeseUgHkNL7kaCYEk
         Y+YA==
X-Forwarded-Encrypted: i=1; AJvYcCW1zSe90G3eWVXUJbUnz6nat5rL4bF9+G/n6O5Ziu86IDpZ4FEhVaGrWFX3sAeVdFbVVjQ2t0ov8UI3P4qjOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJmstI/Bw/DqKnlHJuqgfpxs9S5fEWjdER0XQ68UXoLubfQ9FF
	60bCIEXeSE4W+M8m/z78/UvXzg8lIm7DxseCtGX3VcN8I9uSi63RIsuQW5wfxdbOoNL4x5bsBnG
	3sATsF7bZ1rd6PoVrgfeQOQ==
X-Google-Smtp-Source: AGHT+IEFy9MOMqoUL+PCw3IyeJmCuFhQ91qsxJxZ5c9JuF+IqC2mtPSjn0iWhVp1Rk9Pf+OhOvRwARWSRX9mbFDPmw==
X-Received: from pful4.prod.google.com ([2002:a05:6a00:1404:b0:732:3440:ffcc])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1746:b0:730:8d0c:1066 with SMTP id d2e1a72fcca58-73426da62camr15650719b3a.24.1740251733766;
 Sat, 22 Feb 2025 11:15:33 -0800 (PST)
Date: Sat, 22 Feb 2025 19:15:16 +0000
In-Reply-To: <20250222191517.743530-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250222191517.743530-9-almasrymina@google.com>
Subject: [PATCH net-next v5 8/9] net: check for driver support in netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v4:
- New patch

---
 net/core/dev.c         | 3 +++
 net/core/netdev-genl.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8c7ee7ada6a3..ba83b18fa703 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3921,6 +3921,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 
 	skb = validate_xmit_xfrm(skb, features, again);
 
+	if (!skb_frags_readable(skb) && !dev->netmem_tx)
+		goto out_kfree_skb;
+
 	return skb;
 
 out_kfree_skb:
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 6e7cd6a5c177..6c5d62df0d65 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -972,6 +972,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
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

