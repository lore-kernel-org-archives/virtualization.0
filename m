Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934A40DFB6;
	Thu,  9 Apr 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754138; cv=none; b=IkmMgzPlUaCNnXrU35NEoGKzYf8zDeE5tLlLp2i4w/zI1eFgdBg4CBuEEZESZ/wrYGU/IBcsxruAX/EQIsoYGitDcdro8RTKuiOtdW3U13K3nQ4KO/tq6LF1EBnWRKwoWYHALjUKw83Ed1KTT0Lx0oh5mPzTS+X/ufUVBviLUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754138; c=relaxed/simple;
	bh=RvRHyUcFxxG6wQnNxZOrIM1hO6bj0DP6oMU3xXPQdeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCwgR3q4Mj9Jrqyk/HOrUSOahtsyYTKyc2P3X7/vU05BupVtBpZn4DJ6KRSrHRlxdMkGSeD0EJcALY+S+qsUdXtTeClDP6rbe0rEJOntujxE/CsoM8XPWXieSCM/Lesz+np7XShsR0V8K1FBv2rfZa0jrPfosz4N5paaQJFKUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRcdE6ag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRcdE6ag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3072C4CEF7;
	Thu,  9 Apr 2026 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775754138;
	bh=RvRHyUcFxxG6wQnNxZOrIM1hO6bj0DP6oMU3xXPQdeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRcdE6agHCWl0jOZxFR77KFqXcliDz9Qnt+6874D5ymB/i10NEmchCus6XBVK53tU
	 itNDTl1wPt09jKxiGBUp9nWWO3npeUAS2bNj3MjEFvp9IyK2fYrHCvnk+uCFY1zTAE
	 HJ1ejVZ8Kd6KaW4oqW1DCgNwzLQiqYnt0X6IkDGtVcnHpYAn9tfKSkwKlAdwHm3sou
	 RnI9YIwLQAAP8whvlUShO2iMu+VBe+lFYLIFowHgpbBR9Uvk1S2rDpSYf30Zf3gy2A
	 jw9C/dOVxmTdjD6pKNOVnHoEXhTE0DElKscQ5bYwoOXCNCjZ1ze3keuR912OZ1W6eB
	 Fr3874Rxq9nzg==
Date: Thu, 9 Apr 2026 18:02:14 +0100
From: Simon Horman <horms@kernel.org>
To: CaoRuichuang <create0818@163.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests: vsock: avoid mktemp -u for Unix socket
 paths
Message-ID: <20260409170214.GR469338@kernel.org>
References: <20260405195709.85957-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405195709.85957-1-create0818@163.com>

On Mon, Apr 06, 2026 at 03:57:09AM +0800, CaoRuichuang wrote:
> The namespace tests create temporary Unix socket paths with mktemp -u and
> then hand them to socat. That only prints an unused pathname and leaves
> a race before the socket is created.
> 
> Create a private temporary directory with mktemp -d and place the Unix
> socket inside it instead. This keeps the path unique without relying on
> mktemp -u for filesystem socket names.
> 
> Signed-off-by: CaoRuichuang <create0818@163.com>

This patch was sent twice in quick succession.

Please don't do that.
Instead, please allow 24h between posts of updated patches to netdev.
And please version patches, like this:

Subject: [PATCH v2] ...

The process is intended to help reviewers.

For more information, please see:
https://docs.kernel.org/process/maintainer-netdev.html
