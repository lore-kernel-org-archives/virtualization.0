Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2576EC433FE
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 08:09:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAED26137F
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 08:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAED26137F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 754AD60673;
	Tue, 19 Oct 2021 08:09:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tStpb3uVaSIR; Tue, 19 Oct 2021 08:09:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F32760B16;
	Tue, 19 Oct 2021 08:09:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8D63C0027;
	Tue, 19 Oct 2021 08:09:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B9E6C0026
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDD42404CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15DI0UjWPkt0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:09:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC28C404CF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:09:16 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id o133so16932155pfg.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gj+IjdwtpSoU7uXOoxinPHHGnAi13nWqEOcSDstepQk=;
 b=F3ZWHZrZGIo4fL4XNTI5PKIk2fc+8OHzj4mZeLmgAUHn+40G6TRfdl2q2peQ5dX1d0
 boz4hwjWY4imzL3aipUGIUhwrTsMIoelvjqp2GMEret6+qnUsBIkXhnEFuWfcFViizgr
 7gmo1RJcAJPGc4HvDfxxjYTDiGnN79mSlhkSI0gB8HfT5T0rnkZW6STiavTMFf2hAyva
 u7/ZW8iRALoIpfm2vMxhveqHSO8N9PwWBMnc6k+tc4qEkE8sH4CkhmpF9n1NtgFzDwe6
 Ms9VJGvhA+4cJ97hJRAHKYgtghKmyVTJD563R2hhbAYD5bhImnMygnxjASZFmIu2niRi
 a4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gj+IjdwtpSoU7uXOoxinPHHGnAi13nWqEOcSDstepQk=;
 b=iV5wDAYS+lWDEDL4hZXsx/8bdtAWojEvx0tTJFtS40ZixbKKvCTuMboKKAaIjq+vHe
 99U4ZFbleoOETVniydlYkdVdEWZcNZzBfwdI/HUGxHDGg1/mxfgb53TiryIdGN1bBsZz
 f7AcqOsXHT8ntKlAxoucE39iPMLYu0D4AzqyCIg3YD/Kc2v84SNBa6ZHk7Q4QKhD33e9
 1+hOhDarALCsaknr8IE1vHMT7peI29PmjLpx9xVE93Mn5r/215ISvtDEzOeBy7wbz7Pm
 coPmbUZOh6RQCgBzlSpzkG0ESeVbg/RnKXjbNwYtomWpDybFhImEUKHzVtOjgaczwHhD
 ISlg==
X-Gm-Message-State: AOAM530kucjTOHMVceM3P4PEqpIvagzAW7BtN1g6fD9vdivjECHDB+9n
 YAXV/qngZUnn0WaCJmCl/6Tywg==
X-Google-Smtp-Source: ABdhPJz5JKUnGVnJdr/vOWsWzz9hNwGVMVhXP2Wre7zIFrVbrX2b84fVwC13u/6EoqaE4W9pCK83xA==
X-Received: by 2002:a63:7b1e:: with SMTP id w30mr8237662pgc.464.1634630956083; 
 Tue, 19 Oct 2021 01:09:16 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id ls7sm1831782pjb.16.2021.10.19.01.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 01:09:14 -0700 (PDT)
Date: Tue, 19 Oct 2021 13:39:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211019074647.19061-2-vincent.whitchurch@axis.com>
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

+Greg.

On 19-10-21, 09:46, Vincent Whitchurch wrote:
> If a timeout is hit, it can result is incorrect data on the I2C bus
> and/or memory corruptions in the guest since the device can still be
> operating on the buffers it was given while the guest has freed them.
> 
> Here is, for example, the start of a slub_debug splat which was
> triggered on the next transfer after one transfer was forced to timeout
> by setting a breakpoint in the backend (rust-vmm/vhost-device):
> 
>  BUG kmalloc-1k (Not tainted): Poison overwritten
>  First byte 0x1 instead of 0x6b
>  Allocated in virtio_i2c_xfer+0x65/0x35c age=350 cpu=0 pid=29
>  	__kmalloc+0xc2/0x1c9
>  	virtio_i2c_xfer+0x65/0x35c
>  	__i2c_transfer+0x429/0x57d
>  	i2c_transfer+0x115/0x134
>  	i2cdev_ioctl_rdwr+0x16a/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
>  Freed in virtio_i2c_xfer+0x32e/0x35c age=244 cpu=0 pid=29
>  	kfree+0x1bd/0x1cc
>  	virtio_i2c_xfer+0x32e/0x35c
>  	__i2c_transfer+0x429/0x57d
>  	i2c_transfer+0x115/0x134
>  	i2cdev_ioctl_rdwr+0x16a/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
> 
> There is no simple fix for this (the driver would have to always create
> bounce buffers and hold on to them until the device eventually returns
> the buffers), so just disable the timeout support for now.

That is a very valid problem, and I have faced it too when my QEMU
setup is very slow :)

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index f10a603b13fb..7b2474e6876f 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -106,11 +106,10 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>  
>  static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  				    struct virtio_i2c_req *reqs,
> -				    struct i2c_msg *msgs, int num,
> -				    bool timedout)
> +				    struct i2c_msg *msgs, int num)
>  {
>  	struct virtio_i2c_req *req;
> -	bool failed = timedout;
> +	bool failed = false;
>  	unsigned int len;
>  	int i, j = 0;
>  
> @@ -132,7 +131,7 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  			j++;
>  	}
>  
> -	return timedout ? -ETIMEDOUT : j;
> +	return j;
>  }
>  
>  static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> @@ -141,7 +140,6 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	struct virtio_i2c *vi = i2c_get_adapdata(adap);
>  	struct virtqueue *vq = vi->vq;
>  	struct virtio_i2c_req *reqs;
> -	unsigned long time_left;
>  	int count;
>  
>  	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
> @@ -164,11 +162,9 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	reinit_completion(&vi->completion);
>  	virtqueue_kick(vq);
>  
> -	time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
> -	if (!time_left)
> -		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
> +	wait_for_completion(&vi->completion);

Doing this may not be a good thing based on the kernel rules I have
understood until now. Maybe Greg and Wolfram can clarify on this.

We are waiting here for an external entity (Host kernel) or a firmware
that uses virtio for transport. If the other side is hacked, it can
make the kernel hang here for ever. I thought that is something that
the kernel should never do.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
