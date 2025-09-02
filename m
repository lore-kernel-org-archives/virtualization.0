Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7034A31D
	for <virtualization@lists.linux.dev>; Tue,  2 Sep 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836582; cv=none; b=qHySG6etB0BQh7Z5PYEF7/5sd2ppVokJxYeDe87DH7BApMIrBE2eKFMR2tj+S1VTJXPGt7ugMbIGy5v3HD8p70aqn2E6XQFDHfd3xXYRZWooG14Wp9YWHKmhjCDm7Q3cOmnZeXmIA+a1A63SmjoGtx99kWf2wMYggGt1HmDp8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836582; c=relaxed/simple;
	bh=Y8eVLGI2fWWvzJfBBm0TDnfHO3IOvtrvvaZkZXCvssM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4qBf9tpbeUWSsp2Bq9DtV+9uOZa2ZblrxZrdueIW4cdNwnd1Sf7Aa4DUcwX+9sNAF7ezvAuNc9Ur8hu+L7PS0grzS5h+kCbVWKfvBgErdmC4TVYb1rSWL/DBPm+bef/LZxI4TjfiyZRc/8eJlHugHQoqGVECpOVMJ67F+w10aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9MuRXJA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9MuRXJA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77238a3101fso2328733b3a.0
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756836579; x=1757441379; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=neKzYPHQoWMrppBOK0gWXa8x1/CVR4rUelW61BJWncA=;
        b=X9MuRXJAoPqRs91LGcMsgnVEvylFHnsMbHkr6Jc6bPRGkiVnY7aHrMrwM2HEbmAW2U
         K5gy4mG3hD7DtIygMa4FUdsQMixlPrjp5WVk3E4bDBArtWpxgWeFY6FdtN0nu38ETad4
         BfaSUyWHeApPsNmbnwMbhLRNNZvyjhak2TBE3tIPsG+HcVFe5Go6Lkdo5htTckq/QTzf
         ebtwhFd23PYaNtdgREsWLyv8zX8vVH/Mxm6NgVJNYyBbLGvP2Z5Msxja8/iXD/s12rKX
         yEUp7nWuXne+1zArbGdbKLYyObhykMM9hic1EZ7+XkJasQymsMsEUFd0+GncYxJggz/P
         3Jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836579; x=1757441379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neKzYPHQoWMrppBOK0gWXa8x1/CVR4rUelW61BJWncA=;
        b=BxBst+kQz8kaExDdzaA2GlZiSKN7nrAdFdL73oXSJ7y0oZqgx1AE0nQ7BFIZM1TSxG
         AlTnaBE26+HsE8ZRwIek9nT8c/GM9XledgTq4mDBrlvw+cUgSFiwqDw6SnYSXWfZvb18
         sMVrwmvhDlnNd7FRO4fGg+VMIZVJCmeS7KFSTS3yRuY6p7jH+CMq8zXGDwVPUGb69RJ0
         08qBb8udZWsppwy49eioVzKsfmxkksIOEace8lukWsDYItclynGgTNJB9RR4uomXHwID
         yyFMcigAh+FV3DWaIKjyniM+yQQPJmncBJ6Hp8AOBfKOpTYTCqoXParFIU5yI88B4+Kl
         qOAw==
X-Forwarded-Encrypted: i=1; AJvYcCXn6GJm8IvN97l2c3EgTvhGy9o89XvpIj/GaZ64a560TYcnCBuBaKc1DNvYyliyPf7tqbUDIkRX9ytFRNFlJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz9QbQzr7Njq8rFcgX4boFYeZlpA52nsU5NcZBSnZ0MR+s8rP4
	cD6TP9K1n5seqh0R0HlHaR7tRYtkWNfPK/LIY/pm6A0TFIZmb40OTaDa
