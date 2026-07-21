Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7D45A280;
	Tue, 21 Jul 2026 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672575; cv=none; b=P0wurNtjIPU3OLiL3laNmN122gSVQOCaQbN3wtHQMzDVMbTRjOkVG9vfJCs7/feu/XrVG7voRNrl7bNO0oVaBV0bFELOpNvmDju3O3zXfN0xqc9qWaQHQM1Gx2G34mQGEK7c9lVIebYX54zKK5xhjhPyLho58SwY2TxdknoC81s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672575; c=relaxed/simple;
	bh=v+RgnfN61CPTYQASeM6iKY8BZjb8Nxc3s3NM4xUFZMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8UXuDYTNey/qhrcUmysCiVNPim1/Q0LAISVGg22QPMVNacx2Z+eWk3VKlKqZexZlp2mp1fdzr1GmtqDuI3boxL14JcVcL96VyF2IbBjAvtNOMWLv73Dy75FKOR1qx+cNsQgeNmwyz3jWNO6cJ76d6+St0RbfLgH0IWnECh/i8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ0iA3vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ0iA3vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6001F00A3A;
	Tue, 21 Jul 2026 22:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672574;
	bh=2eNsbDr5OFhLyk5vqbmFVkAYvjYPY96eCFwjysblzcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NJ0iA3vqen6HC2PG2xd9QuactktOdjio7GjsVgoAYF08M+f38wRK7AKnINafIKLoe
	 RYIulTHZx50m2prQTx1YVSAsRdTBbrun2oom+HSNZM4EguWFmIHbyoOtNaLa1+Lpff
	 stsmt1ghvcvsHy9sgdGWSvI9e4D9Q7Zs0dZxE0ze9foEyui0osyMVdwyO+s98l+6u5
	 WG9wIUMuHsaIpPbV9NH3BHV01qrhumss1gLuC4PYOGVe4O4g9H9t6pWxQjdTQqMel6
	 22O+730rNYH2fzUjE4qEZaOxGZLBZXOKd/u5Wg3Ek15/DZYjxHfd8z91K114GHsHhf
	 6jpRUVJC0+4CQ==
Date: Tue, 21 Jul 2026 15:22:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: fix spelling of aggressively in comments
Message-ID: <20260721152253.1da95882@kernel.org>
In-Reply-To: <20260716011201.86688-1-xiongwm2026@163.com>
References: <20260716011201.86688-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 09:12:01 +0800 Weimin Xiong wrote:
> -			/* Pre-fill rq agressively, to make sure we are ready to
> +			/* Pre-fill rq aggressively, to make sure we are ready to
>  			 * get packets immediately.

Move the "to" to the next line to avoid going over 80 chars
-- 
pw-bot: cr
