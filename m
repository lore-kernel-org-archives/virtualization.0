Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77321EEE6;
	Sat, 13 Jun 2026 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372235; cv=none; b=P4xDP/a0wlDmuzOnWl8iP/VeuWUvtBhUTK5uxfz1GNdM1G+246URXtNlfkmI0VHWZwLvp7caotlDzVToNj8FQ1AQ6BHg2epiF9rgof5nsE2Q++vNO1nVIZMgvlRSK5yilvyQYpNqB0G566C23T6ZNZhZlLCKF2jp3hMXbQZGpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372235; c=relaxed/simple;
	bh=4FYhViFgpnWRJ3vbbVswfyM+VVJPJoayuFpiGNMXd0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9FzSHwMli5hMWSYbae+iUZbSDzpgD6r9Stzn1atJ+YkXv19Y+5YXu78Q0wVrerRIC7yHBgj0f2oJg9pI8SuQKTbQYLYnxlx3dMpvcjiAArR7NI8OYAbTHVSSP0O9FVs2LIP8WTCORWdJF9qbynV9eNRnEvdSsKMoh/2e2Y04hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUzSIUGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUzSIUGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B19A1F000E9;
	Sat, 13 Jun 2026 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781372234;
	bh=hWcLMAgLghTx7ZPTXhrSM+sTX6PyGogJrrFs8ZkyBak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PUzSIUGghU1qixEAKIvn19ap5OHfde0Zq73cCD0JJeB+snXP7r0pHwS7hJZDYHbYC
	 nLa3s5VnukX7LMVuTAyzsnTSzKJMofvqcloHbeJ5NGmoESXuuiXwcgv5SqPTqAH7Xh
	 vYWoD53r2yzhKNgpZHXdQk102Og+WEEwNvdjqH+36Zh+HRvbPPayI9iOVw1nub5AJF
	 yfG1iub1HCf/wZ9AzGnvq7eV4zh7evxkNi7XBMeyPSU0fwabDLzyBX2hwfLbBfYbcy
	 Jc0eFLuQ06roXKcuLuAqpU6txEB1MYF7ynr4BwfjLussz5kcwirYvhvnAV8s95rsbE
	 JBAYNlG7+m/VQ==
Date: Sat, 13 Jun 2026 10:37:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Raf Dickson <rafdog35@gmail.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, pabeni@redhat.com, stefanha@redhat.com,
 bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
 horms@kernel.org, edumazet@google.com
Subject: Re: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <20260613103713.6e3e27d0@kernel.org>
In-Reply-To: <aivKma8mRjTXV0BM@sgarzare-redhat>
References: <20260612045842.122207-1-rafdog35@gmail.com>
	<aivKma8mRjTXV0BM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 11:03:24 +0200 Stefano Garzarella wrote:
> nit: title should be updated since now this is not just vmci
> (e.g. vsock: use sk_acceptq_is_full() helper in all transports)
> 
> Not sure if it can be fixed while applying by netdev maintainers.

Updated and applied, thanks!
