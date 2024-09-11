Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDE42A9B
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026355; cv=none; b=bwZAA9kZr6rsicd8t/CLGaII1m6KcCGI2LNh0sri4TQ9cy/DeO/ZPJVAKGHiM5Agxna6VJb5KZUoXSVAIUdoafzxvKWi9rM9q1/ND8hkopZY0dHoQS2GO9jjQ/fKBeRgrqUVkAD7OdUEcE8dKEd/37wuhM307U1WLlshJxpIHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026355; c=relaxed/simple;
	bh=+Rqn0P9mB0La8B4Fje7p5aX1Sl7TbVmBDFgISlRF8pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er5JRoD8JZVmhMjY1Y+tpZrMd4ZoqXO9+su6/BAYJnENMsNzcaLDCuXBZtMx1E/XW+rpkHLSTvrGqULJAcVa4Mr8lUJOvDrM79TWFNDIJY+TkRjtogfpi22clT78Tp4FvVO9BpJprXoLxUK+WMWX90pjuIV4+ToBNCyjIrZijUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFEPf4ea; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFEPf4ea"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB5004072D
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 03:45:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FgwdqymJxqK0 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Sep 2024 03:45:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6F9AC40714
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F9AC40714
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HFEPf4ea
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F9AC40714
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 03:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpoA2K3FbuBcPt6tnw7KwvXi7Ya0b7H2b/GB31m+eoM=;
	b=HFEPf4eakpgy/Rn1MgUofpakuWwcDdvlSSC5WWcgTzm32D830uj79G16buJiq90fPKRkif
	w8CCLUusX9pvKp97PFVy1LM96uAFJFfmOoX24be0LoEjfFw5RB4OlXeE8PQKiLOUbpnFAH
	E+i0dwuYHZ7mnivx5FHGCy/J/IF/6y0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-Qb9aUwHENoi8LrFVbm0NIA-1; Tue, 10 Sep 2024 23:45:47 -0400
X-MC-Unique: Qb9aUwHENoi8LrFVbm0NIA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d882c11ce4so6492758a91.2
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 20:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026346; x=1726631146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpoA2K3FbuBcPt6tnw7KwvXi7Ya0b7H2b/GB31m+eoM=;
        b=YlRZb1kOZllpAd03Rsy2COYtkLeaTvRmkcaAEHWqm81EHtrKsdAnqrlNAxqbfIrKHG
         6HO9KxgxC4FpeuBjdhHFJeHd2NZxw3908r05lVxIg0+39bz6+cBZp2yK2PJI9yoP4EcU
         rLmxLQR/dK079x/Mt6MS/rgk6LWTaHW9w+EhBZEgaLfYEj0R4Yr9k85dvvjdk54Sf1tw
         jBlF1kpZpssasZ1/uOz6uwgnl7J143wSIRJ0Q/JInhyTqdT0Jtg8n4btptn2jBLizJ15
         hp15ccgCqNWoKdG/Kb+2XnihdvlBxwBrGoOvyzxbTKUmzindlBJjMFm9hoVSmZf8OdMU
         2cRA==
X-Forwarded-Encrypted: i=1; AJvYcCWvewQEEnXV7zDFUs0mrDyWPKwMp5GPmgsXBQqHLdItQmC9Pdp91paOB3sRTixO/9i06Tzr0/02AAnS0oD1Hw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywy5sxNyeAl8md/IdSX7ym1riTj60HxwMRuR6RObGR3ZjsZVunW
	grs5q+ChMoDfEgSrG75rumyDKgx6Grn1RJFLd3H9o+xePDRex0kgV75R357K+nTWArxo6ZRMyjf
	OaJTRPSyuwl8qD1ZW8OybA6JUZU3EeHPgIPEF6ARQJ9uwT4ifO9dk4ldvptCqpgR6ZhEZQnWu4E
	oer8JjDozHhAoVe3T+YVeyjkPmIUqXfhvtprR+wFysSHjBx8v03M75aw==
