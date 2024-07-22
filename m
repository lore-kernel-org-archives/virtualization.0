Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62718AF9
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633181; cv=none; b=eVAYDn9N9OU3utkG1Gv5cUD9zGLYhYRdo9P6yc3DPr5SeqYe8HfDZppt1wVN35ADOnwo/j3KBjU3eYe0ovZRtM61tylbKLUhTjc7WImx6ASy1VXNgqHa0UuMwOQL74JuUw4vmEreIGNRXZzTUMCZo1uxjgBRGqGGwbhuJpldrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633181; c=relaxed/simple;
	bh=iZkcr+f6dlr9Bt+kQeW7lFA7lPfsrSBzQGlFQG/8dyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NM+ywEzUXg+EOz63B9vLRvTfAHCh5+ZaER9K0utMrdxVaKP0bt5hIqZcem3ww0iO/K0Jy0Ji3sJmmS9A7vzJEDkHbemU2mNNMkDZybwbLbeIQutijst/bOdEANZHghZqr7Qp0XTlE6bE1xUVk0ghD/nZbJkgo5IdH3HxWYVWoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6saaSnJ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6saaSnJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A3D080E42
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:26:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VlgJPan97J32 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 07:26:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 29B2080AB0
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29B2080AB0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f6saaSnJ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29B2080AB0
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721633176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPCm1Exv8qA9j/PQhMbsYXCV10NdzINlvlRHmghrUzc=;
	b=f6saaSnJt3DmwQ/3rBevTSQOsRvVzj1osQqL0UshI8qvzTqIU48r7k1d9ZKtsebaGvFHTQ
	033UNTg6Zw4wxOjhYYDI751D2KYhWT5U8P9mq747K3Vieh8r0QlYWffedITsqfUdjHmcrA
	mtayoDKgGVflAo6ccTzhZjhaS/9TdNs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-jEiJRAwuPxWNm-pd9oOHHw-1; Mon, 22 Jul 2024 03:26:14 -0400
X-MC-Unique: jEiJRAwuPxWNm-pd9oOHHw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-71a43a07997so3165454a12.3
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 00:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633173; x=1722237973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPCm1Exv8qA9j/PQhMbsYXCV10NdzINlvlRHmghrUzc=;
        b=oTMoyN1kN6x+JzXFd8BAarwW/nq9Sz4n8dFB3tpoZ7FJk5ME/ckX6y+T9xjl521nVg
         Jv+QIkqRGykxULzgBvJ5imPxleqqbyJcEXle1LUVPu6lXbUTzXV9Yuck4A7Zl/5PrNNF
         3+T/mXvQKXwYA/p+tzG2qXZhGXkrXZbi1Uhu1B3cTY/dRD3n5/twnBAh5esYXOSthuZG
         t9AZkjd9sZ7iV8dZyAKUMd3nZbkbooJKTU1sL97SCN9sBtyeaIN5uRa+W3bt9OBvvvaK
         XWI9fDcZhlG5QFG16nfKH35qPxG+uQg/G2/Ujevrn0baOdZFZyN42bIWjTigNSx86QZ/
         thOQ==
X-Gm-Message-State: AOJu0YxM2F8+jqAI+g2Ejk+Sf0pTAIj4F7bQGcxbC7MqEY2xTIscnupa
	0rffogLPjz58ajwGPvLk0yuWYTt2cbtkPv6dP5gD04rGM+5LZviYCNxD7nbeNaEvJHlsPFsaEPw
	ou5vNsz/HbN0+64Ef6k4kg+xOB312QWBS3EtMbp/Acwgy8xp3NTVMnxFd561p9aE9ivuGw+d5oN
	UZ6H1l+hkAorcfAlm+ughKAouifGekxs7YpkSxycuGNIEjpdySxnNXmA==
X-Received: by 2002:a05:6a20:a12b:b0:1bc:e978:8bf2 with SMTP id adf61e73a8af0-1c4228d1457mr6022664637.23.1721633173302;
        Mon, 22 Jul 2024 00:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5sMJq9ooTBX7dMQheFBRCE2BkpmThbRDKNWJ78QktVJygZeVooWmwlyQLwAx396ueyCtfdZuBG+afRYpfqoU=
X-Received: by 2002:a05:6a20:a12b:b0:1bc:e978:8bf2 with SMTP id
 adf61e73a8af0-1c4228d1457mr6022633637.23.1721633172637; Mon, 22 Jul 2024
 00:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
 <CACGkMEu0sNx=saZOaVRbuV7Gz7+_GD-v42i+Bdk-NCp6syABbw@mail.gmail.com>
 <acfccf72-2883-407d-977a-9c2566cf8cb3@oracle.com> <CACGkMEtL7Fkj+srq+beK8UBZ5QDowpz+hT2HZ8RZR00UsRJcVA@mail.gmail.com>
 <00d3d446-fdb4-4c82-ae19-c65de9398677@oracle.com>
