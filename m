Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075F1AAA1E
	for <virtualization@lists.linux-foundation.org>; Mon, 19 May 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747640112; cv=none; b=aq/x4OGRa1dNDpyRjvE43rBoEC+/YvZw66s8ravk79S9njTowSWgGCNXOKM1hnLDepEV76NepDWR63qWTUCrAjEhNxI9Co/aARoB3Y6SjYSQr3aYSsjSQsZfL8arNS7Ngeb7nA/p6cXJuGqApgJJsDlr6zm3Dku4gse+GrjuUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747640112; c=relaxed/simple;
	bh=+GWWr5RiqW6nfGpNUOrgJWmEkayVvBy0v+dsRdLauRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB5Ifc+xmjGx4FvK3ZrrfF3+u+DQrvUgLCNXEqy0N7wnDteEL0L/h0p/3G26tMtg51D9G6XwvNcdEAt8Pr/+OOJZFawTVkBOgosoOe5NBOAMBJ/cAhYMmoHFIZ3AOIeIUMsruJvnyQ9wq6YS4EPY64BjWgVaoYZuPWFf9j618jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Am5w7NgI; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Am5w7NgI"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89B3281566
	for <virtualization@lists.linux-foundation.org>; Mon, 19 May 2025 07:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wKj_HGk0tsNs for <virtualization@lists.linux-foundation.org>;
 Mon, 19 May 2025 07:35:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7B4B381E1A
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B4B381E1A
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Am5w7NgI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B4B381E1A
	for <virtualization@lists.linux-foundation.org>; Mon, 19 May 2025 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747640104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GWWr5RiqW6nfGpNUOrgJWmEkayVvBy0v+dsRdLauRc=;
	b=Am5w7NgIiGaSTxSMeC9aLbrNpMeXvnrr6i+E6X4lEyWzoglHslKTNcublCqgxix3MxCB70
	tBG92bW3eizgUUwl26kOnzaCAcE0LjA5NU0KGlv+s1XsgOekuEeFddW0LVzo0LE7V8slVG
	hCE0bAmgdi0IkJzZPTdK4m9ZxIFn3L4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-csNAdLrDNNS1vCXP2XLbOA-1; Mon, 19 May 2025 03:35:02 -0400
X-MC-Unique: csNAdLrDNNS1vCXP2XLbOA-1
X-Mimecast-MFC-AGG-ID: csNAdLrDNNS1vCXP2XLbOA_1747640101
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso2666769a12.0
        for <virtualization@lists.linux-foundation.org>; Mon, 19 May 2025 00:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747640101; x=1748244901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GWWr5RiqW6nfGpNUOrgJWmEkayVvBy0v+dsRdLauRc=;
        b=b54PzMCw9upwPuFHnNlfXU4zdi7dR/VygFJ+n2Ka5gTon+G1bhtF/qwBMaLATMuCYJ
         qkzhYPBhaXPYmuHVlllJXceEqf501hj3kLk86IyQWeICmYNqc55Pef6DyJrdgxAMLsFD
         J/ByCib/yHZWDVh7N4X7AvlIyM0joY0/L6mKmIDI6uxCKqMbhDPlKhBHf7YpQ+3214OA
         5J09tvDutRlzTPjSd3LOK95YiiXPHo/3mfEiAYVVA8qzgVf0rvjayonN0KYi6z1Nu/wV
         sZ36HrCIAGfOK0BcI7j4sIAmLW3NNUcn8Zdq043msYLm8wL587QQu4PeKA8f+KNdW5P3
         KVuA==
X-Forwarded-Encrypted: i=1; AJvYcCVIY/DaplffyAZrIN05M1VNvi89iOpQAHFdByqU3Bev/PwwCH9f1Ssl0ZBZ+V/CIQe7M1PsFjogbKwQ6Z5S/w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy/YKO00KMlLP2HoLL2xDgfsG6CgY0tCEQH9eY5ZG9QNRb0wT89
	TKqWDSlUnUFX3LDflEqQaiC9rJtzBFAjEwUiqOuoriZJlFWo5Pgpx2Udebdl4+Yf8Ep7/C91Rfb
	RTW7YeQcHNIjgNbDFouKLbSjvVrExIAn2cv5/hQWTWSlVgJTovx8cl0+WGFs5lgdg4Q638Se0Ry
	aRum66/Fx24Nab/oQfsbzrlT45A2+iLLdaowgH5KFV9RhmrU3Dedmo0Yj0MQ==
