Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDE37C93C
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438176; cv=none; b=h78X6Wgi02/F/QeROTi0XCCEiFRRzrdtf41qMyGTlZC9gPIpdkDDXxKyOZe/33CJWu350JwQsqi1NgUW7GV3ZtXsgkfoUk7uBTB7lL28PN1DxvAYTAevJ30bruI43mDMWEoNoQOKpV/pALhq1XMGLnKrR8D8/shkwWomfytfY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438176; c=relaxed/simple;
	bh=ivL+fRFB0SI4FCYqzCCCvnIHn0hdxkIDu8XSrnu613k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XEktuiTqrz7w75sHY4LfRXb0NHQCcRObjmLfPIGZUkOq/l7rFUuAwWMe3VukGDS5f7ugdy87YXqwJLzBhWgWVeC+MijM0T9h525wRG/Y7Imy+vTfq7JHhIUIAbAi2Fum8RChCvyyNy5qWQkaiWatHkLJ80F3SPlYhjbU4p/PrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIycesri; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIycesri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786438172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ivL+fRFB0SI4FCYqzCCCvnIHn0hdxkIDu8XSrnu613k=;
	b=RIycesriTfTg3dlFlTe+K2jhS4CcoVi5c9sWGUpn92qLLTkkumh6h+fnqtZU3hCJYQUuN9
	n4a0DGT9/OzLkSjTBciQ3exF8koNmyqYNtnG3SVP0WtRLExltF+JWcPpgq/7CRnBh1n0ft
	2J5tiJ/+jp4qPnFoXmgxYMjaLPwCcdA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-TE_9rU1wO8e8aiY6Nh4aAA-1; Tue, 11 Aug 2026 04:49:31 -0400
X-MC-Unique: TE_9rU1wO8e8aiY6Nh4aAA-1
X-Mimecast-MFC-AGG-ID: TE_9rU1wO8e8aiY6Nh4aAA_1786438170
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-49d4cb3ca23so700265b6e.3
        for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 01:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438170; x=1787042970;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ivL+fRFB0SI4FCYqzCCCvnIHn0hdxkIDu8XSrnu613k=;
        b=NbgIplP0GxAq18TAUG7BXUK17X3Y3jSnXwm9h/TKl6zhYLHybMk2JzjtRtbTBNo2Wc
         ecz4Z6v/taGANQOnMua+1m5uHtPvo51C000JItZRK6cW852pPsB869li3U2OrEQ7dfiz
         xGLniNccn+WYcK/rk1RoMpyHZI9c0dwrY3oP4YPHWIedqvcMRKmH3CvcxzYmznhhSqEr
         /NNqe4x7tOBdk4xNHD/SPetfZ6iWx53D4xBelC6FWnTDRo8cYwD6ull6uHhx+1Au21bB
         NN4JkuMuVM2SBtk9PLM1Rvt6Micd/SG7R5gKp0NbnJ7R+32UbRNeTThwtj+ezUe5iJHV
         7l1w==
X-Forwarded-Encrypted: i=1; AHgh+RpXfbt/98C1nZkvz+W8XGc3ch8e0CAUp0yaqFaot2eV5WiJgisGeLy4NPkv42zsbro+rMwE8K36CCQeaETu0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNZULaKQCiBnRM3ASuGtalSEQfPis/PfzF5667TJSV6zFsH4EI
	aC3mtYFEBsLnsSoUuUGqtzK2VWY/tYSWvoDP1FxRianFIWhcHjg29U7H3d+AuXfcWIB6ocT3WhU
	QaeI1P2u+Ts3IND50bJcIMdHoj4ikkP+//aHeZ4gc7LlcF4ntx62nD1E55hdVA+VQbKrzNZTTsp
	8+v1PzhVjtFVfaFEz4dkgB5TGrM6zKCpPEbLJRlEz3KBA=
