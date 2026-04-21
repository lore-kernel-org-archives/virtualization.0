Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473A2C2363
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784771; cv=pass; b=KsMbLTFAQuP1epiWVBc6e+ii3+IKhYa0IXC0ADa5fGKffw2w8eO5vvUlkaU0/nVmbtci/OKU31DCFKgVN9oRIaQKP1G3XkSY47oDQGDS0re3+Cl9X75G4uCAnZhzEf3Js71/RvBXADv4YdRYYO0pPIE4YfYPkPkzTKeJMXlZ7ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784771; c=relaxed/simple;
	bh=PjftJJfecmOTA70hHRbK5lG67pybnRdPu/Z7HmX7VfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rq4W37dS7EwOunZuhRhITl6o4CYGjby+t3zkzAS6N/HMf3nqsicpDSVvYspCReralby7bJZnghhlhwA1J+o0tNNHlBDsyKIF1xwdqYJ7/DbyVbw7l3dqnsp5fTr1tYUdjvzUI+Rh9ygF+QqIbXHiG2xXfrlPOgEabgADDO3mu78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPV2ZSQ/; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPV2ZSQ/"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651b4d09141so5786897d50.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 08:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776784770; cv=none;
        d=google.com; s=arc-20240605;
        b=Fh7RzpG0zPBjTH1fMybMEFRkfNIpuYUsFf7U0nggyr2SPkYKBPJ4HsaPSKDYF+Fcrl
         3JB8bb/TZcSbETvLhp6XpK1wzjn/RZJWSsDAFos1QpgGV1CJ274rnVVCRMbqXHRtmuWQ
         FSG7vs+AXUwIvmwZZw5RyKHzdBM40bCy6ToPtiECAkBUfMBZE9jRTqUP86+QD1L7tVMH
         i/4hk0NG2KdvE3F2tsFj/5cgrrjICWaTC7CiySi0NHBS5VCOh+J9XmXwKWTg+XhrEaQG
         8ekNe7juvJ2P7rWS2Yc6MOyP6zTJVB8WFzs4I/KJ9B00eThc3FYkrBctyr+m+nU+QDk5
         u+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQ2m/CHxIoJhwF5p5vbd5h+FeXxeMjnXlSYb2tbUfSs=;
        fh=uKwRUQT0Ns8Y/vLhjuvTqueNDmT1LOqaWzPTbsKnJNs=;
        b=WMRfSAzl3WlkHuyZsNBiY4mkxkSsvCQkqmontFf8ns70mG9GVFSeePj1YR4A/omkd7
         WN8eqx0g4K7MrElPGl/+GjfEy2NZ1sGOkwcQ1aI3u8PJ1c3xuNGdNIPqIOhOvlgzsfim
         ra4WZjlE9H1n0ImJy/10RlW1U6lDEjTnbUcwJN0LB9jbuHGEPpyzRnuSmy2RHDzd+OhH
         kgYVwQwafxICgLIIHDRnH+fFkgoX/uClsWJ3PNQBQaDFafHhNEek+STHJaI1NxS1/cAd
         RNGGgk4CGcZKexDllaTUvOUHr5WHgkarQmTdHIqYT8nU8H93u8MM0WTOBBml5gSyLd7I
         UzDA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784770; x=1777389570; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ2m/CHxIoJhwF5p5vbd5h+FeXxeMjnXlSYb2tbUfSs=;
        b=lPV2ZSQ/iW/47InxxF9PgvhpVrUXgm5qBfnDt2tdvqe1L2aklNPvGrakpJEOst+DSH
         gBrqPXcTNVejM86rX2fl6wQkq3w8sa8y3LZMPpOj/yW9gLX3gearVFDy7lVX2S5N8aJA
         30gxOEJgGgWRsdOhjwHDnpjiEBAEwAZA6aGwBPsHaSDVmnP7AQ/QuqqUjb3ig+E2DLYd
         t8Gh3wW7HPSCVpuLd4zVyXIQUTEirEdKOdXZfsuJnX3CNK5BNUFt2DlCO2nhPt7qVlOJ
         ugDE6kcCseM3/UeDAA3sbZFAR7eYJOfF9Ur3BZ9ujXr/LccCorbuEAG3IazrsT44jByz
         S6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784770; x=1777389570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQ2m/CHxIoJhwF5p5vbd5h+FeXxeMjnXlSYb2tbUfSs=;
        b=XpGtUGKxluCkqsXGtE9fFKMTjJjEV//7E0EX0hlAFM1nNXUxq7thI9RjKhDZTkLgiJ
         /Bad6cMVC3YAJHzbY67ZuGoG2g8mPrKsGtilSI/Jja6eWJ+TDpQukgsRgBZeP6K70+Vz
         3TVJXalr7X+qzQ3dEXmA6WiqOKm51Ss0ZKoJUG9r/zRwEshOjZNBA6hylZga0QHYgyo+
         /YIQq3UcQ/s/WcPu9YVuYsHXmbWDvU5uFIixu+Nk+DEBNuvcOJY9U3ourD8eDKYQlh3A
         0pepgWu8f3MEnGaS40DtCCdxSIN28UyNdxKrsqCZ5aEBhg66m5Wnz8m1Mlorgv1YWDff
         Q0dQ==
