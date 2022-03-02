Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF2EC433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 13:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9173760B78;
	Wed,  2 Mar 2022 13:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9otQ7WYmR4D; Wed,  2 Mar 2022 13:35:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 222B560B50;
	Wed,  2 Mar 2022 13:35:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E55BDC0082;
	Wed,  2 Mar 2022 13:35:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E8CEC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1ECEC409A1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:35:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LW3sQkzanccB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:35:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BD48409A0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646228117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGrF2OvOB13H8iRdKK89NaWHd3b3kdRWqVVkxfYHHl8=;
 b=RI4mYJmT3Ag+hpmLwatUIFZMP/krm0s5jkdMmF5GUQ+ihxDrZKu2McM3XXt46OckgramN3
 O8lHTaYz4IlabNfsw6H+BcBTPk3LcoAylGawdaQ8otEQrIQkpjyc3sS8eAHi+MIgvRh+J9
 akhf8L9XbfW/O91mgiO2yXVw3zhGbEE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-da2WBwUhNzKQvjgXokXz3A-1; Wed, 02 Mar 2022 08:35:14 -0500
X-MC-Unique: da2WBwUhNzKQvjgXokXz3A-1
Received: by mail-wm1-f70.google.com with SMTP id
 j42-20020a05600c1c2a00b00381febe402eso1502417wms.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 05:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XGrF2OvOB13H8iRdKK89NaWHd3b3kdRWqVVkxfYHHl8=;
 b=mrGgdBGtXvHQ6uOLw2OzB6SdYEXn4NXIyyyFQ/NvelfvG7MPkf52f+RtfHulHpO7jS
 oSiSB+77sJrAVBMIeriQSuHCJf8Q2cextYuOMtQ9tzz/wXDgMPWsuAUzYbYVOBliWIjq
 Maz327jvhGAcIQ4fdqIHonxZJdz4/45Zo8bGbvlz82miduSThC9gcU4r70+VWJy0w0Oh
 rbn0LCcfLL8eJU4NzwGek5EhbqMnp5+0f600mMrilVliIOorfi8ABqyuO2Lfvj+/eY+f
 V5e99iD1mHrvAFV3t7vI6KxclPnCF8haypGwNvXqvjQzjV0+ko5P0BcGmjNEkm+YkFmr
 ep6g==
X-Gm-Message-State: AOAM533h+Rm/fkp4dv253G/EmLEFH2vP2qAsyUFgGYwYCRuQDp6LlMDZ
 xuCovEMfaszzQAAx3fG7JnfifdNoQ3Un2hBpIkR05YpUEtB4mTC3O8FKfk6JynsmPEHGefotNxS
 aQ9tNl1TGzXGlzRDxMUIHtrxufT92Gybztu35Ib3eWg==
X-Received: by 2002:a5d:6083:0:b0:1ef:761f:521f with SMTP id
 w3-20020a5d6083000000b001ef761f521fmr18980615wrt.238.1646228112084; 
 Wed, 02 Mar 2022 05:35:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySCve85nsCTXlx9aNBZP55c5oLeOj2XJY2HKDkxKXgqQ95h2DjvN7W+40S5rrP1rYGTiozEA==
X-Received: by 2002:a5d:6083:0:b0:1ef:761f:521f with SMTP id
 w3-20020a5d6083000000b001ef761f521fmr18980603wrt.238.1646228111870; 
 Wed, 02 Mar 2022 05:35:11 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a7bcb17000000b0037bdfa1665asm7640945wmj.18.2022.03.02.05.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 05:35:11 -0800 (PST)
Date: Wed, 2 Mar 2022 08:35:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302083413-mutt-send-email-mst@kernel.org>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302093446.pjq3djoqi434ehz4@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220302093446.pjq3djoqi434ehz4@sgarzare-redhat>
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

On Wed, Mar 02, 2022 at 10:34:46AM +0100, Stefano Garzarella wrote:
> On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
> > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > to vhost_get_vq_desc().  All we have to do is take the same lock
> > during virtqueue clean-up and we mitigate the reported issues.
> > 
> > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> 
> This issue is similar to [1] that should be already fixed upstream by [2].
> 
> However I think this patch would have prevented some issues, because
> vhost_vq_reset() sets vq->private to NULL, preventing the worker from
> running.
> 
> Anyway I think that when we enter in vhost_dev_cleanup() the worker should
> be already stopped, so it shouldn't be necessary to take the mutex. But in
> order to prevent future issues maybe it's better to take them, so:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> [1]
> https://syzkaller.appspot.com/bug?id=993d8b5e64393ed9e6a70f9ae4de0119c605a822
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9


Right. I want to queue this but I would like to get a warning
so we can detect issues like [2] before they cause more issues.


> > 
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > drivers/vhost/vhost.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 59edb5a1ffe28..bbaff6a5e21b8 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -693,6 +693,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > 	int i;
> > 
> > 	for (i = 0; i < dev->nvqs; ++i) {
> > +		mutex_lock(&dev->vqs[i]->mutex);
> > 		if (dev->vqs[i]->error_ctx)
> > 			eventfd_ctx_put(dev->vqs[i]->error_ctx);
> > 		if (dev->vqs[i]->kick)
> > @@ -700,6 +701,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > 		if (dev->vqs[i]->call_ctx.ctx)
> > 			eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
> > 		vhost_vq_reset(dev, dev->vqs[i]);
> > +		mutex_unlock(&dev->vqs[i]->mutex);
> > 	}
> > 	vhost_dev_free_iovecs(dev);
> > 	if (dev->log_ctx)
> > -- 
> > 2.35.1.574.g5d30c73bfb-goog
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
