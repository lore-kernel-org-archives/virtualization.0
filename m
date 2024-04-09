Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601712E1C4
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667374; cv=none; b=aaadeXALkeiBBxIexqxF/5z3TbzNLK1szo4gx1r6L8gxW11C7Rt5uhQyGN9YUF7qX01lpwZCSvqOfur8BsB6b9DPrYcDQ31yZ8qsb7o5bu0O/aWNBC7Jd+R/wNsHFBeB2ylntEvPBxrYuF99WTqm22yCRnxkw3dR1JuQBKeDBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667374; c=relaxed/simple;
	bh=qFjj8gprOyy5QG3PDpMwH5OS6JMEOPGugaUWv8+tRvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4ZKmf3cgKoyhCM8G/7643wc383XjgHP5lRFZSSJiHihmrNDiCyvsl3HL000YTBScuyr7TkV+4KlubqZAe5tZLLB5jHkiDNoePzVAdD5otIM9wLkppzkSdvUQyJ3VsT5U2OOKbvbWLyEypZfobVEjk6jcntKrCxva9PQMlxGbEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ex/cRLK7; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex/cRLK7"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D310A406D8
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 12:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zhdTvdqY1qps for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Apr 2024 12:56:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9710D406D2
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9710D406D2
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ex/cRLK7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9710D406D2
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712667370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pt0N3bL5TJP0v672v3Z/C/6PTX4AkZIvzQAggKI+KTY=;
	b=ex/cRLK7ncXw8P45EyJedfD4HB4NaSuOKTfx+PO/AbP8ptKth564Ydx+gzxwVeGu4X0uSe
	//9Au0lF1e8s8qLoMUh3VNzmMeZprv8k2+t52qnO5RlTcq0ugIrYvFFMNTMAnBBi7IeMXU
	RrSyqjMWKN5bmBskVj+tT3QIp4+NAeg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-vdmHFdzBNzSrsbQJoBqVdQ-1; Tue, 09 Apr 2024 08:56:08 -0400
X-MC-Unique: vdmHFdzBNzSrsbQJoBqVdQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a51cf34d476so106540566b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Apr 2024 05:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667367; x=1713272167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt0N3bL5TJP0v672v3Z/C/6PTX4AkZIvzQAggKI+KTY=;
        b=iBCsMBXAuYfVjZURlk11UcSpwWyOCL4svQngtgnuneqWgGUW3XxexkbJYCQ+MUKBGG
         1Ec4Z7ZTBaBOtuzKXz/GKDQ2aHTQDOkPMNJgGeNfZE3bMisXHpry88zP4IbDNcP3dGwD
         /wTNU9IcGAbTo6PY6GuBB+3ObBt3fMknRBrzkA+OvA2YR3FBOqz3y7ArBECtq6GLz7iU
         YwkGcMGABRfvk1n2yfvpzNijjyIwtDoEgucYr4vX3/880EcBO2Txw1+lG+0dpfSa/1mH
         gbjhSl2TBi4zF0kvIoWyhxS71xCEeV3F2CXjF9otns3xta1eVeL0xR8fME1ghrZ1It11
         T1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEF/IS+LcawPR7gmzSAs2BZQT57x3z+ZPrZ20BTnAoRmdMiGN0zJ4ETRRRbwRA2wFOAzOshqp8l+1HR61Uctk5m4lo0upmjUJPsyVTWOgJKO2+hLw6IOFo6A==
X-Gm-Message-State: AOJu0YzsqfnRIVhBYqTlJBodZ4JHNElatwyBf+kBxQtFmYYMa/YKcJk8
	lZQVSj1ImVUIB1Mrbw/40baR19dwq1f3EwktcDTEufn7sjuT/Ydf00TVwaJdD6088BdCetSLG6s
	5MDVQL+hxdMbgugHGXUcxgcQXZIW/KNZxTB3US4rDtQwuemYOJay50X3FW6V2GbvWFMA+yJEALr
	Z9G0GxRPLmd/0oGxfGCq4wf5qKMVJK3FGhZOc5HIRERW9I6ApmK4LAiA==
X-Received: by 2002:a17:906:6889:b0:a51:a688:3e9c with SMTP id n9-20020a170906688900b00a51a6883e9cmr6916794ejr.35.1712667367592;
        Tue, 09 Apr 2024 05:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoJWDaZk2RdQUZFsUUYdQeQjnpvYmMrAlJni0v8Qmi8hoHGlbaqGBCHz7xfsMA25ZelFLfveAk8CK5Iy6mxH0=
