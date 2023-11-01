Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E494AC4332F
	for <virtualization@archiver.kernel.org>; Wed,  1 Nov 2023 05:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59A0A847BA;
	Wed,  1 Nov 2023 05:33:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59A0A847BA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFoieUlh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XfnbcB6fIZrA; Wed,  1 Nov 2023 05:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A9C3C847B9;
	Wed,  1 Nov 2023 05:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9C3C847B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8000DC0072;
	Wed,  1 Nov 2023 05:33:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B237C0072
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 05:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49A6D6FB86
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 05:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49A6D6FB86
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFoieUlh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PSuY7oAMsCek
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 05:33:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42E766FB87
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 05:33:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42E766FB87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698816798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rDjrgwKhV0X8uxDqmbjmkhKFvllwLl3UFb2d3q6wJf0=;
 b=AFoieUlhJRiWnlWfcrq88PHXwct6Lnv8TONw/bFEFAhlAsbtJ6nW2fd8Cmj1SB3/hXfph6
 JOoIKdByCPIPK1hVhLadwzQqTkeEpXW3p9vvM6+16sCet0mIYBVjvZks2lwxgQ5NLzOQ2E
 alQlS/lgDjW4yEjFGit0a9x3vO4RUyw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-VDfKk-w-MuuER6m2Vk76Gw-1; Wed, 01 Nov 2023 01:33:16 -0400
X-MC-Unique: VDfKk-w-MuuER6m2Vk76Gw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c50cec5d29so55887041fa.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 22:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698816795; x=1699421595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDjrgwKhV0X8uxDqmbjmkhKFvllwLl3UFb2d3q6wJf0=;
 b=Z3L8TFJMhINhjesl9mpA8I3ySIPtfjCf8FvGfuvp+gbaOWMT5ow9cDSGrrhRlSM0j5
 niANhIa30OZbnQK97Awjn8nyZl7EzlBei5JjOae88+nvNS1DQc7HcaVGeDcPjsqSfezp
 EJobfdv/Mgsvrq+IGfgKtYTZmUj3ns9nAANAYI/8aCtWIs21Bqs0CHKal1DDmiDmot6m
 7noSrv56txYgEHbwq+MzcNYpRK+YEabRPPhcpyhw/d0X8DGUbUYCfRVvlUjoyAL47sln
 59dSkgvBMMCabNMQSiWoMUz68ionkE7uLOBdPfzND+TsvHXgYk5WF7OwKL075qgx9iNY
 uXHQ==
X-Gm-Message-State: AOJu0YybKOdyZygqS0UYRB+UOdEIN7i/n7PkKnSD+r/cYM3BI0Zrb9+4
 9Qq/9xAo2iZ4wk5Fad1WXTEn967ggZNeY1Y6EWzhugSt5bPJ4Hi0XB2+Ih49vVqkJDlCb9aHPeI
 b5r3G9/ZTiBhynOg3AYL5BjDmWM2vsXZq1S3g1WXUJw==
X-Received: by 2002:a2e:9812:0:b0:2c5:2661:ca06 with SMTP id
 a18-20020a2e9812000000b002c52661ca06mr11925687ljj.46.1698816795393; 
 Tue, 31 Oct 2023 22:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdJKneWa6ZspieVJDbbOlVQ+x9L/r+0QQ7YYcFs15rRPnwA70wPVRW0dWuTfkT8+oyMFvGtg==
X-Received: by 2002:a2e:9812:0:b0:2c5:2661:ca06 with SMTP id
 a18-20020a2e9812000000b002c52661ca06mr11925671ljj.46.1698816795061; 
 Tue, 31 Oct 2023 22:33:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:14b6:b6f1:4797:8f5d:fa41])
 by smtp.gmail.com with ESMTPSA id
 fk15-20020a05600c0ccf00b0040849ce7116sm204668wmb.43.2023.10.31.22.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 22:33:14 -0700 (PDT)
Date: Wed, 1 Nov 2023 01:33:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-XXX] vhost-vdpa: fix use after free in
 vhost_vdpa_probe()
Message-ID: <20231101013303-mutt-send-email-mst@kernel.org>
References: <cf53cb61-0699-4e36-a980-94fd4268ff00@moroto.mountain>
MIME-Version: 1.0
In-Reply-To: <cf53cb61-0699-4e36-a980-94fd4268ff00@moroto.mountain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Bo Liu <liubo03@inspur.com>
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

On Fri, Oct 27, 2023 at 03:12:54PM +0300, Dan Carpenter wrote:
> The put_device() calls vhost_vdpa_release_dev() which calls
> ida_simple_remove() and frees "v".  So this call to
> ida_simple_remove() is a use after free and a double free.
> 
> Fixes: ebe6a354fa7e ("vhost-vdpa: Call ida_simple_remove() when failed")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

queued, thanks!

> ---
>  drivers/vhost/vdpa.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 9a2343c45df0..1aa67729e188 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1511,7 +1511,6 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  
>  err:
>  	put_device(&v->dev);
> -	ida_simple_remove(&vhost_vdpa_ida, v->minor);
>  	return r;
>  }
>  
> -- 
> 2.42.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
