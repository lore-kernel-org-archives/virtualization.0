Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38194EA397
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561828; cv=none; b=DfCbYWYRFy5mjFkSyzNfc8nrPIQuzJDCmAZP4dRgAbm5TAsMnv+qlVa41ix42jwtSMapCUmZnsMm9TkOF+cMHbbBRoZtPFYwdkreklJDIK+e1bRnIcVXtGAbs2/84pTwOh4lsRPuMRUo019OZMUl1wzY/sZVM+mahK509EgrvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561828; c=relaxed/simple;
	bh=Fmhcgo0917MgP6Yewu3ZjCmJzTY2NacAiSJbTsPkO7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l7ogJuNG4dAzGFoZo8Q7qG67dcBz8Ejfg42wF+LnXQbNtZIMINlHbGXk61YJFh1c7sdFW8afy/8eFN3tMUx5Vm5Wel3KZynicGWTgruugLLo6AhOkMcFX6/UvEQk/UWNt+AlkitakILcsq6d1xFSGemwVDWInbQo16Wt+K/N7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahltFIST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahltFIST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqm8tyx2h9IoJaqWWUmjhp0Aa68nUfNy8FsMl7kX/nI=;
	b=ahltFISTih303hehGdIZ5fYOm2+52DPbA/5IIqsvvTqfGT5RKz8TRZeyTGVuhG+tCdql4x
	/5H5Cq1PC6c9ZfwKcDw7VVkIaK5EhvwkStyRJJQDX5+8jHMb1hXBUMOiUSTVZrJxpx7Nt4
	LFWSKQR63K+WLKvmOV4jEU5qCuz5iwg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-SMDaUUiLOte4H_6q5ELflg-1; Wed, 16 Sep 2026 08:30:23 -0400
X-MC-Unique: SMDaUUiLOte4H_6q5ELflg-1
X-Mimecast-MFC-AGG-ID: SMDaUUiLOte4H_6q5ELflg_1789561823
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870a0fe60fso795837f8f.2
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561822; x=1790166622;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rqm8tyx2h9IoJaqWWUmjhp0Aa68nUfNy8FsMl7kX/nI=;
        b=lvISNhpB3koYLQfg2BSlvjqLB60DcUFpYVhwz52N0b3z+KctaE5Iv+brqCgBg31kWM
         c0kdRg+Pn6r7PjIiUXg/VFv9IQkdlFP6BFCux+SBxEeh64jbn2a5v1KhkioktbxUiOzL
         6/YVxnqwnj5Yh8ZjntqD02eMqSBmOI5kfRKTxS5LZx2rAT6T7w8kVqYVg36agm3HpMOm
         OmxPf/UV1TrmShETmreYCOY2kK7j+TB8XFyJzePbqCQtBG/v94hwVTt0yzuuLte/+EtC
         wmBWLq5l9LUr15ACwEqWelp8ipsrEITPJRbNMAl7LFEtW5iEPKPLnfOlp/yKLGzIJ/QD
         WIkQ==
X-Forwarded-Encrypted: i=1; AKwUvByOZeKxF0Q0ON7mdUB76Q4ayIXaJr+cnZk9CCF/y5RzlLG9RSmbPjBA111YsFY6jXf5D+BbW6j+esXRRJ+2Hg==@lists.linux.dev
X-Gm-Message-State: AFuF++k1zF+x0TzhUZz6VRQpw9UGzdDN0N/2uhogPi4a37xOYyA8Jhhg
	nRCZ3c7Pnd2Ru9XZJh+vOIUi2imIHbvd0kxUHALjS4HQCurOY72/i5IUl/RgnEIzMN7mT9LJU1j
	DxyETxOTF9vQjq0UBCJrzosRt716+Qte+NGFkhPupZPOUSHLfJ1lypHe4q0ctiVyYu5G1
X-Gm-Gg: AYBFou1Fmd0FHRt2WHVGNTJNR42jShRnPAIZ2cm+MHCZ7LaJxtVkkl3cvGK8uBpvtvo
	z6CfDflRVpYWwUJhmM6mQLpA6ZsszRjMKAsWGqJzzEEQ0TJ3MR1yK+531tvxM3+I6xX95D+EddQ
	aOasV8iFRbPCX5kGHeLfA/yJ5seXX6bl4fuNYhaPyZbtyaoo7EcnAPb+Ii6vhPzYMN7Yx9t32nG
	0AuYe096spv3TSVcmdaMuHW30Ci6741KKE0ND2a9oD5klohtF3AukGWbjWH8u8IbQJaF9G4fFuo
	ebGsl5jBIYnyVVvOnD2UE7dpfYAZy6GfxtqfsBtLUUvUbl4PQci4Q4t63CReFncXG2qA4kWAJSn
	snzf/TXHSJ1WbHiHXebaTwTr8PUE9QfeocObwS1nBVoNrTg==
X-Received: by 2002:a05:6000:2003:b0:487:41c:175e with SMTP id ffacd0b85a97d-4870d03fdabmr2882239f8f.22.1789561822258;
        Wed, 16 Sep 2026 05:30:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2003:b0:487:41c:175e with SMTP id ffacd0b85a97d-4870d03fdabmr2882180f8f.22.1789561821702;
        Wed, 16 Sep 2026 05:30:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf413dcsm6941143f8f.31.2026.09.16.05.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:30:21 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:30:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/5] vsock/virtio: Streamline socket reset on
 transport/PM event
Message-ID: <aqp3Po7OcubJboM_@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WJdKBV0HZXkVdLdUCZQ1ulSTk-9frAT4aizrlz4I14E_1789561823
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 15, 2026 at 03:15:13PM +0200, Michal Luczaj wrote:
>Follow vhost's vhost_vsock_reset_orphans() and VMCI's
>vmci_transport_handle_detach(): set SHUTDOWN_MASK, which will come handy
>later in the series.

IMO it would be better to include the reason here as well. Every commit 
should explain why doing a change.

>
>Note that commit c38f57da428b ("vhost/vsock: fix reset orphans race with
>close timeout") fixed a race between pending close timer, i.e.
>virtio_transport_close_timeout(), and a transport/PM reset. But here we
>never set SOCK_DONE, hence no race.
>
>Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 4f9aa9c4c3aa..4d6991321699 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -413,11 +413,14 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
>
> static void virtio_vsock_reset_sock(struct sock *sk)
> {
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+
> 	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
> 	 * under vsock_table_lock so the sock cannot disappear while we're
> 	 * executing.
> 	 */
>
>+	vsk->peer_shutdown = SHUTDOWN_MASK;

In all other places we use WRITE_ONCE/READ_ONCE on vsk->peer_shutdown, 
should we do the same here?

Thanks,
Stefano

> 	sk->sk_state = TCP_CLOSE;
> 	sk->sk_err = ECONNRESET;
> 	sk_error_report(sk);
>
>-- 2.55.0
>

