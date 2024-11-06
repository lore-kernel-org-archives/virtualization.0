Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F4208989;
	Wed,  6 Nov 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918200; cv=none; b=P8+WZsY1k/udjSlbwQhobNgDlLykVS/LPj1rdj/XkvakE/H8JCzR8UGrVj1uHZi+CPKG+tAWlUHp+M/OsXtvz9GpeshwgUNfMi4Y97JMM86DD85tTUWKgOojO7UjDFr/SPK68Ni4gfx+mjlydrSQQDLj/q38sozOfkJwPNmqZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918200; c=relaxed/simple;
	bh=w1LGkQLJAkhFFIWWR2Rj+kYY6tXw++E2KX/1UqbMa2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LB2bXF1ERbWmRc2kWh+kB3A5pMgHT+d2OTy7Tq+3DPZD5xsSIbahBF57rCfQPQ7a8ggu+EhOHaTYHV38BMCtkB8muP+mCfaLJn3pBSOnUSUG+NS1igI1Sl+BhhiVt9FgV1ITgTyv5bpXmgYmANakWPcCFLqxHYzUNT0x+DVW5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO3X2hSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO3X2hSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD01C4CEC6;
	Wed,  6 Nov 2024 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918199;
	bh=w1LGkQLJAkhFFIWWR2Rj+kYY6tXw++E2KX/1UqbMa2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FO3X2hSM9mV40CF0N17r3ps/mo0IScu98QLTAEf6BDzVdY92YE7l9iqndAiyuwxFy
	 zWezaEge0VhI4xTAtFBh0N+9AnNNah7cZpm2zaxY73SZatX+AUphq2yxnHPA9O/QHh
	 FBsiTOPGWtJFrNTBP8ugEB1O7joUN/0kXO2ChfmGzwY/9NAFH4Rf+D042dolc5vdyc
	 7wlKOteN320PM4RBFf6QZp9WOk70OgP/w0pwuXv1/q4Z5u5iFqsoS+VqSyfBzAd3m5
	 juHnpf3zVulbElGANxgMTNQiWjX41thv6yAcRlcXZkDD0bYqQpqtyqoaLGDeTMptbp
	 H9P3en/clcLjg==
Date: Wed, 6 Nov 2024 10:36:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang
 <jasowang@redhat.com>, netdev@vger.kernel.org, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by
 default
Message-ID: <20241106103638.5844fe15@kernel.org>
In-Reply-To: <20241106041545-mutt-send-email-mst@kernel.org>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
	<20241104184641.525f8cdf@kernel.org>
	<20241106023803-mutt-send-email-mst@kernel.org>
	<1730882783.399233-1-xuanzhuo@linux.alibaba.com>
	<20241106041545-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 04:16:07 -0500 Michael S. Tsirkin wrote:
> I thought it can but can't remember why now. OK, nm then, thanks!

FWIW (I think there was confusion in earlier discussions) we do merge
net into net-next once a week. So we can always apply stuff to net,
and then depending patches to net-next within a week. Just for future
reference, this patch IIUC we just leave be.
