Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED71C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 14:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60E32414CC;
	Wed,  2 Mar 2022 14:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrnSUmmUwpdE; Wed,  2 Mar 2022 14:50:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 12EA8409A0;
	Wed,  2 Mar 2022 14:50:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF875C0012;
	Wed,  2 Mar 2022 14:50:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25470C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11E194048A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:50:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GfY_FiMwhhLU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:50:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEAC740184
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646232652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyTbPbzLV6BhTjCf6yQIefb7DNZSD/rDYL7+DnSGw1A=;
 b=ioXQKy+pwmyvTLD0cGwZhrvMg0aG/jR+eBqkGUkTmyUUvKp7i8Mes3fBeGLjY8MF0wOBiu
 2Emnso66btynrpZI4kzzlQZL79DDs6GIogfBp7O6DodOT4nJHPyWNVHg76XuXdpSeJNaXp
 t1RERIngYIhLY5siG7dcU/yZ12zWToY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-HjNySuPCPquVdUYe_0jCEw-1; Wed, 02 Mar 2022 09:50:43 -0500
X-MC-Unique: HjNySuPCPquVdUYe_0jCEw-1
Received: by mail-wr1-f72.google.com with SMTP id
 a5-20020adfdd05000000b001f023fe32ffso715922wrm.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 06:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vyTbPbzLV6BhTjCf6yQIefb7DNZSD/rDYL7+DnSGw1A=;
 b=8LeH/q/Y7sJd+7IQppqIwgw5IBSQqUZKsXwDg5+PM/fEEfYV0vpK0xGozF5R5k1CKV
 OBvYzIie7TrjAAfXSnzf2jU/6hRm7DyRqTYLm+KgbLlHPEUoec3/9fsmBNYivQijYDOz
 86XMnopaiOV+1/8zdLJXvajKi3R/mLdTBxYjoRb8eG/bXCii+hYDneZAmnmiiZLONksD
 06lVmPyFpO0qiwpn5flWLRZYZG4ohm8UeyO778kruh1LQ4QG+BPm4COIBz3WgwoKx3q6
 9b6IWZmWtKDwq/gta7mmnMmOBNFWx6eeYkR6FApBqqfcABKpkX+01QrjYQySULCM52Y3
 HhmQ==
X-Gm-Message-State: AOAM532xSMau7ijVyHV+kJRHDkTER7A8H/LLlwYAQKau5AMv/AdezWbV
 0BOvkC+gaLbgVoeEKdPAvT22OUA/bZsgRF5F92/zx+2uyMA6TYrne4fN/Oo2yytkcARDm5EaXGD
 d7uXiJU5WU2CzPMhdcI7PeUAKxDfOESVFiRC4dUBFKQ==
X-Received: by 2002:adf:f550:0:b0:1f0:2381:ac2c with SMTP id
 j16-20020adff550000000b001f02381ac2cmr4323640wrp.189.1646232642006; 
 Wed, 02 Mar 2022 06:50:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQNu/fXS905mfblMrRA5G2rPob+EQ5Bu1JcHzO8Z63AfxXQlVwQA2iUhIru+dm9U5yRai4qA==
X-Received: by 2002:adf:f550:0:b0:1f0:2381:ac2c with SMTP id
 j16-20020adff550000000b001f02381ac2cmr4323627wrp.189.1646232641759; 
 Wed, 02 Mar 2022 06:50:41 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 k19-20020adfd233000000b001f0358e47bdsm1971249wrh.50.2022.03.02.06.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 06:50:41 -0800 (PST)
Date: Wed, 2 Mar 2022 09:50:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302094946-mutt-send-email-mst@kernel.org>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302093446.pjq3djoqi434ehz4@sgarzare-redhat>
 <20220302083413-mutt-send-email-mst@kernel.org>
 <20220302141121.sohhkhtiiaydlv47@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220302141121.sohhkhtiiaydlv47@sgarzare-redhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 02, 2022 at 03:11:21PM +0100, Stefano Garzarella wrote:
> On Wed, Mar 02, 2022 at 08:35:08AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Mar 02, 2022 at 10:34:46AM +0100, Stefano Garzarella wrote:
> > > On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
> > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > > > to vhost_get_vq_desc().  All we have to do is take the same lock
> > > > during virtqueue clean-up and we mitigate the reported issues.
> > > >
> > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > > 
> > > This issue is similar to [1] that should be already fixed upstream by [2].
> > > 
> > > However I think this patch would have prevented some issues, because
> > > vhost_vq_reset() sets vq->private to NULL, preventing the worker from
> > > running.
> > > 
> > > Anyway I think that when we enter in vhost_dev_cleanup() the worker should
> > > be already stopped, so it shouldn't be necessary to take the mutex. But in
> > > order to prevent future issues maybe it's better to take them, so:
> > > 
> > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > [1]
> > > https://syzkaller.appspot.com/bug?id=993d8b5e64393ed9e6a70f9ae4de0119c605a822
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9
> > 
> > 
> > Right. I want to queue this but I would like to get a warning
> > so we can detect issues like [2] before they cause more issues.
> 
> I agree, what about moving the warning that we already have higher up, right
> at the beginning of the function?
> 
> I mean something like this:
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..1721ff3f18c0 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -692,6 +692,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  {
>         int i;
> +       WARN_ON(!llist_empty(&dev->work_list));
> +
>         for (i = 0; i < dev->nvqs; ++i) {
>                 if (dev->vqs[i]->error_ctx)
>                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
> @@ -712,7 +714,6 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>         dev->iotlb = NULL;
>         vhost_clear_msg(dev);
>         wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
> -       WARN_ON(!llist_empty(&dev->work_list));
>         if (dev->worker) {
>                 kthread_stop(dev->worker);
>                 dev->worker = NULL;
> 

Hmm I'm not sure why it matters.

> And maybe we can also check vq->private and warn in the loop, because the
> work_list may be empty if the device is doing nothing.
> 
> Thanks,
> Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
