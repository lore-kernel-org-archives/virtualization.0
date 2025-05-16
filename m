Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F227701
	for <virtualization@lists.linux-foundation.org>; Fri, 16 May 2025 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359121; cv=none; b=aLuIvioLMdwgPZQ8cohb8Kq8/cDaZaFhPsMlafV2haqLKhvA54t9d21a7Ia8f221JZnBksXpuNiPq770by9dZdmSbDDpBI5JKTBVDles8CtZi8B47TO8xylaks/wOHWjdzOBnW9fBL0oas3vivujytEwtmIrNigcL/POXR3CjMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359121; c=relaxed/simple;
	bh=dHG8gFthP6572iwZ9voMYp5Nib09yecuPF2Kb1mF4Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpxJtrfJWXJJvJkl2bNWaGC4ou/zVqE6gTlmDM/U1eJjxUKGHv0Khoz3YH146rBxZSB+IdFo1OQ66S7+JURl+t2DI+CjLvavgk9UTP/AmA6krKrFtZWnmAqzuQvCPjk1e9zWLa3JbqnYo54dFiYEqdn0fqPQaPKfhKd6L2hXfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTtFyhv1; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTtFyhv1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45DB380E97
	for <virtualization@lists.linux-foundation.org>; Fri, 16 May 2025 01:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ltC0oO9xHVjN for <virtualization@lists.linux-foundation.org>;
 Fri, 16 May 2025 01:31:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 83D4B80EC6
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83D4B80EC6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XTtFyhv1
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 83D4B80EC6
	for <virtualization@lists.linux-foundation.org>; Fri, 16 May 2025 01:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747359116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHG8gFthP6572iwZ9voMYp5Nib09yecuPF2Kb1mF4Lk=;
	b=XTtFyhv17fwpWzgOlCb7SWoHUt5poRQAK5K79SCM5CQ5sWwH1y29/akWUA6i7PI7sdgstc
	jtXcKh49xH51asva11ulLd9++ru4BWNAoSjcDq/C/4D+LIZr2zAatWIpGrgq/11FZWSc0e
	hWbrp+OWFDzIy6c3V2Xy0Asfn0IF5LQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Xi4dv2I0Pd2r7spPIXVGlw-1; Thu, 15 May 2025 21:31:55 -0400
X-MC-Unique: Xi4dv2I0Pd2r7spPIXVGlw-1
X-Mimecast-MFC-AGG-ID: Xi4dv2I0Pd2r7spPIXVGlw_1747359114
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b26e73d375aso1089739a12.2
        for <virtualization@lists.linux-foundation.org>; Thu, 15 May 2025 18:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747359114; x=1747963914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHG8gFthP6572iwZ9voMYp5Nib09yecuPF2Kb1mF4Lk=;
        b=YPEP7T/TlR1doDh70mTPmwHMk48La34bW+MQX/3bUBJCOdU7EqOFfyWiVYqDlZVkkm
         QkFrMuEpuOgiWbRogeNDVRAbtdHQjZiI9MDuF08aASRRfjJkesvt2ZigcTB4f/fGUPig
         uPcyHFRav1/tPsIPWXWo3p1ccpgruFaSE1LaQLwqs1ju5kFl327KFWRxGuDBx/d+Fweu
         MRJBfL1VyPtKfbcBe9vf6qi2acQVq+n4g80BiA4MkwWzyyCyysmCO+29OlNziqd2QXCN
         SD19ic71bhRhWsxWci+hW1vNftQZjQxW16NUQbgJM01+iAARO02/1ZJsA84eBARSS06r
         CdkA==
X-Forwarded-Encrypted: i=1; AJvYcCVD8hjlcnqXT4FoCHnWdQP5h6M7CQYx7L7AsA+UBZMPI/6shaI9rZkjOmyz2PBptDy0sJio0UV4DKcBo78wuQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzgKTZL7YVAAEmwU5RDuMLN5Iff7Iby/zxHmjlPaTEJQ0L+vBHs
	bau/IBmrdL1cRTdmbdKT2og1LlgMa2+iVhrziacKRpAHhLYSRK4SGKKrRN7m/1ExnZ1skMajUtK
	OypEhjNGWRBgyqfaZwsCiq3OnkuOezXE7w2Q3F+ToooO75x7+PnncAFSavHKjAnbUZwEGBEzA3o
	s1GRNx05zfIM+wKSSbicmzT+p+Rd2ODi4RzcGTTgKnMkuVG7sOZmVJbetadw==
