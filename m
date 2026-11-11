Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425190;
	b=tiHDfREg3ftXHpdiRID1xpMQtAfRK1CttRVJNch83XTj8j8VQ3qKHs9d8NZnL++CPih5
	 4ol3dqAQmXd6JUeez93eZI63O9wvkLz1Vz3oqz0zSdY87f3F3//7USZrfpLDuFhjoOxma
	 MRV61TFkmXWUZtr21RYHkvZtOmOgpkX8HBJlyZoZI6qOBF/qkRD+jcIJeDRs5agDKN1fL
	 elzOCdv4YHbVKcZm6leFmlXEa7doEi2uzfDS1qItv92n+Db6NmAFAvc6wK4d0lzeomZZd
	 OsSndFpejfQ6JeD9P25RUfRXqajaHgKijZOFgOa3LHThhjE5ulUkYOV/JWzCqi9UDxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wd2WluVLwj4r2VIyBQDufDpYxaAOyEu9BCBLHFr84dA=;
	b=gK0Ghx+vBmaHDTekDmZ336odvpmYoKPPrmcUjKP0eOiH911ysNztZC2smNINDOPrS7Qz
	 KzcsUYqVW7IZogUa9Fx4BYIdStVB0oU8HzrFb4VXzLbx7iradM0q4mw36x1vANnTdiP0j
	 SytecFCL3mi5oyJ8B/G8jv89N4ixp9O+UgS2SkOIdE2x8KESiRkJfgZvp4ws5YOZk2hF/
	 Cjev28q34XYz8a81U4OuRlU0/6wePNyG1VOnL7qmZV4H3nTIbPH7Q+Xgx6jzd+++5G/Hq
	 NWwrqawHZ4Zrjn4KUADUPqZNuqThdMZmxcUCv1Tiaabj5aLh6dZfnWpAO4ohYP3R+Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Xg48hDJ9;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD275606A89B
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 19:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD275606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Xg48hDJ9
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso2371542a12.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 11:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794425188; x=1795029988; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wd2WluVLwj4r2VIyBQDufDpYxaAOyEu9BCBLHFr84dA=;
        b=Xg48hDJ9I6I9quvE9TG2xdSsiqmBRV2Q1z1wbnE8WwtwYmJdpWM7xWuR6at0wdTy0q
         G8sDJ9bwWbAlHvnJ9nh+xkTmUgaEsTNM7s6GPfvJ9CGs27N+LqogW/QTsr7Oyz/d/hJg
         y7zm4gHR5lJKMF8h6jxrlrM+6Uy0FIgmLFfZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425188; x=1795029988;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wd2WluVLwj4r2VIyBQDufDpYxaAOyEu9BCBLHFr84dA=;
        b=sTqc66nI9sk/jMcLRZZ4JVTIKlnqR+/1NdPOxU+4KTrUxyYJ+4O+6pM17pMSjcZKZL
         S25mzStsSM5TjWu7sEdNdAC2Sd02YgVp54LppNzKRY/nJSbCQYi2aNDrIalhcqjeeuXW
         HpRvmIFdYW8+Tuc26ZhfsGJPiliazbd383LVOEdNoK9bokfPRQau+q57S2dksG1Bz6jF
         01ySW50eWT8Lwq397HR66eAtPi0jepXIVVkaXtfU0iIRbqUGxyv1HWhe57aR6r9rQCj1
         zSIdVz+H0NXML27cXTDLJIOtoaV6lspwf9kyM1Lis9JnQycSbD1tBlRrvluWqeSoMf6Q
         Ao5A==
X-Forwarded-Encrypted: i=1; AL+hErGU4wf+wLvOSt+3p1uV9TT5SYYskpV4rWlBW0VHZAY4MLvnegpbAnU03m8a73PCXDPmwqvS0oD37TutvTQUzw==@lists.linux.dev
X-Gm-Message-State: APuU4Z94BsLYEcH2uI/e5s/PNjuO31VFjkZJLmbzd963yz1/lj13iiSw
	7DINxdvfEsQgEtRPrZ4kSiZxPGdXoNDSqGq5TBdobocB/mtqbgjzL5o85NmjprR2R4jElZ6x92i
	4tXXykJY=
