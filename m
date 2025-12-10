Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7230F922
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765347862; cv=none; b=aWR3iWJnzva8qVbX6vp+kUdAFbxcNlhytGMWgyBF4PsQql/zRjP/QehBqwUugV6LuVPRsdSrbCKnxMt2x7p7A4ucHlN9VGle4Y0IoRPheTqjz7UoTjBXYIomJ5k/uGv8JxnWQD6gXJdUORBw+2udPVoHXu/AB9OwseCW5KyfPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765347862; c=relaxed/simple;
	bh=4NrEHdEgJFC9TiCltfylkJScH6qDpAKCXibhQlh+2II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3jks6q391Vq4CZ55MOTiyXtJ3wizZzDMIfNKUftyAZjVGspUC9/e576114YJrY7VIX+U6ZLYhuSyKlt6eWpfoWES7w8DLOoDPTe4nT1sZ4rKH/kIlvvoFComVDCqrB9AQG/0P5JCe7AvB/AAd8CTS6eyZ2M2+c0OlcemNB+HxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKKRwLO5; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKKRwLO5"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C8F240A26
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 06:24:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ggTpE1341jb for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Dec 2025 06:24:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 16CC140A0C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16CC140A0C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BKKRwLO5
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 16CC140A0C
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 06:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765347856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Abfyp0Ksn4bRXpXEGWpTf0Yy+rzwJNTHZv0yfgCDNLs=;
	b=BKKRwLO5hFlCAi0ALb6IDG4AxV1iXHwBMCfPwGxEcuApxgHJ1JYdjgQOXZm7HgLIlv0Jqy
	M1NmXjnQJgEmSak7bOQEdUKL8SNm1wKyzPEH6uZeuYUzVSsijquwXx3xL6ehoO0f7YTddp
	eUlcT1o6VICGw1SXC3dOfp+CBB8FyFE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-hldv0tYROTWYWEPqD2Uazg-1; Wed, 10 Dec 2025 01:24:15 -0500
X-MC-Unique: hldv0tYROTWYWEPqD2Uazg-1
X-Mimecast-MFC-AGG-ID: hldv0tYROTWYWEPqD2Uazg_1765347854
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-341aec498fdso8279836a91.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Dec 2025 22:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765347854; x=1765952654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Abfyp0Ksn4bRXpXEGWpTf0Yy+rzwJNTHZv0yfgCDNLs=;
        b=fQkgInm9J26u05QaYp4m6TxZrSqpRu/YOHDuAzDVXrafIzopAxyWOx6ufU0MusH5xd
         mDHQh5cHkuT2AQ3sPwGi2qeeMPBTV3U+sC8fgqSY2DBvaEuerqkbfAdGykkWQiZuwjux
         O5x8fbYaeQGIfGZXOv0aGkt2JvBLLNbHMNvdLlvpes6cw28yoWrlGSQPoX51U5cKm+5C
         pNKUJVf13hdn7HZ4SUXNHjff2oJpfwg227qta8OF4D92Kx3qHY+ZemXyWjMc17xQ8JkI
         AxMb7KqaJADkHTRS1b0SNZjZRXTfow+axp8hjprovYuoKMlEf+fL6YAO7kfMhYBpAdTV
         wDdA==
X-Forwarded-Encrypted: i=1; AJvYcCVQzjdz/15/0pdWKkA+e0PjayiO7Wfzu+bAPCIqTMMM4WCIq1LSX/pwpVprkEodYJduQEKCqJd2YAv9RDNXTA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YynRVO3L1FbuHuIfIzNo2XR30vmuORvt2Nmz0exYQ2cWU5l69rq
	UNCQKV3hfqLF0fcPHWQEijmVqVjOVXgD8EPvcApMMZeEkwr/HzRPyYus4lEf5ig2JPgvh+0owwi
	4+vEwwEwoE7L15BgpWyrYuaQ1xKBAL+hYkZ2U/v3sI/Qw5Z5lBRtekWENXgg2DjF6nFNMiIhn1Q
	dmUhcUaC165pHfqIHXySi9Y8Jg631r5QvaRYsQCK5I1N47QcxvUhZbXv5rPw==
