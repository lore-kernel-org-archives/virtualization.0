Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EC2C15BB
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131690; cv=pass; b=rVC7jn3dRd1IAg79G4yPo4VeQdfYIget5SPTY6JXekDLw9LmwC4/mp/4zZl2vbSr91SBUZ0khlJhdEuc+HWvBUlwziBiEGWh/ulq59aEAivOJ8nGirkYO/1IzSIxXGyQm/1RYCODAkSQjYf56+lcAhFOXZa0YFeX25cd1CRVZGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131690; c=relaxed/simple;
	bh=L/CnMUoFxfJHS8Sz8D/SuZ7T9cQ58RayjuJ4fMCkblQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEi4RGf+zZaeWAEtt6PvBOwP2bXCnPsAICYZiYELNQFXLjDblYOw615GqfxYJ85w/QnRIDttKxbT9jTXy4ZETldKxGxT0U/4PpBlA+leJKasjfs4QmCsxVvGC1eKi5afKgyGJW/+gzQ3dy3KU59yjDjAZgPviXzGo7Ymn15ENhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Grp+Xf/2; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grp+Xf/2"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e347638adso436281a91.0
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 09:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784131688; cv=none;
        d=google.com; s=arc-20260327;
        b=afeNXi/hEL+UJ1XljxYqLLBk3Ewe6VO8+bUzGWiOSaJ+bggpvrSygQdSyuLfHQWuzk
         R9QVKBEQAo6CcXxGd2e1A0AvyKJVBOqgq8Vu5HOxhY+zVdZHHip+Db29psrC6oOZGeds
         KQPpJVvecJxRIzjhn4tUOtYwpJ/dSJf/6qCQ/MqU/uuheMqx8nO/Qebet4i/cTQkO1Lv
         AAGQfUzKix9gitc74AFr47HQirLdFdxHj8pGfw4PEez6fisMBZwEPDo2F2i/PYaJqpkO
         scTeOuxb6Dh8vKrnxRrARXIpWcc0agNYIXNyq22CRD543PiQlIWDuEcX8KkhlFbN9BJ6
         jvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L/CnMUoFxfJHS8Sz8D/SuZ7T9cQ58RayjuJ4fMCkblQ=;
        fh=dwctQyzVGJf1xC3MusE1JqaimlH0BVUKQauyhHYm2JE=;
        b=ag1HvAxXemX+zA0Lr9RrLS2bWlGLqg46IItMFBXOxbj3IifA7Md/sP7WAheXI4pxom
         ydR011OSo+efg77HQSPXbb9SXuA3AIthR1myN+ebYWWXtav8rg+VS58IMl2eD5p5RZN2
         emHLM3r91aiWql/nMgldsJLQYra3opWn/9tCz1X9PdFincd0RomBPWrqrm+qKR8vzV+k
         dx/BIfT6eDKLWR5h6Eznmh+qZ0PSb7QvDgWBjQi0/6EO7+ibbeJYEUwWZVxim6A7ubGF
         QmGmKTAvLhRJV4eiE9JOu1XnAdnsLzqq9XaJ36MUa01b0USazZdgZiOWaf0QhnWgfipQ
         v6Rg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784131688; x=1784736488; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L/CnMUoFxfJHS8Sz8D/SuZ7T9cQ58RayjuJ4fMCkblQ=;
        b=Grp+Xf/2UuIAdNrJuxNylK6Odb/usPBt8xFPJ258XSQG7Qo5qxK6/LkziXu4oMZ8Su
         eNMdPbYkhclcMFbQ4ALrgzlMPiL/zrU4dCXQlf9Q8blNM4ImTlUMOk8ld8ezDnfh7hqp
         OCl4FORm0Aly6eicxMHqo+9gGpJf8+91ZL8q3ucfppbdV1qp7yY6U6GoWvyeN6Tfo/NU
         jGqqeTAQQG2pVmSfT3H1Hv6pAYIZzd/uSeaXv26f5dOQMD/X8BtRiTZHVZIgU9a6OsvK
         72n9ZTIQfxAcGEgWg3UNv3KoZTSpwYIsNAdLxUw4bqpxhtulpKcvLLHnjT4RMoURqOTd
         gG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131688; x=1784736488;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/CnMUoFxfJHS8Sz8D/SuZ7T9cQ58RayjuJ4fMCkblQ=;
        b=mMLbZXcQBLuumjsO4dZxXnaQB3VBvno8vJ4/KzOgcAT3OKxGdjoCzXOlN7JfD3ZCHI
         EXzVYipGjMgH9xxARr6QbbGB6ONN5UmUmpxEuEO+U4c8zfxeynOEQkDJqyxM1Y2SKfWR
         xeiL9/VRVfMVzx/BAyLTMPeIxymTkme9A1yoLbSkLxSVp4pvgX3RgGW3zD9JGXdT9WKA
         RthDwbhwKuY6IH+eZc0/QDDinkyxIh5uaWHODQZ6mpZn/WdhOhbNrGcvjcTW/oOAMoEy
         FB4gBNurEqEoUHx3+jN6uqt3AV4qFCvfg+2mbZ3+PNiq794qVb6nLMp7VJDZxR980p3X
         KIjw==
