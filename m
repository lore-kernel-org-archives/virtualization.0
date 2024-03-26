Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A520B28
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416843; cv=none; b=tseVpG9nYkafsf3XvnJBNY7ddsgstXopmZ6N1I70epOB6S8EGsrga4ZjfHqYyUOLJTOVzVHbitWSLmH2CwyKrudjwDPYTGDaYowCQ6PTzWUJtPoW7ly5m9+EVBooqJW2pBaL/P5mJMvIsF3Z5FFf3XuGg34KSDTdUsvIGqNOS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416843; c=relaxed/simple;
	bh=BixFEykapZwVNVEYPFjYThzYjKiAkONn3vmz/qgv0gc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=K6SCMfd1tadw8mr7e97Z9CKpcwb9X+yH3pRn1FH8e23/r5IIDEbBsG6nnKy8OiAw5d9gaHckMehflBkd8whH5HOagKQxWd2CKRgCh9uzAyQY0F8ASYEvYWavpGce0U+M8Rl3q2WDLPf9W2yExq52Mr4a+HZAET7OLcWdQVUW9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kFyvbM0K; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kFyvbM0K"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711416831; h=Message-ID:Subject:Date:From:To;
	bh=OtDyvDpEmkA9ncX8H7rdwsGH2Mc+/yUbMhqgfXQ4gjU=;
	b=kFyvbM0K24u337YJ2zue8x9tjmQWlbXKLT4dqXlxmK19fA2eJRgzTHXZydDmJ11YC/2g+qpyzqr2wzilPSSCVbaXP18pJEBfbu5O6FxbpvCjNGyOTTWThEIP8fotGTMU9Ko1ORGHififzSPOLh3x2AW6oXv2C7IGtIgfYLa1XOg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3J8F6j_1711416828;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3J8F6j_1711416828)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 09:33:49 +0800
Message-ID: <1711416803.443376-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/4] Remove RTNL lock protection of CVQ
Date: Tue, 26 Mar 2024 09:33:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <virtualization@lists.linux.dev>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>,
 <jiri@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>
References: <20240325214912.323749-1-danielj@nvidia.com>
In-Reply-To: <20240325214912.323749-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

For series:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

On Mon, 25 Mar 2024 16:49:07 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> Currently the buffer used for control VQ commands is protected by the
> RTNL lock. Previously this wasn't a major concern because the control
> VQ was only used during device setup and user interaction. With the
> recent addition of dynamic interrupt moderation the control VQ may be
> used frequently during normal operation.
>
> This series removes the RNTL lock dependancy by introducing a spin lock
> to protect the control buffer and writing SGs to the control VQ.
>
> Daniel Jurgens (4):
>   virtio_net: Store RSS setting in virtnet_info
>   virtio_net: Remove command data from control_buf
>   virtio_net: Add a lock for the command VQ.
>   virtio_net: Remove rtnl lock protection of command buffers
>
>  drivers/net/virtio_net.c | 185 ++++++++++++++++++++++-----------------
>  1 file changed, 104 insertions(+), 81 deletions(-)
>
> --
> 2.42.0
>
