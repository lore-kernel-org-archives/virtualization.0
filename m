Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6F46B8;
	Wed, 17 Apr 2024 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320995; cv=none; b=tkn3i4kTFZI/Dy4HX0UFofPtIf/aIbWY/spQhEnqRgX8IJo5SuYZAsheua8SV8MySAfndtO0iu+SRKCsXg/oDVDFUs4LedfiWPy+d+u5UzOI9mjpJsBBGZqwfKD9SHIH2OvKXEe7kO8Fy9kda6UuflV2vq1QUYLBF/ozMRya4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320995; c=relaxed/simple;
	bh=LO3kg4cq/AVgvFGXrCNmCd+WZMk0SIYf1qY7FJlhjoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rxm8reYINACWkG0vumVSwviTMrWA+abXFz1OnoE/ASA7NaOKM5LqR4BYqAbmOn+vg2OuAFU4aWYFqr0ZFyiNVa03JdvlonABbUR2EusfQP3RofsVh//SjpKIO6Y7HKavLDm3EwFKI5m3XQRe7qBOkBa0Zz+Y1cSETQRDxNI1Cq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrsKSAVm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrsKSAVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02D5C113CE;
	Wed, 17 Apr 2024 02:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713320994;
	bh=LO3kg4cq/AVgvFGXrCNmCd+WZMk0SIYf1qY7FJlhjoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TrsKSAVmNOCkoGl9IwuEgHh+MvNUGX/tZdj4h9bOMsizW4aDrU5a3tN1QR5U0FF3N
	 uOKNqJBJf8rPvGWvOuTELbXWY25GbuYUoUWRi6aGpKQywnNkTVly2f2iXxNuMMggnw
	 SJaj8HJBk+T+iV+28s3NHpOAEweYFNHmgcbbWdBUjO6iUfutMj2To19GpxLIRCUFNy
	 xgrxH3EpO70WR1O7j/cbHlXOjIvRY61dLATLVFd93cELiaz95U3Y607hT1oYssbja1
	 hnJnOSw3s3xKj505OxdT5WmtHMfFtXVlprpeqzDZEqdDor42sx6ZvddT1Vo2N8WBYd
	 fKwDlabI+t3Xg==
Date: Tue, 16 Apr 2024 19:29:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Simon Horman <horms@kernel.org>, Brett Creeley
 <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
Message-ID: <20240416192952.1e740891@kernel.org>
In-Reply-To: <1abdb66a-a080-424e-847d-1d2f5837bbc4@linux.alibaba.com>
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
	<20240416173836.307a3246@kernel.org>
	<1abdb66a-a080-424e-847d-1d2f5837bbc4@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 10:22:52 +0800 Heng Qi wrote:
> Have you encountered compilation problems in v8?

Yes, please try building allmodconfig:

make allmodconfig
make ..

there's many drivers using this API, you gotta build the full kernel..