X-Gm-Gg: ASbGncvNiZc+PZu9200OXE64mKv/BKU3YAAHADeQ/eqIHFm7UhuO2Sz/6g//s7GOvyI
	vu4GAw9g4r3rWFsDy29HoyTrkS5wXsCx1qStSJxvKDttijF6RAwmz2FHhu0FYp35ZNPnsug==
X-Received: by 2002:a05:6a20:7f86:b0:1ee:ef0b:7bf7 with SMTP id adf61e73a8af0-2170cc8f33fmr1031911637.19.1747359114245;
        Thu, 15 May 2025 18:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF/mXKGt3zwINJmfa+xjHZQcL10bzBEwpDZkwgSC7ZysZq48EWkzUMi17HyPYSwG2Bt/eIh6oHKkky9X9+jac=
X-Received: by 2002:a05:6a20:7f86:b0:1ee:ef0b:7bf7 with SMTP id
 adf61e73a8af0-2170cc8f33fmr1031878637.19.1747359113861; Thu, 15 May 2025
 18:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-5-lulu@redhat.com> <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org> <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org> <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org> <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
 <20250515021319-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250515021319-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:31:42 +0800
X-Gm-Features: AX0GCFv_WBgAJTVQmI2TBtXitRDIMCU2f2R8aDmTo2xnqxFw0aP_mhb-qMjj5ag
Message-ID: <CACGkMEvQaUtpsaWYkU6SC=i1tXVbupNrAVPBsXm3eMfAJHzC=Q@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cb60CpAwCeWwAujoWaAnyaw2NwHHTGwt2Zjl5KZ0_xI_1747359114
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 2:14=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 14, 2025 at 10:52:58AM +0800, Jason Wang wrote:
> > On Tue, May 13, 2025 at 3:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > > On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jaso=
wang@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu=
@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK=
_OWNER_IOCTL`,
> > > > > > > > > > > to control the availability of the `VHOST_FORK_FROM_O=
WNER` ioctl.
> > > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n=
, the ioctl
> > > > > > > > > > > is disabled, and any attempt to use it will result in=
 failure.
> > > > > > > > > >
> > > > > > > > > > I think we need to describe why the default value was c=
hosen to be false.
> > > > > > > > > >
> > > > > > > > > > What's more, should we document the implications here?
> > > > > > > > > >
> > > > > > > > > > inherit_owner was set to false: this means "legacy" use=
rspace may
> > > > > > > > >
> > > > > > > > > I meant "true" actually.
> > > > > > > >
> > > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise le=
gacy
> > > > > > > > applications need to be modified in order to get the behavi=
our
> > > > > > > > recovered which is an impossible taks.
> > > > > > > >
> > > > > > > > Any idea on this?
> > > > > > > >
> > > > > > > > Thanks
> > > > >
> > > > > So, let's say we had a modparam? Enough for this customer?
> > > > > WDYT?
> > > >
> > > > Just to make sure I understand the proposal.
> > > >
> > > > Did you mean a module parameter like "inherit_owner_by_default"? I
> > > > think it would be fine if we make it false by default.
> > > >
> > > > Thanks
> > >
> > > I think we should keep it true by default, changing the default
> > > risks regressing what we already fixes.
> >
> > I think it's not a regression since it comes since the day vhost is
> > introduced. To my understanding the real regression is the user space
> > noticeable behaviour changes introduced by vhost thread.
> >
> > > The specific customer can
> > > flip the modparam and be happy.
> >
> > If you stick to the false as default, I'm fine.
> >
> > Thanks
>
> That would be yet another behaviour change.

Back to the original behaviour.

> I think one was enough, don't you think?

I think such kind of change is unavoidable if we want to fix the
usersapce behaviour change.

Thanks

>
>
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>

