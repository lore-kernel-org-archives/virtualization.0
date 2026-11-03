Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716081;
	b=LCtoUBzR9fAQ4LHikW/iVgdY5/R+efGtXmToLN7r4VNXZ7/OMyYYcK02dVgrP4IFfHIE
	 c7QuvKjxe/q+uDoNDnIwZOg9TWt8BJFMxHiPJ2yzs3HGtiwogjbFY+0IjBOwpb5Bws9hx
	 9rL/fvo2Uz8KFhylyADng+2VizmOauiKfmIW7tDDHPL2BSX0A77oCWG7K9/12VxZhVp1b
	 Tp9T3EcwWfGLTEFEUtO8Ou9goPe0Pf3tBvRgY8RG9gysqovn4Jk6wDjyjH4IKYhZp4OJV
	 yERA7TOEW2R+GEWOhJvZFHrtBeTL0HZZqm+NJ8+kLsfew7vfT+udm2Y6GT3i8XLYjmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716081;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=sgCEzOG5MmlwroamKp6HsP5IgH649KiGgr5TeVMmM9eFBzB9VU40yezASGZuQKH7xnVz
	 ist4wogupJ2YOvcZMVXs5wzXwPS9TVaYpaD7njqi7lMYFJm4Aa++VQDjUsJMtyKrBtAp2
	 2q08JcTntdRbpcqHMHr/VZJQ31oeuUMVuj4pup3/7da8p4QMD+AxM0/WBCGAiXR12QhaU
	 b/hoicxz+63QOpDBAzMde6sfP4Ufpl40RYSsQ03DUWekpjISbYu+6j/JVY7Fm7ht3nzuB
	 1MLhTdvmO0CrY8ZOQfCNikOq3TVxZz8eKWfbuyhfxhuUfE/Lm1YHkUAckXwk4lTEHsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHpjdexY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D1606A328;
	Tue,  3 Nov 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHpjdexY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732951F000C1;
	Tue,  3 Nov 2026 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716080;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HHpjdexYLv1LKFZhWNvbOPCNPUsD/VZW8osv5/BChV1k2ouAGtlQR9SQn5QMzOthq
	 m058MRJH9UbvslLaBI1qYprnEAb8vklbQkkWKgqM/Npgil7PBBZAAGOM/gYC2e4srq
	 rPcFraQzJMLo3j+FOTlKmjQbtfV9Xd/gd7YWIn8/3BJ3zXJCJNjUHtdy3R3ELgP197
	 lT0QIgG9IL6pFlvA0J/7Vn0b4Uv2Dlpc9L6O1HBJJuSxrNGQYxxgx+qK3FnWOD3K5L
	 2903gMFeOEbJvYRba/ie5qyjb5Sx1gCrtsdqtfjwmUJ8k8Cn3QHuJWrjGCfIeJAgzn
	 1ATTd+1lQLj9Q==
From: netdev-bot+sinfo@kernel.org
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maheshb@google.com, peterpenkov96@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] tun: bound the NAPI receive queue
Date: Tue, 03 Nov 2026 14:27:59 +0000
Message-ID: <179371607900.488859.488506175171813009@kernel.org>
In-Reply-To: <20261103142232.1869185-1-antonio@mandelbit.com>
References: <20261103142232.1869185-1-antonio@mandelbit.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
