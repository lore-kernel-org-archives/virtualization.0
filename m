Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05055331A61
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285559; cv=none; b=BERCOG0YFsK6z3mJK9XZ24VC21MZnQPTgTSg2SgiRbq0LVay+w0FhVg7tzfDW5IYfJoT8tJepbLC0UHXzKrv3VaesECoIPQtL8W5tMorNrP4Kw1PLjHSUH390+WOs3eXngoXFAlTXZV87n5TdEjFDsaU9mQUHDlM15fcphUPXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285559; c=relaxed/simple;
	bh=8OpYSPc6f7O8KOMZoMzcw+MLAH+EZekjJDAjQynD8mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GKU9BGZvA/6nadxAhyuSHDTHnQWKy+s2UjQNluAkbxzVUmh1Rj2oKXf+UmBf3rcgbi9o5kTqv7z9B3wuAaxCbEmv+8T0q3r7qpmGq4SbGYUPdjNGhEoFfujj6KPFP+wUk1mc2NpfkyC/PtcCrv+2PpGWCdnik/dFJvAhlsz/wQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrPa+tiA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrPa+tiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765285557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C7bt9DIhoeZ6jD2VdZvxOLbQYfNsQNZi6wdwI6g+uRA=;
	b=GrPa+tiABFfGweenwCzwHB9wT+fhg9fYUu+y5CIkch2YmBP+QZrp8OmXiebXDedzIM8l+A
	57eZ8iOfflaQ8/9TNSwlhyofk7MaRqK46EwR1Nnbtdeo6Gf9hEiKm5n8nP+8AL40fT7dQO
	BFWZJeEdWteuwduGpiZd+mPcEJR58cA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-gNKeF0WiOWieapEFhW9MWA-1; Tue, 09 Dec 2025 08:05:55 -0500
X-MC-Unique: gNKeF0WiOWieapEFhW9MWA-1
X-Mimecast-MFC-AGG-ID: gNKeF0WiOWieapEFhW9MWA_1765285554
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779981523fso49104285e9.2
        for <virtualization@lists.linux.dev>; Tue, 09 Dec 2025 05:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765285554; x=1765890354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7bt9DIhoeZ6jD2VdZvxOLbQYfNsQNZi6wdwI6g+uRA=;
        b=Io4gzRF0aVSUUjcMLYnALrJsaqjOPoksxljesALRuiZkd4AcsPkZ99qpxSo2sdl+tJ
         oDOUmg0Zxopwkm3amHb/qQl+xqNzgIgucMmBLuY6m9y8j8mp7uBeGfpi75zA9309JcWc
         N3gfhfqCZxyomz38IzQSB5MoMULfQVFbNCaMBjcGl6GQWEQaPFk7gI7oU1NAHNBkZpdE
         Fk7TBxC3SrfJhZaT7aQECvSGuEtIcETaaickjCvouXHVeZhUyiE6AZEm4du6GZXuPvsh
         e1dcrDFu4R9CikaH3e0695L4jD8I46YSUFuTSClOJ6bwZG5NYuIyxiD+ET058sw0cyhy
         gQxQ==
X-Gm-Message-State: AOJu0YwViikBQpGGm80KLe4hWXmUJTP7E5gTdOnrC0VZ+EhM4LAfKSv6
	o/fF/i+pQ7U3h04DZcxapdqMmxv3Sh/01oSyc14o4+qWbrKyyjTZImmU+SXFBH4TV8d/b0r3AoV
	y2p7IXW5lPFrR3RIdJO4OsTdAhc7gFkIpkqcAeMSVv9h3RONsinyTpwrh58AGTqYmkOfR
X-Gm-Gg: ASbGncuhNrFZ7KXHykp61GhMeejyXlG3CQypLRKnrrBICTo1471vMo3nCqXYxMkAN1m
	JdPAaHatC1gO3rIHpJpRQOhrcaRh2un8pUUTuvK1eZ2zqwFhlLB4T6d0ahdmaB41Es/88mTnZe2
	fN3A2Hd/fC591SfkMxbb5fomq/4LWpKRatYpsBkWOuZhcwYKK9oqfn4vH0Fp3M0ltBARXkXSMrj
	BYzWDY9Hlcgt49yLrAEGLDDnnmpNX+lVqkkc44V3jcC7+3SdSc5bT+s0/3Wu3y1YyzgauIdsD9b
	D8uTP1/6rH9kdQI7RXx112TfJX+qWsRQ62UNZJJsbNo9nI3lE0MUXuUK59qtwA8k5FFgpI+58Rs
	kHUEYKJEENZMi2P5ZeQmO3dj/STR4Tkuzkg==
X-Received: by 2002:a05:600c:1c1b:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-47939dfa09fmr106050945e9.12.1765285554110;
        Tue, 09 Dec 2025 05:05:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuQABtiUkLD+rMxYkpHCMPJ0jWGiDwWoX4yNSI50FHhHBBQ+qu1qOfQtW9LU1ZqHfufP6qYw==
X-Received: by 2002:a05:600c:1c1b:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-47939dfa09fmr106050485e9.12.1765285553476;
        Tue, 09 Dec 2025 05:05:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d357820sm17802735e9.2.2025.12.09.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 05:05:52 -0800 (PST)
