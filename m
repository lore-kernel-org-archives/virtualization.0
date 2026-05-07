Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34337106A
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142207; cv=none; b=mCvav9OrjC3GXaT0ccyJGSneeV1LQj1UXQMMl+K7l74x75IrBdxt5VfGT8kxJ/fm2FvE+ye9+rRIMbtJZB3jXi0ueJrIJWeBr72xufySABKZmvCa9QzLTKw1Ld5IOZlhwBsFFoTIWcmQ57BPqmkc9Yo4EvHXq3ddNwEIvDSgDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142207; c=relaxed/simple;
	bh=JDVCYHU18Qkhl1HIRuaPMbEjsekzZ5adC/txsAiaRMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnCs80IybQVoTcx7tRuAlFoev3xrESPXrfcEy5nKEEtAbpfqI7NIGX+q35haTCIKUji/jmkKpIwBb0uqWEWSBjl+cMoUxpz2BbmTyWJs0EhGyQ2pKwVqfEKt4MDeVnElu2Fva7mc9W2Iadx++sHbmEM6390v9XGoWOy18/p8uIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ymp3Jqop; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ymp3Jqop"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so4701435e9.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778142204; x=1778747004; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCxMiF1tji8828bCn6RZo8UJQ40dDz/+KsCaov+6nXE=;
        b=Ymp3Jqopgo2pFAVt9dyFgnVlRKS6NaFZIjedqF3DLun1fyzl8aojM2Nim75/5hJqsN
         bCjGHt8fQ+YZsWkZfqmHxxx1a/nnWX84Vpvd/XOaveYRGkY+XZR+HhtQ6AMCS1mBE1WH
         MgqmqttdloqA0iN/zWOEnhROk9EQuF4eKi682IRMNYk9aXz2kp4LIfSJyi+MzDNBNv8g
         YnCBpm2FC46t0LjE2lOyS9CVycVj2cEM2J6hhOjoE9Rwm8GW/hCoZxcE5IIo2w7+skwg
         6PzY2i9Q9uJWpmwalR0L9jJYihPA0xCDKH29KF9TiWYG6xLPTnh6Cb8ownLSXz7GnSeV
         /LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778142204; x=1778747004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCxMiF1tji8828bCn6RZo8UJQ40dDz/+KsCaov+6nXE=;
        b=kaTLFr350ZKYpfryryCYleLJADSqO4PBl3Sw9clT2qAum+RnC34eBePVD6O6dke1+b
         6IPNKkWSa7AFKK93VdYWSIs3MEoo/vHVVIPwvtQkoqLBmwRA93UhlAS3nHnLUdknMBdu
         S5kQ5PzzUMPPMciA3RS0Xe5VYN04HWZLJ0PiouQsq0TxbTUUTFFE8VhGMSKf9t8Ra57U
         xL3wpcqZidOFJ7E6+jSpYYU1E6inksc2J04ipzQswZehZk1oxFq/whw8X8f2u1EiiR8F
         2xecw/2hZxmBbL16+6BJkgrxNus6PDagyQ4Qfd2rxIGHfj5DAPuabEjguZdiNMKY8v+5
         /AHw==
X-Forwarded-Encrypted: i=1; AFNElJ/UoLFhQ6lMMDTN6lwdNcwJWRJRoQZJ3DkX0Y3zrjXUOcePrvLxSGnuB/tt0GT+6H5BH7oNysUCMMEnzcxObA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+UJujM0Oz1RaVYfQqi6+7Avm1es8JZFTQDI4SsV9SWAPWfD4n
	odBr0nBUHWdmulDV8KwDSh0nr+datLlF2UdyJy1vb1sBD/gmQCvcGbCvS5RNp7S/xL4=
X-Gm-Gg: AeBDiesnLFsRALdP1gfY9IoDzN5Dqspy6AMWQvM44Uf+i6HvrCcM/3E+KM5Ox04zZVw
	H/IUdSh6/OmK/0D3Rg5+ePWUdjnJqg1nLnc8YlfjzvsJwhwkQU3jgQ+A7LaWtG3fLuX9zZ8yxzP
	V0tl+UTrZSZQU5cli70k0O9eIzRnByglhQrph1IdYYI4OarJeNvbuwlQWbdqR0hl5umVTBzgcYJ
	TuRV1okgn4d6xDdCAm1MDvWHBv/TutbN5G7Qc8nLCnwOoWdca+xSTFd5K48AenpG4/7owG3WFi6
	Po+Ss9S0r8PvMGY1dMr9MxPKBt8f8KOVqS4JDNAEXSoXXJRZq+gvkBowlfw5JxDxB3Ak6wHoMK8
	JPLqlJZ+aocU8KBWy398aCvFafxHVjN2LcedDPX38IyOZUGiagZL5cBmBG29eCLri3GqTeZruNY
	xTmvRAQdA15rvdW5Z4kvPf1z4Ad/7G9QtS8hoAzx0nkJ/EF3EWWLACm4tSOzy+k8/heq3zF1L9q
	l2s
X-Received: by 2002:a05:600c:3548:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-48e51e097fcmr111459975e9.3.1778142195443;
        Thu, 07 May 2026 01:23:15 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm18266867f8f.32.2026.05.07.01.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:23:14 -0700 (PDT)
Message-ID: <71bf7fa1-f435-43bb-a01f-13744484195e@linaro.org>
Date: Thu, 7 May 2026 10:23:13 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/6] rust/scatterlist: add SGEntry::init_one
Content-Language: en-US
To: Manos Pitsidianakis <manos@pitsidianak.is>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Hilber <peter.hilber@oss.qualcomm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar
 <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is>
 <20260505-rust-virtio-v1-4-9563383909e4@pitsidianak.is>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260505-rust-virtio-v1-4-9563383909e4@pitsidianak.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/26 10:14, Manos Pitsidianakis wrote:
> Add a method to allow creation of an SGEntry with borrowed data.
> Analogous of `sg_init_one` in C.
> 
> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
> ---
>   rust/kernel/scatterlist.rs | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