X-Gm-Gg: AR+sD10ID/RrATwgBJ2s1wlk4O7qNpX1KpyE5oRwzKlBu8M1LHyaM4CveytE95OmQnf
	g1FIgaEgCnxPyFdH+t+h79zG2BDnsHUm9LPgjU+2+m54WvzR9bpB0hmbhkittnvMSWKrp9MNf4B
	sX+1LdqkfXu2fJMg0EQMxH4eMwtapeuAOzEG8Kq9yY2d5KgM1q+PLSTXvwNnqLJj2GTvkQ2VjNg
	dLtaWqnV7rMG/5QewN6JMtQGPfhM/RrQm6ta9W7so7heg==
X-Received: by 2002:a05:6808:30a1:b0:4a0:6d4c:7cc1 with SMTP id 5614622812f47-4b1fd268fb6mr1261336b6e.0.1786438170472;
        Tue, 11 Aug 2026 01:49:30 -0700 (PDT)
X-Received: by 2002:a05:6808:30a1:b0:4a0:6d4c:7cc1 with SMTP id
 5614622812f47-4b1fd268fb6mr1261306b6e.0.1786438170085; Tue, 11 Aug 2026
 01:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Dorinda Bassey <dbassey@redhat.com>
Date: Tue, 11 Aug 2026 10:49:18 +0200
X-Gm-Features: AUfX_myup5Cn7XHNiGhYWSQ_DXHMKD_bon7ysZ5L9_VfRayW5JmQ-J3z0cr4fPg
Message-ID: <CACzuRywJFBi8VS9iLNFABgNvjK1_cmYLzdjwjBXdZBggFr1SWA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] media: add virtio-media driver
To: briandaniels@google.com
Cc: acourbot@google.com, adelva@google.com, Albert Esteve <aesteve@redhat.com>, 
	changyeon@google.com, daniel.almeida@collabora.com, 
	Eugenio Perez Martin <eperezma@redhat.com>, gnurou@gmail.com, 
	Gurchetan Singh <gurchetansingh@google.com>, hverkuil@xs4all.nl, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, 
	Michael Tsirkin <mst@redhat.com>, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: qL6tttGKBMSMN4-NjwUTkyFyT-qsf3ezoxwS5czW3n8_1786438170
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

I've been working on a vhost-user frontend for virtio-media
in libkrun[1] and tested this series with vhost-device-media[2].
A few things I noticed:

1. Wrong constant in vfl_dir detection in virtio_media_driver.c:
>
> + if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))
> + vd->vfl_dir = VFL_DIR_M2M;
> + else if (vd->device_caps &
> + (V4L2_CAP_VIDEO_OUTPUT | V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE))
> + vd->vfl_dir = VFL_DIR_TX;

V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE is a buffer
type enum, not a capability flag. So it should be
V4L2_CAP_VIDEO_OUTPUT_MPLANE.

2. Kconfig architecture support

> + depends on VIRTIO && VIDEO_DEV && 64BIT && (X86 || (ARM && CPU_LITTLE_ENDIAN))

ARM64 is missing here, so the driver cannot be selected on
aarch64. Also, CONFIG_ARM is 32-bit only, so 64BIT && ARM
can never be true; that branch is dead code. Since the driver
has no platform specific code, this could just be:

+ depends on VIRTIO && VIDEO_DEV && 64BIT

as it already covers x86_64, ARM64, and any other 64 bit
architecture without listing them individually.

3. Error sign convention:

> + resp_header = sg_virt(sgs[out_sgs]);
> + if (resp_header->status)
> + /* Host returns a positive error code. */
> + return -resp_header->status;

The comment in the driver and the protocol spec contradict
each other. The protocol.h describes the status field as
"one of the standard Linux error codes" without specifying
a sign. It's probably worth making the protocol spec explicit
that the host returns positive error codes to match the driver's
assumption.
[1] https://github.com/libkrun/libkrun/pull/811
[2] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-media

BR,
Dorinda.

