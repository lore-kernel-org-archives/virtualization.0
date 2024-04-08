Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93396CDDC
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580008; cv=none; b=N7qha74OGIEPVVND3VDIpp+qDikPUStrEGFsw8aO6+prcicY7DLzieaQtggOkcQgNdaKvPk49KDAsKUqQHo+RStAnq+OgWYhmDoj/093TiCNwxwLrAOjG5e0aRHc2T6boT8uJf0Cr2KkXzqizH+uNMbIRtJKQIYWby/YA60mJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580008; c=relaxed/simple;
	bh=fxPXw2p77yhgVxO+9PcInO2jf4CRcklB5uKFPixrm8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taFIpiFUD95gTMVouSeS0qExVp4XJ9+lwMXETviA6ri6SA9ZQsPDlMfz+2vD4I59DovdQgJ5N3yITtHzG8N+Fu9wqsFqNkC2m4MHTOASUKxaOKlUPk/DRs+e5Ma+cCgIDuZBYyc5iAvrhCvi+mxLp210hHF8AzVyvACdFTxL5I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICPX0NBP; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICPX0NBP"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9306081799
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 12:40:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 920fLnkJ73Bz for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 12:40:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A8457817A2
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8457817A2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ICPX0NBP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A8457817A2
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712580003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ae2COtjajtOOtS6X4ygU+qeHK/f9eu0OjppudYN/LXQ=;
	b=ICPX0NBPIWiSzHv/qAZo0YcA8QGYQM63evZiJLFredajKRrV0BQkvoC549+haRafGyFbXw
	4WmmFotLtu+SXRFFxoXJZ8Gd34iKQooRkXhFngPmBdRCgtZDBPri/dBWW7B+al21NlazXQ
	S1+pEgv1ZyJ0uCTHeKNml9SnMMwdvbA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-hf6pT_ixNqK4DBHABKLglw-1; Mon, 08 Apr 2024 08:40:01 -0400
X-MC-Unique: hf6pT_ixNqK4DBHABKLglw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a462e4d8c44so215013666b.1
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 05:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580001; x=1713184801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae2COtjajtOOtS6X4ygU+qeHK/f9eu0OjppudYN/LXQ=;
        b=NVlH5y9XrPA5ItjkVS0/LMAOVT+7rPq+2jrIek/uWsGT6+cW4ulLYXF3GriTIQ7uu2
         4HCWH8bnQxq6t/ZTOUZ3MAp24sA7IIef8iQbVGR4Nj9nDQzHuqx0yzYrRWVkneONiPQT
         jXMSUu+HnF45MgLhO7SyRuKHUu1zhl6joI81/QbuPmh/D+vTbxjrnFX9K21f4Puuv7g+
         RdDFdw5peHOjrxPhc1OqDs7bG/ovXpPPOqqbFzM6vpRsbkWNHR3LGel6cy16ornIOHbA
         b4B9bDlDZ3nFZGSwRAfVF37VUt9jPKv6KQEltBTWuflDumaoNEhFVCUrRLx37fWT4U5L
         BnkA==
X-Forwarded-Encrypted: i=1; AJvYcCWLC8xJbLHXzj7FUsnyULBx6XwBUn7c+wqq1g6f1pFtuFjxXzSBsH2AYsO85WxGBj/rMemBMLDBGiomwsBgKCFVyxNUzXmnj8KLB9BpCPz4fEHjAEOTbR/3dA==
X-Gm-Message-State: AOJu0Yw0EH0iZW94bGkl4ctBORu/Y7CHFqRKOw0Ft7MBJG8/E1rw+7oX
	d2C8FTdsoU5sw3koneDBLDl8RV8nSX4s/fO6tcPLHjfsOinbeTgP2gvbggBjAf9VYf49Da18N6S
	ktZF8FWTprixGPCfn/fGwfP5g2Cpzwmn/gp71tEVzvo5r3OeLLhZaYk+329Uzl05tY3Kze9ssRx
	7pqUTKQpFpfdr7DV/optWrGzjslU+0knrAlonNAlPWCbJ0QRD7teuE2Q==
X-Received: by 2002:a17:907:9444:b0:a51:d70f:b5f2 with SMTP id dl4-20020a170907944400b00a51d70fb5f2mr2084583ejc.20.1712580000862;
        Mon, 08 Apr 2024 05:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg3MkKq/gJZBjDBVnAKe4jU7q9XkeS1BfnnkBObgzhdnwCFitOZa/DmVr4r6jMIn9yjc43uLBh88PkDhgd3Mk=
X-Received: by 2002:a17:907:9444:b0:a51:d70f:b5f2 with SMTP id
 dl4-20020a170907944400b00a51d70fb5f2mr2084571ejc.20.1712580000551; Mon, 08
 Apr 2024 05:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240404055635.316259-1-lulu@redhat.com> <20240408033804-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240408033804-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 8 Apr 2024 20:39:21 +0800
Message-ID: <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Add reconnect process for VDUSE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 3:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Apr 04, 2024 at 01:56:31PM +0800, Cindy Lu wrote:
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
> > +   and we want to support its restart and connect to the kernel device=
 again
> > +
> > +2. How can I support reconnection in a userspace application?
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
> Confused. Where is that allocation, in code?
>
> Thanks!
>
this should allocated in function vduse_create_dev(), I will rewrite
this part  to make it more clearer
will send a new version soon
Thanks
cindy

> > +2.3 Check if the information is suitable for reconnect
> > +    If this is reconnection :
> > +    Before attempting to reconnect, The userspace application needs to=
 use the
> > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FE=
ATURES...)
> > +    to get the information from kernel.
> > +    Please review the information and confirm if it is suitable to rec=
onnect.
> > +
> > +2.4 Userspace application needs to mmap the memory to userspace
> > +    The userspace application requires mapping one page for every vq. =
These pages
> > +    should be used to save vq-related information during system runnin=
g. Additionally,
> > +    the application must define its own structure to store information=
 for reconnection.
> > +
> > +2.5 Completed the initialization and running the application.
> > +    While the application is running, it is important to store relevan=
t information
> > +    about reconnections in mapped pages. When calling the ioctl VDUSE_=
VQ_GET_INFO to
> > +    get vq information, it's necessary to check whether it's a reconne=
ction. If it is
> > +    a reconnection, the vq-related information must be get from the ma=
pped pages.
> > +
> > +2.6 When the Userspace application exits, it is necessary to unmap all=
 the
> > +    pages for reconnection
> > --
> > 2.43.0
>

