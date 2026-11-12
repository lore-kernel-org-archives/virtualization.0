Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479765;
	b=k8Widv4MnM1ImJdzqEpaxfQFyMii/wpVLKeYC+z6gOm/coLlj2G7YknhmFYWD+hE16ck
	 Dtsds+YvsPaHtma55VHzYpAvn+0wDq2DQeKsxYaIgcedbcppk5XK1DyIrShVwgwOSN9aC
	 2oTFiOD5Ej+UoF4mnTdIa2YGht2/FZuhd5W+aMXzzAmNttUn8m4Aqr23rMBjxnlY+hIbr
	 AaBXeUaOx89AboxNLbJCCa0BSBKbyH7M5xiQN4jPaI6pomNQJ9lnxygdE124x6jIfDiim
	 uFn3H5g/HdKdD7LoDgpp5y/32CxH0X0Mp4B4CqjFwdB2K5nUhueJaLxDdhlvuFbPxpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=j/Bxe31uh+K88h7Kj2TpdwowUIjH8uqq9fdsvSFZhzjXGWRn/7NAzBxKRCkuD+LBUC8z
	 qnXFCDF7kL23CrfrCvILR70s+Yl+1Tbr0EOysiEaBcrYP1CEy+2yxoN7tOsenZD2dcuMw
	 t9t/gke7TB5wHDt/JEpkNRHrPrRCyUaKhq/j4SzkTk8STzG5WZlkgCih8buUh68XI4p7n
	 5JwFvaqPS6d5fLewXleoyPFjAPewaEoHT84EAoy4FuKy/VPXHGocmt8Uv3gCEqMJbMEJn
	 /416syM5FaBsZ/rawvPjuwGSmRNL+5hxPtS/jHf+ZnLTNECq0uak1QAdwiCXqcskgoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jF0m7nsy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C2606A330;
	Thu, 12 Nov 2026 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jF0m7nsy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641401F00A05;
	Thu, 12 Nov 2026 10:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479765;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jF0m7nsy/kOpUGPVDECaxy+z1JQjd3q1T08tClg07MgBE3iS7AJ5qozya9SlbI1B0
	 AWZH6hP03z+wJnCele/zlNXt83t/Z0ZBmV1lzq76cYAAavzl+JWjsrbuFVvkEYUrft
	 j6bQ15E+9Mr+TZc5KFgYeFTCgr6ad77hqmcruJtnr570QwPTwRFV/9W12YJxlk/EoM
	 U6PC72fVi7yS/bNa/pogqyjBlnD07RPYnQz1eZErxIvZ/1Pej2gFSTtowCei3/fGcl
	 2tlUlf34k+J6an1jfJUjdnJUGUMDSYAwuz/pyE16zkVnDPbbixL3PqBH1cp+hKrnsD
	 sEtRi5VTeun/Q==
From: netdev-bot+sinfo@kernel.org
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: Fix socket state constant
Date: Thu, 12 Nov 2026 10:36:03 +0000
Message-ID: <179447976386.2168702.18392043659968828325@kernel.org>
In-Reply-To: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
References: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
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
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
