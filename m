Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D83FE669
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198774; cv=pass; b=pqvw0Sq5dTy0BglxrMIl5FQM0cCpOuEDjMdNVCQ++r+/rY3tPhfUhCtHf4zlpTh4eMujQMmKC3/eQ2k9IERq/jN+gPf1ZT73syDfthFIVCPCr9X8MUqOyXV6UXuEOqI8dN+vHpaJCDKcRpVcHE5ZKIsXLuajI9eRi3K/5rsJ6UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198774; c=relaxed/simple;
	bh=5B+bH+DXqXDn3cGw1hPdVqrNtnhREmSz2LrL9KD0zIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6q9yB52NDTZhHThqGlsSX4pf7Gib+60VYDoCNjOi86t/4PLbwQsJb0n6s462RKeA1AB9srH+mptThz22ZHP36mNojWbELWmXOaJWx7o1ObwNMSrn0oTjZI7/GcdJmjvVYHiVnDU3o5NSUhdrxpD+qko17mTZtjYsZ6mVswq3Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8ECLJR0; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8ECLJR0"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so144771a12.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 10:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781198764; cv=none;
        d=google.com; s=arc-20240605;
        b=H/Q0WetO3AdrGiNACxhcqd08VHi6hucjAKTZVDVz8sBmoBK//hNxa9M14Wd1s2Vt+K
         ftcZ4CTkiFH9b0VPnyZtIrVHIe3+Cx3a0xMN+VWYGcilIPPjqdjglXWQl2iME8Z68jL6
         6VmWXEJ2RbnFEdUoceanraiYkq8v8TpIo22S4IBmeaSYFMZ0J1tuy8yLrc3kQFmjy9HV
         nAqFSjROGEUlNQELYsLYCf9slwU0HjtcL/g/jjf4nSx37CeSpSDsKfDyOC8CMWKapfL8
         w/cAgMbCg2qM3/ULbiXVl/EYcah2XdHCXjMXGguthj4hKBB53tCiDZO6/dbml8/RDbSa
         Gwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5B+bH+DXqXDn3cGw1hPdVqrNtnhREmSz2LrL9KD0zIc=;
        fh=CIroxCqACBeLVLfVyEFiiNsG30fRRlBZh6rftv0KBj0=;
        b=VCbIA+wbPtUGLcjVvf7iNVFOdRaU34e0dmcjmBzfPT8Qqi80+kEe57ZBMIyYAbosYw
         R5kZtwEH/4eFm4L+LSm8NQXSO0z7x23ooHp4zJ2wFRnWFV2NpovAq4z5MEbltbpnBjQ6
         BP31TXDRATSoB8VthkwgdZXqJXR1PJiUN+OPlGZmZaKX599rqpN5Xt7wkLuohI7EGD1K
         F2Ew29FhfnETMyDMeUVL96Oszwzjk+o1lDnjfc5iqS1czVQ9O8I2/hxIjpd81dj3j3pR
         Cbv3Xpaz/Pv4nQq8UexPlfYEQZAy96amyCwD/gEfAQF8RjmHjL3F3hvxM3mnnzHVd7ly
         u2Aw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198764; x=1781803564; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B+bH+DXqXDn3cGw1hPdVqrNtnhREmSz2LrL9KD0zIc=;
        b=R8ECLJR0hbajT5iwtKSHUWYmW8fV4ryCI3qg53LbeEKuP+F9N4CdUHeZFIAClG6xv2
         fymZUEsXCRPT+B1iA26fO5AfUuvir8h+LqEFJtaFLZbKUmPXMdvmJ8M5MQQ3mllxZnJO
         P1o+FCjfNQQSp9XK7e32nr28nU0edJUxiSMEFEhUguxY/UEml/uEhQ7yKy7C8uupX7FC
         LZKSv9eupa5Nfk6eLBoHbg9xwdRJst4IyDsEAwLL3lVVAYluNN9X3hjOaSKZaZUVXGcQ
         hj/wYnW82psajheL5YwKAtQqMTItVrQi4QstzzmYIPesvS1SKmICwt/r/oCx5AbA4bPQ
         +Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198764; x=1781803564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5B+bH+DXqXDn3cGw1hPdVqrNtnhREmSz2LrL9KD0zIc=;
        b=BDB2v+iawUNNsqS9SrUt7ElFq902xyJ8kWqohkjIwNJqfD1KRdODeUAQxcqNs4yxTO
         V/NiSZr5PWB7WpjPxigFjk3wGBEn2EPbdhWHDu9wVv5Sm/5oduhwvIveHtOh4qrZb3gw
         RWjHP9VKxecAdc8WV/rb+8P1pXR2u0+9Kn3t9z2Vzdw/wrn6+BRD2L6sXmtN+fcqOKJh
         eL8h8ZIzQsk4G3/v07KLEeiNUQuLQhkGQoH/ivqgw572vrL+3uR/XroltQVBgYLKOx4D
         jNXR6na+GNU84EuBFHCVDsFxHOCIsSa5bvz6T9r1+AZLbEoLSH8zGPDzAAmoeCBPLE6b
         ccrA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ca9kf3tS/B+wLOLdP9tTIu9nYXvMP9ESqImO9barRqtcDA5cnHu8hVMn+Ijg9VQOWochRKrw7WV5CAu0e+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOjGuTl7vut0gqPRKHMD3uyb6po32+r+AqDhIyqv6O60qtRYAk
	yjc/QNRioHc/DCUW5048nWR0SXngqfIdmBXQ1k+kUalNQn34CkVVzYzgsCvayejZ7diPYzkXNk+
	rzFp7c2R9rSfJBI+q0K13aR3qj7VmriQ=
