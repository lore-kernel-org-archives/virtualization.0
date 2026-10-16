Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427E3932C3;
	Fri, 16 Oct 2026 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116610; cv=none; b=ZX3OUsXFXMQWp+wjKnqTj9KpCxuUa2JT3mXvgvCpqDzlLbdR9wW3pgSuBmvfAFD3db4RRuxTkRyxqxz+ffQtU7cVUjrZKi0E/TXGt6T+iDoyvXLy6eCmbzwsrLHXGoE3gwJJPfoYEi9xekvfIZkGAPbeZH+LLyaWqIZJ7tsqt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116610; c=relaxed/simple;
	bh=fA/o53KYLGOvle9N618z1weHZaWaXTsHzIs1Es+mMMg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aAh9ZszOmLEvc2qb/sxU/pBSuEI5onkXeBwzhQ16gd3meD4kG8sqKnJcf8HHHyk99YCQ4ofBWTbTbkHOMhLUJ+t5nk/Q1Tx4MIr4WtTBoObMrPTOtMaiXTBFltkqY5SIte+NqoIJgIGl5fBzGbgXeNfd4XkyT0/R9r/a9xC8D3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdZ9LgV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdZ9LgV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827011F000C5;
	Fri, 16 Oct 2026 02:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792116609;
	bh=b8G3sVwNZ2QwLUMQDu2Zjc5gj35BMegihtMvY0bgkOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bdZ9LgV6msXdENuFpA+QItIeFYwtbSwsKZyvsWL61E1f5XjVTXMw+9JODAw/yOhhz
	 pFcLrg9AqAUWK/vEJiM2OcjwYzs+KWzxFz70VBjL0iCUJRbDVTJl2RtZuHdt5kvFwu
	 uYMOzNT8/RCBKGd7YD7YToFXNoGudsLIuqcSGwO7bBoDC9y1wcpHeC/URgRu58PuSp
	 QKo6EO6x+iQpiEX9A8WfGQC/kSVA+cIKR34pZMOy55110SG7fABK+oVnrI0DrjjCkR
	 Y6hGEGdJSA6SQ0C3yxzS6Ra1Ear+wYZqRcbjOQXtN3jqO8WD5OC7+uD838MCh8U8Lf
	 NL6RUCUxN8NVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774663808209;
	Fri, 16 Oct 2026 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211660802.15365.12535976672551564151.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 02:10:08 +0000
References: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
In-Reply-To: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 sgarzare@redhat.com, kuba@kernel.org, stefanha@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Oct 2026 12:58:08 -0700 you wrote:
> I've been reviewing vsock via lore+lei for a while now.
> 
> Finally adding myself as a formal reviewer, since vsock will continue
> being stuck with me for the foreseeable future.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
    https://git.kernel.org/netdev/net/c/191aa41548b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


