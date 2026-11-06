Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944950;
	b=gQZc87FCzf6B59rvt0KBCMHf8K0Sxfs8W+twcilXZLo9509b/Nt1FQWTAVTd4jCBO/BZ
	 3m28+PMbR0fq+F5fa0IobXBbkXJAsBUySpQPe2L0vteQ0Q4DCZQNQvdjhhHD0+b2Ibcrr
	 jzlUt4YLwaXHNQNfMSvkFkOwXOcOVDHc4NsPRyrz7+5YdwGg0su1tqAGjzxd5/7/rEeQO
	 sYWQwKd3h/64Lj83nl4w1TylC6XXPYKyqcqATF7wQAL3zb6jUFTWqvaIAbF4b6pTysWpw
	 0QpUYK1LEOGsimAZltuq29FiDWgqUaoop+hVdLCkQmL+Dsw8sjQBbNPxUFOjiV7MLLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
	b=HFadQsMi/4tzUU/F2l/4hCfyuHZiXTlyH2uk3G4TpJUQQTAvPudHEw/olmNdPMLuoW1z
	 quRqaF85sLoZyp1TEr+VwknqfhavTCz87G7xzDGhGD/bgXNKyBrPNd3wa2u8FM9VrEsSd
	 ZHE6uiIgF/7LEqNL+0ZLnRFLTP7dl4bhmFG1iw1Lk/IcQmecdIdifQEF2QPX0xbSLkc8P
	 46i2EIcTTATr8JgR9dFEbXleeQolsx8GLkhmFexYly+xNTEJNzU1wh4mpul2DOwQBRV30
	 IEY2HVVhN5TKMjDwkGvUa2+YfFcHHKq3Pg9uZFfw2hoDTvyOLHUJoP4xODASJcoY/1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwq+pnu2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D2606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 06:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E40D2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwq+pnu2
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4682977f9aso27342266b.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 22:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793944948; cv=none;
        d=google.com; s=arc-20260327;
        b=M0kjzC8pxjYcNcm5Y7lK4eweSI+IAUutvbl0kVUikXKOfKm7awNttQCL9AQmAOXMiA
         qDcHfYUBAi6GORJIgOylE2BxeQw8VYn3RoehsKaxzovy1hLxs0OHZzY0UKH2uiF28I4j
         WdVv572D+L9RwNRXOucByRxVpqKZET4i57ePZfMHlTqtIqMEy3nQDutQ9O1zYGVbwD1c
         +yMB2upMCwQonaNp7Mea3rojZ2wu73xdjkFqnw6Pr36AlA/P0F5JJAEK3sdsMV11htbh
         SnVryvVYIY3n/COXXi16rxKdo0U0yLI2zw11TZ2oRe3oZZF75WvhlIZfqGPU0p5VNBRB
         E3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
        fh=WT01FoBRzeOM81sFP0pMvr1rl47e8yRESqeaCJMTscM=;
        b=TEfMEN4bLt2R/8KZEPsUHZbjcYWtsG4wCBYYEx7Xmf9WkJGQMx+9MAxK2pwp+dB88m
         2T76IBnMeB7KHqO1EacKDn+I1kA7f74C8byaf65ux7q3NKsIALnxznNi40mKTSt+JexP
         Bmgad5I6d8QTtkbOel2tuQo5fg2/CTBmg6PIMKRNyoAh0cHDBuU7VgrPPHXmok+evyoa
         AFGPPUqbMB17fb3SNtyrYsbQ7h9NsLXbCnHhvi6hNgqxDkI9KDA1d4wLJ5SyEeLTn1/d
         q9tujIopzFGajPs+JejYETgUWUa83GfwUZqPQ2Cgpm8luLxinYVNJrFrI5SlqzUV020E
         FZmA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793944948; x=1794549748; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
        b=dwq+pnu2FP0az5oK0+kB1sex+7TXsBKkPwkIDcPxcuGZiEfOuzNeEqjEH6ArciK40x
         WZbw/4IQKo45ayOtt/wsHg3foCM0w/BjkrWVdTjeqW2cI9WrFATVR6b6wNKi5eGoBwvO
         T3ua+oa+0wUQXPb/AKiVnG0nYxmAs4LMnVESSaU0QM9783ADye4KWus8zKK1Q/+QbPCz
         SqENa/etxjHxzP5AWhQFVJxmkBMb4EQMYV+7tVISWtZQWDHdY0+1s5w/xzSbzfW/fKA0
         20KlJa4w5W68JOu4MiQfwq3TzD7AdTTvHDo5wOxrf6RodFBdYiv4UPQWRYWZve4c29MZ
         yR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793944948; x=1794549748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
        b=BRyqq6jL3JV8wJwD+DJ34DvuxqhsFMnsSl80rBGSrGikt161PFm/EKlDvf9uzLqusm
         +0DN5XSx9G/xElZu5oJVPNJY1zrLMo02iOLE2RJkJEd4Sqa86CYvULB7rgf4Wmn+okIW
         3+EpgB4T4/1dKp+xyUTDY721tx7fa84hLvmqHFT5Sp3X3+l3C41ocn/8WkdiCTkJPFd2
         fv/9vEbmtz2UWXLcxSYtvuqZEkjGmYHxK2u/SsHNVrSSf2Y3053mFmFM4g+nvVQhJ6v1
         zG/lkOSkBLOBizT887a0+LxkIgdCNI8H4RcbyU35aw0y8fiF3QW8sO1Dd/tHMNW34HI5
         qq4g==
