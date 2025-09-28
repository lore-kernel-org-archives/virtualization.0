Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27722D9ECB
	for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759055043; cv=none; b=d1zCbsnb8//dZVNrVO8HZ6iFtpq9KemU2ZYJTTue2du69X4Zy5SRD4acSMfyFp03no+4pqe4ZUz3PDAkGdFx3MYwKH0uPNBjvrYRJxm+XrfgMZyWlPpVOq5AFK7WokVebH21ZLNj76rwZjlBP/m2AeFeOp/BKskPvh7R7xaAOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759055043; c=relaxed/simple;
	bh=D6IUpv1N1uqZnzwjcSW/CDPKsLpnOn0CcSzXGCV/+/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkfhQPnnlIz+6CN1k7X43Xg7DPPuITpEUfQJ3M6Nybo+aJnU5zPK4NfGvhjMlFYM5aQV5KVkBWQDv64g9H392BqzbNls7GYiCwcRIPd4a2Vlim2RZloMVYsHnrlDk3gEKq0WyJvOx/qLI3Ga0ZUF2o2WiCZFBdo0i1tcsg6t9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpWv0CVA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpWv0CVA"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so6998125a12.2
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759055040; x=1759659840; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LcChJkbyyCyxxnYoZ0h2dgScTYQu8ypUACGdGHRDEY8=;
        b=MpWv0CVAD8Y3AyatiPvXsh8dkk9iFNUSZhbLZ293Yd9Jqna3DYeyNLi67cCULXuE07
         06yeicHFJsroLuXzvqDuBZSDnvG2dyP+VdbC2XfeFcVdt5PxjuH98PdVe4lsKGAK6jTu
         OWOBE5DrZlb+fD5kPuHtgBXGTFGnXcYGvxO6TR04SQdQ0BVrO2ndVF0K2eY0IoodLJKq
         vmcFsPBn8uBLmAN8fE9PBk89ViRqUVtXUN6g6OqUoJ8jbAqqQqj2dAUylL2pURfPQMZS
         4LVGUfPeOKKuteIlmIkLMnXQ8z2ZYJJVxdtuf/Erip+DM7PbXwhi9RRNPbOcZ4k6w7at
         bsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759055040; x=1759659840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcChJkbyyCyxxnYoZ0h2dgScTYQu8ypUACGdGHRDEY8=;
        b=k9uOsRvU8fcCN3z9MqBNnv+3fZx8448t9wCeGk25I6Asy9eV1SP+HyAo3Ob2CoyuqX
         GFws0O9v3bPHugAreRI8mwEnCMcTpVGyoqW/f8dlpI12G1TQyF3wr9zT/hs8ylmbvXup
         AHCQQ3Rt/P8P6EX2yfzqygkS8aFfO67N3IeAs2BYzcbG+mxqaJjixSMU8hX+q0Dt+W8g
         ryBXDcf3kVxx/0kZ9bKiIPHPsjGgXT94pOVfr6q3BcgRXWiiZNu2WoBrDrPqRf9LXBwz
         pVxtZNqRXnMccor2RcE+E3Ndzyp6z/wL3b3x5+Ta9cUxEtYVIvvVrA6a75EP3sRFroEh
         w2AA==
X-Forwarded-Encrypted: i=1; AJvYcCUZBqRAIzi9Nl65e+GnBnp+l+myBqupC4fdBs8hD4t2jQ/4N0vl/ahpNBMn/FX3bUc2giZDiwClGwbgKT7G4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDjXW5EgV4qKH0oMZWsjJ8rE6sQAwDh+o3h4NJf04+kaXNH6Ig
	MlaKAQXOD6f5KIWFDe1Z73yoYckGtDkz0MA2CKtXb5vVFi/1+1Y8ZVKQH+aVwioOK0sEoxH/z5l
	DRCrQMXAZKcyWUMafOlXujWNQ4ooplHE=
X-Gm-Gg: ASbGncusm0EXkpQ00UaA4olH0RM2Nxp4PcU0f6P5DY4fiT9IknLjyNH2Occd8JWHpC8
	qCi6YWnk9sOVVoWwS7B7R06ubBkvb06HltfS+4c066O8SDqdJEWgBX8o6E/oaNPIYd78ASC4mdk
	4KWOKV9TxMhIASxpb7HGGgtJI9JAtITTU4JXbNI2QGSIG/GIw99+6U0b8Q/5rG/PRsYKqhDZgam
	olcdSwN
X-Google-Smtp-Source: AGHT+IGAq0LbOWTh24q9bLB+mXJC5ix6EL+ilnN7HstffL1oa4ImYTxpRTBcFvmhE8oxPjiGws6tJF6LzW8U7U3nO24=
X-Received: by 2002:a05:6402:606:b0:633:8337:da95 with SMTP id
 4fb4d7f45d1cf-6349fa9f661mr8379897a12.38.1759055040002; Sun, 28 Sep 2025
 03:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com> <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
 <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
In-Reply-To: <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 28 Sep 2025 12:23:48 +0200
X-Gm-Features: AS18NWC4Nb9W4XCpYP_OV5Q9pNZrLenXw3hzv9kO6uALa6_OupoUAOrEskTs214
Message-ID: <CA+=Fv5TF+RTPEkQEmVd0_=B9xbqKycLz3ck3UwcPDqacezYfFQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

> After reverting the above commits, I'm able to build a working kernel,
> that is, no filesystem corruption occurs. I'll take a closer look at this
> after the weekend.
>

Short update,  It is enough to revert the following commits, in order to
have a working kernel on alpha:

e78a9d72517a88faa6f16dab4d1c6f966ed378ae
(dma-mapping: remove unused map_page callback)

d459e3b80ad1c81bf596d63d2e3347cf8c7bb0d9
(alpha: Convert mapping routine to rely on physical address)


/Magnus
