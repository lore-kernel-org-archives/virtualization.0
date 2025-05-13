Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589CB1AB6D4
	for <virtualization@lists.linux-foundation.org>; Tue, 13 May 2025 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747109350; cv=none; b=B+cb+kTvoEUaavMz0T/9qGgKYCfYu75BKyXAo3gEgFKUIWio76kD15CUSKC0HKx6pTFtpGYiI49PKkfW1A06YFh47PtYoCGmhQnssyqcAXDG256CkjNrRgwYWzJS9nvKCw0xpmPAio0eguhr6CyNprcqnAMwiNU6K1Xy+bN3fPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747109350; c=relaxed/simple;
	bh=/7PexB5fSgQlaIRo7HZc5/n/QHKjEqlW3Nl3Mba+2fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WP/IWGDxDXpDu9YryVndfr5O32elCcuQ5dUht4SR8WFBXablrJrqDpTbD0lybLZdSTgGqZtb7gg+2gixBw9ytipt8PqCFzd+FX+y2kw2frs/1cnCIgD7D46hR0YWBcCea0Wu9upj5/Icwh2g37uXbQ9wcdaBigzfzGfIhv5Jivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieFYV1q6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieFYV1q6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0B5881EC0
	for <virtualization@lists.linux-foundation.org>; Tue, 13 May 2025 04:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYbCjKh6NEQG for <virtualization@lists.linux-foundation.org>;
 Tue, 13 May 2025 04:09:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 127F8819CC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 127F8819CC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ieFYV1q6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 127F8819CC
	for <virtualization@lists.linux-foundation.org>; Tue, 13 May 2025 04:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747109346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7PexB5fSgQlaIRo7HZc5/n/QHKjEqlW3Nl3Mba+2fU=;
	b=ieFYV1q6wMxvubB7WWpbCprv9pNx8LueksFHtFLFB3ZJNIH/w3ClxQYwuZZ+EAF7La8WRM
	AXwbNXYog91u/PLqP9TwtCcfp2N63YcsFc9bGUjXOTAiidSeF7/y+r0QgTaR4ADU0FCUbH
	wH/bKp1otwso9VNVVP6TZLMe9Zmi3UE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-pYYVUNkzOgueRSK8nHSU7Q-1; Tue, 13 May 2025 00:09:04 -0400
X-MC-Unique: pYYVUNkzOgueRSK8nHSU7Q-1
X-Mimecast-MFC-AGG-ID: pYYVUNkzOgueRSK8nHSU7Q_1747109343
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30ac9855e35so6600502a91.2
        for <virtualization@lists.linux-foundation.org>; Mon, 12 May 2025 21:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747109343; x=1747714143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7PexB5fSgQlaIRo7HZc5/n/QHKjEqlW3Nl3Mba+2fU=;
        b=O0L3Hz3pIrsfw1X/iyR4HpHiAaF3w6NWFIvS2N1+IwvfoI4ARSPylRdieqVHjVO/0R
         Cgi8jQQk0N7xZ2sbiTvX3l0kHRfJOqW41+9nR0A6ynHh2kyK6qliSTVN3G2YX235hMTr
         F9TZ+w28E6lPrGN6RIHIVO1rkueLlcL5+pYCOh3nvR9UVqqcLtgLDRuDdYDrEmj/q/rJ
         kD9NPgDbscOY1YDcoz1SB71TmZBrq3Qx/bmv8xb8reuPJE6xreH3sUXydK4gFmgo2BVX
         2CsxbpWFIo8f7qyEHLXtNenDGV2jBuCShL3+zQN546A5ANQtuba7EGpMxPEv1CMdzGf1
         YfsA==
X-Forwarded-Encrypted: i=1; AJvYcCWnPhie21pnh7lLafvfbgAiQNyQmPkrcqrtINqAPZFurP4xE44OKJJUDLyQQCdjkkOZteoL46T7xC/mKmHx3A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzdy1yDWPUbTnBAuADYhhftn1UoaLZQ5hAOoE1/qb8bpQ48SoJA
	l0pns4Hf6y66fyvC6/gM/uTsEUx68MDMZPKAaDbKZg3nKOJGtPk65IC50OcyhW6kkHiwfHSpBaG
	F0cQec+Q5yD+wtawGCqcs9CmkxfGXq8qd0LNKEL9Y3+ejLmOZ4CXm4uZXLmlXSs8+5RtdfL390S
	f2ND+TXxkaaUo0kk0+qcc3xfBESJXnQsoUQD1aBfTn6/LUaKhpFQSzSg==
X-Gm-Gg: ASbGncuMdXOKDbYkzARm7BI06vF0zZqrVRYFRRkZjH2GJXHyAYtgbeQu6V0v+mo7+nu
	6VwqttBc/AomGfmIcnsYZt49Bf0DbpVRRaWFJqaJ5Nft1aBrAYeGe47oG4bF0Twq1fQ==
X-Received: by 2002:a17:90a:d605:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-30c3ce0470bmr26232825a91.11.1747109343310;
        Mon, 12 May 2025 21:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyBWgHCft3k//tAxwx54BhvxIyBUdAIfMV5MOII1cMr/aB5z20Oh2o8khSRERHIdevOIlxT4LnUgaV8ZRyza0=
X-Received: by 2002:a17:90a:d605:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-30c3ce0470bmr26232784a91.11.1747109342873; Mon, 12 May 2025
 21:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org> <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250430052424-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 May 2025 12:08:51 +0800
X-Gm-Features: AX0GCFv7w4A3XPsR5LhhGFMy4lH1n0jPjulwvckB7Zf4ezIel8xqf6nhTotZRJ0
Message-ID: <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L1-VgbMGZYxflU8ZA-0ckAAHKq9Vb4PbI85qngrX2vQ_1747109343
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.=
com> wrote:
> > > > > > >
> > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_I=
OCTL`,
> > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` io=
ctl.
> > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the io=
ctl
> > > > > > > is disabled, and any attempt to use it will result in failure=
.
> > > > > >
> > > > > > I think we need to describe why the default value was chosen to=
 be false.
> > > > > >
> > > > > > What's more, should we document the implications here?
> > > > > >
> > > > > > inherit_owner was set to false: this means "legacy" userspace m=
ay
> > > > >
> > > > > I meant "true" actually.
> > > >
> > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > applications need to be modified in order to get the behaviour
> > > > recovered which is an impossible taks.
> > > >
> > > > Any idea on this?
> > > >
> > > > Thanks
>
> So, let's say we had a modparam? Enough for this customer?
> WDYT?

Just to make sure I understand the proposal.

Did you mean a module parameter like "inherit_owner_by_default"? I
think it would be fine if we make it false by default.

Thanks

>
> --
> MST
>

