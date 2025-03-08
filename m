Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113221519D
	for <virtualization@lists.linux.dev>; Sat,  8 Mar 2025 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741470060; cv=none; b=JU1GC9dwx9+GJhzjQwupUkKwOYLRyG1Dstj+c63NVBceZT+SDOeGs440ttsva3QYJhlF1tb5VE1KUi98O5ZrBx2e83yVAJnhF1av/lYVdz62bsOTxpGDeLLBASOtqg85N8uQjAA5SrNuq0dYz29PmbBcAY/O/KTmcmh5HgyjXxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741470060; c=relaxed/simple;
	bh=Waqs9wqvrVBOROjzMcSiYTjSpSVpd+3UCgCmMkkpDvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nVLpNPlEgXJ1eDO07VPizOasn8CNYPZYWxzJ6GDqpjCWHTurrTcNFLvg5KDG73uPb3Qb/GNjUbWmnNzfvSn7TdWEfbRH9EDvfFXAbKmBg7NIILH1ke4MQLiDo7x0rUqZEkvBiJugfGM+QABXN/AA7BtQBwzXmIdv4v58zoBU9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEGHjBJU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEGHjBJU"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so2429989a91.0
        for <virtualization@lists.linux.dev>; Sat, 08 Mar 2025 13:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741470055; x=1742074855; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=58V3xIMqcRJTwA4dVCAwUps2MRFlACWl18gn2/ylnO8=;
        b=CEGHjBJUKVTUyFbRKi9QwIW/1D7abgihUEWMCCYdrYclCC7QoqCazAIfHCQpSwZ7Ap
         qYu59gAxYnBQBAgRa8DJN0xQPlO+hU5AmPlYt60kPyRt52wgyej0cjrpQ2vbzHVN4LX7
         WSrXwC9XfWdGhaLZ7sUN1xMWGM0XrWaakWJ0+BWJMyV41H2TlQkXfhBA4MbxBhQLwp3F
         FS3TOcb+rHGk/Bn2yvgijFCI4djJLUoXNNVYCxtthcj+scZSMm6BaJA2eBoj8kximaR1
         PUejjFGngFHL/qt+vCOUghuvmKj1m2pI1TIUnpDFtTWAMR6P0fa2pm1ZlbuglElYb8UW
         +9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741470055; x=1742074855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58V3xIMqcRJTwA4dVCAwUps2MRFlACWl18gn2/ylnO8=;
        b=ndKQdJwQ3U8s+gaEaLYMQ3TCdQMx24PtzZE95druL69JgjxOcFKrIihhWJv+XWhm8i
         WhRO+vF19aIn78a+syv0FqY9hDcXklApe5TdyJ30YzwIKU46xsEs8329nGdL595fIZi6
         Pa2WJTONcxlTsP5s5dUxVt8khYsMlbWac0x6sRiFVyQ3P+K2IqNF3CdUOLnGI0QMu3ia
         N4xca016KWvu4WDyF9R1VnrK9YDwwTuhiqzjs6xjoWsNTywiLv57EXtvpOh9o9u+Yj3T
         tVViyTr/L/TBqGTFwZWfKn/ASOC+/xUbJOpiSt06ta6bpspWferqdOaYOCJUYNyvl1qf
         zksw==
X-Forwarded-Encrypted: i=1; AJvYcCXzzmNqTTyPkowXUCNn/7u61uRT3+xwqfeiM23UHQ5NdBsfvmr74tgR7HVdznBrook11P3kigjTnohQFETaAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxfp+wg7yIj/tHIBdhBALbMPL4kRiVCIsXhJfQG/ihmTL9L3sM1
	GN3vIfQvTM6DVW7JnbTdba2YMUgSg8Sss83FpFc7S+VQR1Aooo/eLnJZkaL7XDwStKCwktF6B2d
	nWq4n/fpepZhCHldm3L3ggw==
X-Google-Smtp-Source: AGHT+IFSb6U+tbU6T3ppbOqqdxqHzaRcKQ8NbHk2U0tmSzdSX0/NwuESjTr521WJ+R0cR10sB0m7/cPnT5827g+YgA==
X-Received: from pgbck14.prod.google.com ([2002:a05:6a02:90e:b0:af2:681:e27a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:78a8:b0:1ee:d87c:8051 with SMTP id adf61e73a8af0-1f544af83d7mr15659224637.13.1741470055464;
 Sat, 08 Mar 2025 13:40:55 -0800 (PST)
Date: Sat,  8 Mar 2025 21:40:41 +0000
In-Reply-To: <20250308214045.1160445-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308214045.1160445-6-almasrymina@google.com>
Subject: [PATCH net-next v7 5/9] net: add devmem TCP TX documentation
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

Add documentation outlining the usage and details of the devmem TCP TX
API.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v5:
- Address comments from Stan and Bagas

v4:
- Mention SO_BINDTODEVICE is recommended (me/Pavel).

v2:
- Update documentation for iov_base is the dmabuf offset (Stan)

---
 Documentation/networking/devmem.rst | 150 +++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index d95363645331..1c476522d6f5 100644
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
@@ -235,6 +235,148 @@ can be less than the tokens provided by the user in case of:
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
+to the semantics of MSG_ZEROCOPY::
+
+	setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+
+It is also recommended that the user binds the TX socket to the same interface
+the dma-buf has been bound to via SO_BINDTODEVICE::
+
+	setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifname) + 1);
+
+
+Sending data
+------------
+
+Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
+
+The user should create a msghdr where,
+
+* iov_base is set to the offset into the dmabuf to start sending from
+* iov_len is set to the number of bytes to be sent from the dmabuf
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
2.49.0.rc0.332.g42c0ae87b1-goog

