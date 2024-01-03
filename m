Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569CB1EB20
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jan 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQwMt7hu"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5BA041A42
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jan 2024 21:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5BA041A42
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZQwMt7hu
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eoGgQkS5pDLq
	for <virtualization@lists.linux-foundation.org>;
	Wed,  3 Jan 2024 21:58:06 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D4C8C419EE
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jan 2024 21:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4C8C419EE
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 91DFB615ED;
	Wed,  3 Jan 2024 21:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0904C433C7;
	Wed,  3 Jan 2024 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704319084;
	bh=7evY+Thk8UVxoNHyanWJrPDweTbRIRw+mgXt5AHtm8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZQwMt7huBv06cAhF2TyE8QHYuJa28TDZt4VUt15DgtGoN/DMoxf81uAVke5lOHp3V
	 exjFz+Z8We6faTqI6yUkCGOEeb59NfZ9Ef1sMyPNEZMtwdBOBJz5Y8KolgrmCv5g/0
	 ELErgWuebKOWO3Zl0pAyODYIcFXTmFdGWeyd5359eKMkU+mZSFqM+qrpn0FYzDoGNJ
	 GbTGLGnSv4sGajvIwvjoGa8LMA1eVaPr3XU5Lqo2ec7kcVQ+/XJvUjUluet8LPj+Sn
	 yVMBK4JluBkQ3u3vkLsaH4/2J7yCBQQB3J+6BeXY1cHXhERf/tZ2lBQ076UgB1DMqU
	 y5+8BIS4qFqTw==
Date: Wed, 3 Jan 2024 13:58:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2] virtio_net: fix missing dma unmap for resize
Message-ID: <20240103135803.24dddfe9@kernel.org>
In-Reply-To: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
References: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Dec 2023 17:43:33 +0800 Xuan Zhuo wrote:
> For rq, we have three cases getting buffers from virtio core:
> 
> 1. virtqueue_get_buf{,_ctx}
> 2. virtqueue_detach_unused_buf
> 3. callback for virtqueue_resize
> 
> But in commit 295525e29a5b("virtio_net: merge dma operations when
> filling mergeable buffers"), I missed the dma unmap for the #3 case.
> 
> That will leak some memory, because I did not release the pages referred
> by the unused buffers.
> 
> If we do such script, we will make the system OOM.
> 
>     while true
>     do
>             ethtool -G ens4 rx 128
>             ethtool -G ens4 rx 256
>             free -m
>     done
> 
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Michael, Jason, looks good? Worth pushing it to v6.7?
