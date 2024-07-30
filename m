Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BD1B5808
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354436; cv=none; b=ZLeS5A6gK1fBvTLtOeDZzVIeVB2f9rYIus7O9SWse0VCbWkMZIlx+6BGIMGcTUOA7ZkjRYXlAWMuPRo7TMhFURKuZABqkyvnKtDJ/DnxK0FhFnd3m5yL8YbkscDQdinHgcqANGSvX5u/389Wujcgpu5SIO3aNX8qTTazVVso690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354436; c=relaxed/simple;
	bh=tZTmCW5GZ93dLZfDm1v8+9DRshuBQgUPfGjqVhe9ZhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF5cnEEVzDLA4dGkAirOsX1FVQxt2B6DNYCG+qfFU2eXwAmqamfg5qYUkb+I2dGxgqd3KkjjiFeBnJVJJLr0yODYo4OeVVKav8mM20uiiqfVUyof4a2vWz4A7r5N5mndKBO86ER0x6VG185yvtudTPNOhWDsEGy75F3j1RtAGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiaPHkjE; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiaPHkjE"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3228240482
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 15:47:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4cBDkN4YLFNI for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jul 2024 15:47:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 408B8400F1
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 408B8400F1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DiaPHkjE
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 408B8400F1
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 15:47:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1984ECE111F;
	Tue, 30 Jul 2024 15:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5C0C32782;
	Tue, 30 Jul 2024 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722354429;
	bh=tZTmCW5GZ93dLZfDm1v8+9DRshuBQgUPfGjqVhe9ZhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DiaPHkjErpIoh7tbTHA2BkSuyZEHOL2luROddx81dyCDgV/01X9oMpto6T6HMOuiW
	 eufkPP1TytFgdz6OiWzOStPlVMJPLLM+woeYyq1qNZc6jz2u6LijjWnkx3EQ5vfn5i
	 RwYmufBnLVyPFnfnCubsnk4XE0JfPj5EaYk3PIcLiPzgHACZcf0bvmEeSCAvBjNBhO
	 2V9TRCEurUbvSJrhoEiZsYOYigVH5e91KIgEFU7UkLxp3TLGMOSou5fQvsC/BV9oAF
	 +uXf06D8Js/wPCs4W8Tz+rKxQG+pbHZuFFdR8RRLUzDYE6OYt14MnFqOFuuS3+Dki8
	 E4h74czh47JzA==
Date: Tue, 30 Jul 2024 08:47:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, <kvm@vger.kernel.org>,
 <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
 <oxffffaa@gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: add me as reviewer of AF_VSOCK and
 virtio-vsock
Message-ID: <20240730084707.72ff802c@kernel.org>
In-Reply-To: <20240728183325.1295283-1-avkrasnov@salutedevices.com>
References: <20240728183325.1295283-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jul 2024 21:33:25 +0300 Arseniy Krasnov wrote:
> I'm working on AF_VSOCK and virtio-vsock.

If you want to review the code perhaps you can use lore+lei
and filter on the paths?

Adding people to MAINTAINERS is somewhat fraught.
