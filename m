Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C4DF5C
	for <virtualization@lists.linux.dev>; Wed,  5 Feb 2025 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785155; cv=none; b=c1yzav2Ejm9XGOJS+FMQt2OnWyUOYMaDyACFdPqkWwdO2TQw9xVF8ca5am8ByixtGQf3R+lbQUkdF7uSYChEHg4NfST2FIWcqjczzt3rZa/gO72xf5BQnn51QJuTO8VHlwDd6p/zqD7yHi65jVV2xXcsq4XD99y9OIhbXi54KeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785155; c=relaxed/simple;
	bh=ylXsVJQ4SkSRoIxit5Ty1D4Df/HyuC5GpDfK6nUoWVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZhymE4O/r/FJS/3uTwvRlpVarOLkJaPgtg0ROquB28ykaLYMwxAQZJhJcvi6R8cBx4xVjCMplRolhiwZnssKF8hawq+XvBLVp/K3x9SHVfz3UJPD+JyuvvmKk5do9+hAtK5CTPD1/itjBf7bwMw43KUwZn49Q6hREOY+8f0jkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z98uPWy9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z98uPWy9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f6ca9a81so21705ad.1
        for <virtualization@lists.linux.dev>; Wed, 05 Feb 2025 11:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738785153; x=1739389953; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWWB+QEPZ+Au3FNEZ2YpDzx0U4CEf7uGyoSwdOXplO8=;
        b=Z98uPWy96wcF7CpPQfiHC8xWtXolFOcBcAtMOxElVdYzBZS02IxhVWe12E3zmLuRtL
         rYYMdDrE04BwM67ofcoUI75s/A541IKuIsgnlzDpQsqTvanRXCK64i9f3prpbcIX4OwI
         xKSfh2PhtENSuk5LaB6xRXyDmuOsarpJf5WujAFmV8rQQfsq9oiaj+oyhOWoltceAQkL
         cHVF+CI1zSYEU5t9x6oVUq0p2d9BWlelysQN7/SR9vlx3drzEm0WdPUIKvkv2Pk8Ig3N
         txucfE9/Pxx4YNbDSBE+uT09+/4Fs3sgLaeYrsWYGiu2d/QWepuQTHzdAjRdtN0vlsNb
         Pdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785153; x=1739389953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWWB+QEPZ+Au3FNEZ2YpDzx0U4CEf7uGyoSwdOXplO8=;
        b=Efcg2zTPJ8NDSXMc9/tDiWZsunreiLAB8nbMQgjhNsj+LYMZS6NBB5621ICYQd2u8h
         XwD3FNzYYhmXOr0E4WNQh5JG3k5wdkUK6kBJOVUmAj3cBx+kROHgpLwjHZhEroBqnJ+X
         aGjaCAQ1a7v5zaNIJnWc5C5DmfBWZRzL3JFsShCXJTboDz8jFOtHd8f0tXHUrN6rTzoh
         VoUOmmV+1O2aqaAX9NJV9MGLMpbR6lWANjCh1SUKY7aInkUl0DWXxrNr7woYnQF+RFtR
         Jnzy+CFuYGuvje5TTFrkGmrCT5NFXSc/wXw7nGar8y6VfzJdDR8neNAtNgu81gey5n/y
         Qsxg==
X-Forwarded-Encrypted: i=1; AJvYcCXor8FL0zPRCmEk2/QWoguXm+B10/MIQrOT/FKrZ1f0EB9igDDZykLE3X7+7GtzLT3ecEzsd1tZsqKrKgVLUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5mGHl9SolRc5yo044rc2lBPl6Mkj1I3gDKpwPuJeku8Skx3hL
	YtnhoqE/THHUKdwwNs2cVzXJHE3XIHH1AzSUvZg0Tz9eCwNHzUHW2USEJdmqtAl0rQ7WcM71zpU
	7nNcSGmQukc03wgSoKPujZ4EPieEKPHlu3/V7
X-Gm-Gg: ASbGncuAhE10WnWw/BbB8hT2DP+CJ6SDUwJIFRIldULMw6S9b7kSQY8Jvpoufm6GSrX
	3tU+btNFX9p2dzIbiry+kZNGzI2I0+z3HjP/wNDeFRtBXEJpgi6YKvujTWBYiMS8SlgsYPaIZ
X-Google-Smtp-Source: AGHT+IHSXvK084oC3z+1fgrASub/JYpZd/AoLG9lE82EQY5MiiDttWHzSDZOOWYo0x2zVfAmQP+VclfQEe9+CUjMAGc=
X-Received: by 2002:a17:902:f64c:b0:21c:e29:b20d with SMTP id
 d9443c01a7336-21f311d088bmr191825ad.3.1738785153331; Wed, 05 Feb 2025
 11:52:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com> <20250204180833.48cb40cb@kernel.org>
In-Reply-To: <20250204180833.48cb40cb@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Feb 2025 11:52:20 -0800
X-Gm-Features: AWEUYZndLUQ3-Ja5MRaU3KyullgQr0rdTygpMSUSH9To-Lupoe-x8bvGN-ZuNjE
Message-ID: <CAHS8izNxi+Dc6mXPNaQSjtmz5YzmeA-Sn8JdMWLpYRomJdCWMA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 6:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  3 Feb 2025 22:39:10 +0000 Mina Almasry wrote:
> > v3: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D92940=
1&state=3D*
> > =3D=3D=3D
> >
> > RFC v2: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D9=
20056&state=3D*
>
> nit: lore links are better
>

Will do.

> please stick to RFC until a driver implementation is ready and
> included

For the RX path proposals I kept the driver implementation out of the
series and linked to it in the cover letter. Just to confirm, is that
OK for this series as well?

--=20
Thanks,
Mina
