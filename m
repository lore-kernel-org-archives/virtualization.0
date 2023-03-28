Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA361C76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 07:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A74D402C1;
	Tue, 28 Mar 2023 07:58:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A74D402C1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QructXAp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oDoLDoyB-MoN; Tue, 28 Mar 2023 07:58:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F76F402B5;
	Tue, 28 Mar 2023 07:58:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F76F402B5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC36C0037;
	Tue, 28 Mar 2023 07:58:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22BC0C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 07:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDE726115D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 07:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDE726115D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QructXAp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vk0Hg30reNKl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 07:58:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6DD16105C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6DD16105C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679990287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zX64wamSvcuBg/+n8EW5C/QE8JCYba2x9NZLoF8LKOI=;
 b=QructXApXTiSuLD9AMSFAiTXvHMzTX7Piz/Io9gUT2Y0O7H0LDUKMKV6LQjk8wHa/LbZZC
 VmSK4Jzq5rOAMv2pnDBHHCtp7ELseboumrDmc6Bwn4K3/OyNH+UVp3yWtcns4yQEw0XjXK
 h5C9BUiNHZM4LWyx/UqeaE2IFCtmQ4g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-5PnA8jBbNx2265EBlxO1RA-1; Tue, 28 Mar 2023 03:58:06 -0400
X-MC-Unique: 5PnA8jBbNx2265EBlxO1RA-1
Received: by mail-qv1-f69.google.com with SMTP id
 m3-20020a0cbf03000000b005de7233ca79so2562106qvi.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 00:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679990285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zX64wamSvcuBg/+n8EW5C/QE8JCYba2x9NZLoF8LKOI=;
 b=XTjzCXVBUm5NinHi7QJE9gJ9yofhlKUEO0KkdiVldMHuihF714YTcIHGtdBXQQ3g+o
 AwFIhcFvfHaxKXO4qTQW/iXfRsofHTf0X3QVEILjB98TBaO9IEtgynRHILlHQGTi4wd5
 XtWfQnRXwPGDwzML/pYVCYFsFpKSKW3RqMzpNfNuE6Qq7UQvA35FT/DlRC/DB6nFHSc0
 88LNk9x/qtFc/f63K6a6P050e/Tj6PCubxNqB7VeglsFTl9AvnTtjhXPxmLbjM4PjBR9
 QhyKcTXjTgk22L/y9nCW0/9rPU0RLbTe9IuNt3LzzNiHkpMuCKyVwuX7taXS4kaUkSqW
 1EIQ==
X-Gm-Message-State: AO0yUKUhoqXhz9RyZ3+uWKxAsmo/CbPeiFlZ80FSjLoWlHEo1qO3x+cu
 srdaP2Z+4HIRdwDAvdqxXimIdnyXtmGIdCLlgtWeBoLOvRBHYgMpArDt6bEJt0JwJBzpSo6G+Rr
 n3C4kRCMJhyuNRvKopRTVxz4OOs3wl5FcgJleouqc/Q==
X-Received: by 2002:ac8:584e:0:b0:3d3:95fd:9085 with SMTP id
 h14-20020ac8584e000000b003d395fd9085mr25956579qth.42.1679990285642; 
 Tue, 28 Mar 2023 00:58:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350a8LN3HbXJ4yvKz19Oadd4R8pyBHJFdmxnmtbIae9l3nU8wgRH2HBkaFmqmIFsJT4IA1NyyBw==
X-Received: by 2002:ac8:584e:0:b0:3d3:95fd:9085 with SMTP id
 h14-20020ac8584e000000b003d395fd9085mr25956565qth.42.1679990285424; 
 Tue, 28 Mar 2023 00:58:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 h20-20020ac85154000000b003e4e1dbdcc3sm2122686qtn.47.2023.03.28.00.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 00:58:05 -0700 (PDT)
Date: Tue, 28 Mar 2023 09:58:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net] virtio/vsock: fix leak due to missing skb owner
Message-ID: <jinx5oduhddyyaxnreey2riem3s7ju5zuszddmoiie6dcnyiiy@fr4cg33vi7aq>
References: <20230327-vsock-fix-leak-v1-1-3fede367105f@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230327-vsock-fix-leak-v1-1-3fede367105f@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>,
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

On Mon, Mar 27, 2023 at 10:01:05PM +0000, Bobby Eshleman wrote:
>This patch sets the owner for the skb when being sent from a socket and
>so solves the leak caused when virtio_transport_purge_skbs() finds
>skb->sk is always NULL and therefore never matches it with the current
>socket. Setting the owner upon allocation fixes this.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
>Link: https://lore.kernel.org/all/ZCCbATwov4U+GBUv@pop-os.localdomain/
>---
> net/vmw_vsock/virtio_transport_common.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 957cdc01c8e8..2a2f0c1a9fbd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -94,6 +94,9 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 					 info->op,
> 					 info->flags);
>
>+	if (info->vsk)
>+		skb_set_owner_w(skb, sk_vsock(info->vsk));
>+

Should we do the same also in virtio_transport_recv_pkt()?

The skb in that cases is allocated in drivers/vhost/vsock.c and
net/vmw_vsock/virtio_transport.c using directly
virtio_vsock_alloc_skb(), because we don't know in advance which socket
it belongs to.

Then in virtio_transport_recv_pkt() we look for the socket and queue it
up. This should also solve the problem in vsock_loopback.c where we move
skb from one socket to another.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
