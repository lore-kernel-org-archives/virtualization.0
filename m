Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335E352F9B
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592581; cv=none; b=OwNaSgawepP845mnp0RRP+YaUzI4Lz7+e5NAGT6QR1OPb3Q3NqQCWa51qWbjtElgUHi+WUTVJxoASZHz9KHTjMMB3znrM3mIzexx6oU2yP5aO7uUXlLm2lSlKGMZvD2J8A13AGyf7ReMzKKl3x6zPCLKDwHWEbOAE0MPF81BvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592581; c=relaxed/simple;
	bh=Yh8dBMe3ibg8tK09EirKlKZM1uMUm94vien5uMRloZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rAKknsjBmrZs/9mnBzZmZbf1DYyP43D5G54hvzMxS1qYEFjiq9CHKa57OcmLQSQpWnk/MzBmCSaLSY/dg1d98YfpXi5Oygzu9Pp9sSi0c/vWps8jjLxYauUVbL1Xka3TJ6VsZhZxRG6PsoBDTI5Lawr4OVZa86vAGiKUUYJ4OVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sjqm+Skx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sjqm+Skx"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae49120e74so29120285ad.3
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 18:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772592579; x=1773197379; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlfxAiLCYE9X+ss6Nds/jzCWOjzdQvgrRAY6r5Hx7j0=;
        b=Sjqm+SkxiJ98qgnm1C2hsA/w3axWsKN7SDop0PIeHB6pDjVCF2rLRAVw8fAofU2ICP
         Qzvj9O3QGatnsquCCdxqkeYamlSLqauOyQfrXX4hrW0EWOLORl7U9mXzt3QdYQV5gbd+
         3uCSK04DJ6PNL0MsGj94ghha4gZ/YmCMSUun/cBNY2K8wEGHp2dQeuWn4ROgs3KN/9zk
         GYsBfg4i4ACGxshXoRTTi2CzvxT8rHMeFXDf4EeXy+81wGeWUbnEOmoRNMnjXoeoWQ4T
         t2FFi9hLT5bKSW7L4mw1NgBISMwfa4lBYJ6AdIWoEHRTdQSOUHpBoccs4gAtnidILPxl
         0NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772592579; x=1773197379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlfxAiLCYE9X+ss6Nds/jzCWOjzdQvgrRAY6r5Hx7j0=;
        b=elnkVDd1RX10DWTeZSj8mCQxFHzJvqDPh+RpSkXE7F9aoALkuqbBQmxSrHoP+FpY6s
         zUZYkM4aUg+vxHcFC0OY54mwDbpx8YEak3MzEVTll/q/mmvykY6js139NeVVkIfhI8NF
         5Sqws7fq2hdWERBKtSDnaMZF3KqAoFbQ8SZj1/mb37DHYgPbVORG4/BsX6tMgS5l5vyQ
         iiAo9eVuSH33SHd+NMtTomMYr7jSvIB+E0kgqdHSPe0C7gKVSjtTXysal6UnDOm4zZ1O
         rULgAW80u09IzjBpbP7SoGnFKW8sSX7h4VRArm0al8ra5DjhH56F3olnfkvkKkinIEm6
         D0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXWCW3lJZ2aZz5JzJhROojKsQRUBLuvkEX5HicyXdCrizwoE2Uldps8iAA7/pftHXcmN3MPPGPk2O/4ChNDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHrSBgVmTovtpXJGOL+Zw5rDRlnyofiObR6oV+Z9+WO8Srjyya
	CXU89nvul/1I6f6fkIMA98lC4pYtv8grGTnFzTyTRjDozNxbv2Ejldbn9fCLcoB/Ydmtfkaxqr4
	MebdeSg==
X-Received: from plzv9.prod.google.com ([2002:a17:902:b7c9:b0:2ae:6338:73ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2446:b0:2ae:483f:b239
 with SMTP id d9443c01a7336-2ae6aaf9469mr6114485ad.30.1772592577810; Tue, 03
 Mar 2026 18:49:37 -0800 (PST)
Date: Tue, 3 Mar 2026 18:49:36 -0800
In-Reply-To: <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260304012717.201797-1-ynorov@nvidia.com> <20260303182845.250bb2de@kernel.org>
 <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
Message-ID: <aaedwFwXh9QXS3Ju@google.com>
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
From: Sean Christopherson <seanjc@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jakub Kicinski <kuba@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Duyck <alexanderduyck@fb.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexandra Winter <wintera@linux.ibm.com>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Anna Schumaker <anna@kernel.org>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, 
	Carlos Maiolino <cem@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Chao Yu <chao@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Dongsheng Yang <dongsheng.yang@linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Latchesar Ionkov <lucho@ionkov.net>, 
	Linus Walleij <linusw@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>, 
	Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Zheng Gu <cengku@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-block@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	dm-devel@lists.linux.dev, netdev@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 03, 2026, Jens Axboe wrote:
> On 3/3/26 7:28 PM, Jakub Kicinski wrote:
> > On Tue,  3 Mar 2026 20:27:08 -0500 Yury Norov wrote:
> >> The net/9p networking driver has a handy macro to calculate the
> >> amount of bytes from a given pointer to the end of page. Move it
> >> to core/mm, and apply tree-wide. No functional changes intended.
> >>
> >> This series was originally introduced as a single patch #07/12 in:
> >>
> >> https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
> >>
> >> Split it for better granularity and submit separately.
> > 
> > I don't get what the motivation is here. Another helper developers
> > and readers of the code will need to know about just to replace 
> > obvious and easy to comprehend math.
> 
> I fully agree, I had the same thought reading this.

+1 from KVM-land.
