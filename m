Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959D326388F
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417333; cv=none; b=f4WVEarUquOkRTenSGasT20W5Aw5uRsRTFK2db2w2C0h26wb3gaV+sh0D/NsDLhmMS8I6vRSrn1+1/Q3T1brLYQ1MybvPE/5hsHxxVQXAnX5WlzdJSjpQOwocqvsWFJ+QsuNggMsy6L4ymyHxxQm1rLbwwWtN4QcD6lrUgrBwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417333; c=relaxed/simple;
	bh=7zX5aWXKrLXXfHIknWWq+MssxzWYqqZPISFTHBTePAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AX7V7gbMPZnGw7euVt75FhTjvieEkJIbwBtJbZpNnZApawfMOWTZJYuXl//wb3CjNd6E9Bcvuuv7pZnOSOSuSGKigBFse/AmPD+aX/1hQZOZM/LY/0dVZhkcf/fATA7nKfZyOxWgvC0r8X4tZe6Nepu5xpzn6X7wRKGwvB6K9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/iRPu3F; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/iRPu3F"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so7277457a91.3
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740417332; x=1741022132; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSwmMkmIgLqpokeXm1Oy2RMQPP6UHGDY7f3neUmxahM=;
        b=Y/iRPu3F6nY77Jgnu6opCM9k763hSYpie0+lJ/vRKV7pt3TTsBgfpt6DHzv9Mp7Kih
         4zML20A/hp+zfuDs5r++A5HEzMFMXU4e1ttPpetTi0PZgPk0wQ4snbOkp1x9jZdsgPH5
         XMi/0t55T6RD7X4ya5aPV2rbl2G6tCe7D5U/QHdp6T00FkyiGPc5mHP92f+x2sTAzlQy
         Z0QZDYdSIBLgjY1zAmdyZ2dXc9hQF8MFSkAroLJfJVFznBLppbNww5WbvEZiQNtEoXYg
         NmxaAAZGMO+8WDjawnniCwLRlITN5e8tG5DyMYES3CdTkyTWhrq8rC+FYQcNEExLkxNR
         A9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417332; x=1741022132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSwmMkmIgLqpokeXm1Oy2RMQPP6UHGDY7f3neUmxahM=;
        b=CmaZ8Odl8gP2QAXYd2h/0q7WJh3NwT9NvC7HsgdQD3haQlHJq8mlf7l/gRBqRgQIpH
         hOnh7ls7vDen7TnLvHcCDT3yneC5+fWg8mPWfWMNpeph7H5dYtJGpMRann/KoxyBGckK
         LnW2FMsY+lOAG1ZQSbjIozpDWKFLoVRiosC5igOLVsXzXoclrMn1o9gOZleft9zOI1jN
         QIU9nAmFGraGN+yydtr/fFaF0Oc9XU9C6BNe0ws3x3nYfEtdqldhvW0pe8LPKO1m7+jY
         R0HCzHUyjPwZ9SVBzkwo0CUrs0NvW3S+Kl/kZfVFNIuaPFu3jkwVqdTLhzvcnhI0F1Vm
         3cog==
X-Forwarded-Encrypted: i=1; AJvYcCXKr/X5ISrCqCY2Vm0hTRFqzkJVdpH3AHyUrUlBL3aRcIL2C6dfnCu5hDo1PMl/AKnqktnXfXHdBQdKqettmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCmq/jMOScIFChya4MV+rjaP+E7Pd2/jpUlVK0fl/wNk7xRxUY
	7BPQwm6RtNkTHF008D9HUXJrmyhBe0+6A/MRZDh9i4fObl093jw=
X-Gm-Gg: ASbGncsq9MgCUWuVa4+EJSXQKJkAxcCg4vAMh5t0WgdMHm3DdTnrE0YW3dwwbJjxPSp
	uMuQR1SRtaIJ1mG8EPqoIXuZZcqzkvVa+RRCyWOL+xPxWJr6IBjrtTG4jxbMNHVZc0GIHKN/Y0w
	b5twkeBRzrd+mqU2PraOBemCotpEJH5R+bKt2iKGvww6NyIvbYFWkJJt0ehLsn8tetXF4fhlpQ9
	ZcjAtM6CJe1py58ILuS6FbtdNBeRtaI2dTd2RY7MnsbF54cHSSlgIh0iwM2GvCfUpIxPKrtv6hC
	iAUwmLKorzFvWzWPhjeWJxJSAg==
X-Google-Smtp-Source: AGHT+IFWarbUxrrczcIr8TarroVGKxHwHMvRfgBRrDRlPG93ZRUc7qqfwewXv5vW5TnFkQrdpVqUBw==
X-Received: by 2002:a17:90b:1f91:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-2fce75f1e43mr28310275a91.0.1740417331691;
        Mon, 24 Feb 2025 09:15:31 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb10fb5bsm6766211a91.33.2025.02.24.09.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:15:31 -0800 (PST)
Date: Mon, 24 Feb 2025 09:15:30 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v5 9/9] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <Z7ypMjORvm99q6L0@mini-arch>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-10-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222191517.743530-10-almasrymina@google.com>

On 02/22, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

We need exit_wait=True for check_rx as well, but I'll send this change
separately.
