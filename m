Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CB8C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 01:34:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0795610CC
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 01:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0795610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6BC9740018;
	Wed, 20 Oct 2021 01:34:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5dFqIFh69z1; Wed, 20 Oct 2021 01:34:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16BDF400F3;
	Wed, 20 Oct 2021 01:34:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEDB0C0011;
	Wed, 20 Oct 2021 01:34:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 655DBC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 01:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4722540545
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 01:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qOpIKWOuRCi1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 01:34:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67CE94022F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 01:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634693645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltXfto+2D3qHt5R0luKHd8lxHSlL7nx4NZbjj+fLLmY=;
 b=U1ggA5Z0KkjdkmlHNfUCHxu5Y+3+yRExiu7tnt0/lyPmu30GlsmippbUGNO3lzGDVOfiIE
 xA8IPsFujTROvoXWUOsM8suJxhe4KObuLxyEoNleC86pTbcmTPsKn+dXF99rvqJefNPeWg
 xaX2V1T3sdxzIPYZ7RL5I4y6UEsTU30=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-JuF0PjyvMD2DBnCgHLkScw-1; Tue, 19 Oct 2021 21:34:02 -0400
X-MC-Unique: JuF0PjyvMD2DBnCgHLkScw-1
Received: by mail-lf1-f72.google.com with SMTP id
 f17-20020a0565123b1100b003fda40b659aso2289157lfv.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 18:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ltXfto+2D3qHt5R0luKHd8lxHSlL7nx4NZbjj+fLLmY=;
 b=cDK9FBKaKDErtK4J114/ghUzzM8sGAXLg8b24joE+WsOiDJcsVq2FxS01c8k1E8BXu
 9bXBsk2EIebW6Tq243Qliwass9KWHNfOwJVQ45m6jJOBKpmTC5Pi+ejjB3a7CX/Epmiy
 Lvnc96grf39W4NpPoOMeQjZ6eiAv0YszwPdsKrHoBnYb7D1X9ZESRRdPsodsMl6AqnXt
 RyCHI2jyH8OFTw8+SXhGaw4BA6YY1BjQKQstn9NXqlQQw07pZFuI9FxU6h9MV+++dVKN
 s13iFT9TkM1sBFQkRGvvZslME71oYB8pZNQgMsZriwo+kf7gfq0WWxERsMISmslaq2Zh
 lltA==
X-Gm-Message-State: AOAM530Irvvugoa+3/xyGMMa3hyoDEdtzXdW+m2jqBwFja97KPz1OdzJ
 urbOy+W+xhvMR/WjAIGW/ihw1ov9xBSpFk2numL4Tw/7GJcGR9ETHd4+LmAOG6PvIIPRLV/RC3v
 AIiMBWRYGyUmh9jgmgFxWN4EFiL16wXXrWBNH+eJpJoirJfAJuEyR5HDHWw==
X-Received: by 2002:a05:6512:128a:: with SMTP id
 u10mr9534656lfs.84.1634693640817; 
 Tue, 19 Oct 2021 18:34:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF+/cEU7+91nx7pxgumxGT2rgLZSQW4vhO2/x8Z65P97rY4mBDOhUnt29vb3LfSb6KnDQ6ltfEwK978AmcDe4=
X-Received: by 2002:a05:6512:128a:: with SMTP id
 u10mr9534640lfs.84.1634693640619; 
 Tue, 19 Oct 2021 18:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-7-jasowang@redhat.com>
 <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com>
 <20211015132639-mutt-send-email-mst@kernel.org>
 <CACGkMEujcgMTtLiJWx5ZazVgM5qopB0ZVDkvg6cEuyRGAL31AA@mail.gmail.com>
 <c51930a2-3f47-407a-2b1a-fdd1d23ca7c2@oracle.com>
