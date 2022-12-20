Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC06C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 06:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EB874012B;
	Tue, 20 Dec 2022 06:32:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EB874012B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WQqXz8Mw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HfrcPrN0pviu; Tue, 20 Dec 2022 06:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC38F40142;
	Tue, 20 Dec 2022 06:32:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC38F40142
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82C33C0035;
	Tue, 20 Dec 2022 06:32:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6122CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30C5581A24
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:32:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30C5581A24
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WQqXz8Mw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UzXg4eRukRbh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:32:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65BB08144A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65BB08144A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671517948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+6Z7EO57bf3vC7QJ473McXF6jeTHHBAdGwLsa49M35I=;
 b=WQqXz8MwmkPOppZ6u6se6b4He/rvCG6CFuIo0vlK30Hz2GSt+CU9/aFKXINVyKh5Q5JwWK
 +32czqEz3ntl80/smbcWIE/aUvRXjOcPHU9zaCZcgV0Glx2UsVuVtVWDtNcSXnwxFA9nKz
 g624F1TSu5xHwf2m9ETJ9y4LrtJyHU8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-154-q_Lic-JmPfyKr5YKTebBgw-1; Tue, 20 Dec 2022 01:32:26 -0500
X-MC-Unique: q_Lic-JmPfyKr5YKTebBgw-1
Received: by mail-ot1-f70.google.com with SMTP id
 ca5-20020a056830610500b0066ea21701ceso6574377otb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 22:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6Z7EO57bf3vC7QJ473McXF6jeTHHBAdGwLsa49M35I=;
 b=uqwfHv6c+04XL4WOADJRWvBQhwsDt1TFOPyLzQ06a9UyiEx/GJ4R6YbTd8MXhZuts2
 vgHZ53tD+aBVOPOVU+4MgLeCVemn8XkEP1VBX5fQ0OH1yPYtgZhmtF0Ael9Ta5saJq5B
 GJ+03vcDi2Wmn3xqXi2ELTcru6WSMuEy8Y8b7h+dWG0WH0gTHT0qMQVTWVPfog1arb1X
 9iwCAndER6YEr4G4CJELp4GONZmWlsik8noArqp19g9Hrk+qgDuuv9MqDJ6zxTrqRUR9
 c6zFyruNHift/pxooskPgPk745cjO/pNPFPN5qBEQpST5tbdisoB4k/PXrQPihddx0tk
 4Y0w==
X-Gm-Message-State: ANoB5pn+Ly/55kEZVsCRx7ItUFroXpY1U6BD57wRnQQSqxd+sNo5dUAO
 z79NYMNYIk9ioB+X/C0oIajEF2tJh1bi7hXGRA/drNwWXntJCrzpxjxGWN5jU+wOwTjMkyWY8hX
 gVH+1ZAIJvfVhg2sQNWluWXT5EtFV7PT6WG+0xOVHH/hccvrVKg6Xnial3A==
X-Received: by 2002:a05:6808:9b0:b0:35c:303d:fe37 with SMTP id
 e16-20020a05680809b000b0035c303dfe37mr815064oig.35.1671517946188; 
 Mon, 19 Dec 2022 22:32:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6O8kKBLs/Zg9r7I75zBRxziZNso13xp/D7qM4wHnsDLFUHGNeAKcDTWJ0wXqNqaUKzZpAGbB0GD/k3tgBINsw=
X-Received: by 2002:a05:6808:9b0:b0:35c:303d:fe37 with SMTP id
 e16-20020a05680809b000b0035c303dfe37mr815059oig.35.1671517945980; Mon, 19 Dec
 2022 22:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205085846.741-1-xieyongji@bytedance.com>
 <CACGkMEuhYO3neFmxwiBp8C0QTaa+Mb13kken+RZ9QuruMct6tA@mail.gmail.com>
 <CACycT3vu0_xCG7SvdP-zkZkuOGdudx2apOwi3CZ4MOFSe-XAFg@mail.gmail.com>
