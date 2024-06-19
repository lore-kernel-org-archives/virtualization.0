Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF74687;
	Wed, 19 Jun 2024 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757901; cv=none; b=Ku4uXHt7WZZ7e4kBHQYRpJaLZcfnOnTHQKcc5xxs1Huvz0kL31ci7x1WDgUlj7fyUDxyt1ha2AyomTR3fXY39o4ReNvrQSUAFxZZsr2fWwqdvnrHGZk42X87uMbdAqdpGkyO9ebMkTC7NlknRakpMS5Q9LED5jN5ZRjYQI9W9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757901; c=relaxed/simple;
	bh=4MSwzDwCDVOtASEfSX2a65c/to5zuEGQDDfHQVDYUpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRkzxacqRVGGsFyom8S3AeHpWkXwSLW4Jxaz7TZkSKi9/DjLxGZDpzYKjcfd30y9jEzlzExSIwA7H1dzkLnXFzkzzTbKN3G+5UMl1I0pH231iQSNdTYmeVLSTkuVx7REIRN9GR+uuNURpQKMVBB0HwfHYcPlZqvMzMgi0RWYV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf3TNz2B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf3TNz2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD51C3277B;
	Wed, 19 Jun 2024 00:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718757901;
	bh=4MSwzDwCDVOtASEfSX2a65c/to5zuEGQDDfHQVDYUpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mf3TNz2BRtXxesfQP75+rglLlPAgEsO1xIp/NbQh4ionEPhFjjgJKrUNolt07oJQh
	 6+VkhMO5yo5xi5QRBTK7f+piD2fy0d6CyZp0iHL/0WwhdA8HJHrGEX4LcY0DM1Ps8Z
	 6okdOAeda7PVcI3HEgbuYrb/MfvnRwuLnCso96+FbVgSI8D7nz5jzHFy5ixU6r2AjB
	 REHVAlxvBNtc6q4pPz88n6zuUn0UNqsAdqSevu+OlmRBCq7Kqwy2d3dmYzRsOPTFk9
	 Z99C1Qr8ak47sVGZc3uZvQBinRHpD+tQ1M1SZn2QtbuqjrxCXOpIxeQS2DtudT26mq
	 0EEzVql14BA7Q==
Date: Tue, 18 Jun 2024 17:45:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Denis Arefev <arefev@swemel.ru>
Cc: jiri@resnulli.us, edumazet@google.com, eperezma@redhat.com,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v2] net: missing check virtio
Message-ID: <20240618174500.49a3045b@kernel.org>
In-Reply-To: <20240614101826.30518-1-arefev@swemel.ru>
References: <ZmsG41ezsAfok_fs@nanopsycho.orion>
	<20240614101826.30518-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 13:18:26 +0300 Denis Arefev wrote:
> Yeah, I was thinking of adding Fixes: 
> 
> But this code is new, it complements what is done.
> 1. check (!(ret && (hdr->gso_size > needed) &&
>                ((remainder > needed) || (remainder == 0)))) 
>  complements comit 0f6925b3e8da0
> 
> 2. The setting of the SKBFL_SHARED_FRAG flag can be associated with this comit cef401de7be8c.
> In the skb_checksum_help function, a check for skb_has_shared_frag has been added.
> If the flag is not set, the skb buffer will remain non-linear, which is not good. 

The Fixes tag indicates how far back the bug would trigger.
