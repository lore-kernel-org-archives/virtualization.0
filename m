Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BE305958
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240813; cv=none; b=d1fLUbSiq7n+JteM8JuvNLJPgJN4pJHZC1ydLcQggljhe3NoUP7eJyN1wf+6Xij9Qmx9NK273H4jzlSgPuAVDz77EmcJ44RquwZBZPMGnn4smuqcHYyGrma5yZ/Hcd3Gd2Lb2HuJ/ecv5Q1nyQztScYeGD0lr8GA3aHbyrLehPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240813; c=relaxed/simple;
	bh=v7mUg8o5d4YbnHuWnnfU7f+zdxtoURTUi+W59zuTfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UM2hGtwZKJM1G3zh5Swdw92koIHqctA2cbqDiIpVUWxkrjfRJ5rFrBwaaT6iSDZwWo39p9U3LXowH4nswRpjYDgquCuaHZ6nhHMYUkli0nLIjxfW8uLwSeiqcP9x/APmPsyBS75wQzoufELvHYSvV9kJLRfJVeEipB5nfHhE+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfnX4izk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfnX4izk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762240810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73YCUBj4jfpBlE2x+0rguaM2jWl3OFSkZTRKpIlgxow=;
	b=DfnX4izk23fzRgiV+dhemWzTSYr5UBTRGGlI6/a2mRTbuLibd32mngw4VLM5aIgbngsteb
	yHBcrbzmql4mHjjrw1bPa6m4faHZfyyOmrB83DyMVrRpTCcA1qiIjBYdOOJNgw0mE7sWJm
	UB72yHnkEUVAtvvD1Vws0jcK4Vz8SN0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-B0A4sIFIONeBFTQTT14m5g-1; Tue, 04 Nov 2025 02:20:09 -0500
X-MC-Unique: B0A4sIFIONeBFTQTT14m5g-1
X-Mimecast-MFC-AGG-ID: B0A4sIFIONeBFTQTT14m5g_1762240808
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cd08586cso1137003f8f.3
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 23:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762240808; x=1762845608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73YCUBj4jfpBlE2x+0rguaM2jWl3OFSkZTRKpIlgxow=;
        b=QDCnK3u62GomZ3PE5/jDENo3jHGVpC+B2AtjLfQSMqdmtI3rcbHzHhgrwWMR5SoWRy
         Yn31nnEOWOS7XjXDz/IK/86wKABBWbNRptIgAvFBLXeaZmzC83KV+PY4V+CWhEBWNF7n
         zSwMiX2Frvxxug3epWyKLBQTv2F9Izb07oZwNysS6dU5yr+gxieCiL3hcizgP/o4C5cJ
         sqI/hThuPunXU2nQO5W/p0qCOw0W0+fxABlKwE5aSP5ZEuLIsOCnwWMMmzJkq1YvSmeC
         kIGnW4hZa3a6nvU/wq8ET7LZ7eakFbdNGa/+jX/VzsmkVjJ0rZmaXZvKfmhFbyRJW8s1
         YWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9wOVRd/OGBBvr/bPcgmPZDCrK+AC1wSpKBGiCXr7VQ8lxOwez3CTJ5vp/lMvQAxnxiahcy0usUovYL2aEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYqebJZ2CEwU9rKHnQP7rUoGGfOois9NPn43lr5N1A7iAWPym4
	8pY0svRdzHWQH5S3IiA0nkSOjfJdt2MgqL9mmGXcvbHmvaudIZSYDNKa4xRq5jt+UQJ5VZKy8+v
	HqRJucg8Lmb6POnY630sCKwLRlzXHH3zYvEgyDeoB7jQGX/+iVdvaVcYHJuppE0HHRPXa
X-Gm-Gg: ASbGncuXtCxfnFR1edBQ6JGVIorigqhtoU8S3Q3iJqDE0zsGXwnzbhy5SSNpqf2bLm7
	YudCZnugaa1NnN7JCSk3QAPqquDr7YORmAAQEXicwWkIJiDjwkPwuAVWu1efGawK8bTK+9aVKjH
	p7hX3a7qfJjEANJ46nNyRgRq2XybV6zLmFW9c+saFuRSR8Jah8k9OUHXYLz8Machg+uUae1FHoV
	wDvDZPnTzf7pud8NeU5IgRJRoQcEaqSdL/HGUfpcqub9O1v9wx0vevEMJlzBSjRHTFupmR4fUDJ
	rsEMVe7aWVjLP+ezTsDu5jRpjQmWi1Cvx6Vy8K4q8ciznNh2C0bPdxanEeiEBHE=
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr13671413f8f.10.1762240807866;
        Mon, 03 Nov 2025 23:20:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9No17j+8sKvTu81QHfZyLpwKipzhcNFRu6WF9IdUgkLA/8mjSFSLTp3MyIpE+dprvQRAAig==
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr13671379f8f.10.1762240807302;
        Mon, 03 Nov 2025 23:20:07 -0800 (PST)
Received: from redhat.com ([31.187.78.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fbeadsm2857277f8f.37.2025.11.03.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:20:06 -0800 (PST)
Date: Tue, 4 Nov 2025 02:20:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Fix a typo error in virtio_net
Message-ID: <20251104021953-mutt-send-email-mst@kernel.org>
References: <20251103074305.4727-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251103074305.4727-1-chuguangqing@inspur.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: toI8lqx8rZ71O4aIFly9CvgJHkmebEuVy0ltuM8McnY_1762240808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2025 at 03:43:05PM +0800, Chu Guangqing wrote:
> Fix the spelling error of "separate".
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---

Acked-by: Michael S. Tsirkin <mst@redhat.com>

>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..1e6f5e650f11 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3760,7 +3760,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	 * (2) no user configuration.
>  	 *
>  	 * During rss command processing, device updates queue_pairs using rss.max_tx_vq. That is,
> -	 * the device updates queue_pairs together with rss, so we can skip the sperate queue_pairs
> +	 * the device updates queue_pairs together with rss, so we can skip the separate queue_pairs
>  	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>  	 */
>  	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
> -- 
> 2.43.7