In-Reply-To: <00d3d446-fdb4-4c82-ae19-c65de9398677@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:26:01 +0800
Message-ID: <CACGkMEt_7r8O=RBfoPAgp_-BWLi_LA2YrNsfn6K0QyZuZLTcUg@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 2:28=E2=80=AFAM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/16/2024 1:16 AM, Jason Wang wrote:
> > On Mon, Jul 15, 2024 at 10:27=E2=80=AFPM Steven Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> On 7/14/2024 10:26 PM, Jason Wang wrote:
> >>> On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare=
@oracle.com> wrote:
> >>>>
> >>>> Add an ioctl to transfer file descriptor ownership and pinned memory
> >>>> accounting from one process to another.
> >>>>
> >>>> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_=
OWNER,
> >>>> as that would unpin all physical pages, requiring them to be repinne=
d in
> >>>> the new process.  That would cost multiple seconds for large memorie=
s, and
> >>>> be incurred during a virtual machine's pause time during live update=
.
> >>>>
> >>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>>> ---
> >>>>    drivers/vhost/vdpa.c       | 41 +++++++++++++++++++++++++++++++++=
+++++
> >>>>    drivers/vhost/vhost.c      | 15 ++++++++++++++
> >>>>    drivers/vhost/vhost.h      |  1 +
> >>>>    include/uapi/linux/vhost.h | 10 ++++++++++
> >>>>    4 files changed, 67 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>> index b49e5831b3f0..5cf55ca4ec02 100644
> >>>> --- a/drivers/vhost/vdpa.c
> >>>> +++ b/drivers/vhost/vdpa.c
> >>>> @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa=
 *v)
> >>>>           return ret;
> >>>>    }
> >>>>
> >>>> +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
> >>>> +{
> >>>> +       int r;
> >>>> +       struct vhost_dev *vdev =3D &v->vdev;
> >>>> +       struct mm_struct *mm_old =3D vdev->mm;
> >>>> +       struct mm_struct *mm_new =3D current->mm;
> >>>> +       long pinned_vm =3D v->pinned_vm;
> >>>> +       unsigned long lock_limit =3D PFN_DOWN(rlimit(RLIMIT_MEMLOCK)=
);
> >>>> +
> >>>> +       if (!mm_old)
> >>>> +               return -EINVAL;
> >>>> +       mmgrab(mm_old);
> >>>> +
> >>>> +       if (!v->vdpa->use_va &&
> >>>> +           pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_lim=
it) {
> >>>> +               r =3D -ENOMEM;
> >>>> +               goto out;
> >>>> +       }
> >>>
> >>> So this seems to allow an arbitrary process to execute this. Seems to=
 be unsafe.
> >>>
> >>> I wonder if we need to add some checks here, maybe PID or other stuff
> >>> to only allow the owner process to do this.
> >>
> >> The original owner must send the file descriptor to the new owner.
> >
> > This seems not to be in the steps you put in the cover letter.
>
> It's there:
>    "The vdpa device descriptor, fd, remains open across the exec."
>
> But, I can say more about how fd visibility constitutes permission to cha=
nger
> owner in this commit message.

Yes, that would be great.

>
> >> That constitutes permission to take ownership.
> >
> > This seems like a relaxed version of the reset_owner:
> >
> > Currently, reset_owner have the following check:
>
> Not relaxed, just different.  A process cannot do anything with fd if it
> is not the owner, *except* for becoming the new owner.  Holding the fd is
> like holding a key.

I meant it kind of "defeats" the effort of VHOST_NET_RESET_OWNER ...

Thanks

>
> - Steve
>
> > /* Caller should have device mutex */
> > long vhost_dev_check_owner(struct vhost_dev *dev)
> > {
> >          /* Are you the owner? If not, I don't think you mean to do tha=
t */
> >          return dev->mm =3D=3D current->mm ? 0 : -EPERM;
> > }
> > EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
> >
> > It means even if the fd is passed to some other process, the reset
> > owner won't work there.
> >
> > Thanks
> >
> >>
> >>>> +       r =3D vhost_vdpa_bind_mm(v, mm_new);
> >>>> +       if (r)
> >>>> +               goto out;
> >>>> +
> >>>> +       r =3D vhost_dev_new_owner(vdev);
> >>>> +       if (r) {
> >>>> +               vhost_vdpa_bind_mm(v, mm_old);
> >>>> +               goto out;
> >>>> +       }
> >>>> +
> >>>> +       if (!v->vdpa->use_va) {
> >>>> +               atomic64_sub(pinned_vm, &mm_old->pinned_vm);
> >>>> +               atomic64_add(pinned_vm, &mm_new->pinned_vm);
> >>>> +       }
> >>>> +
> >>>> +out:
> >>>> +       mmdrop(mm_old);
> >>>> +       return r;
> >>>> +}
> >>>> +
> >>>>    static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned=
 int cmd,
> >>>>                                      void __user *argp)
> >>>>    {
> >>>> @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct fil=
e *filep,
> >>>>           case VHOST_VDPA_RESUME:
> >>>>                   r =3D vhost_vdpa_resume(v);
> >>>>                   break;
> >>>> +       case VHOST_NEW_OWNER:
> >>>> +               r =3D vhost_vdpa_new_owner(v);
> >>>> +               break;
> >>>>           default:
> >>>>                   r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
> >>>>                   if (r =3D=3D -ENOIOCTLCMD)
> >>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >>>> index b60955682474..ab40ae50552f 100644
> >>>> --- a/drivers/vhost/vhost.c
> >>>> +++ b/drivers/vhost/vhost.c
> >>>> @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> >>>>    }
> >>>>    EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
> >>>>
> >>>> +/* Caller should have device mutex */
> >>>> +long vhost_dev_new_owner(struct vhost_dev *dev)
> >>>> +{
> >>>> +       if (dev->mm =3D=3D current->mm)
> >>>> +               return -EBUSY;
> >>>> +
> >>>> +       if (!vhost_dev_has_owner(dev))
> >>>> +               return -EINVAL;
> >>>> +
> >>>> +       vhost_detach_mm(dev);
> >>>> +       vhost_attach_mm(dev);
> >>>
> >>> This seems to do nothing unless I miss something.
> >>
> >> vhost_detach mm drops dev->mm.
> >> vhost_attach_mm grabs current->mm.
> >>
> >> - Steve
> >>
> >
>

