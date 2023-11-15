Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C62E852
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 04:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pErthgeD"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 977E481B69
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 04:23:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 977E481B69
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pErthgeD
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id liabO-7qx4sM
	for <virtualization@lists.linux-foundation.org>;
	Wed, 15 Nov 2023 04:23:15 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE014817C3
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 04:23:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE014817C3
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BC2FDCE1C45;
	Wed, 15 Nov 2023 04:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA9BC433C8;
	Wed, 15 Nov 2023 04:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700022189;
	bh=GwyRQdupYWEx39i8GPje4vSvKw7QVNRwxwRvkzjvais=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pErthgeDMY7HCj4Edusuhh5S62tHBqZsO2U6OQrFGXnmQZrD6fPq12El6FfBIlAiy
	 ekLwoSmbBNbiMjjJQTmlXBL3HFQ3/6NImx34OMXZgaYSQeqNuYnOZS1Nu+bQAajunt
	 usKuF72ErI8vmBv0bg+6fPGunTn4NOUfNTkCzRk8Q5OOQABRwM2dw8zKbMegy2YlCZ
	 xW2lvpFLOPuSx9AEB1WhqtUjPhNQqlZEy7kum8lhZ2MgQj07AKsKJh/INp7Seiv2CN
	 60LXxFmiUEUh79qMZq7vYudY95EL3M4m0UxhJR0RAaNmmWrt8Q19GiGeAMk+Ck6uDR
	 +1EKYW2fL0hGA==
Date: Tue, 14 Nov 2023 23:23:05 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jason
 Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Simon Horman <horms@kernel.org>,
 xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 5/5] virtio-net: return -EOPNOTSUPP for
 adaptive-tx
Message-ID: <20231114232305.4cd58415@kernel.org>
In-Reply-To: <6a79229fbeb72edf41185a45a0f9ea5cd87a1086.1699938946.git.hengqi@linux.alibaba.com>
References: <cover.1699938946.git.hengqi@linux.alibaba.com>
	<6a79229fbeb72edf41185a45a0f9ea5cd87a1086.1699938946.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 13:55:47 +0800 Heng Qi wrote:
> We do not currently support tx dim, so respond to -EOPNOTSUPP.

Hm, why do you need this? You don't set ADAPTIVE_TX in
.supported_coalesce_params, so core should prevent attempts
to enable ADAPTIVE_TX.
