Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180062C15AC
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419163; cv=none; b=AdL3vt6kQyrUmgKHug2wFCcbPY1/lSSwswZZxdus071VFJTxQJZEm8lShMBXZnqxFraVjAHkuxbYlWd7IUzNAG9ck05P6gNhORnZSMG1obw4GdGTaocdOmddfQYiIR7e4k0PXNxtjUbIZiAPen3MT7WXpxO3CNQbnd3aQtdpFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419163; c=relaxed/simple;
	bh=kH/nWE1uWj4nPX0coh0oI7W0Icpip5M6GBcvfIU9LV4=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QXC3ioFlCmI9BtrlwuYS6CWpQHEXCdUsbr8cQhOe0MnetP4lLaTun9SGJMgMlP7F/Z3uUT0IhEIFokBc1Xucd2KjIILm2QA8BKratW5e+NVoFQ0Y5Xv4RUWFFtswcmeILyPHOV7GautDpt/JlTu6aFPPGRBFS7E5B4mS7PDwXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtYvaC/s; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtYvaC/s"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-92045e86763so280417085a.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782419161; x=1783023961; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQTuInYbw/iuI+/cpa7ndKurPDuK7LO01xka1fr9WE0=;
        b=TtYvaC/s4+7Y3ZbWyefqV920mR6RKaCGP5Z+AW/gatzEwBzZbbUhjPbcdeBjMgUu6i
         yPbPnnR7/QeMccH9MiNhJIgMjelFYaHnWGNV/Jt+KrjRWBnCiJ1UGIIhfT5FlPssy8lY
         ec1469wy9glfDiswS7FEMPLD6zzsPpxHrzU1rQpy6nmlTHzaULost3BI2A7xPI4yP1Iy
         IsZip1hesDOzDLXIcEzr5lHpelUi8MCoObmrHuLzEGzoCG2ofz3MdHNZmGai+2iQoExq
         TejbTHh4efHwl+xgLagpjXExBGJudRDcvMH09q+r3GxkgZ0J0tk6In3IszLp5dquyFQ3
         1O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782419161; x=1783023961;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nQTuInYbw/iuI+/cpa7ndKurPDuK7LO01xka1fr9WE0=;
        b=DeYeMnIKrDSis/m5d9vI/rppBXxR8uiKGvSAI+7J8wpt90VQe+UHpiZCm7poO4vFqp
         EkOrhX2NK03E5pLD/um/9s1jzvZ87gYluwUIKyyV69NpQ9Vy2iqMoQfi8wFandObUFFG
         2wUozGR8n6ZOngTopDRtiqM8GObJ/YF1Jt8HHnT10R6qtyIGsYNSeD3XOswrufkEIFhX
         7Qlpy2lbWTnGWCvjorpRfz1PqIc8dxRIeixWcDgUQLGqHrAYSkH2iPZbSIDBfjS9iGWj
         Tqq/LdMpnoyUcv7HxNdbb1rRPVFS4ziKyCbvZTQh9kXTNJU+WRRSwn4i0ZWqMGdXvyYj
         vmsg==
X-Forwarded-Encrypted: i=1; AFNElJ+efBB+ThHHgX+UDudbK1fsEEgHjQ8mnupOFnUsQOK6Gdxn2HgmrHaMYePHWZBTFg88ga5oD6YQ7xq76D5M1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym4t/dyO49eLhXdn2ikpK5P9ti489yFTJ6gDoDJhicWjDfpq0M
	UO6fWCKX3QOMMAb6Vv7Vl7vomuBPqagbcz/aO5y+tDb+OFJeGcOhIZZpm16UQrpIWkF50bAfdTr
	Nothv7Jdnq22uvPyIAjOq0tryZEyP
X-Received: from qtbhx10.prod.google.com ([2002:a05:622a:668a:b0:517:7852:3f03])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:514:b0:50f:b61c:ec4c with SMTP id d75a77b69052e-51a72149df7mr49243091cf.7.1782419160377;
 Thu, 25 Jun 2026 13:26:00 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:25:46 -0400
In-Reply-To: <ce63d29a-8c76-4a3d-ad8f-144f8b709cfa@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625202549.2988460-1-briandaniels@google.com>
Subject: Re: [PATCH v4 2/8] media: virtio: Add virtio-media driver structs and
 function declarations
From: Brian Daniels <briandaniels@google.com>
To: "Bryan O'Donoghue" <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Brian Daniels <briandaniels@google.com>, acourbot@google.com, adelva@google.com, 
	aesteve@redhat.com, changyeon@google.com, daniel.almeida@collabora.com, 
	eperezma@redhat.com, gnurou@gmail.com, gurchetansingh@google.com, 
	hverkuil@xs4all.nl, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +extern char *virtio_media_driver_name;
> > +extern bool virtio_media_allow_userptr;
>=20
> This looks a bit funny to me - why do you have externs in your header ?
>=20
> =E2=9E=9C   grep -r virtio * | grep extern
> arch/mips/include/asm/mach-loongson64/builtin_dtbs.h:extern u32=20
> __dtb_loongson64v_4core_virtio_begin[];
> Documentation/virt/kvm/api.rst:    - virtio external interrupt; external=
=20
> interrupt
> drivers/gpu/drm/virtio/virtgpu_drv.h:extern struct drm_ioctl_desc=20
> virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS];
> drivers/net/wireless/virtual/mac80211_hwsim.c:extern int=20
> hwsim_tx_virtio(struct mac80211_hwsim_data *data,
> include/linux/virtio_anchor.h:extern bool=20
> (*virtio_check_mem_acc_cb)(struct virtio_device *dev);

You're command will only return lines that contain both `virtio` and `exter=
n`.
If you instead wanted to find all header files that contain externs, I beli=
eve
you would want something like:

  find -type f -name '*.h' | xargs grep extern

When I run this I find many examples of `extern` in header files.

That all being said, the reason the `extern`s are in the header file is so
files that include said header file can access those variables. In this cas=
e,
these variables are used for different module parameters. We may be
removing them though, check the other discussion thread.
