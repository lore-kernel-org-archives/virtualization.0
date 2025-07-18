Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6438E7D098
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879856; cv=none; b=uvufjcqnoq/S8J2sFCs98UMSEWOBt6FTIQXMwEuxoZgIPSDj9uUlOaNj10+eJtfGgd6+OMepO6TcuntmqpHG8sb09v1iAAaYNXpH36wYTNoT1X1j3S0qrQkmrFEOFygsVPl3G+wxGwvQdkGO98wgCOs+OQdGRcn3+okDbf0gNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879856; c=relaxed/simple;
	bh=aNFT0yZ80RgyPPBqO0HADJeRn51vBTpDeBK+1CGG40M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIaAelHMnRe43FMET1zMm7BsjieIZw/lyYKtrp5UHaDxiMYEzWI4Cdhe46+NQZ5BAqy4J45Gmb2ifgS+tD7K7LrwN4lsX7gPFplzczgMwzJfRFi+3aX06aKFQximnbhxb45YOJwFYrmd4KjNik6aoFnHoPvW1SH0PtmDCZMhjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=K+00J/Sc; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="K+00J/Sc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752879851;
	bh=LFxEnCAkEFyUblYDoXXBiBzO8Qo/AzKOdZm5iH4dMdU=;
	h=From:Subject:Date:Message-ID;
	b=K+00J/ScWY0XWeaZBVUbk9UgiadBEvtiVRoD3Y2l66SOn5lMwJ04GRJK8WIoiBT+Z
	 Auq5HNhxJNbhh9O3z7Jb0C891ULDbNQMwH8RgD+eBnHuew4m9JcwZHA7PGwLct8Rjf
	 3EDJ8/FsiBNvW6piIGoXtaWouB6kThpI2fuWNoYw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 687AD2E6000070F4; Fri, 19 Jul 2025 07:04:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3834976816285
X-SMAIL-UIID: FA24C9C871B0402384642277C907EC60-20250719-070408-1
From: Hillf Danton <hdanton@sina.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	Andrey Ryabinin <arbn@yandex-team.com>,
	Andrey Smetanin <asmetanin@yandex-team.ru>
Subject: Re: [PATCH v2] vhost/net: Replace wait_queue with completion in ubufs reference
Date: Sat, 19 Jul 2025 07:03:23 +0800
Message-ID: <20250718230356.2459-1-hdanton@sina.com>
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
> When operating on struct vhost_net_ubuf_ref, the following execution
> sequence is theoretically possible:
> CPU0 is finalizing DMA operation                   CPU1 is doing VHOST_NET_SET_BACKEND
>                              // &ubufs->refcount == 2
> vhost_net_ubuf_put()                               vhost_net_ubuf_put_wait_and_free(oldubufs)
>                                                      vhost_net_ubuf_put_and_wait()
>                                                        vhost_net_ubuf_put()
>                                                          int r = atomic_sub_return(1, &ubufs->refcount);
>                                                          // r = 1
> int r = atomic_sub_return(1, &ubufs->refcount);
> // r = 0
>                                                       wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
>                                                       // no wait occurs here because condition is already true
>                                                     kfree(ubufs);
> if (unlikely(!r))
>   wake_up(&ubufs->wait);  // use-after-free
> 
> This leads to use-after-free on ubufs access. This happens because CPU1
> skips waiting for wake_up() when refcount is already zero.
> 
> To prevent that use a completion instead of wait_queue as the ubufs
> notification mechanism. wait_for_completion() guarantees that there will
> be complete() call prior to its return.
> 
Alternatively rcu helps.

--- x/drivers/vhost/net.c
+++ y/drivers/vhost/net.c
@@ -96,6 +96,7 @@ struct vhost_net_ubuf_ref {
 	atomic_t refcount;
 	wait_queue_head_t wait;
 	struct vhost_virtqueue *vq;
+	struct rcu_head rcu;
 };
 
 #define VHOST_NET_BATCH 64
@@ -247,9 +248,13 @@ vhost_net_ubuf_alloc(struct vhost_virtqu
 
 static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
 {
-	int r = atomic_sub_return(1, &ubufs->refcount);
+	int r;
+
+	rcu_read_lock();
+	r = atomic_sub_return(1, &ubufs->refcount);
 	if (unlikely(!r))
 		wake_up(&ubufs->wait);
+	rcu_read_unlock();
 	return r;
 }
 
@@ -262,7 +267,7 @@ static void vhost_net_ubuf_put_and_wait(
 static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
 {
 	vhost_net_ubuf_put_and_wait(ubufs);
-	kfree(ubufs);
+	kfree_rcu(ubufs, rcu);
 }
 
 static void vhost_net_clear_ubuf_info(struct vhost_net *n)
