Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226CF250BF2;
	Tue,  7 Apr 2026 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526643; cv=none; b=MwKH3URGe4lFbIN3lcbFoWS0aLyVEgzdWgq92ht6tI5KuE65Q0lagFjRbnDo4qscnWp+FkNiiXjolP/xNY7VodKTB355TjsczfvkApGi9YE8TCVsRpIuFtJqUAqoFvq+JhqRxWEGOQtMkSOKM6VaeqygABYnjM2N3oh5cX26zUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526643; c=relaxed/simple;
	bh=4cABJcrKrP1rtJVcjJUJFB6jIA/+r8G0msOGJbi9zOs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RO9p8NrD7+hsZgZR7ijI2BqIcVoF8rNGLCwE2bgGXmRsZx+pAejtXYxsfbkweoZLvczqKNlb3/hF+zJNb4sxsz91Rg8lZKE51+3Shs4GU9S3Gjtoz7SiWMR1Er2UwpXISZFeiK5vGFzj6zfVXRm6CaoUxJjtAX/+36jKepIzdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5Ju5qll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5Ju5qll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042A9C4CEF7;
	Tue,  7 Apr 2026 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526643;
	bh=4cABJcrKrP1rtJVcjJUJFB6jIA/+r8G0msOGJbi9zOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5Ju5qlllMRbw8nuE8mI9X63nPaS6wyePSDnLfEpukjgRuUdy+WyTse7N6Z/Vaeb5
	 PCb5m20eycpR9sfj3wPqUnnu96YWAEP/+VMQLM7+acH7SqYbb+9tSEsZHoHHPOfzaz
	 m8YDc8tZjdnZgbnwwYO8Fb3ExePX2KggsDkwFn5s54Be+gUpNN1tUGz/CGHV4Q95cX
	 jdeocQC9aEgF7rB7ES9gJZ5TABYaX6pGwiYgGARsgCO6WZ+SrEM9PjWEFd0J4dgtfy
	 gdx6LDQfu4MShpMGmJBlg3u/E0ADTz41JTWxCyDfOrDP+yBCiBB14TRnpRXH/26wdU
	 AF3xPSyHbe69A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDCC3809A28;
	Tue,  7 Apr 2026 01:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/test: fix send_buf()/recv_buf() EINTR handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552662129.3337768.3699528809798023594.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:50:21 +0000
References: <20260403093251.30662-1-sgarzare@redhat.com>
In-Reply-To: <20260403093251.30662-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, avkrasnov@salutedevices.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Apr 2026 11:32:51 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When send() or recv() returns -1 with errno == EINTR, the code skips
> the break but still adds the return value to nwritten/nread, making it
> decrease by 1. This leads to wrong buffer offsets and wrong bytes count.
> 
> Fix it by explicitly continuing the loop on EINTR, so the return value
> is only added when it is positive.
> 
> [...]

Here is the summary with links:
  - [net] vsock/test: fix send_buf()/recv_buf() EINTR handling
    https://git.kernel.org/netdev/net/c/24ad7ff66889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