X-Gm-Gg: AYBFou3/8FHdeZQw9yJjGrn+IcToTD/vZa/ATmLfc3WtuvwPQMqYTS+yB9UkhLfyap4
	6OVRq4uL2r/bxE2du9EANKL+Mm+l8hKNbDvQ9llgrywDCLeUnmsbHeILdk1BLRjYZcW4sWok7cp
	u7l5+iQaQg1XNP8UhtZDD311tQ5YTeT40qQCiLpo212SXOIcTsDH6w6SOeFqziV6vkZnohoJee5
	03vczBBb6Sb12rw2Vhpl04OSkQyPeqcTd91zxe0iHH9ah07Usd5WdwMs6l0XTo9yDjpfj9NfkfA
	+QUfAJHP29ishO9amnGDHZ5/DlliF3u3b+pEGJJFiV2RA70KqHBcVTJ5u/Z1ztaeLLXr0nKyjgg
	ind4hZG57oYYzMKkSuNhlOl9+fHhZMWVsYBfWcIfnhrgkrgMh5OWAy/G4G8dlIeer2fHO2OlCge
	GdI0YAVgru+MgD0FC7u4yYSAGk4srfTbWCICVs5n3tvRM1FLG3EyDjKLOUkWKvDpmuAmhIrZmft
	mfaU2DrLovKvkIVwecpVGM6lvHrglwceTSSqt9DTnMUbCnYWNpp5WAMJMG/od+/ZqQBk8QzzsOm
	fVvPU7xzWqChGGopK3zKDRPkV0LEGi76OYReS+8KvPkZIZ7dHKvGhrNuUvDzlf3zPuFuhAS8kLs
	JxiE=
X-Received: by 2002:a05:6402:22d9:b0:6b5:962e:e017 with SMTP id 4fb4d7f45d1cf-6b777702145mr1868606a12.23.1794425188068;
        Wed, 11 Nov 2026 11:26:28 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b78348cb4esm964825a12.23.2026.11.11.11.26.26
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:26:27 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso2371510a12.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 11:26:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFo34lyflsg8mS7c13GHVO4UezjhpkmvgFpxS6R2hRryM/A6iLgOtVaib7U+THoOdC7MdnKpaavFVFpCfUWWA==@lists.linux.dev
X-Received: by 2002:aa7:d1ca:0:b0:6b5:6478:a9a5 with SMTP id
 4fb4d7f45d1cf-6b7773edf34mr1838418a12.10.1794425186528; Wed, 11 Nov 2026
 11:26:26 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org> <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner> <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
 <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
In-Reply-To: <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Nov 2026 11:26:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
X-Gm-Features: AclHuK8LZq7-9ajWCZDJwTRjmLDnovqaiY30E_XKr8U-iLvj6BsIi-SShy4XPgk
Message-ID: <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 10:53, Christian Brauner <brauner@kernel.org> wrote:
>
> If that's the official new stance than I'm very happy.

I definitely want to remove HIGHMEM entirely in the not too distant
future. And before we remove it, we can most definitely document the
fact that we will not be worried about insane users.

And things like security issues count as "insane user": if you use
HIGHMEM outside of controlled embedded setups or museum pieces you get
to keep both pieces when it breaks.

IOW, it's legacy. We should aim to not introduce *new* bugs to it, but
if there are pre-existing bugs they very much count as "don't care",
this will be removed soon.

I think the only reason it wasn't removed a couple of years ago
already is basically a few old 32-bit ARM platforms that still used
it.

Those platforms still exist, and I predict that they'll still exist
next year, but if those users have to stay at the current LTS kernel,
that's fine.

                  Linus
