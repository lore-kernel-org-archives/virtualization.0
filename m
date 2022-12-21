Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5B4C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 03:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B0244185B;
	Wed, 21 Dec 2022 03:20:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B0244185B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JZ/mtVfY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id THRoxxxluiD4; Wed, 21 Dec 2022 03:20:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A3BF741843;
	Wed, 21 Dec 2022 03:20:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3BF741843
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F166C007B;
	Wed, 21 Dec 2022 03:20:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0221C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B563281F87
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:20:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B563281F87
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JZ/mtVfY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_SMBWVhop-r
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:20:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0E4E81F7C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0E4E81F7C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671592833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EcW/ZVp4YYgciJ7BFnCTvXG9mJ4eyjo2xCwkenfL2F4=;
 b=JZ/mtVfY2AN2a35t37UMPNYiviXahAZwn0zYpzmK6OkcjQqL5xP5G4U5Cf7Xjqt9ldaHE+
 jkTiZyVrj6Oa0nRF9CeGiNlmXOaiJnbWvogmebh2Ms6UvNZoKzL/An/L4/Rp5F7rNS9KkM
 rpNVITPLt/N55c4R+r80/x/M1tVVGcw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-oQvwFKCJOx67vYFZMFS3wA-1; Tue, 20 Dec 2022 22:20:32 -0500
X-MC-Unique: oQvwFKCJOx67vYFZMFS3wA-1
Received: by mail-ot1-f71.google.com with SMTP id
 cr28-20020a056830671c00b006774d5923ddso6139035otb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 19:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EcW/ZVp4YYgciJ7BFnCTvXG9mJ4eyjo2xCwkenfL2F4=;
 b=6sJgg/fuxdSZ7JwsJdX7mfMTfVyAndBcOW8T9yHdROdbSlA/9RWgMvql4RKZcLtZdz
 0qKaq7j2c7CHC9An7Z9DheVv0+cybyWRhXO+sj0YdthgbkdU8nQRsmqO1VbOEvXzhq3l
 0V9Tyvrr1W73RUzV+tsXqwomfU+xhNDn+DNcaxauLu6eDcosRtW1od5fnlL9hIhxbeHT
 os6X9fMLAiVa7VmaAl2b8RC2Tqk9HVG7upNkfFwvmSwAktGfAJcD4WtGFT26w53SRP7X
 LoxEr2FwpzmLXKtZTlFGQgUu8KgHjUseKKkJKCxd87k2M1ESlZS0ULSc5GKrdPOqdl5O
 fr1Q==
X-Gm-Message-State: AFqh2kqmioM7zXoeFFH2uHmTY5Iqo0t9OIHa72l+jRZyuE8xiw3MFxUq
 3rWt8BfVQgms++j4C6yzuAiPTPr+rduianvW2NdhyhHI5cipgU8wAD8Wujq/kXCbvmOMiSwtjWh
 53GWZVocv3Ejmw6P0hZEcOC7+np53YoxhboexxVtTj7ZDPwTh+37WVSMNUw==
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr11204oir.280.1671592831683; 
 Tue, 20 Dec 2022 19:20:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuOxGS1RwYuR3X0E7axAQcQe8M4mP2vAHYvXCHnKF7f+yeLTSx8haGOu/8+MQFm4fxS9ZnxKRzdLU+AK2EWdTU=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr11202oir.280.1671592831507; Tue, 20 Dec
 2022 19:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-4-xieyongji@bytedance.com>
 <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
 <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
 <CACGkMEtoX_jPkJnCB6bx0qkB4pfOAPcSDAdwmd9pL4d8Z3cnEg@mail.gmail.com>
 <CACycT3t1AVyDjZ-HzWPHxfhur=hh9aYW3=Fp7ML8YieBbwDa+Q@mail.gmail.com>
 <CACGkMEvXTsWbXUgz+sJPiwas9vV2X8rW6w27oQWivcRveoxCKg@mail.gmail.com>
 <CACycT3vP42dpq5NXFJ-Qua=MKsW9visq+mykS7H6i9gUcqo4NQ@mail.gmail.com>
In-Reply-To: <CACycT3vP42dpq5NXFJ-Qua=MKsW9visq+mykS7H6i9gUcqo4NQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Dec 2022 11:20:20 +0800
Message-ID: <CACGkMEvMCqvFwWYOd1U2Z8YXBkxSHK9QX8fWVLdU6oo9WWNRZQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vdpa: Add set_irq_affinity callback in
 vdpa_config_ops
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

On Tue, Dec 20, 2022 at 6:14 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Tue, Dec 20, 2022 at 2:31 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 19, 2022 at 3:12 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Mon, Dec 19, 2022 at 2:06 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Dec 19, 2022 at 12:39 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > On Fri, Dec 16, 2022 at 11:58 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > > >
> > > > > > > This introduces set_irq_affinity callback in
> > > > > > > vdpa_config_ops so that vdpa device driver can
> > > > > > > get the interrupt affinity hint from the virtio
> > > > > > > device driver. The interrupt affinity hint would
> > > > > > > be needed by the interrupt affinity spreading
> > > > > > > mechanism.
> > > > > > >
> > > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > > > ---
> > > > > > >  drivers/virtio/virtio_vdpa.c | 4 ++++
> > > > > > >  include/linux/vdpa.h         | 8 ++++++++
> > > > > > >  2 files changed, 12 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > > index 08084b49e5a1..4731e4616ee0 100644
> > > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > > @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > > > > > >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> > > > > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > > > > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > > > > > +       struct irq_affinity default_affd = { 0 };
> > > > > > >         struct vdpa_callback cb;
> > > > > > >         int i, err, queue_idx = 0;
> > > > > > >
> > > > > > > +       if (ops->set_irq_affinity)
> > > > > > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
> > > > > >
> > > > > > I wonder if we need to do this in vhost-vDPA.
> > > > >
> > > > > I don't get why we need to do this in vhost-vDPA? Should this be done in VM?
> > > >
> > > > If I was not wrong, this tries to set affinity on the host instead of
> > > > the guest. More below.
> > > >
> > >
> > > Yes, it's host stuff. This is used by the virtio device driver to pass
> > > the irq affinity hint (tell which irq vectors don't need affinity
> > > management) to the irq affinity manager. In the VM case, it should
> > > only be related to the guest's virtio device driver and pci irq
> > > affinity manager. So I don't get why we need to do this in vhost-vDPA.
> >
> > It's not necessarily the VM, do we have the same requirement for
> > userspace (like DPDK) drivers?
> >
>
> IIUC the vhost-vdpa's irq callback just signals the eventfd. I didn't
> see how to use the irq affinity hint in vdpa device driver. The real
> irq callback should be called in DPDK internally.

I agree.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
