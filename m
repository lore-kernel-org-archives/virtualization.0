Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605285;
	b=JNwsf3aU5wP3qavt3ZovUTPCXF6xJqNV20i/USiQjJzrWST4S42+kRxFxrxdCcBNjtjr
	 uxj+U0ynCgR2/EB2x2nt9N+8L8Nf+5u2CtP7KXfgZGpwB3ed1wByhOGT1coasOrN+qh42
	 aGLhNtL5y9F+uvJLeYZSmorYqpOyvBS781xvorzo5BOULVodxa0QNcUCcXIk/XOfPTePO
	 ylrgOy+8JdQYUzxFzhzI7vNE9eks0AMyizEv9arzWHbnAlBWSWLfE1BpbXZajPIwfzVx3
	 kfsdEDOl9mm5/rQi9DAka2kNuK6eYc0Y0vHdJveEupcHMSWU3O6wvD6uxAuS8px/4Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=lRz4tP1fZxrrQHHS3vIg61PS1koQPKaE78djqCF5qOaP8vQ4wjMPABi/4NqRmbNFyntP
	 La6rR7fhERfyZzn/q4CSqrF5007e7EIBzZxtAi/Z29DQajEtdaQ68rp3CODArKnNoDfHb
	 CRPuuAuvEqVztfzPWaGR/NNKhnHky2m7BkL1la7+UI7QNI8rW25TaUAGE5l+vOwPF/7R6
	 ID6jT+AHL/0EOQFQUzcYdFx5rvZSKGFeGlq6o/KO0Ydp1KvzYoYkZfxVSBJvO4eoGoLvQ
	 rIl8sVip2dr7Dov7Y4gRuXTRRBQvPwc87eRvCvFkoA5KmXj31FuPyFM6lYSAGByZ4bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4DAg8dC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF5606A330;
	Fri, 13 Nov 2026 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4DAg8dC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDAE1F000C4;
	Fri, 13 Nov 2026 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605284;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K4DAg8dCx3MWAWVHsNxZSQOZ3GOQTnJP/KPl2yZSLbvTcX6Qo/9Jlyt8XzSZbmlGP
	 zNOlpPvCeUb345ztnV2tMUbEFIdXu9c3zUctfBe3ixocANkOiDdH0lG58groV9G80h
	 6Kbk6OQE+jHm3l9uK1e5oP5mjl3+G5HuCg4Ft1KWwu/+KKAK96/WjMwR4CnpjYn4Hx
	 I6YXMkiR3PaUpgWHhXJV+Sq7/RRPwSxgwYJ1+JqNeUM9u2S1cnSEngzw0Do3wuW367
	 SaRLxkl82VHWiRtM2WCUVJJvj7DUUI6+ZbKymkgN2efosRIBzMm+ptmz0cYak1BasD
	 DK4h/gmJj1Ctg==
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
Subject: Re: [PATCH net v6 0/2] tun: bound the NAPI receive queue
Date: Fri, 13 Nov 2026 21:28:03 +0000
Message-ID: <179460528309.2168702.1406827506655543594@kernel.org>
In-Reply-To: <20261113212237.1742984-1-antonio@mandelbit.com>
References: <20261113212237.1742984-1-antonio@mandelbit.com>
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