X-Forwarded-Encrypted: i=1; AKwUvBzxMiaL3d2WeGA9kVWBeH/kxL4BayFQNW3SsT8gc455JTgnJZYmORumQPl5bLcU/p9/Yi3NcH8k0FeKtrf5Sw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Gd4XwJYcaRNQGQby/9YjSoX7ukyeY5g6oTZZYK976Pitk1iKN
	MMDiXxUecvfQxRBOqMcTCOzotfEpvdWRoWv1jMPTBK8zuvxqdjEk1U2aSNBuHabY3PgFg9frQXp
	8aJWKkAO8DTlK8LnCkIpqYi1N52pybks=
X-Gm-Gg: AYBFou3cpIkmnP/fm7/p522gJnWwFv0yU9HCu1p4E0trDy/SFfkM/OkvPWwejCiRNjx
	cgiOoXkYVRUYFcQydxtWbcG3F4xVwLWD0B36K4mRJrqRaagAGVC2icSoe+LRkPqZGhenTYbu6SV
	ohTS5U3GGogTvif9YnUC/K4iiYGs+4YwIYghqtsaLwiFWdp/o0O0yOik7pDQGAo64FdBJVqxjWi
	PQxqe+/dD/BJUg/KknTLjO0MX82VcRsiuQ39bYoD82tKTcP0m6Adk/n9HbS9KBWu6hnlmUarIx6
	fX42QAK53vGsdX6elb3Gm/ASTTeIjQ55GQOpQkVfHLVXPjV3N5u9t6EnCIOr3fZrSk2/Vmy4dJ6
	zlNVzk1NJ2CGHwKQTe8Ym9+UGAXkXCbSfw9hxc33JN4I6vh5pi7joAcc87q/RwC/QGIiT
X-Received: by 2002:a17:907:7b9e:b0:c42:4750:8d33 with SMTP id
 a640c23a62f3a-c4d355354efmr132932866b.28.1793944948293; Thu, 05 Nov 2026
 22:02:28 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105193426.2999631-1-stjepan.poljak@gmail.com> <20261105144316-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261105144316-mutt-send-email-mst@kernel.org>
From: Stjepan Poljak <stjepan.poljak@gmail.com>
Date: Fri, 6 Nov 2026 07:02:16 +0100
X-Gm-Features: AclHuK-YNzSXRW1RHjomN8YIUKv427RnMYB6bCZCxyhE73XOJIrYBtMyz-mjos8
Message-ID: <CAKVkeTxfwL9vFx_AFgevsQ1Kg0=DE9aSPYTcw8ZuyejhE+w7ng@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: return an error pointer from vring_create_virtqueue()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexander Graf <graf@amazon.com>, virtualization@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> not how you ae supposed to attribute LLM use.
>

Sorry about that. I've sent the v2 with corrected LLM disclosure as
"Assisted-by": https://lore.kernel.org/virtualization/20261106055635.301988=
9-1-stjepan.poljak@gmail.com/T/#u

Thank you,
Stjepan Poljak
