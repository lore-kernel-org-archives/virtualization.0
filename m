Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E046EC2BC11
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 02:08:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5428620758
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 02:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edeB5Osf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5428620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D6D208746A;
	Wed,  9 Sep 2020 02:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IhyYo9+Fwrdt; Wed,  9 Sep 2020 02:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61BEC8744D;
	Wed,  9 Sep 2020 02:08:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D41EC0859;
	Wed,  9 Sep 2020 02:08:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84004C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 72F058746A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tUIVCfYIrsZ6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:08:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A589A8744D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599617322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cK43OIRzcGZJEOVLkDpteaSOuuBLunxsaFHU/AarU6A=;
 b=edeB5OsfD1Q9s9zuU+VIc3pXPNYGsGkEKkFFvkYlzPbAQCSyYL0CR8U8fTtiBJ5o6b/J86
 SqiKBXxtp6sU8hwdPtnBAOVLhowmhkpBmPIV/HKgqnDgMXo3RPvrlSXLBT1R78GZMw4xsG
 5shF18WoN4+8Ey6jgUn7m9SyLzKDF8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-62f7pSR1P-6oeJmgDXQcmQ-1; Tue, 08 Sep 2020 22:08:41 -0400
X-MC-Unique: 62f7pSR1P-6oeJmgDXQcmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01845807335;
 Wed,  9 Sep 2020 02:08:40 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED3A65C22E;
 Wed,  9 Sep 2020 02:08:39 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id D5F5A79DBA;
 Wed,  9 Sep 2020 02:08:39 +0000 (UTC)
Date: Tue, 8 Sep 2020 22:08:39 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Message-ID: <1004346338.16284947.1599617319808.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200908123346.GA169007@mtl-vdi-166.wap.labs.mlnx>
References: <20200908123346.GA169007@mtl-vdi-166.wap.labs.mlnx>
Subject: Re: [PATCH v2] vdpa/mlx5: Setup driver only if
 VIRTIO_CONFIG_S_DRIVER_OK
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.13]
Thread-Topic: vdpa/mlx5: Setup driver only if VIRTIO_CONFIG_S_DRIVER_OK
Thread-Index: qaNSGDz/X0Zzbl+zuoh4Dhhl+VkUUQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> set_map() is used by mlx5 vdpa to create a memory region based on the
> address map passed by the iotlb argument. If we get successive calls, we
> will destroy the current memory region and build another one based on
> the new address mapping. We also need to setup the hardware resources
> since they depend on the memory region.
> 
> If these calls happen before DRIVER_OK, It means that driver VQs may
> also not been setup and we may not create them yet. In this case we want
> to avoid setting up the other resources and defer this till we get
> DRIVER OK.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> V1->V2: Improve changelog description
> 
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

Is there any reason that we still need to do vq suspending and saving before?

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
