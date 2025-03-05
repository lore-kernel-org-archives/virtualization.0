Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF58253342
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197135; cv=none; b=NAGvy5GtnwPdhVxIA163VS4KJDX1zx7Jp/A8n/EkgC+CXtiC9Ss0BHN1TbbE7tSfmzMJjFmOWD14m2UELBVQGQNffnR97kp07rlN6NpI4EMAm5doKqIAH1nn4+XpfSv01uBMH9HV1hnqbEnw4zNJ9IMl0GtsxRWc/x+cDlrkwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197135; c=relaxed/simple;
	bh=+fO6QHFZK3v34T0UbQQG+Rs4wUa/4vaaUqJFHDD+cJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LarKI+jOkipYcDAIoXzRh2KndIe2gJIv3Xoy1tF018jeSYyJvlBX5uPb6k1jgKvd7IHqgmf55SPNFNVvUwxcabkKEdMMyZJDxqzfiUEgOX2PuLpfKzUPyWvKoD32d9lqhljqn+SIwQoAuUqVLSLTokfZKJdsba2vChGrgyZmNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLjGYBKb; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLjGYBKb"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 42377401FB
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 17:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NvWYPw7Apfz for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 17:52:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 38CA0400FE
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38CA0400FE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tLjGYBKb
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38CA0400FE
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 17:52:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E0AD5A45C95;
	Wed,  5 Mar 2025 17:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60757C4CEEA;
	Wed,  5 Mar 2025 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741197130;
	bh=+fO6QHFZK3v34T0UbQQG+Rs4wUa/4vaaUqJFHDD+cJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLjGYBKb2Crad0G/NITWxBaBxqZgqDl+WHtPV/INm9ZGzYEuYRxMovqxsAw8g9F7n
	 6GKC/zA3gIBNEe3IQbEIX2voyimvey/XiDv9YyHcfniDhPi/FtDpb3ckaaSo42teoO
	 gYN6zX8dZV+z9eCW50WR45oIzlMXO5CT+FQBwNCYKERCp694nN62/2glkpvvAMxuaj
	 RGGx3yukJw17Ry7zuiXdoE721k8i4Uc812+jnw16YiKYjQ6U1haNvUewQLZMYfHrBd
	 MCWnPFT80c+anlS38oocNHqYco2JryFGb/mlHMl+dQktVXF12U7BUndPiZiRE20Eii
	 HUn/+p3uqdIEw==
Date: Wed, 5 Mar 2025 17:52:04 +0000
From: Simon Horman <horms@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH net-next v7 3/6] tun: Introduce virtio-net hash feature
Message-ID: <20250305175204.GP3666230@kernel.org>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
 <20250228-rss-v7-3-844205cbbdd6@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-rss-v7-3-844205cbbdd6@daynix.com>

On Fri, Feb 28, 2025 at 04:58:49PM +0900, Akihiko Odaki wrote:
> Hash reporting
> --------------
> 
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
> 
> RSS
> ---

Odaki-san,

Please reformat the patch description to avoid including "^---$".
Git will truncate the commit message at that point,
excluding the text below and your Signed-off-by line.

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
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

This one is ok, as the commit message should end here.

>  Documentation/networking/tuntap.rst |   7 ++
>  drivers/net/Kconfig                 |   1 +
>  drivers/net/tap.c                   |  62 ++++++++++++-
>  drivers/net/tun.c                   |  89 ++++++++++++++----
>  drivers/net/tun_vnet.h              | 180 +++++++++++++++++++++++++++++++++---
>  include/linux/if_tap.h              |   2 +
>  include/linux/skbuff.h              |   3 +
>  include/uapi/linux/if_tun.h         |  75 +++++++++++++++
>  net/core/skbuff.c                   |   4 +
>  9 files changed, 390 insertions(+), 33 deletions(-)

...
