Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0DDC433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 04:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A15E940631;
	Thu, 25 Nov 2021 04:40:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phh2LvtVtf9z; Thu, 25 Nov 2021 04:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6022C405E8;
	Thu, 25 Nov 2021 04:40:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 423F8C0038;
	Thu, 25 Nov 2021 04:40:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14387C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03665607FB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:40:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dlw2iLdU1kfQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:40:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A348607B2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637815230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdCujs9G0dfTb9HqJwZO9OGLzmW0ZL/Ook05U2Z62yo=;
 b=gTYFiyj75bAHOFWGhdhpiiV6r+tZMPq627Q2xvcdBSdVULEPYkRZ8TeSry3N0iEGnZuOgq
 YbcqlzY/5xiLsh17LjxOXnNY+RM9F2F/PQPCiJtHREh4slbxnz6NswadiHAM/+9cg0uFpJ
 dSzSuJ5Skp9T+OXhj0oyr/LGWxmDRaY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-S2DF6wv4MeKj_rzPy8ybCg-1; Wed, 24 Nov 2021 23:40:29 -0500
X-MC-Unique: S2DF6wv4MeKj_rzPy8ybCg-1
Received: by mail-lf1-f72.google.com with SMTP id
 m1-20020ac24281000000b004162863a2fcso2540737lfh.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 20:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FdCujs9G0dfTb9HqJwZO9OGLzmW0ZL/Ook05U2Z62yo=;
 b=i+qHIgGJZetCbPxYy2kR1jOvSpf5JXE+jhMnZKLQj7DbldVlrUlbzkQPl2FuBhXN5t
 fAEL4m+xRfR9OzB155v/J8/UqFTy3LJSQ7z1VYqt7fyeDtCv++VTuJQjfEmFPquW/Mnz
 7bVK41pxjJdCPxED8ApnQ00AyD1m+uMQjHpjV3D10NU/RfGXIsa5d6GhYWDacnnVaJ0z
 lYSClfXK3bZOZpHmzMt7WZrdMunH0jPvOEgdFhFngDiGNUWriIT/xrVuWIDE2Wh0WiZ6
 +gWWlJwhohUgnLmh0LSq0JvN0OHWQUK14QbV6o89kAcUd9d4CfFuB1LbAbZRdRRMwCtQ
 yhWw==
X-Gm-Message-State: AOAM530CwCtT0acIlfgaLyHE25wc6SQ04TxjdZPtnp0BmI9Zfe4pyrJO
 hfFlNCOvdDw06I6eTl9G1mklgL+cxADK+0oVRs+7cuBpsMr3rbyzVbJ5LXE9WZCiNHnqbqXQuRX
 hlzc01/JSCgBN+VLZ3OJ5rWaK0crk6Phhk8jrS2OO62mz+zBZyuQVfGgb+g==
X-Received: by 2002:a05:6512:3990:: with SMTP id
 j16mr20547511lfu.199.1637815227599; 
 Wed, 24 Nov 2021 20:40:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2VCFcKUNc9mqMdSxGKzCXgEbvfRNcNoaQtBlA4rY2ZqXxbrBTaAhA1bn7FhhsGnjATxvL6nVXOCMzL6ynnNQ=
X-Received: by 2002:a05:6512:3990:: with SMTP id
 j16mr20547492lfu.199.1637815227429; 
 Wed, 24 Nov 2021 20:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20211124171953.57858-1-elic@nvidia.com>
In-Reply-To: <20211124171953.57858-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 12:40:16 +0800
Message-ID: <CACGkMEvguu0BM-n=i2VP2q4GYdG9kNRMeK1NXH5t1pj6xO2=2Q@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5_vdpa: Increase the limit on the number of
 virtuques
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, si-wei.liu@oracle.com
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

On Thu, Nov 25, 2021 at 1:20 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Increase the limit on the maximum number of supported virtqueues to 256
> to match hardware capabilities.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

(A typo in the subject)

Other than this:

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ed7a63e48335..8f2918a8efc6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -135,7 +135,7 @@ struct mlx5_vdpa_virtqueue {
>  /* We will remove this limitation once mlx5_vdpa_alloc_resources()
>   * provides for driver space allocation
>   */
> -#define MLX5_MAX_SUPPORTED_VQS 16
> +#define MLX5_MAX_SUPPORTED_VQS 256
>
>  static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>  {
> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
