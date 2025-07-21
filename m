Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703E23F405
	for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135996; cv=none; b=dlji1UaaU0yv2XkfLf7ahfLptxrTy0QMqB1Lfh+5LpsvIlZlaZ0pG/dU/oLi818//dV2m2Vvk0n7hH3a0qIo5SflQ5C7BloM+bjexrWCwhFH5nzX6Y5l66L7edNwjLwtqNjM1DBoAJAimA0m10hjXqeKOMXt6ujWeb+8UGRD8oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135996; c=relaxed/simple;
	bh=vP1W6WJPDl5iLhA+8YgrVzSEMMjQAA4cbViPPymMSs0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhwpAwgCCY1rE4TGANc4NHTApL6mJPuLEeJaH+FD7GB06yQCXhBXcaOhx+WUSVqW87qhGgOdmPlLO9DdFjAmOsqeNagGIKWR9aosSS0SooydQ8uksgd5wiMVK+lwDTyO0MKDUmbJGzxfXIcOOOo0wEyWFg0irE5wxlC3mW735gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkTu1dCR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkTu1dCR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2353a2bc210so43430485ad.2
        for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753135994; x=1753740794; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+8uZUrE32kx3Y8E2ADL7GSixioUYxp87EMR1K59PcGM=;
        b=DkTu1dCRlPOFsV1n9xrPn7in3bkYa1/+CgNiybShqrKSnr2eE7T0VD55LukAPoWcP3
         dSh1LhCPP7rKmZ2oHLmq0M+3X0VHve3HoEaSWuA8eyqGsi9Aa6Hy5NnR1r7CoYYb/jh2
         4P+GTjlE+Rvld7cz/oDaKLmaW9YVhGIiizoBjsjTtJZkjqJaqIlnOLZFab3hVdbMpgli
         R17qP+vjbrazLBe+TxUlhAqGkd4n5rVcJWAR79SCQYF0SmbpR5O5E+ufXREs5nvAi1df
         E7K16FbUdLTg6WSJDS2+r2o67OAd2LEGcixdJxLOhXGaPdRSvAGedlDBzFI3U1DcW0k3
         P0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753135994; x=1753740794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8uZUrE32kx3Y8E2ADL7GSixioUYxp87EMR1K59PcGM=;
        b=egw658tSJqYoNhO/RV/pD1joHoK9399/kBe9DvHQNaAHJGTPREiMucf4WwQc1YY12l
         iOzkA0rtdl/sYQZ0M2RHZC+mbQSwVVHlS5t9u23evZOR7wH7hdZFbIUQrpmzsbl6ZKFU
         NUBt2WCKctDEjydKKiJGI9VQHGuW7O6+/R3tSOQTxblV6P2/1NB13YKxf7Cvz2vKUte5
         ZMTzp6m8VxaRxuV9U+fEEHuwMS0j7XGlC0Df217vaQZfA19MFXWNJ6zaw0cE0luYdS6v
         OTlL8+9oC7mgkXO1sQ8v9M9V7jdfx7FQZoEgRqoq6ceJ9GEeINeSaHcWt6IgbAN04sqk
         VTsw==
X-Forwarded-Encrypted: i=1; AJvYcCX24e15dgNQZDx74wf+Dc4EbVUzJv9o0wQ/2e7jNXqkovUChg3639hk0On8xRmaXaKbFXA8LebteFZ9HkH2dA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd4KIOqO3ZLYnL7wNaba/h/zbLRRF90S9cYM5LP5ugy1viw4xZ
	Vq4DVGE2KPE0+1dDBM4PP7rAN1yhvaqXHAsxaLXcbCX0x8Ua5hzLRTPY
X-Gm-Gg: ASbGnct4Lo2f7DI+YqwPBGQqo2X9Uakzz24C/ZH5fBvW97L2w4bNDELzV5wzyC3XijH
	xaXDTK4kW7fusuu5WdMhvu5hbVSAjGcvgY+X4it4esPXoK5WO5WBzpJlWjh5nNydXrJw/CZVbS7
	fd75mcFxNPlqi5g3aUFqjWrrd6Gy7rPmgY2rU6XoPAAt1iKaVxpCgnJjk6cJTg7AetL9HJoaJ1j
	IwhhGiWoKGKMZLClHxlo3XOlqQjo9Vlf9jdJJ/fhWoFmy+wjRVlB5Tjk4W3poPOu9dxi5AC9NDA
	7MZ1zQrTLEV9M3OLmVz9W3PlgBgkvch7OzAgbh1pjtBQyQSrGiOwPKav9rxcBEP1PBhgSL/3uQw
	P10RafG/UmVhWspYkn+kzMBssl5Md
X-Google-Smtp-Source: AGHT+IHxsqdm2Hc+W3+mvEVuEMVTCQZ2rqpr9FSegnYQ2/jB1XfVrQ8BsAanT22nX0QAmjG9/qtWHA==
X-Received: by 2002:a17:902:d490:b0:234:c2e7:a0e4 with SMTP id d9443c01a7336-23e25684a67mr299105685ad.3.1753135994080;
        Mon, 21 Jul 2025 15:13:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e40cde048sm53740a91.1.2025.07.21.15.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 15:13:13 -0700 (PDT)
Message-ID: <0d6e1144567e32bca049e4438395ac16da85124f.camel@gmail.com>
Subject: Re: [PATCH v2 6/7] selftests/bpf: replace "__auto_type" with "auto"
From: Eduard Zingerman <eddyz87@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,  Alexei
 Starovoitov	 <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton	 <akpm@linux-foundation.org>, Andrii Nakryiko
 <andrii@kernel.org>, Arnd Bergmann	 <arnd@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Dan Williams	 <dan.j.williams@intel.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Dave Hansen	 <dave.hansen@linux.intel.com>, David
 Laight <David.Laight@ACULAB.COM>, David Lechner <dlechner@baylibre.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Gatlin Newhouse	
 <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, Ingo Molnar	
 <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jakub
 Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason
 Wang <jasowang@redhat.com>,  Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, KP
 Singh	 <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, Luc Van
 Oostenryck	 <luc.vanoostenryck@gmail.com>, Marc Herbert
 <Marc.Herbert@linux.intel.com>,  Martin KaFai Lau <martin.lau@linux.dev>,
 Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, Miguel
 Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown
 <neil@brown.name>,  Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sami Tolvanen	 <samitolvanen@google.com>,
 Shuah Khan <shuah@kernel.org>, Song Liu	 <song@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Thomas Gleixner	 <tglx@linutronix.de>, Thorsten
 Blum <thorsten.blum@linux.dev>, Uros Bizjak	 <ubizjak@gmail.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Yafang Shao	 <laoar.shao@gmail.com>, Ye Bin
 <yebin10@huawei.com>, Yonghong Song	 <yonghong.song@linux.dev>, Yufeng Wang
 <wangyufeng@kylinos.cn>, 	bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org
Date: Mon, 21 Jul 2025 15:13:07 -0700
In-Reply-To: <20250720065045.2859105-7-hpa@zytor.com>
References: <20250720065045.2859105-1-hpa@zytor.com>
	 <20250720065045.2859105-7-hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Sat, 2025-07-19 at 23:50 -0700, H. Peter Anvin wrote:
> Replace instances of "__auto_type" with "auto" in:
>=20
> 	tools/testing/selftests/bpf/prog_tests/socket_helpers.h
>=20
> This file does not seem to be including <linux/compiler_types.h>
> directly or indirectly, so copy the definition but guard it with
> !defined(auto).
>=20
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
