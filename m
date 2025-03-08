Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888AB205E15
	for <virtualization@lists.linux.dev>; Sat,  8 Mar 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741470051; cv=none; b=C6ztF24ft3TrThZbsRJKD1A3PkLxHTqOUvQLGH4sCQR42iAPHSlFjZaDLgjrYQh2kcXX1ittKbI92liRE3+AQa9GLB75/7hk5IeS3cJpI91u9R7ASV2DyPl6rF+XbbaTydbsLeUPCpbJAlCiik+S1dZDcvFBqT8d7qg6WnxNB6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741470051; c=relaxed/simple;
	bh=1gKSJ1zhftBSMc9cuS8nUiycP8+YXffYCs0yXilMSBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g/X51Trh7THT+fG2veX8FirENxkaqg4NFAsDKXPH2n93lD6K0NDihMeZBVjiiiO03xGm+ihpcevWJQ92FQCVUkUEyKuoBlfu7xLGgFSYmkAS+aGpaWAyXMpAl9C2Gd3wjBzAmwJtEz3RFXBaDfm1usHLq+Kd47m2Zhn4xeNXWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ltrhb7Gc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ltrhb7Gc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so3534043a91.2
        for <virtualization@lists.linux.dev>; Sat, 08 Mar 2025 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741470049; x=1742074849; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tX6BmoNjuzIzQpeeDWDPAAnCBo+DQIywGklr81dGywI=;
        b=Ltrhb7GcVSZTwrjYVojjOTdK8grHiTpDVSHraGUOtSw07o9BOPCSA7Rc9hB7T1+fEF
         4Sc6VgirUJRrWwvI/pgTdtK6Hu09dcv2qQEuHB03GmniZIk9PWbFS5+h/6eKFZb9W8xB
         NjvtJoYTDViPaKqKxhAlCyCFWqg3fgbNhP/DbkeGlxYZLU55zkIv/FLMdgYPjiC3Ydkm
         lSO8XmAdEDu0mGnb2xpYIBXlGulrBOFrIJ5G07le+/lXsG4lddUlDdracKT33eqKtYD2
         ra7vfG+R+6lCXM+6KPIsmsijOrk0yD9hf/uZrzSUxM0z6wrAtGDGeHOwy/nyyiv8UZoF
         T7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741470049; x=1742074849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tX6BmoNjuzIzQpeeDWDPAAnCBo+DQIywGklr81dGywI=;
        b=nqRkDU+NvYEb838ZmEL/soPc22FFvPXQJObPmGmZX4WHK6KavgnfbSLeLUpNaP5TvE
         +2aKUFean9yU41oQajxWgvzxfGdH4A4JNayVM+M2S54h+/FpDK0NSG7k9NiELfsG9fxo
         A5NTZ2nsRRhh+b6soVQabX2hf7LipA5Dxmw8zxfq7bkRAT/NWnAbiDOVHLlaI1kkDvyy
         AVuN/Ox3433DCNimwdbs2ISIANDnTkOBnAhPU5NcgFFXK0xxAnqPLprQNa8wvGpE8fRf
         pl1dzy4WWE0OF9d/uig3YLBZ9vmAKxZx9fRnmrd5xd/4Wm3f6LBSyE327Z+esJ08jh3c
         KISw==
X-Forwarded-Encrypted: i=1; AJvYcCWuJyAJ6dunT1TiySJK0GYQAdjSHTIWktbKOLoHiYxHXfjl5uOQOHoh1ZVdkcSrfZPaLIdDWRsO0TmqfaFSOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNubOKa3/SO7EKI3g7DAtQIzw4r7ObITFF0TDWsVE7Qa3tttQd
	2rnY/eeK8dUJeFJXsrLFgIMHhhfEfSPLK/kp3Pa4JQikL6dywDQ+jm2+P3JdU2rYDAM6roQ9x8f
	2f3NrH5fTCzqq8Cn50UgyCg==
X-Google-Smtp-Source: AGHT+IGosKIoAKeyr/SG8ND6M+mWt52v5RM08qZWQV+Ah7+Pc16NBy99FOItw+U5mA3+iLTD73K+eFUwb0dExaCk+w==
X-Received: from pgbdo7.prod.google.com ([2002:a05:6a02:e87:b0:af3:27c:5603])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7483:b0:1ee:d317:48e9 with SMTP id adf61e73a8af0-1f544ad8152mr15572734637.6.1741470048718;
 Sat, 08 Mar 2025 13:40:48 -0800 (PST)
Date: Sat,  8 Mar 2025 21:40:37 +0000
In-Reply-To: <20250308214045.1160445-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308214045.1160445-2-almasrymina@google.com>
Subject: [PATCH net-next v7 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
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

Later patches in the series adds TX net_iovs where there is no pp
associated, so we can't rely on niov->pp->mp_ops to tell what is the
type of the net_iov.

Add a type enum to the net_iov which tells us the net_iov type.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v7:
- New patch

---
 include/net/netmem.h | 15 ++++++++++++++-
 net/core/devmem.c    |  3 ++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index c61d5b21e7b4..16ef53ea713a 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -20,8 +20,21 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
  */
 #define NET_IOV 0x01UL
 
+enum net_iov_type {
+	/* The unspecified type is temporary until the io_uring net_iovs being
+	 * worked on in parallel are migrated to specify their type, then this
+	 * can be deprecated.
+	 */
+	NET_IOV_UNSPECIFIED = 0,
+	NET_IOV_DMABUF,
+
+	/* Force size to unsigned long to make the NET_IOV_ASSERTS below pass.
+	 */
+	NET_IOV_MAX = ULONG_MAX,
+};
+
 struct net_iov {
-	unsigned long __unused_padding;
+	enum net_iov_type type;
 	unsigned long pp_magic;
 	struct page_pool *pp;
 	struct net_iov_area *owner;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 7c6e0b5b6acb..69c160ad3ebd 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -32,7 +32,7 @@ static const struct memory_provider_ops dmabuf_devmem_ops;
 
 bool net_is_devmem_iov(struct net_iov *niov)
 {
-	return niov->pp->mp_ops == &dmabuf_devmem_ops;
+	return niov->type == NET_IOV_DMABUF;
 }
 
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
@@ -297,6 +297,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 
 		for (i = 0; i < owner->area.num_niovs; i++) {
 			niov = &owner->area.niovs[i];
+			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

