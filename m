Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838F26FD9B
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107264; cv=pass; b=sxVMrIkk4Z/peWXzai9KTwlOL9AieMfwv04ygZwTtenDrJbFKxTYimK1af9Nta/l2zBuKERhyyBWMiRd01Nq9kSgdyk+orKii548MBtYLBsNfjLvosmHEsLJXDrWnwcG/wp7zSAi6Xvzk9FfdNkHwjzVU3r8/ytVo90ooA6SBlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107264; c=relaxed/simple;
	bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plGnXbpJa9u7n4RDoCeOAA6Gn95RVocmQrRkfHuyETAkuiFtCT4ff5GPvU4KIcoLv8EntVO2v7tYUVLbVcOK4js8iQ3JcaeLyAvDR2lpJgAYkFNzTfOLQLaPXL5XFYums1uZX9wZGAhdU1tqJEFWUpg/NjPuWBfj8zJhw9dh54k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYb5UzX7; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYb5UzX7"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6605469c263so928825d50.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 09:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781107262; cv=none;
        d=google.com; s=arc-20240605;
        b=XEO6M3dlrdPqs1/BQsgxAYkqGvpc/UwmEUFjvxTasxEMuNfSVMD/dHhd5r/n/gX+ks
         +ilkLShAyyyDVI1aDow6JyMwouLTXwlNl++J5r+wBAkPJ/6RBNec6DDMwS1EUVaOZbcd
         wlVILVpnCQzjM0rkOmif/k0gksS3wZ0J4sOV+cEiZQlkreQ0t9jtRGDsKWuqtGbadZGE
         z5Vs1C8JXrZbxMQ3sqvZCiVd3ukUdsU0tKfxupNkSrQNF8dot5WeC3qMzv8DQT5HuHKn
         9XY3DSzeCR8/LBOu+M/1QCGy1zzD5cAxzeswT3EFIyjsDWFPIkL4JRYBgQPWKYv93L6l
         0XLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
        fh=KEEsyuhqCRod5DuefhPuSKG+8w8DvAv7cSNvd3No01w=;
        b=j3Gyd7pK7oIaVQz0OAQ+dBCm7bEW4rl+pPA21mglE7B//CWiQHxK6gqfG8SJdnsK8b
         MEkE7ERWJN0Z+cVoLhBovUmfJM1Kj4TsTnNzHVe4VhTdVy9kMQ3K/PctXinK8CgLgCnt
         x3rZdHz9V/X0B29QquEDr9E8K3lbfbvTcTVkrkG0OmR+ft7iLKU1XtREse7e/MzoUsk1
         Pu7t7xK+hFFiNqXEoJiNjI6dIH2vORY7NcBf0V4zIQbhdj+I7uqPBDByfLcusKnoj0zU
         KwUPBZHyfgaDyId8G6vYW24xbGGt/FpiPoEh/KCcqI05qoE/U4OGAQ3NFSZQCVat8r2Y
         MRjg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781107262; x=1781712062; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
        b=IYb5UzX7q0BK6U/MUM8CDgQ1bQh7oVeQ5xP0sXpYoCayD8pBY+HuPTvEl9OyXIZG0n
         Rvn7DyPEkmCsGLjyocAB88msP0b8+99jzaWBgC1KC9L+paljPYs9tgevMWDZj5FSxD9E
         Ok8QpWzaeNFiom3cbTbNOc8Onl1PSffrTeCd0bvuAt1vs/nmFgwCczAT7gxbqSHVb3W4
         5g5u2P4wX6i72bE2L9OOtk8DY6W6JS7VDNdsFYvlBb5FngDIOc/FLjpI8BbvgNmxeWDB
         BK+PDXMfaonFBUV5oQCUPNNNnUowBdUvDhkLlJvuQ6boAo5ZTcTobRApwFdDdbds80a1
         Z6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107262; x=1781712062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
        b=WUYViO5ygnr1Zcn8K05snXByr9+B837L5+PLQpBPPTX3CNCvL5dC0FriUxUWaVBoR3
         bzcxxeqWH9XkmZNRSRlFGb+BVWg6feUbaBXYW6DeuGK1i/d6RhhC33QPzJ8rFE4aRdv6
         MoW0A/d1a/U5DF6gprIF8kUvhfxxFpdpet90K5OKTSMH2odk3HHRiWzzNu7vonz9e4Gw
         Cq0n/V8jksZh4lQf6ORo/Xrr92u3ccif8u/nZEDY5gK7Z9zWdYE5T4pWGOLDDd8vvSMW
         fo564CW9TihdYAis/dJ9LppVSpw2+ZwlAt4iLGPtMD2klr1MnEL+5YKrb+siQeM+8x9g
         fKFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ipxOj7+3GrED4XfgnAGSu8AjbzK3vWVCUyvPAF6a8QLyboEfhMLt97g6J6fbIJ4KMY9iOqOt0XnCzYyM0jw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3+3Oa66WDojR2dna8R71NlVEOqCoHMypKHbY4czyVqq41qeG9
	NRhFDPPNOOyxH/NU/HvPn2qJrH0nbYBe1Lj/OqpwyvROBYkX11KyVNkpXatPRt38pS0n1ltf958
	C1/Zi5AMxooOob0IAQ/FSSwEP/oQOaLE=
X-Gm-Gg: Acq92OG1mKIXXF5yTs2SsCCrv24RIOb9MU/8lay40g9/dDY3lBwiamzMgpaZ3rUs78i
	tdozz7nRgBcmvBYyZ/T6thDOMOU/c8BPrFCk5EUlYikrHmx6TJtRe3nbqpnWxIvv6WQNLJfQDeL
	hCkgGJzvLhW5cxdgG/vPVzNH2GZA2gHuz17KblEIxsMSdfimGds/TtUQ5RnQXUquHhhm8jTS2T3
	9BYCj6qrgGhU6FE+DCxHPBWw+wAqLYgktdhBJsRxRy2QE3MtCI2zHrS0QO0egp/18wBrSgVPR8a
	UwTV4Js9/30sDdvNBrJEJiXZml0WcgjWRLy/U16qpnTd8Ds=
X-Received: by 2002:a53:d845:0:b0:660:56ee:ec03 with SMTP id
 956f58d0204a3-66106e5b480mr18896264d50.21.1781107261714; Wed, 10 Jun 2026
 09:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610114206.3749904-1-michael.bommarito@gmail.com> <1962500.CQOukoFCf9@weasel>
In-Reply-To: <1962500.CQOukoFCf9@weasel>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 10 Jun 2026 12:00:50 -0400
X-Gm-Features: AVVi8CfE6Z8Gd2v7H8nISX8O4sfO8iVy30cFRa5xdFkX4tgN_Vkz1s3oigsZeEA
Message-ID: <CAJJ9bXz=01tvoUTF8cQ6rUiCbsyYQbGKTcXD7LwJSwBu6y=unw@mail.gmail.com>
Subject: Re: [PATCH] 9p/trans_virtio: bound mount_tag show copy to one page
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:46=E2=80=AFAM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
> I would say no, a 64k tag is at least suspicious, if not even hostile.
>
> Therefore: what about simply rejecting the device at probe time if its ta=
g is
> beyond a certain length?

I think that's much cleaner if the user base really can't think of any
legitimate purpose here (or in userspace utils).

FWIW, on a similar Xen issue, we're also talking about blacklisting,
which is one step even further.

Thanks,
Mike
