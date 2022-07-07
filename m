Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6B9C43334
	for <virtualization@archiver.kernel.org>; Thu,  7 Jul 2022 05:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47D9960E2A;
	Thu,  7 Jul 2022 05:10:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47D9960E2A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V/OriaIk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Axxy1Tw1OvnL; Thu,  7 Jul 2022 05:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A76AE60D6F;
	Thu,  7 Jul 2022 05:10:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A76AE60D6F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88E52C0033;
	Thu,  7 Jul 2022 05:10:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC146C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F9CD41697
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:10:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F9CD41697
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V/OriaIk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Am8PJG3vMcGB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:10:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 250AE415F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 250AE415F8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657170603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9lzc6w/Opw97U2hLgEhRkh2O+cH+saQhnPq0SCuszs=;
 b=V/OriaIkWqHwdmsvYEflLAVu58Yupx/DNNbJ4TNj/GctUvfZmzqgqIVv+YKBkbjMxnOzpV
 GbI27rpmFEtGITRt0S7riz+nNPCax5qLlP6cIxxhXoYzqUWZtnl3gmLdN2xmcTEqXnHrlz
 5gmPo8KBMUxpjt32x775nIH6SjHhZok=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-HufBJuusPpiNdgAPSPMC6A-1; Thu, 07 Jul 2022 01:10:00 -0400
X-MC-Unique: HufBJuusPpiNdgAPSPMC6A-1
Received: by mail-ed1-f70.google.com with SMTP id
 m20-20020a056402431400b0043a699cdd6eso7285404edc.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jul 2022 22:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u9lzc6w/Opw97U2hLgEhRkh2O+cH+saQhnPq0SCuszs=;
 b=vUNgUo88FNxJpNIHvV5RpUt952wFHS34fvX4YCiY14wktoJy5Wm2f/1bhIs6ZCFB2E
 mQImAfxJ1p6zB3jiRM9eOKLFHc3g72mrDfs2vQTMviCOzKfh76Nqfi11NIWGeXrIgXPW
 eCv36LtWL5664zm3fPq4yDAX/nv/h6phm+KlwFb7mIp9qex5hX9CygZ8MGao4dyQYygA
 k9DSiRNAG94gCl4PPa3iLCceLoumwzn/qOUt3G564Pg2mUz1sh3etiUuRzzS4iGFCh0H
 DoGhbnk5nXlZbzk2R6rGCzb95n3o5UEOKYCDvB+fvNixBe2ow2flW61FfBpU4jGbRYyF
 X31Q==
X-Gm-Message-State: AJIora9x6B7kwBrGlPpLbZW1qkC3q6/VZJ8I6jPbfKu5Eunk55xLi4hM
 uxFxaoo2b7NKqJbRatPYVZSaPZlIDBFIwElOQM4mRk30rKqGmjEwNEXRZ0UDxXZ/52v0gyQl4kL
 E9XuOukIyAd7HIBBQiy1pVipdWSPLK7RkIWS1TrsHQw==
X-Received: by 2002:a05:6402:3705:b0:43a:214b:5f40 with SMTP id
 ek5-20020a056402370500b0043a214b5f40mr30738832edb.83.1657170599292; 
 Wed, 06 Jul 2022 22:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sohhdZNZE7c0EBG3VjG+K42I/xUZSo8tDQCDdtJmisQuBT4yRmnBw6C2WBL3mzB4KECJQUsw==
X-Received: by 2002:a05:6402:3705:b0:43a:214b:5f40 with SMTP id
 ek5-20020a056402370500b0043a214b5f40mr30738812edb.83.1657170599059; 
 Wed, 06 Jul 2022 22:09:59 -0700 (PDT)
Received: from redhat.com ([2.52.154.68]) by smtp.gmail.com with ESMTPSA id
 b4-20020a1709065e4400b00706287ba061sm18290813eju.180.2022.07.06.22.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 22:09:58 -0700 (PDT)
Date: Thu, 7 Jul 2022 01:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: Re: [PATCH v2 2/4] virtio_test: move magic number in code as defined
 constant
Message-ID: <20220707010036-mutt-send-email-mst@kernel.org>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-3-qtxuning1999@sjtu.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20220707024409.1869-3-qtxuning1999@sjtu.edu.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Thu, Jul 07, 2022 at 10:44:07AM +0800, Guo Zhi wrote:
> We should avoid using magic numbers directly.

Not necessarily. For repeated values - I guess.
But this kind of thing:

	#define BUF_SIZE 1024
	int buf_size = BUF_SIZE;

brings no benefit IMHO.

And this has cost - values are now removed from code.


> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  tools/virtio/virtio_test.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 95f78b311..1ecd64271 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -20,7 +20,10 @@
>  #include "../../drivers/vhost/test.h"
>  
>  #define RANDOM_BATCH -1
> -
> +#define ALIGN 4096
> +#define RINGSIZE   256
> +#define TEST_BUF_NUM 0x100000
> +#define BUF_SIZE   1024
>  /* Unused */
>  void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
>  
> @@ -100,8 +103,8 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
>  	if (info->vq)
>  		vring_del_virtqueue(info->vq);
>  
> -	memset(info->ring, 0, vring_size(num, 4096));
> -	vring_init(&info->vring, num, info->ring, 4096);
> +	memset(info->ring, 0, vring_size(num, ALIGN));
> +	vring_init(&info->vring, num, info->ring, ALIGN);
>  	info->vq = __vring_new_virtqueue(info->idx, info->vring, vdev, true,
>  					 false, vq_notify, vq_callback, "test");
>  	assert(info->vq);
> @@ -115,7 +118,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
>  	info->idx = dev->nvqs;
>  	info->kick = eventfd(0, EFD_NONBLOCK);
>  	info->call = eventfd(0, EFD_NONBLOCK);
> -	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> +	r = posix_memalign(&info->ring, PAGE_SIZE, vring_size(num, ALIGN));
>  	assert(r >= 0);
>  	vq_reset(info, num, &dev->vdev);
>  	vhost_vq_setup(dev, info);

This is actually doing more than what commit log says.

> @@ -131,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>  	dev->vdev.features = features;
>  	INIT_LIST_HEAD(&dev->vdev.vqs);
>  	spin_lock_init(&dev->vdev.vqs_list_lock);
> -	dev->buf_size = 1024;
> +	dev->buf_size = BUF_SIZE;


This seems to have zero added value.

>  	dev->buf = malloc(dev->buf_size);
>  	assert(dev->buf);
>          dev->control = open("/dev/vhost-test", O_RDWR);
> @@ -396,7 +399,8 @@ int main(int argc, char **argv)
>  
>  done:
>  	vdev_info_init(&dev, features);
> -	vq_info_add(&dev, 256);
> -	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
> +	vq_info_add(&dev, RINGSIZE);
> +
> +	run_test(&dev, &dev.vqs[0], delayed, batch, reset, TEST_BUF_NUM);
>  	return 0;


This replacement does not buy us anything either.

>  }
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
