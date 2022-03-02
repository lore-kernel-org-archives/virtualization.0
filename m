Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877B8C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 17:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B0474028C;
	Wed,  2 Mar 2022 17:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nCZdnoXjGIew; Wed,  2 Mar 2022 17:11:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 922E1401F5;
	Wed,  2 Mar 2022 17:11:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4291EC0082;
	Wed,  2 Mar 2022 17:11:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02A2AC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 17:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3CF44048C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 17:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AOlik2jn-4yC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 17:11:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5475F4012E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646241060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OCk0IGN+JSNCGOmZy65+tm/Nx0eAS27c5ZIr+XIGJxc=;
 b=MqndEOW45dVttoLPGEjpGRMqU7/oqh/1OPyTZObNKrTJSXaXOfJhJZ6rRYkLfp0BtrNxh7
 2DiJodvHg073wS53Hg1KDExgLjvxG49WYsCeCRUsh0iwC1hOt0kFTUuoLtbCO+bwgICHqV
 O/a4mY33V55+SLJGddUoT7kimBlOW+4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-UrJbvSBxNd23DPoXqaQ6jg-1; Wed, 02 Mar 2022 12:10:55 -0500
X-MC-Unique: UrJbvSBxNd23DPoXqaQ6jg-1
Received: by mail-wm1-f69.google.com with SMTP id
 az11-20020a05600c600b00b00381b45e12b7so1048233wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 09:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OCk0IGN+JSNCGOmZy65+tm/Nx0eAS27c5ZIr+XIGJxc=;
 b=e9Jy11H/YCRj8XDwic4BeDwLVOFMHQXpFmjuRWVXo18W2XGbI5fKIJCAkTHORwEGuT
 u2U60FnFkjF6z4UVT67syr3QSOn6Fm5DDq7eWAk9cv8su5V5E3yR7jI5l+78RUSF74dS
 fGX5ecElj9VGzLdH8tRICMdjB3X9HvPqohBMyPSaBlqsJ+K1Qbhz3O0mMUU/dik3Ragh
 +NoA9EZlP7QBJnLl61WM1TVTuu6+NjDJ0SJni2IGUXDk6qCcFH9v2mirj+yFu3JuhF5x
 I0ZDg5vp4ULVN2khogp7kyarx+6cgOx3YmIj1rElHm0GjZ96DXFt9PbqyVk8zGuWernN
 fRcA==
X-Gm-Message-State: AOAM530tTR28Klwx91q95CcCvdALNm8xhx+XBWik95mDPZ/eqUxmc/Pz
 ckady3vWSko3ONnFHrUtFFNKkA6pmx6lfbHg8jRTI/A4DHuppkFpifirecA/9ivzgTj+hHin1G1
 5yt16o4zlwDE0xMxxYdHHdaDgATNuTr3WGdYLqVEDZw==
X-Received: by 2002:a5d:6b0f:0:b0:1e7:9432:ee8c with SMTP id
 v15-20020a5d6b0f000000b001e79432ee8cmr22845001wrw.216.1646241052250; 
 Wed, 02 Mar 2022 09:10:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdCmMTM9zLSI+LlHPZY7Qi9z6yOB/Nx9cLAFKLKH9IIrgIyZ3Z4qt7cBDrf7wigHlwXxKhVQ==
X-Received: by 2002:a5d:6b0f:0:b0:1e7:9432:ee8c with SMTP id
 v15-20020a5d6b0f000000b001e79432ee8cmr22844983wrw.216.1646241051946; 
 Wed, 02 Mar 2022 09:10:51 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 e20-20020adfa454000000b001f01a14dce8sm5579398wra.97.2022.03.02.09.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 09:10:51 -0800 (PST)
Date: Wed, 2 Mar 2022 18:10:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302171048.aijkcrwcrgsu475z@sgarzare-redhat>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302082021-mutt-send-email-mst@kernel.org>
 <Yh93k2ZKJBIYQJjp@google.com>
 <20220302095045-mutt-send-email-mst@kernel.org>
 <Yh+F1gkCGoYF2lMV@google.com>
 <CAGxU2F4cUDrMzoHH1NT5_ivxBPgEE8HOzP5s_Bt5JURRaSsLdQ@mail.gmail.com>
 <20220302112945-mutt-send-email-mst@kernel.org>
 <Yh+gDZUbgBRx/1ro@google.com>
