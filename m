Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB3BC433ED
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:56:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1DE60233
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1DE60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 159E740389;
	Wed, 21 Apr 2021 08:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T2bTV_KpSlLL; Wed, 21 Apr 2021 08:56:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90B5140279;
	Wed, 21 Apr 2021 08:56:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C289C000E;
	Wed, 21 Apr 2021 08:56:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA426C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8EBD40387
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id doDB9tCeOzad
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:56:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8987D40279
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618995411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEt58VbFvs2xemicT0zBRkhdh8N6/jqkICXkVkT9euM=;
 b=cZm+KwkLdm0d34/aLSayBy99G+aWAf80SXiafy1XhW52uIk/VN7+8IPBN+lumBns+TY+2H
 252mrKhcK5qQU2XAqXyUUQQ5/CD+94da5ZE4LZ1Bvz+GmLOuShBWbHlS8BtahU5AOJprHn
 DHXURcvzF8PVif3tY/2MIO9PrANB5Xg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-ZDxvmY9UMpOHPKulWgO3Iw-1; Wed, 21 Apr 2021 04:56:49 -0400
X-MC-Unique: ZDxvmY9UMpOHPKulWgO3Iw-1
Received: by mail-ed1-f69.google.com with SMTP id
 r14-20020a50d68e0000b0290385504d6e4eso4722910edi.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 01:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SEt58VbFvs2xemicT0zBRkhdh8N6/jqkICXkVkT9euM=;
 b=IZrAIf0LZ/f/6re3N7DpjXvy2gYbKhmKJc4hD4dRhUUUcuPs+E/7h2dLVr4//chuoR
 5TpWji0aMufz166R3iy0RsW0romCkUtyaTbuAnQyMU/aDgnoS61nNsfr7HrIiXVDsGpN
 Zz+9ghb55j/mipyy5Kr3jwYMPl1MZRzvDeMAve0mYUC9M/sNaSK4JmD0zhE1eLbbxCQv
 0JSkkUhxUYLA2mtVEKLjxFZOkogihk5+5QD5DXXCHZ/5LqsNlQ+g2oSIyF+O6mrORcfM
 NZPZTjpoQWmkxrKhHucr6ZLTzPL8gB4dwHj7WI6K7rwuVe37GXIzJu0NnDurTc9zk9LK
 gH3g==
X-Gm-Message-State: AOAM532qsW2pJPA4nzzQNHPyvR1BR2yCskxKERYsCr7v8/Q3Oq9tXqjf
 /EryKFZbOFHnuHH7g98qixsfjJm2GbW7hNuTNzFQX3QuFPsxQ08+q/q6wLZEVMB2GEo88tOwhIf
 FIqaQencSSp+ryxDSKYMc0h5D/CJ7fPfGiviaJw2HrQ==
X-Received: by 2002:a05:6402:3079:: with SMTP id
 bs25mr37112003edb.369.1618995408385; 
 Wed, 21 Apr 2021 01:56:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVKAFDOm/ut3DgHKQpFeoviJZKXQkE7zcUV8M8seOk13Zkiub5ZYnl8jEUrk51HHxRRca4Uw==
X-Received: by 2002:a05:6402:3079:: with SMTP id
 bs25mr37111975edb.369.1618995408182; 
 Wed, 21 Apr 2021 01:56:48 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id w1sm2452811edt.89.2021.04.21.01.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 01:56:47 -0700 (PDT)
