Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D9219FC;
	Wed,  1 Jul 2026 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865223; cv=none; b=jCSCKYb5YR1v9vZ24ipvvJ6P0eGrEDabBUX/S2sfmyv8XnrYkUFTHQ2JwUcW02k03K8kP+IxSS55kGiA0TEOqwy35YvIQ5cjCdHbvgbSS1HpUTbj0nWlzQ7Nh3z4ijK8YREp+l/Jqjbbbt0aJFEWPhJbSwo7K2uZI17luWfY3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865223; c=relaxed/simple;
	bh=TffaeaZ0/qHBYSA5RFOVOakKWtw2Dy4q32bJqISPWZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Taip+ZTkGjJ5cSUYOb0exnbcCs54LihMKEQZHu/vhEFu0UpFObGvybPwyUAfEaA2TByUhKA0N/s80w/yFSIozmtZ5/XW2oYyA18lVlxpUP7LeQ83XowKx0DYlZJAV04cR2g5O4gzDY2mSRYFe8Ana/Krh71B2swkJI2cVAV7LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD4djcxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD4djcxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2351F000E9;
	Wed,  1 Jul 2026 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865221;
	bh=FhHoEVJX47i6Sq0muV3ZK6X4+lfzLqPfe/vKM7lETeI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZD4djcxpxUu+P5dJ2j7cr7KejIwE827lFoOldk1DvQGUrWZMYgHivWdJ9Fwi7qJkM
	 yoShvViqEe/8lMElMUNA9alILc4tGVTqdy6aXdh1VT2TbOQMDlQeNc/3/spiczPu+U
	 SqMEgbqBDZKy5Mc0DJGDjmJia5jD+AxmbKP2aFqRa7/XQqKIDunW7tFBPTSTfAEEuN
	 Ljchj++UtV5X3cMNxOJYyxBCMV28PkgRlipIEhD6g1Rivm70EQSB1DOLlWK9fchMcl
	 lMY44rMhVtVNQn3l8bBl2e2BIl4AtL79vtOk05fnJIhnmkkwFXrStd/kOKY9o6TejU
	 dXgFeI9845GZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C9E393A963;
	Wed,  1 Jul 2026 00:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] virtio_net: disable cb when NAPI is busy-polled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286520539.349616.104964929108327778.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:20:05 +0000
References: <20260629024230.37325-1-lange_tang@163.com>
In-Reply-To: <20260629024230.37325-1-lange_tang@163.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, horms@kernel.org, mst@redhat.com, jasowang@redhat.com,
 edumazet@google.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 tanglongjun@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 10:42:30 +0800 you wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> When busy-poll is active, napi_schedule_prep() returns false in
> virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
> The device may keep firing irqs until reaches virtqueue_napi_complete().
> Under load (received == budget), it will lead to a large number
> of spurious interrupts.
> 
> [...]

Here is the summary with links:
  - [v5] virtio_net: disable cb when NAPI is busy-polled
    https://git.kernel.org/netdev/net/c/1eb8fc67ca41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


