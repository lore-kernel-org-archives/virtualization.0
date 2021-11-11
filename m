Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04CFC433F5
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 16:46:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEB561002
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 16:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DEB561002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2590781852;
	Thu, 11 Nov 2021 16:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S_DJoMJZmC58; Thu, 11 Nov 2021 16:46:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C821D81516;
	Thu, 11 Nov 2021 16:46:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 929B6C001F;
	Thu, 11 Nov 2021 16:46:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AE72C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 797EE8174C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-YCvzx1zs9V
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:46:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4EF581516
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636649171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fA0i4I2sJQvNiM1THao7+ZG2wZ9nUHKTkW18M399t/8=;
 b=K+AWjPPazzGeEE2hLou/p9lG0eqm5Z+zS6E+JYq5ezCbBKS17FJUniZbY4ufGNxtwc3zEc
 kYAIWhnSwm8w2TJIS/gTL+RL3bPo4XCzedLu08NeZhyIxq/yQP6ODedsls90S0xcZyjycW
 fMN86icy5NqvIyRvlJ/y5Nvg+dRP/DI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-fazv5pRmMymBEmY9uZ-64Q-1; Thu, 11 Nov 2021 11:46:10 -0500
X-MC-Unique: fazv5pRmMymBEmY9uZ-64Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 v10-20020a1cf70a000000b00318203a6bd1so2926059wmh.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 08:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fA0i4I2sJQvNiM1THao7+ZG2wZ9nUHKTkW18M399t/8=;
 b=Dg22nA/iolTbceidlEmX57DwrrSt6WgVYbAmwVdRjMcqEPNisopg7Ki+cgt9s5Ru0/
 ayreOMtVrEXjcYdrLnC5ZhBV1he33eO4OGTIQXDiobDT9dEByMYdaYgVlKE5JAVv1q47
 Ua6CR+6PBgE+hYK1OZNSZkQBn4lqhWX2daaw46Zqnb0AzPJyjQwLiRhchsP7N2diEgm2
 9wYr1+ZzeYL3djY3DnqTbuT/7NC235UOJ3nc6IXeVqglluiTReHYQuJPjiAjH2qH/hVg
 K2GxdmKmGXEDmA/X3fLg9MDzdX1tAd+oHVdHTG07pJx7XJNp/4IGRawSpqj62SoYwoc5
 BXyQ==
X-Gm-Message-State: AOAM5327SVpKC2urpLmEs5wrX+JZ4fM+IaPf8jA18Lhu6JR2BuWodzFG
 NhfSnzADYPVk/cMi1IK6wdrh1b+CmTZXsagz78AHnRi4EuTwh7+XuNimH7fxyNiSemHzYUOC7tv
 +kH4Nt+qWoqUYmltzidIt/lDS8vuLdr2s2hj1Hnl8pw==
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr10340643wrx.173.1636649168169; 
 Thu, 11 Nov 2021 08:46:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKRZDaiYOBTv5xC4SSYkhznLpliqsStYNu35LyQ+ZrmZjgf7f0+en9CTvLiG3noAEvPWA86w==
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr10340607wrx.173.1636649167942; 
 Thu, 11 Nov 2021 08:46:07 -0800 (PST)
Received: from redhat.com ([2.55.135.246])
 by smtp.gmail.com with ESMTPSA id z12sm3408376wrv.78.2021.11.11.08.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Nov 2021 08:46:07 -0800 (PST)
Date: Thu, 11 Nov 2021 11:46:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211111114434-mutt-send-email-mst@kernel.org>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211111160412.11980-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
In-Reply-To: <20211111160412.11980-2-vincent.whitchurch@axis.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org, kernel@axis.com,
 linux-i2c@vger.kernel.org, conghui.chen@intel.com
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

On Thu, Nov 11, 2021 at 05:04:11PM +0100, Vincent Whitchurch wrote:
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
> 
> Fixes: 3cfc88380413d20f ("i2c: virtio: add a virtio i2c frontend driver")
> Acked-by: Jie Deng <jie.deng@intel.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

For an eventual fix, I think you'd have to reset the device,
then you can get free up the outstanding buffers.
This has to be done carefully to make sure it does
not race with interrupts and/or new requests, typically
not easy.

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
>  
> -	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count, !time_left);
> +	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
>  
>  err_free:
>  	kfree(reqs);
> -- 
> 2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
