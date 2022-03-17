Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F4AC433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Mar 2022 03:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 366B140236;
	Thu, 17 Mar 2022 03:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKYgHQFJT_Cy; Thu, 17 Mar 2022 03:39:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D1E5740241;
	Thu, 17 Mar 2022 03:39:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2515C0012;
	Thu, 17 Mar 2022 03:39:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFA62C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97540827AA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AaDAulwAEfYN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:39:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF5AB82681
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647488374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IuVUbU5po4pDsL5Q02wWFZCT4oH7kt1pNvS3SA5iGQw=;
 b=dE+3IaLqK1l4jc5S6r9fml+JgN/4Xn8rdnBEjMYNLSBO3SeVV6JWtt2ywm86+Q4Z+1ahsa
 2kIsx2G6QT6WpGD+DuxFrDP3hYNzdHICBhXxyKcGn7fL6am8yFPJ6lMbdLViUlbS45nfsM
 EWnUJaPjnIsa2pnPA+zZx//GdZ32F4o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-wjMUhbjXNNicRCFGtZ-pEw-1; Wed, 16 Mar 2022 23:39:31 -0400
X-MC-Unique: wjMUhbjXNNicRCFGtZ-pEw-1
Received: by mail-lj1-f200.google.com with SMTP id
 j7-20020a2e3c07000000b00247f8eb86a4so1634461lja.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 20:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IuVUbU5po4pDsL5Q02wWFZCT4oH7kt1pNvS3SA5iGQw=;
 b=Cf4zB10yfQKr4QeqNHwbCVlolADvk6KXzcROcG56kFCoNw0IWXxEj2rOZ+kOGkBDF8
 dR9PXXcK6o/xMJSsr1BrdUjcmqxZLd6IAk1gn8Ncz+yhN+dDCCAErCWDgVP5j/Onj9Lq
 x1qmKagjC1XyS9XHlbSGGQ3VbKcin3djHfaDhFw1cQD0kRiMzrji8Cjzd1Tq9nZZqH77
 Po7VQNA3+uTLJxtaEvrcwCnfYtZgIyRvmxMq2Ck1H+MfsyEzBUKv+MKgVnrhcENVy4WR
 GBJI+/9igmkE+k35by1NEzODSCFUz5CtFQikEEckDNYQnn9gXXxNiPkDE8/LPRDKZX5P
 2iIQ==
X-Gm-Message-State: AOAM531ZzEZJGBMGLcTHt7NCpftIif23hhov1oV72Utu6SbqvLo0ikUZ
 QZTEV70g7LOSH4ByOPeOCm+69VDPm5NqOVPj9duJSXC086QzD8kxmSDuqU50yQmS7FRn0vTS0xA
 aNuat4LQPsuYbM2cdGjShhqahON9k4HImDki8y7DzqNGXebHDAEJYwuZAZw==
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr1508965lfh.471.1647488369634; 
 Wed, 16 Mar 2022 20:39:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK0XzZGn35nasn25rxFzAwhFR/SqzlJeKiaVyEcPcYeD18h4oUG7GAWG/QVUE79bFdBETaLdR8yXIgqxOznS4=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr1508956lfh.471.1647488369460; Wed, 16
 Mar 2022 20:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220315131358.7210-1-elic@nvidia.com>
In-Reply-To: <20220315131358.7210-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Mar 2022 11:39:18 +0800
Message-ID: <CACGkMEuCjdLZ6sRSk3CnH-QVh8wruhJQWFV2fWsujHRvcR0dKg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Update man page with added support to configure max
 vq pair
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, dsahern@kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Tue, Mar 15, 2022 at 9:14 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Update man page to include information how to configure the max
> virtqueue pairs for a vdpa device when creating one.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  man/man8/vdpa-dev.8 | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
> index aa21ae3acbd8..432867c65182 100644
> --- a/man/man8/vdpa-dev.8
> +++ b/man/man8/vdpa-dev.8
> @@ -33,6 +33,7 @@ vdpa-dev \- vdpa device configuration
>  .I MGMTDEV
>  .RI "[ mac " MACADDR " ]"
>  .RI "[ mtu " MTU " ]"
> +.RI "[ max_vqp " MAX_VQ_PAIRS " ]"
>
>  .ti -8
>  .B vdpa dev del
> @@ -119,6 +120,11 @@ vdpa dev add name foo mgmtdev vdpa_sim_net mac 00:11:22:33:44:55 mtu 9000
>  Add the vdpa device named foo on the management device vdpa_sim_net with mac address of 00:11:22:33:44:55 and mtu of 9000 bytes.
>  .RE
>  .PP
> +vdpa dev add name foo mgmtdev auxiliary/mlx5_core.sf.1 mac 00:11:22:33:44:55 max_vqp 8
> +.RS 4
> +Add the vdpa device named foo on the management device auxiliary/mlx5_core.sf.1 with mac address of 00:11:22:33:44:55 and max 8 virtqueue pairs
> +.RE
> +.PP
>  vdpa dev del foo
>  .RS 4
>  Delete the vdpa device named foo which was previously created.
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
