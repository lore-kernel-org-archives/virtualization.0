Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC280C636CC
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 14:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C7EE81F5D;
	Thu, 16 Feb 2023 14:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C7EE81F5D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EBDJcNW0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mWVrbPXT1-PM; Thu, 16 Feb 2023 14:30:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EA4A781F51;
	Thu, 16 Feb 2023 14:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA4A781F51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF949C0032;
	Thu, 16 Feb 2023 14:30:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98766C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 604F341014
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:30:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 604F341014
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EBDJcNW0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xFJ02xCAUF5R
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:30:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92B62402EB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92B62402EB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676557835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9oWDCNYoCRLAFAE2xiwQxbVwQjtrOQMjZPhjji0izk=;
 b=EBDJcNW0tzaNkcuBS4Kd8UdQ4+xgN+Bj4wsoU0KR2ubsgDOgxJ4ZBfy4p5bbtZIXntN9R2
 CfSlKBgUUlKxL8CozG1P+9rCPeCGkkZd0F/JQGLC3850J8ediYYZhLk0N6zmlwFiB7AL0B
 gEZmNdUC54wr8CaEp82r6C0rOMmmFZQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-189-mQCnjN-UOVuUafAzC8iCKQ-1; Thu, 16 Feb 2023 09:30:34 -0500
X-MC-Unique: mQCnjN-UOVuUafAzC8iCKQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 x14-20020a05620a14ae00b0072f7f0f356bso1295020qkj.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 06:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9oWDCNYoCRLAFAE2xiwQxbVwQjtrOQMjZPhjji0izk=;
 b=sS8R8KO8pTvLn4hi5JunW1wwOvfFNZ4ITFUSGSwSC3tiZY3Wq13cg3WiE0BsgMXu4I
 kjQkEs2RDkl47/8tOre4wHTYSIPy0CuOwOLt62yEaKZ3fYsiUCpcLlfil0fZQWnk/58W
 xtF06tw94vfjuOjMGzAJnB6hpio3slmbyhM2UC+n5QmMXg3Cx8spKFKjc+VF5ZFGoewW
 sA5Sk4kE71dgfBvL/Jm9hOPFIPdyRpT2w3AjmGotvPMMaa2vVMWRVtWShmYYceGsdhuU
 Ce1eKSNVgNk5rWuPpl4jv5mMEVSPnqO1mu6tm4ek52QTnTq9mViFv0R4Jf5uVkZhqY6H
 i3/g==
X-Gm-Message-State: AO0yUKWHKfWFPRACtAgu4n0gUv/H6/jJq+yvr7yhSmFVeAks1UKMCL0R
 04C3pkvgfzpWH4TtyWWOyvEnOWbOKFmObzVMbNc/awHloqocDDmD2Nqg5ujbx2XOvvm8oHYh0nS
 C1spLMvgzvkkHLCdHsbg+D/yX8InR3ffumW4y5cNLZg==
X-Received: by 2002:ac8:5849:0:b0:3bd:15d4:ff65 with SMTP id
 h9-20020ac85849000000b003bd15d4ff65mr661141qth.40.1676557833575; 
 Thu, 16 Feb 2023 06:30:33 -0800 (PST)
X-Google-Smtp-Source: AK7set8XJTsnTm0VaIJmbJX3VcXHUhxxi2M8Gpe8tbPNcNIuLHAOsiSc/znHPpsq3YpeBFeBz2CWkQ==
X-Received: by 2002:ac8:5849:0:b0:3bd:15d4:ff65 with SMTP id
 h9-20020ac85849000000b003bd15d4ff65mr661093qth.40.1676557833268; 
 Thu, 16 Feb 2023 06:30:33 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it.
 [82.57.51.167]) by smtp.gmail.com with ESMTPSA id
 k6-20020a378806000000b0073912c099cesm1258386qkd.73.2023.02.16.06.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 06:30:32 -0800 (PST)
Date: Thu, 16 Feb 2023 15:30:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 06/12] vsock/virtio: non-linear skb handling for
 TAP dev
