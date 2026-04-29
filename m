Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA839658A;
	Wed, 29 Apr 2026 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496679; cv=none; b=ddeagO12xlCVmJ0yFUPjjE4Pk1Cq7CMzdwQ7vpPtfannw6viExUJBYNjHpoZ6vvM+UEfKd9NjOBUD/JUCXMGB2U/Gs9S2o8oqprWW7L+7zaMUXfC30GfotNuq+4XzPGcv9AxmrqXu/WhhVNG8wxJ/IaNv8JcZl5Of0WrIfPzonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496679; c=relaxed/simple;
	bh=hRuy7WgCIVRD583lA+MEcUg/0SPThFP+5pL8HoRtRho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F5v0JcFt1oRl6RCQOGuHU/zdws1C+fb0A9e6AYdURykdrWoLcZCy1+3RZvliZx2u+GjyBFPpYFIIro4WhcYKbR+ePmu6pHV8OJuToht2JCBQvkP9qKTqrVXf/EDDn37n39aWUQmY9Are1hfuoYKsYmHMQuT3sLggM6kVi5Dh4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [192.168.178.127] (pd9eaad8c.dip0.t-ipconnect.de [217.234.173.140])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 63TL4OA3019919
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 23:04:24 +0200 (CEST)
Message-ID: <5232eae3-e924-42c2-bab4-6f2023aa629b@tu-dortmund.de>
Date: Wed, 29 Apr 2026 23:04:23 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/4] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I just saw that the Sashiko AI review found some valid regressions.

I will update and test the patch set accordingly and send a new
version...