In-Reply-To: <c51930a2-3f47-407a-2b1a-fdd1d23ca7c2@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Oct 2021 09:33:49 +0800
Message-ID: <CACGkMEvSVA=qx6m7BvM-P9mm=KpPihWhVWUycj2WGnwxfa+HAA@mail.gmail.com>
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
To: Dongli Zhang <dongli.zhang@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E . McKenney" <paulmck@kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Oct 20, 2021 at 1:02 AM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
>
>
> On 10/18/21 6:33 PM, Jason Wang wrote:
> > On Sat, Oct 16, 2021 at 1:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Fri, Oct 15, 2021 at 05:09:38AM -0700, Dongli Zhang wrote:
> >>> Hi Jason,
> >>>
> >>> On 10/11/21 11:52 PM, Jason Wang wrote:
> >>>> We used to synchronize pending MSI-X irq handlers via
> >>>> synchronize_irq(), this may not work for the untrusted device which
> >>>> may keep sending interrupts after reset which may lead unexpected
> >>>> results. Similarly, we should not enable MSI-X interrupt until the
> >>>
> >>> About "unexpected results", while you mentioned below in v1 ...
> >>>
> >>> "My understanding is that e.g in the case of SEV/TDX we don't trust the
> >>> hypervisor. So the hypervisor can keep sending interrupts even if the
> >>> device is reset. The guest can only trust its own software interrupt
> >>> management logic to avoid call virtio callback in this case."
> >>>
> >>> .. and you also mentioned to avoid the panic (due to untrusted device) in as
> >>> many scenarios as possible.
> >>>
> >>>
> >>> Here is my understanding.
> >>>
> >>> The reason we do not trust hypervisor is to protect (1) data/code privacy for
> >>> most of times and sometimes (2) program execution integrity.
> >>>
> >>> The bad thing is: the hypervisor is able to panic/destroy the VM in the worst case.
> >>>
> >>> It is reasonable to re-configure/recover if we assume there is BUG at
> >>> hypervisor/device side. That is, the hypervisor/device is buggy, but not malicious.
> >>>
> >>> However, how about to just detect and report the hypervisor/device is malicious
> >>> and shutdown/panic the VM immediately? If we have detected the malicious
> >>> hypervisor, we should avoid running VMs on the malicious hypervisor further. At
> >>> least how about to print error message to reminder users that the hypervisor is
> >>> malicious?
> >
> > I understand your point, but several questions needs to be answered:
> >
> > 1) how can we easily differentiate "malicious" from "buggy"?
> > 2) If we want to detect malicious hypervisor, virtio is not the only
> > place that we want to do this
> > 3) Is there a way that "malicious" hypervisor can prevent guest from
> > shutting down itself?
> >
> >>>
> >>>
> >>> About "unexpected results", it should not be hang/panic. I suggest ...
> >>>
> >
> > It's just the phenomenon not the logic behind that. It could be e.g
> > OOB which may lead the unexpected kernel codes to be executed in
> > unexpected ways (e.g mark the page as shared or go with IOTLB etc).
> > Sometimes we can see panic finally but it's not always.
>
> This is what I was trying to explain.
>
> The objective is to protect "data privacy" (or code execution integrity in some
> case), but not to prevent DoS attack. That is, the 'malicious' hypervisor should
> not be able to derive VM data privacy.
>
> Suppose the hypervisor did something buggy/malicious when SEV/TDX is used by VM,
> the "unexpected results" should never reveal secure/private data to the hypervisor.
>
> In my own opinion, the threat model is:
>
> Attacker: 'malicious' hypervisor
>
> Victim: VM with SEV/TDX/SGX
>
> The attacker should not be able to steal secure/private data from VM, when the
> hypervisor's action is unexpected. DoS is out of the scope.
>
> My concern is: it is very hard to clearly explain in the patchset how the
> hypervisor is able to steal VM's data, by setting queue=0 or injecting unwanted
> interrupts to VM.

Yes, it's a hard question but instead of trying to answer that, we can
just fix the case of e.g unexpected interrupts.

