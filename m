Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFF33F383;
	Wed,  5 Aug 2026 05:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785907442; cv=none; b=m4l7QmOnfSwFD0mYAdr9RbskdV97lfaQF8kg8y4uN1My3gCtFhnBTI1XlfTcGpbqPRSy8HrjgJ3WM169SkPLvapZBMriqBRMp78zmG8Q+EDxaUKP0D6HrUWO9kFzmNx4GkcUh9b3UT6t1sM4wrFTf2LjluYfOsiLgPNhJENsJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785907442; c=relaxed/simple;
	bh=s1uXNVpEAHN4f/x9IHGPV+gZso6zL17IL/l6/kWi1+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oSzCLAhGuOC1MJRkQ2mthZX3BAu3XEtjuIfxh3Qfy6Hrx7sCZzKwFefPhqca9Baq8kdT3NQ/uARzmJ/wlcuaU0k06vmRYziCEN1gY0v268pwjxFaNBjr8ryRbTomZzHBsY2wP2eGagtgHuAieIWppC84rBC7FiY/u/QwGUMcXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=dM1nqOnD; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="dM1nqOnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785907230;
	bh=tnJ1K0fIN2izUR1UfRoFKGa/WS2bVfZZL5bJfos5cCk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=dM1nqOnDArETP2YaQuChbwXjt658w2p/8a01FVV3lZYiPmkV1Km9pfbmjAeaqhEVb
	 SyYdPGTZea9DQ4qf3zTB6goRoae/8SULlKeBjeVhLJMQzr3ntFv0/lRjkWv0grkOWC
	 VFyAS9aFOZrv8ai5fBGfbXZKmXziVrsqNufENRPM=
Received: from [IPV6:2a01:599:232:c1b0:84f0:11ed:69b4:d86b] (tmo-075-246.customers.d1-online.com [80.187.75.246])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6755KRMg017404
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Aug 2026 07:20:27 +0200 (CEST)
Message-ID: <0e3efa4a-e9bb-4e98-8b1f-1a8637c429db@tu-dortmund.de>
Date: Wed, 5 Aug 2026 07:20:26 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 0/5] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
To: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, brett@librecast.net, corbet@lwn.net,
        skhan@linuxfoundation.org, tim.gebauer@tu-dortmund.de,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 20:36, Simon Schippers wrote:
> This patch series deals with tun/tap & vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> patch series, the associated netdev queue is stopped, but only when the
> new IFF_BACKPRESSURE flag is set and a qdisc is attached. Without the
> flag, or if no qdisc is present, the existing behavior is preserved. The
> XDP transmit path is not affected. This patch series touches tun/tap and
> vhost-net, as they share common logic and must be updated together.
> Modifying only one of them would break the other.
> 

Sashiko is happy now.

Gemini reports in patch 2:
"[Severity: Medium]
Will vhost-net bypass this wrapper and cause permanent TX queue stalls when
IFF_BACKPRESSURE is enabled?"
... but this is added in patch 3. It just cant cross-reference it.
So it is fine.