X-Forwarded-Encrypted: i=1; AFNElJ84AkRdCd29ZaaKW+5UzVrrKAObo6YLcgGHoeWoBe21nPZ+UecbZyuThYDdY+ZF3c/K9iyeI/f21JeUzvI39A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxToTRqOVf+/f1GnbQJScQBs9tcGkUWs8xjp7nuBAH13ASprRBR
	WBrfZvsub5ROEsF87+ej09o96G4z0EHBDbB3HpItMFenaHsN++bcvjZHxUVaf+RphoIKvPoCrAI
	QxlQLdlgZTY/1LR11HNtw43fZ4nFrBFA=
X-Gm-Gg: AeBDievxSQlbb5vb3r2pPZP0FF4ko5V0bzXgkEWxDjj1BHCBrSVeODWbJqsl3cSHLvW
	I8aTxM2TfpIyGjxyNU4WpWtecWQW1/q7BFbxof9e0tnqu5S9zT+8GymZEOePmA7VVr4CapBfzrq
	WBYHmVRVHtDntPmYgTrC/DmPWnxlJcpreZ13n+SHLX12iD5MZrpKhHlomx6qkeq/utFzJYn45lp
	/Bz3lYG1+PWtB1MS+Zf+jl3IPJrpZaVa6yzPZlYkFYJO5oFvED1kao3c+7ykqDb98kngoj38rkA
	GytpniyWp3R83pzeo34G+r5jBqRavsYnyCyETw896p+G/us=
X-Received: by 2002:a05:690e:1914:b0:651:c41c:80ce with SMTP id
 956f58d0204a3-653119894a8mr14639293d50.16.1776784769747; Tue, 21 Apr 2026
 08:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260418000138.1848813-1-michael.bommarito@gmail.com> <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com>
In-Reply-To: <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 21 Apr 2026 11:19:18 -0400
X-Gm-Features: AQROBzBPqUpIKnWEQ11L0F-Vix3nySntGBxcZ4D7FG64ZBem_e_xYXdFqVKGSkI
Message-ID: <CAJJ9bXz0nwWsFg-B0nn77bn4dh=ob-F11a6azK+VV8sbLOBmLw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: virtio_bt: clamp rx length before skb_put
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Soenke Huster <soenke.huster@eknoes.de>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 3:17=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> All seem like valid comments to me, first one is odd to me thought,
> never would have though that skb_tailroom wouldn't be enough to check
> if using `skb_put` is safe.

Thanks, those were definitely gnarly.  Went back in with
cscope/libclang and found another spot to guard too.

Let me know if you want me to re-organize/separate these into a
patchset instead of one bigger patch.
