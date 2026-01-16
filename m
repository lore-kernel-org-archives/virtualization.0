Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580837418A
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562996; cv=none; b=obsHsw0XzUo4vvxdKRpUi8fupTXOvRivRDD7tucPI8JFcOuOM4GZqw4kYsHMuRDPsVecOPCPzkvMPPTBOKUMW6sTyhHNd983NECzlUVxGEKEpARoclY5H3X4Esx/k9AJ+GTxxuz7qAlM7loLaM6gBKZBqoW+Jv5tRT9HRDphbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562996; c=relaxed/simple;
	bh=HGtEY94btNFsQ3pWQ2jfFP+yTgKL2x2AHHKTl14hOY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVeFGRC2NnAOXzVh/xXSk9QOj+DPq2BoqLYAwOE9wMz/LvowFgR4QCzo2C22PQKHBb6Cn9+6BkQnem7FjJu+1OtaTV6c2ZidX4ZBkVqWBVDRhde7ss47n3RIs9WSKjOigHOq7GLzwjUlhoUl4Gvs8CjMdwx/yaD1wkalaQyrLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErmG+ybk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErmG+ybk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768562991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqJOALd7CLzydDHpOUK0eQfzDEDWdMLe5N3vMnvGQ5o=;
	b=ErmG+ybkbIRFywbmTmtQbsn5ljN8mxxEK8OrK6srn2+uqkbqc5ScExiTQ51VafEu5i+tUh
	LG4TXlrNj0m/dI6iw2X6wxP5PVIcF2Of2bQNiMx077uHqBST7j4tgxJoqrQJsojJ34zebd
	T+GLkfL/Qy/ekS5jxVzCFp0QDB4Dvqk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-DAuUaB7QO4aaf_Kr86Rlvg-1; Fri, 16 Jan 2026 06:29:48 -0500
X-MC-Unique: DAuUaB7QO4aaf_Kr86Rlvg-1
X-Mimecast-MFC-AGG-ID: DAuUaB7QO4aaf_Kr86Rlvg_1768562988
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7927567a32eso22748177b3.3
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 03:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768562988; x=1769167788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqJOALd7CLzydDHpOUK0eQfzDEDWdMLe5N3vMnvGQ5o=;
        b=Gy2SA9E65Gy7iVUvTviWZVrZ+/bBQFmSmqnRD2ykKJB6Te6z+X6IODLuurdy/OziDl
         V9YLTKaZuqgPihumzN1uVMTZAB/xpf8R2Oy67hkatDbTEBXSk9fJTdnHAiNINIkSGsi+
         p2aWlYikbFnApYKHwdZsxu0e0yo2siEInfRUl/yICGfAePAe/h9JECaDjfHe1i+fAc10
         FKTLAy5Lf+ZQsnBR45P8hzUiIlRd+pRS7Y8vrfd7Q1FbDSx7U4jH2NpMzmqQuxWvJ0E9
         z1TTmhfLSjhOHWULJdAYyMjO6f8ZbOLbK9k/8QFF0iCODky5CjqBzc+ZIT68SeEPdjg7
         Hw6A==
X-Forwarded-Encrypted: i=1; AJvYcCVYkV3K7jHncia1FgkR3/OQPd6YrunvO+GwS8CwSzw9wNTziP/pKn0Jbf5b9ByQSHJq/OoNKRKQYHD2QvAghA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUd0d8nNtEA8VHUGs3NiT6l1LB2rpSf0153J7wyWAFgW76YrwG
	+bNVIYj0C/FA9H1gfcZnZpeKbAL5MsifCoQpcez615wTVj6NbY+IuWEueHKFENzG0XHYkvqU0bA
	SG0ri5UKgTxDKyE4RE9tVA4YiJRY9+EJviBEtEWwKMCbsm1j1/l9MPgWs207TOxPbo6delrdDQv
	F1Yte/sn8L1KA4naymVLl9budaCMGReZuwWigWOQXXZ88=
X-Gm-Gg: AY/fxX7Pu0+9lwWzI62aeSGVqH6GEDCpw/L/o20xYnybqezQozSeWNM/SMFIIwDBXs5
	3R4FBU4mMM4/lIaP0evIspfFDrlGJP2VyZXtTBGTmNvXRyIjluymz6KqfTMrMW7Mb8CwYdcEKHh
	KEdL2ieuBV0uIGjwBFSHXZ2/CMfexLwXo+0joDpxDbfEk6InZGuIhy8NZRx91NKnfLGw==
