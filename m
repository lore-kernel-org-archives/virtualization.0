Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA36C146588
	for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781403745; cv=none; b=g20C9i9JDaY22Mqdii6501tVfG5Hek7U3GlrKhDPaAHKxS6AI+pDaI/kj/+wepCaJ+Jhbk/DVfK84Od2drLyaRVW4VMgBN/s4nuS1mUV8dt3lpittbN+paUQLVI4rnGMVjEjXRNmf5IP20YRQfyhVQ2XbA0apUGM2L7/WPr63hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781403745; c=relaxed/simple;
	bh=ZknJMDKwVJgIZpDFbdQoNSsPaPQ17znpCfBxpHGfGsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddgurF59ApYi5XQVFlxTd5L1i3nCpGn9jsVSAkc0Zm98tvSn7d/K7M8GjnAL8Pz1bGhh77QuVsAKQ+n/+pGhwos2Un5yvfIwkOb/4Xqz2TdcI3B2Pnh52eN4sqNRMuk+eCMkE21iaPb3BREy5z7wxrKbXf9yxhX5MlEzRnENnwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wEgqKCJO; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wEgqKCJO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781403740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUHyjG0RXs1veCstB5MKuPMJNCla+JoVZvzNMOBLwHM=;
	b=wEgqKCJO64K2xwTZWh3Ep+gEvFYrwEDmVQOlvE9I8Pco9Fw2NEy7m/HnwU7VdikJl+rW1C
	FWGdXXZVMaPa/Ka+KB6BQOuPz6rueouaqZMk5lFPhBR8sjViT2EzWzS6prVUhkwZWK3xW+
	CjgjKSa1QHERcgPYwyDX3Ck4vfGinUM=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
Date: Sun, 14 Jun 2026 10:21:56 +0800
Message-ID: <5Iw9UybCQg2Lz8MAf7lCXA@linux.dev>
In-Reply-To: <20260613144438.767f8069@kernel.org>
References:
 <20260610081648.2205711-1-dongml2@chinatelecom.cn>
 <20260613144438.767f8069@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/14 05:44, Jakub Kicinski wrote:
> On Wed, 10 Jun 2026 16:16:48 +0800 Menglong Dong wrote:
> > +	/* If both rq->vq and fill ring are empty, and then the user submit
> > +	 * all the chunks to the fill ring and check the wake up flag
> > +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> > +	 * we will lose the chance to wake up the rx napi, so we have to
> > +	 * set the need_wakeup flag here.
> > +	 */
> 
> TBH all the comments you're adding are harder to understand than the
> code itself ;( Please try to phrase them better or just remove them.

Ah, sorry about that. The race condition here is a little hard to describe
for me. After the discussion in the V2:
https://lore.kernel.org/netdev/rHZz5_ylT4WggoZ-Ic2Q4w@linux.dev/
the race condition seems not likely to happen. So I'll remove this
part in V3.

Thanks!
Menglong Dong

> 
> 




