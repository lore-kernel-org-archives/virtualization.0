Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40247186A
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264118; cv=none; b=iWvLQ5Ivo2uLoOEuit1NzP7jhLIBW22PygcE/CJjCjxg4O56gZ1qyebC4SLuIGx4p50VILDCyjpCgu+VHk+Y+MP07EIA5LMCaxxgxbuoGLeiOVAxy8MqRtcCHaACkCibVl3jIsDSjpe9ftgKAXJ1wZl1LcjPzJXYuY6fft76NV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264118; c=relaxed/simple;
	bh=zPIg+4eb6WoHfiAiG3KlsYSlCN+gdWNJn8xNEEP0J1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5ql8yYDtEOd9gCCx2wH4isyctaNF4f/hQzVT7vySYbODUW6qsL1ftHcxPrzBb9o98bagCR/0jZYEnke07wAGhXJOUPMiOWydqoPFL6MQh3gI9yR/kgJJb9rZ5aSrhp8hisXHABVq1BCcFMoPT1vBhl0KgXVyi5IUuV3sLtdTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebBeSrvn; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebBeSrvn"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F2E180C3A
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 00:45:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DHWIIzjCIRvD for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Jul 2024 00:45:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 72FB780C29
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72FB780C29
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ebBeSrvn
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 72FB780C29
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 00:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721263547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuGBSeFQsnlLdV7vrAMqLKj9qYzNTsXMEl3YsWB1yD0=;
	b=ebBeSrvnxtR1egAHCzf0eRQXvh9pvxYp9ZH+ssbiX1LtWxubnVqrpv4rPZRZav6+xbHG3p
	JMuQ+8IhYHUK2Iq1qKmDOiP6fKgLV244ugYlgE2cUW53GDKHreaEpop/3jpl1Tm6qqbAeX
	Ulet6a3qcjyWN2C4aex9Qg6kk47E3DE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-xTQDEnH2NGqOX_iIVFgkvA-1; Wed, 17 Jul 2024 20:45:46 -0400
X-MC-Unique: xTQDEnH2NGqOX_iIVFgkvA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70af524f6b9so208967b3a.2
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 17:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721263543; x=1721868343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuGBSeFQsnlLdV7vrAMqLKj9qYzNTsXMEl3YsWB1yD0=;
        b=iZp6gdWE0HwYMUcSVSYQ1j/dmPa0ItMf+gSxOGh7eouFZwhfR4pzxbyPKxZpJ+yldD
         o8GZm/dbRTejZSq/KGLH7nWcfdvSvRUpPgxBMBVg0z5vxrBxOVblsoRDyEgxS4OLe4DD
         OWiQZSP5cNnnMB1I7uY0whAs0ccTff2fh0uM6oZMpWrbzqRJ+E33te9PqqiGSpu2GPjn
         cRv+I0sCEW7eGjz6csjmk3/FKgD+KKc/4wiAJWM3OhK5/sOeB51za/P4XASWB38TP/dz
         ln4EYmK6YasViQMBjnEbawpELmAEbPQwVjz7X9r/F/enqzljudmy9uLN7Dg9H679ahOY
         QWqg==
X-Gm-Message-State: AOJu0YyovmUId0GVgUYusX84ZwUZB4MVF9zRte3H5v1TJoDr53ARCml7
	xI5yU/urBMsO3GFuSncKKHFSlZllGjc7q97+/hyMVoMi+UdKPG4eJf4wAIJy3QgAgdRWhiqS/Vn
	6Ilt5hXbEdej9jBxseOI6FZJNv55hZKK9zGo1of0vQwq5dJvWkpw5WmLYwzDEDMaM3OvvkbtWd3
	3HHr+R458iamtKOIvKaxJGRwa3Qb55hDU9bYYfIqotqV+xEsjqIP54ew==
X-Received: by 2002:a05:6a00:cd3:b0:70b:a46:7dbe with SMTP id d2e1a72fcca58-70ce4f74761mr3934055b3a.6.1721263543058;
        Wed, 17 Jul 2024 17:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEHUp2yLgFHjwlsv0tj9A0qEaGT1mHaLLnevxyAG688KmcyWJmEu2amcwCK/Wgj10hCEgcDt9cDijnUeA045E=
X-Received: by 2002:a05:6a00:cd3:b0:70b:a46:7dbe with SMTP id
 d2e1a72fcca58-70ce4f74761mr3934038b3a.6.1721263542518; Wed, 17 Jul 2024
 17:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
 <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com> <CACGkMEuj-6EcEPo9xKkmuPSaQPQnH6zG+j2cqLRiScWUB4oqXw@mail.gmail.com>
 <5a1cfaaf-64aa-426a-b1b4-da84a66b362a@oracle.com>