X-Received: by 2002:a05:690c:c513:b0:78c:5803:f67b with SMTP id 00721157ae682-793c52b3521mr24686197b3.25.1768562987872;
        Fri, 16 Jan 2026 03:29:47 -0800 (PST)
X-Received: by 2002:a05:690c:c513:b0:78c:5803:f67b with SMTP id
 00721157ae682-793c52b3521mr24685997b3.25.1768562987568; Fri, 16 Jan 2026
 03:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-14-eperezma@redhat.com>
 <CACGkMEva=PPzqHBT4tXsPAjkYHnNO1vXYGE-3KxdTQJPVoeZKQ@mail.gmail.com>
In-Reply-To: <CACGkMEva=PPzqHBT4tXsPAjkYHnNO1vXYGE-3KxdTQJPVoeZKQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 16 Jan 2026 12:29:10 +0100
X-Gm-Features: AZwV_QjOyPzlSDFmfY4eVxU0ONYp35PG4dfroX0QMWUlOBu_hFlIeSwcvVSOEkQ
Message-ID: <CAJaqyWcgSTQKq1UA8kLvhxRdHvCNuMsiShgVw3cEziCJk2QByg@mail.gmail.com>
Subject: Re: [PATCH v12 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Y_sXQ6nLIe_zKPaTbT6MNNDV3fyPgH3sWt63nnm3So_1768562988
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 9:15=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Address Space IDs allows the VDUSE framework to support devices able to
> > expose different virtqueues to different part of the drivers.  For
> > example, to let QEMU handle the net device control virtqueue, so QEMU
> > always knows the state of the device like mac address or number of
> > queues enabled, while leaving the dataplane passtrhough to the guest
> > intact.  This enables live migration.
> >
> > Expands the VDUSE documentation to explain how to use the new ioctls or
> > the new struct members of old ioctls.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v12: New in V12. Requested by Jason.
> > ---
> >  Documentation/userspace-api/vduse.rst | 49 +++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/user=
space-api/vduse.rst
> > index bdb880e01132..66110d918815 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -230,4 +230,53 @@ able to start the dataplane processing as follows:
> >  5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ=
_IRQ ioctl
> >     after the used ring is filled.
> >
> > +Enabling ASID (API version 1)
> > +------------------------------
> > +
> > +VDUSE supports per-address-space identifiers (ASIDs) starting with API
> > +version 1. Setup it with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/c=
ontrol` and
> > +pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance with
> > +ioctl(VDUSE_CREATE_DEV).
> > +
> > +Afterwards, you can use the member asid of ioctl(VDUSE_IOTLB_GET_INFO)=
 to
> > +select the address space of the IOTLB you are queryng. Similarly, you =
can use
>
> Should be "querying"
>
> > +ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file descriptor describing an=
 IOVA
>
> Should we fail VDUSE_IOTLB_GET_FD on API version 1 or it is implied for A=
SID 0?
>

ASID 0 is implied at this moment, so future VDUSE devices don't need
to worry about ASID configuration.

> > +region of an specific ASID. Example usage:
> > +
> > +.. code-block:: c
> > +
> > +       static void *iova_to_va(int dev_fd, uint32_t asid, uint64_t iov=
a,
> > +                               uint64_t *len)
> > +       {
> > +               int fd;
> > +               void *addr;
> > +               size_t size;
> > +               struct vduse_iotlb_entry_v2 entry =3D { 0 };
> > +
> > +               entry.v1.start =3D iova;
> > +               entry.v1.last =3D iova;
> > +               entry.asid =3D asid;
> > +
> > +               fd =3D ioctl(dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
> > +               if (fd < 0)
> > +                       return NULL;
> > +
> > +               size =3D entry.v1.last - entry.v1.start + 1;
> > +               *len =3D entry.v1.last - iova + 1;
> > +               addr =3D mmap(0, size, perm_to_prot(entry.v1.perm), MAP=
_SHARED,
> > +                           fd, entry.v1.offset);
> > +               close(fd);
> > +               if (addr =3D=3D MAP_FAILED)
> > +                       return NULL;
> > +
> > +               /*
> > +                * Using some data structures such as linked list to st=
ore
> > +                * the iotlb mapping. The munmap(2) should be called fo=
r the
> > +                * cached mapping when the corresponding VDUSE_UPDATE_I=
OTLB
> > +                * message is received or the device is reset.
> > +                */
> > +
> > +               return addr + iova - entry.start;
> > +       }
> > +
>
> It looks like we missed the documentation of VDUSE_SET_VQ_GROUP_ASID.
>
> >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > --
> > 2.52.0
> >
>
> Thanks
>

