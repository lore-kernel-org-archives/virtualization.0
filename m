Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832131E32D3
	for <virtualization@lists.linux-foundation.org>; Tue, 29 Apr 2025 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898001; cv=none; b=IbQ4gvgvQnjopVSQOM3j2eV9bWQANiv+NAXP4EkARVAZC87h/KyfYRlJzs5/kwceL59kQSWSe9N2+k3/38dO0IfRNF/gmNAQia/2ubwMxlxzBKDnRKfNhe9mCgQOAXJWBiXRJ2cj/QZGbeK6wCWKSAwFo/+r3O8omyqpMA00/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898001; c=relaxed/simple;
	bh=CZ+mWcXOnoNmB5QyyZZqqFpy5PLSEtLDvf2WP/DW33Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HypyrogtN1plBeynxmqNb/LKi+c0Y+9fBxbmgAFjNXduy8AOJf4xYn9jCo9ZZIfPNW7zliGJaX3xfIJXsu4CikK9T+wBACh+XwvCcA2B3iHtSBoYs5vmnZIo4EKwY2cJV8b/W9OJcnakrXq8cQFzgECAGRWRcAzXCXrU6SeSV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIn+AQLy; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIn+AQLy"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08025811C7
	for <virtualization@lists.linux-foundation.org>; Tue, 29 Apr 2025 03:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlVfJoHJkZ3U for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Apr 2025 03:39:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 290DC811C6
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 290DC811C6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gIn+AQLy
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 290DC811C6
	for <virtualization@lists.linux-foundation.org>; Tue, 29 Apr 2025 03:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745897995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZ+mWcXOnoNmB5QyyZZqqFpy5PLSEtLDvf2WP/DW33Y=;
	b=gIn+AQLy80PwDrB+bv19UfjaZQMIK51cnBHNBoFmFO4ppiN0witAB7pt4uhDCiE/mdr15B
	Npi3iMsperwLYsaQOKLO+3aymh10GX4MqRNpEjBR4IlgkU6CTLgwbg0y98Aexalvw6xMVu
	+Y+djDotLGOCiOsOYvAcopaRhL1BctI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-WMdtrDfEO56DS3xSPewITA-1; Mon, 28 Apr 2025 23:39:53 -0400
X-MC-Unique: WMdtrDfEO56DS3xSPewITA-1
X-Mimecast-MFC-AGG-ID: WMdtrDfEO56DS3xSPewITA_1745897991
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30a0a8ddcc4so2459679a91.3
        for <virtualization@lists.linux-foundation.org>; Mon, 28 Apr 2025 20:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897991; x=1746502791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ+mWcXOnoNmB5QyyZZqqFpy5PLSEtLDvf2WP/DW33Y=;
        b=c4O+5F9/ZgINUcg6UC7BhglkkSHvcUq5N3web28yPSbk9pXREjyN3s3neEA0iaB4uE
         QYW1neSZrpjNap7DYlxewr8IdzdNG1xKFi2Hvc1fA7m8/l9bSsJpLbxR/uhw7kL7/5aj
         z0vU/IF0OvcOocDraDI+ScVwKAHZ4DflLt28fSFfSjFBn+3AXyPabdnWj7hnvi9loWPA
         bDF1fUbrVWJsdjCMDMgBmeI4860Y0ICiveprYNHp/wBpmcHdoQwIjSIFzUbqmPIG/m6m
         m9zD1lhdHH0Rejd1iSUoUTNx0FhWuzJjeGdKmNuOWKO1JPZXbgOySoDro1zff+rOQ+0z
         n7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4hs6LWJ6GTJ61EDr+gqs8BcTHRvuT1fHdPaICvyGhSDFwpLSuxpRWmBnitcWFtKZHt17mVoCNSq7EcPep3w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzMQiG5G0ZWtn4nvkmb23MRUEHdq7uGUm/SkmNfMkhm+pEaRyKG
	Fp+ze0pZK6LZeA3J/eKKJc4fhaFUDR/CNAasfMyn7a2kTnkAsRXEZeAKwzkd/qu5cCagN6uhzHg
	Uchi803rhyV9iyrKJ7CdJhuGRwVCTVxH5zsBO1iG1Cn6yBe02GrxwEfD1zo4hRnJyCSNkGxFySh
	ZywY37AIsclMMLqjcGbbU7GfhmOZ4Zz0qJ3u0KDHn342MBwwgAeHZL8g==
X-Gm-Gg: ASbGncuOiONWKbc3VV9EiG/quFBdnQWjp0r3UC1x/yfEo40uX1gB/RNui0NRKkg+csN
	CgJQLep3dso0Lj3SJZ3Lti8QkSFZ1LPqtCLMP/fu2Ssoq/IkKBRwr8ozeuR4k3GsaUg==
X-Received: by 2002:a17:90b:4cc4:b0:305:5f25:59a5 with SMTP id 98e67ed59e1d1-30a215a9e6cmr3195103a91.35.1745897991093;
        Mon, 28 Apr 2025 20:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO25nt6hV3dV111j+arayWq9RJrat5QwpIGcVcLMQhppu+t5T6cKy8dvsGeNPzrwkLvZvBpyPz/UcGeHutQWE=
X-Received: by 2002:a17:90b:4cc4:b0:305:5f25:59a5 with SMTP id
 98e67ed59e1d1-30a215a9e6cmr3195076a91.35.1745897990674; Mon, 28 Apr 2025
 20:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com> <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
In-Reply-To: <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Apr 2025 11:39:37 +0800
X-Gm-Features: ATxdqUEwpamsgyJSROjElXTifDP9gzLG-yrcg3CrQ8683svXB8ELNH4GnXFNWQM
Message-ID: <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: mst@redhat.com
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x6UZwH8QPH0jr44EuRYYmQmmWrTat8ChLKdUrdFpgHU_1745897991
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wro=
te:
> > >
> > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > is disabled, and any attempt to use it will result in failure.
> >
> > I think we need to describe why the default value was chosen to be fals=
e.
> >
> > What's more, should we document the implications here?
> >
> > inherit_owner was set to false: this means "legacy" userspace may
>
> I meant "true" actually.

MIchael, I'd expect inherit_owner to be false. Otherwise legacy
applications need to be modified in order to get the behaviour
recovered which is an impossible taks.

Any idea on this?

Thanks

