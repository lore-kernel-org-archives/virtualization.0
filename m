Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0A6C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 08:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C6CE81EB1;
	Tue, 21 Mar 2023 08:40:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C6CE81EB1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4TGxt61
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5WnYNsl9Rzj6; Tue, 21 Mar 2023 08:40:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8D9C581BFA;
	Tue, 21 Mar 2023 08:40:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D9C581BFA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41D0CC0071;
	Tue, 21 Mar 2023 08:40:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D7A4C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EB1840017
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0EB1840017
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4TGxt61
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HnK7zvM68twF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:40:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA0BA4000B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA0BA4000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679388009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ue5AFGaReKj/xnbY98VYj9OaV+WVOdpiOY5id9iIGc=;
 b=E4TGxt61/Ug0nAzZyc1yDJZIUWESnfDFbzpCWknH33NOlJtE394HJEwWqCVfT/9KxVNzQh
 HJBzG8afsTcLBoyilZOa5686oi8WFzoecErWdGJ82s5N2sfGR70dyUTYnOpMRw4F4SLvcG
 T1EpGpfIWZFyAInSP8b4m7izQrQZWdk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-1FQpsVpuMgCUo9meVsbfig-1; Tue, 21 Mar 2023 04:40:08 -0400
X-MC-Unique: 1FQpsVpuMgCUo9meVsbfig-1
Received: by mail-qv1-f70.google.com with SMTP id
 pr2-20020a056214140200b005b3ed9328a3so7300951qvb.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 01:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679388008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ue5AFGaReKj/xnbY98VYj9OaV+WVOdpiOY5id9iIGc=;
 b=DDsGHA6W8DSst4myr3HIHFc09ol0hFUUSBND/RPncxBPA8sbz3ilRtmmmCCUosnguX
 CBQ9Wte89WwtN8S0BN7D9rtdjCGTQh9qCdTalyPgFUuqVF4Yqi/JcDd0EDXLXdgkqS3N
 z8tW4xWGZo5rZpPzQG6/KTqo6YvcK6TE4W5CFSzw6w5e/EmLiHVQ9qyP786rxdxXODZr
 A/gTWxSN6JMno3tLuDdRlUxbgseFwqdWZTa0pBIDS8oZJihevmPHf6pxKmu6kQYg/FD6
 2+y5icg4UyzbxGl2yrYHaNAYA9cnTPBgTbvTccakL5YoGkV/3pU2m7IWw8YQPxfixKIj
 SQMQ==
X-Gm-Message-State: AO0yUKWrXeROkf9bJNvoluX5RG9BB9I/tpIu11lmzH8FSAyNjtUs+kLO
 O3P9IUU1XLmpLfa2ez2heFu8hDKD+8z7hz71sA973UMr0MLDdRcfV0so/X8QDRoUnnSxhGQJW/T
 4X1d1jEk1wn0sF/y5s30sKTjzJvbD27m41KgNgy9/mg==
X-Received: by 2002:ac8:7f82:0:b0:3b8:6ae9:b10d with SMTP id
 z2-20020ac87f82000000b003b86ae9b10dmr2446535qtj.2.1679388008126; 
 Tue, 21 Mar 2023 01:40:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set8QDeZYCc7+c7IEn1uW0Jnl2bYqoqO+r68HTwXQ2vd7mj/LnUa34SC9AX/rzKtTfj6hGS72jQ==
X-Received: by 2002:ac8:7f82:0:b0:3b8:6ae9:b10d with SMTP id
 z2-20020ac87f82000000b003b86ae9b10dmr2446521qtj.2.1679388007827; 
 Tue, 21 Mar 2023 01:40:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 h12-20020ac8548c000000b003d58d0297e5sm8076455qtq.3.2023.03.21.01.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 01:40:07 -0700 (PDT)
Date: Tue, 21 Mar 2023 09:40:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3] virtio/vsock: allocate multiple skbuffs on tx
Message-ID: <20230321084002.5anjcr3ikw3ynbse@sgarzare-redhat>
References: <f33ef593-982e-2b3f-0986-6d537a3aaf08@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <f33ef593-982e-2b3f-0986-6d537a3aaf08@sberdevices.ru>
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

