Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86369187857
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957491; cv=none; b=SCzTplLJ2Z9biJniiKAJ6zzRoxNCNX4lY11udpoTmvluvDVdBEqWvi2p/AZJv/8Z5zPtfTn7tqSywHOhn2szi6aNh+37EXh5m680oqjHhHX1Ybp4zy+sKjKekUMSAesEWQHZ+TxMQRXekQV/3P4oCZWL4QA/uJXKO2UYXs0Hty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957491; c=relaxed/simple;
	bh=fnaF8gPEpYkpUTRGXvaULlGO8r2Crx4Q3msbEnNHPu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq2XnszQ+OYGBIeQpCoPaEnCQi4uEJlKX/xV2iOqubcryXy7waeFX76sYDFWSft9B/0EeiS/yZZ4t1JEKrff8dckSe/vvRUOtOl3TvGkhuZg4B2Tqwuwizhj6yICA4E6p6k9lF4W9Zzooweo4etnrOEAqRjhRfc1cN4Il/cXSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLo/Krce; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLo/Krce"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4710140450
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 08:38:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W9KcpL6TcwI2 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Sep 2024 08:38:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2F429401A4
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F429401A4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLo/Krce
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2F429401A4
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 08:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725957487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iJUAv5Ry381p8aMkXZK0fv3mb0B6nXI7NKnzuhOuSM=;
	b=YLo/KrceosjAOaXKsI1hY33ltGSMj2kvKSwoBHznek+yuoq45TUsU7/1yVY9GH8+3qnK04
	dSoqmnOyIFsgFO7qqNh33xSdJFjXI/7Oow1E0cb8tv9gy3S+dIxngJaKNDhmy9zcaVaKlE
	9NBtN7hOKRedyoL3Cqi0cB23lGcZq2A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-0OczeteXPI2EHfn0gHwdqw-1; Tue, 10 Sep 2024 04:38:05 -0400
X-MC-Unique: 0OczeteXPI2EHfn0gHwdqw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-206d8c47496so63014525ad.2
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 01:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957485; x=1726562285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iJUAv5Ry381p8aMkXZK0fv3mb0B6nXI7NKnzuhOuSM=;
        b=JmtrUYTYtcR8aoYGinwfW5OCLadDMLvaMKpmzqEBcOdmSzE6aulQy2S32o6uxX9/bk
         OdkBj0YK58hck3Rb1RO9gR5vshX/I/IJ1OhZ+hdKzLbJzgMnMI+ofn9XmMmPorTT9oC8
         cDPpbgGezSh2Xj5IjxmEmtyuOuvM+xTh6YPNbBG4HCPH75If0YnUoAs0pRevBDcpm07D
         1oXXYxNHsv1iNXxBBg2DtJAzKudutaOfqk5Sg8MYE/0N4kk0+ugRa63DMZDfMWQvPTwQ
         ldm7gEkKVSEeGlTQNRTFwK1GNjgwvsKCaITh8aeSlM65Ph71ZvTENXGqG7xUzMoWmA4B
         dN1w==
X-Forwarded-Encrypted: i=1; AJvYcCW0ejV9RR7rY9/zghWsjRQycP+aV+U/yeR/5PQvwNHEUMUoh/MEIigNPEPr1oZ5GeCfJxyaG5NSbCDo9xaj6g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwziKQHiLNnrW6aFFgRw5ru9LMIW50nR5DTwFqxl7IJE1xHN9/1
	KNc2vM4jVs0y8qW/HlE42Y6hsVCM4q+7cER+uv8yaMKLZfMAVOrUAWNmIc2VX13o5Fwb3Vu0UuR
	KhrPlW4yjoMHuhg0AgDdsCgRKdZ3EqOha97emUYXjtpA1e2C0lzEWvAdLvQl7T0R3NmO4vFAPe/
	Az/DINNFJm20FEeTsc3IPxnJ7mYwvJ4qvVMv5UoBulI2o5tzQSMkb5Cw==
X-Received: by 2002:a17:902:d2c4:b0:207:73f:59f3 with SMTP id d9443c01a7336-207073f5b2fmr92474825ad.32.1725957484827;
        Tue, 10 Sep 2024 01:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN+6s0zW2d5Bv2RAV9dPFLl3+KMxshNJUww5Fv/MtwPDNl+ZxD7CVDUqQYQDp11tZQ2myblNXEAnVEStNtMNs=
X-Received: by 2002:a17:902:d2c4:b0:207:73f:59f3 with SMTP id
 d9443c01a7336-207073f5b2fmr92474615ad.32.1725957484166; Tue, 10 Sep 2024
 01:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240909020138.1245873-1-lulu@redhat.com> <20240910032825-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910032825-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Sep 2024 16:37:52 +0800
Message-ID: <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > vhost removed the support for the kthread API. However, there are
> > still situations where there is a request to use kthread.
> > In this PATCH, the support of kthread is added back. Additionally,
> > a module_param is added to enforce which mode we are using, and
> > a new UAPI is introduced to allow the userspace app to set the
> > mode they want to use.
> >
> > Tested the user application with QEMU.
>
> Cindy, the APIs do not make sense, security does not make sense,
> and you are not describing the issue and the fix.
>
>
> The name should reflect what this does from userspace POV, not from
> kernel API POV.  kthread and task mode is not something that any users
> have any business even to consider.
>
>
> To help you out, some ideas:
>
> I think the issue is something like "vhost is now a child of the
> owner thread. While this makes sense from containerization
> POV, some old userspace is confused, as previously vhost not
> and so was allowed to steal cpu resources from outside the container."
>
> Now, what can be done? Given we already released a secure kernel,
> I am not inclined to revert it back to be insecure by default.

It depends on how we define "secure". There's plenty of users of
kthread and if I was not wrong, mike may still need to fix some bugs.


> But I'm fine with a modparam to allow userspace to get insecure
> behaviour.
>
>
> Now, a modparam is annoying in that it affects all userspace,
> and people might be running a mix of old and new userspace.
> So if we do that, we also want a flag that will get
> safe behaviour even if unsafe one is allowed.

I am not sure this can help. My understanding is that the flag is
sufficient. Otherwise the layered product needs to know if there's old
user space or new which seems to be a challenge.

Thanks

>
>
> Is this clear enough, or do I need to elaborate more?
>
> Thanks!
>
> > Cindy Lu (7):
> >   vhost: Add a new module_param for enable kthread
> >   vhost: Add kthread support in function vhost_worker_queue()
> >   vhost: Add kthread support in function vhost_workers_free()
> >   vhost: Add the vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: Add kthread support in function vhost_worker_create
> >   vhost: Add new UAPI to support change to task mode
> >
> >  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++++--
> >  drivers/vhost/vhost.h      |   1 +
> >  include/uapi/linux/vhost.h |   2 +
> >  3 files changed, 240 insertions(+), 9 deletions(-)
> >
> > --
> > 2.45.0
>

