Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204F15444D
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722036152; cv=none; b=vDS0OuRl2kbKB5WAc9+Zg13jOxjKmdN220eyS/M/lv3U9y1OCuBrp+r/6IZz/8KAzgEr3pVrQJ0GAqdjNAyFQ2D9MvX/YeJRXfdd/U12R7bPuoKnDZctNasWQI9yGA+fZCo+uQa3Sr5tn/1ZQ3BkYLRYSxuLHjm4HgLrRcp1gFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722036152; c=relaxed/simple;
	bh=QTihwxKdNfbuodKGhHZUu2S0sWalLUNdFqu3G+fz6vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nnv3IxPbFlKQPmeLnFPYAOo7m/5YtwCXcK4ft1v7Vfc3rwFedV8rI3R0KFfG/5Sgvc9cIuqLmvaStgF+adr5w42t5YcZ7EZEPw+/oB4vEMzMPEFsAoOXzwg0igPXO/92u5nXUsHrOpbQFgrr6eCqtSDbPBYGhYxjNVEIrxAHOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdGiQxPL; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdGiQxPL"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 681EA40D6B
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 23:22:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uRZfbZZqp96X for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Jul 2024 23:22:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b35; helo=mail-yb1-xb35.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 09FE540BF3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09FE540BF3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DdGiQxPL
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09FE540BF3
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 23:22:28 +0000 (UTC)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso211067276.0
        for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 16:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722036147; x=1722640947; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v48RWsL/8+kJWmWAAV3oUELstcaxL2EQr9QFsJ90o4=;
        b=DdGiQxPLsKb3g29BUqVX30DiDUtTo1uHxBqBDK8dGkG2XcRQ/e1HqwJO0EwSvkYjQ7
         OYlpVUSpBaOs9FAXOyKFfpgR/tdRxeSYn6uyPOavOdZb+CugSWItD8pUXkzHaFd6I8s5
         tQaCzBRoAYNDO3XmOIwv8of73L/lfviBVZV9U/St5MGXSXzOHzIkb9FlFN0UtcnZX7Di
         2pu8Y0BQW/2bCg+Is49anIoMgvRJyl5a6JGI285aF+v/04cwsFb5/n780RF/c6DABZL7
         yAF7QXoBWDtLrJ2+TKuH80YtPfHrl59bgPJdVZbw8xgrieAAA0bfGzTXwZwhOFb3JoQd
         66+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722036147; x=1722640947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v48RWsL/8+kJWmWAAV3oUELstcaxL2EQr9QFsJ90o4=;
        b=trMPhXXlcc3h2CD4lmWAmtpfiiJ1Kc0AoZS6t9ruutnRE5RAA0iNeLtvSXRJX/dqCK
         kp6zVmicbrDJiHtow79RNbVMD/dO44zXnTcztN8y1DLBXCcubM0Hep/9RY8cW7NeIsJT
         NDqzrMhf2rJ/4N/o1VEK3vRQMrhMGPSoqjiqw/L1juJKg4he5XPepRYcGVIriXzlNZp9
         se/llirZIkodyPpcTWs+m4wow5X7m6lGqPAFLmtYz7LOPELypktnckj706ujMz84o55j
         1Sxhw+pcXhvGXheFTw43URcQr43paL4zml2dYg4pE77kOiYyI3ym1Y5G6UuZQ4Jzt7So
         hf/w==
X-Forwarded-Encrypted: i=1; AJvYcCVTBrokXfQLGILM03DUYvIZW84GKI68WpkH1XBzzvzdB+9HEl4OFjw1s4YfB0ryZ85IT71egmyCfrT+Cpb3pmDMLxFPl9rinjeZDUdbVbTfxCsAMDZvyo1Lqw==
X-Gm-Message-State: AOJu0YyO+CDXvWYwsYthGJaY066ANk1/gSsMa3/dGfPuR6K+usxo5oU5
	peQY0UBP7nO9ExtXfKwqzWKF4iyHL0Uc2wlEoKq2ssO/5NmAmqco9FR4wFgI3vBOcsR1ILu3tKk
	5gu6N+pRBwkPT1ng7+q1aTd+i/4o=
