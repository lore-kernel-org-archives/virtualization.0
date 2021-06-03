Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61539C47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:56:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED1B613E3
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED1B613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC9E483F8D;
	Thu,  3 Jun 2021 14:56:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VeCNbL2qw3II; Thu,  3 Jun 2021 14:56:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6487183F7B;
	Thu,  3 Jun 2021 14:56:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 470D9C000D;
	Thu,  3 Jun 2021 14:56:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDF7BC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7BC283F8D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gJHSsEmKuGHu
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:56:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A977583F7B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622732191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goc0S/3BnSXgINaDm4Ycz9KOeQAXHuNP6jsSEIzAQsg=;
 b=VuI2UnpciToZjwiw9QLX14fQ8WDoTnhgKu3aFB4jD5fw2Cgz9SuYpAbkRF5HsZRF+wR5U/
 Xdg3Lpu3irfQWUlMag8ObI6zg1CH3DcWzP+/NoHLwqsU8ohp0WzO2o0459isggAkCORGT/
 ywCO4QgyDxKt1z6ScD0HTqIwDKqMSZk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-hvQkCDiBOJ-2gAvO3QDwVw-1; Thu, 03 Jun 2021 10:56:30 -0400
X-MC-Unique: hvQkCDiBOJ-2gAvO3QDwVw-1
Received: by mail-ed1-f72.google.com with SMTP id
 v18-20020a0564023492b029038d5ad7c8a8so3406574edc.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 07:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=goc0S/3BnSXgINaDm4Ycz9KOeQAXHuNP6jsSEIzAQsg=;
 b=LUPBt9SlwOEDo+yNSIUsvzK+grmMy52d1oxHOCHI1ZD9CxmSgHZeSeY0XyLAzuX3hf
 0oueu7TdersuM/UcmBzgtq4vRfeOJtcE4e0BQFUkSvUTH+1MHoCwmOmLcaqT+uJaH0C4
 t8xqSY2v9LANxHxD+3pS42ZW22t4MkQqnuLIL0P0GK+Y3xckBF/CrhzD696gUJjo5LFV
 CB2VRbhUuMC/rKngSnTqlndeqRTLvycp2f6E1Xr8wBEoo9hFTFZSAynXQTXWVU2fgc5b
 HlvlhrX629sQcO3Hl1Z00nkGho/76+i7qXdmapQSpj2vx4h/JoN8vnyWpLiniCm5NaHZ
 hxYw==
X-Gm-Message-State: AOAM532j07B9WqitORrbm6sakvTFzXrdv/jafkPUeQCJ/OaOoFnjl1/c
 tn+9fPEzXJaCxLFO1yE1dNXdgyeVbPPQGaLFRRYaObA4pvKbhNg70zWvOkxR3llrM/eEmT8jsJK
 gKo7SejSGLDYn72yI8KiZlZVDfIRUr3ecLY6ojVJXIA==
X-Received: by 2002:aa7:c594:: with SMTP id g20mr171116edq.193.1622732188105; 
 Thu, 03 Jun 2021 07:56:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNs8fBb3HJWsNPx4vbS0w6t0xdKecgcrrzazaCK6WjM8HGlFblxyZ501bs6But06wi3tedQQ==
X-Received: by 2002:aa7:c594:: with SMTP id g20mr171099edq.193.1622732187957; 
 Thu, 03 Jun 2021 07:56:27 -0700 (PDT)
Received: from steredhat ([5.170.129.82])
 by smtp.gmail.com with ESMTPSA id h2sm1391024edr.50.2021.06.03.07.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 07:56:27 -0700 (PDT)
Date: Thu, 3 Jun 2021 16:56:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 12/18] virtio/vsock: add SEQPACKET receive logic
Message-ID: <20210603145623.cv7cmf2zfjsx4w2t@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191824.1272172-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210520191824.1272172-1-arseny.krasnov@kaspersky.com>
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

On Thu, May 20, 2021 at 10:18:21PM +0300, Arseny Krasnov wrote:
>Update current receive logic for SEQPACKET support: performs
>check for packet and socket types on receive(if mismatch, then
>reset connection).

We also copy the flags. Please check better your commit messages.

>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v9 -> v10:
> 1) Commit message updated.
> 2) Comment updated.
> 3) Updated way to to set 'last_pkt' flags.
>
> net/vmw_vsock/virtio_transport_common.c | 30 ++++++++++++++++++++++---
> 1 file changed, 27 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 61349b2ea7fe..a6f8b0f39775 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -165,6 +165,14 @@ void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
>
>+static u16 virtio_transport_get_type(struct sock *sk)
>+{
>+	if (sk->sk_type == SOCK_STREAM)
>+		return VIRTIO_VSOCK_TYPE_STREAM;
>+	else
>+		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>+}
>+
> /* This function can only be used on connecting/connected sockets,
>  * since a socket assigned to a transport is required.
>  *
>@@ -979,13 +987,17 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 					   struct virtio_vsock_pkt, list);
>
> 		/* If there is space in the last packet queued, we copy the
>-		 * new packet in its buffer.
>+		 * new packet in its buffer(except SEQPACKET case, when we
>+		 * also check that last packet is not last packet of previous
>+		 * record).

Is better to explain why we don't do this for SEQPACKET, something like this:

		/* If there is space in the last packet queued, we copy the
		 * new packet in its buffer.
		 * We avoid this if the last packet queued has
		 * VIRTIO_VSOCK_SEQ_EOR set, because it is the delimiter
		 * of SEQPACKET record, so `pkt` is the first packet
		 * of a new record.
		 */

> 		 */
>-		if (pkt->len <= last_pkt->buf_len - last_pkt->len) {
>+		if ((pkt->len <= last_pkt->buf_len - last_pkt->len) &&
>+		    !(le32_to_cpu(last_pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)) {
> 			memcpy(last_pkt->buf + last_pkt->len, pkt->buf,
> 			       pkt->len);
> 			last_pkt->len += pkt->len;
> 			free_pkt = true;
>+			last_pkt->hdr.flags |= pkt->hdr.flags;
> 			goto out;
> 		}
> 	}
>@@ -1151,6 +1163,12 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
> 	return 0;
> }
>
>+static bool virtio_transport_valid_type(u16 type)
>+{
>+	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
>+	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
>+}
>+
> /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>  * lock.
>  */
>@@ -1176,7 +1194,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 					le32_to_cpu(pkt->hdr.buf_alloc),
> 					le32_to_cpu(pkt->hdr.fwd_cnt));
>
>-	if (le16_to_cpu(pkt->hdr.type) != VIRTIO_VSOCK_TYPE_STREAM) {
>+	if (!virtio_transport_valid_type(le16_to_cpu(pkt->hdr.type))) {
> 		(void)virtio_transport_reset_no_sock(t, pkt);
> 		goto free_pkt;
> 	}
>@@ -1193,6 +1211,12 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		}
> 	}
>
>+	if (virtio_transport_get_type(sk) != le16_to_cpu(pkt->hdr.type)) {
>+		(void)virtio_transport_reset_no_sock(t, pkt);
>+		sock_put(sk);
>+		goto free_pkt;
>+	}
>+
> 	vsk = vsock_sk(sk);
>
> 	lock_sock(sk);
>-- 
>2.25.1
>

The rest LGTM.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