X-Gm-Gg: ASbGncuz9eCrmoMOxregA4S5m/bj7FbCUHdC07MIDz9oKCbZf+YNIMCb4EPKWKcCUvS
	Xl6YZzznb/78ikaTQEUigZtqNAeJKIEeZL3VFo403LDWir0KlZtuhY2tmhR8K7bGUVzcBTy9K4I
	NHWww3aXcaHtDmj8W/jgIIFfyVh5zGa2mT775htA7Ttf5b2n3GJY6P18rdCiK2+4HdgdNtY69rS
	U+nNc1WRpSh663S6Lb9SDkZL8daJfluwS56Hwm7XQvEru628nVjJe9zSgsdswqd8ahYJpwmNHOi
	ZPArQFr+CK0c1vI4uq6mTaGKEYpXclIvurlOxsHEGP5G1BmCBMAOQtI6RPhVShpN7plRnJOFB8F
	jk5qXGFQFvXry2aIT8tg05WyJCEO8LFhVJlw/LMQlaH6Y
X-Google-Smtp-Source: AGHT+IEszkkL7/+2aZeioYDbLSYEbQhPu9BJi+NsfbBdMxh8of4z3v3uxhiTGB9aKQSvVtw1pfsRiQ==
X-Received: by 2002:a05:6a20:3d07:b0:243:a251:cf5b with SMTP id adf61e73a8af0-243d6f7ec09mr15709679637.57.1756836579228;
        Tue, 02 Sep 2025 11:09:39 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327c5fc5055sm16361875a91.14.2025.09.02.11.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:09:38 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:09:36 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 4/9] vsock/loopback: add netns support
Message-ID: <aLcy4Kk0joVPbxkd@devvm6216.cco0.facebook.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-4-0ba580bede5b@meta.com>
 <mhjgn7fdztfqi6ku3gesgd42jj5atn4sqnvpyncw2jds23dpc3@iiupljayjxs4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhjgn7fdztfqi6ku3gesgd42jj5atn4sqnvpyncw2jds23dpc3@iiupljayjxs4>

On Tue, Sep 02, 2025 at 05:39:33PM +0200, Stefano Garzarella wrote:
> On Wed, Aug 27, 2025 at 05:31:32PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add NS support to vsock loopback. Sockets in a global mode netns
> > communicate with each other, regardless of namespace. Sockets in a local
> > mode netns may only communicate with other sockets within the same
> > namespace.
> > 
> > Add callbacks for transport to hook into the initialization and exit of
> > net namespaces.
> > 
> > The transport's init hook will be called once per netns init. Likewise
> > for exit.
> > 
> > When a set of init/exit callbacks is registered, the init callback is
> > called on each already existing namespace.
> > 
> > Only one callback registration is supported for now. Currently
> > vsock_loopback is the only user.
> 
> Why?
> 
> In general, commit descriptions (and code comments) should focus on the
> reason (why?) to simplify also the review.
> 

Sounds good, will improve the message/comments. I'm realizing as I type
this there may be a way to avoid the callbacks altogether with
pernet_operations, so I'll clarify that before next rev.

> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > ---
> > Changes in v5:
> > - add callbacks code to avoid reverse dependency
> > - add logic for handling vsock_loopback setup for already existing
> >  namespaces
> > ---
> > include/net/af_vsock.h         |  34 +++++++++++++
> > include/net/netns/vsock.h      |   5 ++
> > net/vmw_vsock/af_vsock.c       | 110 +++++++++++++++++++++++++++++++++++++++++
> > net/vmw_vsock/vsock_loopback.c |  72 ++++++++++++++++++++++++---
> > 4 files changed, 213 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > index 83f873174ba3..9333a98b9a1e 100644
> > --- a/include/net/af_vsock.h
> > +++ b/include/net/af_vsock.h
> > @@ -305,4 +305,38 @@ static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
> > 	       (vsock_net_mode(n1) == VSOCK_NET_MODE_GLOBAL &&
> > 		vsock_net_mode(n2) == VSOCK_NET_MODE_GLOBAL);
> > }
> > +
> > +struct vsock_net_callbacks {
> > +	int (*init)(struct net *net);
> > +	void (*exit)(struct net *net);
> > +	struct module *owner;
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
> > +
> > +#define vsock_register_net_callbacks(__init, __exit) \
> > +	__vsock_register_net_callbacks((__init), (__exit), THIS_MODULE)
> > +
> > +int __vsock_register_net_callbacks(int (*init)(struct net *net),
> > +				   void (*exit)(struct net *net),
> > +				   struct module *owner);
> > +void vsock_unregister_net_callbacks(void);
> > +
> > +#else
> > +
> > +#define vsock_register_net_callbacks(__init, __exit) do { } while (0)
> > +
> > +static inline int __vsock_register_net_callbacks(int (*init)(struct net *net),
> > +						 void (*exit)(struct net *net),
> > +						 struct module *owner)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void vsock_unregister_net_callbacks(void) {}
> > +static inline int vsock_net_call_init(struct net *net) { return 0; }
> > +static inline void vsock_net_call_exit(struct net *net) {}
> > +
> > +#endif /* CONFIG_VSOCKETS_LOOPBACK */
> > +
> > #endif /* __AF_VSOCK_H__ */
> > diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
> > index d4593c0b8dc4..08d9a933c540 100644
> > --- a/include/net/netns/vsock.h
> > +++ b/include/net/netns/vsock.h
> > @@ -9,6 +9,8 @@ enum vsock_net_mode {
> > 	VSOCK_NET_MODE_LOCAL,
> > };
> > 
> > +struct vsock_loopback;
> > +
> > struct netns_vsock {
> > 	struct ctl_table_header *vsock_hdr;
> > 	spinlock_t lock;
> > @@ -16,5 +18,8 @@ struct netns_vsock {
> > 	/* protected by lock */
> > 	enum vsock_net_mode mode;
> > 	bool written;
> > +#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
> > +	struct vsock_loopback *loopback;
> 
> If this is not protected by `lock`, please leave an empty line, but maybe we
> should consider using locking (see comment later).
> 

Will do.

> > +#endif
> > };
> > #endif /* __NET_NET_NAMESPACE_VSOCK_H */
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 68a8875c8106..5a73d9e1a96f 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -134,6 +134,9 @@
> > #include <uapi/linux/vm_sockets.h>
> > #include <uapi/asm-generic/ioctls.h>
> > 
> > +static struct vsock_net_callbacks vsock_net_callbacks;
> > +static DEFINE_MUTEX(vsock_net_callbacks_lock);
> > +
> > static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> > static void vsock_sk_destruct(struct sock *sk);
> > static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
> > @@ -2781,6 +2784,49 @@ static void vsock_net_init(struct net *net)
> > 	net->vsock.mode = VSOCK_NET_MODE_GLOBAL;
> > }
> > 
> > +#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
> > +static int vsock_net_call_init(struct net *net)
> > +{
> > +	struct vsock_net_callbacks *cbs;
> > +	int ret;
> > +
> > +	mutex_lock(&vsock_net_callbacks_lock);
> > +	cbs = &vsock_net_callbacks;
> > +
> > +	ret = 0;
> > +	if (!cbs->owner)
> > +		goto out;
> > +
> > +	if (try_module_get(cbs->owner)) {
> > +		ret = cbs->init(net);
> > +		module_put(cbs->owner);
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&vsock_net_callbacks_lock);
> > +	return ret;
> > +}
> > +
> > +static void vsock_net_call_exit(struct net *net)
> > +{
> > +	struct vsock_net_callbacks *cbs;
> > +
> > +	mutex_lock(&vsock_net_callbacks_lock);
> > +	cbs = &vsock_net_callbacks;
> > +
> > +	if (!cbs->owner)
> > +		goto out;
> > +
> > +	if (try_module_get(cbs->owner)) {
> > +		cbs->exit(net);
> > +		module_put(cbs->owner);
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&vsock_net_callbacks_lock);
> > +}
> > +#endif /* CONFIG_VSOCKETS_LOOPBACK */
> > +
> > static __net_init int vsock_sysctl_init_net(struct net *net)
> > {
> > 	vsock_net_init(net);
> > @@ -2788,12 +2834,20 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
> > 	if (vsock_sysctl_register(net))
> > 		return -ENOMEM;
> > 
> > +	if (vsock_net_call_init(net) < 0)
> > +		goto err_sysctl;
> > +
> > 	return 0;
> > +
> > +err_sysctl:
> > +	vsock_sysctl_unregister(net);
> > +	return -ENOMEM;
> > }
> > 
> > static __net_exit void vsock_sysctl_exit_net(struct net *net)
> > {
> > 	vsock_sysctl_unregister(net);
> > +	vsock_net_call_exit(net);
> > }
> > 
> > static struct pernet_operations vsock_sysctl_ops __net_initdata = {
> > @@ -2938,6 +2992,62 @@ void vsock_core_unregister(const struct
> > vsock_transport *t)
> > }
> > EXPORT_SYMBOL_GPL(vsock_core_unregister);
> > 
> > +#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
> > +int __vsock_register_net_callbacks(int (*init)(struct net *net),
> > +				   void (*exit)(struct net *net),
> > +				   struct module *owner)
> > +{
> > +	struct vsock_net_callbacks *cbs;
> > +	struct net *net;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&vsock_net_callbacks_lock);
> > +
> > +	cbs = &vsock_net_callbacks;
> > +	cbs->init = init;
> > +	cbs->exit = exit;
> > +	cbs->owner = owner;
> > +
> > +	/* call callbacks on any net previously created */
> > +	down_read(&net_rwsem);
> > +
> > +	if (try_module_get(cbs->owner)) {
> > +		for_each_net(net) {
> > +			ret = cbs->init(net);
> > +			if (ret < 0)
> > +				break;
> > +		}
> > +
> > +		if (ret < 0)
> > +			for_each_net(net)
> > +				cbs->exit(net);
> > +
> > +		module_put(cbs->owner);
> > +	}
> > +
> > +	up_read(&net_rwsem);
> > +	mutex_unlock(&vsock_net_callbacks_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(__vsock_register_net_callbacks);
> > +
> > +void vsock_unregister_net_callbacks(void)
> > +{
> > +	struct vsock_net_callbacks *cbs;
> > +
> > +	mutex_lock(&vsock_net_callbacks_lock);
> > +
> > +	cbs = &vsock_net_callbacks;
> > +	cbs->init = NULL;
> > +	cbs->exit = NULL;
> > +	cbs->owner = NULL;
> > +
> > +	mutex_unlock(&vsock_net_callbacks_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(vsock_unregister_net_callbacks);
> 
> IIUC this function is called only in the error path of
> `vsock_loopback_init()`, but shuold we call it also in the
> vsock_loopback_exit() ?
> 

Ah right, that needs to be done there too.

> > +#endif /* CONFIG_VSOCKETS_LOOPBACK */
> > +
> > module_init(vsock_init);
> > module_exit(vsock_exit);
> > 
> > diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> > index 1b2fab73e0d0..f16d21711cb0 100644
> > --- a/net/vmw_vsock/vsock_loopback.c
> > +++ b/net/vmw_vsock/vsock_loopback.c
> > @@ -28,8 +28,19 @@ static u32 vsock_loopback_get_local_cid(void)
> > 
> > static int vsock_loopback_send_pkt(struct sk_buff *skb)
> > {
> > -	struct vsock_loopback *vsock = &the_vsock_loopback;
> > +	struct vsock_loopback *vsock;
> > 	int len = skb->len;
> > +	struct net *net;
> > +
> > +	if (skb->sk)
> > +		net = sock_net(skb->sk);
> > +	else
> > +		net = NULL;
> 
> Why we can't use `virtio_vsock_skb_net` here?
> 

No reason why not. Using it should make it more uniform.

> > +
> > +	if (net && net->vsock.mode == VSOCK_NET_MODE_LOCAL)
> > +		vsock = net->vsock.loopback;
> > +	else
> > +		vsock = &the_vsock_loopback;
> > 
> > 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> > 	queue_work(vsock->workqueue, &vsock->pkt_work);
> > @@ -134,27 +145,72 @@ static void vsock_loopback_work(struct work_struct *work)
> > 	}
> > }
> > 
> > -static int __init vsock_loopback_init(void)
> > +static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
> > {
> > -	struct vsock_loopback *vsock = &the_vsock_loopback;
> > -	int ret;
> > -
> > 	vsock->workqueue = alloc_workqueue("vsock-loopback", 0, 0);
> > 	if (!vsock->workqueue)
> > 		return -ENOMEM;
> > 
> > 	skb_queue_head_init(&vsock->pkt_queue);
> > 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
> > +	return 0;
> > +}
> > +
> > +static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
> > +{
> > +	if (vsock->workqueue)
> > +		destroy_workqueue(vsock->workqueue);
> > +}
> > +
> > +/* called with vsock_net_callbacks lock held */
> > +static int vsock_loopback_init_net(struct net *net)
> > +{
> > +	if (WARN_ON_ONCE(net->vsock.loopback))
> > +		return 0;
> > +
> 
> Do we need some kind of locking here? I mean when reading/setting
> `net->vsock.loopback`?
> 

I could be wrong here, but I think net->vsock.loopback being set before
vsock_core_register() prevents racing with net->vsock.loopback reads. We
could add a lock to make sure and to make the protection explicit
though.

> > +	net->vsock.loopback = kmalloc(sizeof(*net->vsock.loopback),
> > GFP_KERNEL);
> > +	if (!net->vsock.loopback)
> > +		return -ENOMEM;
> > +
> > +	return vsock_loopback_init_vsock(net->vsock.loopback);
> > +}
> > +
> > +/* called with vsock_net_callbacks lock held */
> > +static void vsock_loopback_exit_net(struct net *net)
> > +{
> > +	if (net->vsock.loopback) {
> > +		vsock_loopback_deinit_vsock(net->vsock.loopback);
> > +		kfree(net->vsock.loopback);
> 
> Should we set `net->vsock.loopback` to NULL here?
> 

Yes.

> > +	}
> > +}
> > +
> > +static int __init vsock_loopback_init(void)
> > +{
> > +	struct vsock_loopback *vsock = &the_vsock_loopback;
> > +	int ret;
> > +
> > +	ret = vsock_loopback_init_vsock(vsock);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = vsock_register_net_callbacks(vsock_loopback_init_net,
> > +					   vsock_loopback_exit_net);
> 
> IIUC we need this only here because for now the only other transport
> supported is vhost-vsock, and IIUC `struct vhost_vsock *` there is handled
> with a map instead of a static variable, and `net` assigned when
> /dev/vhost-vsock is opened, right?
> 

Correct. The vhost map lookup is modified to account for namespaces, but
vsock loopback doesn't have a map to do that. The callbacks are used to
hook into the netns initialization.

I wonder if it is possible to do this with just pernet_operations
though... when I wrote this I was pretty laser-focused on the
sysctl/procfs + netns init code, and may not have realized there may be
similar hooks that aren't bound to the sysctl/proc init. I'll clarify
this before the next rev.


> If in the future we will need to support G2H transports, like
> virtio-transport, we need to do something similar, right?
> 

My guess is that we'll be able to avoid using these callbacks unless
there is some per-net data we need to initialize. I'm guessing if we
follow a similar path as using ioctl to assign the dev netns, then we
won't need it. It might be moot if pernet_operations work to avoid the
module circular dependency.

> BTW I think we really need to exaplin this better in the commit description.
> It tooks me a while to get all of this (if it's correct)
> 

Roger that, I'll improve this going forward.

Best,
Bobby
