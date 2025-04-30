Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD5231847
	for <virtualization@lists.linux-foundation.org>; Wed, 30 Apr 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005247; cv=none; b=Aecnwp64RbTN3v6NTaqSjZ93D4Jipy0zGLq4UqI5I+TvoaUG4Ct2IoR0VjrAPNV0+QJ0xA6cTSRUxj8kospPSUezwaSBeSPw/vWQ2fTO0PjQk+KRC8al7JYUZRs7h1z9BNFsF17e6QKc2qzqb2lkCCVre066RfELJzNVEBGlwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005247; c=relaxed/simple;
	bh=BwKXXL3PYQFTRZW+aG7URAo/jaI2DLZtA1xxXzSK0Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sckDXtWE4zDeMCzVikS49od7ZzO0hjBxcHZZct+syFim9w+hVnF0pGDHFkM2s2V9Lm3xw+A1QfXAUiiL7VCQonywkhWM3sc4dAWQXEnWoM+8Tn/VbLqYUA8sF8+5S8kgMltZhIYOmGhpJovYWNDvficmkd3WA0bXoXgFL0a1BPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Af1zBx5q; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af1zBx5q"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5613405E9
	for <virtualization@lists.linux-foundation.org>; Wed, 30 Apr 2025 09:27:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PiRbToFbHS7A for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Apr 2025 09:27:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1EF83405C4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EF83405C4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Af1zBx5q
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1EF83405C4
	for <virtualization@lists.linux-foundation.org>; Wed, 30 Apr 2025 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/eUi8mcDR2dtcgh0sHngZgam7Zp8nuaOnXZ0TH4FZE=;
	b=Af1zBx5qFy4XzxnBfpls9GBJzq84EG7M0/B+Q00ikKrNIP7rHaLrvSbQKNvYq9hrc0pNRg
	JFfwFOYrmaqZDbb92aaHCTwU6U3WwWJLFUc4t21xqHSfUVQDCZeUTI255qUpwZAeJSQKwY
	ysGWX1aMfoKw+FNbH+rBjnWLldcmdj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-2kZon-niNvq6d0TCEOGR2A-1; Wed, 30 Apr 2025 05:27:21 -0400
X-MC-Unique: 2kZon-niNvq6d0TCEOGR2A-1
X-Mimecast-MFC-AGG-ID: 2kZon-niNvq6d0TCEOGR2A_1746005240
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so39393115e9.3
        for <virtualization@lists.linux-foundation.org>; Wed, 30 Apr 2025 02:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005240; x=1746610040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/eUi8mcDR2dtcgh0sHngZgam7Zp8nuaOnXZ0TH4FZE=;
        b=c5haJ1HTnZxaqrzmrBvPskL7t/lfsDUMGFjFdeXhbmZT4eS7HIGeE+aRMM7Nz4c9FO
         FbxZ5kPjzbWkRQTAQEUDLgeQTSPVlaCFP+b6964bXU8UK2I9VojRSxW0OoRPxXlRG8Th
         jT5eTtOGXR74T4DURjxvtYYN0tZelZkiRJKIiLoN7gXjFhm4P02gO0Dm66pnLJB8zed4
         lNsPY0mxIyjyaZfj/6Q51GuRdX+rZU3FXb0KTYMqeAoVxrmJo7i/q0nuiM1VnO1gls5N
         +3x9wcjXFBQF4sSppLGB9AIikLpkj5hN5kcR6MV5DsGvEm8MJZ3O4D+imhVHzpXmKUTy
         PJdA==
X-Forwarded-Encrypted: i=1; AJvYcCUGaFlBPuLEbuzpcPR2Qft8QGdHeQyuu30bvcXMOkL+2HhmMnjOq9E84wpkJncG3KYQTcYwN+IbmyW+eTHsyQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy6QHFicCgxE6ZxSq/w7G5XuWMtf8DhhyLsjvLrYuSy0qUP7hkn
	QUCWQaa5NGTp3N0NVGkljzHFCpPZb2xM5p8J79kSa1DS6crRv9sCVt586MzycEXaSIYrdn0l+Qq
	yPnqUGeAL+rUREdW5VSEa2hpXCdNLnfeC3pVNsh3WXzfh9o/vOgcwy7OHjnncvaorR8qUNzPotm
	f/ar0=
X-Gm-Gg: ASbGncvfVsH9iV/SfXrBsuewfUdVWG0yBOQuA+ZC2WCgRPB9FuYVWSs4bi1tKlAzrSR
	O8+ccpuFWDyZxEMdtXE9n3J7k2pi06N2ngCmsf3w84Hk56oJ0nXY2DoBQ5h8bPEgDN1XO4sj3tj
	PktAg99ZpOvfwfIodLxJj/4t8FjzXdPRKyiOUIYM8DW0Ia/KALggWqbLEy5RO/5//Ke/K572cPn
	zcTFhNxRKEzZvvv2iJDOWaJrA75GvggTA3ChyvKcAI9Zwxuj0E/wLbVOJ7NqyCudB5g9m4jfQcp
	GAoScg==
X-Received: by 2002:a05:600c:1d82:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-441b265a216mr24126275e9.16.1746005240416;
        Wed, 30 Apr 2025 02:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ0vZyPaRC1RprvkAzVN5EJdqn5u6WSue/8vY8l9DR5pd+MaYPUw+ILcM4tYuviqNUNWk6TA==
X-Received: by 2002:a05:600c:1d82:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-441b265a216mr24125915e9.16.1746005240038;
        Wed, 30 Apr 2025 02:27:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ae3ee26fsm40134145e9.1.2025.04.30.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:27:19 -0700 (PDT)
Date: Wed, 30 Apr 2025 05:27:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250430052424-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org>
 <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vdEz-2Ygvi-iZ_Vpe3F0MeV9bfk7aUAxw1L39-y30ZQ_1746005240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> On Tue, Apr 29, 2025 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > > > >
> > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > > is disabled, and any attempt to use it will result in failure.
> > > > >
> > > > > I think we need to describe why the default value was chosen to be false.
> > > > >
> > > > > What's more, should we document the implications here?
> > > > >
> > > > > inherit_owner was set to false: this means "legacy" userspace may
> > > >
> > > > I meant "true" actually.
> > >
> > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > applications need to be modified in order to get the behaviour
> > > recovered which is an impossible taks.
> > >
> > > Any idea on this?
> > >
> > > Thanks

So, let's say we had a modparam? Enough for this customer?
WDYT?

-- 
MST