In-Reply-To: <5a1cfaaf-64aa-426a-b1b4-da84a66b362a@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Jul 2024 08:45:31 +0800
Message-ID: <CACGkMEtuErg+nd96k6FkL9dfSxOv2o38L1HSsK9jU-xmmkv8oQ@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 2:29=E2=80=AFAM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/16/2024 1:28 AM, Jason Wang wrote:
> > On Mon, Jul 15, 2024 at 10:28=E2=80=AFPM Steven Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> On 7/14/2024 10:34 PM, Jason Wang wrote:
> >>> On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare=
@oracle.com> wrote:
> >>>>
> >>>> When device ownership is passed to a new process via VHOST_NEW_OWNER=
,
> >>>> some devices need to know the new userland addresses of the dma mapp=
ings.
> >>>> Define the new iotlb message type VHOST_IOTLB_REMAP to update the ua=
ddr
> >>>> of a mapping.  The new uaddr must address the same memory object as
> >>>> originally mapped.
> >>>>
> >>>> The user must suspend the device before the old address is invalidat=
ed,
> >>>> and cannot resume it until after VHOST_IOTLB_REMAP is called, but th=
is
> >>>> requirement is not enforced by the API.
> >>>>
> >>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>>> ---
> >>>>    drivers/vhost/vdpa.c             | 58 +++++++++++++++++++++++++++=
+++++
> >>>>    include/uapi/linux/vhost_types.h | 11 +++++-
> >>>>    2 files changed, 68 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>> index 4396fe1a90c4..51f71c45c4a9 100644
> >>>> --- a/drivers/vhost/vdpa.c
> >>>> +++ b/drivers/vhost/vdpa.c
> >>>> @@ -1257,6 +1257,61 @@ static int vhost_vdpa_pa_map(struct vhost_vdp=
a *v,
> >>>>
> >>>>    }
> >>>>
> >>>> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
> >>>> +                                         struct vhost_iotlb *iotlb,
> >>>> +                                         struct vhost_iotlb_msg *ms=
g)
> >>>> +{
> >>>> +       struct vdpa_device *vdpa =3D v->vdpa;
> >>>> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >>>> +       u32 asid =3D iotlb_to_asid(iotlb);
> >>>> +       u64 start =3D msg->iova;
> >>>> +       u64 last =3D start + msg->size - 1;
> >>>> +       struct vhost_iotlb_map *map;
> >>>> +       int r =3D 0;
> >>>> +
> >>>> +       if (msg->perm || !msg->size)
> >>>> +               return -EINVAL;
> >>>> +
> >>>> +       map =3D vhost_iotlb_itree_first(iotlb, start, last);
> >>>> +       if (!map)
> >>>> +               return -ENOENT;
> >>>> +
> >>>> +       if (map->start !=3D start || map->last !=3D last)
> >>>> +               return -EINVAL;
> >>>
> >>> I had a question here, if a buggy user space that:
> >>>
> >>> 1) forget to update some of the mappings
> >>> 2) address is wrong
> >>> 3) other cases.
> >>>
> >>> Does this mean the device can DMA to the previous owner?
> >>
> >> Yes, but only to the mappings which were already pinned for DMA for th=
is
> >> device, and the old owner is giving the new owner permission to DMA to=
 that
> >> memory even without bugs.
> >>
> >>> If yes, does
> >>> this have security implications?
> >>
> >> No.  The previous owner has given the new owner permission to take ove=
r.  They
> >> trust each other completely. In the live update case, they are the sam=
e; the new
> >> owner is the old owner reincarnated.
> >
> > I understand the processes may trust each other but I meant the kernel
> > may not trust those processes.
>
> If a process holds the key (the fd) then the kernel can trust that is has
> permission to use it.  Keys are only passed around voluntarily, unless th=
ere
> is a bug.

Looks not, for example, kernel can choose to limit various operations
on a fd, even if the process holds the key

1) privileged process do setup on fd, passing that fd to unprivileged fd
2) unprivileged process can only use a subset of the functions of a fd

In the case of Qemu, it prevents the kernel from the case where for
example malicious guests can escape to Qemu.

In the case of vhost-net, the privilege is the owner. For example, the
following seems to be valid in the case of vhost-net:

1) Two processes (A and B) share a part of the memory
2) A is the owner of the vhost-net who is in charge of building memory
mappings via IOTLB
3) A passess vhost-net fd to process B

