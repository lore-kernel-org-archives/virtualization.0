Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC211127E17
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343651; cv=none; b=F1HYU9oxsz/QZMiId5FR1RXvlSOjGPXYqzOuhd+IXPagVMxc1x8zr/Q9D3Y+76jKwIL9q0JTzzIKHgSO+x5bxXY+pC11BHdRCPjT2xEP0r4TbJTP6+a+X2e2h6JTJhJnOQnQR64k9MBPYnrsN7BTHFlWTr+7Unz/yXcdJpTeuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343651; c=relaxed/simple;
	bh=2B5PS/6d09LZj1e+zLCuQV4GCMrqEJtQcCFNgI2Utb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bA5da/cId3mDBBPFj8h6oKOrQ+np0pHTLsbMm9lQvOx+MjmULCuANgodImu9Heyrl4TyQ2sR04NibyhFUDKJ3a9QiLurzHfCi8OMZ/7WEx/r68Dh8X6DpfY0+3j0pNnnkt5AidTKjQnROVUR/a1GY2Ck5Y9v4+mDfkC2OcfApQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecxweKRO; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecxweKRO"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DE3340279
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 08:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujnmg8oBEHVN for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Apr 2024 08:47:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EB2244015A
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB2244015A
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ecxweKRO
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB2244015A
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713343646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6wF7/7+EUHH57/t9RpDsNBwadh/aqSlofB+nlzD4Zs=;
	b=ecxweKROmCs40McK8tWTU7uEEOKWtxPW9OatVLmFoKc2sk8f0lg+Q0fr+Ue1ZZEp7qIyoy
	rZIixc87TZswbc1gJj0syE4KBcNg/XiDz+dy8RAJ9FTVUzwiP84n29qNtZGftzblux1fDz
	WFZX+IoJbjq+FiDyCDbwAOhdfzwhH7g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-jGrDhHPJOgmBpgYl_APvaQ-1; Wed, 17 Apr 2024 04:47:25 -0400
X-MC-Unique: jGrDhHPJOgmBpgYl_APvaQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d86787efa3so44760651fa.1
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 01:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343643; x=1713948443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6wF7/7+EUHH57/t9RpDsNBwadh/aqSlofB+nlzD4Zs=;
        b=E6UbCcz2VoSbUrip67sn0PjjN5mpthxOvEp0CDdrnyKQ6QMgbUblmprIY38HNm1AVl
         PhbuAOrlRxUmbWFyGwySg+kUK/WnF/8+g8qTvKEbrrc5KRgcFaKFZa9dbZ4y9BSpX0xh
         N6r9UTUX+zYz2RM0nLVzQaYME241oR12ov15M0Zdn5AoDAaxtggoX7wIKRleSl8SSf/A
         ifGp0+2DGsNXMqsYhR71/EeCRo/oyXJeR38LgbWWNtRZjvMedoR5fqZXdmMyG1FqOcYl
         5y9/6pwnZNsNMBwI90HfXDZ9a8ffr27I875D6Wo3/rsFCSccXjgnW93yU5geQ+qol0RW
         0TYw==
X-Forwarded-Encrypted: i=1; AJvYcCWRIVJHSCBn9diE/hK6gV3OK4S5r+7nGblCOIJl/I1NU7xOT8meWgPru1vynFPqZ2XTyZWdASDClE5tkC6LiFbAxDfOtGl+cdOvwd0UU5EeE0a9j3ey4Ie2Lg==
X-Gm-Message-State: AOJu0YwXquGv7I/dpk05Oj/n3NZIQl7rSjBO4ycRHdPbzfGv2+36Q/hx
	BT7kd41MtvGlpnu6xCxTDr9jKabXAvOvFw8Jvucvgx++8krcwJG0MQIUGKagxR2oxQSZAXNXJrd
	Z1cZT/ClHj01bpf4rX9b8UD4fZzORKME6uKtvU2KX4Lr7gD6agNfETWH+EShncao62gNoGhIuBF
	1FmLeOnJTvRvH5a47HE5pqsUZpxKa7KCVsBktQeF4tDK9pY2X/hTE3tw==
