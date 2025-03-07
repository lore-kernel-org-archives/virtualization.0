Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D6189B91
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741312556; cv=none; b=sNhrXN+ZOf9q5VIacHxc0xeUOMzSkSPsy6XF2nbDszCQgeS+f6NcFHt4S3vzn1KvXxxZ/WADDi2OZQSkcdrYcDAIBCmdhsPJjxYLyS/XJFJ5Qv8DtZbiGDwO/VwOM1C7eiQ0PevnvI8TQ7moMXzPSyVXPc3xP2FALiZe5vt3zVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741312556; c=relaxed/simple;
	bh=jzCmZGAmwpg8bHyOWaxlRBOX2RWJnHDIlNa1nRCaMD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbfjLVMbiqQpADZjppQ0G6yfJegEkgfqM7663lYnSNr65Ez604G8TLHdhQhbNooWCpomSDVOiyS+g7YW3pL3IKIEtQOBtCBXXAqzZyuuN7PS5ckGrkD+eDfShgM9vUec6gQnLg//LsJHS1FC2beMcZcCsXodlUkFaMSQv2blv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pla5hmcm; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pla5hmcm"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C1E740691
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 01:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -10.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEOFnZctFE7q for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Mar 2025 01:55:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8F9044067C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F9044067C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pla5hmcm
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F9044067C
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 01:55:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6EB1E5C5813;
	Fri,  7 Mar 2025 01:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD84C4CEE0;
	Fri,  7 Mar 2025 01:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741312552;
	bh=jzCmZGAmwpg8bHyOWaxlRBOX2RWJnHDIlNa1nRCaMD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pla5hmcmfU6ZtpRhWTOzsslFVyiBa054pxuL5go/J3ZWEvP7lqtehS1RtojkvKTB8
	 WPOltc4Y12RSTAuftoMZGlfZRHKl6WbkyNuSJecUj/escsX1elPw5iZOw3vyloWA4z
	 j0gUGcwCsNgc0bXt571JJAJbMKPhJ7oV90et1yPZe4kNU7QPKQIsBY674NZraSoxSJ
	 OHgF4c4abqScmwgPIZC+8tm78Z6cAD4LSoyFopu7rWVCRi3qBJXTOq2CPdDfOMQ2dX
	 CxKS2ox3S14Fsb4Q5USTLGXN5dpzW6ex9cXPWVB0KykY93hF1BrQ4weU68SPcHJmvO
	 HLiinPIsaUNYA==
Date: Thu, 6 Mar 2025 17:55:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko
 <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>,
 gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v8 3/6] tun: Introduce virtio-net hash feature
Message-ID: <20250306175550.03c90e21@kernel.org>
In-Reply-To: <20250306-rss-v8-3-7ab4f56ff423@daynix.com>
References: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
	<20250306-rss-v8-3-7ab4f56ff423@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Mar 2025 18:56:33 +0900 Akihiko Odaki wrote:
> Hash reporting
> ==============
> 
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
> 
> RSS
> ===
> 
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
> 
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
> 
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.

drivers/net/tap.c:1056:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
 1056 |         case SIOCGIFHWADDR:
      |         ^
drivers/net/tap.c:1056:2: note: insert '__attribute__((fallthrough));' to silence this warning
 1056 |         case SIOCGIFHWADDR:
      |         ^
      |         __attribute__((fallthrough)); 
drivers/net/tap.c:1056:2: note: insert 'break;' to avoid fall-through
 1056 |         case SIOCGIFHWADDR:
      |         ^
      |         break; 
-- 
pw-bot: cr
