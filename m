Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05F1C36
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262807; cv=none; b=T/au2cLoMJ13ZmaZB9rTOcMvOTfQ5DXre5el+zAaAl2ugnhQYFSkwfWiWuVAPuW78eLiq1KGWrvTL/ftb5Mjk3JWOgV39naM5kFLlsSo5zm6IOJ/87aT4rpwNse6yHoXrcDLvx1GFV6b1uM2c/YvU8UrmEm0IodQI0Z1p0I4enE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262807; c=relaxed/simple;
	bh=Rp8c4UkQcNBnTx3QJZMU+cC81PiJjr4tBFbSpiLrR4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp9nyp/egC52Lyam6JONG55mBpazUrdfFJgJOJwrex6Jg3geW7wCWq5eqt3Bb+iKhOReYFIuxV5pMO++/MiSnByAz0QlgCyutlJ88v84DzrIUS7cZzZTcwckqUYVZ11QvObP2htBm1EZ5QEy5mSsAxxxih/yyOyXZoRfe8uOh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyXqWcY6; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyXqWcY6"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7F19400D7
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 00:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBc7MvecJErV for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Jul 2024 00:33:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6041C400A6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6041C400A6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HyXqWcY6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6041C400A6
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 00:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721262802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u68wgJ63ryVdre9iF5AoFnGzoJg7HXk9rm5FX/Mq98o=;
	b=HyXqWcY6cIaRhgDPgFMWRDQVLWfbQgLaoOtBicEK/mJFZ37sD5smP/JmaIeP10VWN+Ne5B
	HVFF+mRqHymTQxbX1Zl7MgqNjhnunVhU9I4gyPsLTao/rKJ4kEqcYpm5+/d825NoPOaTlA
	t/sZwIophbcPid8uBqwor61Ug7ob8yc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-kFN8MRYIMomZeSRCabmftw-1; Wed, 17 Jul 2024 20:33:20 -0400
X-MC-Unique: kFN8MRYIMomZeSRCabmftw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb5ab2f274so379485a91.3
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 17:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262799; x=1721867599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u68wgJ63ryVdre9iF5AoFnGzoJg7HXk9rm5FX/Mq98o=;
        b=enNcP0Sm1KEN98hJs9XN9lOhnCVCFFNHXhd1SidI5sWROrVOrw/CTORyr6YQKGnh6P
         PsJ2fN6aPueauGekdVKemFkFP0J0AUBCL1w50T2ktWboY4EOgWoPQN6ILp7ZxeQPol66
         WE/w5Hd70v/jKZsPMKPrcynW86CHHFWFPZQjcnNJC6oeh3hS3bThzbKYIZWxOkJv6Ezf
         VGnShDG0WameJSKNutad9N/or3NBahiDRLLJPpdJL0XxLMCcAGlLa2ogo7ZEWAvxfsU2
         fCH+4oFvb1Jsm02oDxYJyvqxDylmowhZu2c3qsi2dt7f8FJVoh0K+KiHGFfNE9D9TjUn
         0T2A==
X-Gm-Message-State: AOJu0Yx48Tas5olqDrwF0LhbEh0fpRURmMYjB6BTD4CH7O0leSEa93Fk
	WJgyCVnoWxGFpU6bvf7MmsetjLx7wBlktxXQG2JEnzpqlXoyY4p5arTPU1Bvx0S0PiLQOijoNd/
	1IP1nOeBrYAm6dJDvMH3+Xg5+sqOeGhYG9zG3KKJys7Aq4jDCD0h75+ZbX71IS3uTP1fI52q+Jr
	eW4A1d6+X2Du3z+cqSQIneICtmuJmztPw/fg1uzmhelvsWntL2IqSLdQ==
X-Received: by 2002:a17:90b:30ca:b0:2c8:ac1:d8c3 with SMTP id 98e67ed59e1d1-2cb52927e76mr2869700a91.29.1721262799107;
        Wed, 17 Jul 2024 17:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZO+VU4obCAMlLWVT45xvTrxr3rvTyY+6U4DhssOpvN3TexH/9IeAtdQBJcSbdawQJw1uZ/ZkYQfYlgJK3i/A=
