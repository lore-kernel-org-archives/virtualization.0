Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873160;
	b=b00h6qqn/GI08rp2qDj9YStcvFjhe8GB2KxHneA31gDoPnH7+h0e0rHS92oag/kYuoSD
	 7fZPCy54ze0GjK4AAShwzD7LUgywsWvOGIQzJSAHAThjOotWX8URdW2UqSNcQDeip6tKs
	 R53rGkddSxcubTLl6IoX6l4DThcCV7daePhgw23Vob7VEpe/b+B8gORHcIfmeAOfCymHu
	 +QpaKGCiPgVOsqFaP1H0ORulMuVWJGttMaPGF//9cVQCe1iei4d+JDdpacmq7a2v191HO
	 y8R0YguFME7x13hac8lBnL9qFSEgKygrRG8TO3M6jq22aQUk0WK/J4ZZShc/1ZyrLmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=eOH7g5/0hgt8+48CXosE/GDQbrziwEaRn+3ytCzl98Eslu+aQxgnzyyaDhYposh/3y4/
	 CmVs8wLA2kvFTY3LUhtQwsaa7TZGE/qucP6sZKWfMJpa/GSlR2qSqUjgb1BWwNLjpWCWU
	 S9ZcIIblvjzzJhUUxO7eLCBjDfx2mEyS6O9fNdpOCWhYcaJb+RGgDvW515HzHPQj1KM6B
	 uoAAm9xgybyGtNkd48xceax4bV19F0pemtHh+reuV2KeZutgIrvHe93NQh1E7bnQXtvxR
	 Rkwo1M7nqbLj1U4dOCk02iRqM6SiIdxafVRuLd7/w7laYAekcw0SaC5SVU//wMz3Svg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2cdKXwp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E49606A32F;
	Mon, 16 Nov 2026 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2cdKXwp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF161F000C4;
	Mon, 16 Nov 2026 23:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873159;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I2cdKXwpKnMpTII5LkX/pgrtz+M5xpCpMEOm0Td/SBKSRmO3f9LdjYz1BUKk0nziN
	 skg8TQ1JXNcGcAg6xBIrdYeUkD7m0vNwmzqHIhq8HqNRadEU417+OYN9O4MP8fVAvB
	 fMZqtYV/1I6/89pSm0o7DGSEEXHdiAuJPa5qlnC96mUi0k6g9QxhA66cHFc2BL8l2V
	 0dVisxBhG/N/ESNxa0+IPMXbZqsUSPqcXVw69232qaToqZn+uTeyjDR4A1ATmS7T4s
	 jmlkqYF8GvQCPYyagYaC8xKpkCp69NoZjCuz3VFa/a06pKJfNt9RjHWisiW25AAaKm
	 DIeMQKFd6sNOw==
From: netdev-bot+sinfo@kernel.org
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can reach
 the device
Date: Mon, 16 Nov 2026 23:52:38 +0000
Message-ID: <179487315810.3291.12142099363352099423@kernel.org>
In-Reply-To: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
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
