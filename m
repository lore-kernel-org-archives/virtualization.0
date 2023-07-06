Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AE2EB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC8C08228A;
	Thu,  6 Jul 2023 16:51:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC8C08228A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HsLZ+nDW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wQ8QumIwEOXb; Thu,  6 Jul 2023 16:51:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8844C82281;
	Thu,  6 Jul 2023 16:51:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8844C82281
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61427C0071;
	Thu,  6 Jul 2023 16:51:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DB28C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48DC182284
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:51:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48DC182284
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xdKC8MV1Pdy6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:51:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04F9A82281
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04F9A82281
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awb+7AXpmYzXz/qezLtg4yD0Vv3mvjeFgM0SYmrlPEU=;
 b=HsLZ+nDWDBa/iWBtDeptV2UdmcW/i7aTPN9OvEFVay0ZIL5p+EPc5LBPMefqL5tSof9HCK
 ylI+N4zWDmD3ssMxcuSgw67mdenITzBgiqm7YrJNN/5wa55lDH/h71yL5UN3EJdscAUl40
 bwyMRTXyHDNF1uM3xctkbbfrLB/l2So=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-W63Pz_bIOwWQD6nUUXj7cw-1; Thu, 06 Jul 2023 12:51:18 -0400
X-MC-Unique: W63Pz_bIOwWQD6nUUXj7cw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-987e47d2e81so68926066b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662277; x=1691254277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awb+7AXpmYzXz/qezLtg4yD0Vv3mvjeFgM0SYmrlPEU=;
 b=IsYKo8SdlS3Vv38ilIHOUQ8aNRCw/PZOiICnCqg/B1CfsRzWiIG9FiDF1fZVjj2gKX
 INWpVBzAVEt7kNolHpu7HjDnz8HusMGfptqZSXifoZN7Ohpv//RBQtEFFujukBZGM1Tv
 Hls9Ic+9CO3SDMmWmaUxwqIE38U3dqX4iFkvO9FJ+cNuapM6zhd/N+Ee3fORBn+eyMOo
 +bAmWXzt+oBcZoP/T0tenI+/S/EM2RpgnAUu8ZiM0GDgf0x1rRyxvRcw2zYFZH8klhlL
 /P7ir+a+ejfStUJyZ84tKAkg7HgMol7ANJxVx5SFP5QlVyp7Bq/RIEZd/x7QFviBN1tk
 9hgQ==
X-Gm-Message-State: ABy/qLbvHfu0ik83D6lrWxIDJCq8MZG/QGzNlS5KKF+452Y0pD5BEvCv
 WCv53BIiGLDarE8EgxLz8IGUWV6qYquxKIhRxWvVryDwyualJRe0BbviB4B3yd3U9FtkpcvnqFb
 2THgnkDWpBWNmideteQir7vMrUvL5O7jI53TNLIUZCQ==
X-Received: by 2002:a17:906:7499:b0:992:630f:98b4 with SMTP id
 e25-20020a170906749900b00992630f98b4mr2090425ejl.7.1688662277388; 
 Thu, 06 Jul 2023 09:51:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcjZ/elRu3NDEvZe9dL5bPtGnyqQvkazpE91J90ogdTAnM9Wru1mlG0RExbfNcoTXT5+NKlw==
X-Received: by 2002:a17:906:7499:b0:992:630f:98b4 with SMTP id
 e25-20020a170906749900b00992630f98b4mr2090395ejl.7.1688662276897; 
 Thu, 06 Jul 2023 09:51:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 m18-20020a170906849200b0098f33157e7dsm1042403ejx.82.2023.07.06.09.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:51:16 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:51:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 04/17] vsock/virtio: non-linear skb handling for tap
Message-ID: <3klk75my4waydbvy7sa5muwattknjq2nify2myrucib5yb6maz@4a2swpu55lhv>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-5-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-5-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Sat, Jul 01, 2023 at 09:39:34AM +0300, Arseniy Krasnov wrote:
>For tap device new skb is created and data from the current skb is
>copied to it. This adds copying data from non-linear skb to new
>the skb.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Make 'skb' pointer constant because it is source.
>
> net/vmw_vsock/virtio_transport_common.c | 31 ++++++++++++++++++++++---
> 1 file changed, 28 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e5683af23e60..dfc48b56d0a2 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -106,6 +106,27 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	return NULL;
> }
>
>+static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>+						void *dst,
>+						size_t len)
>+{
>+	struct iov_iter iov_iter = { 0 };
>+	struct kvec kvec;
>+	size_t to_copy;
>+
>+	kvec.iov_base = dst;
>+	kvec.iov_len = len;
>+
>+	iov_iter.iter_type = ITER_KVEC;
>+	iov_iter.kvec = &kvec;
>+	iov_iter.nr_segs = 1;
>+
>+	to_copy = min_t(size_t, len, skb->len);
>+
>+	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
>+			       &iov_iter, to_copy);
>+}
>+
> /* Packet capture */
> static struct sk_buff *virtio_transport_build_skb(void *opaque)
> {
>@@ -114,7 +135,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	struct af_vsockmon_hdr *hdr;
> 	struct sk_buff *skb;
> 	size_t payload_len;
>-	void *payload_buf;
>
> 	/* A packet could be split to fit the RX buffer, so we can retrieve
> 	 * the payload length from the header and the buffer pointer taking
>@@ -122,7 +142,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	 */
> 	pkt_hdr = virtio_vsock_hdr(pkt);
> 	payload_len = pkt->len;
>-	payload_buf = pkt->data;
>
> 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
> 			GFP_ATOMIC);
>@@ -165,7 +184,13 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>
> 	if (payload_len) {
>-		skb_put_data(skb, payload_buf, payload_len);
>+		if (skb_is_nonlinear(pkt)) {
>+			void *data = skb_put(skb, payload_len);
>+
>+			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>+		} else {
>+			skb_put_data(skb, pkt->data, payload_len);
>+		}
> 	}
>
> 	return skb;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