X-Gm-Gg: ASbGnctAQQleB1Ar0CGnBKTGK1qJM/KvPJTX/xnkQ4abL8/wSQxeCKMdk4Jxsbtlx31
	jJw+i69g2s4xlGFns/WwM6we00CO3Kkknblj57I/ZJfOaIX/5XEZrVqF64TkVYiQm7ybx4A==
X-Received: by 2002:a17:90b:5344:b0:30a:b93e:381b with SMTP id 98e67ed59e1d1-30e8323efb1mr16994396a91.35.1747640100984;
        Mon, 19 May 2025 00:35:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt9F94wd/fVIMSOApEGXJjgSdwwxfi3SsRD6UvHPFqL4hZL+vGud5MgtJ7RZc3Wd0IkHVmn4mfL7q3qoCrYIg=
X-Received: by 2002:a17:90b:5344:b0:30a:b93e:381b with SMTP id
 98e67ed59e1d1-30e8323efb1mr16994369a91.35.1747640100521; Mon, 19 May 2025
 00:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org> <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org> <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org> <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
 <20250515021319-mutt-send-email-mst@kernel.org> <CACGkMEvQaUtpsaWYkU6SC=i1tXVbupNrAVPBsXm3eMfAJHzC=Q@mail.gmail.com>
 <20250516063659-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250516063659-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 May 2025 15:34:46 +0800
X-Gm-Features: AX0GCFvjL12yu5vbZKoZG0F8FRp_SpNIY-NCfrlEoz_AECElKDPTfAB5-YtQhxY
Message-ID: <CACGkMEscvjHyrWy1PgMOwz8Ys7s2ReX_xiu65WvLyShPubZvVQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xO4Xq5TrbasXKYKowNDYNf5sxTlJUjXObruhQD8S1as_1747640101
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 6:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, May 16, 2025 at 09:31:42AM +0800, Jason Wang wrote:
> > On Thu, May 15, 2025 at 2:14=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, May 14, 2025 at 10:52:58AM +0800, Jason Wang wrote:
> > > > On Tue, May 13, 2025 at 3:09=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > > > > On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > > > > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin =
<mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrot=
e:
> > > > > > > > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <ja=
sowang@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <=
jasowang@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <=
lulu@redhat.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_=
FORK_OWNER_IOCTL`,
> > > > > > > > > > > > > to control the availability of the `VHOST_FORK_FR=
OM_OWNER` ioctl.
> > > > > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set =
to n, the ioctl
> > > > > > > > > > > > > is disabled, and any attempt to use it will resul=
t in failure.
> > > > > > > > > > > >
> > > > > > > > > > > > I think we need to describe why the default value w=
as chosen to be false.
> > > > > > > > > > > >
> > > > > > > > > > > > What's more, should we document the implications he=
re?
> > > > > > > > > > > >
> > > > > > > > > > > > inherit_owner was set to false: this means "legacy"=
 userspace may
> > > > > > > > > > >
> > > > > > > > > > > I meant "true" actually.
> > > > > > > > > >
> > > > > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwis=
e legacy
> > > > > > > > > > applications need to be modified in order to get the be=
haviour
> > > > > > > > > > recovered which is an impossible taks.
> > > > > > > > > >
> > > > > > > > > > Any idea on this?
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > >
> > > > > > > So, let's say we had a modparam? Enough for this customer?
> > > > > > > WDYT?
> > > > > >
> > > > > > Just to make sure I understand the proposal.
> > > > > >
> > > > > > Did you mean a module parameter like "inherit_owner_by_default"=
? I
> > > > > > think it would be fine if we make it false by default.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > I think we should keep it true by default, changing the default
> > > > > risks regressing what we already fixes.
> > > >
> > > > I think it's not a regression since it comes since the day vhost is
> > > > introduced. To my understanding the real regression is the user spa=
ce
> > > > noticeable behaviour changes introduced by vhost thread.
> > > >
> > > > > The specific customer can
> > > > > flip the modparam and be happy.
> > > >
> > > > If you stick to the false as default, I'm fine.
> > > >
> > > > Thanks
> > >
> > > That would be yet another behaviour change.
> >
> > Back to the original behaviour.
>
> yes but the original was also a bugfix.
>
> > > I think one was enough, don't you think?
> >
> > I think such kind of change is unavoidable if we want to fix the
> > usersapce behaviour change.
> >
> > Thanks
>
> I feel it is too late to "fix". the new behaviour is generally ok, and I
> feel the right thing so to give management control knobs do pick the
> desired behaviour.
> And really modparam is wrong here because different userspace
> can have different requirements, and in ~10 years I want to see us
> disable the legacy behaviour altogether.
> But given your time constraints, a modparam knob as a quick workaround
> for the specific customer is kind of not very terrible.
>

Ok, that makes sense.

Thanks

