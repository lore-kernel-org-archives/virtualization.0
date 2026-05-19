Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B93DDDBE
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177641; cv=none; b=ihPPHn9I91HFW1i/y8Ic5y+NX1jdyMgnWfRqlmIpZ9hL1x8I1fUtwgoTSbB6odfkPduRhOqrAsu9F2hZPS7u+gxLxLjbR4ubJNcviktbOz/ERZtVtqSxNWIgDEj0borhAyr8aK+4+jm01ZdJlp0QONT2UFVm73VCfEYhjsLb4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177641; c=relaxed/simple;
	bh=3d4rILdlilDFDSw76hiIyNlmPop0Z7DV66rhMlxLZi4=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=ha6PmH3Hn1tKVTErYtLngZhh4FjCtSEbIH3pjzJqmkPCoG4XLz6SoVEEiLUO4Pkilqrrm0H2o8QkvG+7HjhR4iXz+gjgrC5ESfCsftmiu7fbrgskn64lX/1CPXUV7BCFv74e8WS5zPtFbwr8fFMFpJs5qkOPtRjzsGQZ19hTJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDTiDwIH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDTiDwIH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779177639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=3d4rILdlilDFDSw76hiIyNlmPop0Z7DV66rhMlxLZi4=;
	b=IDTiDwIHQW8ZjVzFv2ZS2kAV/E4T6nRSFHDr+5tKfC8pczz+zUCHJ+Eb1gJRtELRbuCyaE
	o/qQbnyx8c3XvMIwfETAQFEWL61g8aiowGXC3AXhT6Cp7ZIP/IcCkdtVQTpPEGCq1QmJZ+
	efRCiGvWKfI8q4BzTQYDpsR0wfy0PqQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-fOu2KWo4MriBjUKxlvNMNA-1; Tue, 19 May 2026 04:00:37 -0400
X-MC-Unique: fOu2KWo4MriBjUKxlvNMNA-1
X-Mimecast-MFC-AGG-ID: fOu2KWo4MriBjUKxlvNMNA_1779177636
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd6aeb3637so84659105ad.2
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 01:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177636; x=1779782436;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gE08M1SuyC2hJeQGP9oQiMi2Xo7VgIAhPzD+PrSXSZY=;
        b=JltnvkqMr5Cw/8wi1fYmlV0Mfo/aGzRmd0sBNKeJfErUWl84wjqqcFR241K5i3BsU5
         IEPqzZZRyEmuWRGVoo1RRNPOt9Zr4MeSKk5F59u3eWAbOCxZT+lTPXlUXnLKgVIOYQK+
         qPDFGU7pIOmzBmadPbJ7b7usDNqLY6rkzshRu0SYk70QvnIiIhJK37zAr/47V7FY5n6K
         dRoHKvHe1o0KWG5bGJUOSshKaNtUnB8dI5RkvtvryyXxBJOU+eQSb4ktqdd52htM6O2e
         598UmU/P9jOxkPSgrcjdpxCiTs40k+WsoMjQYC2jFrfMPPNOrmpdhlBkN5LV8ZfSFHON
         V2RA==
X-Forwarded-Encrypted: i=1; AFNElJ9dzDJ25FQHZgjo7fZcs8WughZqP7iE0p3Gb9rRT6ns7I2n+njTlcjtdPi+/5Nys6fJ7uXTu2m4xJL82jlYaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF9v4bMJOF2FD4nNLNQuVTTR8fgROxJwFL5VxQey2lCLaTqN+g
	K6+gNoZSs3pf/zXe0i+3tHAi75D0+s2ZhELMwH2JlMaFeg9f6P9YJccN8863pZx8NCyhQX1m0qG
	qVQtkh3/4nyqR4O9E9w8eu3Y2mS6Sv5FSdHm27Anzpg32ytoAacf6kiDUEKIbBp8Nzm9R
