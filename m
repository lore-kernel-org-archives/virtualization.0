Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A35C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 02:16:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E026115A
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 02:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62E026115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B14F401C3;
	Thu, 28 Oct 2021 02:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yp_oN-9969Oe; Thu, 28 Oct 2021 02:16:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54BE34010E;
	Thu, 28 Oct 2021 02:16:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F07AC0019;
	Thu, 28 Oct 2021 02:16:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4569C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9FC240553
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HwZLR_rn05pU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:16:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A71C940551
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635387384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zyX1NBb1GFWiobOEsK//3db/aGGpCgwG1Zhr5JwpAoA=;
 b=RwOv3+6p98mQXdY8UICvKgGIQKkqXyHGTGHzMjTbkG9HRTHJ/vgNri/KMrqtFPY/DZUKHf
 KcBI1G4E3DDPas44w3vEE59+RSxz8P7RGWRSK+Ftr4Fzqi3hdd0x+AWwhQ2kTplhrbFz6Q
 CQFAayWbG6M4an6egDZECiZbot1JUIQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-EAOFtuAOOJazm7828QMGcg-1; Wed, 27 Oct 2021 22:16:23 -0400
X-MC-Unique: EAOFtuAOOJazm7828QMGcg-1
Received: by mail-lf1-f71.google.com with SMTP id
 p19-20020a056512139300b003ff6dfea137so2143982lfa.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zyX1NBb1GFWiobOEsK//3db/aGGpCgwG1Zhr5JwpAoA=;
 b=zaAoS8TKDx4tIX890T+NLaFOer03jicJ6KQGSibg5qwjacFujNZEhOWmRIkMPuLIO7
 mq8TkwGUuFnhIO4auWe7+fbnxGm1ra+R14/p3STWBJM6x+WbKZ/PhAuAPtr1ffN2Rs7j
 QXGJodEwDJCmgLsaUuIeXiTVYy0gzsGd2ER2PqikieXZv/ofM4w5fbckFEPREalaAtQu
 hflVYvCIUJC5/hH2bxBpU4rbTWF4MBcb7b9iKqHPCp6C/sV43oG2jF9mw/1ij/sJii6L
 dNRquG0g6O0fEF62UG/bDUAAmyAlXU0SDl60fnWrqStDdyAnxxOkL2+Hpo3w3AYyKBWn
 4w4w==
X-Gm-Message-State: AOAM531xedqd25gdW8NpEF1lyQqztJUEQV7o08UyOV3pmPywNZ+P7q8N
 lb9ysmQ9cDab0vbmagvwuh5fu+pTpJFQEV8g2/h+HVI/fJpM7XxcZ3EvxQ2A5G6IeeX9YRGy1Ii
 CpskM9Md/ZOjLKbzcTF4kkBsGpy42IeK2Xpb/jdVLisQtmirbp5dO623WfA==
X-Received: by 2002:a2e:9155:: with SMTP id q21mr1593759ljg.217.1635387381509; 
 Wed, 27 Oct 2021 19:16:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1snIYTirnKARWwiJO7raESyFHFyqNmD63SLBFxBpCK3iJaSWiFVXSRp1q8HHPRpYpIeMj6ciyoG44KjLUbIk=
X-Received: by 2002:a2e:9155:: with SMTP id q21mr1593727ljg.217.1635387381190; 
 Wed, 27 Oct 2021 19:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211027061913.76276-1-xuanzhuo@linux.alibaba.com>
 <20211027061913.76276-2-xuanzhuo@linux.alibaba.com>
 <20211027130429-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211027130429-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Oct 2021 10:16:10 +0800
Message-ID: <CACGkMEssaFCNgmRL4b5P5Dpm3WBhpQX37t-_j9Bc6wndTh4UHw@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio: cache indirect desc for split
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Oct 28, 2021 at 1:07 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Oct 27, 2021 at 02:19:11PM +0800, Xuan Zhuo wrote:
> > In the case of using indirect, indirect desc must be allocated and
> > released each time, which increases a lot of cpu overhead.
> >
> > Here, a cache is added for indirect. If the number of indirect desc to be
> > applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
> > the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio.c      |  6 ++++
> >  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++++++++++++------
> >  include/linux/virtio.h       | 10 ++++++
> >  3 files changed, 70 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 0a5b54034d4b..04bcb74e5b9a 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -431,6 +431,12 @@ bool is_virtio_device(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(is_virtio_device);
> >
> > +void virtio_use_desc_cache(struct virtio_device *dev, bool val)
> > +{
> > +     dev->desc_cache = val;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_use_desc_cache);
> > +
> >  void unregister_virtio_device(struct virtio_device *dev)
> >  {
> >       int index = dev->index; /* save for after device release */
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index dd95dfd85e98..0b9a8544b0e8 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -117,6 +117,10 @@ struct vring_virtqueue {
> >       /* Hint for event idx: already triggered no need to disable. */
> >       bool event_triggered;
> >
> > +     /* Is indirect cache used? */
> > +     bool use_desc_cache;
> > +     void *desc_cache_chain;
> > +
> >       union {
> >               /* Available for split ring */
> >               struct {
> > @@ -423,12 +427,47 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> >       return extra[i].next;
> >  }
> >
> > -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> > +#define VIRT_QUEUE_CACHE_DESC_NUM 4
> > +
> > +static void desc_cache_chain_free_split(void *chain)
> > +{
> > +     struct vring_desc *desc;
> > +
> > +     while (chain) {
> > +             desc = chain;
> > +             chain = (void *)desc->addr;
> > +             kfree(desc);
> > +     }
> > +}
> > +
> > +static void desc_cache_put_split(struct vring_virtqueue *vq,
> > +                              struct vring_desc *desc, int n)
> > +{
> > +     if (vq->use_desc_cache && n <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > +             desc->addr = (u64)vq->desc_cache_chain;
> > +             vq->desc_cache_chain = desc;
> > +     } else {
> > +             kfree(desc);
> > +     }
> > +}
> > +
>
>
> So I have a question here. What happens if we just do:
>
> if (n <= VIRT_QUEUE_CACHE_DESC_NUM) {
>         return kmem_cache_alloc(VIRT_QUEUE_CACHE_DESC_NUM * sizeof desc, gfp)
> } else {
>         return kmalloc_arrat(n, sizeof desc, gfp)
> }
>
> A small change and won't we reap most performance benefits?

Yes, I think we need a benchmark to use private cache to see how much
it can help.

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
