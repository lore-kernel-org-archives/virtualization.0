Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9A5C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 17:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEBB141B5B;
	Thu,  2 Feb 2023 17:32:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEBB141B5B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZW7zXFRV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4mJpGR7Obfjm; Thu,  2 Feb 2023 17:32:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 66C9141B57;
	Thu,  2 Feb 2023 17:32:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66C9141B57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C2DCC0033;
	Thu,  2 Feb 2023 17:32:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 446CAC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F75961195
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:32:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F75961195
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZW7zXFRV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xhxlGxuKoSV3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:32:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F1DA61185
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F1DA61185
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675359130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cAKUGmodg4IRX1hPLMrz7uTyPgg2ivvgeN6HaVeWe+E=;
 b=ZW7zXFRVb6x+OYR0dD5MMjPXT2rLX0xPdlEO7gCbD/bF4HWRZ2Em5knNEhJWiMRc6FE7nR
 PwnhXTeGuobynul1outs1W6teVRQ+X1c3BzNg+gkGrZGvYCajJ/odkwD+1hkx+5nE2MPYC
 189Jg5k9UXn0303Ibm0I7j0Y7GkN31A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-282-cX-nPoWFMDqrbGCy-g9Uow-1; Thu, 02 Feb 2023 12:32:08 -0500
X-MC-Unique: cX-nPoWFMDqrbGCy-g9Uow-1
Received: by mail-ed1-f70.google.com with SMTP id
 m23-20020aa7c2d7000000b004a230f52c81so1918425edp.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 09:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAKUGmodg4IRX1hPLMrz7uTyPgg2ivvgeN6HaVeWe+E=;
 b=FPpduR9lN4YfzV9/GF7S5ggyLO/3RUnW3JEw2VsszwiXdb/oVXfrWrksD6aBtrNxxS
 Q0u7j3R1c7ILUgLbS5+Upl8+BNXRdo0IldqoN5RPOfw2DBpzWy5ooBTc/4Q5k3kYioHN
 si6XewrFAkyLVr+w6OlaYSfLRvyPonhFwgEV2eA51ajZRk7Kbb5SrwQdSa2j+I9WNALV
 o7C7JUZ9FbwiqAsb1Zc6/VKcNgyM8qusoLKxfBx2kMAJF2Ghe8suIMZ2cXj1kGtcfv+p
 jcM43FyEu+2mzeDGQpXFoBg2bqi1Gn7mwqlNh9UOmtNdvBLBkgfLB0vVQ4KV6sF2Mvks
 6sKQ==
X-Gm-Message-State: AO0yUKVzlV3KiB6saoDzyH96bhNOE9rlWH1ow0z2xbpRcxXe/gxT9KPL
 LZ0dDqguFHHmJ86bC3rMEYQ30R0CapiHYwWwzAA2hvbYt7vOIiwPLgpspigYAKHOBKCfwDt/bNV
 qN/sgYqYjKAUP1bhJmRofhi/mG2/tFipyMJzoGrMa4Q==
X-Received: by 2002:a17:906:f0f:b0:878:572b:8ffb with SMTP id
 z15-20020a1709060f0f00b00878572b8ffbmr2321069eji.72.1675359127724; 
 Thu, 02 Feb 2023 09:32:07 -0800 (PST)
X-Google-Smtp-Source: AK7set814grh/B0gFF2lHfKdKmP7hDQcPriv/Ppwx2OKqUQo7xYH1W1GRl0FIPl+8F0vOvvHLvBZNw==
X-Received: by 2002:a17:906:f0f:b0:878:572b:8ffb with SMTP id
 z15-20020a1709060f0f00b00878572b8ffbmr2321060eji.72.1675359127576; 
 Thu, 02 Feb 2023 09:32:07 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 p23-20020a1709061b5700b0086f4b8f9e42sm78415ejg.65.2023.02.02.09.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 09:32:06 -0800 (PST)
Date: Thu, 2 Feb 2023 12:32:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Directly assign memory key
Message-ID: <20230202123132-mutt-send-email-mst@kernel.org>
References: <20230202125718.1013961-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230202125718.1013961-1-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Feb 02, 2023 at 02:57:18PM +0200, Eli Cohen wrote:
> When creating a memory key, the key value should be assigned to the
> passed pointer and not or'ed to.
> 
> This fix has is required but had no real impact so far.

I don't get what this sentence says. Both grammar and general meaning
elude me.

> Fixes: 29064bfdabd5 ("vdpa/mlx5: Add support library for mlx5 VDPA implementation")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/resources.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> index 9800f9bec225..45ad41287a31 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -213,7 +213,7 @@ int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, u32 *mkey, u32 *in,
>  		return err;
>  
>  	mkey_index = MLX5_GET(create_mkey_out, lout, mkey_index);
> -	*mkey |= mlx5_idx_to_mkey(mkey_index);
> +	*mkey = mlx5_idx_to_mkey(mkey_index);
>  	return 0;
>  }
>  
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