X-Gm-Gg: Acq92OF1S3VaE/OHvTrvqJ/LfTSY6A/4WFYIDWkdTR+80qKHkC3AfpLPEqCq6ViTqPE
	dtJPdiF+G7idt/84jmL1C+Phi7V5zpHHOm1+TmoA3MeRgiGqF60r9xpxUpdYduzVj7rfUNK9+7M
	47El3ByutgI3gGC2hsKxdNQ5kubeCvdtWI/5FueBi1mdiQRSmYus9Xm8QC0Dl2nQzSAyJ2rlTJT
	vLpraeAdtq9TNpeOYr0Ps+O1Do18snsp3o+c0y1kNH/HX2AUcYJ18svhUGFfpxNbVFldnUi7KD4
	4440OHMbmRjUDHhwD8NLc4SUnbh0PdTe3BbXF+qZ0aXTfUUczflpl2/fF560LEeyLIB0/bupDLX
	zaHgIGC2gbmrO+2MB/3HVPFQHPvRn9tMTuiAb+q+wAagMkfII0mPagfwqaCQ=
X-Received: by 2002:a17:903:1b70:b0:2bc:810b:5c0c with SMTP id d9443c01a7336-2bd7e8cbd1dmr212913155ad.34.1779177636014;
        Tue, 19 May 2026 01:00:36 -0700 (PDT)
X-Received: by 2002:a17:903:1b70:b0:2bc:810b:5c0c with SMTP id d9443c01a7336-2bd7e8cbd1dmr212912815ad.34.1779177635540;
        Tue, 19 May 2026 01:00:35 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49a4sm161905065ad.38.2026.05.19.01.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
	"David Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>, 
	"Gurchetan Singh" <gurchetansingh@chromium.org>, 
	"Chia-I Wu" <olvaffe@gmail.com>, 
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
	"Maxime Ripard" <mripard@kernel.org>, 
	"Thomas Zimmermann" <tzimmermann@suse.de>, 
	"Simona Vetter" <simona@ffwll.ch>
In-Reply-To: <70e966d1-ca74-4f5c-8527-9e34ffe19095@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
	 task
Message-ID: <18b0e8a0fd7e47ff.9be20be20a12ad9a.4495158120858bb1@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Tue, 19 May 2026 08:00:30 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ziISpbJuvRQ1alco4Vdka4fOdL5X_j4PJbK2abfAdz0_1779177636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the suggestions.

On 19/05/2026 09:11, Dmitry Osipenko wrote:
> On 5/18/26 09:45, Ryosuke Yasuoka wrote:
>>> It may be acceptable to have wait_event_timeout() in a loop, printing
>>> warnings about unresponsive host.
>> I considered this approach, but it does not solve the recovery problem
>> described above. The guest would still be stuck in the loop with no way
>> to remove the device or shut down gracefully.
>=20
> Could `system_state !=3D SYSTEM_RUNNING` be checked in the wait loop? Thi=
s
> may allow to handle system shutdown, aborting the timed out wait in the
> special case.

Instead of checking system_state directly, I'm planning to add a driver
flag (e.g. vqs_released) to struct virtio_gpu_device. The shutdown path
(virtio_gpu_shutdown) will set this flag and wake up the wait queues
before calling drm_dev_unplug(). The wait loop checks the flag and
aborts if set. This may cover both the shutdown and the unbind cases
with a sinble check, so I believe a separate system_state check is not
needed. If my plan turns out to have issues, I will use system_state
check.

> Userspace may also get stuck in a zombie state. For that, code should
> use wait_event_interruptible(). But driver has code unprepared to be
> interrupted, it all needs to be reworked first [1].

Agreed. I will leave wait_event_interruptible() for follow-up once the
interruptible is prepared. For now, userspace stuck in D state remains a
pre-exsiting limitation.

> Similarly, for unbind there could a driver flag that the wait loop will
> check and handle specially.

Yes, the driver flag described above will handle this as well.

Best regards,
Ryosuke

> WDYT?
>=20
> [1]
> https://lore.kernel.org/dri-devel/20260515084030.21986-1-kartikey406@gmai=
l.com/

