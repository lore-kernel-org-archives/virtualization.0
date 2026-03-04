Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A943822AD
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610120; cv=pass; b=mI5aVgMdknQdpscSB/twuIv8KKLPbLN6pGPks/MgC4TVxBSsuyC8g0nci4VGKf34keDwuM69GKUNmrK3L349CN+kVE+bhqpC2evY1w8sBA1Xzwcq5n5BZG+dKTiN3mcZ2Lgx+o7ZgH8iG9T2fKTHDDJNj4UE8gQCMXhsZDyV6Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610120; c=relaxed/simple;
	bh=qlUnuSDjsJk4CS2+9S9es8EW3SmkE/njFl/U6Z2OlLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNXnJJe8hZ0pMKJJK6NltY4KQnE6wgJluS4VIDqKm/NrFHdFkJLkQlWL8tQYx3w6BgSqZImHzWHQvcdXUUY9lT+Bo1x380eWbkKPeAMXWQSwfEbljmuklpDGFfAB5hFoaNO/TirlZEO396glsEkNA99hSOFUWaB8iunFFokNHAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSQxkNa9; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSQxkNa9"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-389fac627c9so100262661fa.0
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 23:41:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772610114; cv=none;
        d=google.com; s=arc-20240605;
        b=a5nST9FS1yZrXlKf1n8hYl784GulH57y6hz2GyOTgM3opBKLcfL70XA40bgAyhNH8F
         UCXQkEA2tSuUxj6/xRMKIt51OItH+4rx25mXNZWG0R6f1VPcZkrakMZf8yGyer335LAp
         vVLh2a0wvoXQGDkyunYuf4WhpMlQrwnCdWRrQZnvtQZcqp5phrtP/Nttw+4kaTkWSHNb
         gmYaxzxo16ZIsM8roQkMHlrm13s5QTy8DXO79Hgk5M5M3ML7ieqGFJJ0wJi3kQceb74t
         RCecaNaDJy4YC8JKKi9odi9tXCtIq5gZFuZ/c+g7wR9O19M3vNQNXYctu1LD5b24LSQb
         f/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qlUnuSDjsJk4CS2+9S9es8EW3SmkE/njFl/U6Z2OlLs=;
        fh=FO9/bvsJdZ8R6ahKQrF5FixsoYItIC4H0DBleRdaZlU=;
        b=kKiB+MoxroVpo5ifsF3JKOyp/eAD79DrSJEMUA90SNzYaNgcE/rqt3fswmrToVd2nJ
         /pXJ1rGG1M+cihSUyyVIiot6if5qE1q4hFqwU9wHG/+n1tbPLjiXItGOp/GHFHHFkVFd
         ZEKtnw70gVp7KuWv0E8Z3FSCD5XKVH6AbMsfmh5VEQ38hSoP71UZERDw1UCj9pVZgxtR
         eva1/SXJ59F3+avL9YdlcNo/Hn+CaM+ZOHxGjHorPkw2KjnU1MiDZyL0YgFDj/iUrP+O
         qtNnLzP0NNp5XpqOzDsNu2FTOsJvOX4iC0ZNKwxR29Tuw97TWaaQIf/r8IPo9+nC31Xi
         54IA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610114; x=1773214914; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlUnuSDjsJk4CS2+9S9es8EW3SmkE/njFl/U6Z2OlLs=;
        b=OSQxkNa9C1Awljby9dCgCbBdnhwq1oRXOOi81VWYFYujM8Fj+FoJkthrfRoSvhKtYO
         Sj4IUPEnuhbIbI4NlKP1JHScgCEDOI/3vFhgqNSd/hfWulpcRZk3HKvyLONPFg51V2lK
         GQV4WEDggGlugxmdNlUUFQsyNPgzVp8NXRxiGZ7SBwPycGkgpqyoqsfqy9q8xfeJfJ9V
         9kflC3zxszTiHSrAHNGx1AdYVblIs6QWlV3SOBClm+8G7YYhY6gHHaIRh/HLyYnJ6Sgj
         qt143m1o38ydnQerq2Nk/nsGmF0AoTfWNytFmoIGtgVwm/ygk/tWn2asOnMNh60WZawr
         D5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610114; x=1773214914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlUnuSDjsJk4CS2+9S9es8EW3SmkE/njFl/U6Z2OlLs=;
        b=vEMMK8ls8k4o6+NG2sTCjCgs4UjtPzyNlkBR44M7yR/ifo0R7xGbpT8NqpHzgaZZ4z
         uotanhPl4mD1qn9jiK4SnvFY5EQqxwedlpQ9CnMWj8JNVykhQWcd2r2UUMZ9WonmKfol
         EZXSD8Eu+thE/ZUyM9trDY0TmpA6salPXCPBx5UIqyAyqwE2TE4UAlgKQR13jjLnZHxT
         3gWMWeiqCg4DppX1jo7pvYH6K9LesTO3uSJlNGuFOJdw7YWOiphLZ2ubfKQHsra4ma5f
         Ei3xhauTqgdHwYgR/QenhTFzKlqg81OyFnh6tUXSDoO1Al6YwCsaSklCPHKi0Hjr0vJE
         jm+A==
X-Forwarded-Encrypted: i=1; AJvYcCXsfnMay79Il+g3jJ68+6x9zVtY+EQoIKfyIseF3aV4vVjio5+8hK23PsMCNfyQ9umRxFcAs/k10pcd1S2Bnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YznwTwMZMsgbUylJcSgJyon0Hw1o3gqowexRuPsiP6mL/8gWBI2
	2CF0D/svFhdU3pgTC/Md1YXfvc4ElHj7aZSV75PkONH+bIlbhsuPHwaWXRH3UOzObmhvQ2ufe0e
	41QWT22Bc8Yyh3XM22ZJbrnTw4VNHA54=
X-Gm-Gg: ATEYQzz/eY6bEIjcu2FZGQtLC21fwROoa44phJjIJdP3bE67Q5RBYQB2uclzC1UjN1u
	uv/fcOS++4Ivm3aHSOHS6Ax0rOuEkQ6rTAPpiLl+zvtLI9tp51ZWrHYyjxvSLdQnMmdj6JNRPbS
	4shVwnDbzbTmLJ+R191Bxr6H4ZTH4HDCYenLXMFqg0Wz+VVQORaJFO6gW+jqfXfeAmGkbdMNtux
	Yqhmkr1Bkc5jKNvY+Vx+iW1Zcx3L/hoXEXDBaj8MHZCvzTjfEyxzrgulCW5t5akq41889NAzAfY
	AgMPftkx
X-Received: by 2002:a2e:8e79:0:b0:38a:26ab:700c with SMTP id
 38308e7fff4ca-38a2c7d3c60mr7461441fa.31.1772610114211; Tue, 03 Mar 2026
 23:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260302164158.4394-1-minhquangbui99@gmail.com>
In-Reply-To: <20260302164158.4394-1-minhquangbui99@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 4 Mar 2026 15:41:16 +0800
X-Gm-Features: AaiRm53kjsodLbYCGuUlv_RazlGLZcLSlUxqsUZ1o3B6kF53z5rIZZK8GKmcp50
Message-ID: <CAL+tcoAm8wBEes9unXrssHHsnPP28b0XcOdqQN-TVtet5O2sAA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 1:03=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmail=
.com> wrote:
>
> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> wasting CPU cycles on polling. Users will be notified and they need to
> make a wakeup call after refilling the ring.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Thanks for handling that problem. Please carry my tag in the next version:

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

You seem to have forgotten to add Xuan Zhuo's tag...

Thanks,
Jason