Thanks

>
> Thank you very much!
>
> Dongli Zhang
>
> >
> >>> Assuming SEV/TDX is involved, the hypervisor should never be able to derive the
> >>> VM privacy (at least secure memory data) by providing malicious configuration,
> >>> e.g., num_queues=0.
> >
> > Yes.
> >
> >>> If we detect hypervisor is malicious, the VM is
> >>> panic/shutdown immediately.
> >
> > This seems to enforce the policy into the kernel, we need to leave
> > this to userspace to decide.
> >
> >>> At least how about to print error message to
> >>> reminder users.
> >
> > This is fine.
> >
> >>>
> >>>
> >>> BTW, while I always do care about the loss of interrupt issue, the malicious
> >>> device is able to hang a VM by dropping a single interrupt on purpose for
> >>> virtio-scsi :)
> >>>
> >
> > Right.
> >
> >>>
> >>> Thank you very much!
> >>
> >>
> >> Can't say I understand what it's about. TDX does not protect against
> >> hypervisor DoS attacks.
> >
> > Yes, I think what Dongli wants to discuss is how to behave if we
> > detect a malicious hypervisor. He suggested a shutdown instead of
> > failing the probe.
> >
> > Thanks
> >
> >>
> >>> Dongli Zhang
> >>>
> >>>> device is ready. So this patch fixes those two issues by:
> >>>>
> >>>> 1) switching to use disable_irq() to prevent the virtio interrupt
> >>>>    handlers to be called after the device is reset.
> >>>> 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> >>>>
> >>>> This can make sure the virtio interrupt handler won't be called before
> >>>> virtio_device_ready() and after reset.
> >>>>
> >>>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>> Cc: Paul E. McKenney <paulmck@kernel.org>
> >>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>> ---
> >>>>  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> >>>>  drivers/virtio/virtio_pci_common.h |  6 ++++--
> >>>>  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> >>>>  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> >>>>  4 files changed, 32 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >>>> index b35bb2d57f62..0b9523e6dd39 100644
> >>>> --- a/drivers/virtio/virtio_pci_common.c
> >>>> +++ b/drivers/virtio/virtio_pci_common.c
> >>>> @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> >>>>              "Force legacy mode for transitional virtio 1 devices");
> >>>>  #endif
> >>>>
> >>>> -/* wait for pending irq handlers */
> >>>> -void vp_synchronize_vectors(struct virtio_device *vdev)
> >>>> +/* disable irq handlers */
> >>>> +void vp_disable_vectors(struct virtio_device *vdev)
> >>>>  {
> >>>>     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >>>>     int i;
> >>>> @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >>>>             synchronize_irq(vp_dev->pci_dev->irq);
> >>>>
> >>>>     for (i = 0; i < vp_dev->msix_vectors; ++i)
> >>>> -           synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >>>> +           disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >>>> +}
> >>>> +
> >>>> +/* enable irq handlers */
> >>>> +void vp_enable_vectors(struct virtio_device *vdev)
> >>>> +{
> >>>> +   struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >>>> +   int i;
> >>>> +
> >>>> +   if (vp_dev->intx_enabled)
> >>>> +           return;
> >>>> +
> >>>> +   for (i = 0; i < vp_dev->msix_vectors; ++i)
> >>>> +           enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >>>>  }
> >>>>
> >>>>  /* the notify function used when creating a virt queue */
> >>>> @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> >>>>     snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> >>>>              "%s-config", name);
> >>>>     err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> >>>> -                     vp_config_changed, 0, vp_dev->msix_names[v],
> >>>> +                     vp_config_changed, IRQF_NO_AUTOEN,
> >>>> +                     vp_dev->msix_names[v],
> >>>>                       vp_dev);
> >>>>     if (err)
> >>>>             goto error;
> >>>> @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> >>>>             snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> >>>>                      "%s-virtqueues", name);
> >>>>             err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> >>>> -                             vp_vring_interrupt, 0, vp_dev->msix_names[v],
> >>>> +                             vp_vring_interrupt, IRQF_NO_AUTOEN,
> >>>> +                             vp_dev->msix_names[v],
> >>>>                               vp_dev);
> >>>>             if (err)
> >>>>                     goto error;
> >>>> @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> >>>>                      "%s-%s",
> >>>>                      dev_name(&vp_dev->vdev.dev), names[i]);
> >>>>             err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> >>>> -                             vring_interrupt, 0,
> >>>> +                             vring_interrupt, IRQF_NO_AUTOEN,
> >>>>                               vp_dev->msix_names[msix_vec],
> >>>>                               vqs[i]);
> >>>>             if (err)
> >>>> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> >>>> index beec047a8f8d..a235ce9ff6a5 100644
> >>>> --- a/drivers/virtio/virtio_pci_common.h
> >>>> +++ b/drivers/virtio/virtio_pci_common.h
> >>>> @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> >>>>     return container_of(vdev, struct virtio_pci_device, vdev);
> >>>>  }
> >>>>
> >>>> -/* wait for pending irq handlers */
> >>>> -void vp_synchronize_vectors(struct virtio_device *vdev);
> >>>> +/* disable irq handlers */
> >>>> +void vp_disable_vectors(struct virtio_device *vdev);
> >>>> +/* enable irq handlers */
> >>>> +void vp_enable_vectors(struct virtio_device *vdev);
> >>>>  /* the notify function used when creating a virt queue */
> >>>>  bool vp_notify(struct virtqueue *vq);
> >>>>  /* the config->del_vqs() implementation */
> >>>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> >>>> index d62e9835aeec..bdf6bc667ab5 100644
> >>>> --- a/drivers/virtio/virtio_pci_legacy.c
> >>>> +++ b/drivers/virtio/virtio_pci_legacy.c
> >>>> @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
> >>>>     /* Flush out the status write, and flush in device writes,
> >>>>      * including MSi-X interrupts, if any. */
> >>>>     ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> >>>> -   /* Flush pending VQ/configuration callbacks. */
> >>>> -   vp_synchronize_vectors(vdev);
> >>>> +   /* Disable VQ/configuration callbacks. */
> >>>> +   vp_disable_vectors(vdev);
> >>>>  }
> >>>>
> >>>>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> >>>> @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
> >>>>  }
> >>>>
> >>>>  static const struct virtio_config_ops virtio_pci_config_ops = {
> >>>> +   .ready          = vp_enable_vectors,
> >>>>     .get            = vp_get,
> >>>>     .set            = vp_set,
> >>>>     .get_status     = vp_get_status,
> >>>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> >>>> index 30654d3a0b41..acf0f6b6381d 100644
> >>>> --- a/drivers/virtio/virtio_pci_modern.c
> >>>> +++ b/drivers/virtio/virtio_pci_modern.c
> >>>> @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
> >>>>      */
> >>>>     while (vp_modern_get_status(mdev))
> >>>>             msleep(1);
> >>>> -   /* Flush pending VQ/configuration callbacks. */
> >>>> -   vp_synchronize_vectors(vdev);
> >>>> +   /* Disable VQ/configuration callbacks. */
> >>>> +   vp_disable_vectors(vdev);
> >>>>  }
> >>>>
> >>>>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> >>>> @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
> >>>>  }
> >>>>
> >>>>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> >>>> +   .ready          = vp_enable_vectors,
> >>>>     .get            = NULL,
> >>>>     .set            = NULL,
> >>>>     .generation     = vp_generation,
> >>>> @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> >>>>  };
> >>>>
> >>>>  static const struct virtio_config_ops virtio_pci_config_ops = {
> >>>> +   .ready          = vp_enable_vectors,
> >>>>     .get            = vp_get,
> >>>>     .set            = vp_set,
> >>>>     .generation     = vp_generation,
> >>>>
> >>
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
