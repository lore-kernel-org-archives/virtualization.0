Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6C27703A
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765350114; cv=none; b=rrMtorL7Y1J6BYUp/954AqVO9Snw1n+QC77IwVStpzswPrKefYdraIDlyoSyJn2oSOZ8uMsDD5lWplCL6Dq8cCm6gsW+9nHA4qb16Oa/tk4P6wlVXhGBhr1Se9AwEfRzwi4BGs5s26sHg2Jqwv37Cm4VRitcTz1Vzox5AGFkgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765350114; c=relaxed/simple;
	bh=gibbgAxI7cZAdCz+ugRHbf3iB61X+HkRWsWttHJKwbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uuCnrvV9EepPEOM/Bzw4MmjNgaCISK7ylHh6LgLwDe/v7Ol/+N+4TYduFq2x70GY83ucJ82m/dvK+2Rbe4i/2qlIqAxAXwv/M2Xr58IaWnqQIo2H6g6rpUNkIUamBzX9E3EPfaZuEVkYnIzfmqHHpzdLid6Zz+nqwf0fEzrerWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4TbrSG1; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4TbrSG1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DFA184885
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 07:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_sVDWhp5nDo for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Dec 2025 07:01:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 57A4684883
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57A4684883
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D4TbrSG1
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57A4684883
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 07:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765350105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zX/e8bRTTjVFt97WaH+e1WJ6OfAsE6amXFqYYu2rFLM=;
	b=D4TbrSG1gzU5pFYxnbJs6xQaL3nvVi7rm1BvmKo3qJxE7+itf5JKUXhsElOCYIvNjpgI9k
	RbWHQw7sRfBiJ+Td5/tZaDEOM12yamFiFSs5OTp1UZccy7nZOGxitC9dsAkcnBukDgtpUQ
	69KaWyAdmNIM5yHapKJLXmNLlvf2knQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-SMGuelBaPrau-gbf1LsUTg-1; Wed, 10 Dec 2025 02:01:43 -0500
X-MC-Unique: SMGuelBaPrau-gbf1LsUTg-1
X-Mimecast-MFC-AGG-ID: SMGuelBaPrau-gbf1LsUTg_1765350102
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47797caba11so29769545e9.3
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Dec 2025 23:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765350102; x=1765954902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zX/e8bRTTjVFt97WaH+e1WJ6OfAsE6amXFqYYu2rFLM=;
        b=EcBM6zGBwubeHAPA5Ln/e4yS/G3Zl43Qp5s7qi1hzaCdnChQ7TaHoWK0+Wh/7R3tuk
         FmPu7lvkd8tmq822wxiUZ2Em0MP6gTuj/Smqi+YXxtDsklK/fKLh+RFo0113uWLeZVH5
         P/UJblGO7edBW6Q8ahvZ35EiojhZi3Kb3ugTTN0sbpL48dZDbUlYrx66NPCSwLjE6qNU
         M/8KQmWZX9yf4EvDswoAPpQKY2YkaHjY5V8UamwstXxRiguML0l/jYkGmjiW7GDWYg0b
         fT5V4eScM/yFGWHcc4x+Q4xTPd9INL3HPVFrtEcjXUEZZuS2Wal4mMwfZn1tZDTQw16V
         tEug==
X-Forwarded-Encrypted: i=1; AJvYcCXO4Dp06qbwthfRG+pNmJauNvYz3Bc20FLF+ZdhUXg2CsS/pNHBIaMNF+x3ipTGF6G+Bps4ieU/obc18XPUww==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywmgzlr71VFdb8+HY1S8p8uTnxwlca5sHNv+4vV85NawJ1bXkt4
	R/Gr3xzoueS6rNunySOuyjAynnswZ7xTm5EROi2DVEnhqjZx64+M4ma8A7OeT4CR/CqFJB2eVMG
	pBU7OFpnz/eDYMwlx2FfSwpHY0EI/CEwh+VJ5l/KBoMxkzW6S7Lj7Qu8I49LLyztPg1zHQwRxiR
	TnSpt1URE=
X-Gm-Gg: ASbGncs0Qu+cK8Iy7Kdeo24+HyWyUe86xRUDj83qup3PNMxF/Kupxu5Qat79U7kkMLz
	B3ELNFFmhNQiwqWkth+t0IuR+tUBYZEK42G1RZwUqsK8w2JU+VTt0wqMt8fngxMuy5Xd93n2HE6
	LQ3lNmHDD6ofM24hOpmjvISy5vzatkFtIEoIhqinpB7c0Y8ySScM9eu3vQ05ch1QMBEdHxCKkNV
	1V8NhvmgRqkpngZLO48INhq/u4lZpTiC6V+n7N93zxT7jIod3Y1rnaiO6FaJUIiQGYJV6LkvuQS
	CeP29aM9OjbaJ8i4ck1VWmsUPe+b8QE7pG+Wm/dfCMDHRDVOqGxheT8lTkM5k21gml6emj/oVxB
	PfftfB9WtgQ+eXKu8fqYQira0F/uMgq8=
