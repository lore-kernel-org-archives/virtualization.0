Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596EAC43461
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 10:53:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2545206D4
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 10:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRGmlq/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2545206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8388487115;
	Mon,  7 Sep 2020 10:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aStG9vVfH9a2; Mon,  7 Sep 2020 10:53:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E535B87103;
	Mon,  7 Sep 2020 10:53:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6D76C0052;
	Mon,  7 Sep 2020 10:53:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE8CBC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BEB7384A75
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mhrfl3cgM+b4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:53:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A71D2847D9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599476006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i89UCCXKKan+5I1+ppu2tBoEuwjXgdxp6aLWE1Reto8=;
 b=gRGmlq/U+L+tQL8KaUbH/3POvcZJWhXQ/z/awG/CusomwnUk/EEMwyoP2il5LlghsR7CYk
 v8QBBBj6wl2fSSsGO62/JVz26ZeRK30dSyqvwoB86NlnV4k6XJD6EmINA0q4RtjZQpXBk7
 5X6hVe7n1AxhyrBSM5Eo210kyiuyIXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-nUGUxhcHPwyWfgbwno-P9Q-1; Mon, 07 Sep 2020 06:53:24 -0400
X-MC-Unique: nUGUxhcHPwyWfgbwno-P9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DE2D8030BD;
 Mon,  7 Sep 2020 10:53:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7677A5D9D2;
 Mon,  7 Sep 2020 10:53:23 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5FDCC79A16;
 Mon,  7 Sep 2020 10:53:23 +0000 (UTC)
Date: Mon, 7 Sep 2020 06:53:23 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Message-ID: <507166908.16038290.1599476003292.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200907075136.GA114876@mtl-vdi-166.wap.labs.mlnx>
References: <20200907075136.GA114876@mtl-vdi-166.wap.labs.mlnx>
Subject: Re: [PATCH] vdpa/mlx5: Setup driver only if VIRTIO_CONFIG_S_DRIVER_OK
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.28]
Thread-Topic: vdpa/mlx5: Setup driver only if VIRTIO_CONFIG_S_DRIVER_OK
Thread-Index: lEsps6GGs64HEps5Kq4yQPAU9yMKuQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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



----- Original Message -----
> If the memory map changes before the driver status is
> VIRTIO_CONFIG_S_DRIVER_OK, don't attempt to create resources because it
> may fail. For example, if the VQ is not ready there is no point in
> creating resources.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9df69d5efe8c..c89cd48a0aab 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1645,6 +1645,9 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_net
> *ndev, struct vhost_iotlb *
>  	if (err)
>  		goto err_mr;
>  
> +	if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		return 0;
> +

I'm not sure I get this.

It looks to me if set_map() is called before DRIVER_OK, we won't build
any mapping?

Thanks

>  	restore_channels_info(ndev);
>  	err = setup_driver(ndev);
>  	if (err)
> --
> 2.26.0
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
