Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB21B0422
	for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529262; cv=none; b=tA5V9Hhz+NBbPgsZfZs8LJ7ISwKlPwVXumDGkbLJ0pkSkrYoiwB17/zyJEOeLxPNF8fXsRuKhdYgtnma55tUluRfJFQaWxTCizfp1/OTJhqErrvR0undZ+8B7mlwmSNIeOxJdmr3FWgniVyxwSmXdP7Tbir6VjaMep97jpq+pi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529262; c=relaxed/simple;
	bh=K0zNBfbcETnxYcirA39F9HXcQ5BTEnz7zkOIyJnNNe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l0IZdk7WVFa1pPkBzYBjqYrIrvg+kleXPoArIgrCWzJsXi3hYrpHoOGjeGk0LNT2ZepALy4HYnF6UcPpUr8DkB7xN7mUObCmn1YrX3ngn52XGsRSlI9Abqny+1dboPy79mUyZSHtyoB6VpjkgYP3AFqadbWnKu3GNKOPws4dJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGMPcy74; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGMPcy74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734529259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UKlCgrehlnF+33doHpsOgEv2HS2Nvzn1ShjGdsaFJ4=;
	b=aGMPcy74i0LxSTc5o9+or4hO7g063+eIUfdQxThqP+DNt1Zl3kgoEZc6fymAdh9iC3VBMu
	4vIfGov6aMRybpsQ4cTWIVcPa/lPMgcQQPnUqlftzQq7xBb4TrnZlQORBmIzYIZLgJUmmh
	4tuMAJt4+Ndbk9byGH+RmU0n1oqAwBY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-yEqLkUFHPoCNmdJHkQGlAg-1; Wed, 18 Dec 2024 08:40:56 -0500
X-MC-Unique: yEqLkUFHPoCNmdJHkQGlAg-1
X-Mimecast-MFC-AGG-ID: yEqLkUFHPoCNmdJHkQGlAg
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8eb5ea994so74672346d6.1
        for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 05:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734529256; x=1735134056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UKlCgrehlnF+33doHpsOgEv2HS2Nvzn1ShjGdsaFJ4=;
        b=owBVuRvEcrdqf//Ewdr3SbcBWO+5jMWtb18zVuSUWvnepjazF6jqQVcchIXCVzYFko
         +Qgz+1rRcUsWrdwPJabCrINOsJvi0jeVcmK3a/Xi8dtv6qHDP5+lcO6CwvwqVr0E7NpK
         MvL68IT7PXvnLHGWdwhsClcHJK/wL3JgNGqKHVm1qPFyJEeGwjtpccF6qqrEgbbQj0Al
         pGs4lFbzb4ktiYzUx9eF0/rQrYwfdIEGPljIoOPtRBbVdSmHuNhslLTL5dpGCLt/8sJw
         V7p8u28GyXR2T92DejBSY3jBImMygFw1xAJYx5BJmpusccla5EWkmEZ7hcYTNo81w9Yb
         pGJA==
X-Forwarded-Encrypted: i=1; AJvYcCVWBgJXcv+Wkp1ktG75GUY2YPKYy5J/BevN9l+aIP/n0hiuWMJi6aYtFZMVA/gGS84yGjAamE9LUS1qvPVrZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwD+vhvqPSubCzzVvNjkhgc9If6CBVFebA9l3lroqBblpr4IKvS
	fOk/z6JC3SiWjEKWwB0YkL7SoR8ES7mAB/IDq/d/4R5at4tN3xL8Ue8kEoobg9TgtyajzvanucC
	isOobDyzgD92jkYvTouWKzs14CUfa5+7SEQ7RZHg7NeD5w8on7VZK12h5FPjKQwzV
X-Gm-Gg: ASbGnctaAOh3FCFE3C8WDZ7AdvEWVeO+gB5wpHhgVgnn/syCMlI1XfRfZoJFO7KSfJ4
	U+L6aHGcSDBYvUdUrrl/kASxyldG6YwGoPzHAjV95FTJ2/9ttQGiL9PJ6azkU/Y/iMMRy7DDRle
	8d087h2Nrik4H6qBzQpVXjzjJjVxYFzS7M/4Y5Q9pnglnzcp8GxacI62AVkWRm2abZWC+/BW0GA
	K1gNruhET03ZL2/kHh5XKX7Lzvy+ckHxk6itbZBesCiTsqhfXrKuN0ru7SrNHP49wtWZsHXgqwN
	fkQCfszAm4Xizo8SlamBhmkSPa34PAlN
