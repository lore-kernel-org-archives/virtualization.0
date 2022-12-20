Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC7EC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 06:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D534414C0;
	Tue, 20 Dec 2022 06:28:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D534414C0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zfiv7YnC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Oo11qdnghvQ; Tue, 20 Dec 2022 06:28:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8935C410E6;
	Tue, 20 Dec 2022 06:28:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8935C410E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 542CFC0035;
	Tue, 20 Dec 2022 06:28:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1D84C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77D6160A8B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:28:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77D6160A8B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zfiv7YnC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cqLzCLZNIHi2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:27:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94A96607F4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94A96607F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671517678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fk2PiE0CunQ+TDmLGNL5qpMQY7lBOmo7teDnAJQAAFs=;
 b=Zfiv7YnCSmQJzoDxef26FP1rTzN4+0P+ZxlCEDpSbJ8wwMU6US7edDtCARKjwJ8eHRvtuU
 ddpZhupL3fUYIiPFV2PsRwa71GRzF69+sGIkEORA7k9q+SqhxyKkysijjM36CMwoPJ6529
 TxkeT26sFbd2ms0c+68Lbxgse8TX1Oo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-fJzIHRAYPFSeWotTXHWjUA-1; Tue, 20 Dec 2022 01:27:56 -0500
X-MC-Unique: fJzIHRAYPFSeWotTXHWjUA-1
Received: by mail-ot1-f69.google.com with SMTP id
 s22-20020a9d7596000000b0066eb4e77127so6628661otk.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 22:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fk2PiE0CunQ+TDmLGNL5qpMQY7lBOmo7teDnAJQAAFs=;
 b=0PD32H2M20PIJH43VJMVgeXa8HIErVVV22VG8tO1W2cymnbYw4uROlwksakmvHvrHr
 D/sMjxIyvVdlNER0V/9nNJWMYiiMilYSLIX64DbeJC26uucZx+5pNDNDzkqcuqjz0eF5
 0zXp6tWGULXWlDf77LulaJ0twT56qRSZQVVas+XKaqyqRDyBPRpAsuigTwPAAHGjOj2c
 l5cIyvmQxW+aVkqykgVQ6C5fOpYt2yJFjByXE5MRpZIiUnvJa6e8l+sEuL+vwXxQLPY/
 RyrzkdvUZhb5HE0OCgD2UD9+uAIDu1+vX2qQtdqQP234QjZ4nBWvurNlk2vnQU+rPddJ
 HCjA==
X-Gm-Message-State: AFqh2koJzXDhh/3mtM7FG5XK1lhGv/4xHQl7UJIf+iw0OoeCqpyNGZnr
 pFbLf9rCvyQcHSz7tG8lZIa3yzyigQ4WJLXsnRZwN29bo3Z2+XZrKvUEBQPmQIVdWa8tbg7y67p
 arcVjzMg89ranrfpRu7f6GQtPXdKa7XtHKG3F2vOGdYmmUKWHcWHGKytsUA==
X-Received: by 2002:a05:6830:3359:b0:678:1eb4:3406 with SMTP id
 l25-20020a056830335900b006781eb43406mr524118ott.237.1671517675882; 
 Mon, 19 Dec 2022 22:27:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsZt7pm6VhKZOL4+wxRQBFH0VoFxpTBBIytwLKsgR30rvYBkn3/JGtSy1k4ZwbJeR++nPgPC5pfUAnP0VMPL4M=
X-Received: by 2002:a05:6830:3359:b0:678:1eb4:3406 with SMTP id
 l25-20020a056830335900b006781eb43406mr524114ott.237.1671517675583; Mon, 19
 Dec 2022 22:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-6-xieyongji@bytedance.com>
 <CACGkMEvkTJn7Hm5u=79nDNHQG_gakS3Cbvi=JpO38ndjHy_fog@mail.gmail.com>
 <CACycT3tyR0zTfTgE3BhL0GZqWAj2KDC0Q+tfm+rV=wbgHPOhFA@mail.gmail.com>
In-Reply-To: <CACycT3tyR0zTfTgE3BhL0GZqWAj2KDC0Q+tfm+rV=wbgHPOhFA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Dec 2022 14:27:44 +0800
Message-ID: <CACGkMEt1MkoxJQUixMsR8gVmTVUVoPh1CNo7GpbOyWGb3bzoPw@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] vduse: Introduce bound workqueue for irq
 injection
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Dec 19, 2022 at 1:04 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Dec 16, 2022 at 12:02 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 4:44 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > This introduces a bound workqueue to support running
> > > irq callback in a specified cpu.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 29 ++++++++++++++++++++++-------
> > >  1 file changed, 22 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 37809bfcb7ef..d126f3e32a20 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -57,6 +57,7 @@ struct vduse_virtqueue {
> > >         struct vdpa_callback cb;
> > >         struct work_struct inject;
> > >         struct work_struct kick;
> > > +       int irq_effective_cpu;
> >
> > I wonder why it's a cpu number instead of a cpumask. The latter seems
> > more flexible, e.g when using NUMA.
> >
>
> This variable represents the CPU that runs the interrupt callback
> rather than CPU affinity.

Ok, but for some reason it only gets updated when a new affinity is set?

(Btw, I don't see how the code deals with cpu hotplug, do we need
cpuhot notifier?)

Thanks

>
> > >  };
> > >
> > >  struct vduse_dev;
> > > @@ -128,6 +129,7 @@ static struct class *vduse_class;
> > >  static struct cdev vduse_ctrl_cdev;
> > >  static struct cdev vduse_cdev;
> > >  static struct workqueue_struct *vduse_irq_wq;
> > > +static struct workqueue_struct *vduse_irq_bound_wq;
> > >
> > >  static u32 allowed_device_id[] = {
> > >         VIRTIO_ID_BLOCK,
> > > @@ -917,7 +919,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
> > >  }
> > >
> > >  static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > > -                                   struct work_struct *irq_work)
> > > +                                   struct work_struct *irq_work,
> > > +                                   int irq_effective_cpu)
> > >  {
> > >         int ret = -EINVAL;
> > >
> > > @@ -926,7 +929,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > >                 goto unlock;
> > >
> > >         ret = 0;
> > > -       queue_work(vduse_irq_wq, irq_work);
> > > +       if (irq_effective_cpu == -1)
> >
> > Is it better to have a macro for this magic number?
> >
>
> It makes sense to me.
>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
