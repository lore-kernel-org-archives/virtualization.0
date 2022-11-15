Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E752AC43217
	for <virtualization@archiver.kernel.org>; Tue, 15 Nov 2022 03:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FAB240424;
	Tue, 15 Nov 2022 03:10:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FAB240424
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xug4hYTS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4DSio4MIZq7O; Tue, 15 Nov 2022 03:10:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F045740018;
	Tue, 15 Nov 2022 03:10:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F045740018
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2525C0033;
	Tue, 15 Nov 2022 03:10:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC2A6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96B2760A87
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:10:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96B2760A87
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xug4hYTS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d5kK3NMQzqzE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:10:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD74760A70
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD74760A70
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668481834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LmxdoJVLhZiX760c9V3GI6qvw0JOeU/gMUZ23fFnOlw=;
 b=Xug4hYTSlMAp1Lu00XCMqYLqMNF2NSDQ4lDJsTCd3dqthn+B6Ww4goex6F/ixjQnWRaVkP
 UA12kglweMt//EEe95XeRnzfoCoYGJtju8LAlh5wO+CBBSxPM3lhKQMuD4qO6qNGmSq5FU
 msxXdHTzgQcz9elLyXFYkn2yNN1uQ4c=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-f1PDS7hzNGCnA49_JKrMeg-1; Mon, 14 Nov 2022 22:10:31 -0500
X-MC-Unique: f1PDS7hzNGCnA49_JKrMeg-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-13b041fd3cbso6253115fac.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 19:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LmxdoJVLhZiX760c9V3GI6qvw0JOeU/gMUZ23fFnOlw=;
 b=pEac7V1I9WDZQ5k+7xWGyVNUrKLkSxh1yaG/RF5zXV643LytD1EIn7ABeqQph1rup5
 GzGXkxwEeGqD7j1NeDxMZngbDdGPzxhM+O3QHYltzs48d+udZElFem4RIM/kl0dCBLwM
 RJ1nsKKHFe+dUdc6/jAfCXCv9JrZ0H0OY57aMsSLH6C6LV0SCpPdJmv9nMlITKA8poWq
 d49uG/TP9C0yoazrBjnj43BEUssiLVJBjnF/++IulOBEzhBm8jGAsvSaWa83RFRHKeNd
 DlyCQ2kPix+fIqM3lw8kg0ZdAylBmbP2Z58/Zs3vRIWh0wgteW3sfaM5fNdMm42I3RF+
 IM+Q==
X-Gm-Message-State: ANoB5pl6mNp/TeqmJ+n5rYSUQ4U3AceA1Ss8X2ILA7LTK6Mx6Fi0DEz/
 NwG6ndZLQyJej8Ne0JjAUY/rd7fE/qmEiqH8uuubnZiltZdJHaJQxCHdemXLqGNjBoZK8Uh1/DK
 LwYCIrRecewxr2PhxxPeyPjvipp7/ZNorC0wBYuFQyq4PWHxPh6khT5Sy6Q==
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id
 s13-20020a056830124d00b0066c64d61bb4mr7778956otp.201.1668481830421; 
 Mon, 14 Nov 2022 19:10:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5nQCT0S5bfmSNmyom39QUjcF9+M0QJTqpWCFA4vh7lW7Nl7FALwgg20OyeHrd9FTYTBTir8WX55xcLO1GjW0c=
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id
 s13-20020a056830124d00b0066c64d61bb4mr7778949otp.201.1668481830217; Mon, 14
 Nov 2022 19:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20221114131759.57883-1-elic@nvidia.com>
 <20221114131759.57883-3-elic@nvidia.com>
In-Reply-To: <20221114131759.57883-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Nov 2022 11:10:19 +0800
Message-ID: <CACGkMEtEKyeYM4AxWY3Zjx9_4sHGGvBL=3hGHgd5y-bnP3EhMg@mail.gmail.com>
Subject: Re: [PATH v2 2/8] vdpa/mlx5: Return error on vlan ctrl commands if
 not supported
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: lulu@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

On Mon, Nov 14, 2022 at 9:18 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Check if VIRTIO_NET_F_CTRL_VLAN is negotiated and return error if
> control VQ command is received.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3fb06dcee943..01da229d22da 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1823,6 +1823,9 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>         size_t read;
>         u16 id;
>
> +       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)))
> +               return status;
> +
>         switch (cmd) {
>         case VIRTIO_NET_CTRL_VLAN_ADD:
>                 read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &vlan, sizeof(vlan));
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
