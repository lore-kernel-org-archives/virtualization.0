Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA35BC433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 14:00:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9234C2312D
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 14:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baC8TH2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9234C2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44F7A8689B;
	Wed,  5 Aug 2020 14:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w867Lgp0Jc4N; Wed,  5 Aug 2020 14:00:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B442A86203;
	Wed,  5 Aug 2020 14:00:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82403C0051;
	Wed,  5 Aug 2020 14:00:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0DF5C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C8E78214FD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WYDIoy3fVhTh
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:00:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 7A0D52051E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596636000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6BgoSObisAMVxaJpQKxat6BIIq50UZiECX71HIFPB8=;
 b=baC8TH2PSDSmQgarJdzmEVj++ygt7Pyi5f4bkZr0ZP4owxrLZWG4YATuFKZa0makMfVMU8
 kyHL7Su3h9jV+YnZRwznA387f46E0Im08oPFr6m/FZdUcREzj5TUGIxe5+r7bmKSRCJaV5
 T4cDCLS9ghrojWIWiji6iotiv6bx0X8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-EMfVmt2BMeOPnRR1pJUjkQ-1; Wed, 05 Aug 2020 09:59:56 -0400
X-MC-Unique: EMfVmt2BMeOPnRR1pJUjkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D27D80183C;
 Wed,  5 Aug 2020 13:59:55 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 943062B6D9;
 Wed,  5 Aug 2020 13:59:50 +0000 (UTC)
Date: Wed, 5 Aug 2020 15:59:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 38/38] virtio_net: use LE accessors for speed/duplex
Message-ID: <20200805155948.4869b0cc.cohuck@redhat.com>
In-Reply-To: <20200805134226.1106164-39-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-39-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 5 Aug 2020 09:45:00 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Speed and duplex config fields depend on VIRTIO_NET_F_SPEED_DUPLEX
> which being 63>31 depends on VIRTIO_F_VERSION_1.
> 
> Accordingly, use LE accessors for these fields.
> 
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/virtio_net.c        | 9 +++++----
>  include/uapi/linux/virtio_net.h | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ba38765dc490..0934b1ec5320 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2264,12 +2264,13 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
>  		return;
>  
> -	speed = virtio_cread32(vi->vdev, offsetof(struct virtio_net_config,
> -						  speed));
> +	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> +
>  	if (ethtool_validate_speed(speed))
>  		vi->speed = speed;
> -	duplex = virtio_cread8(vi->vdev, offsetof(struct virtio_net_config,
> -						  duplex));
> +
> +	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);

Looks a bit odd for an u8, but does not really hurt.

> +
>  	if (ethtool_validate_duplex(duplex))
>  		vi->duplex = duplex;
>  }
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 27d996f29dd1..3f55a4215f11 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -99,7 +99,7 @@ struct virtio_net_config {
>  	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
>  	 * Any other value stands for unknown.
>  	 */
> -	__virtio32 speed;
> +	__le32 speed;
>  	/*
>  	 * 0x00 - half duplex
>  	 * 0x01 - full duplex

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