X-Received: by 2002:ac2:4644:0:b0:518:6e71:13be with SMTP id s4-20020ac24644000000b005186e7113bemr11623235lfo.51.1713343643604;
        Wed, 17 Apr 2024 01:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEnbNAaG2pgLH1zH3tK8yuWdjHVWpGGrmPm1B0xt/ug9cB1g+OElPTMbQN4sBuo3dA12Dh5KtBsnQn45/ZBc8=
X-Received: by 2002:ac2:4644:0:b0:518:6e71:13be with SMTP id
 s4-20020ac24644000000b005186e7113bemr11623220lfo.51.1713343643245; Wed, 17
 Apr 2024 01:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-6-lulu@redhat.com>
 <CACGkMEt3qpm=3Y=CDeA1Kyd7te-Wm-gk3j5iR96=_CaP0PrVtQ@mail.gmail.com>
In-Reply-To: <CACGkMEt3qpm=3Y=CDeA1Kyd7te-Wm-gk3j5iR96=_CaP0PrVtQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 17 Apr 2024 16:46:44 +0800
Message-ID: <CACLfguVnQV1qaZeOXi5=T7KbGNEPibmUOXv_r8HZpcU0CMbgGQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] Documentation: Add reconnect process for VDUSE
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Fri, Apr 12, 2024 at 9:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add a document explaining the reconnect process, including what the
> > Userspace App needs to do and how it works with the kernel.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/user=
space-api/vduse.rst
> > index bdb880e01132..7faa83462e78 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
> >     after the used ring is filled.
> >
> >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > +
> > +HOW VDUSE devices reconnection works
> > +------------------------------------
> > +1. What is reconnection?
> > +
> > +   When the userspace application loads, it should establish a connect=
ion
> > +   to the vduse kernel device. Sometimes,the userspace application exi=
sts,
>
> I guess you meant "exists"? If yes, it should be better to say "exits
> unexpectedly"
>
> > +   and we want to support its restart and connect to the kernel device=
 again
> > +
> > +2. How can I support reconnection in a userspace application?
>
> Better to say "How reconnection is supported"?
>
> > +
> > +2.1 During initialization, the userspace application should first veri=
fy the
> > +    existence of the device "/dev/vduse/vduse_name".
> > +    If it doesn't exist, it means this is the first-time for connectio=
n. goto step 2.2
> > +    If it exists, it means this is a reconnection, and we should goto =
step 2.3
> > +
> > +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > +    /dev/vduse/control.
> > +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory fo=
r
> > +    the reconnect information. The total memory size is PAGE_SIZE*vq_m=
umber.
>
> I think we need to mention that this should be part of the previous
> "VDUSE devices are created as follows"?
>
> > +
> > +2.3 Check if the information is suitable for reconnect
> > +    If this is reconnection :
> > +    Before attempting to reconnect, The userspace application needs to=
 use the
> > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FE=
ATURES...)
> > +    to get the information from kernel.
> > +    Please review the information and confirm if it is suitable to rec=
onnect.
>
> Need to define "review" here and how to decide if it is not suitable
> to reconnect.
>
> > +
> > +2.4 Userspace application needs to mmap the memory to userspace
> > +    The userspace application requires mapping one page for every vq. =
These pages
> > +    should be used to save vq-related information during system runnin=
g.
>
> Not a native speaker, but it looks better with
>
> "should be used by the userspace to store virtqueue specific information"=
.
>
> > Additionally,
> > +    the application must define its own structure to store information=
 for reconnection.
> > +
> > +2.5 Completed the initialization and running the application.
> > +    While the application is running, it is important to store relevan=
t information
> > +    about reconnections in mapped pages.
>
> I think we need some link/code examples to demonstrate what needs to be s=
tored.
>
> > When calling the ioctl VDUSE_VQ_GET_INFO to
> > +    get vq information, it's necessary to check whether it's a reconne=
ction.
>
> Better with some examples of codes.
>
> > If it is
> > +    a reconnection, the vq-related information must be get from the ma=
pped pages.
> > +
> > +2.6 When the Userspace application exits, it is necessary to unmap all=
 the
> > +    pages for reconnection
>
> This seems to be unnecessary, for example there could be an unexpected ex=
it.
>
> Thanks
>
Thanks Jason, I will send a new version
Thanks
Cindy
> > --
> > 2.43.0
> >
>

