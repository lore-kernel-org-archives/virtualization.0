Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98B1A76A4
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936842; cv=none; b=fD+KucmOzSWZ1oOVihLGotsjp8Ij9tePw5R4fADi1uhK54Jv0gG634+0vtryBLoduZ4HfSZ76k6aX5W+l6WErVcAF+ZG1TsY36tseOXWcTmwgPIBk6mdAeouuBGq31k4ldOTFWE96f/hOFahG8NewRtV+I6GwMycvH8URR3Ziq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936842; c=relaxed/simple;
	bh=vhpdpTfvOWpq4BkpAeiQWNqUpz5BcVonWLnhkaxRaQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqMLDOa53C0LJF2G+We/c9TFBdMOFFSYftNjsAUks2H2xEr6+MDglJa/xXmzfoA4+T3Q5rHhGmAoLPKQsMvOpW/DEnP5BmaOxk87yipwpEITs54qliHTeVi5WYft2UL1bHDEx072rLxknbIp37EWP5K2We/r61k0bYtNvGOi1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bKIbvltB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bKIbvltB"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5343eeb4973so1016607e87.2
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724936839; x=1725541639; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0TbsUu6WIFtUI0I/cmrO4B5vqQGbNpEnL8oQNR8OvE=;
        b=bKIbvltB0Y5W+1nlGrsDUbMZxqHUKEXWbDqQIccOgAMERZPsZ3zpV5d0ytUosw3cWz
         st2S12kSj0eV0m9nnZJA0u8LG63HbfS87KOa7GQI6iOQDnGHwrRwWennOZdANBKdBG9z
         YQnECe1mOOnJiO3QVJ1el3G9XF9Vj5XMIkGy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724936839; x=1725541639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0TbsUu6WIFtUI0I/cmrO4B5vqQGbNpEnL8oQNR8OvE=;
        b=spYX1b2SDEyxQxqLlqaec2rwTiW20zx7UKsbL41r0PaeKDJQwOdKKnEHRdSr2bxsbo
         tOlk66NFYVzGetF54hrggeUCdwwH1ISgEkCm+zK3/4vRwcdUWPJOpOPVbJKJq4xghuXH
         69+4OIArFz/pb3s5zkUyd8ElqnZjseddfDBB8QJ/hcv4+/IUBBCcr8o9KfJ+FRRUbkf1
         wNejm+bwA33sIKPjTs7SbxvmyszPe1CQajJjzt7VRFR4hldWX1Lqy6Ln0skGA4ma4VWj
         li5O6axPUemxFYdbij6O5K+0az60PXGwIPkITHR8dN53gMTItkSHJ9r2huHqa0u3pZM/
         roqA==
X-Forwarded-Encrypted: i=1; AJvYcCVpXWdlcvRMbqt2UCZU4UqcPOmfABhLYrRqSWaY/5Lpevbcfi/ymKfA4hg3F+jFtC7FS7WsvsMjuV4udR/8Iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYWc45d3pG2laZm7JGTsE/Xkh6XJnX6xV0m4dKOGKYd8n5QiZ/
	dke65lmVH28S2MDJjhidMkDF/rxRVOQKyk+4NQ9FsR8/qX5J1W7vzvbSLsv5knsZq1ZnnIf2BBT
	FJdLg34rs4bjBUsVP7QGzQxMv79gtyfNTYs4mZA==
X-Google-Smtp-Source: AGHT+IGSRqyXut7tytiqq+Fv/FSdxZOLBx6kvkri+Nl7nKT6LJzc0hkeK3IT0QDDU6jjqcTAQkTG+kIWkupBmiQV4tM=
X-Received: by 2002:a05:6512:4003:b0:533:4620:ebec with SMTP id
 2adb3069b0e04-5353e543459mr2692053e87.3.1724936838878; Thu, 29 Aug 2024
 06:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240709111918.31233-1-hreitz@redhat.com> <CAJfpegv6T_5fFCEMcHWgLQy5xT8Dp-O5KVOXiKsh2Gd-AJHwcg@mail.gmail.com>
 <19017a78-b14a-4998-8ebb-f3ffdbfae5b8@redhat.com>
In-Reply-To: <19017a78-b14a-4998-8ebb-f3ffdbfae5b8@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 15:07:05 +0200
Message-ID: <CAJfpegs0Y3bmsw3jThaV+PboQEsWWoQYBLZwkqx9sLMAdqCa6Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	Miklos Szeredi <mszeredi@redhat.com>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 at 14:37, Hanna Czenczek <hreitz@redhat.com> wrote:

> I honestly have no idea how to go about it on a technical level,
> though.  Na=C3=AFvely, I think we=E2=80=99d need to split off the tail of
> fuse_fill_super_common() (everything starting from the
> fuse_get_root_inode() call) into a separate function, which in case of
> virtio-fs we=E2=80=99d call once we get the FUSE_INIT reply.  (For
> non-virtio-fs, we could just call it immediately after
> fuse_fill_super_common().)

Yes, except I'm not sure it needs to be split, that depends on whether
sending a request relies on any initialization in that function or
not.

> But we can=E2=80=99t return from fuse_fill_super() until that root node i=
s set
> up, can we?  If so, we=E2=80=98d need to await that FUSE_INIT reply in th=
at
> function.  Can we do that?

Sure, just need to send FUSE_INIT with fuse_simple_request() instead
of fuse_simple_background().

Thanks,
Miklos
