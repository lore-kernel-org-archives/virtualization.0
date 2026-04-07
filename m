Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56542B9A4;
	Tue,  7 Apr 2026 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522223; cv=none; b=nJpU9OGeoiHqy7741+9zHxEfZliiV/o7Fkenm+iUEJpZHrW0GX7lOQTjZnAW1mRMZRsRDWQRk/TtNHdaZTDcRvz809SiS/Bh8oSYGaF7CtE6EzkvzMpPZy+cDO1LxQP004s8yRxOQKdvQymEuJma7OSeq9wk7Kq0+VU44M9qSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522223; c=relaxed/simple;
	bh=XlHyAzaJklqxmNalMDD6OKRU12ck+jCq8qKnCst96gI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOp13/D7oCLbVRspT3Zm2iGikcUYSMi5tur+hsZ/nIUWn5fWodrge7oD8+nHWiEdjZrBdKtkXO8bSqsqz8gvnqwvAZ5Z9BrHtzbuFotNCu/UoHt2JVLe/Zc4AYmJpc9z1yvx2sXisteysgxBsUMhAJzOuWVzQ3QTOoAB8kFPMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVp70/+t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVp70/+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F58C4CEF7;
	Tue,  7 Apr 2026 00:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775522223;
	bh=XlHyAzaJklqxmNalMDD6OKRU12ck+jCq8qKnCst96gI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVp70/+tlQHEJnueuLtQClkQR1/+dtsCJj9DulgO1WpCNXWprnF+zoscNNJk7ZVux
	 a7lIqu3QkET4z0bHxNT78dqjeGhEVNuyUpnV3xNo2ps6CS7/dba2r1Pm9YDWFmyta6
	 O6biJMb8Z+jNYrQrdlKM0BDxBHCwoDxeR0s+9OqWjcz/7XaamRjeW0lGHPyQy33DGI
	 CulDptKAPmAhC8VBZ/xiex0X7VAP9YKXcVw0rxC8T4MlkRDg93+A+MSU+Mey2SC7kL
	 wtiSDz64hFL76ad4FoNrt1SUuqu69i30mO3OHlp+p99NYRMNRmQb9TWL2xYCH6Xj4j
	 pcCPc/b+x61iA==
Date: Mon, 6 Apr 2026 17:37:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Norbert Szetei <norbert@doyensec.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Villamil <john@doyensec.com>
Subject: Re: [PATCH v2 net] vsock: fix buffer size clamping order
Message-ID: <20260406173702.56239557@kernel.org>
In-Reply-To: <69317E49-40AA-4985-8A4E-447C58665A68@doyensec.com>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
	<acuKUpZQq6z1DY_n@sgarzare-redhat>
	<102981F1-2CAE-481F-8FAE-4F3085E25E89@doyensec.com>
	<69317E49-40AA-4985-8A4E-447C58665A68@doyensec.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 22:04:26 +0200 Norbert Szetei wrote:
> v2: fix indentation/whitespace issues in the previous patch.

This is not a correct way to submit a patch, but please wait until
Stefano responds with any further postings.
