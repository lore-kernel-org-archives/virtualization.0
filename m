Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACEC2103
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896742; cv=none; b=PxV0rHeGuqj9SoNNiw/0llZ9oTyUY6dKMbtYyCukLL3u5irzKi0cjhLDV7y6qjYSCL/O6qUJPD+JlOG9I02DWbwPjjmTqoappiLf+lzY2on44ZC+95oTE1+8udbWV+wwsO1NXgVUjLJDbdED9pxoOkKAFKkSnD9Yfz4H44+nkEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896742; c=relaxed/simple;
	bh=MmLX/+2eKkvpMSGodryciCRGoarYC51S/2/oOX7cMXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZw5mF2IjnK8ETw835JBUHLVqc/X4fz9uKdjuuJ5DZcj+o5p2FD0OKVUw1h29iYio7LS5mitkKp0XQTQUrjRopTtTyAQZXEY1iDxdM+DyNFZjZ+4KBfZyj3WPp6qNdB8b13vMTAaDwPyo7DsuznO6Wqg/ropNg1h8kMxo/utssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIuUn5tB; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIuUn5tB"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7054460A91
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:12:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7054460A91
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NIuUn5tB
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XZ0LqAIKOB7Q
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 04:12:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 940BC60A87
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:12:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 940BC60A87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705896737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdiWVjSrLkm00g1JovgY0SIa+x6URzp4TrijiFdHWvQ=;
	b=NIuUn5tBVgTlBTB6jv9jhnquz9/DC8Dl9UzT3zamMDULHx3N4O9kK+KcotgVND5pLJTGsp
	x17oF8AdHYhDTGSLRTbHfx7KMzMwHv56fVYH4vPwACvYvzxfah+pURqQjAdGrRi380nhBt
	87gJdiSKFOJcuxK6WGP67eskJuiwhRA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-Iv1LQ-EjNQ6ue-4iuUeBwA-1; Sun, 21 Jan 2024 23:12:16 -0500
X-MC-Unique: Iv1LQ-EjNQ6ue-4iuUeBwA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6da57e2d2b9so1950295b3a.2
        for <virtualization@lists.linux-foundation.org>; Sun, 21 Jan 2024 20:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705896735; x=1706501535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdiWVjSrLkm00g1JovgY0SIa+x6URzp4TrijiFdHWvQ=;
        b=ukGtUuLv2yAkhrDK27RLN+EJocQkU1gxGFTdLFxYpWVpVFU/nNRtEMYbui3WEWEj/e
         V2zTSmxUqaTnk1r2LC6+Ww/6LKXzhzQp3Y50To48ppeNKLYsKg1Mv4AhAm6u3Z7bI83A
         HmliNh1BJyVrUh+5hUDTn0Vkh4GKZW7SzX57KYbHBAlgix4yJZm/UXlYXJj9HKbt23lh
         9dqeuYRAC3endRrwYyWyPLLZfLzpP0HaZToadav/gOQ3MBwkanPUoeqkXQqVl0Z7jbNB
         1Jyk0KWMc6nWmkOv4AfLX6kzxJgHsGwwYXSMCxP4w8JHg60S0jU975pObOWNfkq8RQrL
         SmNw==
X-Gm-Message-State: AOJu0YwFLqrNLh/LW+rtmISuEfKkMIlw1HexU1+2NBdC5XsWurVC2lnX
	tSBS44JQFIl8F9j158M12ItxoHnOZvSX7rVHGqKyXmflaL4ZN2Cc3eny2Trd0Um632QdTbUiTW9
	BW1rQYA/GJk9BnKoMj4lAplt22PQ9Trjf9OS6IvRMET/itFBWPk/uD6B8gGyn2+4d280pHRKBlb
	gDvAAmZ/L4bgPRv77j198+Ayi8m1dZL6WEyW+WsZnMfkNv/aAzy+tupg==
