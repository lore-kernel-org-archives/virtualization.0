Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108155695
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842846; cv=none; b=BUv7yCW4Ipk+uEnNRHmu8wWglc+vIzrKKtz7YKs8AkxjDvyWHAUig0CMWVdNuAEx9yXmOa0LRhbylAdLIpl5o2weWHN69ACHL/cQXHCsdIKumWf8L8AI8xiUna8xNzZrzZT0HGbcTWDBzY4+iI7p7zQnq/vJrAU/Rp/zoVB7J+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842846; c=relaxed/simple;
	bh=F11q+SajRL1s+aGrsJcfDhgtWQTBvLq27lRdD4eAHL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUzWuNRO/ov9lY9Wzj34SwTrSLBfjcwBDGxHeogwvOXYHagYlTPqNzq0jBDvBGUme5/X4FaD+Rhth7wEWjKVYu412YUumQcbejCWwWI7RhdoSVSGeXWHZ42rJEfOexikh7qJuFMKIMXWPOFvGXqEGPwzliup+RAyVoIbhSfzmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pRmB61R7; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pRmB61R7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752842841;
	bh=cRELcXBlxny6lNaBGcEEyYOTog8DRO1ARtWovaU+gaI=;
	h=From:Subject:Date:Message-ID;
	b=pRmB61R7/mHbnh5THnMw5yk9sfygsKFq+y1pRMKV5E5GWqQEmct/zy6M3Xnvl48km
	 UPuWCqIvz7hpHt6oPCW05Xge+3aMFu27esnuz7EOojdGOyVW7EZR1HETWG54dPBb94
	 RUM8zLGKMqtlxSKgP9FJ4XwD/Kgq5h1EEYQB/0Lk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 687A424B000069BD; Fri, 18 Jul 2025 20:47:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9991446816238
X-SMAIL-UIID: B92073821F22481A95B5626781CD631D-20250718-204708-1
From: Hillf Danton <hdanton@sina.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	Andrey Ryabinin <arbn@yandex-team.com>,
	Andrey Smetanin <asmetanin@yandex-team.ru>
Subject: Re: [PATCH v2] vhost/net: Replace wait_queue with completion in ubufs reference
Date: Fri, 18 Jul 2025 20:46:56 +0800
Message-ID: <20250718124657.2394-1-hdanton@sina.com>
In-Reply-To: <20250718110355.1550454-1-kniv@yandex-team.ru>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 14:03:55 +0300 Nikolay Kuratov wrote:
> 
>  drivers/vhost/net.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..69e1bfb9627e 100644
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
> @@ -249,14 +249,14 @@ static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
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
>  }
>  
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
> @@ -1381,6 +1381,7 @@ static void vhost_net_flush(struct vhost_net *n)
>  		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  		n->tx_flush = false;
>  		atomic_set(&n->vqs[VHOST_NET_VQ_TX].ubufs->refcount, 1);
> +		reinit_completion(&n->vqs[VHOST_NET_VQ_TX].ubufs->wait);
>  		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  	}
>  }
> -- 
> 2.34.1
> 
In the sequence below,
	vhost_net_flush()
	  vhost_net_ubuf_put_and_wait(n->vqs[VHOST_NET_VQ_TX].ubufs);
	    wait_for_completion(&ubufs->wait);
	  reinit_completion(&n->vqs[VHOST_NET_VQ_TX].ubufs->wait);

reinit after wait, so the chance for missing wakeup still exists.
