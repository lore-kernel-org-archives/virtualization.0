Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC41FA4
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896394; cv=none; b=s2M0snoRWHNwTNcatUG6meAnqzKaFLqde/qI+qugo8aZsmtckqUE5yYLkjhyZbmQfZSPvntoCi5y1b5ny2PHzL2UhiFlnbRGfhC5gwTkLJJB8BQe9Fjzss2RAPArRZGXBkNCXBOrgfF/3nzbPvqoFokHXriMmPlRcbZLz6rvWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896394; c=relaxed/simple;
	bh=w/E9F7Uv9VHzG+a2XSEpab7stLqBdgdfZsfwuTMD2Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oS+6BSpXt5ETQtVt3cSVZKVhrAlTmuhUvWVCCCwnX0oGsJtElCka5VsTYgvXH7iD7g4rOEQhWFXNejJhKRjyzbS92L+8ujqgBnmiQqQBKLrsKNkoM2Ijen48ESuLEVDuKvbJn0TbNKOScrrzOKTMiuLOfTPY1EvBbPmcdeB2RmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFOQOAmT; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFOQOAmT"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B14CD82046
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B14CD82046
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iFOQOAmT
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MX7dZl_3GAxd
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 04:06:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A280E82034
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:06:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A280E82034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705896390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0G1zcOMwYVF5Am6q3I5TfizUQR1r7FxkBnQWhGkczY=;
	b=iFOQOAmTKvMPnHd/XoZ3orN4OJTJP3OmA859ljLCkBcgYKfoS4/hUAme1/PTLudfPxYnRg
	EDJ+Li9GIA+5W8EOGDlgl+1AxcoTdWSvT7IEJ0NBuKmMIXs1YoT0Uzcsf6rpBd4d0/GQA0
	JWbVnkBuqv1b3sm73/9h0sehdB5HzAo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-nvZAH0riMLWYlphQ_SHigw-1; Sun, 21 Jan 2024 23:06:28 -0500
X-MC-Unique: nvZAH0riMLWYlphQ_SHigw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6dde8cf78c4so3969733a34.1
        for <virtualization@lists.linux-foundation.org>; Sun, 21 Jan 2024 20:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705896387; x=1706501187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0G1zcOMwYVF5Am6q3I5TfizUQR1r7FxkBnQWhGkczY=;
        b=bUyuMNvQNJjFw7wHV1rP4pVuqJpR/ZVRyfE05xE6bGGSHkMs3taBCbJKTYNVC/K/ZI
         I6CNuy/g86ktVhqFK4xmWFKTrHsA30oz5C+llJ8pxHwvJkc/6UTHptDG0MHTimPgkwhD
         0loJ9YzTWf4GzU2RavDhygD1ldsfFhAR6mSJmHybpJnq7BtrTPcLB8POuIuLWBcQNEWX
         carqF1X3i8QWlpBPCmU66pZKKdafwRxT2d2A8XwP4rGlyKhpsOc2nLA5aoK3JE2teSR9
         S3bwHum/yUHP04mbUmwT39lnjVsbfHT2aG3Ci/MK4u3vskqTUQWhSvEYPIFoSoK8Ud4E
         fVKQ==
X-Gm-Message-State: AOJu0YwhLEbFy9ar+IHh/7BMt6fEvbiPM1SLDtjPC0Xw1KbUEvjGmY1s
	wgYTLQm2cU0x74fyjWzss0WH7igXKZigaN8KNQiiQU5b41WFHqv15qhm0da6+UII1AwLLVHOGim
	s5e351A0qLTx0EUTEFjFmL+rAcjb6OH7sh9pEaCPM82ae+VRcYNq90FfdfTDPfHqu2mey8Ab4fm
	Lxca5irAUFWw5SwcmLe0eTC0oaUASeB4Bu6Co3GUsoUsMa5gsDmCnQGA==
X-Received: by 2002:a05:6358:15d6:b0:176:5bef:d33e with SMTP id t22-20020a05635815d600b001765befd33emr436378rwh.14.1705896387140;
        Sun, 21 Jan 2024 20:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGti6AsyCdu5QIJLNdUXo0z42+dA2eB5mYJ/oRVBM0DY85CRNaixV6Ce/TAxYJK7oXKAQdEjuv+kgdbqW2tATE=
X-Received: by 2002:a05:6358:15d6:b0:176:5bef:d33e with SMTP id
 t22-20020a05635815d600b001765befd33emr436374rwh.14.1705896386879; Sun, 21 Jan
 2024 20:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEsCzLNdRXu25tzhrnTVatM6pHwVXVUn7kE=3erVWQUL4g@mail.gmail.com> <700fc2e5-445d-46c4-bdde-0dd29bcdb2bc@oracle.com>