X-Gm-Gg: AY/fxX5J9U+/jvVz35LAe5V0MtfKsEjIYXu6AFtjULBi/MrB+AjdOu6iPYiVmEx4cK9
	/K21woUCdTkFPFCXR2nnJJ4JEfAazByPX4wHbyMK4VfHqx4mMlOtZDWCTsYh0ok7ywtoR8JkpBs
	qG+oihIIDxlbsxlQlLJJz5HnmNUnyMnPUmbBmLCUmv8FvD4EtD4ANen77XxWU70Kjmmo4=
X-Received: by 2002:a17:90b:258b:b0:340:5c38:3a56 with SMTP id 98e67ed59e1d1-34a72868dc0mr1434380a91.37.1765347853985;
        Tue, 09 Dec 2025 22:24:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUGlpayx8NvYwhfSTCf8sTpVctNs0AJYlojJvqtRw0ijUtKXQrU+h8fAqi7kNZVUnkslgQGgRczajEKoLNJQU=
X-Received: by 2002:a17:90b:258b:b0:340:5c38:3a56 with SMTP id
 98e67ed59e1d1-34a72868dc0mr1434363a91.37.1765347853519; Tue, 09 Dec 2025
 22:24:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1764873799.git.mst@redhat.com> <20251209080926-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251209080926-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Dec 2025 14:24:02 +0800
X-Gm-Features: AQt7F2rX5GnC0R3-0fOqA0ux8dw3Mjrw5YuzA3GI6_2N24NDpp8gvAePXboIAKU
Message-ID: <CACGkMEuFZHgD8Shq6w_QfKYh0p3w8pfhY2mw_+ieQv0U14d8NA@mail.gmail.com>
Subject: Re: [PATCH 00/14] tools/virtio: cleanups, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aowB1sGet8jS9Bxd3cKZ-kcFauzBcynnjc2L9FxYma4_1765347854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 9:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Dec 04, 2025 at 01:46:01PM -0500, Michael S. Tsirkin wrote:
> > Recent virtio changes brought about build errors for tools/virtio,
> > as usual. I did some refactoring to hopefully reduce maintainance
> > load going forward.
> >
> > Adding stubs is tedious and seemed a perfect fit for cursor -
> > so I used it for that, then rewrote some commits and accepted
> > others.  commit logs I've rewritten.
> >
> > Found and fixed a couple of minor bugs while doing this - that
> > part's all mine.
>
>
> Jason, any feedback?

Looks good to me. But I wonder, it looks like synchronization will
become more and more a burden in the future, I wonder if it's time to
switch to using uAPI instead of trying to reuse kernel virtio core to
test vhost?

Thanks

>
> > Michael S. Tsirkin (14):
> >   tools/virtio: fix up compiler.h stub
> >   virtio: make it self-contained
> >   tools/virtio: use kernel's virtio.h
> >   tools/virtio: add struct module forward declaration
> >   tools/virtio: stub DMA mapping functions
> >   tools/virtio: add dev_WARN_ONCE and is_vmalloc_addr stubs
> >   tools/virtio: add ucopysize.h stub
> >   tools/virtio: pass KCFLAGS to module build
> >   tools/virtio: add struct cpumask to cpumask.h
> >   tools/virtio: stub might_sleep and synchronize_rcu
> >   tools/virtio: switch to kernel's virtio_config.h
> >   virtio_features: make it self-contained
> >   tools/virtio: fix up oot build
> >   tools/virtio: add device, device_driver stubs
> >
> >  include/linux/virtio.h             |   2 +
> >  include/linux/virtio_features.h    |   2 +
> >  tools/virtio/Makefile              |   8 ++-
> >  tools/virtio/linux/compiler.h      |   6 ++
> >  tools/virtio/linux/cpumask.h       |   4 ++
> >  tools/virtio/linux/device.h        |   8 +++
> >  tools/virtio/linux/dma-mapping.h   |   4 ++
> >  tools/virtio/linux/kernel.h        |  16 +++++
> >  tools/virtio/linux/module.h        |   2 +
> >  tools/virtio/linux/ucopysize.h     |  21 ++++++
> >  tools/virtio/linux/virtio.h        |  73 +--------------------
> >  tools/virtio/linux/virtio_config.h | 102 +----------------------------
> >  tools/virtio/oot-stubs.h           |  10 +++
> >  13 files changed, 82 insertions(+), 176 deletions(-)
> >  create mode 100644 tools/virtio/linux/ucopysize.h
> >  create mode 100644 tools/virtio/oot-stubs.h
> >
> > --
> > MST
> >
>