In-Reply-To: <CACycT3vu0_xCG7SvdP-zkZkuOGdudx2apOwi3CZ4MOFSe-XAFg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Dec 2022 14:32:14 +0800
Message-ID: <CACGkMEs9nD--8y-dKsv23OK6G7LAC5dLDRRT8sKA5dUrAo0QbQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] vduse: Support automatic irq callback affinity
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

On Mon, Dec 19, 2022 at 12:56 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Dec 16, 2022 at 1:30 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 4:59 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > This brings current interrupt affinity spreading mechanism
> > > to vduse device. We will make use of irq_create_affinity_masks()
> > > to create an irq callback affinity mask for each virtqueue of
> > > vduse device. Then we will choose the CPU which has the lowest
> > > number of interrupt allocated in the affinity mask to run the
> > > irq callback.
> >
> > This seems a balance mechanism but it might not be the semantic of the
> > affinity or any reason we need to do this? I guess we should use at
> > least round-robin in this case.
> >
>
> Here we try to follow the pci interrupt management mechanism. In VM
> cases, the interrupt should always be triggered to one specific CPU
> rather than to each CPU in turn.

If I was not wrong, when using MSI, most arch allows not only the
cpuid as the destination but policy like rr and low priority first.

Thanks

>
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 50 ++++++++++++++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index d126f3e32a20..90c2896039d9 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/nospec.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/sched/mm.h>
> > > +#include <linux/interrupt.h>
> > >  #include <uapi/linux/vduse.h>
> > >  #include <uapi/linux/vdpa.h>
> > >  #include <uapi/linux/virtio_config.h>
> > > @@ -58,6 +59,8 @@ struct vduse_virtqueue {
> > >         struct work_struct inject;
> > >         struct work_struct kick;
> > >         int irq_effective_cpu;
> > > +       struct cpumask irq_affinity;
> > > +       spinlock_t irq_affinity_lock;
> >
> > Ok, I'd suggest to squash this into patch 5 to make it more easier to
> > be reviewed.
> >
>
> OK.
>
> > >  };
> > >
> > >  struct vduse_dev;
> > > @@ -123,6 +126,7 @@ struct vduse_control {
> > >
> > >  static DEFINE_MUTEX(vduse_lock);
> > >  static DEFINE_IDR(vduse_idr);
> > > +static DEFINE_PER_CPU(unsigned long, vduse_allocated_irq);
> > >
> > >  static dev_t vduse_major;
> > >  static struct class *vduse_class;
> > > @@ -710,6 +714,49 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> > >         return dev->generation;
> > >  }
> > >
> > > +static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > > +{
> > > +       unsigned int cpu, best_cpu;
> > > +       unsigned long allocated, allocated_min = UINT_MAX;
> > > +
> > > +       spin_lock(&vq->irq_affinity_lock);
> > > +
> > > +       best_cpu = vq->irq_effective_cpu;
> > > +       if (best_cpu != -1)
> > > +               per_cpu(vduse_allocated_irq, best_cpu) -= 1;
> > > +
> > > +       for_each_cpu(cpu, &vq->irq_affinity) {
> > > +               allocated = per_cpu(vduse_allocated_irq, cpu);
> > > +               if (!cpu_online(cpu) || allocated >= allocated_min)
> > > +                       continue;
> > > +
> > > +               best_cpu = cpu;
> > > +               allocated_min = allocated;
> > > +       }
> > > +       vq->irq_effective_cpu = best_cpu;
> > > +       per_cpu(vduse_allocated_irq, best_cpu) += 1;
> > > +
> > > +       spin_unlock(&vq->irq_affinity_lock);
> > > +}
> > > +
> > > +static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
> > > +                                       struct irq_affinity *desc)
> > > +{
> > > +       struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> > > +       struct irq_affinity_desc *affd = NULL;
> > > +       int i;
> > > +
> > > +       affd = irq_create_affinity_masks(dev->vq_num, desc);
> > > +       if (!affd)
> >
> > Let's add a comment on the vdpa config ops to say set_irq_affinity()
> > is best effort.
> >
>
> OK.
>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
