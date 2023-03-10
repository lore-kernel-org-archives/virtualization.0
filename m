Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD22C6FD19
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 09:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50DC160F76;
	Fri, 10 Mar 2023 09:06:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50DC160F76
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A+HozW0d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7L_0R-9J7ceD; Fri, 10 Mar 2023 09:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B723B60B98;
	Fri, 10 Mar 2023 09:06:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B723B60B98
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E03EC0071;
	Fri, 10 Mar 2023 09:06:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C5DEC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDC7F60F58
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDC7F60F58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xc9AYFmClFOW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:06:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1976260B98
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1976260B98
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678439160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wz8nUvi2fGgDgewNMYegfHqQ2FX4wiXlwJl5P4TAg0M=;
 b=A+HozW0d5E9QDn7Ij5QK7Y2wJb+9Z6M6hdHrO4cQ4jl5MMx/bD6loXhOpuqvJar9OQq/8c
 eO6SFN6hKHQbO8gGoNExIW1NsKKPsOLbPajreehKoorx2YpyRqHpUW0AuqcDdppO7V7XLE
 bohiig2ihPribhf4eChbMWXQPYmuUc8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-9D424plINhygIPCn3Rve8g-1; Fri, 10 Mar 2023 04:05:58 -0500
X-MC-Unique: 9D424plINhygIPCn3Rve8g-1
Received: by mail-wr1-f72.google.com with SMTP id
 t19-20020a0560001a5300b002ce013276b8so915666wry.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 01:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678439157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wz8nUvi2fGgDgewNMYegfHqQ2FX4wiXlwJl5P4TAg0M=;
 b=q4eVA0ptxlD3mkxBSssa16nPF6JhJW36F9UcZGGC41aTU5D0F5Mg9j++jrk8/0HzFd
 yaay8cPdtbXPGdF0mCfX6DW9Se4vXQNJRNdWfpz2RDwThb0YI2EXWSDfXPvTvGPFPxZb
 BUueKT4St/lM+xUjiNeFnCMgoEASaC9s0ymWbIk5Lw0uDlcfIfB3hOwNpT4Q+koqBD+H
 Ik00jPrkLMCCtjiPP4LU78xCSZIczwu8xn+Uf+o7lWy28Bvv7yP0etn4oWtLIFPxHGDp
 Cd9SNOyodEHiw6wEE57iUir8Zf0SSgxNZFG5W8MjtREbEay8YrgZDDh3CM4X2M5cT3kk
 fPbg==
X-Gm-Message-State: AO0yUKUFXwqp/QPRAMr1riGUfxcaZeLIbUMuhr8TFkPtvdn1xa91mEC0
 ylR72odBGA/OWVWIMkwiA9WfmJ+bIlD2b2eg82u1LcQ8WNlCPN/q3XoiMc8J4kPTB/2nzPzF1+Z
 SXSroXhDSlySxVdfaK+AeqdAZZIkdFp4/XPy9Wn7xzw==
X-Received: by 2002:adf:e343:0:b0:2c7:f56:285b with SMTP id
 n3-20020adfe343000000b002c70f56285bmr16988085wrj.63.1678439157274; 
 Fri, 10 Mar 2023 01:05:57 -0800 (PST)
X-Google-Smtp-Source: AK7set/kMCf2/pJ8VDpyvGWvl95/R1kauUwT62ehT8eA6aqrdwrsYUpmjAVFex11URKqVX/AodZhVQ==
X-Received: by 2002:adf:e343:0:b0:2c7:f56:285b with SMTP id
 n3-20020adfe343000000b002c70f56285bmr16988072wrj.63.1678439157105; 
 Fri, 10 Mar 2023 01:05:57 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 a4-20020adffb84000000b002c592535839sm1624988wrr.17.2023.03.10.01.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 01:05:56 -0800 (PST)
Date: Fri, 10 Mar 2023 10:05:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 3/4] virtio/vsock: don't drop skbuff on copy failure
Message-ID: <20230310090553.mlvthrdpmehi5op5@sgarzare-redhat>
References: <1804d100-1652-d463-8627-da93cb61144e@sberdevices.ru>
 <e29e788a-51d7-f733-85a5-707044f54dd6@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <e29e788a-51d7-f733-85a5-707044f54dd6@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
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

On Thu, Mar 09, 2023 at 11:28:01PM +0300, Arseniy Krasnov wrote:
>This returns behaviour of SOCK_STREAM read as before skbuff usage. When
>copying to user fails current skbuff won't be dropped, but returned to
>sockets's queue. Technically instead of 'skb_dequeue()', 'skb_peek()' is
>called and when skbuff becomes empty, it is removed from queue by
>'__skb_unlink()'.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 9a411475e201..6564192e7f20 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -364,7 +364,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>
> 	spin_lock_bh(&vvs->rx_lock);
> 	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
>-		skb = __skb_dequeue(&vvs->rx_queue);
>+		skb = skb_peek(&vvs->rx_queue);
>
> 		bytes = len - total;
> 		if (bytes > skb->len)
>@@ -388,9 +388,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>
> 			virtio_transport_dec_rx_pkt(vvs, pkt_len);
>+			__skb_unlink(skb, &vvs->rx_queue);
> 			consume_skb(skb);
>-		} else {
>-			__skb_queue_head(&vvs->rx_queue, skb);
> 		}
> 	}
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
