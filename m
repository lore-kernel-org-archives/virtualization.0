Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965892;
	b=otnPHOpW581FedsvkHMdD/sagUv+zApQq8IurUZC/gaElBGgkbZS+y61WnUe9HrYQ0hF
	 JRYdcP9Nj5iICSIxmhUe14Jy6vFJpexpVaZ797f/8SARTlXkYm720CguMcQ4ju+/Ncwis
	 Jdoo8C5ZTv3hCP7O2dSMccu/uYlpqWO7n5FDjbPN1DZ7c55Ig9EmY7XOA6Uw4fwiGROIU
	 HLJxJxIC+G350knev4AR8Ox/BlUMX4kX2Ni3beuwU+tM0D6PhK4AUdWe71wXLcfhWl/is
	 UA4h7vCPrJ+EewImg1/iKDncqGae5ZvqsYoTMxPljEq21YnN0E3KNyFrbog/UOVQVhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=DgIC+LCfWRa+mXzrTrAuCo3rN7Px/xGkP0eV60iac3ZWrqEfD2bGm+3IGF0El307hftF
	 7l21b5F6qeTKby2XVkQdHgkN9CQTJTu2IkG1c1oK2Udy3OMfBinf5YSVfJV75ZlNTBQmk
	 cU2iFxBD4/M/ghdo06vOlfzjRCL4YBcfOri6yMXHGqAKTVWjiT3UTx3q3+7ezdVxOOwNl
	 0jUlsFuDNopqEMNo2QyGAtR59I78M2ZlDkDUXCgaasjuOkKCVHKWPaSdY/WSp14JF6mLv
	 OL4pbISwgt6k5ymXwbhiNGu0kJQFTk94AsR/WEq9HyHHDFCAyXrBFma1BeeIdEmA7RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnXjqYEf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB808606A31C;
	Wed, 18 Nov 2026 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnXjqYEf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA51F000C4;
	Wed, 18 Nov 2026 01:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794965891;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GnXjqYEfkfvf2wRpV0ki6w+VZ4PFWUy/ssKslstK+7bHmcCyNHAJgH4BxYQVrxNlt
	 e9+t3VLhwqPfX6CxyEXpMY/sc/Jcttra80iRwR11pU7Domupdvevkh0ZNURvCxhRXy
	 72yIUjQNqb7j+oIzGk9pRjlCsN9ACQMmzKEUCPpZ2YH9quY2umVw/lhwXnKghoGMo7
	 A+OxJC+iQXgOYJYNtuhYKsrybGCXOl5udXXAY3DpGJhf1NoB2Cr8YP//WH15A3rNRw
	 ZkRlvTLUr7aOCMcS1c5LJIejqUnU4eAveEdJdJuAVQTbAi2ztcFecQ7yb7j6FpPGGp
	 Au2yTaVGpIXHQ==
From: netdev-bot+sinfo@kernel.org
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>,
 Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Zeng <kylebot@openai.com>,
 Michal Luczaj <mhal@rbox.co>
Subject: 
 Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect() fails
Date: Wed, 18 Nov 2026 01:38:10 +0000
Message-ID: <179496589050.3291.8051739757077166191@kernel.org>
In-Reply-To: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
