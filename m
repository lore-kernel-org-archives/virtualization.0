Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F81917D7;
	Tue, 10 Sep 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984211; cv=none; b=D6R7tEJOcPntoCSY3dwEbfkxPnukafO5U5VnO9P+kvwd/b8w7+W4Zy55S/3v+DL1yUPEIbSPbAyLJnng9QerW/D0McLV3Qm22wPlO2gqQlr5kunZImaWLvZDxc1lJ0h7FFOIVbM0/EZh43gA03SuFdRv1dlWHy2fHxyUt75osWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984211; c=relaxed/simple;
	bh=ilabHJFlIv3jx9OGdmytGZRjRg+7iTyA+0pqWCT0tN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNqURufRQciK3TEeksG0N41ph/AVGHGk9EqxiuFS+wd1ZHilqtitPEXiBFEbcZDTeMI4OvUWrSJ/BZ3wYDW8CCZxt21hI5U1Wj7wXy4cRI5m0/AHMVmuRO1gfdNHPkw4UyARw2339BeZyUFXbp7B2oSJZW+XJYMf2ps+TubTNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0O0gnlr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0O0gnlr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC059C4CEC3;
	Tue, 10 Sep 2024 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725984211;
	bh=ilabHJFlIv3jx9OGdmytGZRjRg+7iTyA+0pqWCT0tN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H0O0gnlrE5+rmvwTOE/GS4fSqEBcOhjWh6IqCQ6v2+QsISPkCmeN4GBKt3YWd3KrL
	 hNKv7YkOZBh2kNeTW//EBhApSb1Vi6k1+PbM09Cc0SEdbVcSWvwbRylOcJ8MYAs+vp
	 gy8iHwZsgOqPeY4dl500iBvtCZGB3pYyLivzmPgXfiqxZDfManJfZn3PCh9jIujhnR
	 s+uf56mNy+MEgUT53JgxbaHI7piVuidmZNBYKezhzsxVxqn69fo/BRVjnY7HF32Z7g
	 0n7ExtxxxkMpRxl/MkxuUsNyKnfTB+pL+5kjtWNManYDZb/6ljaWpwZq7LyXM/4IyV
	 t4IOzmSiXTAqg==
Date: Tue, 10 Sep 2024 09:03:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240910090329.721e538b@kernel.org>
In-Reply-To: <20240910081147-mutt-send-email-mst@kernel.org>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
	<20240910081147-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 08:12:06 -0400 Michael S. Tsirkin wrote:
> Just making sure netdev maintainers see this, this patch is for net.

Got it, thanks! I'll be applying it shortly.
