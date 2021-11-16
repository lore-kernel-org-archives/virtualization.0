Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA61C433F5
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:34:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAA6615E1
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AAAA6615E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7670F4041D;
	Tue, 16 Nov 2021 14:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kRlfl7IFvFZ9; Tue, 16 Nov 2021 14:34:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 038C14018F;
	Tue, 16 Nov 2021 14:34:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D32C9C002E;
	Tue, 16 Nov 2021 14:34:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62E1DC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CD72401E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NgkFviIKL_o6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:34:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4D874018F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637073240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gw+zT5Bn7Yu9SFxWiKnZNuSsR3PCxJWgrO3fVTViz5U=;
 b=ce77AcTU4Hg2u6yifc/6AKTrXF6Qwvl7ZhYFQ+PkTRni6x5eq721mwzR2QPUMgdkYMEiwT
 /ZmGXf3DIrk9BYGq/OxcAi42XZ/13gj4w3pzQZIVMOQ3E/AvbJWjq6Uj8u/hsrtxUcwxxL
 7FDQhPFfJCy4FA/rZwAp+xhHYCkYdEw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374---MgUm5ENNOl7keCoOIQgA-1; Tue, 16 Nov 2021 09:33:58 -0500
X-MC-Unique: --MgUm5ENNOl7keCoOIQgA-1
Received: by mail-ed1-f69.google.com with SMTP id
 k7-20020aa7c387000000b003e7ed87fb31so381450edq.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 06:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gw+zT5Bn7Yu9SFxWiKnZNuSsR3PCxJWgrO3fVTViz5U=;
 b=q4lPt7W7/Zllh3HmkT9IKros6Awy+3xBBpRdsXs4v5o5eTwwXg22jS2N907lTpbUTw
 i4+o44i7nfHCSZsCdWQthBu793vFz66Sspdg240CTa5wmvKNw985KwrYYxw2+OdOdW/v
 liv4x099Wi5p+fE6UQDnEsuXTSudlfmv4ATs6IN8BrIjkdtQf9PWUS38G3iM1gD9R2y7
 MVpQ1n8OYHxlhHhr9cAKClU9vDPwfPSuNi0841LOtOYll+Deyc2bB7gGqj0TOeafBd28
 nlnvaOEwMlf+V3EpQHxwykfBCa1JMPIvFe7VYewn3q8O7WwcZ6zVRmXH9Ax6d3HEkzmn
 OTig==
X-Gm-Message-State: AOAM530Hr34iq8dgbfDHDkrkFGgWhB19DYlTmLUStaNa7+gTl6Dt4v5d
 3nGfyUIhUyEaZ2oFIYjz0pa1abeCWYVVMihJmhzxF5NaWUXxRo7c0RKw++DgjG011lUWy9ONuNV
 WiTNVgUynoOU+vxejm0MDFsVZPt8NTUl+60H1oPYVbw==
X-Received: by 2002:a17:906:2cd5:: with SMTP id
 r21mr10866451ejr.435.1637073236969; 
 Tue, 16 Nov 2021 06:33:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsudr1k0KsGdEMmED92N84TSbVeptPs2C1EJfEE9/7YPC8Go6Zta6pz56XSBZBy8eqwHLpGA==
X-Received: by 2002:a17:906:2cd5:: with SMTP id
 r21mr10866430ejr.435.1637073236801; 
 Tue, 16 Nov 2021 06:33:56 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id g15sm8766816ejt.10.2021.11.16.06.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 06:33:56 -0800 (PST)
Date: Tue, 16 Nov 2021 15:33:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH 2/6] vhost_net: get rid of vhost_net_flush_vq() and extra
 flush calls
Message-ID: <20211116143354.exgqcjfbmmbaahs4@steredhat>
References: <20211115153003.9140-1-arbn@yandex-team.com>
 <20211115153003.9140-2-arbn@yandex-team.com>
MIME-Version: 1.0
In-Reply-To: <20211115153003.9140-2-arbn@yandex-team.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, Nov 15, 2021 at 06:29:59PM +0300, Andrey Ryabinin wrote:
>vhost_net_flush_vq() calls vhost_work_dev_flush() twice passing
>vhost_dev pointer obtained via 'n->poll[index].dev' and
>'n->vqs[index].vq.poll.dev'. This is actually the same pointer,
>initialized in vhost_net_open()/vhost_dev_init()/vhost_poll_init()
>
>Remove vhost_net_flush_vq() and call vhost_work_dev_flush() directly.
>Do the flushes only once instead of several flush calls in a row
>which seems rather useless.
>
>Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>---
> drivers/vhost/net.c   | 11 ++---------
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 3 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>index 11221f6d11b8..b1feb5e0571e 100644
>--- a/drivers/vhost/net.c
>+++ b/drivers/vhost/net.c
>@@ -1373,16 +1373,9 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
> 	*rx_sock = vhost_net_stop_vq(n, &n->vqs[VHOST_NET_VQ_RX].vq);
> }
>
>-static void vhost_net_flush_vq(struct vhost_net *n, int index)
>-{
>-	vhost_work_dev_flush(n->poll[index].dev);
>-	vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
>-}
>-
> static void vhost_net_flush(struct vhost_net *n)
> {
>-	vhost_net_flush_vq(n, VHOST_NET_VQ_TX);
>-	vhost_net_flush_vq(n, VHOST_NET_VQ_RX);
>+	vhost_work_dev_flush(&n->dev);
> 	if (n->vqs[VHOST_NET_VQ_TX].ubufs) {
> 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
> 		n->tx_flush = true;
>@@ -1572,7 +1565,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
> 	}
>
> 	if (oldsock) {
>-		vhost_net_flush_vq(n, index);
>+		vhost_work_dev_flush(&n->dev);
> 		sockfd_put(oldsock);
> 	}
>
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 638bb640d6b4..ecbaa5c6005f 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -15,6 +15,7 @@
> #include <linux/vhost_iotlb.h>
> #include <linux/irqbypass.h>
>
>+struct vhost_dev;

Is this change needed?

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
