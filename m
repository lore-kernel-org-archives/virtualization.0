Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2492101B5
	for <virtualization@lists.linux.dev>; Mon,  3 Feb 2025 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622362; cv=none; b=p38MGS6xq/xdoSjgCcwHcODp7OWRYKwdjvrYS5/IPQo8MeSbS+Z1LWwP1qjTIZ61KtVxAgNmSNf7f09tgxItslGY9vxkJPzFxAuQqpgDL7+d2swvYEABn9hNdZ4Wx6/xtPMTL4riAmJ0Ao1zKygESGLxUNu4bKBtGbzsgjKTrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622362; c=relaxed/simple;
	bh=3u/7jLBYe2KfRcVNNTNkFn5t4vUJKiOG+tUb7ZrbBhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AXlo1Vx2lzb1YNfyFaVVX/B3SvRn4l2UuiXUkbYHmy7whIvfqAUWiKZ5gUAfyA2y7upgQBnpV7miqPypB+V8L96bOe+yxLClaZhXF6WeQqQLJWX4eBlpFUJGOLdSl27N13vsyihmk6P7TT7nxcCOINcowH55C1d/jDXaNzeAeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fa/YJEtt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fa/YJEtt"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21dcc9f3c8aso75295285ad.3
        for <virtualization@lists.linux.dev>; Mon, 03 Feb 2025 14:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738622359; x=1739227159; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kMF0lC9HmaCcCSq7dy1+BxkweYLRN4mbfBRIjXSD14=;
        b=Fa/YJEttYE8wuJZyjCH5buGvUfOh1f/ShondpTEzYo7SOGGonDboHYiDvGpbdqihjp
         Hpb4giRsxEGeiEg8D+MloIelp//D+X63C8jZ8hPV4hDvqrF70dJMKt3J6ulo+ISiS/U0
         MQTQYie8wGsDo5XW2V0pwi6uqNWXFRuU3YgeEiH13BC0N1hQXRsCSwXdFfcj1+7uIpX4
         9yxIMUuTGOrFoH/B0i/1mkrjk4zUHPUY6s39/d5S9XuruCbpVWiNAcMK6XTK+Q6fiI4n
         ZTtY+hjWMKPHkzJyXkSt1ChyZ+cNHZPUTJW1PIhLfeyav6MB3dssAUzFS8GavMXJDvW7
         dXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622359; x=1739227159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kMF0lC9HmaCcCSq7dy1+BxkweYLRN4mbfBRIjXSD14=;
        b=oDEB6YdWf99iNCTk0IazHaqTtHNd2DDE48TL0JOGHbwQxy3FsxAlQAQgnQJCSGIMSb
         S8+VLji95HncVqz4jncdXiKgUwguWIOvx7PsDeQw08Dr/211H1jrmu44RqT7Z3D8WUla
         ulpJBNF6mGxP0fNS+aocm1rLNNKnpv0kRPWrCdp0rKH9NG6OzG0ncWKeQPqHWTmjchuT
         yQdcKS9XbKj3IW6RyjwZI6ue/jtO9wQ/R+gTeXL1xnakHgTs7Lq5mA7c8fhxKivNg8Kt
         mUTTtqNivdQ3rLQDnigZatRpUyC1KOgTcpkTV/LfPItcvxVtENA6136meq+3+bZP9iW8
         8pzw==
X-Forwarded-Encrypted: i=1; AJvYcCWKzhuER5G5zVcdPLDmM/ldK1Lj43mizv8BLylN2T5390ctdUEV5Y28bW8DfHMhHIZYnscP0d94tpjVqZfR9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyA4R2EEg4XCCW+6b+585zIQFrfxpo2e28hvokDKb0c3TY8kU6k
	VaTF5iPpI8KLEui/34Vv4JGF4zaTeL629h1R3ea6rvwroN02/1N/d3hGttZRQFNTOvib2rcqmGX
	ORNm5GGBQlpk1l9lllbKlrQ==
X-Google-Smtp-Source: AGHT+IHb13gQXiLhCy8lu7S+LD4XF4ggchabFxgYbLgWDs+s8DOSBAGbImDSpE2rflM6SVyUqDbN1DXEF3FRb/M8sA==
X-Received: from pfbha6.prod.google.com ([2002:a05:6a00:8506:b0:72d:7a13:7a84])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:10cb:b0:725:ebab:bb2e with SMTP id d2e1a72fcca58-72fd0bfae9bmr34000927b3a.11.1738622359422;
 Mon, 03 Feb 2025 14:39:19 -0800 (PST)
Date: Mon,  3 Feb 2025 22:39:11 +0000
In-Reply-To: <20250203223916.1064540-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203223916.1064540-2-almasrymina@google.com>
Subject: [PATCH net-next v3 1/6] net: add devmem TCP TX documentation
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation outlining the usage and details of the devmem TCP TX
API.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:
- Update documentation for iov_base is the dmabuf offset (Stan)
---
 Documentation/networking/devmem.rst | 144 +++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index d95363645331..8166fe09da13 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -62,15 +62,15 @@ More Info
     https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymina@google.com/
 
 