X-Received: by 2002:a17:90b:30ca:b0:2c8:ac1:d8c3 with SMTP id
 98e67ed59e1d1-2cb52927e76mr2869692a91.29.1721262798686; Wed, 17 Jul 2024
 17:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEs9SvtW=Dkg1aU6HuFqTP5eekD1JdR2w377u3iGsOR-Aw@mail.gmail.com>
 <911f018b-c273-4983-90ac-0a8f925ab6e7@oracle.com> <CACGkMEv_yJ6iwOexGGexVt=EEpr2SXHJSLFcH_7g1yh=L-eDgA@mail.gmail.com>
 <bab464f5-a660-4122-886a-c348be3d95fa@oracle.com>
In-Reply-To: <bab464f5-a660-4122-886a-c348be3d95fa@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Jul 2024 08:33:07 +0800
Message-ID: <CACGkMEtpVOqsJMF1LLNOdTG+_1JBKy6yNbn12_nP=Tw0DeAZvQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] vdpa live update
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 2:29=E2=80=AFAM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/16/2024 1:30 AM, Jason Wang wrote:
> > On Mon, Jul 15, 2024 at 10:29=E2=80=AFPM Steven Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> On 7/14/2024 10:14 PM, Jason Wang wrote:
> >>> On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare=
@oracle.com> wrote:
> >>>>
> >>>> Live update is a technique wherein an application saves its state, e=
xec's
> >>>> to an updated version of itself, and restores its state.  Clients of=
 the
> >>>> application experience a brief suspension of service, on the order o=
f
> >>>> 100's of milliseconds, but are otherwise unaffected.
> >>>>
> >>>> Define and implement interfaces that allow vdpa devices to be preser=
ved
> >>>> across fork or exec, to support live update for applications such as=
 QEMU.
> >>>> The device must be suspended during the update, but its DMA mappings=
 are
> >>>> preserved, so the suspension is brief.
> >>>>
> >>>> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memo=
ry
> >>>> accounting from one process to another.
> >>>>
> >>>> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> >>>> VHOST_NEW_OWNER is supported.
> >>>>
> >>>> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its us=
erland
> >>>> address in the new process.
> >>>>
> >>>> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> >>>> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> >>>> require it, because the userland address of each DMA mapping is disc=
arded
> >>>> after being translated to a physical address.
> >>>>
> >>>> Here is a pseudo-code sequence for performing live update, based on
> >>>> suspend + reset because resume is not yet widely available.  The vdp=
a device
> >>>> descriptor, fd, remains open across the exec.
> >>>>
> >>>>     ioctl(fd, VHOST_VDPA_SUSPEND)
> >>>>     ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
> >>>
> >>> I don't understand why we need a reset after suspend, it looks to me
> >>> the previous suspend became meaningless.
> >>
> >> The suspend guarantees completion of in-progress DMA.  At least, that =
is
> >> my interpretation of why that is done for live migration in QEMU, whic=
h
> >> also does suspend + reset + re-create.  I am following the live migrat=
ion
> >> model.
> >
> > Yes, but any reason we need a reset after the suspension?
>
> Probably not.  I found it cleanest to call reset and let new qemu configu=
re the
> device as it always does during startup, rather than altering those code =
paths
> to skip the kernel calls.

If we care about the downtime, I think avoiding a reset should be faster.

> So, consider this to be just one of several possible
> userland algorithms.
>
> - Steve

Thanks

>
> >>>>     exec
> >>>>
> >>>>     ioctl(fd, VHOST_NEW_OWNER)
> >>>>
> >>>>     issue ioctls to re-create vrings
> >>>>
> >>>>     if VHOST_BACKEND_F_IOTLB_REMAP
> >>>
> >>> So the idea is for a device that is using a virtual address, it
> >>> doesn't need VHOST_BACKEND_F_IOTLB_REMAP at all?
> >>
> >> Actually the reverse: if the device translates virtual to physical whe=
n
> >> the mappings are created, and discards the virtual, then VHOST_IOTLB_R=
EMAP
> >> is not needed.
> >
> > Ok.
> >
> >>
> >>>>         foreach dma mapping
> >>>>             write(fd, {VHOST_IOTLB_REMAP, new_addr})
> >>>>
> >>>>     ioctl(fd, VHOST_VDPA_SET_STATUS,
> >>>>               ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
> >>>
> >>>   From API level, this seems to be asymmetric as we have suspending b=
ut
> >>> not resuming?
> >>
> >> Again, I am just following the path taken by live migration.
> >> I will be happy to use resume when the devices and QEMU support it.
> >> The decision to use reset vs resume should not affect the definition
> >> and use of VHOST_NEW_OWNER and VHOST_IOTLB_REMAP.
> >>
> >> - Steve
> >
> > Thanks
> >
>