MIME-Version: 1.0
In-Reply-To: <Yh+gDZUbgBRx/1ro@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 02, 2022 at 04:49:17PM +0000, Lee Jones wrote:
>On Wed, 02 Mar 2022, Michael S. Tsirkin wrote:
>
>> On Wed, Mar 02, 2022 at 05:28:31PM +0100, Stefano Garzarella wrote:
>> > On Wed, Mar 2, 2022 at 3:57 PM Lee Jones <lee.jones@linaro.org> wrote:
>> > >
>> > > On Wed, 02 Mar 2022, Michael S. Tsirkin wrote:
>> > >
>> > > > On Wed, Mar 02, 2022 at 01:56:35PM +0000, Lee Jones wrote:
>> > > > > On Wed, 02 Mar 2022, Michael S. Tsirkin wrote:
>> > > > >
>> > > > > > On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
>> > > > > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
>> > > > > > > to vhost_get_vq_desc().  All we have to do is take the same lock
>> > > > > > > during virtqueue clean-up and we mitigate the reported issues.
>> > > > > > >
>> > > > > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
>> > > > > > >
>> > > > > > > Cc: <stable@vger.kernel.org>
>> > > > > > > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
>> > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > > > > > > ---
>> > > > > > >  drivers/vhost/vhost.c | 2 ++
>> > > > > > >  1 file changed, 2 insertions(+)
>> > > > > > >
>> > > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> > > > > > > index 59edb5a1ffe28..bbaff6a5e21b8 100644
>> > > > > > > --- a/drivers/vhost/vhost.c
>> > > > > > > +++ b/drivers/vhost/vhost.c
>> > > > > > > @@ -693,6 +693,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>> > > > > > >         int i;
>> > > > > > >
>> > > > > > >         for (i = 0; i < dev->nvqs; ++i) {
>> > > > > > > +               mutex_lock(&dev->vqs[i]->mutex);
>> > > > > > >                 if (dev->vqs[i]->error_ctx)
>> > > > > > >                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
>> > > > > > >                 if (dev->vqs[i]->kick)
>> > > > > > > @@ -700,6 +701,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>> > > > > > >                 if (dev->vqs[i]->call_ctx.ctx)
>> > > > > > >                         eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
>> > > > > > >                 vhost_vq_reset(dev, dev->vqs[i]);
>> > > > > > > +               mutex_unlock(&dev->vqs[i]->mutex);
>> > > > > > >         }
>> > > > > >
>> > > > > > So this is a mitigation plan but the bug is still there though
>> > > > > > we don't know exactly what it is.  I would prefer adding something like
>> > > > > > WARN_ON(mutex_is_locked(vqs[i]->mutex) here - does this make sense?
>> > > > >
>> > > > > As a rework to this, or as a subsequent patch?
>> > > >
>> > > > Can be a separate patch.
>> > > >
>> > > > > Just before the first lock I assume?
>> > > >
>> > > > I guess so, yes.
>> > >
>> > > No problem.  Patch to follow.
>> > >
>> > > I'm also going to attempt to debug the root cause, but I'm new to this
>> > > subsystem to it might take a while for me to get my head around.
>> >
>> > IIUC the root cause should be the same as the one we solved here:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9
>> >
>> > The worker was not stopped before calling vhost_dev_cleanup(). So while
>> > the worker was still running we were going to free memory or initialize
>> > fields while it was still using virtqueue.
>>
>> Right, and I agree but it's not the root though, we do attempt to stop all workers.
>
>Exactly.  This is what happens, but the question I'm going to attempt
>to answer is *why* does this happen.

IIUC the worker was still running because the /dev/vhost-vsock file was 
not explicitly closed, so vhost_vsock_dev_release() was called in the 
do_exit() of the process.

In that case there was the issue, because vhost_dev_check_owner() 
returned false in vhost_vsock_stop() since current->mm was NULL.
So it returned earlier, without calling vhost_vq_set_backend(vq, NULL).

This did not stop the worker from continuing to run, causing the 
multiple issues we are seeing.

current->mm was NULL, because in the do_exit() the address space is 
cleaned in the exit_mm(), which is called before releasing the files 
into the exit_task_work().

This can be seen from the logs, where we see first the warnings printed 
by vhost_dev_cleanup() and then the panic in the worker (e.g. here 
https://syzkaller.appspot.com/text?tag=CrashLog&x=16a61fce700000)

Mike also added a few more helpful details in this thread: 
https://lore.kernel.org/virtualization/20220221100500.2x3s2sddqahgdfyt@sgarzare-redhat/T/#ree61316eac63245c9ba3050b44330e4034282cc2

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
