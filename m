Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C164EC4332F
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 07:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5456140A02;
	Fri,  4 Mar 2022 07:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vw28xKjx6kXr; Fri,  4 Mar 2022 07:50:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D84C040301;
	Fri,  4 Mar 2022 07:50:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC3D9C001D;
	Fri,  4 Mar 2022 07:50:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94F74C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 07:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F85460F74
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 07:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHPuuvY3mI1d
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 07:50:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 677D460D68
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 07:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646380247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RHT38EAK8wYUL1DGHAhrEW8RVwO4xAs9c9L8nS+s5yk=;
 b=htaabeUWVHhM4SqgizHuWQ7X4Q3HSuw4oixJk7tQj6y0SE58Uq4vXYXnVMT6jZUeo2daCy
 nNr3yJP8/I/RlGrkC/srKXgHx2k/3BS8zdqPQgDy9We0Jg7wF2bLa2zCdiiKpGPHJjP4qU
 WXFNy+jAyuAcoE+2LBiAXttwy47eS0s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-0wrtOjqCNPOSW34T4DZVrg-1; Fri, 04 Mar 2022 02:50:46 -0500
X-MC-Unique: 0wrtOjqCNPOSW34T4DZVrg-1
Received: by mail-qv1-f72.google.com with SMTP id
 x16-20020a0ce250000000b00432ec6eaf85so6179472qvl.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Mar 2022 23:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RHT38EAK8wYUL1DGHAhrEW8RVwO4xAs9c9L8nS+s5yk=;
 b=JqtwakbyqZ23eEBdxI6XHaA/JsNc/DKnNk4vNnaNv1OujuxwsGimJTrLjva8LxOCmO
 HwwYNvLqLRasC2fRPlgQ5nSueLzUR3rKl8c+kLzGXqfN74qtuVzAB32uWUkwummBSqMa
 E1fRNbPKTmf7NEKadQNTXWEFzWHWDzXX+8wb5mK/0K+xtVPY96Ya7O67qsxg6m6dxVAS
 mqHvgKRnCOw+Xvz0UdB8lbDJ0prIUxA4t1BqTQ4Kk9rQo+yBMXBZ4nykAtA9fydyj/9G
 WWEH+TIRqgNy95GWCv9kBW9a9Zt5/F6EweJYiJzv9CnmM8fpL+qOTK+b3X1/OG9MjQoE
 bi0A==
X-Gm-Message-State: AOAM530s2/I8yG7fb0/CUar1D2EW3QQCN2bJxTvfv8MFFMmsHg0Sj+7Z
 Fq4eoLiBn9tnQmRXFrt+hGtI2uH+CrcRKvt7Kh6MlAoILgT7tyOhO5myVReL/RT8yPk+zIDuApG
 on6Pou29wwHeQVzvpzz5Mxy0YdTxzRe/tqW5+dboW0g==
X-Received: by 2002:a37:6808:0:b0:46c:e3c1:7247 with SMTP id
 d8-20020a376808000000b0046ce3c17247mr1770384qkc.770.1646380246247; 
 Thu, 03 Mar 2022 23:50:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMCSQfDu5Agxl+Zrju4icTbzmVnYv6E0GbiwcmRYdI77zGTFN/asNZoAGZHw/6BhY/xu+7Bg==
X-Received: by 2002:a37:6808:0:b0:46c:e3c1:7247 with SMTP id
 d8-20020a376808000000b0046ce3c17247mr1770377qkc.770.1646380245984; 
 Thu, 03 Mar 2022 23:50:45 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 z14-20020a05622a028e00b002dc8e843596sm2953032qtw.61.2022.03.03.23.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 23:50:45 -0800 (PST)
Date: Fri, 4 Mar 2022 08:50:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held
 whilst clean-up in progress
Message-ID: <20220304075039.rewrf3gnbbh3sdfl@sgarzare-redhat>
References: <20220303151929.2505822-1-lee.jones@linaro.org>
 <YiETnIcfZCLb63oB@unreal>
 <20220303155645-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220303155645-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>
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

On Thu, Mar 03, 2022 at 04:01:06PM -0500, Michael S. Tsirkin wrote:
>On Thu, Mar 03, 2022 at 09:14:36PM +0200, Leon Romanovsky wrote:
>> On Thu, Mar 03, 2022 at 03:19:29PM +0000, Lee Jones wrote:
>> > All workers/users should be halted before any clean-up should take place.
>> >
>> > Suggested-by:  Michael S. Tsirkin <mst@redhat.com>
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > ---
>> >  drivers/vhost/vhost.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> > index bbaff6a5e21b8..d935d2506963f 100644
>> > --- a/drivers/vhost/vhost.c
>> > +++ b/drivers/vhost/vhost.c
>> > @@ -693,6 +693,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>> >  	int i;
>> >
>> >  	for (i = 0; i < dev->nvqs; ++i) {
>> > +		/* Ideally all workers should be stopped prior to clean-up */
>> > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
>> > +
>> >  		mutex_lock(&dev->vqs[i]->mutex);
>>
>> I know nothing about vhost, but this construction and patch looks
>> strange to me.
>>
>> If all workers were stopped, you won't need mutex_lock(). The mutex_lock
>> here suggests to me that workers can still run here.
>>
>> Thanks
>
>
>"Ideally" here is misleading, we need a bigger detailed comment
>along the lines of:
>
>/*
> * By design, no workers can run here. But if there's a bug and the
> * driver did not flush all work properly then they might, and we
> * encountered such bugs in the past.  With no proper flush guest won't
> * work correctly but avoiding host memory corruption in this case
> * sounds like a good idea.
> */

Can we use vhost_vq_get_backend() to check this situation?

IIUC all the vhost devices clear the backend to stop the workers.
This is not racy (if we do after the mutex_lock) and should cover all 
cases.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
