Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060501F12E0
	for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271755; cv=none; b=sgy4TiTqmORaaAj1kZaHsa1TkWzvIPXQOHNiHg+MxJ5ie9RI7TbhjWvBOy+j/Z9dapcrZst4WiiTSh0o08dHbXalUsVa3a2k5X4Jkcit5a/poSNBiGQ0bw29uW9wtGXY7bdbPxUKDnVBsInWX5o9Gs3OxF88BPHcaaERZhaDkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271755; c=relaxed/simple;
	bh=x4IKxvmNWD/4EDjE6znR+TcbhAdsP8iIvWcJKwYoK60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h6ofL9cIMjXzLJTnuvtMV5xI+MuXm8Eejx7L+cCq9Er/AtjW6waKIOLgYd306M7bNXePVe3FezAZeuxYgwIZvxNfHOoVct6QZ2Kj8X/UtFv0P+oJwlvHeeQdr+phTC5VAxhZhUy8h48MYjiKk6yDudUqBKBv2EpMNWJm2FmP0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WqbP5opK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WqbP5opK"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso2482380a91.3
        for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 13:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738271752; x=1738876552; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1EKwdWQ1Gk6X/oh63eg9ipo10zb+OP7eOCU+VWvx8c=;
        b=WqbP5opKbdFznSxOMG4ABsxp5T9JHZgPOO3QT1LsfoeYliT/4f9W37pVnLI/+9boY3
         1KNG5g4BckDuPTwqVFyaAvrNE+woErbQ1DtekJgMLRc45O1mkN2Jur8h7EKShOt43kdV
         VMDVRBM0oXLdoQlrXvDur7lfVYPqKIgWrJlAX8BQ29TWCIDxosSLURXHGitdFMgAEH07
         eTW5ZgQXif7ieT8+UF1kY8pdpH++mV4fLEJCknp6L7i4/Yziwn3+l2tWd+ezTTZRYaw0
         ehv96SDisV7O9lPIHvZDm0A2q3MJ0pdwhafuW/Gt0kUxgtU9Hjtca/x37mMRecgiq3ic
         0FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271752; x=1738876552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1EKwdWQ1Gk6X/oh63eg9ipo10zb+OP7eOCU+VWvx8c=;
        b=HDEiY15TZsMKoA1INYeE7gkApqnCTS7dpgVZ7+tKiOAtanYOdhggLD61AsqfxFR1Iq
         cjZ9yuQuQurI2rri+bSnhScaQGT8RKtONjkWPA8buS+qUBt+ow/bWWLlARiOO2UuOc7s
         3jXai78q86N3GIg3ADD+H1HxhztkrnlCAjMlUHABw+rCYYDfTIfr/2x+Ymh62O8plb4T
         /1lV6TKDSy6I6FSQ+vZtLWKgTmSp578aNkQg1cEIRGecR/RQwkZww0MbEgQgff1t5HT4
         5ORXUL9ea9bHFNxD6AsEFBHKUTlJPdaD8dh3vhalsb46u9KvGelX5LSYGjbcdzRB5s29
         ccMw==
X-Forwarded-Encrypted: i=1; AJvYcCWmBsybZaSilUtigLiq980+GGrFozkbvt3wOitw5c8w3z7Sv7DrByDQgmUu/NVmPEt/oLFWpPpl7PNHCAERVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwspmzsgzxrqZmZhVrChL/fmzQEn7JwXDmGffrpGqbdSXkQ4xdN
	WJH3oiL0xh8rpymDD9dWFwWmt58vFOhjAHCWz7QvWWPqWznvW1VZp9GlrmPMpQJSZ1kgjWV14fU
	KJYjW19CzVJm/3dduc7KDtg==
X-Google-Smtp-Source: AGHT+IEu842jzz9/l2yJnwVinJKP7fFjPrUiJo2kyVUr6Y5tdahD7orUVlBr0+J+ihAQ9NwxSAcZpEbIb/SaC3F/GA==
X-Received: from pjbsw11.prod.google.com ([2002:a17:90b:2c8b:b0:2ef:a732:f48d])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4ec8:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2f83abea7c9mr13096491a91.13.1738271752211;
 Thu, 30 Jan 2025 13:15:52 -0800 (PST)
Date: Thu, 30 Jan 2025 21:15:39 +0000
In-Reply-To: <20250130211539.428952-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250130211539.428952-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130211539.428952-7-almasrymina@google.com>
Subject: [PATCH RFC net-next v2 6/6] net: devmem: make dmabuf unbinding
 scheduled work
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"

The TX path may release the dmabuf in a context where we cannot wait.
This happens when the user unbinds a TX dmabuf while there are still
references to its netmems in the TX path. In that case, the netmems will
be put_netmem'd from a context where we can't unmap the dmabuf,
resulting in a BUG like seen by Stan:

