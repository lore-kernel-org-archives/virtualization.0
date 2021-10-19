Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3CAC433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 08:22:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34A161390
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 08:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C34A161390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B689406DB;
	Tue, 19 Oct 2021 08:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id St4OuNNGd6WP; Tue, 19 Oct 2021 08:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F75F40697;
	Tue, 19 Oct 2021 08:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0A4AC0011;
	Tue, 19 Oct 2021 08:22:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71677C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60683406A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d55vTuWCemuZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:22:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40D8140697
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:22:14 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id m14so16947691pfc.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Q4dXGZ3NpyXYFT6kSbI1+eF5ag5MVYmMy9y0dVt/g1s=;
 b=o5XP+ARvD/j0GyX9i6mY9geDotz1RLUZEED7x6esrPwjcyJt6NzkfSbG4x5elr8b24
 53kNa/hUilDY98HVZCh2IAE5+5wGFoMhkC05QzwjQTnVDJIBIRnGkHLGMriEIf+vvHI1
 qkMPKQCwdhllpvD8qowPHfCwjC2VfdsQ4HusggJwM8VlayAC7Xeox45lL3Mm0LGW4VOa
 PICfuwFx6yGs4nECVC+1WleqSl1u9v9Ti/dMxprOJITzMsibt4tylswFBWs/3ZOazJlY
 QveEBQ5UbjFYiMXEaK0otoh7ZH9uQ/cW+MlhXOGZTQ8Y+MCwMcxKlNiKMXifigrai2E6
 mYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q4dXGZ3NpyXYFT6kSbI1+eF5ag5MVYmMy9y0dVt/g1s=;
 b=YnPFaxAHF7CSnUG5UeAVe1F/7H3dzK0SaywtcGTImwFZyN+ARZqp9Ohg7KxrbhbZn9
 M/4RrWY/+hf6nyVYGPh0rRZFB76eXDJAnZMF4ZYXsgCDoAWixjmNCA6brIPKqNilrrrm
 QIRWHqxbw0RiwEhoFdoPCVc/+sJfi2FJDf+eiOEMPfTaB3mv3RF28LSciYOs8p5FD9Oj
 9qzcLfte+C76xbkypS3E2mbraGe377O/P8UD9ggUgx4b+zlW/hThqMgWxHejUU66m633
 WHBGY/rVWzCOoMMAOZFCtrhnojSM6fpiMhpSDUN0llorTfbxowxCkMqWjVZi1M6enzVG
 YeEw==
X-Gm-Message-State: AOAM533EXK73+0OnT+s1lP70duvfUC9f7kBOQk5N2mHUOuq7FyqqFi/V
 5i5u2BQjNQLKpDEKB5RDciNKAw==
X-Google-Smtp-Source: ABdhPJx66YQtym98ASzCKZD8wkXrms3VZUZjaMJ52yR55kR/QXQmtyXnOwevtdfvnUQ36QXKW6UTIA==
X-Received: by 2002:a05:6a00:124e:b0:44d:cb39:40f6 with SMTP id
 u14-20020a056a00124e00b0044dcb3940f6mr12053599pfi.22.1634631733568; 
 Tue, 19 Oct 2021 01:22:13 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id h1sm9040268pfi.168.2021.10.19.01.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 01:22:13 -0700 (PDT)
Date: Tue, 19 Oct 2021 13:52:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
Message-ID: <20211019082211.ngkkkxlfcrsvfaxg@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211019074647.19061-3-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, kernel@axis.com, linux-i2c@vger.kernel.org
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

On 19-10-21, 09:46, Vincent Whitchurch wrote:
>  static void virtio_i2c_msg_done(struct virtqueue *vq)
>  {
> -	struct virtio_i2c *vi = vq->vdev->priv;
> +	struct virtio_i2c_req *req;
> +	unsigned int len;
>  
> -	complete(&vi->completion);
> +	while ((req = virtqueue_get_buf(vq, &len)))
> +		complete(&req->completion);

Instead of adding a completion for each request and using only the
last one, maybe we can do this instead here:

	while ((req = virtqueue_get_buf(vq, &len))) {
                if (req->out_hdr.flags == cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT))
                        complete(&vi->completion);
        }

Since we already know which is the last one, we can also check at this
point if buffers for all other requests are received or not.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
