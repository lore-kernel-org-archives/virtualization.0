Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF9257423
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766027698; cv=none; b=sfGv/6gXOE17ZMECHD8Lt2iqLdMvbEIURFvPEpHZT2gYFJHdWF29wVS3UD6Uo4vQpGOK4ok1CXCM8GTvI/x3J0k4IBsmspgtmU3uMYvmDwLM4LkCRuTyGemwUZ3GcIullE6cJ242HBz8IB8lJKZiBmWA71RGLR1Lk4qWDV71UEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766027698; c=relaxed/simple;
	bh=aMmDsg6PeqY3yDJKla0eomYe6OESw8tJFHAPUF0WDJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyZ1VWDlkMIX/M7IInd/7BaqFzB4Dii1qUhQGOetYRFXN7/5r1MXa8rg0cqbKvnoU8vMZlAf9Ly1dIy/l46G0L1PYS2npvWQB9qHAQ53ULZgUJqCnxV8dE4pnAV24GhV5ZRllNrJ+MI8prR9gkrQuZoHUfr0GWDHO/wH+bXhHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhGvh/xR; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhGvh/xR"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so242012a91.1
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 19:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766027696; x=1766632496; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMmDsg6PeqY3yDJKla0eomYe6OESw8tJFHAPUF0WDJQ=;
        b=dhGvh/xRvLg9b/KpiFr4QTyIv4LPjcWrCJYMRIUaxKexIlkhbHYHnlfmfhmavbp4LI
         dJ/lzX7vlmM28Y54p3zZlU1l8iM68IfKCAE3lm0UbeTc8yOOmLdfah5nAlhhMdhlDj2K
         RTXAKQEoELafrm6hwd5J/R6YgJVLIAb3/X5sn9dirfUrdFY9XBZOTp0MkecsFSV5g6Yu
         pbNxJj2HrPQlMn3DPEW+VEh5sYjTkAROGUVJO9PoHqqlF4dZTe4rvjDnyuG9RnUYAQox
         4YUOmiFhOFB8ZQXsGLfzphYJFRhxLWZ/Y8kT2dS7PxlI3Ivlo+kz3chaQa99xZQkJKXT
         N/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766027696; x=1766632496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMmDsg6PeqY3yDJKla0eomYe6OESw8tJFHAPUF0WDJQ=;
        b=EDZtZMjLLP+Pt5z3fd53x1hhbrkvIylqrp80qACDy+kmQNDk+RmmCwRDc9q+xoNToi
         jruMfQouq8Gj4DFWXvKPp8EFj4b4uzme6vcNvQE7A7A23LtXqoOLejWE3sObiDWvqWRw
         zWd5/r6PUmHLEjYbH/LFzTg/jpQ/1HHkwqwqzvc+TCBQVB0UHpRkgPtIeqOdFZcE6EHp
         jjoE/yp/z5q9tUDrTB2DBTooEB3uHFHQc85opA82/aiXV+IwmelKfOZXIw6zAbo+qzAL
         aI1thfheCymQl8On4O/Y5SIgMw9hfFwxGhV+C/0XhMLHhCYsF9iTVZsAwgb3b7RYwJ+m
         LhYw==
X-Forwarded-Encrypted: i=1; AJvYcCUm9VnB55pwES3sL+vWBoG7PWMTkQ/RXKUymzVGEUTeX8K/wF5bOq3xVncQpi3utKSP35/u8ykHE5wqp2aLSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR0GGDqcG1sz52p33GASTh73AeZKjJpLnDnzZIi8klbChgLDks
	6B+Y2pBupBgfOAhdoX5cvmGrC14NCkYDc3x0tr0f/TMque5BZ8kmRtFi
X-Gm-Gg: AY/fxX524Q1Ep/rvslqnubhQahNQDdkn9eG6Gg++FqsXNhTDKPUfWy9eUcOBKV5yl6G
	U+G43PvvLjm4pzHIzPtX3usNd9RT1SrkmZFroPfGelHbBr/wc62XqBCD8borZrKvtxkPGMGVWTe
	If9M9b6RQgECwkN/Jrs8HBa6OplNeVjeMi+SF7aI6QHA9JrE6bDoBtzNMVVWhfWVLF5f4y326dO
	ANmSPv3/iAsMD/CHuTNQ92Gr/0cM7rP2WELzDXjPrDxthApWlXnE9x2Fb+KAxCMy5VZmuqADL9h
	KHwUVrvAZMmYP7jZsgOU1QlHfyAAhJVrqDoe0E4OJO8qWVob36UUOvwwND7jrFjlER/W01qUA8L
	l7Uo8j2cB3pp27R6oYuobtzhc8fhar9Un9yVbLpyRlCm0cm9s2fAukWc3NdUwAWPxg/SSYnxxg/
	tFzG9u0Dfc8kEtf3wPmyH1Gw==
X-Google-Smtp-Source: AGHT+IHSjhEce/oXMOW5vM6ZF5lLLUz2/oBcTOMxDFFo21mOBhpjs2cfzbOckN+Zo7VcHVKH3Yx+8g==
X-Received: by 2002:a17:90b:2ccf:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-34abd71f7e6mr19045388a91.14.1766027695922;
        Wed, 17 Dec 2025 19:14:55 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2d9ae134sm730773a12.1.2025.12.17.19.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 19:14:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 75FB1420A930; Thu, 18 Dec 2025 10:14:51 +0700 (WIB)
Date: Thu, 18 Dec 2025 10:14:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexey Skidanov <alexey.skidanov@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 00/14] Assorted kernel-doc fixes
Message-ID: <aUNxq6Xk2bGzeBVO@archie.me>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251216140857.77cf0fb3@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V23DYTy9ofvlaB8B"
Content-Disposition: inline
In-Reply-To: <20251216140857.77cf0fb3@kernel.org>


--V23DYTy9ofvlaB8B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 02:08:57PM -0800, Jakub Kicinski wrote:
> On Mon, 15 Dec 2025 18:38:48 +0700 Bagas Sanjaya wrote:
> > Here are assorted kernel-doc fixes for 6.19 cycle. As the name
> > implies, for the merging strategy, the patches can be taken by
> > respective maintainers to appropriate fixes branches (targetting
> > 6.19 of course) (e.g. for mm it will be mm-hotfixes).
>=20
> Please submit just the relevant changes directly to respective
> subsystems. Maintainers don't have time to sort patches for you.
> You should know better.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--V23DYTy9ofvlaB8B
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaUNxpwAKCRD2uYlJVVFO
o1nDAP9D8xQeBKhU5vgUY1uZdEmdnOr8lzFR748Q3fszwHYA2AD+Lmk5pycZlTp2
pDdOJDlTqJohju9NNAPmvm1zT37zzwE=
=Ar/g
-----END PGP SIGNATURE-----

--V23DYTy9ofvlaB8B--