X-Google-Smtp-Source: AGHT+IE8eQ8lHv0aThBvkkelmXblMeJEqsMKM3GoNmG5ryHhqvDYjHXResG10v+ubvnoi/etG44LWQwWd+owOufroPA=
X-Received: by 2002:a25:8907:0:b0:e08:5ee3:7a03 with SMTP id
 3f1490d57ef6-e0b5447b082mr1495365276.22.1722036147014; Fri, 26 Jul 2024
 16:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-8-amery.hung@bytedance.com> <bpb36dtlbs6osr5cudvwrbagt7bls3cllg35lsusrly5pxwe7o@kjphrbuc64ix>
In-Reply-To: <bpb36dtlbs6osr5cudvwrbagt7bls3cllg35lsusrly5pxwe7o@kjphrbuc64ix>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 26 Jul 2024 16:22:16 -0700
Message-ID: <CAMB2axPwUV9EusNPaemLVx5NN2_1wkq0ney4NazAj7P+WRo=NQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 07/14] virtio/vsock: add common datagram
 send path
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, bryantan@vmware.com, 
	vdasa@vmware.com, pv-drivers@vmware.com, dan.carpenter@linaro.org, 
	simon.horman@corigine.com, oxffffaa@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:42=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Jul 10, 2024 at 09:25:48PM GMT, Amery Hung wrote:
> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >
> >This commit implements the common function
> >virtio_transport_dgram_enqueue for enqueueing datagrams. It does not add
> >usage in either vhost or virtio yet.
> >
> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> >---
> > include/linux/virtio_vsock.h            |  1 +
> > include/net/af_vsock.h                  |  2 +
> > net/vmw_vsock/af_vsock.c                |  2 +-
> > net/vmw_vsock/virtio_transport_common.c | 87 ++++++++++++++++++++++++-
> > 4 files changed, 90 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >index f749a066af46..4408749febd2 100644
> >--- a/include/linux/virtio_vsock.h
> >+++ b/include/linux/virtio_vsock.h
> >@@ -152,6 +152,7 @@ struct virtio_vsock_pkt_info {
> >       u16 op;
> >       u32 flags;
> >       bool reply;
> >+      u8 remote_flags;
> > };
> >
> > struct virtio_transport {
> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >index 44db8f2c507d..6e97d344ac75 100644
> >--- a/include/net/af_vsock.h
> >+++ b/include/net/af_vsock.h
> >@@ -216,6 +216,8 @@ void vsock_for_each_connected_socket(struct vsock_tr=
ansport *transport,
> >                                    void (*fn)(struct sock *sk));
> > int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *p=
sk);
> > bool vsock_find_cid(unsigned int cid);
> >+const struct vsock_transport *vsock_dgram_lookup_transport(unsigned int=
 cid,
> >+                                                         __u8 flags);
>
> Why __u8 and not just u8?
>

Will change to u8.

