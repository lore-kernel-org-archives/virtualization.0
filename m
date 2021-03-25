Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74DFC433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:08:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D730619F2
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D730619F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0D064017A;
	Thu, 25 Mar 2021 10:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W8Tm5Y8_HkBn; Thu, 25 Mar 2021 10:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 686E0400B8;
	Thu, 25 Mar 2021 10:08:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43023C000D;
	Thu, 25 Mar 2021 10:08:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C075C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C32E405AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:08:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fRqSqUeScTP7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:08:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1121A405A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616666898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pU5HF2Zqf9J2oGlSjnzcSVRUkp00dVcRxrCu9/f0WWI=;
 b=Gw3/6l7dK6RosWaO3ZokOifZQOnqhI/gt1giNopdllKoxvfgVuYx4Q/cos6nGYxY4Tjk/D
 nbQJntAD9Fhtpd6BUWen4wL55X9YnyAHkeHnk8ahxtti+doaWcwgq3l4CsIfzkCY3uw2QA
 dNNSRgaaNMqdEIG9qzWsIzDJGVk8E08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-0MpjrsYXMNu1GEerDOPwAQ-1; Thu, 25 Mar 2021 06:08:14 -0400
X-MC-Unique: 0MpjrsYXMNu1GEerDOPwAQ-1
Received: by mail-wm1-f69.google.com with SMTP id c7so1475916wml.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 03:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pU5HF2Zqf9J2oGlSjnzcSVRUkp00dVcRxrCu9/f0WWI=;
 b=ujqIMJnDllQq0Rg59/k0/jbTTJ6dbQx3DiqMvj1maskWGJFBycWHWoBZU8Ci7XIZub
 wnswXfixOWvAK8vjCwaa1rXrHzPtDVd0W95dSLMMPC+K0LAWdtqmZDGeqIKf6M6Fa3an
 aF8w4l/Mp5HddYRdCt5Fbr8IPiS6Y7x/LNwSmZTqaJRqgoJY8ht91nGPfU+i/965oHGI
 vuCIKNa1C57qQRZGrrT9Ftsf/6oJP4CJBmdDqUI+CoVjeUBrGEorb9dHhjCk98AOyhcU
 yQzR4uVFqcTcLFva1fzXll+YwjjB3oq9u86f2krDbub49v//1YkvTv130deMaYa9//mj
 kCrQ==
X-Gm-Message-State: AOAM531sKBcZ+35JtdPhijkbEntzuMrpxVj546JTAIShtZUHgGAwe+UQ
 uG1h8r86/9lqJJ3IQ/O6EWF0N0KOx52mg8CEtIuWjhXM4KeAUWVpekHcnJiET1AB2qgchGp+17R
 aYWEQpcmWDEwJNNAJWMBMtWPcSxZjAOk4Qu1daiTNkw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr8050181wrn.346.1616666893648; 
 Thu, 25 Mar 2021 03:08:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMEBLS+WucRFXH7pX2XfS53TCF8pklH4jcshSQtgYvkIE6JYp/hse6ZXrowfH28LtmJN8axw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr8050152wrn.346.1616666893409; 
 Thu, 25 Mar 2021 03:08:13 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id i3sm6673746wra.66.2021.03.25.03.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 03:08:13 -0700 (PDT)
Date: Thu, 25 Mar 2021 11:08:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 12/22] virtio/vsock: fetch length for SEQPACKET
 record
Message-ID: <20210325100810.ygmg6vqb2f7rxoyx@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131258.2461163-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131258.2461163-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 23, 2021 at 04:12:55PM +0300, Arseny Krasnov wrote:
>This adds transport callback which tries to fetch record begin marker
>from socket's rx queue. It is called from af_vsock.c before reading data
>packets of record.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v6 -> v7:
> 1) Now 'virtio_transport_seqpacket_seq_get_len()' returns 0, if rx
>    queue of socket is empty. Else it returns length of current message
>    to handle.
> 2) If dequeue callback is called, but there is no detected length of
>    message to dequeue, EAGAIN is returned, and outer loop restarts
>    receiving.
>
> net/vmw_vsock/virtio_transport_common.c | 61 +++++++++++++++++++++++++
> 1 file changed, 61 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index a8f4326e45e8..41f05034593e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -399,6 +399,62 @@ static inline void virtio_transport_remove_pkt(struct virtio_vsock_pkt *pkt)
> 	virtio_transport_free_pkt(pkt);
> }
>
>+static size_t virtio_transport_drop_until_seq_begin(struct 
>virtio_vsock_sock *vvs)
>+{
>+	struct virtio_vsock_pkt *pkt, *n;
>+	size_t bytes_dropped = 0;
>+
>+	list_for_each_entry_safe(pkt, n, &vvs->rx_queue, list) {
>+		if (le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_SEQ_BEGIN)
>+			break;
>+
>+		bytes_dropped += le32_to_cpu(pkt->hdr.len);
>+		virtio_transport_dec_rx_pkt(vvs, pkt);
>+		virtio_transport_remove_pkt(pkt);
>+	}
>+
>+	return bytes_dropped;
>+}
>+
>+static size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk)
>+{
>+	struct virtio_vsock_seq_hdr *seq_hdr;
>+	struct virtio_vsock_sock *vvs;
>+	struct virtio_vsock_pkt *pkt;
>+	size_t bytes_dropped = 0;
>+
>+	vvs = vsk->trans;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* Have some record to process, return it's length. */
>+	if (vvs->seq_state.user_read_seq_len)
>+		goto out;
>+
>+	/* Fetch all orphaned 'RW' packets and send credit update. */
>+	bytes_dropped = virtio_transport_drop_until_seq_begin(vvs);
>+
>+	if (list_empty(&vvs->rx_queue))
>+		goto out;
>+
>+	pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+
>+	vvs->seq_state.user_read_copied = 0;
>+
>+	seq_hdr = (struct virtio_vsock_seq_hdr *)pkt->buf;
>+	vvs->seq_state.user_read_seq_len = le32_to_cpu(seq_hdr->msg_len);
>+	vvs->seq_state.curr_rx_msg_id = le32_to_cpu(seq_hdr->msg_id);
>+	virtio_transport_dec_rx_pkt(vvs, pkt);
>+	virtio_transport_remove_pkt(pkt);
>+out:
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	if (bytes_dropped)
>+		virtio_transport_send_credit_update(vsk);
>+
>+	return vvs->seq_state.user_read_seq_len;
>+}
>+
> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 						 struct msghdr *msg,
> 						 bool *msg_ready)
>@@ -522,6 +578,11 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> 	if (flags & MSG_PEEK)
> 		return -EOPNOTSUPP;
>
>+	*msg_len = virtio_transport_seqpacket_seq_get_len(vsk);
>+
>+	if (*msg_len == 0)
>+		return -EAGAIN;
>+

Okay, I see now, I think you can move this patch before the previous one 
or merge them in a single patch, it is better to review and to bisect.

As mentioned, I think we can return msg_len if 
virtio_transport_seqpacket_do_dequeue() does not fail, otherwise the 
error.

I mean something like this:

static ssize_t virtio_transport_seqpacket_do_dequeue(...)
{
	size_t msg_len;
	ssize_t ret;

	msg_len = virtio_transport_seqpacket_seq_get_len(vsk);
	if (msg_len == 0)
		return -EAGAIN;

	ret = virtio_transport_seqpacket_do_dequeue(vsk, msg, msg_ready);
	if (ret < 0)
		return ret;

	return msg_len;
}

> 	return virtio_transport_seqpacket_do_dequeue(vsk, msg, msg_ready);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>-- 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
