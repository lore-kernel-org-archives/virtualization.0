Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97DCC433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 15:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49BF060B5E;
	Wed,  2 Mar 2022 15:36:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ejaZshk8GoUj; Wed,  2 Mar 2022 15:36:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D3677608B7;
	Wed,  2 Mar 2022 15:36:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0EE2C0082;
	Wed,  2 Mar 2022 15:36:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BCB1C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 15:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4052B8143E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 15:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6fr-F9zrbJMB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 15:36:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E016381437
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646235411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiWuNUMDb+jMyibsjnWGqQsYAJ9IA+FOAlDaEyD0AQE=;
 b=e1cEDTPxqc0JHEvUHxfuraIli1GbyhjKHnGmwCozmPVtsRD9fyaIwYxvPN5IasRzmVgwvR
 ksZtAXnwW2dxzahV9G97GZctS+Z6I1Eqk+P70g+8jKIOBojQlQvnaIY5QQasbuhzcF+Vb9
 +ePcGkOb/qXLteG0LKqkWpnsHhtFctk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-UQ3_1AjoO-i1UHzrkKmJtg-1; Wed, 02 Mar 2022 10:36:48 -0500
X-MC-Unique: UQ3_1AjoO-i1UHzrkKmJtg-1
Received: by mail-wm1-f70.google.com with SMTP id
 p35-20020a05600c1da300b0038151176781so950758wms.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 07:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HiWuNUMDb+jMyibsjnWGqQsYAJ9IA+FOAlDaEyD0AQE=;
 b=2camtGE5A6FhTe2lhEiYK17+c4blx8iyIVL6Ay7Dx1up/XZhk3E9eNTjFR9dRBipV+
 bwLa7yxnbdXw1+w+DOKTvdh/AwnP8kpBC5CmjmeI12vwQR7m8vkzSHujYeGNaZNUbkuJ
 38hTV0IzGPBo9a1e70JHcE22BoCsdmIXcicb+01fgLFePnRX8y0U8Jkej97wIVrsG++t
 +q8C1Ms32uTehnVpdwek9aTPyupYKjkrXEw8q94LtEV2vsQVb+j54OKqHXN05fLKHfzh
 DR7mg/A+3Z7NmVK0F5MP8/5RtgXGfCkDkMYGUYRQB0xSXS9mPAje0kpctyUwYWRGr0IR
 5nGg==
X-Gm-Message-State: AOAM533PoDC5WGjWm1lsLx6m9ukFsnsNUeYQuv/ru5MObplstYLVm5ML
 FpQNNINBnRkbIgZohXhS/iKt4L9zRYQmiR61nP41CHz0Nua2sJ2PhJ4+b5WXPXxX05HaoUKzkzX
 P3Uf31SXDCW8F9yiFzFwsJWz3qS0gIk1NdU2W6Sql9g==
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id
 j73-20020adf914f000000b001edbb92d0ccmr23760992wrj.297.1646235407399; 
 Wed, 02 Mar 2022 07:36:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOXNVA6Ca35935P9zNNj3hLgvVWqdH+AVRnYEdYqNaoKk8H9E6ae22MHAewrFcGgr/Nliwkg==
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id
 j73-20020adf914f000000b001edbb92d0ccmr23760976wrj.297.1646235407162; 
 Wed, 02 Mar 2022 07:36:47 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 m12-20020a7bcb8c000000b003811afe1d45sm5852294wmi.37.2022.03.02.07.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 07:36:46 -0800 (PST)
Date: Wed, 2 Mar 2022 16:36:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302153643.glkmvnn2czrgpoyl@sgarzare-redhat>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302093446.pjq3djoqi434ehz4@sgarzare-redhat>
 <20220302083413-mutt-send-email-mst@kernel.org>
 <20220302141121.sohhkhtiiaydlv47@sgarzare-redhat>
 <20220302094946-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220302094946-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

On Wed, Mar 02, 2022 at 09:50:38AM -0500, Michael S. Tsirkin wrote:
>On Wed, Mar 02, 2022 at 03:11:21PM +0100, Stefano Garzarella wrote:
>> On Wed, Mar 02, 2022 at 08:35:08AM -0500, Michael S. Tsirkin wrote:
>> > On Wed, Mar 02, 2022 at 10:34:46AM +0100, Stefano Garzarella wrote:
>> > > On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
>> > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
>> > > > to vhost_get_vq_desc().  All we have to do is take the same lock
>> > > > during virtqueue clean-up and we mitigate the reported issues.
>> > > >
>> > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
>> > >
>> > > This issue is similar to [1] that should be already fixed upstream by [2].
>> > >
>> > > However I think this patch would have prevented some issues, because
>> > > vhost_vq_reset() sets vq->private to NULL, preventing the worker from
>> > > running.
>> > >
>> > > Anyway I think that when we enter in vhost_dev_cleanup() the worker should
>> > > be already stopped, so it shouldn't be necessary to take the mutex. But in
>> > > order to prevent future issues maybe it's better to take them, so:
>> > >
>> > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> > >
>> > > [1]
>> > > https://syzkaller.appspot.com/bug?id=993d8b5e64393ed9e6a70f9ae4de0119c605a822
>> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9
>> >
>> >
>> > Right. I want to queue this but I would like to get a warning
>> > so we can detect issues like [2] before they cause more issues.
>>
>> I agree, what about moving the warning that we already have higher up, right
>> at the beginning of the function?
>>
>> I mean something like this:
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 59edb5a1ffe2..1721ff3f18c0 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -692,6 +692,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>>  {
>>         int i;
>> +       WARN_ON(!llist_empty(&dev->work_list));
>> +
>>         for (i = 0; i < dev->nvqs; ++i) {
>>                 if (dev->vqs[i]->error_ctx)
>>                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
>> @@ -712,7 +714,6 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>>         dev->iotlb = NULL;
>>         vhost_clear_msg(dev);
>>         wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
>> -       WARN_ON(!llist_empty(&dev->work_list));
>>         if (dev->worker) {
>>                 kthread_stop(dev->worker);
>>                 dev->worker = NULL;
>>
>
>Hmm I'm not sure why it matters.

Because after this new patch, putting locks in the while loop, when we 
finish the loop the workers should be stopped, because vhost_vq_reset() 
sets vq->private to NULL.

But the best thing IMHO is to check that there is no backend set for 
each vq, so the workers have been stopped correctly at this point.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