X-Received: by 2002:a05:600c:1c93:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-47a8380ca45mr14384195e9.16.1765350102352;
        Tue, 09 Dec 2025 23:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqmrQ6MzJUQ/LqJShkvMtV8AofINZuLnCxqbR6YZxwtI2MI+IWASHHwvubI2JNq7YbkXKiyA==
X-Received: by 2002:a05:600c:1c93:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-47a8380ca45mr14383755e9.16.1765350101819;
        Tue, 09 Dec 2025 23:01:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-33-27.inter.net.il. [80.230.33.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d2734fsm27508565e9.6.2025.12.09.23.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 23:01:40 -0800 (PST)
Date: Wed, 10 Dec 2025 02:01:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 00/14] tools/virtio: cleanups, fixes
Message-ID: <20251210015855-mutt-send-email-mst@kernel.org>
References: <cover.1764873799.git.mst@redhat.com>
 <20251209080926-mutt-send-email-mst@kernel.org>
 <CACGkMEuFZHgD8Shq6w_QfKYh0p3w8pfhY2mw_+ieQv0U14d8NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuFZHgD8Shq6w_QfKYh0p3w8pfhY2mw_+ieQv0U14d8NA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E2-FYNcgWbR8S13Ws6awO8pu1r0Ld-V4FhQ1BArgTwY_1765350102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 10, 2025 at 02:24:02PM +0800, Jason Wang wrote:
> On Tue, Dec 9, 2025 at 9:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Dec 04, 2025 at 01:46:01PM -0500, Michael S. Tsirkin wrote:
> > > Recent virtio changes brought about build errors for tools/virtio,
> > > as usual. I did some refactoring to hopefully reduce maintainance
> > > load going forward.
> > >
> > > Adding stubs is tedious and seemed a perfect fit for cursor -
> > > so I used it for that, then rewrote some commits and accepted
> > > others.  commit logs I've rewritten.
> > >
> > > Found and fixed a couple of minor bugs while doing this - that
> > > part's all mine.
> >
> >
> > Jason, any feedback?
> 
> Looks good to me. But I wonder, it looks like synchronization will
> become more and more a burden in the future, I wonder if it's time to
> switch to using uAPI instead of trying to reuse kernel virtio core to
> test vhost?
> 
> Thanks

Nothing prevents you from adding more tests, for sure.

UAPI - will likely not get us there. But if you have the energy to
add selftests, maybe.

> >
> > > Michael S. Tsirkin (14):
> > >   tools/virtio: fix up compiler.h stub
> > >   virtio: make it self-contained
> > >   tools/virtio: use kernel's virtio.h
> > >   tools/virtio: add struct module forward declaration
> > >   tools/virtio: stub DMA mapping functions
> > >   tools/virtio: add dev_WARN_ONCE and is_vmalloc_addr stubs
> > >   tools/virtio: add ucopysize.h stub
> > >   tools/virtio: pass KCFLAGS to module build
> > >   tools/virtio: add struct cpumask to cpumask.h
> > >   tools/virtio: stub might_sleep and synchronize_rcu
> > >   tools/virtio: switch to kernel's virtio_config.h
> > >   virtio_features: make it self-contained
> > >   tools/virtio: fix up oot build
> > >   tools/virtio: add device, device_driver stubs
> > >
> > >  include/linux/virtio.h             |   2 +
> > >  include/linux/virtio_features.h    |   2 +
> > >  tools/virtio/Makefile              |   8 ++-
> > >  tools/virtio/linux/compiler.h      |   6 ++
> > >  tools/virtio/linux/cpumask.h       |   4 ++
> > >  tools/virtio/linux/device.h        |   8 +++
> > >  tools/virtio/linux/dma-mapping.h   |   4 ++
> > >  tools/virtio/linux/kernel.h        |  16 +++++
> > >  tools/virtio/linux/module.h        |   2 +
> > >  tools/virtio/linux/ucopysize.h     |  21 ++++++
> > >  tools/virtio/linux/virtio.h        |  73 +--------------------
> > >  tools/virtio/linux/virtio_config.h | 102 +----------------------------
> > >  tools/virtio/oot-stubs.h           |  10 +++
> > >  13 files changed, 82 insertions(+), 176 deletions(-)
> > >  create mode 100644 tools/virtio/linux/ucopysize.h
> > >  create mode 100644 tools/virtio/oot-stubs.h
> > >
> > > --
> > > MST
> > >
> >

