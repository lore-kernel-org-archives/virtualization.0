Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59C3E0C7A;
	Thu, 11 Jun 2026 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209564; cv=none; b=gQMwrwZvEWs4P+P21aKUEy4eovtOG4Z8mUMxTF1SSdcVWEhsvo2Pv7Us6M2RLKSCs8YiNalaIi5eL++xIs3ZhpCmqp3BmuoxQe5RQnGiYFbIftnvJFGPgQz9jva/VgSCwINp35cUOwzpwLgwca6GlWGM+Zq3Pxt/WuXF2kqn3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209564; c=relaxed/simple;
	bh=Rbrycvwow+FxQc/jZ51SEb9/hMV7x015TjMv7s3KcXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOHca5KGLY6jpsLupb7jqS4HvwUHC19lBXv3eXXouq6FteMld9sLr74xaOUfmbtEDjVokJbY4SODUwxHIiWmh5o0AEQuVf9bJK3vaZHZOM9Q7z91pvfCnQ6DTstoFoF0Wcfmtx2Obm2eG9ux0UA/7XbXIMmUNjCGFyzd5IPI04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkQWoHD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkQWoHD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB2B1F00A3E;
	Thu, 11 Jun 2026 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781209561;
	bh=Rbrycvwow+FxQc/jZ51SEb9/hMV7x015TjMv7s3KcXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BkQWoHD4HgOU8QPKUprfT7uO2nfwuq4/peXPwvVjn7AGIb/+9Co0ztuO4GUNBhKq1
	 mUN7hphfbbjwD9TqhKjsnRxhYPU1rZCFrCtnsjC8uBBMkLLfRYpNs6dWdJihTvrfGQ
	 +YsLaSDH9892NqkpUZfG/fZ/uJLBG9MgAHkKE7lzd6f5b5bDP0LCoaCoH8UMhwt4dT
	 +i7YN4xCz/MaVHn2avEPa1QhuouRfpS8zPEIbdXMJVUOaa67zm0CIvLIzHOh6aGAVq
	 K/V7WrRnfdafysWS5XPAcNZXpCLw2CkRUNHPB54y51KJfxMgMHj40MKxjs+3tJ2EQo
	 cdchLdcIw6Dsg==
Date: Thu, 11 Jun 2026 13:26:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Raf Dickson <rafdog35@gmail.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, pabeni@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <20260611132600.754ec1a3@kernel.org>
In-Reply-To: <aippcmlliXpO0BXM@leonardi-redhat>
References: <20260611023830.106259-1-rafdog35@gmail.com>
	<aippcmlliXpO0BXM@leonardi-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 09:58:22 +0200 Luigi Leonardi wrote:
> note: according to patchwork [1] you forgot to CC some maintainers,
> please be more careful next time :)

Please focus your reviews on the code not patchwork checks.
