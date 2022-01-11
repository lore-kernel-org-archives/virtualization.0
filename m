Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ED7C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 15:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 662E6408BF;
	Tue, 11 Jan 2022 15:58:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lEhoG5uW0_a3; Tue, 11 Jan 2022 15:58:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D269B408B6;
	Tue, 11 Jan 2022 15:58:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB0CDC0030;
	Tue, 11 Jan 2022 15:58:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2D5FC001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2AE582796
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9gah-YAjDNCT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:58:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B292827BB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641916683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qQPu632SLEDKKCOlJeD3lJKkFALflLSysLUmGXuCiSo=;
 b=ESndo8k1qqvF16zqdBdxnYowpjrQQm8zfOrO9mkKdeHOwCFOgf0AktZnTlE4IW9Ke3uYT4
 Fn5EX9Wm8Aev3iA1vWL1ZCeg1apcbBWE+Acfcfm+9OhBH39ebvGLg67w1LEPrKGVPfHLVb
 tUu3JrFs1a/jYXGWtsW6dt7Ns0qZEoE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-pB63P82xMheXkI1hvX6kcg-1; Tue, 11 Jan 2022 10:58:02 -0500
X-MC-Unique: pB63P82xMheXkI1hvX6kcg-1
Received: by mail-wm1-f72.google.com with SMTP id
 i81-20020a1c3b54000000b003467c58cbddso1766673wma.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 07:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qQPu632SLEDKKCOlJeD3lJKkFALflLSysLUmGXuCiSo=;
 b=527OJ373NlRtcPTkVH5JULDDhlWhhECTNcD9g3UkvfBEVdp3ymzM662zZxEmZYCYst
 6/dITYCx1YDlC0IL+TIsQwcwpQuCcbUlY4cdYXKTMHG+qExAwsqfbAZnEVirmsiS2p7r
 /yu87RypaV1/KyMnxVf3qQMfl6nASDkXRpCOO1prEyFx9D8u6AW5+JOTYx8FLb34LAQO
 f4Ptj5lX4GDEQcBNRTiKVR3ZldsfaQvgBc5nYRN0dYd/dtYOkQqA+G5oMZYQtrHYNHgA
 pqCv0MmAr4KNkLXR8+lSi4ckVuGgkbj/sdFis8I/i+MIvMsGcwDdnXFWhh3pZjnBzapl
 vkrw==
X-Gm-Message-State: AOAM5307Taq7bzjFBcdV8sXTLAo487G7Yizsk+B1kIhXz6Ksz0NdHS7T
 X9xEobEH/EuMQo11gf4RqlA7Poci4hU9sZz/byXzSSWB939VVbgadkgJCVflBe55KM9jhRHAL3P
 6BseCiC1qEUGI18RnImLCpsbCT5/DRFNPXKmLx4+Qrg==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr4639697wrz.350.1641916681543; 
 Tue, 11 Jan 2022 07:58:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyExHjHI7RFbME/MwdI7EOsz8mxyGLFWb4Sh/pvCko3vEKlLATCJSsuPF2DU3sP/EtlA7QpIg==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr4639677wrz.350.1641916681312; 
 Tue, 11 Jan 2022 07:58:01 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id p18sm2961279wmq.0.2022.01.11.07.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 07:58:00 -0800 (PST)
Date: Tue, 11 Jan 2022 10:57:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 2/4] vdpa/mlx5: Fix is_index_valid() to refer to features
Message-ID: <20220111105509-mutt-send-email-mst@kernel.org>
References: <20220111072253.101884-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220111072253.101884-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, si-wei.liu@oracle.com
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

On Tue, Jan 11, 2022 at 09:22:53AM +0200, Eli Cohen wrote:
> Make sure the decision whether an index received trough a callback is

through

> valid or not consults the negotiated features.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Which commit does this fix?

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index d1ff65065fb1..9eacfdb48434 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -133,10 +133,14 @@ struct mlx5_vdpa_virtqueue {
>  
>  static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>  {
> -	if (unlikely(idx > mvdev->max_idx))
> -		return false;
> +	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> +		if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +			return idx < 2;
> +		else
> +			return idx < 3;
> +	}
>  
> -	return true;
> +	return idx <= mvdev->max_idx;
>  }
>  
>  struct mlx5_vdpa_net {
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