X-Received: by 2002:a17:90a:ee8f:b0:2d3:c892:9607 with SMTP id 98e67ed59e1d1-2dad4ef4a6amr18033879a91.12.1726026346127;
        Tue, 10 Sep 2024 20:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj9vZUExbOBNU4jOmP5eXmRYi/TEXq3HEgEg7kx8fYKg3PiXc3U9CsuxA3ZvSd76wvoTopUe5ybTKLYrtquv4=
X-Received: by 2002:a17:90a:ee8f:b0:2d3:c892:9607 with SMTP id
 98e67ed59e1d1-2dad4ef4a6amr18033853a91.12.1726026345640; Tue, 10 Sep 2024
 20:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240909020138.1245873-1-lulu@redhat.com> <20240910032825-mutt-send-email-mst@kernel.org>
 <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com> <20240910044139-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910044139-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 11:45:33 +0800
Message-ID: <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Sep 10, 2024 at 04:37:52PM +0800, Jason Wang wrote:
> > On Tue, Sep 10, 2024 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> > > > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"=
),
> > > > vhost removed the support for the kthread API. However, there are
> > > > still situations where there is a request to use kthread.
> > > > In this PATCH, the support of kthread is added back. Additionally,
> > > > a module_param is added to enforce which mode we are using, and
> > > > a new UAPI is introduced to allow the userspace app to set the
> > > > mode they want to use.
> > > >
> > > > Tested the user application with QEMU.
> > >
> > > Cindy, the APIs do not make sense, security does not make sense,
> > > and you are not describing the issue and the fix.
> > >
> > >
> > > The name should reflect what this does from userspace POV, not from
> > > kernel API POV.  kthread and task mode is not something that any user=
s
> > > have any business even to consider.
> > >
> > >
> > > To help you out, some ideas:
> > >
> > > I think the issue is something like "vhost is now a child of the
> > > owner thread. While this makes sense from containerization
> > > POV, some old userspace is confused, as previously vhost not
> > > and so was allowed to steal cpu resources from outside the container.=
"
> > >
> > > Now, what can be done? Given we already released a secure kernel,
> > > I am not inclined to revert it back to be insecure by default.
> >
> > It depends on how we define "secure". There's plenty of users of
> > kthread and if I was not wrong, mike may still need to fix some bugs.
> >
>
> which bugs?

https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com=
/T/

>
> > > But I'm fine with a modparam to allow userspace to get insecure
> > > behaviour.
> > >
> > >
> > > Now, a modparam is annoying in that it affects all userspace,
> > > and people might be running a mix of old and new userspace.
> > > So if we do that, we also want a flag that will get
> > > safe behaviour even if unsafe one is allowed.
> >
> > I am not sure this can help. My understanding is that the flag is
> > sufficient. Otherwise the layered product needs to know if there's old
> > user space or new which seems to be a challenge.
> >
> > Thanks
>
> this will be up to userspace to resolve.

I actually mean the module parameter. It would be very hard for the
layered product to decide the value for that.

Thanks

>
>
> > >
> > >
> > > Is this clear enough, or do I need to elaborate more?
> > >
> > > Thanks!
> > >
> > > > Cindy Lu (7):
> > > >   vhost: Add a new module_param for enable kthread
> > > >   vhost: Add kthread support in function vhost_worker_queue()
> > > >   vhost: Add kthread support in function vhost_workers_free()
> > > >   vhost: Add the vhost_worker to support kthread
> > > >   vhost: Add the cgroup related function
> > > >   vhost: Add kthread support in function vhost_worker_create
> > > >   vhost: Add new UAPI to support change to task mode
> > > >
> > > >  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++=
++--
> > > >  drivers/vhost/vhost.h      |   1 +
> > > >  include/uapi/linux/vhost.h |   2 +
> > > >  3 files changed, 240 insertions(+), 9 deletions(-)
> > > >
> > > > --
> > > > 2.45.0
> > >
>

