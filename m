Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FB2C6FD1C
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 14:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCB8183F40;
	Wed, 22 Mar 2023 14:41:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCB8183F40
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f/NCqzh4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sj3XjATkic9T; Wed, 22 Mar 2023 14:41:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 140B2821E8;
	Wed, 22 Mar 2023 14:41:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 140B2821E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE8F9C0071;
	Wed, 22 Mar 2023 14:41:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4387FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 14:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F67441B40
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 14:41:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F67441B40
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f/NCqzh4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Rs-kclV4BuZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 14:41:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8363641AE9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8363641AE9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679496082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HLKDxFolV4+rR00GX3j1Ecw4i/HFp0PPyVxu2w/0V7w=;
 b=f/NCqzh4dEh1Nub6LblWTUBdq7uP3LP9eUx/HprCkqfgANWA9dxxGu7dxHUbvUpzTo1ueG
 QTA8APOB7u/AY0zF0QCgGAutBXut37npzaeAigTdv+Oz0pSyQnWu2oG/eQLuYiFV/d5bZ/
 OYiJbnqh/x2jifYAfoATEoQP9/RzOTs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-3xjkSm29Oj2wbUjZRzxi0g-1; Wed, 22 Mar 2023 10:41:21 -0400
X-MC-Unique: 3xjkSm29Oj2wbUjZRzxi0g-1
Received: by mail-qv1-f69.google.com with SMTP id
 pr2-20020a056214140200b005b3ed9328a3so9402937qvb.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 07:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679496080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLKDxFolV4+rR00GX3j1Ecw4i/HFp0PPyVxu2w/0V7w=;
 b=YzW0uMqlUmf4K+SDeiK/LT0dImbv6Pw3RkKuKhy0OyF25ZcI5wfSxrlzzVVhBQdV0h
 mEYsByBIwkf6rmXA7snTMIYkdZNnRCfPT7Hti541jo/zZc+V7Ypieu/8Q9WgByk5LfHx
 tKuTrA5frcQZSk6eLc/8bZczBcv26YSipkVU1LE+evBfVc6gPvV+OC11OPATiql1MnE4
 iQJdKibNbgCkWGCL3a5vHoFK3Mpop5v5fpO2mMaYIPT0jmNYn7f8UhjtJnp40LhburDT
 nCnlokZsViVu6cu9Zh0kalRBe0p/T9MagPB3rN3jWAW3ethjGHi2cu7NTcWgJw0fKeTL
 uPNQ==
X-Gm-Message-State: AO0yUKWNSa9v+d0T+Fz0hvSbXTssqslrc1st234om3d4GwfWMLA2fXQD
 +2ySW/q+FC4IO1tPogHyLIdWGxcJeeQ7MKmwKSivCim8jDk1BZqpJVvbZGflzhLJhgBPh5n9yQz
 bjyTmYzdENbfgAuDjNOXlJLmKwYXHE8WKkVPU8aVsWw==
X-Received: by 2002:a05:622a:408:b0:3e1:b06d:e9e0 with SMTP id
 n8-20020a05622a040800b003e1b06de9e0mr6228372qtx.56.1679496080661; 
 Wed, 22 Mar 2023 07:41:20 -0700 (PDT)
X-Google-Smtp-Source: AK7set8/wgsKLj9GUGG1GRhMhqaCnjl30RufXTIdaJf4Ub159yWBZLYd3EzoSNVPdHZrQ/N36OqnqA==
X-Received: by 2002:a05:622a:408:b0:3e1:b06d:e9e0 with SMTP id
 n8-20020a05622a040800b003e1b06de9e0mr6228339qtx.56.1679496080406; 
 Wed, 22 Mar 2023 07:41:20 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 q21-20020ac87355000000b003e387a2fbdfsm2158689qtp.0.2023.03.22.07.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Mar 2023 07:41:19 -0700 (PDT)
Date: Wed, 22 Mar 2023 15:41:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4] virtio/vsock: allocate multiple skbuffs on tx
Message-ID: <20230322144115.sz3icgbnhjgae2fj@sgarzare-redhat>
References: <0e0c1421-7cdc-2582-b120-cad6f42824bb@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <0e0c1421-7cdc-2582-b120-cad6f42824bb@sberdevices.ru>
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

On Tue, Mar 21, 2023 at 06:03:14PM +0300, Arseniy Krasnov wrote:
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
> Link to v3:
> https://lore.kernel.org/netdev/f33ef593-982e-2b3f-0986-6d537a3aaf08@sberdevices.ru/
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
> v3 -> v4:
> - Use WARN_ONCE() to handle case when transport callback returns
>   unexpected value.
> - Remove useless 'ret = -EFAULT;' assignment for case above.
>
> net/vmw_vsock/virtio_transport_common.c | 59 +++++++++++++++++++------
> 1 file changed, 45 insertions(+), 14 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 6564192e7f20..a300f25749ea 100644
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

nit: this initialization seems superfluous since `ret` is
overwritten later ...

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
>
>-	virtio_transport_inc_tx_pkt(vvs, skb);
>+		virtio_transport_inc_tx_pkt(vvs, skb);
>
>-	return t_ops->send_pkt(skb);
>+		ret = t_ops->send_pkt(skb);

... here.

>+

nit: we can remove this extra line

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
>+		if (WARN_ONCE(ret != skb_len,
>+			      "'send_pkt()' returns %i, but %zu expected\n",
>+			      ret, skb_len))
>+			break;
>+	} while (rest_len);
>+
>+	virtio_transport_put_credit(vvs, rest_len);
>+
>+	/* Return number of bytes, if any data has been sent. */
>+	if (rest_len != pkt_len)
>+		ret = pkt_len - rest_len;
>+
>+	return ret;
> }
>
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>-- 2.25.1
>

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Anyway, feel free to include in the same series or as separate patch
also the changes to avoid useless lock in virtio_transport_put_credit()
and virtio_transport_get_credit().

I would include it in this series, because before these changes, we
used to call virtio_transport_put_credit() only in the error path,
while now we always call it, even when rest_len is 0.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
