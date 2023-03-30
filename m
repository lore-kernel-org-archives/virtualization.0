Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2272DC77B6F
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 08:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88263615DD;
	Thu, 30 Mar 2023 08:00:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88263615DD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gXtg943a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QOf7ljQ9cj8g; Thu, 30 Mar 2023 08:00:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07B2A615B5;
	Thu, 30 Mar 2023 08:00:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07B2A615B5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5C7CC0037;
	Thu, 30 Mar 2023 08:00:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E58ECC002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2E2941E54
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:00:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2E2941E54
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gXtg943a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O_Oz2-ZzMOKO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:00:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F74841E30
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F74841E30
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680163249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aKnf9talvaQpvRmivVJ+UtDT41SWYzLKCf+gopv+JXM=;
 b=gXtg943aOM64Yk+q1Sn1teGIsR2o801CVaUZEvVVaQg4QmOt4dwVEPpfGBz67CWan/v+mw
 LLXc12UW6dZiJUwUtxpEKtW76BiaT6PmTIOuqc/7kpKRcC8Pu1eFb5CpW4ReFL50L/AHN5
 /RIT97wYzI4deg6omHaMXnf2lrSJ/Lc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-mlDFQsF3NXS-DU6t6TXANg-1; Thu, 30 Mar 2023 04:00:46 -0400
X-MC-Unique: mlDFQsF3NXS-DU6t6TXANg-1
Received: by mail-qv1-f72.google.com with SMTP id
 dg8-20020a056214084800b005acc280bf19so7827299qvb.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 01:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680163246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKnf9talvaQpvRmivVJ+UtDT41SWYzLKCf+gopv+JXM=;
 b=8LC+oV+8yU5rnrZDIqd9PDSYfLmH8z4DiEF0ZTZ1aM5Q0rg+w1NUTSZRaEpEosMfXX
 mVmHtWzNMNxx+1VEw2Pm7jFi2B6tAF7TdAtuamYOuQ6LuXUauiH4p5O/dDrFPtUe/jCN
 yCI5rGh90lYtEXMyWQ7ut+mmgzNYZgVVcZzHMureBb0qRp0Z3yyCwDFPwImBrSGPvGN1
 h8N4Ck3HIgx6Oi1vCFXzCoj+O2oy7RuIIc5vPxi+uKRTAmNBIAUahvxLKYoFJUl6SWSq
 ajPnaAtEhftjYvZ2NHV0PrH9byfrhLkW6eZaWnQQRGUQx8L25anfEzBWSCTkWJRNN2D+
 Ivbw==
X-Gm-Message-State: AAQBX9dtH/4LrYa+NHf9/M5kr4j81nFaumxtxh3j9Gti2hplRmM9Zo2D
 7R/IeOmHNYMCbsikLzYyDuWXGjVXhN1C3s8B1ULdkfRZV602m5RF8Zyd/FImhFiyR1K7ukwH9tK
 9fh59+8tkElJW/9Q+zxLLrLq7dl0yYb6qdPjk4lNuYg==
X-Received: by 2002:a05:6214:21a8:b0:5e0:3bbf:78c5 with SMTP id
 t8-20020a05621421a800b005e03bbf78c5mr2381388qvc.37.1680163246451; 
 Thu, 30 Mar 2023 01:00:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350YFd/4+N/O9Q5uwc3AG+urPSvuo4JSxefwurWAaOedWAKnyL/UuyV9ifYC209uK3neiFHLf+g==
X-Received: by 2002:a05:6214:21a8:b0:5e0:3bbf:78c5 with SMTP id
 t8-20020a05621421a800b005e03bbf78c5mr2381363qvc.37.1680163246211; 
 Thu, 30 Mar 2023 01:00:46 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 l4-20020ad44244000000b005dd8b9345cesm5192472qvq.102.2023.03.30.01.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Mar 2023 01:00:45 -0700 (PDT)
Date: Thu, 30 Mar 2023 10:00:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net v3] virtio/vsock: fix leaks due to missing skb owner
Message-ID: <p6y6cwfywyi5apvn4cx5edob3n2zvyrmfvj6yss5szd24phgnt@gynsr43tsvan>
References: <20230327-vsock-fix-leak-v3-1-292cfc257531@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230327-vsock-fix-leak-v3-1-292cfc257531@bytedance.com>
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

On Wed, Mar 29, 2023 at 04:51:58PM +0000, Bobby Eshleman wrote:
>This patch sets the skb owner in the recv and send path for virtio.
>
>For the send path, this solves the leak caused when
>virtio_transport_purge_skbs() finds skb->sk is always NULL and therefore
>never matches it with the current socket. Setting the owner upon
>allocation fixes this.
>
>For the recv path, this ensures correctness of accounting and also
>correct transfer of ownership in vsock_loopback (when skbs are sent from
>one socket and received by another).
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
>Link: https://lore.kernel.org/all/ZCCbATwov4U+GBUv@pop-os.localdomain/
>---
>Changes in v3:
>- virtio/vsock: use skb_set_owner_sk_safe() instead of
>  skb_set_owner_{r,w}
>- virtio/vsock: reject allocating/receiving skb if sk_refcnt==0 and WARN_ONCE
>- Link to v2: https://lore.kernel.org/r/20230327-vsock-fix-leak-v2-1-f6619972dee0@bytedance.com
>
>Changes in v2:
>- virtio/vsock: add skb_set_owner_r to recv_pkt()
>- Link to v1: https://lore.kernel.org/r/20230327-vsock-fix-leak-v1-1-3fede367105f@bytedance.com
>---
> net/vmw_vsock/virtio_transport_common.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 957cdc01c8e8..c927dc302faa 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -94,6 +94,11 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 					 info->op,
> 					 info->flags);
>
>+	if (info->vsk && !skb_set_owner_sk_safe(skb, sk_vsock(info->vsk))) {
>+		WARN_ONCE(1, "failed to allocate skb on vsock socket with sk_refcnt == 0\n");
>+		goto out;
>+	}
>+
> 	return skb;
>
> out:
>@@ -1294,6 +1299,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		goto free_pkt;
> 	}
>
>+	if (!skb_set_owner_sk_safe(skb, sk)) {
>+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>+		goto free_pkt;
>+	}
>+

LGTM!

I would have put the condition inside WARN_ONCE() because I find it
more readable (e.g. WARN_ONCE(!skb_set_owner_sk_safe(skb, sk), ...),
but I don't have a strong opinion on that, so that's fine too:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
