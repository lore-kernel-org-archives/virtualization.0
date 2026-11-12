Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502415;
	b=g26tAzPJgeZirBHd5YvMz5URodLJnTblKf01vZ+TQNnf6LMIUbBJ1360IS+j0NWvBHCO
	 2CZ8xqYeDyYzh+nwWqHsuZF1QS36+zqbOl5ThaN8AXhiOxIrsqRVPwluEhMV7LdoQcr8Z
	 uvmGxFGim7ZlkxWZ8NIDQh2TPt6NZ4T9PgYxDBWCOkBsYevF/r136cKpbzbzJBDFvoy63
	 si0aS5J154HZoAvtuCXIM5Arb/HsPaoMM9hSpnq8kCBhc2VIUAk5CllVjr/DP+CNbSHsg
	 eQGhd1wCYc9UD68QnNYQ06C7liO0hd5cCllHs7ajVIdhMbU92J9fhgEVFq8VE3f+yDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502415;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kUesCCpeSihhizE+ryMsGam5gkt2oL/j/Joc00r5DNc=;
	b=sgny033oZaNrA1zTts28EkXGJwiMUJYdQmwCQ8cNJB0faVv8JNey2Xms5WGSpzu7d1ln
	 K8VXz0yzK7y/G6OSh6riwSo1RGOg1cCJF4tN4go5Ji12hktwfAo2XAto/3/BpAsMxUGdw
	 MOwS1JO4WPhe69IKEPq12ywdmSGJZd/jKBAdboqNOPf8glojeu5CVfMztk/bSl2XQpop7
	 XF+x8P2ieZXv5pE+NftDJZeCwNqi01VJ8a2z90gRnonD8YkLDuIO8uzE1Q6xiwb1GDwbj
	 iRZvX/I/SrPSYLV2YLOwXw1HlPK/Kpd47hza4l/7A+1GF9frSGi/yHfEPd/+2OuVSuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ML4tXTMR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29952606A31C;
	Thu, 12 Nov 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ML4tXTMR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7414B1F000C4;
	Thu, 12 Nov 2026 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794502414;
	bh=kUesCCpeSihhizE+ryMsGam5gkt2oL/j/Joc00r5DNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ML4tXTMRuQPNOPSoszh5R0pfwKAhIx5zHlg1LhoCuK5VA7sv2nSyM6gl6oSeGtuHt
	 DBl2xctqAu+tua6sz/sBZjw4RTAmeaQdZxruL6Acisc5Ly/MEgcpEu5D+g3YK5+Sps
	 ozh7BpDB4CZQrm9qSMlLS1q2vhuzTSvaQpUMhiaHkPKYkpthffJ0TVMcKFgidEJwWI
	 aKOB5Z/i8fE9sZyDiw2w3wJTlthfkHLC+tlnkzEmzmu7QzdHz68DWxxEpmi/YDb+nZ
	 XQJJ5yzwqffB9XdzeldfRAKT5sR65dTTSV0k19rff0u2tr7NVzRbmZc9nLqJnRQkxQ
	 dsLqWX/+HMpXw==
Date: Thu, 12 Nov 2026 08:53:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Longjun Tang <lange_tang@163.com>
Cc: mst@redhat.com, eperezma@redhat.com, jasowangio@gmail.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH 2/3] virtio_net: introduce an RX queue watchdog for
 stuck detection
Message-ID: <20261112085333.77476864@kernel.org>
In-Reply-To: <20261109094310.103979-3-lange_tang@163.com>
References: <20261109094310.103979-1-lange_tang@163.com>
	<20261109094310.103979-3-lange_tang@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 17:43:09 +0800 Longjun Tang wrote:
> The backend raises an interrupt after adding buffers to the used ring,
> and the hypervisor injects it. If one is lost (e.g., a transient KVM
> failure), NAPI will not be scheduled and the driver stops consuming
> buffers. The ring eventually fills up, the backend stops notifying, and
> the queue is left permanently stuck.

Can you say more about what platform you're hitting this problem on?
An what's the virtio backend?
