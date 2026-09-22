Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B67284B37
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109099; cv=pass; b=oenLHNUyJeLbu1PmLZukwGr/5YhkrfDXMFpFlfXvF6uX4VDXQ3bn8gQxq69iKqUuYUDP5p2m+ZfP4bG3UTTOgWHFdftzMDv/Yvv9ZlZismr1iZjFH4wQKLdFHVbwoliuVSLGHzghMSP/eorWIa6hCELhc7MGod2FTEc0KFHk0js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109099; c=relaxed/simple;
	bh=pyQVQX6jKLamp0uCXxk31zCcsl4nBlJoDrluWIu4huc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/C9wbRlVOiiWsw4kT0K2qDEw9jJWHVB5ykQMqyiZrqroevSaCQnoKgrYsl1bnmvCGbcvvR35SRu1SL8LPuilvXlki+eftaiPN7VydqrVkmeVaaJUoFz6PS+q/42nFviRQqadkKo3ljzEWt8A1z2c7E2timwWJe5IfnIhZrYV00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtKtY2fW; arc=pass smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtKtY2fW"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7fccd4c3f36so376304a34.3
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 13:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109088; cv=none;
        d=google.com; s=arc-20260327;
        b=sTkpwCe5c3fhrqbVrQk+KmhnjSxDgAIlHfhhM9GUerVlgKTuj1/WMZaPWR7cyD9Ws0
         kR8FBh34LbEFhUfeaK11Kc9l2b9bNxY9SXvtcKpja1kWFdrGczTvcxbR5StTMsc9ov78
         kLeVenldp5WE95/xejQOBeeYy+mKoZgCUtnPDpzMYc5SihkK9nANmWvRrH0t6gS9b4wY
         nW9g8rq996epksMYnWGA8FywPJkEIMD62YCw7sxdpKXLoRFy61heNE/cGiAdDwI4wQs8
         5iniLCgX2bcS/53+W5ywc5xPif98GRgjCWURptXj9ey6EMD1nSggvPYoCtBFEo/WijY4
         YLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pyQVQX6jKLamp0uCXxk31zCcsl4nBlJoDrluWIu4huc=;
        fh=a91AinTc1RW28h++sn/Qp90zWmIGHYpBATNr2jqdHcM=;
        b=STgr5uTtC306qhZmZ2kGhXPAHbIa2ps8pcDUjse11i/eW5xNTHnBFJc4tCgvivfuLS
         2nprqPWNBkWPuQN/ENZul03pGOtWD584R6XnJgqnupugHSNvHEsZdnOqx5iSs5lDJQJk
         ZPlsMYZZm5o0nUlbMTs5yzp3HbfgwrwOAA7Yqr5vMaSoNmIybN13JquuX7q2G4J+XN/5
         I7st4j/m8uGCSVQZ5ykTRli/tjmrS+idOm0VpkiT8j7j0cEo30JeCu70dVWQLgpljVPT
         wmD3vzKFVL5DJh1C6gpba9fhRc/bhWFyAnKiXpofdWBitU3SM95+lwgtEkbny/FjIFg9
         hwVw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109088; x=1790713888; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pyQVQX6jKLamp0uCXxk31zCcsl4nBlJoDrluWIu4huc=;
        b=RtKtY2fWth/rJY70IK1LSZvlvaDsw8pKT99s+gNvpeORlfkkxKhGQNZrtg/cz3HPtR
         wJ3wPsyasQkjgOI+LNhB4CaKHfkAg43tU2g8CM7LsH6CMRYxY7VrlwhocqNUwU6z/tF9
         9g2zEttp4nfnEXAY/X4i5VaHYusXIYLA3MMGXMkRTsgy+AuuWmF5qQADevHxvsqWlAKh
         /ZJDNv2cBQRUwxcYdbnaBD5Tj7uD8gCqRfP6iM227M1zueR5tv8tb7LMLS7Z/xiygA0g
         lU8ymdoYzkxuRMGq0Qdqf4zaM+mJezdxSUZYhfl7yVIUPMl7GC6s2a5CeVViYQBgFO54
         v3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109088; x=1790713888;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pyQVQX6jKLamp0uCXxk31zCcsl4nBlJoDrluWIu4huc=;
        b=TdKBTXfGsAylfLxdeu8rBs3gs/TeEtiHyG5VryhlWf0+GCn9iskjoh13lXw384VUh1
         5qS/42gJJpbXxYu0NkVAa14sHYVOlCx3ILDrIBh/K4Yij+kX8S5ck7Bmo4L+NhGCigBZ
         M5GyD6bAUFHPZjHnJYay4FHytvgs0B7VUEEz1V30zPHxIrzH7vrDyWf5LwiqRRTdSNw9
         YWRpgv13sgVwLFuWTjb+YzQh9Gsl1kzV6JsVxS4MlVtAWd/5npBocYFL26XNswwYK47Y
         Jsku3C7iSP4YYBFx3dAQMqYOOSta9VQMZXgOa3Zt7qCaipw4yiFtJ0w2KF8Qof69ZilE
         RJrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPGzVPTWB9y2w8syPbob1Ro3+u+roG0NPYo0DXnGDTB6IKZsGbbWHnDkKKUtpvKlDR8FtN11rF56QBSQdruA==@lists.linux.dev