X-Gm-Gg: Acq92OGoXYhfEb68ILjed/Nq2/gOgJ+tTKge2vPHLEnvFVnymrJpROfr/O5OQxbZJrM
	U+ZN+QPh9aerSXbUx3JLimPwL9vJBdxBsXrG8XVIkwUi7JTJFsFjBCzORBX67g77Y/SOq6roDWg
	69fxxYvhuhjEhDNdwjNToqgWXHWxEGOCVYosqrC3N3AaAR8LXpMHk06mhpd5Vxu/gvVl3TYX8Nt
	yVypWSui/9jlztCb0wwj8eEG8cMvbceU/V8a02pVpiRBYvrjwx3olG4+epy4yE0fb5noMzB+tYk
	TGzMBcJPHvbvNBw2nlfihYTLqUNDcgNcYIYw1CXk5w==
X-Received: by 2002:a05:6402:2b93:b0:691:ad29:ea20 with SMTP id
 4fb4d7f45d1cf-6930e2b71fcmr1948306a12.14.1781198764050; Thu, 11 Jun 2026
 10:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260402104407.11495-1-liwang@kylinos.cn> <CAJfpegs8v6a9D1zWsNY7pX_Zx1wgjGvoEFS6hkk+qE2iDQptZw@mail.gmail.com>
In-Reply-To: <CAJfpegs8v6a9D1zWsNY7pX_Zx1wgjGvoEFS6hkk+qE2iDQptZw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 11 Jun 2026 13:25:50 -0400
X-Gm-Features: AVVi8Cd6zdOVZpbHEWQyWnBShqshMgnprxexMPewUECxtADluKfoRYeJ9YdUNLI
Message-ID: <CAJSP0QWURGD_XCaLCTfFPg84rCbDAHMecfzTpo6Nw3Jp_2gB_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] virtiofs: hiprio FORGET robustness and no-reply
 request completion
To: German Maglione <gmaglione@redhat.com>
Cc: Li Wang <liwang@kylinos.cn>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:34=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 2 Apr 2026 at 12:45, Li Wang <liwang@kylinos.cn> wrote:
> >
> > This series fixes virtiofs completion for FUSE requests that do not use=
 a
> > reply descriptor, tightens hiprio FORGET handling when virtqueue submis=
sion
> > fails transiently, and prevents the hiprio worker from stalling when on=
e
> > FORGET must be dropped after an unrecoverable error.
>
> Can someone from the virtiofs team please review this?

German: Are you available to review this? I am can review patches as a
fallback but would prefer for you to handle them most of the time
since I haven't been actively involved in virtiofs for some time.

Thanks,
Stefan