Date: Tue, 9 Dec 2025 08:05:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: improve RCU read sections around
 vhost_vsock_get()
Message-ID: <20251209080528-mutt-send-email-mst@kernel.org>
References: <20251126133826.142496-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251126133826.142496-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: awTRixMpvZrwdpmmh6Oz62Zr800ed7oXZkUb4DxI4Ko_1765285554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 02:38:26PM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> vhost_vsock_get() uses hash_for_each_possible_rcu() to find the
> `vhost_vsock` associated with the `guest_cid`. hash_for_each_possible_rcu()
> should only be called within an RCU read section, as mentioned in the
> following comment in include/linux/rculist.h:
> 
> /**
>  * hlist_for_each_entry_rcu - iterate over rcu list of given type
>  * @pos:	the type * to use as a loop cursor.
>  * @head:	the head for your list.
>  * @member:	the name of the hlist_node within the struct.
>  * @cond:	optional lockdep expression if called from non-RCU protection.
>  *
>  * This list-traversal primitive may safely run concurrently with
>  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
>  * as long as the traversal is guarded by rcu_read_lock().
>  */
> 
> Currently, all calls to vhost_vsock_get() are between rcu_read_lock()
> and rcu_read_unlock() except for calls in vhost_vsock_set_cid() and
> vhost_vsock_reset_orphans(). In both cases, the current code is safe,
> but we can make improvements to make it more robust.
> 
> About vhost_vsock_set_cid(), when building the kernel with
> CONFIG_PROVE_RCU_LIST enabled, we get the following RCU warning when the
> user space issues `ioctl(dev, VHOST_VSOCK_SET_GUEST_CID, ...)` :
> 
>   WARNING: suspicious RCU usage
>   6.18.0-rc7 #62 Not tainted
>   -----------------------------
>   drivers/vhost/vsock.c:74 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   1 lock held by rpc-libvirtd/3443:
>    #0: ffffffffc05032a8 (vhost_vsock_mutex){+.+.}-{4:4}, at: vhost_vsock_dev_ioctl+0x2ff/0x530 [vhost_vsock]
> 
>   stack backtrace:
>   CPU: 2 UID: 0 PID: 3443 Comm: rpc-libvirtd Not tainted 6.18.0-rc7 #62 PREEMPT(none)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-7.fc42 06/10/2025
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x75/0xb0
>    dump_stack+0x14/0x1a
>    lockdep_rcu_suspicious.cold+0x4e/0x97
>    vhost_vsock_get+0x8f/0xa0 [vhost_vsock]
>    vhost_vsock_dev_ioctl+0x307/0x530 [vhost_vsock]
>    __x64_sys_ioctl+0x4f2/0xa00
>    x64_sys_call+0xed0/0x1da0
>    do_syscall_64+0x73/0xfa0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    ...
>    </TASK>
> 
> This is not a real problem, because the vhost_vsock_get() caller, i.e.
> vhost_vsock_set_cid(), holds the `vhost_vsock_mutex` used by the hash
> table writers. Anyway, to prevent that warning, add lockdep_is_held()
> condition to hash_for_each_possible_rcu() to verify that either the
> caller is in an RCU read section or `vhost_vsock_mutex` is held when
> CONFIG_PROVE_RCU_LIST is enabled; and also clarify the comment for
> vhost_vsock_get() to better describe the locking requirements and the
> scope of the returned pointer validity.
> 
> About vhost_vsock_reset_orphans(), currently this function is only
> called via vsock_for_each_connected_socket(), which holds the
> `vsock_table_lock` spinlock (which is also an RCU read-side critical
> section). However, add an explicit RCU read lock there to make the code
> more robust and explicit about the RCU requirements, and to prevent
> issues if the calling context changes in the future or if
> vhost_vsock_reset_orphans() is called from other contexts.
> 
> Fixes: 834e772c8db0 ("vhost/vsock: fix use-after-free in network stack callers")
> Cc: stefanha@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


queued, thanks!

> ---
>  drivers/vhost/vsock.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ae01457ea2cd..78cc66fbb3dd 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -64,14 +64,15 @@ static u32 vhost_transport_get_local_cid(void)
>  	return VHOST_VSOCK_DEFAULT_HOST_CID;
>  }
>  
> -/* Callers that dereference the return value must hold vhost_vsock_mutex or the
> - * RCU read lock.
> +/* Callers must be in an RCU read section or hold the vhost_vsock_mutex.
> + * The return value can only be dereferenced while within the section.
>   */
>  static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>  {
>  	struct vhost_vsock *vsock;
>  
> -	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid) {
> +	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
> +				   lockdep_is_held(&vhost_vsock_mutex)) {
>  		u32 other_cid = vsock->guest_cid;
>  
>  		/* Skip instances that have no CID yet */
> @@ -707,9 +708,15 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
>  	 * executing.
>  	 */
>  
> +	rcu_read_lock();
> +
>  	/* If the peer is still valid, no need to reset connection */
> -	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
> +	if (vhost_vsock_get(vsk->remote_addr.svm_cid)) {
> +		rcu_read_unlock();
>  		return;
> +	}
> +
> +	rcu_read_unlock();
>  
>  	/* If the close timeout is pending, let it expire.  This avoids races
>  	 * with the timeout callback.
> -- 
> 2.51.1