>
> > For example:
> >
> > 1) old owner pass fd to new owner which is another process
> > 2) the new owner do VHOST_NEW_OWNER
> > 3) new owner doesn't do remap correctly
> >
> > There's no way for the old owner to remove/unpin the mappings as we
> > have the owner check in IOTLB_UPDATE. Looks like a potential way for
> > DOS.
>
> This is a bug in the second cooperating process, not a DOS.  The applicat=
ion
> must fix it.  Sometimes you cannot recover from an application bug at run=
 time.
>
> BTW, at one time vfio enforced the concept of an owner, but Alex deleted =
it.
> It adds no value, because possession of the fd is the key.
>    ffed0518d871 ("vfio: remove useless judgement")

This seems to be a great relaxation of the ownership check. I would
like to hear from Michael first.

Thanks

>
> - Steve
>
> >>>> +
> >>>> +       /*
> >>>> +        * The current implementation does not support the platform =
iommu
> >>>> +        * with use_va.  And if !use_va, remap is not necessary.
> >>>> +        */
> >>>> +       if (!ops->set_map && !ops->dma_map)
> >>>> +               return -EINVAL;
> >>>> +
> >>>> +       /*
> >>>> +        * The current implementation supports set_map but not dma_m=
ap.
> >>>> +        */
> >>>> +       if (!ops->set_map)
> >>>> +               return -EINVAL;
> >>>> +
> >>>> +       /*
> >>>> +        * Do not verify that the new size@uaddr points to the same =
physical
> >>>> +        * pages as the old size@uaddr, because that would take time=
 O(npages),
> >>>> +        * and would increase guest down time during live update.  I=
f the app
> >>>> +        * is buggy and they differ, then the app may corrupt its ow=
n memory,
> >>>> +        * but no one else's.
> >>>> +        */
> >>>> +
> >>>> +       /*
> >>>> +        * Batch will finish later in BATCH_END by calling set_map f=
or the new
> >>>> +        * addresses collected here.  Non-batch must do it now.
> >>>> +        */
> >>>> +       if (!v->in_batch)
> >>>> +               r =3D ops->set_map(vdpa, asid, iotlb);
> >>>> +       if (!r)
> >>>> +               map->addr =3D msg->uaddr;
> >>>> +
> >>>> +       return r;
> >>>> +}
> >>>> +
> >>>>    static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> >>>>                                              struct vhost_iotlb *iot=
lb,
> >>>>                                              struct vhost_iotlb_msg =
*msg)
> >>>> @@ -1336,6 +1391,9 @@ static int vhost_vdpa_process_iotlb_msg(struct=
 vhost_dev *dev, u32 asid,
> >>>>                           ops->set_map(vdpa, asid, iotlb);
> >>>>                   v->in_batch =3D false;
> >>>>                   break;
> >>>> +       case VHOST_IOTLB_REMAP:
> >>>> +               r =3D vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
> >>>> +               break;
> >>>>           default:
> >>>>                   r =3D -EINVAL;
> >>>>                   break;
> >>>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/v=
host_types.h
> >>>> index 9177843951e9..35908315ff55 100644
> >>>> --- a/include/uapi/linux/vhost_types.h
> >>>> +++ b/include/uapi/linux/vhost_types.h
> >>>> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
> >>>>    /*
> >>>>     * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modify=
ing
> >>>>     * multiple mappings in one go: beginning with
> >>>> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
> >>>> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_R=
EMAP or
> >>>>     * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH=
_END.
> >>>>     * When one of these two values is used as the message type, the =
rest
> >>>>     * of the fields in the message are ignored. There's no guarantee=
 that
> >>>> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
> >>>>     */
> >>>>    #define VHOST_IOTLB_BATCH_BEGIN    5
> >>>>    #define VHOST_IOTLB_BATCH_END      6
> >>>> +
> >>>> +/*
> >>>> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping=
 at iova.
> >>>> + * The new uaddr must address the same memory object as originally =
mapped.
> >>>> + * Failure to do so will result in user memory corruption and/or de=
vice
> >>>> + * misbehavior.  iova and size must match the arguments used to cre=
ate the
> >>>> + * an existing mapping.  Protection is not changed, and perm must b=
e 0.
> >>>> + */
> >>>> +#define VHOST_IOTLB_REMAP          7
> >>>>           __u8 type;
> >>>>    };
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>> --
> >>>> 2.39.3
> >>>>
> >>>
> >>
> >
>

