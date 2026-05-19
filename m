Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C63F86E9
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182885; cv=none; b=EWt7GNz3lq4Guyc6wWggc3efkrb5a/2xPXXe8ZZCl02cFQwZr2bz0Weg6U2mMUYzte3VlFj9stlCf2trM/LwQV+fxNCP5uE0rH9/twYnOm9ANLCjRJ/5ASTt4hRxVJeKfwZxP6EgCBWP5M2xx9fpczkGXzyH6lgLDkFkMmPUFhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182885; c=relaxed/simple;
	bh=uDEw9No4oP0gv6j/Ado3aaG16haNPWRnDa/SWjuSB2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IDt4m8FeWTvZbelnYCr6pbm5GOLwNOJ1EnUmM/b7Oj11+WGG/g5V3m696/3Po/JrSPMk9b6FXREsU4ApTpx/boXJlbMumuyw1KQXF2qT9SmIkUuR+1XxIDM3JffCpZCPOl6ZUmhCJou/Ws9fPASjQSUv9lNFwrsKZXd8zvnj0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rucx+pmH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rucx+pmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779182878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kq5cy4odtanFj4ZmmMjmdUGGp4uB2ZhMg4n7iuzQNs=;
	b=Rucx+pmHvPJcnVky4WdCn6zFhXmdA9HX3+JK+9KSdl6zP5nEK1AjjDnU0U5vGGafE+hyl+
	8TBZv9u+3ycWKPwbN4RvzMlJcg84QxnBeeyWtGWT17zBiohLSwQRbiR3emZgltqwFt0zon
	2YeTi6dODujQQLb+6AvBxwDiP7mm5rw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-JlbNZ20mOwqLvsXmaLT8HA-1; Tue, 19 May 2026 05:27:57 -0400
X-MC-Unique: JlbNZ20mOwqLvsXmaLT8HA-1
X-Mimecast-MFC-AGG-ID: JlbNZ20mOwqLvsXmaLT8HA_1779182876
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43fe791a398so2672683f8f.0
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 02:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182876; x=1779787676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kq5cy4odtanFj4ZmmMjmdUGGp4uB2ZhMg4n7iuzQNs=;
        b=GZ4qwLRcCER83yKpKcB285ROmsor2wN7+yFqgpYdXfZMargz7Pf9M3710jntNcy/o/
         t65Utyr5BI/9IO2S6NClBCMJ2XUaFz8WekFZYSJkXTGBHk0BrIYtQkpNLUDPgn2J/iQk
         Z2neiR2bbjBBz1Y4pP60rT1GmIcDL3RXemHKtDX0gOJKKwqtJsL5cnn3kQavSlezc+yV
         OkvPKcw8avAhl6KFq9vEe7l1xPyaLIV6n9CQjhKG4OCelFJ3K5BEledaRlhnp2IyeuWv
         LOzQq7HByF7HAwIgz+8T87fpdSWY9UbjGJQKA2GeWoyb9QY/w+mq+s0yVMvAmm6ASbsq
         +I6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8fWeR5+81GdviUsQjEF7BqpVdUfGiGBmlBtM1/fQ4TQGLA8COIb101+DEpMUekdqVbdOMpJMrYIcg5LdZA0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyA1Xs4jMwFs8KPzNRndyFHJjeeezE+XcjkIHwDUUaKm1DqejW0
	2P105egnqZM3abLfyfJu7ilH+mwdyTSdCASub216/1HVRIdubuDLrXwoEpOLL3hKXUr+9IpcWY7
	D0+F1CIznItJOjCNy1EaqdaDDHXyoe3JSh1ia46LasTmZ+taWIa/xXZtCqqyqF/RXvuZL
X-Gm-Gg: Acq92OGlrbx1c1tSjYjFu6VYsBF5+BQtaBiFPMOJls40HzCSpEfF/lh1fRrd+yZOWkk
	97ckTQt0FYiymoVePTyk3Q96W8k4uLbznt9Fh5UP2FA5N67U9TSBA07EkT+eDKX0nE5NFYfPTtN
	8FMtMxY5OXpgvbA+qhA/UmOfscCLw55f1S0E5+UcNJBrEwFgbUZDHCYLWG4/QhVO4RC+Os21jhD
	nqo2RDLMG3qjeEQZq965Aos901KcvCUly0hqBngGfyiQ5ngzYWDgJuj8K96f6kBlSkR1KVB8wS5
	1FygxRVqRbgSUGfAeNq6WVekrhx+Vyaym6iEoLQDF+6YwxFY0e7cwxtOjgr094K041igDslxZh9
	5A6clSVk+T1gQjFsCJRCM3dIdrItoEgC0jfK8wlwllxqTBwk/w9pGmjSb423dhDc2uDaztIIWuQ
	==
X-Received: by 2002:a05:6000:40db:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-45e5c6137f0mr31869416f8f.42.1779182876029;
        Tue, 19 May 2026 02:27:56 -0700 (PDT)
X-Received: by 2002:a05:6000:40db:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-45e5c6137f0mr31869195f8f.42.1779182874171;
        Tue, 19 May 2026 02:27:54 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm43178925f8f.16.2026.05.19.02.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:27:53 -0700 (PDT)
Date: Tue, 19 May 2026 11:27:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net v4 0/2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agwrrRSEZ9akIrx-@sgarzare-redhat>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SgbQ97Kw6gWHJKu6_3H1H9vc6xUcytEUamh4osix9Sw_1779182876
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 18, 2026 at 11:06:54AM +0200, Stefano Garzarella wrote:
>Patch 1 resets the connection when we can no longer queue packets,
>this prevents silent data loss, and both peers are notified.
>
>Patch 2 increases the total budget to `buf_alloc * 2` for payload
>plus skb overhead similar to how SO_RCVBUF is doubled to reserve
>space for sk_buff metadata. This preserves the full buf_alloc for
>payload under normal operation, while still bounding the skb queue
>growth.
>
>In the future, we plan to improve how we handle the merging of packets
>to minimize overhead and avoid closing connections.
>
>v4:
>- Split the buf_alloc check to be sure the credit is still respected and
>  to avoid overflow of buf_used [sashiko]
>- call virtio_transport_do_close() and vsock_remove_sock() to properly
>  close the connection and remove the socket from the connect table
>  [sashiko]

sashiko reports 2 issues on the second patch but both IMO are 
pre-existing: 
https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com

The first one related 32-bit architectures should be fixed, but can be a 
follow up since not introduced by this series.

The secong one related to a low value set by the user as buffer size, 
it's also pre-existing and I don't think we can do much.

Please let me know if you prefer to add another patch to this series to 
fix the first issue, or just send another patch.

Thanks,
Stefano


>
>v3: https://lore.kernel.org/netdev/20260513105417.56761-1-sgarzare@redhat.com/
>- Split in 2 patches [MST]
>
>v2: https://lore.kernel.org/netdev/20260512080737.36787-1-sgarzare@redhat.com/
>- Close the connection when we can no longer queue new packets instead
>  of losing data.
>- No longer announce the reduced buf_alloc to avoid violating the
>  spec. [MST]
>
>v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
>
>Stefano Garzarella (2):
>  vsock/virtio: reset connection on receiving queue overflow
>  vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
>
> net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++++-----
> 1 file changed, 23 insertions(+), 6 deletions(-)
>
>-- 
>2.54.0
>

