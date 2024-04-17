Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111107EC;
	Wed, 17 Apr 2024 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314319; cv=none; b=W+eszqBlviWkhsgaO/NHOeCaSEPHdhaq9UcHkd6c8hEtRfi1ZWF5jFnFv86q54IX59UUpGb2jeXHBiAuyCzC5dBPFe1ffWjS0n72yxJfX1KMcyTnN5RzOvYnsbjo4dWJlnhllkD5Lp+C3WQYL8LNH7irSQ+fNlo+SOTnFL2eark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314319; c=relaxed/simple;
	bh=8sPreGzy38jwLJbiaLTW4QbosqbxP0HM4a2/L+7E15w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUiP5xwFvNM3nYnftSPcUNJTjMA2FTiY0b12wmet9ERVp+RISp1zY54fbkeHr/RNGo530HAsWnddRR7JAuwb1Ck9yjsTP5A1/2sikjVd5uTsYQ8XBIOiVSNr6u+1BybZaHLtYswg4BIpTsLN31FePQNZlfBhM/L8DTzoxqsUAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9WE1/X7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9WE1/X7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E232DC113CE;
	Wed, 17 Apr 2024 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713314318;
	bh=8sPreGzy38jwLJbiaLTW4QbosqbxP0HM4a2/L+7E15w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u9WE1/X7536tRngNyYIH1aU35N0XDdOXMhK1JpnlRo6KPd0+sr0n+q6aPLTux9qQ4
	 sFTx7YOFnuvqcPKbeeLUbNzo/DTrYTJMnrBV/fBs/DdZ4ribZU+TRRi/WxvEgwu3/Z
	 tha+JhugycWuTHcxO6ikZ0/wpgbnDrgCkl4u/F3We1GoybhamY7qnBhUFVKDJMTsQO
	 03MR+c2sfoNhqBY4DZw4PN5YNR4NzwaKwSmrsHS2TEs30pdqol/S2c5o35VmrC/P0A
	 wMjfJGmALHMfXi9s881loc4zxOfIZKyq3utDQZ6SC2RmkufouvClgiTd55+8FVKxR/
	 I+KcB4h0e9rUg==
Date: Tue, 16 Apr 2024 17:38:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Simon Horman <horms@kernel.org>, Brett Creeley
 <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
Message-ID: <20240416173836.307a3246@kernel.org>
In-Reply-To: <20240416122950.39046-1-hengqi@linux.alibaba.com>
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 20:29:46 +0800 Heng Qi wrote:
> Please review, thank you very much!

Please stop posting code which does not compile.
The mailing list is for reviewing code, not build testing it.
-- 
pw-bot: cr
