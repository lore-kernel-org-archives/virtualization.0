Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00811CA80
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jul 2024 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107043; cv=none; b=SZI3c8QJv0F37Xt9mTlE38qdIlRtWaPNWqDXkpHBEcn9Slreu7Q6kUwribEHwu7KvqIY9okstalMR6LmlwwZrtnX0xwl0mU1YxyOhx5jaF7UD5v4ggEUVlOtozpRxbN9NMiu65OWU/jjaMkneS9YSYutYvfPW8IxWfPbBJkj680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107043; c=relaxed/simple;
	bh=Ei8Zh+WUYz9gyI6jvfia3vMDKTzpVSDcVJwlBtwjSN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkm6mSPbdteNsoXqL3tulycLPiRW8axKIliaxrBTi4bWBBlSX8MvErlzxQe2CAwAUaHWrRPJ2Q92+c5KLpn1vCuWuUJp8p9VRC5/ict1cFId2jOBmtlZd5y1iLsu+l/xkAU3lItERoy2X1JPEUeZmJxUBAS1gzQ+TsmpSlYy+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCpwQ2ei; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCpwQ2ei"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8099B810B6
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jul 2024 05:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_sRwXeI8IqU for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Jul 2024 05:17:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7544E810A6
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7544E810A6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WCpwQ2ei
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7544E810A6
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jul 2024 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721107037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV35LYaNNEGWx8EBWfuJaXV5qmmqt8q3YPSyBVDLw84=;
	b=WCpwQ2ei2CgPgeATdYARUnWY2jdRAWR+rFBJDonlhygl3ctA8Z2m4cuahNIuLi7I0BYNHZ
	6Z5QS7neyXJJqy7TXA6gXZGZ2MN/YVAy4ZO1pUj/6/IxaJM0O5xeG9cZcIUc49n5MBR1Vl
	aUhCcfCF3OTwo6zQq3Lhv86hV4AYKUQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-qE_6cjIxNlO3AIN0AKLonQ-1; Tue, 16 Jul 2024 01:17:13 -0400
X-MC-Unique: qE_6cjIxNlO3AIN0AKLonQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c99c1075c9so4304972a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 22:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721107032; x=1721711832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iV35LYaNNEGWx8EBWfuJaXV5qmmqt8q3YPSyBVDLw84=;
        b=vXHYeTNG9gQJx29PZm2Pps63WhE+a0EG9Np2Z8XWu6CzN2ldqozVUeCW1FHWkqKkL8
         MILqqxdaW8Dg9e58Y8fK8JvG/9pLK0hHv8t4YHNS5T/pBNn2qldsSvQMeY8qdPEL2A/i
         Rd2X1s3b8eUdbb+fII2sbe5oNxp4zCLGvhLLXYl5VahXoJJcXcLg61SAvx8P14oZ28Hn
         /4tPA52y/haM1Dcoe5vqPzdzbmTynFvvsUPMswGYT5pE4h9QZTPdp+rs8xQWT2ewH8Zp
         73fJtlfOZvMW8qGIKrk1QAhfniV+ILfFLLFLqN5xMh2EIgOo7oIr4O1bLOf4f+xSJppD
         bgKw==
X-Gm-Message-State: AOJu0YzrF+74d9ccUEXmQ2IKhbntVmsBuYVWWvXtUMxhws4o4RZ2w1rn
	DIQYq1LDRa9vVD7Msik/XIhm+T240b4i2hG7D1LYzP+3XPPdJocGE+KXU78p+1hkRZDzk1AL3yV
	ukD/+qumKeChSKotkgZWtWeLxPUWDNzATmvZFR488yAVuigVB276Xx2QMH6+B30DoAU6ixJ82IH
	fISA3IuLLZl3CqQMetCSreJzd7zHupa2nn4iWfz89qIiNpIfpZ6Tdx7g==
X-Received: by 2002:a17:90a:bb07:b0:2c8:f3b4:425 with SMTP id 98e67ed59e1d1-2cb3740ee4emr790011a91.23.1721107031940;
        Mon, 15 Jul 2024 22:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ANQt5ows3QOa5bdpVKACuf5yOTcvmdotzZ6xqk3YrNrhe/6vFwXEh88rK+S5GL0Jwr+RG+N864dnR4xWlNg=
X-Received: by 2002:a17:90a:bb07:b0:2c8:f3b4:425 with SMTP id
 98e67ed59e1d1-2cb3740ee4emr790002a91.23.1721107031501; Mon, 15 Jul 2024
 22:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
 <CACGkMEu0sNx=saZOaVRbuV7Gz7+_GD-v42i+Bdk-NCp6syABbw@mail.gmail.com> <acfccf72-2883-407d-977a-9c2566cf8cb3@oracle.com>
