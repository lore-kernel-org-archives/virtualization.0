Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714B3644CB
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453223; cv=none; b=F169PJsixdaz7ZK7I8Akv4CsFaRXDG4nJf2BxUnu2+TETcuXhrnQBYsyoKx1Xyn0UEJ8TiNvfI+9x+qSyi/1Us2AE4alaDAKD98W/0NCzp5nuEwBgkg5gaUJhhl8YR4JV4jSxbqH0zpNNqEVDEHwVJ4Gb3lX2KuruH4YECuIxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453223; c=relaxed/simple;
	bh=hWo99dcPxR938udacUcF8OjqE0Ne+a/dIWKnSWa/bFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sb6KEADVRkqPYbeedOZDQt841jxG3Ccqp0OUGk5o0jJkeL9yxoLcdrCYtq9ytHmjSgeosz/ofWT/feNBl5y8vnzEpj4eri8ylZ25DgyZsrKRVqR3sEdilCMiWRnA4zRCyCdMmTe8XreVWx7FbXkSxsMvPL5JySTjAe7vcKLGfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXlF6Y5X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXlF6Y5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772453221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wY6cGgZtSvQ1tBML++SvZaka9Xv+OGOyQzuRqjlOQ6U=;
	b=QXlF6Y5XyVootNrqwYy/5DChXazL/dtvDHbA25jZ3n3PU1WVcDByclDOL43bUIVbWz4GIt
	nM6WT9KqJrp6DZv9GUmF7T5uWXQ1XdDdpogJFrEkG4Xg3ZT0iPuOyBHShRFwqIBArPhIa1
	c2tPYn7xw7SSLua24pGzo/vlrNJOSE4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-x3TOSWzcMrauXzlcjDmdXw-1; Mon, 02 Mar 2026 07:06:58 -0500
X-MC-Unique: x3TOSWzcMrauXzlcjDmdXw-1
X-Mimecast-MFC-AGG-ID: x3TOSWzcMrauXzlcjDmdXw_1772453217
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837246211bso56993215e9.0
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 04:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772453217; x=1773058017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY6cGgZtSvQ1tBML++SvZaka9Xv+OGOyQzuRqjlOQ6U=;
        b=K7ZJnN+osbyI2yDGsjSVx5E7Mdf7E/xZzjegoJZbkKDsl6g9rwKYw9WvaIAbmBZHoN
         i82q6Il5A57hdEK7VZ9TC7JOf1p/ym3T2MvSp/NHUM+38BywJTZVEcnZ31XWaDRJA2Ju
         6RZ69M+0IZWRZbHnQSEVEEDHvK6vgK0OyiOvkBHyLmEV0YBbLdqC+ORzXG+VbrvDV62G
         7Gu9XhwnGwFctbxXhT8zZ9/xOEMCr73iiNDbb+isvZ28M420dsDQ7sY61sebczd/BqST
         PjntIB4Kq0H87IjW+0+1ybCpL72K4HC2yaq0/qrXWBOm2NuF/4pS2BIZ2yuIFb61gP03
         jIZw==
X-Gm-Message-State: AOJu0YzAQ80e2uolSAnX0f0cdJ2JBd+eXkkf3v6iyVxVGPROBqOPf8zc
	khJWec7lv0PpQmn+3eMP6o2JIl+PJkB/3oiCSfS1Anjw7SOAJ6daPXI+M+jwN4YDNFW0h13ahjK
	2SEF9DfxlPXl+xOCt18JgJOA6UYqHxC/h9+pKMqdkkeaJgRrU7+DaOFEScpoBoPMCkqPI
X-Gm-Gg: ATEYQzx5kQqdnf4bVhuSVuuLeRz2Sb/CzBWolUstHofuLgddU/8E3Z5LYvMomdyNXLc
	4ZcPpySSy11G4R6BB6wGkzhn7KTwAODJOk+CyMswswAp4tEunYNDXc8A3r9UgjluKNeeGmIvGmz
	cYgjZHeAYH0jGg16njjArzMkj0tP0TkXtstuJOUx1Bm+S683HPx00BI3NHbNGqojRXkUaoY9m99
	y3uut36DX+pBs/hjXsjcxYPhr1vzOmWyQuRPoLQsUeqsSy/e3xA6f0W2TbglftJIS2l3mCYTHw8
	fQTCd8RNMHyOJrrBn9x0qxRGWWc+uCykXsnN5ieSWEkacz2u/eapGBhLsZan8Fm+V0/UxguN//t
	xSwIe0aBZQJqF5KtRdtvh5W9Lyr5HOY+PC6HZuHhC3B+kzzyIissGlu/NRxbxhTsN7C0YFk4=
X-Received: by 2002:a05:600c:5249:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-483c9c29b56mr197779745e9.32.1772453217058;
        Mon, 02 Mar 2026 04:06:57 -0800 (PST)
X-Received: by 2002:a05:600c:5249:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-483c9c29b56mr197778995e9.32.1772453216431;
        Mon, 02 Mar 2026 04:06:56 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb2c5a8sm194215805e9.0.2026.03.02.04.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:06:55 -0800 (PST)
Date: Mon, 2 Mar 2026 13:06:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	Jason Wang <jasowang@redhat.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	nh-open-source@amazon.com
Subject: Re: [PATCH] vsock: Enable H2G override
Message-ID: <aaV80wWlpjEtYCQJ@sgarzare-redhat>
References: <20260302104138.77555-1-graf@amazon.com>
 <aaVrsXMmULivV4Se@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aaVrsXMmULivV4Se@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g0YwyltyBLh37NOIkw0cUdjbY6l6M3E14Re0Uv_k4po_1772453217
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