X-Gm-Message-State: AFuF++mUqus/NZEUsTMsHO88dT4nsHJCC+Q6z1PBzzsW9rI7GaUPgk9k
	qBIb0o4gsR4AiPE0gOCyie/rskn81g29k0N0E6JVLj6jU3mnaixGvqtZ3tEfQBXA0Nz/ryM2NPk
	YXZtD+orlrX1MSS8i665d3Cxal65nO5NAft1Q
X-Gm-Gg: AYBFou1ty57d+PGqwSwoA+pBMn/SheQ3hOJ0KIjxx8CjcTrZx1WQT9kpVz2CoxjGer8
	qkQAVVYLzUlLKhbHR2XNrP84GXgWv1Scqsf6SRJlsxyOXMaqDAdtm+0AX/WYpLCokMxcJH1ilCE
	gB552icgsROEETWmwE8sk2Va92xp6mzmGPm2x1PIci215t6oWhRiJ7TpVDTIRLb/QXCeAuz/vY1
	K5w9wyYw+la/4ADLVTK028qTL8/Q2q3yGTvOX21B52MEgGgfpvm+vQ2PbXINTmKI1z1AWI2IRRv
	wOnHlYZTkO1hIt9OyXMXMfYH8p4vNkv8RBL10lVDiuBuvBYeSt/HG94Wvs/P+IRdLcWDOS7b4Qr
	+q5d6UAqVFA==
X-Received: by 2002:a05:6830:4109:b0:80c:d34f:5f5f with SMTP id
 46e09a7af769-815f242b7e1mr808405a34.24.1790109088330; Tue, 22 Sep 2026
 13:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260920194710.1114748-1-devnexen@gmail.com> <20260920194710.1114748-2-devnexen@gmail.com>
 <arKF7P9gqq7ehX-k@sgarzare-redhat>
In-Reply-To: <arKF7P9gqq7ehX-k@sgarzare-redhat>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 22 Sep 2026 21:31:17 +0100
X-Gm-Features: AcwNN1XSk4_n-Pw8whwf_qkZon5EH5z4YSuf40SxLSGrNh11a3Xo3EAHx4U9uBs
Message-ID: <CA+XhMqwsoW1xyq+URGSuTrwnPo2CR5297bskaAsgHfMyyPPSPQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] vsock: report pending receive data to io_uring
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stefano,

> Maybe this can go in util.c/h
Sure.

> nit: can you add uring or something like that in the function name
Ack.

> Should we avoid to fail if it isn't supported and just skip the test?
Yes, will skip.

> Why we need this barrier?
That one is not needed, I will drop it. The others might stay; an early peer
close makes the hint report EOF.

Cheers.