-Interface
-=========
+RX Interface
+============
 
 
 Example
 -------
 
-tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
-the RX path of this API.
+./tools/testing/selftests/drivers/net/hw/ncdevmem:do_server shows an example of
+setting up the RX path of this API.
 
 
 NIC Setup
@@ -235,6 +235,142 @@ can be less than the tokens provided by the user in case of:
 (a) an internal kernel leak bug.
 (b) the user passed more than 1024 frags.
 
+TX Interface
+============
+
+
+Example
+-------
+
+./tools/testing/selftests/drivers/net/hw/ncdevmem:do_client shows an example of
+setting up the TX path of this API.
+
+
+NIC Setup
+---------
+
+The user must bind a TX dmabuf to a given NIC using the netlink API::
+
+        struct netdev_bind_tx_req *req = NULL;
+        struct netdev_bind_tx_rsp *rsp = NULL;
+        struct ynl_error yerr;
+
+        *ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+
+        req = netdev_bind_tx_req_alloc();
+        netdev_bind_tx_req_set_ifindex(req, ifindex);
+        netdev_bind_tx_req_set_fd(req, dmabuf_fd);
+
+        rsp = netdev_bind_tx(*ys, req);
+
+        tx_dmabuf_id = rsp->id;
+
+
+The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
+that has been bound.
+
+The user can unbind the dmabuf from the netdevice by closing the netlink socket
+that established the binding. We do this so that the binding is automatically
+unbound even if the userspace process crashes.
+
+Note that any reasonably well-behaved dmabuf from any exporter should work with
+devmem TCP, even if the dmabuf is not actually backed by devmem. An example of
+this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
+
+Socket Setup
+------------
+
+The user application must use MSG_ZEROCOPY flag when sending devmem TCP. Devmem
+cannot be copied by the kernel, so the semantics of the devmem TX are similar
+to the semantics of MSG_ZEROCOPY.
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+
+Sending data
+--------------
+
+Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
+
+The user should create a msghdr where,
+
+iov_base is set to the offset into the dmabuf to start sending from.
+iov_len is set to the number of bytes to be sent from the dmabuf.
+
+The user passes the dma-buf id to send from via the dmabuf_tx_cmsg.dmabuf_id.
+
+The example below sends 1024 bytes from offset 100 into the dmabuf, and 2048
+from offset 2000 into the dmabuf. The dmabuf to send from is tx_dmabuf_id::
+
+       char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
+       struct dmabuf_tx_cmsg ddmabuf;
+       struct msghdr msg = {};
+       struct cmsghdr *cmsg;
+       struct iovec iov[2];
+
+       iov[0].iov_base = (void*)100;
+       iov[0].iov_len = 1024;
+       iov[1].iov_base = (void*)2000;
+       iov[1].iov_len = 2048;
+
+       msg.msg_iov = iov;
+       msg.msg_iovlen = 2;
+
+       msg.msg_control = ctrl_data;
+       msg.msg_controllen = sizeof(ctrl_data);
+
+       cmsg = CMSG_FIRSTHDR(&msg);
+       cmsg->cmsg_level = SOL_SOCKET;
+       cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
+       cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
+
+       ddmabuf.dmabuf_id = tx_dmabuf_id;
+
+       *((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;
+
+       sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
+
+
+Reusing TX dmabufs
+------------------
+
+Similar to MSG_ZEROCOPY with regular memory, the user should not modify the
+contents of the dma-buf while a send operation is in progress. This is because
+the kernel does not keep a copy of the dmabuf contents. Instead, the kernel
+will pin and send data from the buffer available to the userspace.
+
+Just as in MSG_ZEROCOPY, the kernel notifies the userspace of send completions
+using MSG_ERRQUEUE::
+
+        int64_t tstop = gettimeofday_ms() + waittime_ms;
+        char control[CMSG_SPACE(100)] = {};
+        struct sock_extended_err *serr;
+        struct msghdr msg = {};
+        struct cmsghdr *cm;
+        int retries = 10;
+        __u32 hi, lo;
+
+        msg.msg_control = control;
+        msg.msg_controllen = sizeof(control);
+
+        while (gettimeofday_ms() < tstop) {
+                if (!do_poll(fd)) continue;
+
+                ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
+
+                for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+                        serr = (void *)CMSG_DATA(cm);
+
+                        hi = serr->ee_data;
+                        lo = serr->ee_info;
+
+                        fprintf(stdout, "tx complete [%d,%d]\n", lo, hi);
+                }
+        }
+
+After the associated sendmsg has been completed, the dmabuf can be reused by
+the userspace.
+
+
 Implementation & Caveats
 ========================
 
-- 
2.48.1.362.g079036d154-goog