CCing Bryan, Vishnu, and Broadcom list.

On Mon, Mar 02, 2026 at 12:47:05PM +0100, Stefano Garzarella wrote:
>
>Please target net-next tree for this new feature.
>
>On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
>>Vsock maintains a single CID number space which can be used to
>>communicate to the host (G2H) or to a child-VM (H2G). The current logic
>>trivially assumes that G2H is only relevant for CID <= 2 because these
>>target the hypervisor.  However, in environments like Nitro Enclaves, an
>>instance that hosts vhost_vsock powered VMs may still want to communicate
>>to Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
>>
>>That means that for CID > 2, we really want an overlay. By default, all
>>CIDs are owned by the hypervisor. But if vhost registers a CID, it takes
>>precedence.  Implement that logic. Vhost already knows which CIDs it
>>supports anyway.
>>
>>With this logic, I can run a Nitro Enclave as well as a nested VM with
>>vhost-vsock support in parallel, with the parent instance able to
>>communicate to both simultaneously.
>
>I honestly don't understand why VMADDR_FLAG_TO_HOST (added 
>specifically for Nitro IIRC) isn't enough for this scenario and we 
>have to add this change.  Can you elaborate a bit more about the 
>relationship between this change and VMADDR_FLAG_TO_HOST we added?
>
>>
>>Signed-off-by: Alexander Graf <graf@amazon.com>
>>---
>>drivers/vhost/vsock.c    | 11 +++++++++++
>>include/net/af_vsock.h   |  3 +++
>>net/vmw_vsock/af_vsock.c |  3 +++
>>3 files changed, 17 insertions(+)
>>
>>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>>index 054f7a718f50..223da817e305 100644
>>--- a/drivers/vhost/vsock.c
>>+++ b/drivers/vhost/vsock.c
>>@@ -91,6 +91,16 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>>	return NULL;
>>}
>>
>>+static bool vhost_transport_has_cid(u32 cid)
>>+{
>>+	bool found;
>>+
>>+	rcu_read_lock();
>>+	found = vhost_vsock_get(cid) != NULL;
>
>We recently added namespaces support that changed vhost_vsock_get() 
>params. This is also in net tree now and in Linus' tree, so not sure 
>where this patch is based, but this needs to be rebased since it is 
>not building:
>
>../drivers/vhost/vsock.c: In function ‘vhost_transport_has_cid’:
>../drivers/vhost/vsock.c:99:17: error: too few arguments to function ‘vhost_vsock_get’; expected 2, have 1
>   99 |         found = vhost_vsock_get(cid) != NULL;
>      |                 ^~~~~~~~~~~~~~~
>../drivers/vhost/vsock.c:74:28: note: declared here
>   74 | static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>      |
>
>>+	rcu_read_unlock();
>>+	return found;
>>+}
>>+
>>static void
>>vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>			    struct vhost_virtqueue *vq)
>>@@ -424,6 +434,7 @@ static struct virtio_transport vhost_transport = {
>>		.module                   = THIS_MODULE,
>>
>>		.get_local_cid            = vhost_transport_get_local_cid,
>>+		.has_cid                  = vhost_transport_has_cid,
>>
>>		.init                     = virtio_transport_do_socket_init,
>>		.destruct                 = virtio_transport_destruct,
>>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>index 533d8e75f7bb..4cdcb72f9765 100644
>>--- a/include/net/af_vsock.h
>>+++ b/include/net/af_vsock.h
>>@@ -179,6 +179,9 @@ struct vsock_transport {
>>	/* Addressing. */
>>	u32 (*get_local_cid)(void);
>>
>>+	/* Check if this transport serves a specific remote CID. */
>>+	bool (*has_cid)(u32 cid);
>
>What about "has_remote_cid" ?
>
>>+
>>	/* Read a single skb */
>>	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>>
>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>index 2f7d94d682cb..8b34b264b246 100644
>>--- a/net/vmw_vsock/af_vsock.c
>>+++ b/net/vmw_vsock/af_vsock.c
>>@@ -584,6 +584,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>>			 (remote_flags & VMADDR_FLAG_TO_HOST))
>>			new_transport = transport_g2h;
>>+		else if (transport_h2g->has_cid &&
>>+			 !transport_h2g->has_cid(remote_cid))
>>+			new_transport = transport_g2h;
>
>We should update the comment on top of this fuction, and maybe also 
>try to support the other H2G transport (i.e. VMCI).
>
>@Bryan @Vishnu can the new has_cid()/has_remote_cid() be supported by 
>VMCI too?

Oops, I forgot to CC them, now they should be in copy.

Stefano


>
>
>
>I have a question: until now, transport assignment was based simply on 
>analyzing local socket information (vsk->remote_addr), but now we are 
>also adding the status of other components (e.g., VMs that have 
>started and registered the CID in vhost-vsock).
>
>Could this produce strange behavior?
>For example, two sockets with the same remote_addr communicate with 
>the host or with the guest depending on whether or not the VM existed 
>when they were created.
>
>Thanks,
>Stefano
>
>>		else
>>			new_transport = transport_h2g;
>>		break;
>>-- 
>>2.47.1
>>
>>
>>
>>
>>Amazon Web Services Development Center Germany GmbH
>>Tamara-Danz-Str. 13
>>10243 Berlin
>>Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
>>Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
>>Sitz: Berlin
>>Ust-ID: DE 365 538 597
>>
>>

