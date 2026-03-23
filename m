Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C636D9EB;
	Mon, 23 Mar 2026 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302582; cv=none; b=sJOk3cGU6McsBpbgsLnXfoAk/DDnnbCUGAQqYpw+47R3XGQLL+PtrKnAJ6Hlwe+LQdQF44bPKby9WDe4Q3vaIxRmFoxTQPAfA/IbhV+FjBKO11dI/unx0nNjSCyhe9sNq0pSjjRFhdCqq73OahFyn8cwGXWjnR1hjARJRXPM884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302582; c=relaxed/simple;
	bh=F3YPmaITdEScGqQkB2M0Y0/ePglVVsPUpGdyETHCneM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=TpGQ0Zzb8dCr35okkCxsVBcvxUUhobBHrZvkU3ZeHWWKloezYCrpIkWq9czP9WfXILXWIUyAasqz9i1e8t+G+65GpXOUcP1yCorwYyu6q3GCjYJsWQByGPQy9vKOU6czDENtHFFtYozxJkVF7JfO7YyTwY4QbfiF7hfQduIyAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=hVhKPX4Y; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="hVhKPX4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1774302568;
	bh=F3YPmaITdEScGqQkB2M0Y0/ePglVVsPUpGdyETHCneM=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=hVhKPX4YYJTnhXfIMdpsY+cFwL1ihBr2+VoUtyLtJaVGnQkr3eAANfkUXPzIiasDb
	 v0HLhQhlrWLWUYjvtd/9Zb1JLEJ8oDGs46vHlEcPt0fJ6xyURAm3mDm+KlghLt84es
	 UjeoFFCWUHMD+nknBbQ8mEff5Wy+r0hhOBrrufKY=
Received: from [192.168.178.143] (p5dc880d2.dip0.t-ipconnect.de [93.200.128.210])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 62NLnQrb009858
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 22:49:26 +0100 (CET)
Message-ID: <c98afd05-79fa-4bd6-9f34-79fd2875544f@tu-dortmund.de>
Date: Mon, 23 Mar 2026 22:49:26 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/4] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
To: jasowang@redhat.com
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
Content-Language: en-US
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mst@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/26 14:06, Simon Schippers wrote:
> This patch series deals with tun/tap & vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> patch series, the associated netdev queue is stopped - but only when a
> qdisc is attached. If no qdisc is present the existing behavior is
> preserved. This patch series touches tun/tap and vhost-net, as they
> share common logic and must be updated together. Modifying only one of
> them would break the other.

Hi,

@Jason what do you think about the patchset?

Thanks!

