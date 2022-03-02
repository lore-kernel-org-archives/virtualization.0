Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F06C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 14:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3C48817AD;
	Wed,  2 Mar 2022 14:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k5YwNezJkGV8; Wed,  2 Mar 2022 14:11:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 80D7481764;
	Wed,  2 Mar 2022 14:11:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45906C0012;
	Wed,  2 Mar 2022 14:11:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 178E4C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA5FC40492
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FMEtzQ3GI4zP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:11:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8F254048A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646230292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zki/Dz8/SB2dieRvsIUHk7QNqNrRAue+WSnk+jKK4oo=;
 b=XD8QbHf0TZQuSiinancoTUAergOvIy0SEatz1Filgtx18AL2gwGTp6JD9osiUAtAj2tHRB
 fmSs4M2GhrNu77gJAXn79LrKhEM2kB8xl7DSsIkOzzUP6ipiJL0luonHV7dwd9qAYdRjdh
 V6SuNhDcU5hJpGjUadeKVXzoCPtl1ow=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-YPzjV3hqNwqz4sFA5XU38w-1; Wed, 02 Mar 2022 09:11:28 -0500
X-MC-Unique: YPzjV3hqNwqz4sFA5XU38w-1
Received: by mail-qt1-f200.google.com with SMTP id
 g6-20020ac87d06000000b002ddaaeacb91so1338195qtb.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 06:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Zki/Dz8/SB2dieRvsIUHk7QNqNrRAue+WSnk+jKK4oo=;
 b=6eKzXKeqKs5fpskXxSjwMm2QLuUA0cJxAQezuYOsniMgZQw0zTk4ipytIKOyIOg8O1
 /MDscDnX0vmGs6B9mU83YwFieeW+Iyy6JP/HUx2PXbHZqG/4Sp5ux2UG5S5UA1CfYK+K
 LC8PbuhZZPxLcnq2ccixkRWt80TB/H4wVsgKwwop7fCHwi3NQtDn523U3O9+7CPI188/
 rc3oREEQ0TfMUwcSobrXYkzKE92vr8BfrjiAc7MRj/QnmDXx7/K6DYcR5zo5eLOs9qdM
 Aju5uJ9wC9iZZUJdwpZSAm+sqZ3oTESHEmBEoFGeMu8DWxEyJBwil5B3HngZojcBiIFO
 4FNQ==
X-Gm-Message-State: AOAM5301xHn2K2QfVm2sUzjxE9yxoM1Evb2RTFznD94wxBx+rbGfIsYL
 9YokUXgc0GO5o3YngUAErTd/JETCD0cTqLSi31hHX7SG1GIuXEhAfT7C/pZGy0aQaerW6BZpgt6
 RBl74DVlhTyV4xfwPpdgqpfKOVCS5IwIBorr8phoFqQ==
X-Received: by 2002:ac8:7fca:0:b0:2de:8f3d:89be with SMTP id
 b10-20020ac87fca000000b002de8f3d89bemr24147747qtk.34.1646230287713; 
 Wed, 02 Mar 2022 06:11:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZ7kQbxyiazMoeLWG0fZ0hHibPi3bReSoEzb74TshqNyIXX6z6vntalQDbAmbzJRmBH10EiA==
X-Received: by 2002:ac8:7fca:0:b0:2de:8f3d:89be with SMTP id
 b10-20020ac87fca000000b002de8f3d89bemr24147720qtk.34.1646230287418; 
 Wed, 02 Mar 2022 06:11:27 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 c18-20020ac87dd2000000b002dd53a5563dsm11954035qte.25.2022.03.02.06.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 06:11:26 -0800 (PST)
Date: Wed, 2 Mar 2022 15:11:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302141121.sohhkhtiiaydlv47@sgarzare-redhat>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302093446.pjq3djoqi434ehz4@sgarzare-redhat>
 <20220302083413-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220302083413-mutt-send-email-mst@kernel.org>
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

On Wed, Mar 02, 2022 at 08:35:08AM -0500, Michael S. Tsirkin wrote:
>On Wed, Mar 02, 2022 at 10:34:46AM +0100, Stefano Garzarella wrote:
>> On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
>> > vhost_vsock_handle_tx_kick() already holds the mutex during its call
>> > to vhost_get_vq_desc().  All we have to do is take the same lock
>> > during virtqueue clean-up and we mitigate the reported issues.
>> >
>> > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
>>
>> This issue is similar to [1] that should be already fixed upstream by [2].
>>
>> However I think this patch would have prevented some issues, because
>> vhost_vq_reset() sets vq->private to NULL, preventing the worker from
>> running.
>>
>> Anyway I think that when we enter in vhost_dev_cleanup() the worker should
>> be already stopped, so it shouldn't be necessary to take the mutex. But in
>> order to prevent future issues maybe it's better to take them, so:
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> [1]
>> https://syzkaller.appspot.com/bug?id=993d8b5e64393ed9e6a70f9ae4de0119c605a822
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9
>
>
>Right. I want to queue this but I would like to get a warning
>so we can detect issues like [2] before they cause more issues.

I agree, what about moving the warning that we already have higher up, 
right at the beginning of the function?

I mean something like this:

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..1721ff3f18c0 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -692,6 +692,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
  {
         int i;
  
+       WARN_ON(!llist_empty(&dev->work_list));
+
         for (i = 0; i < dev->nvqs; ++i) {
                 if (dev->vqs[i]->error_ctx)
                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
@@ -712,7 +714,6 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
         dev->iotlb = NULL;
         vhost_clear_msg(dev);
         wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-       WARN_ON(!llist_empty(&dev->work_list));
         if (dev->worker) {
                 kthread_stop(dev->worker);
                 dev->worker = NULL;


And maybe we can also check vq->private and warn in the loop, because 
the work_list may be empty if the device is doing nothing.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
