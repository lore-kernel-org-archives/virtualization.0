Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA620E71D
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829672; cv=none; b=Mc1NbPZrfeI5fM8TCHh8UUPMIkk4UZBW2N+M7uIb2/SvlyZQno3VlEKODR/seHlXEWH4S/CcavG8u1AEBkJ1kWfQ7iZbw6pp8Ps8VT0HZWVi6n6fqZUowRUsyedI0IzlMJe9sIrcwmMC478FeoFCZIvsAoFmSgv1ETMX4qUCIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829672; c=relaxed/simple;
	bh=tdcTDQz0ceE2ycFuA9V+lIGdMG3HLelkQNZjBbIokO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFgF5lpzwonlvHKiO43/f9x/sy5HCU0buF0z+7KVHffrBiosH8VtuzSpm299+TPtsNlRaLfEYasrZmF4h5LqnS9SYjwJwtKovLSlxFiuGNmH4TdXNVmUjhi8NQyXaYmuk2O/lOfcD2/tgGDa2ArVPb0BdhLy6to3GOW30RSaP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=YpkGA/fm; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="YpkGA/fm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752829663;
	bh=PAssbCFbHKXX8KDkOtfUWg5h+sjvgzJKyTPGjFAvfYg=;
	h=From:Subject:Date:Message-ID;
	b=YpkGA/fmCw3RdN2rFPDp9aEov2ucOIOCBc2omg4Df3dw/0COZAYMpeyfVPLE95X3S
	 J68k6K4G9LQrbWo6OSPPcUKUN5apLpyGG7mEIXizDm2WxpT7t0s8AtedtAe4lasRw3
	 aK9DlTP/asuaLFQXwkUQL3ZWFvTlzF+IfeQgS2vE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 687A0ED5000079FC; Fri, 18 Jul 2025 17:07:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1225016292282
X-SMAIL-UIID: 87A29BE28692473C9B3A50DD8B7A1688-20250718-170735-1
From: Hillf Danton <hdanton@sina.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	Andrey Ryabinin <arbn@yandex-team.com>,
	Andrey Smetanin <asmetanin@yandex-team.ru>
Subject: Re: [PATCH] vhost/net: Replace wait_queue with completion in ubufs reference
Date: Fri, 18 Jul 2025 17:07:24 +0800
Message-ID: <20250718090725.2352-1-hdanton@sina.com>
In-Reply-To: <20250716162243.1401676-1-kniv@yandex-team.ru>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 19:22:43 +0300 Nikolay Kuratov wrote:
>  drivers/vhost/net.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..454d179fffeb 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
>  	 * >1: outstanding ubufs
>  	 */
>  	atomic_t refcount;
> -	wait_queue_head_t wait;
> +	struct completion wait;
>  	struct vhost_virtqueue *vq;
>  };
>  
> @@ -240,7 +240,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>  	if (!ubufs)
>  		return ERR_PTR(-ENOMEM);
>  	atomic_set(&ubufs->refcount, 1);
> -	init_waitqueue_head(&ubufs->wait);
> +	init_completion(&ubufs->wait);
>  	ubufs->vq = vq;
>  	return ubufs;
>  }
> @@ -249,14 +249,15 @@ static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
>  {
>  	int r = atomic_sub_return(1, &ubufs->refcount);
>  	if (unlikely(!r))
> -		wake_up(&ubufs->wait);
> +		complete_all(&ubufs->wait);
>  	return r;
>  }
>  
>  static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs)
>  {
>  	vhost_net_ubuf_put(ubufs);
> -	wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
> +	wait_for_completion(&ubufs->wait);
> +	reinit_completion(&ubufs->wait);

In the case of 5 waiters for example, after the first waiter reinitializes
the completion, the 3rd waiter misses the wakeup, no?

>  }
>  
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
> -- 
> 2.34.1
