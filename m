Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86201862A;
	Wed, 27 May 2026 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846364; cv=none; b=qRYOjsShGhadbv9bKKuB3N7lBxycfG3DQmlH4mJPL5fiYdvukSGygNTnuqW9FB2E4IFjjwEfIemokuLpIn+6jarn6OL0jS7lSPMGU3+mr4X63fMdBZgiGEcu7yLkFHk7U86JI1OCO93Hce4XjS997CxKBi4SDYqBA2TdWohCGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846364; c=relaxed/simple;
	bh=izIeuNvyeho4SNyx3Pro6A2pURmyDx/3fal0k+yUtso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aT876EUvRDRIARCE6R21QThEPGzt6pVvC3lfshXdOY87/9cCWMVwnu5xd7H/k+0z69dbe8xdoBgHZcL9NRl6+ZCfOG1Abk+7pC5U96+R6lZ7Fi9mnzuOxbASKzcOXXU693yPGtPB2EoY0guoN8YbIPb90iUsbYg7tfFNAuB44QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2Nf8Q4+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2Nf8Q4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE951F000E9;
	Wed, 27 May 2026 01:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846363;
	bh=EGQfbEQ+R7NLz9tytef/6gOtdjU7IFKG69ao+jumQ4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N2Nf8Q4+G4GJymR+NMC4TeJxsvnURCFVMa8W2fU0nT9Hz3zrTKUcIlaAUnydX0N7y
	 8qxwvGgRB8tqc5FD+kDztfyQqzF5HngR61hgEocHV3tAOgIT3FRj2j+JvhFMEOt3rZ
	 FryycX9zlFMV+seUkz3xXDBCQwkQ+ash67c2UL+ky4qSknzSNeCLbjyFXfSEaRU2vp
	 9ujxMt87iig8FxhJ7lCPWUd1T4A6wGTmpT/F0MoqPCou2HePE9HGfx8tVktv5hbOi1
	 R/57YSoD3Rj6jImKGzKHEzvAAhuEYEJHutUrAWY1BLZcslZF89+ghHZsBfOHHTJNl/
	 4brRYCT3wKbpw==
Date: Tue, 26 May 2026 18:46:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "malin (R)" <malin89@huawei.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>, tanjingguo
 <tanjingguo@huawei.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
 <xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Chenzhe
 <chenzhe@huawei.com>, cenxianlong <cenxianlong@huawei.com>, cuirongzhen
 <cuirongzhen@huawei.com>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Message-ID: <20260526184602.36117a75@kernel.org>
In-Reply-To: <9fece5ea269049f883f367642c07eaa0@huawei.com>
References: <9fece5ea269049f883f367642c07eaa0@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 11:15:12 +0000 malin (R) wrote:
> Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
> Date: Mon, 25 May 2026 11:15:12 +0000
> 
> From 9eea4f61a4dca97f56c23e12267219bf791a20d1 Mon Sep 17 00:00:00 2001
> From: Jingguo Tan <tanjingguo@huawei.com>
> Date: Fri, 22 May 2026 19:53:45 +0800
> Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb

The email headers are duplicated on this patch.
This appears to confuse git am into thinking the patch is empty:

$ git am mbox
Patch is empty.

Please fix this and repost (please add the review tags you already
received in the repost)
-- 
pw-bot: cr