X-Received: by 2002:a05:6214:cc5:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6dd091a11bemr55843406d6.2.1734529255999;
        Wed, 18 Dec 2024 05:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO9mHXcACDlZbDnxDKCyk44Fx1XL6dG1GpRlYM9XB/qySvxxv969FyCcdix0+v6qIEDr/4pA==
X-Received: by 2002:a05:6214:cc5:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6dd091a11bemr55842876d6.2.1734529255583;
        Wed, 18 Dec 2024 05:40:55 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd2795e9sm50346356d6.66.2024.12.18.05.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:40:55 -0800 (PST)
Date: Wed, 18 Dec 2024 14:40:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io, imv4bel@gmail.com
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cETJ7cHXlwwzS_7rwOTbfnMXht8pu072K_VNskDzINA_1734529256
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 18, 2024 at 07:25:07AM -0500, Hyunwoo Kim wrote:
>When calling connect to change the CID of a vsock, the loopback
>worker for the VIRTIO_VSOCK_OP_RST command is invoked.
>During this process, vsock_stream_has_data() calls
>vsk->transport->stream_has_data().
>However, a null-ptr-deref occurs because vsk->transport was set
>to NULL in vsock_deassign_transport().
>
>                     cpu0                                                      cpu1
>
>                                                               socket(A)
>
>                                                               bind(A, VMADDR_CID_LOCAL)
>                                                                 vsock_bind()
>
>                                                               listen(A)
>                                                                 vsock_listen()
>  socket(B)
>
>  connect(B, VMADDR_CID_LOCAL)
>
>  connect(B, VMADDR_CID_HYPERVISOR)
>    vsock_connect(B)
>      lock_sock(sk);
>      vsock_assign_transport()
>        virtio_transport_release()
>          virtio_transport_close()
>            virtio_transport_shutdown()
>              virtio_transport_send_pkt_info()
>                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>                  queue_work(vsock_loopback_work)
>        vsock_deassign_transport()
>          vsk->transport = NULL;
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>                                                                   virtio_transport_recv_connected()
>                                                                     virtio_transport_reset()
>                                                                       virtio_transport_send_pkt_info()
>                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
>                                                                           queue_work(vsock_loopback_work)
>
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
>								   virtio_transport_recv_disconnecting()
>								     virtio_transport_do_close()
>								       vsock_stream_has_data()
>								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref
>
>To resolve this issue, add a check for vsk->transport, similar to
>functions like vsock_send_shutdown().
>
>Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
>Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>Signed-off-by: Wongi Lee <qwerty@theori.io>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5cf8109f672a..a0c008626798 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
>
> s64 vsock_stream_has_data(struct vsock_sock *vsk)
> {
>+	if (!vsk->transport)
>+		return 0;
>+

I understand that this alleviates the problem, but IMO it is not the 
right solution. We should understand why we're still processing the 
packet in the context of this socket if it's no longer assigned to the 
right transport.

Maybe we can try to improve virtio_transport_recv_pkt() and check if the 
vsk->transport is what we expect, I mean something like this (untested):

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..18b91149a62e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,

         lock_sock(sk);

-       /* Check if sk has been closed before lock_sock */
-       if (sock_flag(sk, SOCK_DONE)) {
+       /* Check if sk has been closed or assigned to another transport before
+        * lock_sock
+        */
+       if (sock_flag(sk, SOCK_DONE) || vsk->transport != t) {
                 (void)virtio_transport_reset_no_sock(t, skb);
                 release_sock(sk);
                 sock_put(sk);

BTW I'm not sure it is the best solution, we have to check that we do 
not introduce strange cases, but IMHO we have to solve the problem 
earlier in virtio_transport_recv_pkt().

Thanks,
Stefano

> 	return vsk->transport->stream_has_data(vsk);
> }
> EXPORT_SYMBOL_GPL(vsock_stream_has_data);
>-- 
>2.34.1
>

