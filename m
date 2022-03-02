Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F5AC433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 16:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5E0D402B9;
	Wed,  2 Mar 2022 16:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OMZ2xHiFvk58; Wed,  2 Mar 2022 16:28:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 61D86402D8;
	Wed,  2 Mar 2022 16:28:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38293C0012;
	Wed,  2 Mar 2022 16:28:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D540C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C22D402D8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:28:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sWbUpwmZpwuq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:28:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CF50402B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646238524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7eEfPBvyCQz7KlzEw024f3+wwx9DN1COWUQbQ4CRIAA=;
 b=bDgphBkbYHhedcapkIdnTC74O0BLqCk/zCV/dCUG4GxUOKTiKsOGG8g6Qy/DxlAhW+b0P7
 pDmrHqB+i/FkVS9LXOFT9e1MpAHVDfMY/Hvq9oKHECoA4pr1veFReWztpNZHRZM4XBA5vs
 jWcn7Vm4kRtkcr4+5uKTiITpVseYAaQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-_MoF3Jp4Myq0QBdDz2q9yA-1; Wed, 02 Mar 2022 11:28:40 -0500
X-MC-Unique: _MoF3Jp4Myq0QBdDz2q9yA-1
Received: by mail-wm1-f69.google.com with SMTP id
 187-20020a1c19c4000000b0037cc0d56524so2117586wmz.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 08:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7eEfPBvyCQz7KlzEw024f3+wwx9DN1COWUQbQ4CRIAA=;
 b=YQYtMbzk/VQpKzezw/T8NjFM4Y7/lMS28g7SqkwQLvHR7V96NJ+JnngucfYZG76Va6
 iJcu/vE5+QXarhNhm/v9Hdu6U+NIqXoHYXnW+niJgnuLrw/Me5EZPQifPPp/UO1ktzK/
 zI+qeLihy9L0A502fDS5MJ6aF/Zeo5xjO9RAqAp9a5X4HJZ3ZFlif+lHCRxGa2eXFt6o
 cR4wZVymhrx1oHqh4RDW7nCQdrGGwMcPJd7c6W1TQhfSAarBgsL1CRuk9oF2qvWgW29g
 9EpcUOvR4J7YcIaFjed3Y20fMSowBEX9O5OX2C8eqxCGPCVZb7nniUW4RzGnhEFmm0zu
 lKZQ==
X-Gm-Message-State: AOAM5300jpjRwGPHsi1hfCS5c16s3KzGoFWvcUosDbGVrOFBPmkgvE5u
 IhnG6GCssyx+Qf5cBY9E+1vi7xKCi5hwqXgjtOcFkQ8zwE6V7jw+S+0kv9ET+kOzDgfYFgrrdB4
 YETr7hD+XmmbzyqnYoL+GPCDF8k7JdyBocha5lcmRCg==
X-Received: by 2002:a05:6000:1a52:b0:1f0:2d62:2bbb with SMTP id
 t18-20020a0560001a5200b001f02d622bbbmr3097910wry.614.1646238517709; 
 Wed, 02 Mar 2022 08:28:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyul2MSo2n7QpL85LxwCnbq2CCgtDPP6CoPZDNaTpNW2WppDgvCCshQp5K2HZYQsvSsIG9RAQ==
X-Received: by 2002:a05:6000:1a52:b0:1f0:2d62:2bbb with SMTP id
 t18-20020a0560001a5200b001f02d622bbbmr3097869wry.614.1646238516965; 
 Wed, 02 Mar 2022 08:28:36 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c511200b00352ec3b4c5asm8910926wms.7.2022.03.02.08.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 08:28:36 -0800 (PST)
Date: Wed, 2 Mar 2022 17:28:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <CAGxU2F4cUDrMzoHH1NT5_ivxBPgEE8HOzP5s_Bt5JURRaSsLdQ@mail.gmail.com>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302082021-mutt-send-email-mst@kernel.org>
 <Yh93k2ZKJBIYQJjp@google.com>
 <20220302095045-mutt-send-email-mst@kernel.org>
 <Yh+F1gkCGoYF2lMV@google.com>
MIME-Version: 1.0
In-Reply-To: <Yh+F1gkCGoYF2lMV@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com,
 kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Mar 2, 2022 at 3:57 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 02 Mar 2022, Michael S. Tsirkin wrote:
>
> > On Wed, Mar 02, 2022 at 01:56:35PM +0000, Lee Jones wrote:
> > > On Wed, 02 Mar 2022, Michael S. Tsirkin wrote:
> > >
> > > > On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
> > > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > > > > to vhost_get_vq_desc().  All we have to do is take the same lock
> > > > > during virtqueue clean-up and we mitigate the reported issues.
> > > > >
> > > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > > > >
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/vhost/vhost.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > index 59edb5a1ffe28..bbaff6a5e21b8 100644
> > > > > --- a/drivers/vhost/vhost.c
> > > > > +++ b/drivers/vhost/vhost.c
> > > > > @@ -693,6 +693,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > >         int i;
> > > > >
> > > > >         for (i = 0; i < dev->nvqs; ++i) {
> > > > > +               mutex_lock(&dev->vqs[i]->mutex);
> > > > >                 if (dev->vqs[i]->error_ctx)
> > > > >                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
> > > > >                 if (dev->vqs[i]->kick)
> > > > > @@ -700,6 +701,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > >                 if (dev->vqs[i]->call_ctx.ctx)
> > > > >                         eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
> > > > >                 vhost_vq_reset(dev, dev->vqs[i]);
> > > > > +               mutex_unlock(&dev->vqs[i]->mutex);
> > > > >         }
> > > >
> > > > So this is a mitigation plan but the bug is still there though
> > > > we don't know exactly what it is.  I would prefer adding something like
> > > > WARN_ON(mutex_is_locked(vqs[i]->mutex) here - does this make sense?
> > >
> > > As a rework to this, or as a subsequent patch?
> >
> > Can be a separate patch.
> >
> > > Just before the first lock I assume?
> >
> > I guess so, yes.
>
> No problem.  Patch to follow.
>
> I'm also going to attempt to debug the root cause, but I'm new to this
> subsystem to it might take a while for me to get my head around.

IIUC the root cause should be the same as the one we solved here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9

The worker was not stopped before calling vhost_dev_cleanup(). So while 
the worker was still running we were going to free memory or initialize 
fields while it was still using virtqueue.

Cheers,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
