Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1644C63
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701400; cv=none; b=U7XoFSVtzgedZV8ua2+o3AsGoNVlpBNGTh3lulKxJ9bQOTecxKdiMeIAW1QijFaQzSrSF4a2tkxXuuKhLnRIskeYvrXNkppsPYz2TobW47NPbXVtBmsuZqhdFbDibBXucv/yzU09fjBLXKbKd2AqbvEEk82gC3IUDxtSrjZhtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701400; c=relaxed/simple;
	bh=iyV5w9cbgt6ZgVOTxo8iAQ4w6DBDgBjEsyMsIZQh/kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=U//Yjb4wlQ1YdAGoKwHD6mQus425unjNkS3MOyjzqb0zsc7bM6mAkfNIeE+wDndnvDLyDezZ60bcnX+x2xNSMem84/xIEmyhAPI4/2f8WV+rq+/phAeucsDDEONu2YsND6Bi5PMVrvICQa/1pTIwaOIsAqiH8CLQhbfetecOii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIaKNLU5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIaKNLU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758701398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkM4oXRVV4nD2vjM2JL+8uqwWZZi2+21i3PZycL5UHY=;
	b=PIaKNLU5Anfh732lj7csOM1LaofINFbc6I4L4Oe0GG6CLB9C8aYy8BXk58JAHurJA7nNWP
	HqudR35Cf7km8ENtqyDtRUw6+emaVNuTrKURA8aXlGY7FqamhM1csDAh6Uv2LTA1mH0Mli
	hgCYyNIqyuO/+9/NsU8MY8F0v83yinY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-Hae7z_Z4O-6v7mrXYyF_kA-1; Wed, 24 Sep 2025 04:09:56 -0400
X-MC-Unique: Hae7z_Z4O-6v7mrXYyF_kA-1
X-Mimecast-MFC-AGG-ID: Hae7z_Z4O-6v7mrXYyF_kA_1758701395
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso4376795e9.0
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 01:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701395; x=1759306195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkM4oXRVV4nD2vjM2JL+8uqwWZZi2+21i3PZycL5UHY=;
        b=hgDtzAIQLYBvyY/pokKz3rP9I5A3J7SYeywN2zWVQpy3sHWKhxJD4JhXktwFQEkfRE
         iHgB8YnYh8EpDA4fVc4YPWvzpuTPguPHoWO0xnhLTZfxGhO7STh7haG1NC/fqdCSZzbf
         8dlCGJ4y3j5VwZ3jq7Hq3nDt/bhhODszXwPDYisHpGI0dvXa1Qg3V2tb7oQFk4/ohNYQ
         3XmkBDq+y++m6kBoQGGlmQUBTekZzZkzaJC69WOGcnabG0Rz3splL7N8K9hBGhDrjl0y
         5t/w0BqUO3/DS32uj/a8hLfe6VJI4xg7i1I4FP+ysnGm+HwiGxS/XAIKfimBmxYsq6jf
         D8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVdgkR3fPj4EU1Vcv7xJidmmewgIeBIFrAOGTHML+aLdZD0B8cteQk9r7uSoqIdfmBYJp1gtFm0h8KSAx2hfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxax60fvxI5K2jRRuO4reDxjAq7afxHlSVwsvPCtG15JXbLSyAZ
	fWuXeOqGOEPkTEksqpCQTpQrhK4wQ6qFkkGo2t1/fe+DRCeR22IbZOZ1QYBEvxDl7trdETclhYR
	dTT8TwyFa5MLaEZ1wf5aYHxZ0JeGcGSGo+blo5R1hmmGEHf+8yZR61bvIIGq5E7Qh5aAE
X-Gm-Gg: ASbGncv73vzn9RforQQbhlv+U6p1kg/22MT9eCFkZHJwvM8c6d4B5m2IigUkAgzNYws
	eGTXRZoIb7fE6JjrV1ufhiVcm0Vja597L0uu64WfxqcvzC2LgSplYD3OUvmwaJLhJYqkGiRRzIb
	Dxo1Z3svnB+7Ac23jwfJySxTsJo+a5TJbcvdtoXRYXOpwkdPG9xkl8/Ctj8ZleQ13mOh4WKacSa
	kwwLZvXyjj5jw3A6ajpRZsUXTRzzTpzScHtyJ7HaOnmOk/fDaKNmgraN8zugGWDA0xRopCBbfsO
	pK4OQ+yaxLzmwNuSo1VTwiaRwbMS4NtV6Cw=
X-Received: by 2002:a05:600c:540b:b0:46e:28cc:e56f with SMTP id 5b1f17b1804b1-46e2b539770mr14433255e9.6.1758701395307;
        Wed, 24 Sep 2025 01:09:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2isQpxZ6pAJzr2vpEkZfoKb5tx8a+WdsYfEl5CDZPv35AgMoMJYvNF0tcDqDtm8H3UIV5Gg==
X-Received: by 2002:a05:600c:540b:b0:46e:28cc:e56f with SMTP id 5b1f17b1804b1-46e2b539770mr14432985e9.6.1758701394926;
        Wed, 24 Sep 2025 01:09:54 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm20213965e9.11.2025.09.24.01.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:09:54 -0700 (PDT)
Date: Wed, 24 Sep 2025 04:09:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, eperezma@redhat.com,
	stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924040915-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org>
 <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
 <20250924034112-mutt-send-email-mst@kernel.org>
 <CACGkMEtdQ8j0AXttjLyPNSKq9-s0tSJPzRtKcWhXTF3M_PkVLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtdQ8j0AXttjLyPNSKq9-s0tSJPzRtKcWhXTF3M_PkVLQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -THUBskAgnXGbqFO-fPZLAjfl8x6I6ZD7_ZhnZyz_MA_1758701395
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 24, 2025 at 04:08:33PM +0800, Jason Wang wrote:
> On Wed, Sep 24, 2025 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> > > On Wed, Sep 24, 2025 at 3:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > > > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > > > > SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> > > > > patch series, the associated netdev queue is stopped before this happens.
> > > > > This allows the connected qdisc to function correctly as reported by [1]
> > > > > and improves application-layer performance, see our paper [2]. Meanwhile
> > > > > the theoretical performance differs only slightly:
> > > >
> > > >
> > > > About this whole approach.
> > > > What if userspace is not consuming packets?
> > > > Won't the watchdog warnings appear?
> > > > Is it safe to allow userspace to block a tx queue
> > > > indefinitely?
> > >
> > > I think it's safe as it's a userspace device, there's no way to
> > > guarantee the userspace can process the packet in time (so no watchdog
> > > for TUN).
> > >
> > > Thanks
> >
> > Hmm. Anyway, I guess if we ever want to enable timeout for tun,
> > we can worry about it then.
> 
> The problem is that the skb is freed until userspace calls recvmsg(),
> so it would be tricky to implement a watchdog. (Or if we can do, we
> can do BQL as well).

I thought the watchdog generally watches queues not individual skbs?

> > Does not need to block this patchset.
> 
> Yes.
> 
> Thanks
> 
> >
> > > >
> > > > --
> > > > MST
> > > >
> >