X-Received: by 2002:a05:6a20:4314:b0:19c:36df:42db with SMTP id h20-20020a056a20431400b0019c36df42dbmr468891pzk.5.1705896734934;
        Sun, 21 Jan 2024 20:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPKntMMuZTTQpPnZS+5Zmec96aBqPnJau5M7G5SBtCRvgwmF/Mz4WBFPpuztC9MKdTbx2dzj4f1qhZ8gLlJHI=
X-Received: by 2002:a05:6a20:4314:b0:19c:36df:42db with SMTP id
 h20-20020a056a20431400b0019c36df42dbmr468885pzk.5.1705896734692; Sun, 21 Jan
 2024 20:12:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEuFTRBYU+z3ZSWzMMv2650PQ=kduGxcGXaf0T5222Bh4g@mail.gmail.com> <aea1681c-e04d-4678-b161-6dbd2b13b82e@oracle.com>
In-Reply-To: <aea1681c-e04d-4678-b161-6dbd2b13b82e@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:12:03 +0800
Message-ID: <CACGkMEuCOnnMTyjGWz+BahYimwge=6fX4Ynq22gv=koCcnx0mg@mail.gmail.com>
Subject: Re: [RFC V1 00/13] vdpa live update
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
> On 1/10/2024 9:55 PM, Jason Wang wrote:
> > On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> Live update is a technique wherein an application saves its state, exe=
c's
> >> to an updated version of itself, and restores its state.  Clients of t=
he
> >> application experience a brief suspension of service, on the order of
> >> 100's of milliseconds, but are otherwise unaffected.
> >>
> >> Define and implement interfaces that allow vdpa devices to be preserve=
d
> >> across fork or exec, to support live update for applications such as q=
emu.
> >> The device must be suspended during the update, but its dma mappings a=
re
> >> preserved, so the suspension is brief.
> >>
> >> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
> >> accounting from one process to another.
> >>
> >> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> >> VHOST_NEW_OWNER is supported.
> >>
> >> The VHOST_IOTLB_REMAP message type updates a dma mapping with its user=
land
> >> address in the new process.
> >>
> >> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> >> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> >> require it, because the userland address of each dma mapping is discar=
ded
> >> after being translated to a physical address.
> >>
> >> Here is a pseudo-code sequence for performing live update, based on
> >> suspend + reset because resume is not yet available.  The vdpa device
> >> descriptor, fd, remains open across the exec.
> >>
> >>   ioctl(fd, VHOST_VDPA_SUSPEND)
> >>   ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
> >>   exec
> >
> > Is there a userspace implementation as a reference?
>
> I have working patches for qemu that use these ioctl's, but they depend o=
n other
> qemu cpr patches that are a work in progress, and not posted yet.  I'm wo=
rking on
> that.

Ok.

>
> >>   ioctl(fd, VHOST_NEW_OWNER)
> >>
> >>   issue ioctls to re-create vrings
> >>
> >>   if VHOST_BACKEND_F_IOTLB_REMAP
> >>       foreach dma mapping
> >>           write(fd, {VHOST_IOTLB_REMAP, new_addr})
> >
> > I think I need to understand the advantages of this approach. For
> > example, why it is better than
> >
> > ioctl(VHOST_RESET_OWNER)
> > exec
> >
> > ioctl(VHOST_SET_OWNER)
> >
> > for each dma mapping
> >      ioctl(VHOST_IOTLB_UPDATE)
>
> That is slower.  VHOST_RESET_OWNER unbinds physical pages, and VHOST_IOTL=
B_UPDATE
> rebinds them.  It costs multiple seconds for large memories, and is incur=
red during the
> virtual machine's pause time during live update.  For comparison, the tot=
al pause time
> for live update with vfio interfaces is ~100 millis.
>
> However, the interaction with userland is so similar that the same code p=
aths can be used.
> In my qemu prototype, after cpr exec's new qemu:
>   - vhost_vdpa_set_owner() calls VHOST_NEW_OWNER instead of VHOST_SET_OWN=
ER
>   - vhost_vdpa_dma_map() sets type VHOST_IOTLB_REMAP instead of VHOST_IOT=
LB_UPDATE
>
> - Steve
>

Ok, let's document this in the changlog.

Thanks

