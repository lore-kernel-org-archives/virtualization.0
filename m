Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5141C4332F
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 02:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CB8340664;
	Fri,  3 Dec 2021 02:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id loHyiA2hE9rl; Fri,  3 Dec 2021 02:37:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B23A1405D6;
	Fri,  3 Dec 2021 02:37:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89342C0012;
	Fri,  3 Dec 2021 02:37:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 752ACC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C55683495
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IP3CJNWJWVZS
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:37:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF4E283490
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638499067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TzI3S6jLbjqCRmP0AD+xPnjjYGdclGIRvo1UazljKDQ=;
 b=iLGVhJptIjCc6bMHJSXgkr+bqna4HS1XFbQQeYvn7kdRJfWIjQyXVkltGBMfWVBQAI91MG
 epJ7r5dD2Tdx0HqTbOMgl8RKQUBIoF7k71530LYrzNooKuR88fy9tE1QEguUDmywKj/Ppg
 Ymryqhb+8J52h2MTDRXIRufDr4IxoPI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-Opz2R6aUOOCegR2ORirjDw-1; Thu, 02 Dec 2021 21:37:45 -0500
X-MC-Unique: Opz2R6aUOOCegR2ORirjDw-1
Received: by mail-lf1-f69.google.com with SMTP id
 s18-20020ac25c52000000b004016bab6a12so474457lfp.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Dec 2021 18:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TzI3S6jLbjqCRmP0AD+xPnjjYGdclGIRvo1UazljKDQ=;
 b=dgSVkgNfIq+GNVPCxOMDNLVieBD4uM0nh2IKgqasytEEl1kP0vAJlKAvKud09WxPEn
 FgCne4IZpXPLAFmtbArQu6kp3aNfL3dx8RSl/Q9QccFvngeAv4MYd13d7UZl93x4YCkC
 zLd5qKEG8ze+s7HY5Fy30iRhaEMmMezRbJrorg9mWIKkmKa7KfOK60vk23+odGkAKLq7
 nV8OdxdBEk9ypn2IZQp3NslOy7I5og++jG+Oxa5bAuMHoJ/SM51Wrxxf1vr+Wy9G9nu/
 iwiAcuE0TzANIxje0eB9FG5d1OCYYfSaKfCjskcCyfLPF93mNa2AdouA4oe9FLIb/UC9
 APIQ==
X-Gm-Message-State: AOAM532r8afyjYwxHa//u18dBlse3/tQWByw9+A7v2rheJnbfEvcc8bG
 BD0AGzxFH3YKQRdE5JvxWA3UnxucL2t2Ab8w2VT0VsDlCAXPaFdckhd8txbBTmoJN8igFekIjUd
 AYrSu/N8LB1xQDxfN1tywKnHkHOWIAR+jJHamqICqaUtkKJfAY0i9uR6MPQ==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr15405466lfv.629.1638499064382; 
 Thu, 02 Dec 2021 18:37:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/XJjW0jiXhkYE2FIsyAX9Eum3nax80wLh+Mmzlbc6Q4yLINzTuvAGl7JCw3cT0aEyWTwZcJkgFLgHQKQfknw=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr15405452lfv.629.1638499064205; 
 Thu, 02 Dec 2021 18:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-8-elic@nvidia.com>
In-Reply-To: <20211201195724.17503-8-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 3 Dec 2021 10:37:33 +0800
Message-ID: <CACGkMEt1+P0eyCdbXH=2wZ4N=gk-pZfovKSOamciHLXqBQKf_Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] vdpa/mlx5: Restore cur_num_vqs in case of failure in
 change_num_qps()
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Thu, Dec 2, 2021 at 3:58 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Restore ndev->cur_num_vqs to the original value in case change_num_qps()
> fails.
>
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 81a602ff68b5..baeff15d4b95 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1552,6 +1552,8 @@ static int change_num_qps(struct mlx5_vdpa_dev *mvdev, int newqps)
>         for (--i; i >= cur_qps; --i)
>                 teardown_vq(ndev, &ndev->vqs[i]);
>
> +       ndev->cur_num_vqs = 2 * cur_qps;
> +
>         return err;
>  }
>
> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