X-Received: by 2002:a17:906:6889:b0:a51:a688:3e9c with SMTP id
 n9-20020a170906688900b00a51a6883e9cmr6916714ejr.35.1712667365422; Tue, 09 Apr
 2024 05:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240404055635.316259-1-lulu@redhat.com> <20240408033804-mutt-send-email-mst@kernel.org>
 <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com> <20240408085008-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240408085008-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Apr 2024 20:55:23 +0800
Message-ID: <CACLfguWC3LruVfLndc4vzpzOuomEz-+nHY0KENZ6iiXNB728eg@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Add reconnect process for VDUSE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 8:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Apr 08, 2024 at 08:39:21PM +0800, Cindy Lu wrote:
> > On Mon, Apr 8, 2024 at 3:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Thu, Apr 04, 2024 at 01:56:31PM +0800, Cindy Lu wrote:
> > > > Add a document explaining the reconnect process, including what the
> > > > Userspace App needs to do and how it works with the kernel.
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++=
++++
> > > >  1 file changed, 41 insertions(+)
> > > >
> > > > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/=
userspace-api/vduse.rst
> > > > index bdb880e01132..7faa83462e78 100644
> > > > --- a/Documentation/userspace-api/vduse.rst
> > > > +++ b/Documentation/userspace-api/vduse.rst
> > > > @@ -231,3 +231,44 @@ able to start the dataplane processing as foll=
ows:
> > > >     after the used ring is filled.
> > > >
> > > >  For more details on the uAPI, please see include/uapi/linux/vduse.=
h.
> > > > +
> > > > +HOW VDUSE devices reconnection works
> > > > +------------------------------------
> > > > +1. What is reconnection?
> > > > +
> > > > +   When the userspace application loads, it should establish a con=
nection
> > > > +   to the vduse kernel device. Sometimes,the userspace application=
 exists,
> > > > +   and we want to support its restart and connect to the kernel de=
vice again
> > > > +
> > > > +2. How can I support reconnection in a userspace application?
> > > > +
> > > > +2.1 During initialization, the userspace application should first =
verify the
> > > > +    existence of the device "/dev/vduse/vduse_name".
> > > > +    If it doesn't exist, it means this is the first-time for conne=
ction. goto step 2.2
> > > > +    If it exists, it means this is a reconnection, and we should g=
oto step 2.3
> > > > +
> > > > +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > > > +    /dev/vduse/control.
> > > > +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memor=
y for
> > > > +    the reconnect information. The total memory size is PAGE_SIZE*=
vq_mumber.
> > >
> > > Confused. Where is that allocation, in code?
> > >
> > > Thanks!
> > >
> > this should allocated in function vduse_create_dev(),
>
> I mean, it's not allocated there ATM right? This is just doc patch
> to become part of a larger patchset?
>
Got it, thanks Michael I will send the whole patchset soon
thanks
Cindy

> > I will rewrite
> > this part  to make it more clearer
> > will send a new version soon
> > Thanks
> > cindy
> >
> > > > +2.3 Check if the information is suitable for reconnect
> > > > +    If this is reconnection :
> > > > +    Before attempting to reconnect, The userspace application need=
s to use the
> > > > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GE=
T_FEATURES...)
> > > > +    to get the information from kernel.
> > > > +    Please review the information and confirm if it is suitable to=
 reconnect.
> > > > +
> > > > +2.4 Userspace application needs to mmap the memory to userspace
> > > > +    The userspace application requires mapping one page for every =
vq. These pages
> > > > +    should be used to save vq-related information during system ru=
nning. Additionally,
> > > > +    the application must define its own structure to store informa=
tion for reconnection.
> > > > +
> > > > +2.5 Completed the initialization and running the application.
> > > > +    While the application is running, it is important to store rel=
evant information
> > > > +    about reconnections in mapped pages. When calling the ioctl VD=
USE_VQ_GET_INFO to
> > > > +    get vq information, it's necessary to check whether it's a rec=
onnection. If it is
> > > > +    a reconnection, the vq-related information must be get from th=
e mapped pages.
> > > > +
> > > > +2.6 When the Userspace application exits, it is necessary to unmap=
 all the
> > > > +    pages for reconnection
> > > > --
> > > > 2.43.0
> > >
>