[    1.548495] BUG: sleeping function called from invalid context at drivers/dma-buf/dma-buf.c:1255
[    1.548741] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 149, name: ncdevmem
[    1.548926] preempt_count: 201, expected: 0
[    1.549026] RCU nest depth: 0, expected: 0
[    1.549197]
[    1.549237] =============================
[    1.549331] [ BUG: Invalid wait context ]
[    1.549425] 6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15 Tainted: G        W
[    1.549609] -----------------------------
[    1.549704] ncdevmem/149 is trying to lock:
[    1.549801] ffff8880066701c0 (reservation_ww_class_mutex){+.+.}-{4:4}, at: dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.550051] other info that might help us debug this:
[    1.550167] context-{5:5}
[    1.550229] 3 locks held by ncdevmem/149:
[    1.550322]  #0: ffff888005730208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x40/0xf0
[    1.550530]  #1: ffff88800b148f98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_close+0x19/0x80
[    1.550731]  #2: ffff88800b148f18 (slock-AF_INET6){+.-.}-{3:3}, at: __tcp_close+0x185/0x4b0
[    1.550921] stack backtrace:
[    1.550990] CPU: 0 UID: 0 PID: 149 Comm: ncdevmem Tainted: G        W          6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15
[    1.551233] Tainted: [W]=WARN
[    1.551304] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[    1.551518] Call Trace:
[    1.551584]  <TASK>
[    1.551636]  dump_stack_lvl+0x86/0xc0
[    1.551723]  __lock_acquire+0xb0f/0xc30
[    1.551814]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.551941]  lock_acquire+0xf1/0x2a0
[    1.552026]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552152]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552281]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552408]  __ww_mutex_lock+0x121/0x1060
[    1.552503]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552648]  ww_mutex_lock+0x3d/0xa0
[    1.552733]  dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552857]  __net_devmem_dmabuf_binding_free+0x56/0xb0
[    1.552979]  skb_release_data+0x120/0x1f0
[    1.553074]  __kfree_skb+0x29/0xa0
[    1.553156]  tcp_write_queue_purge+0x41/0x310
[    1.553259]  tcp_v4_destroy_sock+0x127/0x320
[    1.553363]  ? __tcp_close+0x169/0x4b0
[    1.553452]  inet_csk_destroy_sock+0x53/0x130
[    1.553560]  __tcp_close+0x421/0x4b0
[    1.553646]  tcp_close+0x24/0x80
[    1.553724]  inet_release+0x5d/0x90
[    1.553806]  sock_close+0x4a/0xf0
[    1.553886]  __fput+0x9c/0x2b0
[    1.553960]  task_work_run+0x89/0xc0
[    1.554046]  do_exit+0x27f/0x980
[    1.554125]  do_group_exit+0xa4/0xb0
[    1.554211]  __x64_sys_exit_group+0x17/0x20
[    1.554309]  x64_sys_call+0x21a0/0x21a0
[    1.554400]  do_syscall_64+0xec/0x1d0
[    1.554487]  ? exc_page_fault+0x8a/0xf0
[    1.554585]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.554703] RIP: 0033:0x7f2f8a27abcd

Resolve this by making __net_devmem_dmabuf_binding_free schedule_work'd.

Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/devmem.c |  4 +++-
 net/core/devmem.h | 10 ++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 796338b1599e..58fcae0c0c69 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -46,8 +46,10 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
 	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
 }
 
-void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
+void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
+	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
+
 	size_t size, avail;
 
 	gen_pool_for_each_chunk(binding->chunk_pool,
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 874e891e70e0..63d16dbaca2d 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -52,6 +52,8 @@ struct net_devmem_dmabuf_binding {
 	 * net_iovs in the TX path.
 	 */
 	struct net_iov **tx_vec;
+
+	struct work_struct unbind_w;
 };
 
 #if defined(CONFIG_NET_DEVMEM)
@@ -74,7 +76,7 @@ struct dmabuf_genpool_chunk_owner {
 	struct net_devmem_dmabuf_binding *binding;
 };
 
-void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
+void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
 		       enum dma_data_direction direction,
@@ -129,7 +131,8 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 	if (!refcount_dec_and_test(&binding->ref))
 		return;
 
-	__net_devmem_dmabuf_binding_free(binding);
+	INIT_WORK(&binding->unbind_w, __net_devmem_dmabuf_binding_free);
+	schedule_work(&binding->unbind_w);
 }
 
 void net_devmem_get_net_iov(struct net_iov *niov);
@@ -161,8 +164,7 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
 {
 }
 
-static inline void
-__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
+static inline void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 }
 
-- 
2.48.1.362.g079036d154-goog

