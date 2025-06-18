Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AECE27F16D
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256216; cv=none; b=OZHosn95jwnIR9N6dCr/YQEKUXHV7G6K13pnfslz+IroSsm2Uv/HXDubaXG0ZVdDgJKKtRhgtZUw0FVYZ0Vt+LkYokn4KkZYsCTP20sYqzBP8Eg/pCkIr2FDoYnpe6PsqAUBW/RfD4kZqFztcNBPD78tNYJYTcbiISJKRl3TD8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256216; c=relaxed/simple;
	bh=QA7GC8UaqMR+DmjCanUIIF2mklJ/OXH3NqlsEaz9NGU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Qj0e4iTE/kVdGKRUGtC3/WmfiiG3Ag2jdje3lMYH2agMbstgQZaDlzd3bSh+M8nJRZU0rBXaKx2ASVHIDp/c4SINBd9ErPL3opgn48coG/nkRGTisHTDW7tKfxOl4E8lJd9ff/NVGoSFGUnUJ9hs6QznfXVvxApCLvRANBcL9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UY+ZPTPN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY+ZPTPN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23694cec0feso18022495ad.2
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750256214; x=1750861014; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKX0AOzd2NDOwL71Cx1dKnfTtO0KV9uKaanDux8gwfE=;
        b=UY+ZPTPNsE4j1fxW9YQ2kJCgVyb4F184fGiALyC0z3VEWtxCamPagBNhaq9mCPtSvs
         q2D889IcWjEl5ogxf39XzIXXYR5/7kJNmAXPdTZECJV0r2exAlpEcDMKF2SNKDci7iyM
         MsNzPFKv0rk3cAS7oSfHIViRz+qSxGSfIdXCk88CRm7ycMeAelA+0WHZTDHeS8XII6Kv
         KAV9lcLsYKuOBb+V9BJfSCeKhySvYLI2H0vQ28ViW54gOBAldI4oxADyqGxKTd4Zo2Rm
         6ZXMJMvcm2hxb9wq3ylh7FQ7rU+GZLW+Bc3FGLfjwuD5whIzHMqs5ktGulffxvhVf2gl
         HINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750256214; x=1750861014;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HKX0AOzd2NDOwL71Cx1dKnfTtO0KV9uKaanDux8gwfE=;
        b=sMm96cy5oSsOoEAA0avdWZAgMlcalN/U+09jLnjYqgfZi3gLZHRzYFrR4LEXwFg4no
         PYdRP8FT2sn+8NmvqT2xSNDYLJ9cyZ0ilj9RSI8HZANejuoCIu7qrmlH0eBZI2oUlZMI
         1NbTq/5VNuZDv2ygfIiyz3ZzCfYhs8LkvYPCc6RSz5xXlLfJQL9o82YtEZ8Kbp7YGPq8
         6aToJFGPG5VVsl2vAOjQ5XQQiKcRzLdhSuVGIr+1sllofDIng5ZiJQLrIDWDfzRVgvyF
         KUyvc4vmYcxteiPfTZdgptphSBtMutgMk3DkYpkIE6ybLcA5paeBbu0C0xrue05Nfa51
         uIhg==
X-Forwarded-Encrypted: i=1; AJvYcCW4MZWMZAAe6UDA7cV6zLFgl3c9+FW4Hr5T1AZYPs0HqEwhiiYPtLBUUYhXbqZTjgzTkY0U8h7pBK3OfxmobQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzE7FpeYFL4Zaog1bJlkqsNYNZqG7BRY01ml7TpM0QGQk1J5nAA
	zh2c44Hf/Q4+T1fxOtxYFfnoR3omU6SO2TARfEAt+wwlOdV5sQ66Dfei
X-Gm-Gg: ASbGncveQfBccYpEGOl4JOYMfl3E46cWFHqE/njKCfXXcbt8eUiMmc9uwHUq/qBFtu2
	0LMrHlqARYx1jULblzLlyEjg3kZCJgQo7S6GNYgKDU/q7B2oBCLHmtyBIzbLEqbIc0irSZfwoP1
	keE2FBxTj/EouBLgvqjixGQwOgn14bK7ZbYxj70h0fu1UBEiOk20dawVw+DxbU2JpQSaQzGVAcz
	cAwFenqlGKlW2Kjugy3DU6Z86+tjKbGk8H5OFcq2KPfRazsx8YCInRIsOPSmXcPOJhqD5N20PH2
	Ld6jsU5r+Ewk1nJkIWOwhO4xsUqyBAgALvUA9yH4jLCYrKR1qgARcQ==
