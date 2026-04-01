Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3E1E5018;
	Wed,  1 Apr 2026 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005524; cv=none; b=VOq9z5MJcDFSkcPQXtXui3e/djdj/ixEu/BbJ7IAwQo0EOxU1B1ZgcPEYKjuwIBKMBqsbhQfcpInFe/NMimauB8woLTgrCDLZ7h5B7m7VwnBTrrsc+hZ4eFZlUEUYDKiP0h26BExGBWwvXXObCl7L1wQCWFl8HCZJjjRwhl62lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005524; c=relaxed/simple;
	bh=ByDXKuHai140NrVm7ahWH+xM2F6/SDBLhHluQ1Ex/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzbfpfiNBULJpDuqcSuZYf0C/nlICtXzUHVqvqYOox81sdMtxw9at122iTg0w75XcH4A2AE1lj9ILqHqGvJg6eFMqJ5HZsU57oBFp1HVbdt+EFuMt31ftIhT9lbaQygDWJcV1sdk/GAwGi324kiL6wJnaj2Zx6u9mACU/eYXqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIVC5wxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIVC5wxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0B5C2BCB0;
	Wed,  1 Apr 2026 01:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775005524;
	bh=ByDXKuHai140NrVm7ahWH+xM2F6/SDBLhHluQ1Ex/FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VIVC5wxLlIXQHrHwokUCek+jrgGpTIDiYTrs8YZnlbjpHErRPL+HqZI/uMk1YoKvY
	 cgFHixFJDW4dMiX5D1jJYgqYrULcTRRofdayL7rG1X6ABTEd1rV0mQ+rP40QB8kFoo
	 Wm9fWqSJqoYEMbHBRTYWh4Ja7aHYVErKe3kl/KnrnqfpqcR/vHHC9aULHvHy5Y9zfZ
	 vTQZiAe9m0QqN+vDlER9AFJcwt1C4Xep2/9bFURNxMd2VyV0RPMZ3lmk8U9nqjIlBf
	 94p58cPsDFClm6zqwMR545mDZOogMzQvAMPd62alkXlYOFM+faE3sJiJyilEHlRlQS
	 3+j7RcHRydCvA==
Date: Tue, 31 Mar 2026 18:05:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Srujana Challa <schalla@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
 <xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Shiva Shankar Kommula <kshankar@marvell.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp
 rss_max_key_size to NETDEV_RSS_KEY_LEN
Message-ID: <20260331180522.64ef9886@kernel.org>
In-Reply-To: <20260331104737-mutt-send-email-mst@kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
	<ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
	<CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
	<68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
	<20260331104737-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 10:48:41 -0400 Michael S. Tsirkin wrote:
> > > Thank you for the feedback. In net-next, NETDEV_RSS_KEY_LEN is 256. This fix is
> > > also intended for stable kernels, where NETDEV_RSS_KEY_LEN is 52, and
> > > I added the message to make clamping visible in that case.
> > > I will remove the check and send the next version.    
> > 
> > I'm sorry, I haven't looked at the historical context when I wrote my
> > previous reply.
> > 
> > IMHO the additional check does not make sense in the current net tree.
> > On the flip side stable trees will need it. I suggest:
> > 
> > - dropping the check for the 'net' patch
> > - also dropping CC: stable tag
> > - explicitly sending to stable the fix variant including the size check.
> > 
> > @Michael: WDYT?
>
> I was the one who suggested it, the extra check is harmless, I'm
> inclined to always have it.  Less work than maintaining two patches.

Give us an RB tag please and lets close this one? :)