>
> >
> > struct vsock_skb_cb {
> >       unsigned int src_cid;
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index ab08cd81720e..f83b655fdbe9 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -487,7 +487,7 @@ vsock_connectible_lookup_transport(unsigned int cid,=
 __u8 flags)
> >       return transport;
> > }
> >
> >-static const struct vsock_transport *
> >+const struct vsock_transport *
> > vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
> > {
> >       const struct vsock_transport *transport;
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index a1c76836d798..46cd1807f8e3 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1040,13 +1040,98 @@ int virtio_transport_shutdown(struct vsock_sock =
*vsk, int mode)
> > }
> > EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
> >
> >+static int virtio_transport_dgram_send_pkt_info(struct vsock_sock *vsk,
> >+                                              struct virtio_vsock_pkt_i=
nfo *info)
> >+{
> >+      u32 src_cid, src_port, dst_cid, dst_port;
> >+      const struct vsock_transport *transport;
> >+      const struct virtio_transport *t_ops;
> >+      struct sock *sk =3D sk_vsock(vsk);
> >+      struct virtio_vsock_hdr *hdr;
> >+      struct sk_buff *skb;
> >+      void *payload;
> >+      int noblock =3D 0;
> >+      int err;
> >+
> >+      info->type =3D virtio_transport_get_type(sk_vsock(vsk));
> >+
> >+      if (info->pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> >+              return -EMSGSIZE;
> >+
> >+      transport =3D vsock_dgram_lookup_transport(info->remote_cid, info=
->remote_flags);
>
> Can `transport` be null?
>
> I don't understand why we are calling vsock_dgram_lookup_transport()
> again. Didn't we already do that in vsock_dgram_sendmsg()?
>

transport should be valid here since we null-checked it in
vsock_dgram_sendmsg(). The reason vsock_dgram_lookup_transport() is
called again here is we don't have the transport when we called into
transport->dgram_enqueue(). I can also instead add transport to the
argument of dgram_enqueue() to eliminate this redundant lookup.

> Also should we add a comment mentioning that we can't use
> virtio_transport_get_ops()? IIUC becuase the vsk can be not assigned
> to a specific transport, right?
>

Correct. For virtio dgram socket, transport is not assigned unless
vsock_dgram_connect() is called. I will add a comment here explaining
this.

> >+      t_ops =3D container_of(transport, struct virtio_transport, transp=
ort);
> >+      if (unlikely(!t_ops))
> >+              return -EFAULT;
> >+
> >+      if (info->msg)
> >+              noblock =3D info->msg->msg_flags & MSG_DONTWAIT;
> >+
> >+      /* Use sock_alloc_send_skb to throttle by sk_sndbuf. This helps a=
void
> >+       * triggering the OOM.
> >+       */
> >+      skb =3D sock_alloc_send_skb(sk, info->pkt_len + VIRTIO_VSOCK_SKB_=
HEADROOM,
> >+                                noblock, &err);
> >+      if (!skb)
> >+              return err;
> >+
> >+      skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
> >+
> >+      src_cid =3D t_ops->transport.get_local_cid();
> >+      src_port =3D vsk->local_addr.svm_port;
> >+      dst_cid =3D info->remote_cid;
> >+      dst_port =3D info->remote_port;
> >+
> >+      hdr =3D virtio_vsock_hdr(skb);
> >+      hdr->type       =3D cpu_to_le16(info->type);
> >+      hdr->op         =3D cpu_to_le16(info->op);
> >+      hdr->src_cid    =3D cpu_to_le64(src_cid);
> >+      hdr->dst_cid    =3D cpu_to_le64(dst_cid);
> >+      hdr->src_port   =3D cpu_to_le32(src_port);
> >+      hdr->dst_port   =3D cpu_to_le32(dst_port);
> >+      hdr->flags      =3D cpu_to_le32(info->flags);
> >+      hdr->len        =3D cpu_to_le32(info->pkt_len);
> >+
> >+      if (info->msg && info->pkt_len > 0) {
> >+              payload =3D skb_put(skb, info->pkt_len);
> >+              err =3D memcpy_from_msg(payload, info->msg, info->pkt_len=
);
> >+              if (err)
> >+                      goto out;
> >+      }
> >+
> >+      trace_virtio_transport_alloc_pkt(src_cid, src_port,
> >+                                       dst_cid, dst_port,
> >+                                       info->pkt_len,
> >+                                       info->type,
> >+                                       info->op,
> >+                                       info->flags,
> >+                                       false);
> >+
> >+      return t_ops->send_pkt(skb);
> >+out:
> >+      kfree_skb(skb);
> >+      return err;
> >+}
> >+
> > int
> > virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
> >                              struct sockaddr_vm *remote_addr,
> >                              struct msghdr *msg,
> >                              size_t dgram_len)
> > {
> >-      return -EOPNOTSUPP;
> >+      /* Here we are only using the info struct to retain style uniform=
ity
> >+       * and to ease future refactoring and merging.
> >+       */
> >+      struct virtio_vsock_pkt_info info =3D {
> >+              .op =3D VIRTIO_VSOCK_OP_RW,
> >+              .remote_cid =3D remote_addr->svm_cid,
> >+              .remote_port =3D remote_addr->svm_port,
> >+              .remote_flags =3D remote_addr->svm_flags,
> >+              .msg =3D msg,
> >+              .vsk =3D vsk,
> >+              .pkt_len =3D dgram_len,
> >+      };
> >+
> >+      return virtio_transport_dgram_send_pkt_info(vsk, &info);
> > }
> > EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
> >
> >--
> >2.20.1
> >
>
