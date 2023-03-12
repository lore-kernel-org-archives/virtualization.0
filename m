Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9563CC6FD1C
	for <virtualization@archiver.kernel.org>; Sun, 12 Mar 2023 08:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 149E360F83;
	Sun, 12 Mar 2023 08:58:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 149E360F83
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFl/D1Da
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6PE0Dy6CBh8; Sun, 12 Mar 2023 08:58:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9489E60F75;
	Sun, 12 Mar 2023 08:58:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9489E60F75
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63962C0071;
	Sun, 12 Mar 2023 08:58:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58FA6C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 08:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32C9740869
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 08:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32C9740869
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFl/D1Da
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xmv12LlKUzmp
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 08:58:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F81B40571
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F81B40571
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678611498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dklwuaM2uWZSMeyDIYenmk/kLDEmD+dwf5R21VX9o+o=;
 b=GFl/D1Dat9EJk3BduMZKtB5HrvzCHjH+cwt/CJteBTCOlFy0QyIy6xTvyGSQHnr5NrfXHx
 fhyNWrSbGt1c8vhk+vhUbgI6eZb6p1GwRLUO0NXcxB8DOW8K1n8vezrr2iMmpiaMCZ1ykM
 kEaVOiBeyW/yatJMmDLzJw/N30AquL0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-IPih-v5WNwKUPEJKZwIgCQ-1; Sun, 12 Mar 2023 04:58:14 -0400
X-MC-Unique: IPih-v5WNwKUPEJKZwIgCQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 y24-20020aa7ccd8000000b004be3955a42eso13092428edt.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 00:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678611493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dklwuaM2uWZSMeyDIYenmk/kLDEmD+dwf5R21VX9o+o=;
 b=qyWzSsxqS0yRaqMYy1NK1SjZTYPHmghdVnMsqPziaIZ2Ao031Qr8eF3yRKW0lO6hSk
 ZoF2C8qfgNI91yDywC1upXRqXhCRS2AfZDF/KngNt+Ty4CECZc9oL9eUgockfD2QIh0C
 UuR0TlTyqfzdCQg5WNzY/eeUwEoLFaQtq1ul5NcDkuJ0FWXCLp333yQAtOZWmd8AC7VD
 GlBCUqoe+10f13jh+n54TDD889hEJF3FpcTmr79MvZmcyFTpUQm9znvsvB3wxszonsBT
 7AFK2at6umPfavnUu49SWF/OyLMsUV3HgaGeBzJ3VfGxu7iuyilrz1BD3k5Xqr2gzFTl
 o06A==
X-Gm-Message-State: AO0yUKXZZkRorXRai5NB0+rTbgokYwe1g5MS9GhXAk6IJfv5XHNRYlz4
 Dms4L2UBgVaCtC7ny59W1FHARiu1nydHcyDN7xxtwW9xHoPt6EU54J4hw8RJZgBTMOiIIMkh/L/
 j5dOAp2e6TaX3tcDea3+dKxafGbDMsxzEYJVBm6VsfQ==
X-Received: by 2002:a17:906:95ce:b0:88d:ba89:183a with SMTP id
 n14-20020a17090695ce00b0088dba89183amr6368767ejy.11.1678611493522; 
 Sun, 12 Mar 2023 00:58:13 -0800 (PST)
X-Google-Smtp-Source: AK7set8iiyBZRnoRBKUYYxOyJRu9Qd2plyTukWDuogm60CVyKIKex+uBfkJXHw6HIq3FnU2L/ajWwQ==
X-Received: by 2002:a17:906:95ce:b0:88d:ba89:183a with SMTP id
 n14-20020a17090695ce00b0088dba89183amr6368755ejy.11.1678611493257; 
 Sun, 12 Mar 2023 00:58:13 -0800 (PST)
Received: from redhat.com ([2a02:14f:1fb:4775:5c5c:4007:acc2:a326])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a170906175300b008eaf99be56esm2043235eje.170.2023.03.12.00.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Mar 2023 00:58:12 -0800 (PST)
Date: Sun, 12 Mar 2023 04:58:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Message-ID: <20230312045717-mutt-send-email-mst@kernel.org>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230312083920.2300028-2-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: perezma@redhat.com, parav@mellanox.com,
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

On Sun, Mar 12, 2023 at 10:39:19AM +0200, Eli Cohen wrote:
> One can still enable it when creating the vdpa device using vdpa tool by
> providing features that include it.
> 
> For example:
> $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 device_features 0x300cb982b
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>

What's the reason to turn it off by default? It's generally a
performance win isn't it?


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 4abc3a4ee515..3858ba1e8975 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3154,6 +3154,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  			return -EINVAL;
>  		}
>  		device_features &= add_config->device_features;
> +	} else {
> +		device_features &= ~BIT_ULL(VIRTIO_NET_F_MRG_RXBUF);
>  	}
>  	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
>  	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