X-Google-Smtp-Source: AGHT+IF65hISwSEsLg+/JJakfukqAPLuMOAOm3U0RdzrzA6kt6koNJHlRbGNsw6NteDLVbOEk1jMCg==
X-Received: by 2002:a17:903:1b64:b0:226:38ff:1d6a with SMTP id d9443c01a7336-2366afbd7ffmr222679705ad.7.1750256213517;
        Wed, 18 Jun 2025 07:16:53 -0700 (PDT)
Received: from localhost ([240d:1a:f76:b500:4431:46e3:c76b:79bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c200sm100652135ad.51.2025.06.18.07.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 07:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Jun 2025 23:16:47 +0900
Message-Id: <DAPQ1LPH05P4.HLIMQEJCRHLX@gmail.com>
Cc: "Albert Esteve" <aesteve@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Hans
 Verkuil" <hverkuil@xs4all.nl>, "Jason Wang" <jasowang@redhat.com>, "Xuan
 Zhuo" <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, <gurchetansingh@google.com>,
 <daniel.almeida@collabora.com>, <adelva@google.com>,
 <changyeon@google.com>, <nicolas.dufresne@collabora.com>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <virtualization@lists.linux.dev>
Subject: Re: [PATCH v3] media: add virtio-media driver
From: "Alexandre Courbot" <gnurou@gmail.com>
To: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250412-virtio-media-v3-1-97dc94c18398@gmail.com>
 <20250526141316.7e907032@foz.lan> <DA6Q0LZPGS2D.2QCV889PQL2A7@gmail.com>
 <20250527111311.105246f2@sal.lan>
 <CAAVeFu+=RpEfu3i_Fh9_eq_g=cmDFF0gcurT0gU9AX1UX+UNVA@mail.gmail.com>
 <20250527153547.6603eaf4@sal.lan>
 <CAAVeFuJtp=UEEULeMSVpmYDmH81Y6OQgj6NCeuPUhabSRHw4dA@mail.gmail.com>
 <20250617104938.09d21b7c@foz.lan>
In-Reply-To: <20250617104938.09d21b7c@foz.lan>

Hi Mauro,

On Tue Jun 17, 2025 at 5:49 PM JST, Mauro Carvalho Chehab wrote:
> Hi Alex,
>
> Em Tue, 27 May 2025 23:03:39 +0900
> Alexandre Courbot <gnurou@gmail.com> escreveu:
>
>> > > > Btw, I was looking at:
>> > > >
>> > > >         https://github.com/chromeos/virtio-media
>> > > >
>> > > > (I'm assuming that this is the QEMU counterpart, right?) =20
>> > >
>> > > crosvm actually, but QEMU support is also being worked on. =20
>> >
>> > Do you have already QEMU patches? The best is to have the Kernel drive=
r
>> > submitted altogether with QEMU, as Kernel developers need it to do the
>> > tests. In my case, I never use crosvm, and I don't have any Chromebook
>> > anymore. =20
>>=20
>> IIRC Albert Esteve was working on this, maybe he can share the current s=
tatus.
>
> Any news regards to it?

Albert shared the latest status. There is one in-flight patch series
required in qemu [1], and then this branch of vhost-device should
contain the necessary support [2]. Albert is waiting for the virtio spec
to get merged before sending a pull request IIUC.

[1] https://patchew.org/QEMU/20250217164012.246727-1-aesteve@redhat.com/
[2] https://github.com/aesteve-rh/vhost-device/tree/virtio-media

>
>> Note that crosvm does not require a Chromebook, you can build and run
>> it pretty easily on a regular PC. I have put together a document to
>> help with that:
>>=20
>> https://github.com/chromeos/virtio-media/blob/main/TRY_IT_OUT.md
>
> I started looking on it today. Already installed crossvm (I had to
> install libcap-devel to build it). Still, I'm not familiar with
> crossvm, which is a little be painful. In particular, how can I
> enable network on it and speedup it?

There is a "./tools/examples/setup_network" in the crosvm repository that
will setup a TAP device. Once this is done, you can pass the "--net
tap-name=3Dcrosvm_tap" argument to crosvm, and the network device should
be visible and usable.

Let me reply to the rest of your questions in your latest mail, with the
most recent logs.

Cheers,
Alex.