On Tue, Mar 21, 2023 at 12:31:48AM +0300, Arseniy Krasnov wrote:
>This adds small optimization for tx path: instead of allocating single
>skbuff on every call to transport, allocate multiple skbuff's until
>credit space allows, thus trying to send as much as possible data without
>return to af_vsock.c.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Link to v1:
> https://lore.kernel.org/netdev/2c52aa26-8181-d37a-bccd-a86bd3cbc6e1@sberdevices.ru/
> Link to v2:
> https://lore.kernel.org/netdev/ea5725eb-6cb5-cf15-2938-34e335a442fa@sberdevices.ru/
>
> Changelog:
> v1 -> v2:
> - If sent something, return number of bytes sent (even in
>   case of error). Return error only if failed to sent first
>   skbuff.
>
> v2 -> v3:
> - Handle case when transport callback returns unexpected value which
>   is not equal to 'skb->len'. Break loop.
> - Don't check for zero value of 'rest_len' before calling
>   'virtio_transport_put_credit()'. Decided to add this check directly
>   to 'virtio_transport_put_credit()' in separate patch.
>
> net/vmw_vsock/virtio_transport_common.c | 59 +++++++++++++++++++------
> 1 file changed, 45 insertions(+), 14 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 6564192e7f20..e0b2c6ecbe22 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -196,7 +196,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	const struct virtio_transport *t_ops;
> 	struct virtio_vsock_sock *vvs;
> 	u32 pkt_len = info->pkt_len;
>-	struct sk_buff *skb;
>+	u32 rest_len;
>+	int ret;
>
> 	info->type = virtio_transport_get_type(sk_vsock(vsk));
>
>@@ -216,10 +217,6 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>
> 	vvs = vsk->trans;
>
>-	/* we can send less than pkt_len bytes */
>-	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>-		pkt_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>-
> 	/* virtio_transport_get_credit might return less than pkt_len credit */
> 	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
>
>@@ -227,17 +224,51 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> 		return pkt_len;
>
>-	skb = virtio_transport_alloc_skb(info, pkt_len,
>-					 src_cid, src_port,
>-					 dst_cid, dst_port);
>-	if (!skb) {
>-		virtio_transport_put_credit(vvs, pkt_len);
>-		return -ENOMEM;
>-	}
>+	ret = 0;
>+	rest_len = pkt_len;
>+
>+	do {
>+		struct sk_buff *skb;
>+		size_t skb_len;
>+
>+		skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE, rest_len);
>+
>+		skb = virtio_transport_alloc_skb(info, skb_len,
>+						 src_cid, src_port,
>+						 dst_cid, dst_port);
>+		if (!skb) {
>+			ret = -ENOMEM;
>+			break;
>+		}
>+
>+		virtio_transport_inc_tx_pkt(vvs, skb);
>
>-	virtio_transport_inc_tx_pkt(vvs, skb);
>+		ret = t_ops->send_pkt(skb);
>
>-	return t_ops->send_pkt(skb);
>+		if (ret < 0)
>+			break;
>+
>+		/* Both virtio and vhost 'send_pkt()' returns 'skb_len',
>+		 * but for reliability use 'ret' instead of 'skb_len'.
>+		 * Also if partial send happens (e.g. 'ret' != 'skb_len')
>+		 * somehow, we break this loop, but account such returned
>+		 * value in 'virtio_transport_put_credit()'.
>+		 */
>+		rest_len -= ret;
>+
>+		if (ret != skb_len) {
>+			ret = -EFAULT;

Okay, but `ret` will be overwritten by the check we have before the
return ...

>+			break;
>+		}
>+	} while (rest_len);
>+
>+	virtio_transport_put_credit(vvs, rest_len);
>+
>+	/* Return number of bytes, if any data has been sent. */
>+	if (rest_len != pkt_len)
>+		ret = pkt_len - rest_len;

... here.

Since we don't expect this condition for now, perhaps we can avoid
setting ret with -EFAULT, but we can add a WARN_ONCE (interrupting the
loop as you did here).

This way we return the partial length as we did before.

Thanks,
Stefano

>+
>+	return ret;
> }
>
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