X-Forwarded-Encrypted: i=1; AHgh+RoCIFlu2d5v8p4EmkmJo24ufybSPQ9Vo9MUhYjQ9hHFPCLveuUXoH59BHUgurdNg0BuH7bqNq7xXyriw2djNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgL3uVoqmKZrqN9XydTYLk0PomY/siojW62nq1SNbHxU8sBVt5
	VMdczcVAg76mud3Z8yA93tMg2ZpQMiTUUUkfVDUGATa5By21Kr/sfr+HWuI2DaeBKe8MfEZTAss
	EFcAnMy2muasH3awI0sKGNk47dawKhzo=
X-Gm-Gg: AfdE7cl5ULu4/uDBUDhkd2JA3BELPicv2RY5GgwKODFLqWDCBpgx7b0g37s/iZMGYRC
	raajKaDEXFxFK4NnfJjB3zBVgXGyjxLRKK//KQKyVqv3WZON0CDJVNXdByKL6fpquZXLlb5N5qI
	hYkTTFmdFYHzBRn6Wqz+x3yrXUD/tZkBcPfXSlHZJLPa8iS0L7RWXYskNAk/oIs38RyJA/+ovSw
	GI5uuRfrDOmiYRWx0OOvV5acHHbvpUfMOhifuxirdT8K9xvo88JPtJigPo6UYVnxj7Ln8cMyre9
	fQ3yeNQAIw9CnNDEqbyhLRN4x8U=
X-Received: by 2002:a17:90b:2b43:b0:38d:ecfe:41ac with SMTP id
 98e67ed59e1d1-38e29eb265fmr2851845a91.0.1784131688289; Wed, 15 Jul 2026
 09:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260715142337.22811-1-harimishal1@gmail.com> <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260715115018-mutt-send-email-mst@kernel.org>
From: Hari Mishal <harimishal1@gmail.com>
Date: Wed, 15 Jul 2026 18:07:56 +0200
X-Gm-Features: AUfX_mxeev5EctzqqOhnXkkLp1lW-oPLOPqW61BCZQn7an58NL9TZTOsb6yp6yk
Message-ID: <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 15, 2026 at 04:22:41PM +0200, Hari Mishal wrote:
> > nslots is derived from the ABS_MT_SLOT maximum reported by the
> > virtio device. A device could report a bogus maximum (e.g. -1)
> > making nslots =3D 0, which input_mt_init_slots() does not reject;
> > it returns success without allocating any slot storage, silently
> > leaving the device registered as multitouch capable with no
> > backing state.
>
> So let's disable multitouch instead?
>

So rather than failing the whole probe, just warn and clear
ABS_MT_SLOT from absbit in that case, so the rest of the device
still registers? I took my lead from input_mt_init_slots(), which
has its own internal cap and returns -EINVAL when the device
reports more than 1024 slots.
Shall I modify that case to get the same "warn and disable
multitouch" for consistency, or is a hard failure better there since
it's a different type of bad device data?
Happy to fix it either way! Just want to confirm before sending V2.

Cheers,
Hari
