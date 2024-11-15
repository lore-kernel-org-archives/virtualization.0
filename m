Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF51C07C3
	for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684301; cv=none; b=NaZO3aJS2PA2sQ2Ajr28ZYv+skWiewmnSm/VyTUAGaJxa2/iyMvUoPpMu/wGswWTaOfbg+cwetyz3LIo/uUz5UMC5zLtEz1CzlR2Btj/soJKdyqMKj+k3l5GC8SDzKq/l85ZALQJv059J16+4QC3n7kPVoteh+TQ5y0tM8kqj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684301; c=relaxed/simple;
	bh=TIZ7Z0awf5cXcxUiF+IISaAkoCwhIcEsKazphLnlfYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUlupuoWpOWmY2RqustItfvg+A/MXlow+KURvnLigrniwX8eabsUKmuDso8Ghiyo116q/qUawVGQFi8IdgbPkViE2jDVYeVXz+rLAzTXj+SFw3HHFLMeRwVLx2WAB0pcnQ1UjAXSvRyD2U3R2ou7o8TEKB7NVp8GEBy0DEog2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qjPI29ci; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qjPI29ci"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4609e784352so13070311cf.0
        for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 07:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731684298; x=1732289098; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhWRL4SgdQsRHwF3zYRHfFkkTS6N6p8eTQwmpFKTViw=;
        b=qjPI29ci2cfQ9JDgbPkFgVIu1Jje+dxeC5P980AmsOSsBQkXyOTPJNmflSi7G3ZAUL
         jdsDELtfqS8aCNNJhidGv148d8Kwzy7/0cC3lk4YLmtt0slIYjHiCGU8YkdB4cxJmbFz
         LdNOBPdsr9ltPcxBKbPdWWy/SGNNkTtRI1T9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684298; x=1732289098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhWRL4SgdQsRHwF3zYRHfFkkTS6N6p8eTQwmpFKTViw=;
        b=sjizcX+PaDw9/FGmqVK17To4jyouyHIqnD4Om+3Wc6mdlnNzfvEztutEyCdo3+ByLZ
         jqz2qWMNVRdtH3Mrwyk37x+E+GpnqLBs9mJpVnXUKpbiNTzgycI4fOHZ04ICBVBmur3K
         wUO0KWyjUc0Wc8KLKoPp79nkjfijOYWKSD1CQY2IZfEAyPXfvN5jXWkc/D2HId9913K/
         3NhSCZ/A8hSD/6X+UKJ85vJdJjY0NE5TTKftN0npqUDmx/PgBongx66ZVO4h4SS1KYHQ
         edDN1+zyc2/jerxD/XH/gs5fRQVcdP6F3Rk50LMs/MPvuvVW31y/P1st16PWsUhOc2nn
         FkHw==
X-Forwarded-Encrypted: i=1; AJvYcCUD4qDrUJ6DS4WLmw/hUJv2K1eZFDGt2FL9BC+yxOm8H0ayZShfgldgo/SB23c4kYMH1HsPeyXKKcIEK5BLuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJMnNFAW3JWC0XX36GwzUDeC814vDX6EiEVNXIFg+l2skfI2tP
	8mveIVb+KFG+lqRl/DAaAMysiz4pmltdFuADmftcuBXMBKnK//V6liLhKQItlv2MHTyRBERHixw
	YYaheb1Tb53vQgRqa4omsv5eV62C3XRDNmybWng==
X-Google-Smtp-Source: AGHT+IEo2rr0odYMw2XFght516xGACmkLA4n6BjOW0bN/+TMAiU5Xyo127jU/d8oAwXbYktURA2Q6cq1rbAEop0XL8I=
X-Received: by 2002:a05:622a:5c8d:b0:460:a9da:42b8 with SMTP id
 d75a77b69052e-46363e11f32mr36945911cf.22.1731684298435; Fri, 15 Nov 2024
 07:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241024164726.77485-1-hreitz@redhat.com> <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
 <ae437cf6-caa2-4f9a-9ffa-bdc7873a99eb@redhat.com> <CAJfpegvfYhL4-U-4=sSkcne3MSNZk3P3jqBAPYWp5b5o4Ryk6w@mail.gmail.com>
 <ece87ac3-71e2-4c43-a144-659d19b1e75d@redhat.com> <CAJfpegtuVxtf9xoyJPveqA=uXb-wnzPcqD_rXNOV4LMahWqxEQ@mail.gmail.com>
 <2fe45430-a07d-45bb-89b7-1e4a08d1818f@redhat.com>
In-Reply-To: <2fe45430-a07d-45bb-89b7-1e4a08d1818f@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 15 Nov 2024 16:24:47 +0100
Message-ID: <CAJfpegtQhcGNaH8k1XKTSV_9=T4Ayx8oDLUK-0X8CRg6Rhb1vg@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: Query rootmode during mount
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Nov 2024 at 15:51, Hanna Czenczek <hreitz@redhat.com> wrote:

> Now that I look at it once again (because I was wondering why to check fm=
, and not fm->fc), do we even need to check fm or fm->fc?  fuse_mount_destr=
oy() assumes both are non-NULL, so I assume sb->s_root || fm->fc->initializ=
ed should be OK, too=E2=80=A6

You're right, fm can't be NULL.  Not sure why I thought it can.

Thanks,
Miklos
