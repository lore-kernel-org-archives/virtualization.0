Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F69179AE
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jul 2024 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107836; cv=none; b=S87pCXtaTu6pe4sb/vgbrt5qpeH7urRaoehMf1+tPzqm5W67XxTj3ywdwpIJTtGnujo+3R/53J9HPepnATSgAC/P4GwqGBMZ92sVnQUA8Bk3jNcud5200z7djPpZ0oXiMixj0lIg00/upWDp/nzlFl8uSXbu9BrejKjKE+RlrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107836; c=relaxed/simple;
	bh=MztzX0AtfKG0vv54p9gj+yksNvKCCq9lQ3ToCgPyir4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dF4xxDcklS8PXWy8kQ68CMDOhWeTXs5JrBb0KnWKNvKDDk6a4oSAIn6TFty5PsxxEO/zm1MSfl0101bMZMneYok959RFVfRcze7NX3tyncvgK5r+8B7lgUi7N+DsEw5PF8PaQ2r3W6poMdl+i8G4VZRos2zLoOHgIwFe1zuf6lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMix6gBa; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMix6gBa"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 494CD402BC
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jul 2024 05:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Ced7cVkG1Re for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Jul 2024 05:30:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1F4F040010
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F4F040010
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iMix6gBa
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F4F040010
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jul 2024 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721107832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWVxoYotOuZE0adepWrwjW/Gf4iGqle1zZCVIlIH1KA=;
	b=iMix6gBaVl/jbgO4fzjJ22qBTT47hNxzIXRsk5vvihZ9HEskX6h1x7/I+m+gUrYjAEpisG
	eC3UpWjjt43AZiOBF/oC53ayLI5PR4Nk/CAmAb9AK7w7qWOMjh9q2K/OwCWOnGipMova0y
	7Xva1K58RDHXHyPVCNe75/D03jjEH5A=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-Ndsp_4QOOW6xVC1dze2WaQ-1; Tue, 16 Jul 2024 01:30:30 -0400
X-MC-Unique: Ndsp_4QOOW6xVC1dze2WaQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-715e59afb63so3506673a12.2
        for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 22:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721107829; x=1721712629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWVxoYotOuZE0adepWrwjW/Gf4iGqle1zZCVIlIH1KA=;
        b=riKWjyraKVGTSMATqI6POv2wF8byrsPbHpmC1tbyxPhtt/fUSdd3mJ8GEuTnKMMQOw
         KRefktRds2KTyXTicmjYy5IlQG7ozUMpwbBGYPE/w+84ROvPiw1TqW4hBbELEEIN34rX
         bmSjEWM3iuz9zE5dyra0sf00xiqahg/yCVsgrzGzJdUx9khj7ZPlw7kmHm7kCRJC1r2q
         CjnjoLz8hXyt4n5sct1A5u0///xQG28RRM1yCOWjWuTmh4otsbkks1sbR4gKh5kGH7Rx
         FeuxzEzDzsPISeUgvjF8Uz+Xkex6wOCctrLU1LtPBil7f4dSYBlFl1tkmbOuQyE++eOb
         eghQ==
X-Gm-Message-State: AOJu0Ywpcdr87qhHRypxp4/IfajR0LoqYWh9p+fnWG/zkvzAgymMf/E7
	2PNl3Ed/hQrlfG5+pNmfrS88wTRvqZXYrTMO5vfbXWs7bQr4/Y+pWRDPebOBoOr4ARkZ5grCHgV
	iijTOHYHWJZnEDWWd6Bq1FdOC8kXfSVy3X2YcoQPl57wlmtc8JMeDn2uErH3AD5mzDPKQ/pUfM4
	W+0FFrQgjr6hO1v87aJml1ULWotzwk56dsSgbefK/YpJncow3U8KSlLg==
X-Received: by 2002:a05:6a21:9207:b0:1c3:b2da:cdff with SMTP id adf61e73a8af0-1c3f10ec5a9mr1427753637.0.1721107829145;
        Mon, 15 Jul 2024 22:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE4/IsYi91e+b+a6BuuTQWkanz20Qq9rKT2XEAIkwUc0Z5+zjH7s27Jz8KjgAa5CWQ0wpSwUG31rJrYIKyU/c=
X-Received: by 2002:a05:6a21:9207:b0:1c3:b2da:cdff with SMTP id
 adf61e73a8af0-1c3f10ec5a9mr1427735637.0.1721107828571; Mon, 15 Jul 2024
 22:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEs9SvtW=Dkg1aU6HuFqTP5eekD1JdR2w377u3iGsOR-Aw@mail.gmail.com> <911f018b-c273-4983-90ac-0a8f925ab6e7@oracle.com>
In-Reply-To: <911f018b-c273-4983-90ac-0a8f925ab6e7@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Jul 2024 13:30:17 +0800
Message-ID: <CACGkMEv_yJ6iwOexGGexVt=EEpr2SXHJSLFcH_7g1yh=L-eDgA@mail.gmail.com>
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

On Mon, Jul 15, 2024 at 10:29=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/14/2024 10:14 PM, Jason Wang wrote:
> > On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@o=
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
> >> across fork or exec, to support live update for applications such as Q=
EMU.
> >> The device must be suspended during the update, but its DMA mappings a=
re
> >> preserved, so the suspension is brief.
> >>
> >> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
> >> accounting from one process to another.
> >>
> >> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> >> VHOST_NEW_OWNER is supported.
> >>
> >> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its user=
land
> >> address in the new process.
> >>
> >> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> >> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> >> require it, because the userland address of each DMA mapping is discar=
ded
> >> after being translated to a physical address.
> >>
> >> Here is a pseudo-code sequence for performing live update, based on
> >> suspend + reset because resume is not yet widely available.  The vdpa =
device
> >> descriptor, fd, remains open across the exec.
> >>
> >>    ioctl(fd, VHOST_VDPA_SUSPEND)
> >>    ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
> >
> > I don't understand why we need a reset after suspend, it looks to me
> > the previous suspend became meaningless.
>
> The suspend guarantees completion of in-progress DMA.  At least, that is
> my interpretation of why that is done for live migration in QEMU, which
> also does suspend + reset + re-create.  I am following the live migration
> model.

Yes, but any reason we need a reset after the suspension?

>
> >>    exec
> >>
> >>    ioctl(fd, VHOST_NEW_OWNER)
> >>
> >>    issue ioctls to re-create vrings
> >>
> >>    if VHOST_BACKEND_F_IOTLB_REMAP
> >
> > So the idea is for a device that is using a virtual address, it
> > doesn't need VHOST_BACKEND_F_IOTLB_REMAP at all?
>
> Actually the reverse: if the device translates virtual to physical when
> the mappings are created, and discards the virtual, then VHOST_IOTLB_REMA=
P
> is not needed.

Ok.

>
> >>        foreach dma mapping
> >>            write(fd, {VHOST_IOTLB_REMAP, new_addr})
> >>
> >>    ioctl(fd, VHOST_VDPA_SET_STATUS,
> >>              ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
> >
> >  From API level, this seems to be asymmetric as we have suspending but
> > not resuming?
>
> Again, I am just following the path taken by live migration.
> I will be happy to use resume when the devices and QEMU support it.
> The decision to use reset vs resume should not affect the definition
> and use of VHOST_NEW_OWNER and VHOST_IOTLB_REMAP.
>
> - Steve

Thanks

