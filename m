Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304DA60B95
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867487; cv=none; b=PQ5yTBNLIM9adBvBo+j8kIiJb3usFozh7gx5ku0xoWawfUJET/UDOByoOlCBaPflf39qLzao/4tYW6xnRj36jLLW5XqKMc0PX6yPu6v8ox1revh8tfMSUYg5tYV3FUN1xzt2UVR4cZZDG+xSrq7GWsNFW/343ZBMn4f1EAjtj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867487; c=relaxed/simple;
	bh=kkqIE0Y4DRPtCUs/sSOoUIPS1FebsbAyD8enDcphis0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyAy3WK4a5NzaY1UVMb++fdeZ+H4+YjEb7IfJes4V0JLWkVGBe491LG6vhfONDybrfxfHawSkSUBZyY5dyz0UDgjWTj+kiktH6UGWS5pzEMts5XJYCYx2Oafj7zgQMBWtHk1iM4leimwoYiZw/g4UIqGVvfa+NKG11aojEoEWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aW9/adHZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aW9/adHZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572256b1636so117598a12.0
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713867483; x=1714472283; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjAI/u9aTsfeTNEAGphzTSvRCRRtKSx3dGfB1X7fHEM=;
        b=aW9/adHZ08WzXp+e8++Ji2ASq8Z5+Z++FRFPQq24UuSaxHsdTz41Vf/J3fED3Vimbb
         /V7eXdpzG8nOmdsfvWzZTnKrfNeo66R4CR7mckgyt6Ull5GZvGKFjxKn6t6f6rfVuVaI
         h2vJEy7Tu6WJPFrMHvd0451qKxEHbvrBt8u8NUBsIYYZOCP0AEdSqPefnpJaeGTmgiyr
         Ouh9yE4SRT3xonJr6tbLpgRyX5Dy3rMwQ/RZNBwNnkqYAphDSoQNUR3nT7jVyVOxTWoP
         Leg59AGQHEhNj08/X3DlwNy6RMYwHUbBM/jNOQT31VhwNNaWiWcYFIY0elts6jcO6lPr
         EQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867483; x=1714472283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjAI/u9aTsfeTNEAGphzTSvRCRRtKSx3dGfB1X7fHEM=;
        b=oA+joTZphZf88BWpI3m/ynrtNiPduVtvoXIffQLCrbWWO08acV4VfY6l3LN5aI3xyK
         4MCfE581cTeM22wsnHcCMPuQnjivPaIJtSdCVld6nWVK/37fVll1BbkojQFUtYw754Vh
         aqIz+xUTauVutKDSXrj/PSRdWr5uVBO0dwoo05CjNrA5Cvy4d1m21C/H3srL6swJm4HA
         sjEV8Ip4cpPuCi0zp26TP3nQJtARidgKNJwnLicesaO0zGouCT/bfgzAcOXkGxmDUJmT
         hlmqx1vkbZvJINOgQEWHwgFie2N17xgSptZ7X80DfB5aVSpdbqExSa/KNFaBqMOgO2mz
         OOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCViIlkaQmqDgU7wFNmHUVVq6YqMRIBpsW2eOI3wx3mlJrYs7zym8Cju5ye4krSLGkJWKgUMKuQDCzWL9CNkKdL3znrPYpPe6AetbvCaFIM=
X-Gm-Message-State: AOJu0YxmPPUAo3u2596TVXHA1nUVRtMG9DUorGgnP1HI6+n7p8PfU6V4
	Zbvtjn+REOl9jeYKGX/IyqXK3/YVjdcWkZOwoeyx+VaZdTJY+kcBp/87YH6nEba6wmFyW3lcfKG
	b
X-Google-Smtp-Source: AGHT+IFrpUA9BGDfzOFgMoFt6BOHOhg8GKgTOgeY0r+LlC7dYpKajZym1moY/r+ox+cVnvAc2GZjxA==
X-Received: by 2002:a50:8ad1:0:b0:56e:428d:77c1 with SMTP id k17-20020a508ad1000000b0056e428d77c1mr8244269edk.36.1713867483066;
        Tue, 23 Apr 2024 03:18:03 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id h4-20020a0564020e0400b00571f140e6b6sm3548863edh.97.2024.04.23.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:18:01 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:17:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio_net: virtnet_send_command supports
 command-specific-result
Message-ID: <ZieK1lmc0czcEXWk@nanopsycho>
References: <20240423084226.25440-1-hengqi@linux.alibaba.com>
 <20240423084226.25440-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423084226.25440-2-hengqi@linux.alibaba.com>

Tue, Apr 23, 2024 at 10:42:25AM CEST, hengqi@linux.alibaba.com wrote:
>From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>The virtnet cvq supports to get result from the device.

Is this a statement about current status, cause it sounds so. Could you
make it clear by changing the patch subject and description to use
imperative mood please. Command the codebase what to do.

Thanks!

>
>Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>---
> drivers/net/virtio_net.c | 24 +++++++++++++++++-------
> 1 file changed, 17 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 7176b956460b..3bc9b1e621db 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
>  * supported by the hypervisor, as indicated by feature bits, should
>  * never fail unless improperly formatted.
>  */
>-static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>-				 struct scatterlist *out)
>+static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd,
>+				       struct scatterlist *out,
>+				       struct scatterlist *in)
> {
>-	struct scatterlist *sgs[4], hdr, stat;
>-	unsigned out_num = 0, tmp;
>+	struct scatterlist *sgs[5], hdr, stat;
>+	u32 out_num = 0, tmp, in_num = 0;
> 	int ret;
> 
> 	/* Caller should know better */
>@@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> 
> 	/* Add return status. */
> 	sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
>-	sgs[out_num] = &stat;
>+	sgs[out_num + in_num++] = &stat;
> 
>-	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
>-	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
>+	if (in)
>+		sgs[out_num + in_num++] = in;
>+
>+	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
>+	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
> 	if (ret < 0) {
> 		dev_warn(&vi->vdev->dev,
> 			 "Failed to add sgs for command vq: %d\n.", ret);
>@@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> 	return vi->ctrl->status == VIRTIO_NET_OK;
> }
> 
>+static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>+				 struct scatterlist *out)
>+{
>+	return virtnet_send_command_reply(vi, class, cmd, out, NULL);
>+}
>+
> static int virtnet_set_mac_address(struct net_device *dev, void *p)
> {
> 	struct virtnet_info *vi = netdev_priv(dev);
>-- 
>2.32.0.3.g01195cf9f
>
>
