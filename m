Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF92C47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:45:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A998613D8
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A998613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6684608F6;
	Thu,  3 Jun 2021 14:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mAWdMG1vr0Fd; Thu,  3 Jun 2021 14:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD35D605EA;
	Thu,  3 Jun 2021 14:45:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91B15C000D;
	Thu,  3 Jun 2021 14:45:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 328B5C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13F4740530
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wm7zt-j17ew2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:45:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29ECF40521
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622731529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YABTD2STAWQQlm5tg1g6NJ074ZuyxPbxn7absUYPnjc=;
 b=QyR8cxBKInIfBE4sOJvhkDWWSZ1jRV0HxMQN626E5Dd146/Gm0LXgTO/Yta1BntsTz7m3y
 c8ClnKogQPY3Hiaq2jwObkNP5MSvNvhqAp+LcvAqEn7oKso7Zy7WaAzzQLNETW/ONa+vdG
 gmNpeFCNdqK3rtHmesHcRCqXv5U8Zmk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-p8764vAUPgONGSfGRNyDxA-1; Thu, 03 Jun 2021 10:45:20 -0400
X-MC-Unique: p8764vAUPgONGSfGRNyDxA-1
Received: by mail-ed1-f69.google.com with SMTP id
 c21-20020a0564021015b029038c3f08ce5aso3395140edu.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 07:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YABTD2STAWQQlm5tg1g6NJ074ZuyxPbxn7absUYPnjc=;
 b=aTTCzSaUQWuQPnuxvT9mFfLmP6p7F3mR8JoH2jXaIgQBnXNsX3+kLiKlcqvHO4VN0h
 KlIcljchnjOwVlnqljE8VGsu77zI5UM3aHmAp+yAT3LMiSVAHDPtT+N8noKIHS+od0NC
 nwqyAB8B9hp6PgpevBeWRUMwAZnQGbwgznWAj/iBKsu8+OedFTMbptb0wp56fuI3/tiK
 LgHg+Y4TPBkQsojK6XKBUeaMMNvc7k9PFgIE+a3DTJu7pYBHsom2g5vJRdoYV9qoaCSU
 qXupmFbkp05WzjmaW+FpDAuWerM7cBi2RY5vOOwsTs6WfMye2y2d3vxECnqLkIvPCOPN
 I3MQ==
X-Gm-Message-State: AOAM533N8cNiNlsvtOXv6Thau3cOENo0QCUdjOwb2ZVZSufOJmGmerqw
 eNLMdr9UiXy9Kmr4/0mtHFELzgGKVmPDqges8YwCCBCyA93O5TCfLuj6Cyd9WSWp/9ke/NgIDMS
 hNKXDYcpOHSGiwQKfBUmbx4XNwRmXcPJiDxDj7+Hihw==
X-Received: by 2002:a50:afe4:: with SMTP id h91mr203600edd.28.1622731518863;
 Thu, 03 Jun 2021 07:45:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJXKlXoitE1mjpn8GN6FD+0N7T0+mjhG0D3VTzD5XyuA6+OeMMiJZX3H1kZB9DlLneqf+VlA==
X-Received: by 2002:a50:afe4:: with SMTP id h91mr203573edd.28.1622731518678;
 Thu, 03 Jun 2021 07:45:18 -0700 (PDT)
Received: from steredhat ([5.170.129.82])
 by smtp.gmail.com with ESMTPSA id bh3sm1622721ejb.19.2021.06.03.07.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 07:45:17 -0700 (PDT)
Date: Thu, 3 Jun 2021 16:45:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 11/18] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210603144513.ryjzauq7abnjogu3@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191801.1272027-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210520191801.1272027-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 20, 2021 at 10:17:58PM +0300, Arseny Krasnov wrote:
>Callback fetches RW packets from rx queue of socket until whole record
>is copied(if user's buffer is full, user is not woken up). This is done
>to not stall sender, because if we wake up user and it leaves syscall,
>nobody will send credit update for rest of record, and sender will wait
>for next enter of read syscall at receiver's side. So if user buffer is
>full, we just send credit update and drop data.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v9 -> v10:
> 1) Number of dequeued bytes incremented even in case when
>    user's buffer is full.
> 2) Use 'msg_data_left()' instead of direct access to 'msg_hdr'.
> 3) Rename variable 'err' to 'dequeued_len', in case of error
>    it has negative value.
>
> include/linux/virtio_vsock.h            |  5 ++
> net/vmw_vsock/virtio_transport_common.c | 65 +++++++++++++++++++++++++
> 2 files changed, 70 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index dc636b727179..02acf6e9ae04 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -80,6 +80,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+ssize_t
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   int flags,
>+				   bool *msg_ready);
> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ad0d34d41444..61349b2ea7fe 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -393,6 +393,59 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>+						 struct msghdr *msg,
>+						 int flags,
>+						 bool *msg_ready)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct virtio_vsock_pkt *pkt;
>+	int dequeued_len = 0;
>+	size_t user_buf_len = msg_data_left(msg);
>+
>+	*msg_ready = false;
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	while (!*msg_ready && !list_empty(&vvs->rx_queue) && dequeued_len >= 0) {

I'

>+		size_t bytes_to_copy;
>+		size_t pkt_len;
>+
>+		pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+		pkt_len = (size_t)le32_to_cpu(pkt->hdr.len);
>+		bytes_to_copy = min(user_buf_len, pkt_len);
>+
>+		if (bytes_to_copy) {
>+			/* sk_lock is held by caller so no one else can dequeue.
>+			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+			 */
>+			spin_unlock_bh(&vvs->rx_lock);
>+
>+			if (memcpy_to_msg(msg, pkt->buf, bytes_to_copy))
>+				dequeued_len = -EINVAL;

I think here is better to return the error returned by memcpy_to_msg(), 
as we do in the other place where we use memcpy_to_msg().

I mean something like this:
			err = memcpy_to_msgmsg, pkt->buf, bytes_to_copy);
			if (err)
				dequeued_len = err;

>+			else
>+				user_buf_len -= bytes_to_copy;
>+
>+			spin_lock_bh(&vvs->rx_lock);
>+		}
>+

Maybe here we can simply break the cycle if we have an error:
		if (dequeued_len < 0)
			break;

Or we can refactor a bit, simplifying the while() condition and also the 
code in this way (not tested):

	while (!*msg_ready && !list_empty(&vvs->rx_queue)) {
		...

		if (bytes_to_copy) {
			int err;

			/* ...
			*/
			spin_unlock_bh(&vvs->rx_lock);
			err = memcpy_to_msgmsg, pkt->buf, bytes_to_copy);
			if (err) {
				dequeued_len = err;
				goto out;
			}
			spin_lock_bh(&vvs->rx_lock);

			user_buf_len -= bytes_to_copy;
		}

		dequeued_len += pkt_len;

		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
			*msg_ready = true;

		virtio_transport_dec_rx_pkt(vvs, pkt);
		list_del(&pkt->list);
		virtio_transport_free_pkt(pkt);
	}

out:
	spin_unlock_bh(&vvs->rx_lock);

	virtio_transport_send_credit_update(vsk);

	return dequeued_len;
}

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