In-Reply-To: <acfccf72-2883-407d-977a-9c2566cf8cb3@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Jul 2024 13:16:59 +0800
Message-ID: <CACGkMEtL7Fkj+srq+beK8UBZ5QDowpz+hT2HZ8RZR00UsRJcVA@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 10:27=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/14/2024 10:26 PM, Jason Wang wrote:
> > On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> Add an ioctl to transfer file descriptor ownership and pinned memory
> >> accounting from one process to another.
> >>
> >> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OW=
NER,
> >> as that would unpin all physical pages, requiring them to be repinned =
in
> >> the new process.  That would cost multiple seconds for large memories,=
 and
> >> be incurred during a virtual machine's pause time during live update.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>   drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++=
++
> >>   drivers/vhost/vhost.c      | 15 ++++++++++++++
> >>   drivers/vhost/vhost.h      |  1 +
> >>   include/uapi/linux/vhost.h | 10 ++++++++++
> >>   4 files changed, 67 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index b49e5831b3f0..5cf55ca4ec02 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *=
v)
> >>          return ret;
> >>   }
> >>
> >> +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
> >> +{
> >> +       int r;
> >> +       struct vhost_dev *vdev =3D &v->vdev;
> >> +       struct mm_struct *mm_old =3D vdev->mm;
> >> +       struct mm_struct *mm_new =3D current->mm;
> >> +       long pinned_vm =3D v->pinned_vm;
> >> +       unsigned long lock_limit =3D PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> >> +
> >> +       if (!mm_old)
> >> +               return -EINVAL;
> >> +       mmgrab(mm_old);
> >> +
> >> +       if (!v->vdpa->use_va &&
> >> +           pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit=
) {
> >> +               r =3D -ENOMEM;
> >> +               goto out;
> >> +       }
> >
> > So this seems to allow an arbitrary process to execute this. Seems to b=
e unsafe.
> >
> > I wonder if we need to add some checks here, maybe PID or other stuff
> > to only allow the owner process to do this.
>
> The original owner must send the file descriptor to the new owner.

This seems not to be in the steps you put in the cover letter.

> That constitutes permission to take ownership.

This seems like a relaxed version of the reset_owner:

Currently, reset_owner have the following check:

/* Caller should have device mutex */
long vhost_dev_check_owner(struct vhost_dev *dev)
{
        /* Are you the owner? If not, I don't think you mean to do that */
        return dev->mm =3D=3D current->mm ? 0 : -EPERM;
}
EXPORT_SYMBOL_GPL(vhost_dev_check_owner);

It means even if the fd is passed to some other process, the reset
owner won't work there.

Thanks

>
> >> +       r =3D vhost_vdpa_bind_mm(v, mm_new);
> >> +       if (r)
> >> +               goto out;
> >> +
> >> +       r =3D vhost_dev_new_owner(vdev);
> >> +       if (r) {
> >> +               vhost_vdpa_bind_mm(v, mm_old);
> >> +               goto out;
> >> +       }
> >> +
> >> +       if (!v->vdpa->use_va) {
> >> +               atomic64_sub(pinned_vm, &mm_old->pinned_vm);
> >> +               atomic64_add(pinned_vm, &mm_new->pinned_vm);
> >> +       }
> >> +
> >> +out:
> >> +       mmdrop(mm_old);
> >> +       return r;
> >> +}
> >> +
> >>   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned in=
t cmd,
> >>                                     void __user *argp)
> >>   {
> >> @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file =
*filep,
> >>          case VHOST_VDPA_RESUME:
> >>                  r =3D vhost_vdpa_resume(v);
> >>                  break;
> >> +       case VHOST_NEW_OWNER:
> >> +               r =3D vhost_vdpa_new_owner(v);
> >> +               break;
> >>          default:
> >>                  r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
> >>                  if (r =3D=3D -ENOIOCTLCMD)
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index b60955682474..ab40ae50552f 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> >>   }
> >>   EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
> >>
> >> +/* Caller should have device mutex */
> >> +long vhost_dev_new_owner(struct vhost_dev *dev)
> >> +{
> >> +       if (dev->mm =3D=3D current->mm)
> >> +               return -EBUSY;
> >> +
> >> +       if (!vhost_dev_has_owner(dev))
> >> +               return -EINVAL;
> >> +
> >> +       vhost_detach_mm(dev);
> >> +       vhost_attach_mm(dev);
> >
> > This seems to do nothing unless I miss something.
>
> vhost_detach mm drops dev->mm.
> vhost_attach_mm grabs current->mm.
>
> - Steve
>

