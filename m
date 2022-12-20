Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E22FC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 06:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2ED84410AB;
	Tue, 20 Dec 2022 06:31:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2ED84410AB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IW3qSjbK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HekxyLtM6FwC; Tue, 20 Dec 2022 06:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4AD50410C2;
	Tue, 20 Dec 2022 06:31:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AD50410C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7F4DC0035;
	Tue, 20 Dec 2022 06:31:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E496AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1FD78144A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:31:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1FD78144A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IW3qSjbK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8iZAETiDM3La
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:31:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D884E81438
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D884E81438
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671517885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZk3qbzZQcmYDjImwMsiBT91DtulhDzTYm0+1LHAV3w=;
 b=IW3qSjbKUr/0Da4mswqkjWfZwuJDCdURgs5e8MZ7+itrnID+qaTjdMQCavlhK++tTB+GQw
 JI/LWnzxpe/n6r+zc4DYmfdBIDtJQq3ZyefqTff+uonb0SCjiAUUHhORos4BzhHQa/L0xv
 3Y2tfIkN2gTkmxIpg7FHPogokrrquT0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-iKFoYT-gOu6GBEs-aMuuTw-1; Tue, 20 Dec 2022 01:31:24 -0500
X-MC-Unique: iKFoYT-gOu6GBEs-aMuuTw-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1438729f685so5226185fac.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 22:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZk3qbzZQcmYDjImwMsiBT91DtulhDzTYm0+1LHAV3w=;
 b=TNYKQxMVYVugcRJPgQHETyadYJbrzusa+P486mOwb7OJMUiaEF/ZMm3lHwIEbuYSbB
 s7cio8fvGPpXeXgWO3iO+lixDjq1Tf5waDHg7CEf1C9UXjeSDyhPjRWJxwiexLJFmd7i
 bc25670RO95jxxHMlbWQqy8rDdVPewsd8N3QsCs0+wDv+5lyamcprGalw5PotwrQ9zYQ
 PtDmHlZakRWu58VZIF0Te7J5x6kb5Ip0sJfBH9r9oEqZpCcIsJPKB+99gliVT1W3eui1
 rxqzMmxlQNibom7HQ8dNDX5qqPwM40+rNXFk97kyuoGVGtadAhYCwxJ+stHSgyATitWB
 T8Hg==
X-Gm-Message-State: AFqh2komygALNgsRUtLVXLn5gZSsRwqbGPkZf4sNVGmH52aNYh9kS9rd
 4A92u55JVDpcmUQIr8RMHG+1mMdcarU4GFdFekxnw/gVGVnBB4kJrA64sQDLEnxLbjnaSfDtUGP
 pQTX9hSbVF+h+izVTjqkiQ6jMw6DCob8oKc4Mklfi4hULKdxqqZpVoB3zHg==
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr1889641oab.280.1671517883497; 
 Mon, 19 Dec 2022 22:31:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvKoy5ftThnHdcMKVl2Dp6TYAc0+BDO3DE1yq3+SqZO+4wXy1PGUNILooG1bmd2wIyAmjOtGa3O8sgRPcdrDSk=
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr1889637oab.280.1671517883295; Mon, 19
 Dec 2022 22:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-4-xieyongji@bytedance.com>
 <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
 <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
 <CACGkMEtoX_jPkJnCB6bx0qkB4pfOAPcSDAdwmd9pL4d8Z3cnEg@mail.gmail.com>
 <CACycT3t1AVyDjZ-HzWPHxfhur=hh9aYW3=Fp7ML8YieBbwDa+Q@mail.gmail.com>
In-Reply-To: <CACycT3t1AVyDjZ-HzWPHxfhur=hh9aYW3=Fp7ML8YieBbwDa+Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Dec 2022 14:31:12 +0800
Message-ID: <CACGkMEvXTsWbXUgz+sJPiwas9vV2X8rW6w27oQWivcRveoxCKg@mail.gmail.com>
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

On Mon, Dec 19, 2022 at 3:12 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Mon, Dec 19, 2022 at 2:06 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 19, 2022 at 12:39 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Fri, Dec 16, 2022 at 11:58 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > This introduces set_irq_affinity callback in
> > > > > vdpa_config_ops so that vdpa device driver can
> > > > > get the interrupt affinity hint from the virtio
> > > > > device driver. The interrupt affinity hint would
> > > > > be needed by the interrupt affinity spreading
> > > > > mechanism.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_vdpa.c | 4 ++++
> > > > >  include/linux/vdpa.h         | 8 ++++++++
> > > > >  2 files changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > index 08084b49e5a1..4731e4616ee0 100644
> > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > > > >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> > > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > > > +       struct irq_affinity default_affd = { 0 };
> > > > >         struct vdpa_callback cb;
> > > > >         int i, err, queue_idx = 0;
> > > > >
> > > > > +       if (ops->set_irq_affinity)
> > > > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
> > > >
> > > > I wonder if we need to do this in vhost-vDPA.
> > >
> > > I don't get why we need to do this in vhost-vDPA? Should this be done in VM?
> >
> > If I was not wrong, this tries to set affinity on the host instead of
> > the guest. More below.
> >
>
> Yes, it's host stuff. This is used by the virtio device driver to pass
> the irq affinity hint (tell which irq vectors don't need affinity
> management) to the irq affinity manager. In the VM case, it should
> only be related to the guest's virtio device driver and pci irq
> affinity manager. So I don't get why we need to do this in vhost-vDPA.

It's not necessarily the VM, do we have the same requirement for
userspace (like DPDK) drivers?

Thanks

>
> > >
> > > > Or it's better to have a
> > > > default affinity by the vDPA parent
> > > >
> > >
> > > I think both are OK. But the default value should always be zero, so I
> > > put it in a common place.
> >
> > I think we should either:
> >
> > 1) document the zero default value in vdpa.c
> > 2) set the zero in both vhost-vdpa and virtio-vdpa, or in the vdpa core
> >
>
> Can we only call it in the virtio-vdpa case? Thus the vdpa device
> driver can know whether it needs to do the automatic irq affinity
> management or not. In the vhost-vdpa case, we actually don't need the
> irq affinity management.
>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
