Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BD12AAC3
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550665; cv=none; b=MRUno43QBfh8d14LV9lkR7g6Zjcz2rjlk43jOk9Kij1tLIa0KIHjrhIsDIvmabUHQrFB36BlHwmxf3sB5JVhKzkmwpOu62w+uyMxDqRAdp9J6MRZeCpz6mG7Xn8Awcda0o1tl8Rk659h3jjqK4i61gnHbE/TahSRI9dcyVVsUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550665; c=relaxed/simple;
	bh=T5JrzvQt69iNjL4/EANWsxT3z20iGSHRmfedO6EBr8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUUw4RB5+v9uVVOXToq/To8g3OodNVuaf6kwgtXOJ2X3KnCWOSPhzgrK9etrNuXjdFRfb4AUqgaadayBXH9QyQ3TBPeIBtLbA226UUMxfrOg8OlmnT6ki7Y6s0kL+9txDRn50U92dy8bvwgeIGzer60aS2G4rNsBa3+HzrBPkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuwRsF+2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuwRsF+2"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6082eab17so5265832b3a.1
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711550663; x=1712155463; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q2C6v07RAOGYu2hu4GY7euXWF8ETU7ffxo3I9AlpmE=;
        b=BuwRsF+2+XfBUI64kq0SFoy3W/V5BXh1rKqWHD7r3zjxaohsdKaxmliWxR7FIv8pCy
         X9BcxM9PTMDgz5Hg6pKPIzEdVkh5fW6rZuLcB3bp0Kb3rmoYWic87AefWxCAe1ROjPRn
         nriAcYhXvNC9fkR3V/Evn+BnRl+8irOAmXtsqooxLNR/AXW7vYEmNNYI6el8v2lY8eQe
         am6+iLIh3YsJfLC/wgdViAHXdKj/7ZFvsYnUo/tpjph7qmd/ag0G3Ww54CQoCQfK5ELy
         GM3lb8yweS/rdq1Afz/AEqWywvBdnsBYpES4lVHLJxbRsUdBicgBcKItx7EpFNR9PC5+
         yQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550663; x=1712155463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q2C6v07RAOGYu2hu4GY7euXWF8ETU7ffxo3I9AlpmE=;
        b=SL/AbwsVD0PVe7IBj6w0TbNEi/1KRf7l+xcMjz/s1C37tI9MeuIjEu6O5xyKSolPBa
         sFzfL3Gkp521CUsvN375Dwe0pgzWBF+P/ppjYlc0i4d/id3cFsSQCj2e+uzwutEbLEJW
         HV4DSDksaVynUVC5dB1Y12rC82KUtq2H0JAPSwV7jVqdwmCBlps48m+EviuUGWvsjmJE
         U/3t5zlsvkLpHnEZA6JTrV7+hz1uGgn9WjV3mTqZCnzBT+gu4OqIneZfkySOocMkeJU2
         nrSE0fGeXM+x/ze8pGfj/ahlUgXuBQTGAXWzSzR52FqA6iUTAC+NPZDb/1yk1fU/15gu
         h8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUzIik5NBV7XU7NSWntObNhP63SpHn8gqP5gp8L2UeacQ+2tvMwjjThNrin/g7TLGwBKp8UwY9saSYkmKcpmbFsdHvF+hZBvnGyJnUoupI=
X-Gm-Message-State: AOJu0YyK3Oy7fc+UrXK6K5m25BIIN8XdFYL5qCZduAUuAXGLyoLfIR5H
	0inlTSB5idPnX44Icc0crJGUQv3rykP6BzeeDe9p/4yDxyjG3bGNakqKseMtPT+0VJkq0iyzwvH
	84JNPRyoSIpFLNSxUR9pQruTOhCeYz8W04zT8xADZ
X-Google-Smtp-Source: AGHT+IE1qaXoQhFdrtV7QT8MND6FcMTo2zAxmPDuHTiYsb86YGvn9Hfou3VfjATjJrHui3jRqwzdKYDjQpt/iPCMqrw=
X-Received: by 2002:a05:6a20:7a9a:b0:1a3:69e9:63a9 with SMTP id
 u26-20020a056a207a9a00b001a369e963a9mr56558pzh.18.1711550663028; Wed, 27 Mar
 2024 07:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANiq72mbsAYmR_dRPpQQ=9-NWhTtp0TWiOz0v=V-0AvwYbWw4A@mail.gmail.com>
 <20240327-magnetic-nonchalant-hare-bbe8d2@houat>
In-Reply-To: <20240327-magnetic-nonchalant-hare-bbe8d2@houat>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 Mar 2024 15:43:55 +0100
Message-ID: <CANiq72kqqQfUxLkHJYqeBAhpc6YcX7bfR96gmmbF=j8hEOykqw@mail.gmail.com>
Subject: Re: drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set
 but not used
To: Maxime Ripard <mripard@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 8:59=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> It looks reasonable to me, can you send a formal patch?

Will do -- I found another one when running the CI with the above one fixed=
:

    drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: error: variable
'num_relocs' set but not used [-Werror,-Wunused-but-set-variable]

I will send you one for that too then.

Thanks!

Cheers,
Miguel
