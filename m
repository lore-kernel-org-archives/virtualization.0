Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7C9C6FD19
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 16:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A4D260D65;
	Thu,  9 Mar 2023 16:30:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A4D260D65
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=chIKqAvj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rEFr7hxYXoNB; Thu,  9 Mar 2023 16:30:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 89B98607CA;
	Thu,  9 Mar 2023 16:30:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89B98607CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74376C0035;
	Thu,  9 Mar 2023 16:30:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F1AEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CBC8821E6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:30:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CBC8821E6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=chIKqAvj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41M7gUi6RJhT
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:30:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2FB1821E3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2FB1821E3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678379423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBLRuHkI1YAXHhp9FH7h8P44ZeZyI6cLn1n7/g70EHY=;
 b=chIKqAvjFRt45A1S3hDQu9J/qxwo+m8PclRZez1eCtjU16Qb32C0phIQshW6uXf+TUYkEK
 ThALYVDU0eLXTDIYegSz2tjXgvKmA5h5iAlHmNWcNMyK8UCyWODfC3xsEDzCU0kRVGsNHe
 FTIMHE0FXK1IKDZVboJna05/PJyAgBw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-U4_S6mLiOGq4uljojcr3qg-1; Thu, 09 Mar 2023 11:30:22 -0500
X-MC-Unique: U4_S6mLiOGq4uljojcr3qg-1
Received: by mail-qt1-f200.google.com with SMTP id
 z1-20020ac87ca1000000b003ba2a2c50f9so1322301qtv.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 08:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678379420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBLRuHkI1YAXHhp9FH7h8P44ZeZyI6cLn1n7/g70EHY=;
 b=4WY105JRpgrFsXhW9zT2APjT2Ix7Aa/nFVhTsdUts+LcUYXl9nP1KwOgdDy623lVvd
 BYEdwVAd2w/2JgRuIos3wLxInVd3rENNoLy8TqrA2kic8GxlZRT8Luw216cBKhY1rVzH
 H8YbVqn2NFT+FU2/TnHZRVHche46ViW2fzxnDvgnrvQvlHIVTVNAfeseFVq1HOUfSD7+
 EpJylquJd51tDVw4OxCzZWuzmgZFD9p2Egsq1F2ybpJUVkII/Y2ryY/TeIZYCg8QF/X5
 IutbDma0YkbUcBzJkVqPaZxjNK4CrtweHL4+9+TRljU6ZIErjDf/b2oidV/Ue5GD+xWo
 dKNQ==
X-Gm-Message-State: AO0yUKXb3wOPVSGH5quHkZevwSDya5PIXAg4vIw/QFMtjPwm64nNnLWJ
 uVcOheAykdYPxFfgMUPKGxGCTnLoA0fU5PDmFCv5q+116VoAfEOngHfbYx22kdOXz7R/BKc9s+0
 1PvpoJELCq0akHJrvAWl0w9TdFtX9AqTlMpyatfibkQ==
X-Received: by 2002:a05:622a:2c2:b0:3bd:140c:91ed with SMTP id
 a2-20020a05622a02c200b003bd140c91edmr31398139qtx.52.1678379419975; 
 Thu, 09 Mar 2023 08:30:19 -0800 (PST)
X-Google-Smtp-Source: AK7set+2F5YD7K/oepsMoEBVn/ZxPDtpNxoaMpPiPeM3V37KrU7smzm/aTYuFBcKJvHFaue9aD1htw==
X-Received: by 2002:a05:622a:2c2:b0:3bd:140c:91ed with SMTP id
 a2-20020a05622a02c200b003bd140c91edmr31398103qtx.52.1678379419700; 
 Thu, 09 Mar 2023 08:30:19 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 d199-20020ae9efd0000000b007423e52f9d2sm13770583qkg.71.2023.03.09.08.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 08:30:19 -0800 (PST)
Date: Thu, 9 Mar 2023 17:30:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 3/4] virtio/vsock: don't drop skbuff on copy failure
Message-ID: <20230309163014.kqpmucbksiqwblbg@sgarzare-redhat>
References: <0abeec42-a11d-3a51-453b-6acf76604f2e@sberdevices.ru>
 <d140f8c3-d7d9-89b3-94ce-207c1f7990da@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <d140f8c3-d7d9-89b3-94ce-207c1f7990da@sberdevices.ru>
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

On Thu, Mar 09, 2023 at 01:13:51PM +0300, Arseniy Krasnov wrote:
>This returns behaviour of SOCK_STREAM read as before skbuff usage. When

So we need the Fixes tag:
Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")

The patch LGTM!

Stefano

>copying to user fails current skbuff won't be dropped, but returned to
>sockets's queue. Technically instead of 'skb_dequeue()', 'skb_peek()' is
>called and when skbuff becomes empty, it is removed from queue by
>'__skb_unlink()'.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
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
