Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E0FC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 11:14:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8147C60F46
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 11:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8147C60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2CF7C403E5;
	Tue, 26 Oct 2021 11:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tkMSHrNiHjXB; Tue, 26 Oct 2021 11:14:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F1A240017;
	Tue, 26 Oct 2021 11:14:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50F6CC0012;
	Tue, 26 Oct 2021 11:14:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35A8AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 11:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 105AB80DBE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 11:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tO-cWtJRu7hG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 11:14:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 043DA80DB8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 11:14:28 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 v1-20020a17090a088100b001a21156830bso1930341pjc.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Uay9CbMwX+2O0ogFCTZO+22+pOrDr/HSyVNYJuWbPJM=;
 b=wTbsTpMWtz2u0QXyxWwJhRBj7ddnChMovMZItHWImTK/f9mO8NhRrA6Pz3op87sJii
 NClyz1RI88YScuKoBzVDWgy6fZrG5jvqqkeIaQUuln6qqSZj0X2ELVAyXnaO7bUPq9aC
 1YWZhMoWIY8+D/T/EO3OL7O/aydr466G/KA+z9lc3JB5hjo60vbh1Kvz4YrpzBm1wbP/
 3PZHlQGrL72ToRU479+DVQ6lHY2WBLgHLjhTG7GA/caVd49KmwED3wKe/XanL5FFT5nl
 3cmLWRcOlOTW076t2DcqmEkSAIkPGguFYWC+6Ild/vxmGPKSUFBlesMVC6fbpQPpZbtS
 P6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Uay9CbMwX+2O0ogFCTZO+22+pOrDr/HSyVNYJuWbPJM=;
 b=GkFLJw595+RbQ7gXZy/FUV5GHySF+ovvPqNKHx99wQqkx7luWWvn0QXNqnJ2IDZC3N
 SJpOv+HK4NV28p/023uVIzlo5kWE4yXRDfdnKLI3eNNTIMcZVvIagDiqzuHQYDWbXu1Y
 VkOc5bxhZ/whs8mcNuzeZINsf1EtWflVE+9ifA0SLdwu/8Hku3SNxCLQhH/E4p0lUiR6
 X+WEAou0TvKWZ+959QHtn0olyouedao8MwxkGI0Rmn3oxjADj+XmoppwalDlxFQDC0om
 YIxpnnlUtUftItED9MSL7WNRYZJL5obiQoWqnyn9ESLpwJXs7o8kmfhRUQuV+8f4o1lC
 lU0Q==
X-Gm-Message-State: AOAM532up++HnlSqmCGVbPdd77wuAzN0hujdCTKNz5Vsk8YQ+h2D7tUp
 A9ToZxfJmwIpZ1YCZuDIoN63Ug==
X-Google-Smtp-Source: ABdhPJz5DzSXU7DwLlex+7rlFsYGq6KKZNeMQTh0M9IOLPaXuknmZc5dsUMVK6fUbDZJCpWMYOgv0A==
X-Received: by 2002:a17:90b:38c6:: with SMTP id
 nn6mr12930310pjb.72.1635246868236; 
 Tue, 26 Oct 2021 04:14:28 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id r8sm19409595pgp.30.2021.10.26.04.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Oct 2021 04:14:27 -0700 (PDT)
Date: Tue, 26 Oct 2021 16:44:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] i2c: virtio: Add support for zero-length requests
Message-ID: <20211026111425.nigbol5stajopkrw@vireshk-i7>
References: <7c58868cd26d2fc4bd82d0d8b0dfb55636380110.1634808714.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7c58868cd26d2fc4bd82d0d8b0dfb55636380110.1634808714.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-i2c@vger.kernel.org, stratos-dev@op-lists.linaro.org
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

On 21-10-21, 15:17, Viresh Kumar wrote:
> The virtio specification received a new mandatory feature
> (VIRTIO_I2C_F_ZERO_LENGTH_REQUEST) for zero length requests. Fail if the
> feature isn't offered by the device.
> 
> For each read-request, set the VIRTIO_I2C_FLAGS_M_RD flag, as required
> by the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
> 
> This allows us to support zero length requests, like SMBUS Quick, where
> the buffer need not be sent anymore.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Wolfram,
> 
> Please do not apply this until the spec changes [1] are merged, sending it early
> to get review done. I will ping you later once the spec is merged.
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202110/msg00109.html

Michael,

Can this be merged as well based on the current voting at the ballot ?

https://www.oasis-open.org/committees/ballot.php?id=3659

Wolfram,

I am asking as this patch should be considered as a fix, which needs to be
applied to the 5.15 kernel itself if possible (now or via stable), as we are
implementing a new mandatory feature, which will make the currently merged
version of the driver unusable going forward (since this won't be backwards
compatible).

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
