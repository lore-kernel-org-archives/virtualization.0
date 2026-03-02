Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D013630AF
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452037; cv=none; b=A25fH7LWfRXOpC2rgLY08XgwtFcJMD91WLjp/2djxPwFVqabWmm2mW87SUssy5B0HmzTpPdvf9HMKo+LrWqMGou+hfrasa13shpQgpHTwcC10N4D2DRYUh+1YVB5UTTMBKb1QLdQMGrX7inrNiJtlamFfmFnjSGSSQ/5fJ+DOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452037; c=relaxed/simple;
	bh=jIEye+0df33ikFViPPR9akfXSu+t/01QHhvxzHLng1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LvXtFBGS40+Dy9d57N3a867x/fTKEWkLkIiHg4FBFagLsbjbXH/ybBfVwJqzDkd8O9GRuZYZNknLDcg5g9tSmcF7iU5BJtv7/DAcuwtopwhBuR/27H1qg0q+6y+Bd8PoN0Xxfpee5HbAP0Eiwke+ushDIkDBWMHzugB0XA7P7ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNIQp32L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNIQp32L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772452035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eummRfVqZi/xRPz07HlbI09UFKU1skHozaqbPUYQxGg=;
	b=DNIQp32LXxIEmr+clYpk5bDnnbh+b7n/nYiWZSH7/KmlbTBBr3c0SLfAsTwIuXlUzY3Vga
	Y4rPnaFQdry7mSmxLK0TIzDvl5ISTvTRVfuYMScWxY2+HQCxJ3quGk7BRXUcNCXqcUrRVR
	zact223AptUqET/DutM19AYXRLSf930=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-UBTOzrkqPGuayhsiLv2JuA-1; Mon, 02 Mar 2026 06:47:14 -0500
X-MC-Unique: UBTOzrkqPGuayhsiLv2JuA-1
X-Mimecast-MFC-AGG-ID: UBTOzrkqPGuayhsiLv2JuA_1772452033
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837cee2e9bso34929985e9.3
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 03:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452033; x=1773056833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eummRfVqZi/xRPz07HlbI09UFKU1skHozaqbPUYQxGg=;
        b=ou5V5uyYW4cOWzbUlR57zjiFl1op+dmmWtUFjZ1z9fKc6UXGY6/rpUOap1z7y0an56
         TuZGJI3OIR3XlrxmS60C/zJDGc7CLOQsVxlniWWFX4mV523b8V2hNENkzaYNuk7JtnqR
         0pW1jLKGJlnqy1DjejsB1WYKvanqMampMvhapel8YNTKaC7vDwZ8xYqKoN75ZRcN7EOZ
         kSbhM7M0RKKvrFVzH3CcGwlcA61nlPwQbIHqdHjHzPC4z1gCkThaTQjtEWXa/SBmICJC
         uZhlFQWAMjDf+IAo94EXNGDp6K+NM/IoI6gDLBnZtbST7VhMpAVRz3PiKcUkmiJeWg2n
         u+7w==
X-Gm-Message-State: AOJu0YwtUpcqygj4ko6qT87QSLj2kmuuDUZ0V9jJK4NUCU4H+wVyQt32
	MBP+uksJriSObMxt8/yBVmxfNiVccHxxTx62AFPczpNm/XWRpZALnw3ISIIwZChysO2HkbANVkN
	oNv5/nVvH7uJzRz7Gx7+UM4gfxlB90LDJRWXXOryaLOdNhPubrpTiC862Xufc1kMu7Ffc
X-Gm-Gg: ATEYQzzoU7f3GLXEhWoZ8cOg+IFAmrvMcY+vowA/L7GgpB3UrrHzRTkG7GrVIHxiRfF
	SCgF9Di0DmJi8XQxk7KoAcoia2jMYIOH5jvWQOUy7s8N179bckwZSY8dVW9K1t/SFmicCdBhC80
	N4TlQ4WSKrnFNo97HJvSBdATcaV2yt0mMaOOwynBliD0z9dIACtQ4hGPLYbz5wbGjQ8oZSMzVad
	Eu9byre6Q0RfpraAc88dV1X7zOpLw5UftCYjSwpOo94QjflQm7uxKWXQ/08XCr/GB3Nufi6tYVr
	dUymhpuZ8gTPaVv2V+NjEppegZZabDGhAKSSGDh8M/8lg4OoE2s3bQ/gz30P1bT/OyMehtv5Rm/
	IwvCcC5a5jaQ0tPUBvu5y/icf1JjsJAmVpUXcM0LlrLrtfV4c6CugxUIXTfHYTeZKhWABlIo=
X-Received: by 2002:a05:600c:444d:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-483c9c243fbmr221396665e9.35.1772452033100;
        Mon, 02 Mar 2026 03:47:13 -0800 (PST)
X-Received: by 2002:a05:600c:444d:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-483c9c243fbmr221395955e9.35.1772452032571;
        Mon, 02 Mar 2026 03:47:12 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf8b6sm147619295e9.20.2026.03.02.03.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:47:11 -0800 (PST)
