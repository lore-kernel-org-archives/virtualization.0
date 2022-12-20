Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A65C3DA7A
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 06:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68C1C4010D;
	Tue, 20 Dec 2022 06:29:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68C1C4010D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d18l0JUg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W_Tw-ZsDg8ps; Tue, 20 Dec 2022 06:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55E954012B;
	Tue, 20 Dec 2022 06:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55E954012B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30B7FC0035;
	Tue, 20 Dec 2022 06:29:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4AB9C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D8854012B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:29:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D8854012B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aO1D1KDRcP4l
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:29:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF3354010D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF3354010D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671517772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AzVicSmtTXyJzSoeoDjGd7xBCARhoKZoumXQL8Yoe9E=;
 b=d18l0JUgJJ8Ko6uhcX9DCwWH+uoOSNFcNcbwI4WSK7c7NQTNgodmtXcEHJV2tjIyuKLckn
 xgFkdk9HrurdkwDcXqEs2eQlGb0TBtTs1qi359Ozm9RV6OXit9hCA9v7xEH2aheHt+qoHE
 e5iapTnqwWKdPdSdSkaL/6nwo3Rjl4k=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-tV-VvvgYO3WlRGCg0sw8Hg-1; Tue, 20 Dec 2022 01:29:31 -0500
X-MC-Unique: tV-VvvgYO3WlRGCg0sw8Hg-1
Received: by mail-ot1-f72.google.com with SMTP id
 e15-20020a0568301e4f00b006783b3a27c3so628258otj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 22:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AzVicSmtTXyJzSoeoDjGd7xBCARhoKZoumXQL8Yoe9E=;
 b=SoaKrvqp3pNgbLtVRMpgpqWGdXtDp7WpfhdLeq1c22hkwZ3Y10/ueUFi/ZUCI8Q/yq
 65DVJKUVRCXrszHCWp7ESA8DcHnKDFgjPtYPi3/RBcFr5BU8Z3l5orOg+LxjBcyQviMP
 OgiDVtpKGvGLLM2iLeGU7K5yJJKus0rvfEPOU+nkrfsOWLAVld4HlBlZAun29Bb9i+2B
 HEZFdEU4JMJVmEMZV+IUrebojsFpZPvgoIC8o5SSW9Da8jDk3BCQLkyZmWZjlIXeS5PR
 F//LODGDT//Zw8uuETqDvzHdmkOS1Gba5W8atEVqckp3HC/7YytD6JlDiprlTJwk3Y/5
 qzbA==
X-Gm-Message-State: ANoB5pmQnDm/VYs1BTixKEKSfyEmINq9uCzyEvGoeqjzj5vnVCDvJcfc
 HwHJorBQA86r9B88XEvIiwC+ey2195YeMwUFn4egGY6sH3tQ3PeY9OQ/cZXhizh88Ova1JgmveV
 kObrQ7ej7fwuB2rRC/MVlxNS3YZT2g4Wns6LBR+YiMhakBDr/yaJDdrh5eQ==
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr1114628oab.35.1671517770728; 
 Mon, 19 Dec 2022 22:29:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7XDhT4Kqn3VliUlOg1lX+MIl+ZQGJw2nP94fJhhFh6xaSPPYK2i99ZSjUkzLPkactll48kTxNV82uaoXotpno=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr1114620oab.35.1671517769547; Mon, 19
 Dec 2022 22:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-2-xieyongji@bytedance.com>
 <CACGkMEsX1RjU_ncNTY-KbeUY8bxm7X62V_SNO=hMehZRuGQ+CQ@mail.gmail.com>
 <CACycT3sGf9-zvR_XGEJuPVQhLSp4zsiO1x7RZ5KHBKbE5Deu2Q@mail.gmail.com>
In-Reply-To: <CACycT3sGf9-zvR_XGEJuPVQhLSp4zsiO1x7RZ5KHBKbE5Deu2Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Dec 2022 14:29:18 +0800
Message-ID: <CACGkMEuDXytqSWNsx1+GDOSLL0X2Z1fEWWBWT5_nJc-iks9Udw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] vduse: Add sysfs interface for irq callback
 affinity
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

On Mon, Dec 19, 2022 at 1:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Dec 16, 2022 at 1:35 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > Add sysfs interface for each vduse virtqueue to
> > > show the affinity and effective affinity for irq
> > > callback.
> > >
> > > And we can also use this interface to change the
> > > effective affinity which must be a subset of the
> > > irq callback affinity mask for the virtqueue. This
> > > might be useful for performance tuning when the irq
> > > callback affinity mask contains more than one CPU.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 148 ++++++++++++++++++++++++++---
> > >  1 file changed, 137 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 6507a78abc9d..c65f84100e30 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -61,6 +61,7 @@ struct vduse_virtqueue {
> > >         int irq_effective_cpu;
> > >         struct cpumask irq_affinity;
> > >         spinlock_t irq_affinity_lock;
> > > +       struct kobject kobj;
> > >  };
> > >
> > >  struct vduse_dev;
> > > @@ -1419,6 +1420,120 @@ static const struct file_operations vduse_dev_fops = {
> > >         .llseek         = noop_llseek,
> > >  };
> > >
> > > +static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
> > > +{
> > > +       return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
> > > +}
> > > +
> > > +static ssize_t irq_cb_effective_affinity_show(struct vduse_virtqueue *vq,
> > > +                                             char *buf)
> > > +{
> > > +       struct cpumask all_mask = CPU_MASK_ALL;
> > > +       const struct cpumask *mask = &all_mask;
> > > +
> > > +       if (vq->irq_effective_cpu != -1)
> > > +               mask = get_cpu_mask(vq->irq_effective_cpu);
> >
> > Shouldn't this be vq->irq_affinity?
> >
>
> This sysfs interface is provided for effective irq affinity rather
> than irq affinity. We created another read-only sysfs interface for
> irq affinity.
>
> > > +
> > > +       return sprintf(buf, "%*pb\n", cpumask_pr_args(mask));
> > > +}
> > > +
> > > +static ssize_t irq_cb_effective_affinity_store(struct vduse_virtqueue *vq,
> > > +                                              const char *buf, size_t count)
> > > +{
> > > +       cpumask_var_t new_value;
> > > +       int ret;
> > > +
> > > +       if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
> > > +               return -ENOMEM;
> > > +
> > > +       ret = cpumask_parse(buf, new_value);
> > > +       if (ret)
> > > +               goto free_mask;
> > > +
> > > +       ret = -EINVAL;
> > > +       if (!cpumask_intersects(new_value, &vq->irq_affinity))
> > > +               goto free_mask;
> > > +
> > > +       spin_lock(&vq->irq_affinity_lock);
> > > +
> > > +       if (vq->irq_effective_cpu != -1)
> > > +               per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) -= 1;
> > > +
> > > +       vq->irq_effective_cpu = cpumask_first(new_value);
> >
> > Does this mean except for the first cpu, the rest of the mask is unused?
> >
>
> Yes, but the user should always specify a mask that only contains one
> CPU to make it work as expected.

This doesn't seem to be the way that the IRQ affinity{hint} exported
via /sys work. Any reason for doing this?

(E.g we may have the require to limit the IRQ/callback to a NUMA node
instead of a specific cpu)

Thanks

> This sysfs interface is used to
> specify the effective irq affinity rather than irq affinity.
>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
