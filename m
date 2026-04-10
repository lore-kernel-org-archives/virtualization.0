Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1022DBF76;
	Fri, 10 Apr 2026 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854056; cv=none; b=cVowm+lJsSMKQeP842jpLSy4ywuvZczwcvjVPmZSzjz8fmX6V1T8k38Yctgp7ihV0+MQs7/jprXHuI8KNYxngvRyx0ABkaSjIAa1dHwlmGOEObutizixQ067mwFOjFpu1AOmxnTAvb8Tu/2p1GWilprU+bLUCxYTXgdXugiBU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854056; c=relaxed/simple;
	bh=5ZRNbPtjJic/V5lbdkjU+Pdn5mC6F2+j/+jCmIOHBzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS7KJi7EbIKhv34tcTEK2Vz3dVbavf0gFlXC3iS5KM5DT5C+raDRPFT0X/JJQR1MCAPMUiYocZTbP+sy2e0vGDOt5toWeIfdhK1e3bSPXANb/5kx3w8K55uL7H50ccdLbOTFvQWSbjMLsZh8TM2EQUgd+gv/MSD5L5x9qE/KOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPK1x0rS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPK1x0rS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536B1C19421;
	Fri, 10 Apr 2026 20:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775854056;
	bh=5ZRNbPtjJic/V5lbdkjU+Pdn5mC6F2+j/+jCmIOHBzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cPK1x0rSBbrDzZEBcDz+etEH7ddDekCBHePuXcqCpHgsSTyfGp8CCFHZfN3E3IoNY
	 lxx57Q7cnHVHMv8otccx6fMTODk4DaFxxddWRmUaxlEcSjWuLShlFHhFHe7jeBHRgE
	 Kp7zpJt3EVJ5RIAvATJs1oWQWpgRpNQ1p0SOZUMgNxhsbffSRWxzwauxNljj4mW3ae
	 Cm07EHtyvOgPkUysKRZUEmQ02Kl4sewObb9o9dBOPRzD7hhShKrbiHtKm2p5AiMYOM
	 39KTl90r2x6BDyxKMikJaWqVyVAX2IdnB4z9y8wyfXAu43NKZ3NrzBAZalK6bdS7SJ
	 DqMxE5jauZTaQ==
Date: Fri, 10 Apr 2026 13:47:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cao Ruichuang <create0818@163.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Stefano Garzarella <stefano.garzarella@gmail.com>, Simon Horman
 <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: vsock: avoid races creating Unix socket
 paths
Message-ID: <20260410134733.1c10a183@kernel.org>
In-Reply-To: <177581562073.13887.468247298173578281@163.com>
References: <20260405195733.86043-1-create0818@163.com>
	<20260410035237.59644-1-create0818@163.com>
	<177581562073.13887.468247298173578281@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 18:07:00 +0800 Cao Ruichuang wrote:
> vmtest.sh currently uses mktemp -u to precompute Unix socket paths for the
> namespace bridge helpers. That only returns an unused pathname and leaves a
> time-of-check/time-of-use window before socat binds or connects to it.
> 
> Create a private temporary directory with mktemp -d and place the
> socket path inside it instead. This removes the pathname race while
> keeping cleanup straightforward.

And you actually run into this as a real problem?
How do you repro the failure?

Basic netdev rules:
 - don't post new version of patches in reply to the old ones
 - no more than 1 posting in a 24h period
