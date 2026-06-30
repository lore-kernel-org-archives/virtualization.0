Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F647A0D0;
	Tue, 30 Jun 2026 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851539; cv=none; b=RbOg9AIGpQ0/CNdIIXxAUAIzrciKA6fIJPd1cjm6sEi+PNOGxKj+6IKrBk4M9z3HxyewZxQNEPaOYKFr/H76U7Duky8O2giVOzaj//DNwRY0grD6V5p28UF8kXwQORLKSYwb/JIi3OrXLw/x0CV3yxUxZEoX0T3KhDT8hg+Z+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851539; c=relaxed/simple;
	bh=Sl/HVCwIBdpvGLatq9Q/YI7I4nA3e5gUG5uiiOaegyk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aiXE1keapH9+bKs1mSktaKe0JqCPQ16+bZW3CYS6WSTrb/e40wp4zg1mjKu4x8Mnb23TZuLa/xig9MA1hSGqOKwGU95S8OP82kXKul/7uPZjsPF94Am4+ConDP/FoKcc71Yxhi3SBuPDLcVTq1IrF2vptgJ8e9IoMRhgDuKmLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyDsgJYE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyDsgJYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD901F000E9;
	Tue, 30 Jun 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851537;
	bh=C8uIgIBFik0MqXQz8692wMT0BwXXTwafs8Ww6H6ShcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hyDsgJYEEo24LaLu6RKYYIrIs9IzSSElGumyU5HdCwtNXqpx2cvoLj8zRS6Zo9d3V
	 leqhJb1Qm/+lpLcKpfvLDZbxrimIoAtGTSREiNDSihxbDq6Vj2cU6WQmtmI9/u9ENl
	 56z8wWb9NCyi1nUmMMlIbiHNSBbJ0yG6ObGVrfG9XpdOOrJwd82PjN4iEcEyr/Yt36
	 VXwNQUsBwXiPyYIYLvVZRj0OD8SHyh1pFA037FWBPQTYeypv1IrW+GA45rVf8oFiDB
	 AxBNbZd+mUOdZSbOxUiJV28pXbAyxvepI1EzXjK/f8D2tkA9up8YSgTQ0TQleeUovX
	 i4Bla6uNmYxoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0DAE393A951;
	Tue, 30 Jun 2026 20:32:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] MAINTAINERS: Update Jason Wang's email address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178285152138.267316.7554665596051831026.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:01 +0000
References: <20260629014525.16297-1-jasowang@redhat.com>
In-Reply-To: <20260629014525.16297-1-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 eperezma@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 09:45:24 +0800 you wrote:
> I will use jasowangio@gmail.com for future review and discussion.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - Add mailmap entry
> 
> [...]

Here is the summary with links:
  - [V2] MAINTAINERS: Update Jason Wang's email address
    https://git.kernel.org/netdev/net/c/1398b1014909

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


