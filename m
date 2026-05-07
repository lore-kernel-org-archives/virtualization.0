Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA7359A91
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142076; cv=none; b=cuLu2+F1ZHVQtBbFjGFIH7MqcLc4BL4ebC4w9QSIUQkUngEEX+voxmy70q2egiBktUlgCeEhQkcDSnGwxsSn7FkQlr8vd11gLNFDgsTY0D7xnhB9WC0YsK3vNQuv19e+eyMJPCrWUVmfG8kFgmUsOZjn/8TruiFZsJpRqmF6AgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142076; c=relaxed/simple;
	bh=0RnBV/CSMLOaV+EgKiJKKgwV/1lMupxiJ036RFmnqC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQF+MmpXNIAE989Bd0THTm7PeQB8fY9EQmpT1qXm0A5ayjxeycZ0cKlGXrQjdygwGITmqjjI0e+HsTst5rJ6Jc91Q6L1xUBH3H18PYRRlyQgUk8TstU5qaMpLuK17MAtnKEvFpcqWwB0YVm47aJoV7hZGN++HdRtV7LfBCiJVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K9IfriTV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9IfriTV"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so4846015e9.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778142073; x=1778746873; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NoGIIFessO3NT0rwffhIFEtP+vlzNTwlsqHDmCLsgFc=;
        b=K9IfriTVjcCUSM9/rJHCRiGJj/mU3yvM6Tx/dH2fZYOKlpx7TA/RK94D1TPiuKdbIT
         abMdXaxtmjfzb//b7dwq39hFIWzwjCCjbNRkCMtOyKsJNposs7yq6ZOG5r91QAcksTYJ
         lakjEGcMzRIhHrYfLgCqfUOwlmNl0FV6XKYYetrjdtev0SQtCfzS2vpUN0CjdFCPWnJO
         THBrf95hDwkxStBvk215Ozx4dS2N8sVcgwVkX+CT50cV/ULpYJJwIYl4lm4TB19/j4lQ
         qqIZYx7TM0tOOkkgSVYfNc+XhYFapIevcxtqE6qsCncO6q0scT+Jq8h3+UInqGfCJFTO
         aO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778142073; x=1778746873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoGIIFessO3NT0rwffhIFEtP+vlzNTwlsqHDmCLsgFc=;
        b=a2b6SXbLdFtginp7Iu66ljo1sjRPEZkjfjxpbvUmuUarqtJRPb2HiAnobFlaJpXIqj
         3jCTQgqllj3mOhtI2ATV5jKiHb4fgFUm/8RlBDO3BIxmE6NpSwtYVEI02nNqyBwSBBMO
         onieRSsiPRFlq8rlP9vIFYSLiwjqyRkQjvrjIWxic8lqEpfUOC12vMKj7NLP5cuWch68
         h1BQuhLR84CmdvzxnvlWdgNnAwthMHD5UtsMlF/yu/U3A4IbHNFfa0PiMAQm0VDQI4bG
         IYreBFeDVMYcfMKW7Yg3bzfGXMPaSSHZk/oIAlG90aMNsBSZhfYYtH/jZjcLTC/Hx87A
         qscA==
X-Forwarded-Encrypted: i=1; AFNElJ/gsn6MBWN1TXH0FjG78OQHopYyMDTvukP7LOzHMwVIH9mnlvHfGvhW9IREJV5Aq13XnyZmArClNFFSWMYlIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNodCD+OmQxBWrboe+W6ttVDg24KN6YN4ekbD9HH78VkBZAUR5
	Sc7XveanziFjkUF3H50CM+oo+h8PD+E8uA3slkT/ujaRoTs7XbWeEXIHgreFJF3VKKE=
X-Gm-Gg: AeBDiesu7SFTggZW9my5PhANDA2EHfidwDJmMxpVgtXwYgtAeqAiIyZUp4+fcgrXWLr
	hkQ+ykOPJpUcJRadbBtP++CTKQfo4v1Y4QPfW19G2LbbPJjk79cqWtjKsYmOuB9MgR8TT9+812z
	vDXa90zQEYv4OrrYHU+zKAOgMV8IPuYG99pGZEGr8fFYKvA08Xf5O8XM/83v8nDjPdspOGd708a
	4Y7Tewm7+lZ3ilvOc0aY50U8dBVj8pOpBz4E7wNnma7HqeWsCWyISTlrXts5RqXhROZDN4cNZjG
	AyOZDbrv2YhugNUWf932m6Y1UTA3ePv/FQW3N5eJHIZdUvFWycc5iQqhrDmenitGZxiVnD2gU8g
	QKYkMvBFrAXEwo6lt7w9JkTqIEe+b1x9vdLTW2iHIe3y17CvFj02JG38NlD9NU9nqkQiHW/JgNO
	r81B2VC5vwFakjGMwGiA9iqqy3gmr1QoBcZ4+ZXV/Dz3gO5lWHjo8VQLu0fJ6xfrNsOEaA6PD6l
	Qfc
X-Received: by 2002:a05:600c:1d18:b0:48a:8cb6:88b9 with SMTP id 5b1f17b1804b1-48e51f44621mr111361955e9.22.1778142067567;
        Thu, 07 May 2026 01:21:07 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b26a3sm197726825e9.9.2026.05.07.01.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:21:07 -0700 (PDT)
Message-ID: <00dc061f-7a20-419e-a6f6-3bc7735c87ec@linaro.org>
Date: Thu, 7 May 2026 10:21:05 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] rust/helpers: add virtio.c
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
 <20260505-rust-virtio-v1-2-9563383909e4@pitsidianak.is>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260505-rust-virtio-v1-2-9563383909e4@pitsidianak.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/26 10:14, Manos Pitsidianakis wrote:
> Some internal kernel virtio API functions are inline macros, so define
> their symbols in a helper file.
> 
> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
> ---
>   MAINTAINERS            |  6 ++++++
>   rust/helpers/helpers.c |  3 +++
>   rust/helpers/virtio.c  | 35 +++++++++++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