Date: Wed, 21 Apr 2021 10:56:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 11/19] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <CAGxU2F7pCfVow7B5KG4hSYjxyH2LcL3wriRvrgURTxeqzn8M9A@mail.gmail.com>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210413124443.3403382-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210413124443.3403382-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp <stsp2@yandex.ru>, kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, netdev <netdev@vger.kernel.org>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Apr 13, 2021 at 03:44:40PM +0300, Arseny Krasnov wrote:
>This adds transport callback and it's logic for SEQPACKET dequeue.
>Callback fetches RW packets from rx queue of socket until whole record
>is copied(if user's buffer is full, user is not woken up). This is done
>to not stall sender, because if we wake up user and it leaves syscall,
>nobody will send credit update for rest of record, and sender will wait
>for next enter of read syscall at receiver's side. So if user buffer is
>full, we just send credit update and drop data.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
>v7 -> v8:
> - Things like SEQ_BEGIN, SEQ_END, 'msg_len' and 'msg_id' now removed.
>   This callback fetches and copies RW packets to user's buffer, until
>   last packet of message found(this packet is marked in 'flags' field
>   of header).
>
> include/linux/virtio_vsock.h            |  5 ++
> net/vmw_vsock/virtio_transport_common.c | 73 +++++++++++++++++++++++++
> 2 files changed, 78 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index dc636b727179..02acf6e9ae04 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -80,6 +80,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>                              struct msghdr *msg,
>                              size_t len, int flags);
>
>+ssize_t
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+                                 struct msghdr *msg,
>+                                 int flags,
>+                                 bool *msg_ready);
> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 833104b71a1c..8492b8bd5df5 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -393,6 +393,67 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>       return err;
> }
>
>+static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>+                                               struct msghdr *msg,
>+                                               int flags,
>+                                               bool *msg_ready)
>+{
>+      struct virtio_vsock_sock *vvs = vsk->trans;
>+      struct virtio_vsock_pkt *pkt;
>+      int err = 0;
>+      size_t user_buf_len = msg->msg_iter.count;
>+
>+      *msg_ready = false;
>+      spin_lock_bh(&vvs->rx_lock);
>+
>+      while (!*msg_ready && !list_empty(&vvs->rx_queue) && err >= 0) {
>+              pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+
>+              if (le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_RW) {

Is this check still necessary, should they all be RW?

>+                      size_t bytes_to_copy;
>+                      size_t pkt_len;
>+
>+                      pkt_len = (size_t)le32_to_cpu(pkt->hdr.len);
>+                      bytes_to_copy = min(user_buf_len, pkt_len);
>+

If bytes_to_copy == 0, we can avoid the next steps (release the lock try 
to copy 0 bytes, reacquire the lock)

>+                      /* sk_lock is held by caller so no one else can dequeue.
>+                       * Unlock rx_lock since memcpy_to_msg() may sleep.
>+                       */
>+                      spin_unlock_bh(&vvs->rx_lock);
>+
>+                      if (memcpy_to_msg(msg, pkt->buf, bytes_to_copy)) {
>+                              err = -EINVAL;

Here we should reacquire the lock or prevent it from being released out
of cycle.

>+                              break;
>+                      }
>+
>+                      spin_lock_bh(&vvs->rx_lock);
>+

As mentioned before, I think we could move this part into the core and 
here always return the real dimension.

>+                      /* If user sets 'MSG_TRUNC' we return real 
>length
>+                       * of message.
>+                       */
>+                      if (flags & MSG_TRUNC)
>+                              err += pkt_len;
>+                      else
>+                              err += bytes_to_copy;
>+
>+                      user_buf_len -= bytes_to_copy;
>+
>+                      if (pkt->hdr.flags & VIRTIO_VSOCK_SEQ_EOR)
                                     ^
We should use le32_to_cpu() to read the flags.


>+                              *msg_ready = true;
>+              }
>+
>+              virtio_transport_dec_rx_pkt(vvs, pkt);
>+              list_del(&pkt->list);
>+              virtio_transport_free_pkt(pkt);
>+      }
>+
>+      spin_unlock_bh(&vvs->rx_lock);
>+
>+      virtio_transport_send_credit_update(vsk);
>+
>+      return err;
>+}
>+
> ssize_t
> virtio_transport_stream_dequeue(struct vsock_sock *vsk,
>                               struct msghdr *msg,
>@@ -405,6 +466,18 @@ virtio_transport_stream_dequeue(struct vsock_sock *vsk,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_stream_dequeue);
>
>+ssize_t
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+                                 struct msghdr *msg,
>+                                 int flags, bool *msg_ready)
>+{
>+      if (flags & MSG_PEEK)
>+              return -EOPNOTSUPP;
>+
>+      return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags,
>msg_ready);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>+
> int
> virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>                              struct msghdr *msg,
>--
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