In-Reply-To: <700fc2e5-445d-46c4-bdde-0dd29bcdb2bc@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:05:28 +0800
Message-ID: <CACGkMEsVNNJfUE7JVX6mYdrZ+uWxZYbdwJVOrxXGiK++WwA4Sg@mail.gmail.com>
Subject: Re: [RFC V1 05/13] vhost-vdpa: VHOST_IOTLB_REMAP
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>, 
	Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 4:32=E2=80=AFAM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 1/10/2024 10:08 PM, Jason Wang wrote:
> > On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> When device ownership is passed to a new process via VHOST_NEW_OWNER,
> >> some devices need to know the new userland addresses of the dma mappin=
gs.
> >> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uadd=
r
> >> of a mapping.  The new uaddr must address the same memory object as
> >> originally mapped.
> >>
> >> The user must suspend the device before the old address is invalidated=
,
> >> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
> >> requirement is not enforced by the API.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  drivers/vhost/vdpa.c             | 34 +++++++++++++++++++++++++++++++=
+
> >>  include/uapi/linux/vhost_types.h | 11 ++++++++++-
> >>  2 files changed, 44 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index faed6471934a..ec5ca20bd47d 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -1219,6 +1219,37 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa =
*v,
> >>
> >>  }
> >>
> >> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
> >> +                                         struct vhost_iotlb *iotlb,
> >> +                                         struct vhost_iotlb_msg *msg)
> >> +{
> >> +       struct vdpa_device *vdpa =3D v->vdpa;
> >> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >> +       u32 asid =3D iotlb_to_asid(iotlb);
> >> +       u64 start =3D msg->iova;
> >> +       u64 last =3D start + msg->size - 1;
> >> +       struct vhost_iotlb_map *map;
> >> +       int r =3D 0;
> >> +
> >> +       if (msg->perm || !msg->size)
> >> +               return -EINVAL;
> >> +
> >> +       map =3D vhost_iotlb_itree_first(iotlb, start, last);
> >> +       if (!map)
> >> +               return -ENOENT;
> >> +
> >> +       if (map->start !=3D start || map->last !=3D last)
> >> +               return -EINVAL;
> >> +
> >> +       /* batch will finish with remap.  non-batch must do it now. */
> >> +       if (!v->in_batch)
> >> +               r =3D ops->set_map(vdpa, asid, iotlb);
> >> +       if (!r)
> >> +               map->addr =3D msg->uaddr;
> >
> > I may miss something, for example for PA mapping,
> >
> > 1) need to convert uaddr into phys addr
> > 2) need to check whether the uaddr is backed by the same page or not?
>
> This code does not verify that the new size@uaddr points to the same phys=
ical
> pages as the old size@uaddr.  If the app screws up and they differ, then =
the app
> may corrupt its own memory, but no-one else's.
>
> It would be expensive for large memories to verify page by page, O(npages=
), and such
> verification lies on the critical path for virtual machine downtime durin=
g live update.
> I could compare the properties of the vma(s) for the old size@uaddr vs th=
e vma for the
> new, but that is more complicated and would be a maintenance headache.  W=
hen I submitted
> such code to Alex W when writing the equivalent patches for vfio, he said=
 don't check,
> correctness is the user's responsibility.

Ok, let's document this somewhere.

Thanks

>
> - Steve
>
> >> +
> >> +       return r;
> >> +}
> >> +
> >>  static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> >>                                            struct vhost_iotlb *iotlb,
> >>                                            struct vhost_iotlb_msg *msg=
)
> >> @@ -1298,6 +1329,9 @@ static int vhost_vdpa_process_iotlb_msg(struct v=
host_dev *dev, u32 asid,
> >>                         ops->set_map(vdpa, asid, iotlb);
> >>                 v->in_batch =3D false;
> >>                 break;
> >> +       case VHOST_IOTLB_REMAP:
> >> +               r =3D vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
> >> +               break;
> >>         default:
> >>                 r =3D -EINVAL;
> >>                 break;
> >> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vho=
st_types.h
> >> index 9177843951e9..35908315ff55 100644
> >> --- a/include/uapi/linux/vhost_types.h
> >> +++ b/include/uapi/linux/vhost_types.h
> >> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
> >>  /*
> >>   * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
> >>   * multiple mappings in one go: beginning with
> >> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
> >> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REM=
AP or
> >>   * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END=
.
> >>   * When one of these two values is used as the message type, the rest
> >>   * of the fields in the message are ignored. There's no guarantee tha=
t
> >> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
> >>   */
> >>  #define VHOST_IOTLB_BATCH_BEGIN    5
> >>  #define VHOST_IOTLB_BATCH_END      6
> >> +
> >> +/*
> >> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping a=
t iova.
> >> + * The new uaddr must address the same memory object as originally ma=
pped.
> >> + * Failure to do so will result in user memory corruption and/or devi=
ce
> >> + * misbehavior.  iova and size must match the arguments used to creat=
e the
> >> + * an existing mapping.  Protection is not changed, and perm must be =
0.
> >> + */
> >> +#define VHOST_IOTLB_REMAP          7
> >>         __u8 type;
> >>  };
> >>
> >> --
> >> 2.39.3
> >>
> >
>

