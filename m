Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3F1C7EE2F
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 16:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 502DB4033C;
	Fri,  9 Jun 2023 16:13:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 502DB4033C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D8S7a501
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8sDb1pto2nVL; Fri,  9 Jun 2023 16:13:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C58E4032B;
	Fri,  9 Jun 2023 16:13:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C58E4032B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76AFAC007A;
	Fri,  9 Jun 2023 16:13:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86611C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6128860BD2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6128860BD2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D8S7a501
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EajzOlC6GKkQ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:13:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA98960B9D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA98960B9D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686327202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0D0fx1mFB/JV/q+hvvzbZ4BbnjjH4XlfjQ5soZ7CGmE=;
 b=D8S7a501JNFuJdUf0CSInZL7Pme5X0QodUWsUfwJYD62fFeAZwyqtRDYAW76bEBTzATnxX
 RefTsHQxSeqIpeimeMo+naH3y8JoCftroQTmKkpJnbmA9ni6VumO3ckoS7PRqtQDTQdoeS
 pbQ/DmePAM6lXX7it15JPa+IeEpRjPE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ZPZN16oSMc-P12f9yv7UqQ-1; Fri, 09 Jun 2023 12:13:21 -0400
X-MC-Unique: ZPZN16oSMc-P12f9yv7UqQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f7ebe8523eso7548925e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 09:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686327200; x=1688919200;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0D0fx1mFB/JV/q+hvvzbZ4BbnjjH4XlfjQ5soZ7CGmE=;
 b=L4D9zaTQylXCN3H9zAMK2bV2nnozXrK/RHG3B4D8mHCT6skrGbYhToq6h5cmGqUEXd
 PAa8miAZoiLSCbwODoS4GkUTalCvChUh++jQ1XqifWauAwqJa/f7HeCvSbAFvy/4em/P
 8EC0YE6046BFYgZv8ogU5BaoYIkdd9nrGa8V1pCnfYGabiCozaV+jHjQXd7CsJWw2ugz
 ubRW3VISpkwj4xIyaUY8v3pYEx9WNT8Nw7sylLOUrX0VdYy8/7CpxlIv2E/G1VA0U6tE
 1eQpasYM05IFFHZmWCLDsAfPwA7fmJEgR29xox5x903Dlu9UwvZ+dDN6Ik0a0TEYPuTt
 xrjQ==
X-Gm-Message-State: AC+VfDyLam0QLziuKiiQKnojTKPI+jT4AYPUOG08UwYEb3qEYk2I9YZR
 yn8L6Yys+iC2iTu20gvkhnGS+agVPaFl2VlPzWksqooaLMYUbcqLOQPcfvYWaUA/wsQe9HCPH/X
 txJwq2eCom7dsEhGrllNwno7hS7d5JDkzFEDxNsshaA==
X-Received: by 2002:a1c:7903:0:b0:3f5:60b:33 with SMTP id
 l3-20020a1c7903000000b003f5060b0033mr1210760wme.5.1686327199938; 
 Fri, 09 Jun 2023 09:13:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PvTuWonpbAPcqcGK+Qy57af6UFWRA4xTXacgkC8KC6k77AUEeUdQkIRV+Tm1Yn4p/8VPllg==
X-Received: by 2002:a1c:7903:0:b0:3f5:60b:33 with SMTP id
 l3-20020a1c7903000000b003f5060b0033mr1210743wme.5.1686327199617; 
 Fri, 09 Jun 2023 09:13:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a1c6a1a000000b003f7ea771b5dsm3187488wmc.1.2023.06.09.09.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 09:13:19 -0700 (PDT)
Date: Fri, 9 Jun 2023 12:13:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2 2/4] vdpa: accept
 VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
Message-ID: <20230609121244-mutt-send-email-mst@kernel.org>
References: <20230609092127.170673-1-eperezma@redhat.com>
 <20230609092127.170673-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230609092127.170673-3-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>,
 linux-api@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 longpeng2@huawei.com, Liuxiangdong <liuxiangdong5@huawei.com>,
 linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jun 09, 2023 at 11:21:25AM +0200, Eugenio P=E9rez wrote:
> Accepting VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature if
> userland sets it.
> =

> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> Acked-by: Shannon Nelson <shannon.nelson@amd.com>

I don't get it, so all vdpa devices accept this automatically?
Should this not be up to the parent?

> ---
>  drivers/vhost/vdpa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bf77924d5b60..a3204406b73d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -680,7 +680,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>  			return -EFAULT;
>  		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
>  				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> -				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
> +				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
> +				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
>  			return -EOPNOTSUPP;
>  		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>  		     !vhost_vdpa_can_suspend(v))
> -- =

> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
