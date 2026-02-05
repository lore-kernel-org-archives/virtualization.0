Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903021F5834;
	Thu,  5 Feb 2026 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259278; cv=none; b=NACnkwCZ/U/XXWtJFp6QV3i3nciVYhK5uIXRxM4X6YAE8ADLkZKYePwo3MPwDWfbqfWU5kE9vw1y+2JIpFI9BNWEjE/mUCwSzBa2SocI3dBrPF2C4AfCvj8OFP9xbDpmILFXXDIPsj/F6oUQExsUsgipDX52p69IJXEhihJwjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259278; c=relaxed/simple;
	bh=IfPF/Ecwpu4CLWUVg28CS2dpUkT27gNfMmd+9r9Gr+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7RhtpZ6+wQoBlPn6mMIjkoJaS1CxIpkQ58uxCe93RIpL/8ky13VeX7Pa2oWTeFpk/htos8oogopwnw2ldDt3VhGV6XDot27D4e6qnNfQLgr2DmvvBxuYdJvvj1mK8vv5ZGfJRSyBouVcXmH1eqTaalvEPzMj3LmL3zUhaQs1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAY21sPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAY21sPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E6EC4CEF7;
	Thu,  5 Feb 2026 02:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770259278;
	bh=IfPF/Ecwpu4CLWUVg28CS2dpUkT27gNfMmd+9r9Gr+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAY21sPEwQpyWxNm5022Q4jfRhYPLMKUgov12iqGyQ6v+Wy9DYbIIhZ34VEC2raM6
	 rLaHq1/AY0APjp2DsYEDccdwCz8HwjzEI0ibQ+08dVW4gKkNvUT24i2zgfnVO5teH0
	 nrwXJkhC82je9CzIzZN3h+p+Ax82WM1NlG1oKaBGhzbeqCHqnw4PNu/IKam6kP6lQN
	 m0T/JKQJ0O+cW3Jh9Lhg8MK+u4npAHM1CNBWC9W4AGhEfhWt5so3hy3Hkr44HODoto
	 QtXSRB3XgMklkw9q1E4zvnUorX1Y32rliYp1jgbjc7vEmC8U2HJQTN1TWDjF+fuJHk
	 1LZ5v/b/SjGCQ==
Date: Wed, 4 Feb 2026 18:41:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Simon Horman
 <horms@kernel.org>, HarshaVardhana S A <harshavardhana.sa@broadcom.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with
 gcc-16
Message-ID: <20260204184116.11ec0a8c@kernel.org>
In-Reply-To: <aYMqw2HbtKi50b1e@sgarzare-redhat>
References: <20260203163406.2636463-1-arnd@kernel.org>
	<aYMqw2HbtKi50b1e@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 12:29:44 +0100 Stefano Garzarella wrote:
> Not sure if it's net or net-next material, maybe net to avoid the 
> warning/error on v6.19 too ?

I think net-next. I assume people who build with werror like pain, 
and we need to be inclusive.
