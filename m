Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F6BC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:33:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C9A64DB1
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C9A64DB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B571A605BC;
	Tue, 23 Feb 2021 12:33:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06oC7D1wjtyl; Tue, 23 Feb 2021 12:32:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3477F605EA;
	Tue, 23 Feb 2021 12:32:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4B04C000C;
	Tue, 23 Feb 2021 12:32:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97DA4C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8399C83A3E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VRfIc7u5fRKR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:32:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6218A839BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614083575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x3DW69ELSoGab9iFk3XQpMfjw5ZB9SvGphEN2R3aLT0=;
 b=ape6WaeydVqSF26qBqbqU3x4oUNvVPH+EuMKJl57pZYQMdwxtuh3Fxac5jaGV+Ql5MkwFa
 W6MaEA/KZdZMxBIMHzBci1PzYoBCAVEWut2cmToTKXlX/Ciq1wXSTcJkQkb9L1XAE/1qFe
 bNxNs/EgO4+6TM8MEcgW31fSn+B8k4o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-4haM8x2ePfKZNkvvCQtkmw-1; Tue, 23 Feb 2021 07:32:53 -0500
X-MC-Unique: 4haM8x2ePfKZNkvvCQtkmw-1
Received: by mail-wr1-f70.google.com with SMTP id j12so1683086wrt.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=x3DW69ELSoGab9iFk3XQpMfjw5ZB9SvGphEN2R3aLT0=;
 b=OK86c6GvbKVLXQrBJ8F3iVhK+F7GMnWyWcFllNvGcgKJ/YH3/QUXYrDOP3afDlFLwR
 Rn1nmeziPTcSSkZ/6RK5FCxdYWVzDV92uTABKmQcgiFnshE3JVzfq8PW4Adsk0Gp3i0k
 hIv6Z9QPBO4geu5GiLXwrmSaZ7qrJkyXHhPinNbmX5egNAAw5hSYh7xfg1jFyzcnW1+d
 jOuniNnzZq4+X+UWrdzBU7Cg/nTxEqsVz2xqlqxPk4K7UmE6sL5jbIz6uczKHQaqG3VD
 xl2KLI94l+kEnDiM+71z2P6NacDwYi/wV96tiwhbi7ltj5UZeFfpMXGmR82iAOZSSc0s
 7QKg==
X-Gm-Message-State: AOAM530R3Q7CFCHcSZLLqlCLt7QoJVRTbjSfxp2KamCZWakDm0v948jg
 4szFc9e5RPjeazu2bLK2u2f2711Z4A4bsNbAQbcWe14/5qeCspym3gDAyKXBHcHL9J4HXLy7BfV
 62eOxuIXdjfUfgQHKhDMsM/AvWRWALWHCetJMTFbrwg==
X-Received: by 2002:a1c:f60b:: with SMTP id w11mr24660184wmc.3.1614083572529; 
 Tue, 23 Feb 2021 04:32:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/j0eRjoVScr7mxvXDLNHosb0ARMNPamB4G4SgA5hHEoAJqxPK6ghP73oKIZ48MV2ylGM7TQ==
X-Received: by 2002:a1c:f60b:: with SMTP id w11mr24660173wmc.3.1614083572413; 
 Tue, 23 Feb 2021 04:32:52 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id v5sm2671407wmh.2.2021.02.23.04.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:32:52 -0800 (PST)
Date: Tue, 23 Feb 2021 07:32:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Extract correct pointer from driver data
Message-ID: <20210223073225-mutt-send-email-mst@kernel.org>
References: <20210216055022.25248-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210216055022.25248-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: si-wei.liu@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Tue, Feb 16, 2021 at 07:50:21AM +0200, Eli Cohen wrote:
> struct mlx5_vdpa_net pointer was stored in drvdata. Extract it as well
> in mlx5v_remove().
> 
> Fixes: 74c9729dd892 ("vdpa/mlx5: Connect mlx5_vdpa to auxiliary bus")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Sorry which tree this is for? Couldn't apply.

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6b0a42183622..4103d3b64a2a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2036,9 +2036,9 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  
>  static void mlx5v_remove(struct auxiliary_device *adev)
>  {
> -	struct mlx5_vdpa_dev *mvdev = dev_get_drvdata(&adev->dev);
> +	struct mlx5_vdpa_net *ndev = dev_get_drvdata(&adev->dev);
>  
> -	vdpa_unregister_device(&mvdev->vdev);
> +	vdpa_unregister_device(&ndev->mvdev.vdev);
>  }
>  
>  static const struct auxiliary_device_id mlx5v_id_table[] = {
> -- 
> 2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