Message-ID: <20230216143027.yg737u2ndiwwatm2@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <ebee740a-95df-ed52-6274-a9340e8dc9d2@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <ebee740a-95df-ed52-6274-a9340e8dc9d2@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Feb 06, 2023 at 06:59:21AM +0000, Arseniy Krasnov wrote:
>For TAP device new skb is created and data from the current skb is
>copied to it. This adds copying data from non-linear skb to new
>the skb.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 43 +++++++++++++++++++++++--
> 1 file changed, 40 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index a1581c77cf84..05ce97b967ad 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -101,6 +101,39 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	return NULL;
> }
>
>+static void virtio_transport_copy_nonlinear_skb(struct sk_buff *skb,
>+						void *dst,
>+						size_t len)
>+{
>+	size_t rest_len = len;
>+
>+	while (rest_len && virtio_vsock_skb_has_frags(skb)) {
>+		struct bio_vec *curr_vec;
>+		size_t curr_vec_end;
>+		size_t to_copy;
>+		int curr_frag;
>+		int curr_offs;
>+
>+		curr_frag = VIRTIO_VSOCK_SKB_CB(skb)->curr_frag;
>+		curr_offs = VIRTIO_VSOCK_SKB_CB(skb)->frag_off;
>+		curr_vec = &skb_shinfo(skb)->frags[curr_frag];
>+
>+		curr_vec_end = curr_vec->bv_offset + curr_vec->bv_len;
>+		to_copy = min(rest_len, (size_t)(curr_vec_end - curr_offs));
>+
>+		memcpy(dst, page_to_virt(curr_vec->bv_page) + curr_offs,
>+		       to_copy);
>+
>+		rest_len -= to_copy;
>+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off += to_copy;
>+
>+		if (VIRTIO_VSOCK_SKB_CB(skb)->frag_off == (curr_vec_end)) {
>+			VIRTIO_VSOCK_SKB_CB(skb)->curr_frag++;
>+			VIRTIO_VSOCK_SKB_CB(skb)->frag_off = 0;
>+		}
>+	}
>+}
>+
> /* Packet capture */
> static struct sk_buff *virtio_transport_build_skb(void *opaque)
> {
>@@ -109,7 +142,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	struct af_vsockmon_hdr *hdr;
> 	struct sk_buff *skb;
> 	size_t payload_len;
>-	void *payload_buf;
>
> 	/* A packet could be split to fit the RX buffer, so we can retrieve
> 	 * the payload length from the header and the buffer pointer taking
>@@ -117,7 +149,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	 */
> 	pkt_hdr = virtio_vsock_hdr(pkt);
> 	payload_len = pkt->len;
>-	payload_buf = pkt->data;
>
> 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
> 			GFP_ATOMIC);
>@@ -160,7 +191,13 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>
> 	if (payload_len) {
>-		skb_put_data(skb, payload_buf, payload_len);
>+		if (skb_is_nonlinear(skb)) {
>+			void *data = skb_put(skb, payload_len);
>+
>+			virtio_transport_copy_nonlinear_skb(skb, data, payload_len);
>+		} else {
>+			skb_put_data(skb, pkt->data, payload_len);
>+		}

Ehm I'm a bit confused. Maybe we need to rename the sk_buffs involved in
this function (pre-existing).

We have `pkt` that is the original sk_buff, and `skb` that it is 
allocated in this function, so IIUC we should check if `pkt` is 
nonlinear and copy its payload into `skb`, so we should do this 
(untested) chage:

@@ -367,10 +367,10 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
         skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));

         if (payload_len) {
-               if (skb_is_nonlinear(skb)) {
+               if (skb_is_nonlinear(pkt)) {
                         void *data = skb_put(skb, payload_len);

-                       virtio_transport_copy_nonlinear_skb(skb, data, payload_len);
+                       virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
                 } else {
                         skb_put_data(skb, pkt->data, payload_len);
                 }

Thanks,
Stefano

> 	}
>
> 	return skb;
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
