Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75FA2C0286
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409525; cv=none; b=KRNCKCjbdf8dduYkGve5gUDM4KfpcCMcaq0XEvoNBIgcrh09fbusfKcMQTi68mpRt9wKq6dE4UwQJPTUIa5BIcNMrNTo3v6kgpcGJD+OD3HKFfdU9DD9kwf9ryJJQ++sM+FdU6A6uyGviP+c3NKjTjC5igsMOmqXC0xTxE9li7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409525; c=relaxed/simple;
	bh=F9WzBVDyVycmq7vPxd/pkL66x9p6CV5hQB/KCgNH4Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzGhWf1dLil2VSFFAr+vuKYkr2RVH99YY0Z17+EoVCosIf1b2cZoLCwixRcXGQALS4QflfYaIUUkDFUFjrNebMg/kSEKfya0j7/WFUUmA9TNmg/lv+WbmruiMVeKw9cAEvhcRNz2O58vyuT1PxvPhirI0jmbLpFqu7eg5iCNuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCNw1VaP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCNw1VaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760409521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9WzBVDyVycmq7vPxd/pkL66x9p6CV5hQB/KCgNH4Gc=;
	b=RCNw1VaPSg3+pNq56QGXqas4Kf3XqN/Fsnse4H4O9MFD0DYIBYEHecRoruaL712rNDS9yZ
	PV5N0RGjLSXogSc4S6cO6ZdrUvyXvo3OwItR0cfT/qgCTiBHN/qzYAv3g8Rn3BUaCP1NKV
	Y2XadLS4vCqZRNnKZLqguWr+bVjgMbs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-Ax1q6x_xPJut7lCPI9kUtw-1; Mon, 13 Oct 2025 22:38:39 -0400
X-MC-Unique: Ax1q6x_xPJut7lCPI9kUtw-1
X-Mimecast-MFC-AGG-ID: Ax1q6x_xPJut7lCPI9kUtw_1760409518
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-336b646768eso11373606a91.1
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 19:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409518; x=1761014318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9WzBVDyVycmq7vPxd/pkL66x9p6CV5hQB/KCgNH4Gc=;
        b=GBVgISt7tks7MplFqfi5aa97j0JIig5501fzic+y4UWaeBw2S6FxtMTPKBoOrCG9zA
         +jALwKTV7QMtvevqS5TTT0OLEiMr6CP2ktekyXaHQdU3TD+iKZomeiB0LmcT1QZu3CwP
         Qmu/NmJgnq7AdShoXOpTNxnOpHhZxrpq+FeVPkNtLHAYFywZ5g80V8ay5brkchHK9Klr
         +QJJTR6hkcB5sXxLbEkjzjXPMoYIwMJMJJvNLrTfRq5s2cFHcX3x1WJFpjaB8Z0GgQ3d
         2S8aMDaklyqtPT4oFDMBKEIm6j3+NXpzqo8eGL9f1AlvbuZGwL27UKbBS1RMAqvfXDW7
         KeuA==
X-Forwarded-Encrypted: i=1; AJvYcCXLU8TIpx6KzcFlFDWm81GsNqMb0j/pZC570R0s+ZR4iGkzu3maQsJ3k9uD7dYKfW2YY1kPCmYGH4djeJ6RnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9wx7xk6fYHaC6tKFsMMBHVp0BXmkT/NfrO8DtAtksVq0IXLt1
	D9FEsdxgqXhZITncEfHBme6po1roH0NgsxF+YKrPZ09Y61Ma/YxMAp9glJMbazSqaywPQ9TxDTC
	jiLo3m4ciEZo+WSsQSXmOTwW2B9NfE8QXoyVYqvlVYZnzpTWiu+k1Lyc4Ie1xafHR5sLtASCikG
	gQVlghgL02YnABixrte3WtPllyXm4Rrr/1l/Af/moDQko=
X-Gm-Gg: ASbGncta6zhQcaLQ9xs3xB+RI09Rdr5thxm2CW8//Gs/FT3XjS7hCjxOA8QZEXMNa5Y
	JvPPI0EBGzszNnJM1cJQHqyK6kErBb61C4FctDbiVJ4GKq+SCwFvYlV+OuCPF11g+sMC2CYDQhI
	7Y06hRIuvKtBnUJmZwdw==
X-Received: by 2002:a17:90b:3a8a:b0:32e:ddbc:9bd6 with SMTP id 98e67ed59e1d1-33b5138408emr32261209a91.27.1760409518573;
        Mon, 13 Oct 2025 19:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWo2mJ/OJVRxxXfZ0wTtK20NpMnbcmMczKNA7M+EwFeHZP2mOQW/Q28ZNj2mhuSiTGeul/i4cDsb6qp4PF9tM=
X-Received: by 2002:a17:90b:3a8a:b0:32e:ddbc:9bd6 with SMTP id
 98e67ed59e1d1-33b5138408emr32261181a91.27.1760409518079; Mon, 13 Oct 2025
 19:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com> <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
 <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com> <20251013040810-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251013040810-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Oct 2025 10:38:25 +0800
X-Gm-Features: AS18NWDKDcpLfi6N1AuOSwJdJOcHa0VoPUyyf3FrzZSA7dT2cKqu6klh5288pTo
Message-ID: <CACGkMEs3iV8kpEmZJzch3jUxZqV5Ff4k51SR+LGKW9sg2WAZhQ@mail.gmail.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yvLDxIACrq_eEayIuabj5Wgc8KNMth1XYAU7Nco54l4_1760409518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
> > On 10/13/25 9:20 AM, Jason Wang wrote:
> > > On Mon, Oct 13, 2025 at 1:29=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > >> On Sat, Oct 11, 2025 at 3:40=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> > >>>
> > >>> #syz test
> > >>>
> > >>> On Sat, Oct 11, 2025 at 4:38=E2=80=AFAM syzbot
> > >>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
> > >>
> > >> Paolo, it looks like the GSO tunnel features will leave uninitialize=
d
> > >> vnet header field which trigger KMSAN warning.
> > >>
> > >> Please have a look at the patch (which has been tested by syzbot) or
> > >> propose another one.
> > >
> > > Forget the attachment.
> >
> > I have a few questions. The report mentions both UaF and uninit; the
> > patch addresses "just" the uninit access. It's not clear to me if and
> > how the UaF is addressed, and why/if it's related to the uninit access.
>
>
> I'd like to understand that, too.
>
> > Do you know better?

Unfortunately, I didn't spot any UAF.

> >
> > It looks like the uninit root cause is on "the other side"? i.e. the
> > device not initializing properly the header.

The trace is in the TX path, so it's not the device side.

> > Would unconditionally
> > clearing the hash info implicitly disable such feature?

The feature is not used on the TX side in virtio-net. On the RX side
(e.g TUN) it has not been implemented yet.

> >
> > The syzbot dashboard mentions a (no more available) reproducer. Do you
> > have it cached somewhere?

I don't.

Thanks

> >
> > Thanks,
> >
> > Paolo
>