Date: Mon, 2 Mar 2026 12:47:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	Jason Wang <jasowang@redhat.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	nh-open-source@amazon.com
Subject: Re: [PATCH] vsock: Enable H2G override
Message-ID: <aaVrsXMmULivV4Se@sgarzare-redhat>
References: <20260302104138.77555-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260302104138.77555-1-graf@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8WEHKFFJDdWDi8j_aAjxOAPwjGeTpq7DatFkzAW-ys8_1772452033
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Please target net-next tree for this new feature.

On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
>Vsock maintains a single CID number space which can be used to
>communicate to the host (G2H) or to a child-VM (H2G). The current logic
>trivially assumes that G2H is only relevant for CID <= 2 because these
>target the hypervisor.  However, in environments like Nitro Enclaves, an
>instance that hosts vhost_vsock powered VMs may still want to communicate
>to Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
>
>That means that for CID > 2, we really want an overlay. By default, all
>CIDs are owned by the hypervisor. But if vhost registers a CID, it takes
>precedence.  Implement that logic. Vhost already knows which CIDs it
>supports anyway.
>
>With this logic, I can run a Nitro Enclave as well as a nested VM with
>vhost-vsock support in parallel, with the parent instance able to
>communicate to both simultaneously.

I honestly don't understand why VMADDR_FLAG_TO_HOST (added specifically 
for Nitro IIRC) isn't enough for this scenario and we have to add this 
change.  Can you elaborate a bit more about the relationship between 
this change and VMADDR_FLAG_TO_HOST we added?

>
>Signed-off-by: Alexander Graf <graf@amazon.com>
>---
> drivers/vhost/vsock.c    | 11 +++++++++++
> include/net/af_vsock.h   |  3 +++
> net/vmw_vsock/af_vsock.c |  3 +++
> 3 files changed, 17 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 054f7a718f50..223da817e305 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -91,6 +91,16 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
> 	return NULL;
> }
>
>+static bool vhost_transport_has_cid(u32 cid)
>+{
>+	bool found;
>+
>+	rcu_read_lock();
>+	found = vhost_vsock_get(cid) != NULL;

We recently added namespaces support that changed vhost_vsock_get() 
params. This is also in net tree now and in Linus' tree, so not sure 
where this patch is based, but this needs to be rebased since it is not 
building:

../drivers/vhost/vsock.c: In function ‘vhost_transport_has_cid’:
../drivers/vhost/vsock.c:99:17: error: too few arguments to function ‘vhost_vsock_get’; expected 2, have 1
    99 |         found = vhost_vsock_get(cid) != NULL;
       |                 ^~~~~~~~~~~~~~~
../drivers/vhost/vsock.c:74:28: note: declared here
    74 | static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
       |

>+	rcu_read_unlock();
>+	return found;
>+}
>+
> static void
> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			    struct vhost_virtqueue *vq)
>@@ -424,6 +434,7 @@ static struct virtio_transport vhost_transport = {
> 		.module                   = THIS_MODULE,
>
> 		.get_local_cid            = vhost_transport_get_local_cid,
>+		.has_cid                  = vhost_transport_has_cid,
>
> 		.init                     = virtio_transport_do_socket_init,
> 		.destruct                 = virtio_transport_destruct,
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 533d8e75f7bb..4cdcb72f9765 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -179,6 +179,9 @@ struct vsock_transport {
> 	/* Addressing. */
> 	u32 (*get_local_cid)(void);
>
>+	/* Check if this transport serves a specific remote CID. */
>+	bool (*has_cid)(u32 cid);

What about "has_remote_cid" ?

>+
> 	/* Read a single skb */
> 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2f7d94d682cb..8b34b264b246 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -584,6 +584,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
> 			 (remote_flags & VMADDR_FLAG_TO_HOST))
> 			new_transport = transport_g2h;
>+		else if (transport_h2g->has_cid &&
>+			 !transport_h2g->has_cid(remote_cid))
>+			new_transport = transport_g2h;

We should update the comment on top of this fuction, and maybe also try 
to support the other H2G transport (i.e. VMCI).

@Bryan @Vishnu can the new has_cid()/has_remote_cid() be supported by 
VMCI too?



I have a question: until now, transport assignment was based simply on 
analyzing local socket information (vsk->remote_addr), but now we are 
also adding the status of other components (e.g., VMs that have started 
and registered the CID in vhost-vsock).

Could this produce strange behavior?
For example, two sockets with the same remote_addr communicate with the 
host or with the guest depending on whether or not the VM existed when 
they were created.

Thanks,
Stefano

> 		else
> 			new_transport = transport_h2g;
> 		break;
>-- 
>2.47.1
>
>
>
>
>Amazon Web Services Development Center Germany GmbH
>Tamara-Danz-Str. 13
>10243 Berlin
>Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
>Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
>Sitz: Berlin
>Ust-ID: DE 365 538 597
>
>

