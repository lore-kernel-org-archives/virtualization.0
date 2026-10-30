Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342982;
	b=XsdmaZEj6XhM8nsnOnukGiix1JbDI2XbmBNiZVw7FI+iNuSvjOjsLCSE+hymxfAFTKnu
	 hcEctHT2VeMStcrnuAGLDo3D9RZbN1pK/B/y1tmtIeVuLvo17es06l5iSQzvTcPvESa9D
	 t788URvZe3HtIjkJ+CrG39fNtcKeWVzR4WWHAseX3R73or3GNA8NYEylRW4rC98m2INL8
	 EwjJZIU3i5eXHMnyA+Rb1NXzKaUVPh06+5xNRMAGD5J4SaBaUnIZtGg1rYZbhWQixusKQ
	 To7ZQ9GXpoyxmmwP4e5LxwlHJmzxb1568mX+YGuC045+qjoUSL4l17XKQfFCt1VBt6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=EySoFa/ZIZHCHIXeDpY/aJJ2gpzeqhU5J0/sqDK+bhVcitJ8tzx2eVLSNw1cqKJ5NAw5
	 UfA557BJaX3vFUmZEI5VYK4ku9s+fhGvbmWpJwWIXc0Kku1wIeVbVEtioqHGkFJocl8Ic
	 s3WbYLRYp1qARAp+g/OXW64LmHHYUNPRjxTzeDdPn+Mqg/RCf3EmLemCqHYyxNc43DDSC
	 vrBod+CPlFgRLsiAJQ4CO1p35DUz8lKogVOa6acrYPpxaDCffC91cr3wIlIZrkCVs4CsS
	 6cNWnGw49gPTKPuvY2MjdFsDF+mpqaJzYlUYezeHyGP+F5c614fC0cu9X46duyDzJUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgeKKIBA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F739606A330;
	Fri, 30 Oct 2026 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgeKKIBA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E231F00A16;
	Fri, 30 Oct 2026 06:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793342982;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HgeKKIBAv4oAgyhSJMc/9Ghzasu+jgG+IWHLxryqLM794LV83Wkpd5hFsr9lwUrXc
	 2SvZozjAICf3mL/PEyu8jR/g08uR9X47889ST49tkSZWL4E79Tk3slPa2yVMa7iY4H
	 8yntpojO6js8sJ8/WZxyOVzPNig8FRZQCUQSqBS67V77m6g5aF9ImzZKeH1EgTXCE4
	 HWdjkPPO83L9sTAspACK/SP/n6ZvRiMaVWyWa0Y9Dujaj3OO0G/GhEdlqLZUf8f3BY
	 rJ3cWVWrUWYXfv3jMf4MeGY5HnKg6/vRLVkd5OBND6a6Bue6TtIsFXagLPnPCN9hSS
	 TgaH2QolMzncQ==
From: netdev-bot+sinfo@kernel.org
To: phind.uet@gmail.com
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>,
 Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] vsock: reject negative tv_usec in SO_VM_SOCKETS_CONNECT_TIMEOUT
Date: Fri, 30 Oct 2026 06:49:41 +0000
Message-ID: <179334298102.3327.1583406776463496240@kernel.org>
In-Reply-To: <20261030064428.73930-1-phind.uet@gmail.com>
References: <20261030064428.73930-1-phind.uet@gmail.com>
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
