Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00C0C433FE
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 15:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67B9640496;
	Mon, 21 Feb 2022 15:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x1_K4NTXZQTc; Mon, 21 Feb 2022 15:22:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2ED54036A;
	Mon, 21 Feb 2022 15:22:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91BF1C001A;
	Mon, 21 Feb 2022 15:22:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44358C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36F1A40374
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tJ5l-Z3M0TWj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:22:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3970B4036A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645456967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=//ocvqSZP1Bqt7GMZm3TubXy/TDW1Bh0IsBpphamyS8=;
 b=BagCvN9rijsNLaF0wSP0StIFvllM0l55zLs3DVuaccagTTCPlgnARZXEPaCchDmdfnK9Ce
 L7tv15crHNEhCp3dT2PDvrJ6z0tQyPoiBNIYEV+TqnDd4ZemK38TrFKZ7QyxnycKCYAvrj
 pDo+gB+tmzKXJNTSCGzpFWNd+ivsJrI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-Fuh3e0aNPZmmCa8Nb1wVGQ-1; Mon, 21 Feb 2022 10:22:45 -0500
X-MC-Unique: Fuh3e0aNPZmmCa8Nb1wVGQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 i188-20020a1c3bc5000000b0037bb9f6feeeso8155189wma.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=//ocvqSZP1Bqt7GMZm3TubXy/TDW1Bh0IsBpphamyS8=;
 b=aCIPbURLtq/h1LjS54DvpnrsAJ8kMcU8FepIHA5s3WK5zOVs1FsHE2gLPje7yDIgvd
 6p+W9pXwDmrw5OOaKKRwJYcuqkWYjcLCkSEJRqZaVe47lrwWtzzaK2m+loqQt+C2vTj0
 tdu2bINxhO3zKJMhKDD/ny5ZW9LRIZvtzMvTSGpAa2aMATMH5FAERk7KQFNGR0QLL1sy
 pVAxEtRCURX3tXe5ZSiSpWTQu+3gPDHNDQoWqGOMTN4hEjUDNj6NKoxhFy2cDjhANtrP
 I4NLW66xb+COLMqbvTfumSbMmpFaz7RNefkdG2YZoJJT7UsSTCX74JL+PlE/+jFLZnIk
 zPrg==
X-Gm-Message-State: AOAM5328QGMt2IGhxcI9GMSDlWR1OwoV6wkDRNotrDT4IiavJPqU8sCy
 Ph5Mwd+j8JBFSB0dnhOZqM2txQO6h9+m1Nhge02hY3NVkhCvhkHUiR8g7UUOaQvA5hC0DGHGJkG
 7io9ejGDHlrzxFt98npi6aytCX1KsufgygsGpNFdClg==
X-Received: by 2002:adf:f3cc:0:b0:1e7:4fd9:6fd3 with SMTP id
 g12-20020adff3cc000000b001e74fd96fd3mr15663040wrp.266.1645456964078; 
 Mon, 21 Feb 2022 07:22:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRe76b/qP2XEzCDRn/yzRVG9vTAJA8nQ+6DymsN10XGTOpBA26zz1vt6D+IC5eOeVGMUheYA==
X-Received: by 2002:adf:f3cc:0:b0:1e7:4fd9:6fd3 with SMTP id
 g12-20020adff3cc000000b001e74fd96fd3mr15663016wrp.266.1645456963802; 
 Mon, 21 Feb 2022 07:22:43 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 j5-20020a05600c410500b0037bc3e4b526sm7745956wmi.7.2022.02.21.07.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 07:22:43 -0800 (PST)
Date: Mon, 21 Feb 2022 16:22:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <20220221152240.nbdthe4grii577zd@sgarzare-redhat>
References: <20220221114916.107045-1-sgarzare@redhat.com>
 <20220221094829-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220221094829-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Asias He <asias@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 21, 2022 at 10:03:39AM -0500, Michael S. Tsirkin wrote:
>On Mon, Feb 21, 2022 at 12:49:16PM +0100, Stefano Garzarella wrote:
>> vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
>> ownership. It expects current->mm to be valid.
>>
>> vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
>> the user has not done close(), so when we are in do_exit(). In this
>> case current->mm is invalid and we're releasing the device, so we
>> should clean it anyway.
>>
>> Let's check the owner only when vhost_vsock_stop() is called
>> by an ioctl.
>
>
>
>
>> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vhost/vsock.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index d6ca1c7ad513..f00d2dfd72b7 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -629,16 +629,18 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>>  	return ret;
>>  }
>>
>> -static int vhost_vsock_stop(struct vhost_vsock *vsock)
>> +static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>
>>  {
>>  	size_t i;
>>  	int ret;
>>
>>  	mutex_lock(&vsock->dev.mutex);
>>
>> -	ret = vhost_dev_check_owner(&vsock->dev);
>> -	if (ret)
>> -		goto err;
>> +	if (check_owner) {
>> +		ret = vhost_dev_check_owner(&vsock->dev);
>> +		if (ret)
>> +			goto err;
>> +	}
>>
>>  	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>>  		struct vhost_virtqueue *vq = &vsock->vqs[i];
>> @@ -753,7 +755,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>>  	 * inefficient.  Room for improvement here. */
>>  	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
>>
>> -	vhost_vsock_stop(vsock);
>
>Let's add an explanation:
>
>When invoked from release we can not fail so we don't
>check return code of vhost_vsock_stop.
>We need to stop vsock even if it's not the owner.

Do you want me to send a v2 by adding this as a comment in the code?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
