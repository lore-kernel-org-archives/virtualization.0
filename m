Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446F4A843C
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561851; cv=none; b=DyUagw7qLoMR4f6mOsbkRAWIlht7H8udoh8tr1HHotSc3wPjCJscEP0hWoMOsrbIido2Qp+gyDSMKntoymRIFNXBxMphGgRakd7/T/OdZTMMxtih5ydFnhfjtn9XoBgnsC7IzdHkITbbfPXubwAnIjs029C7EqmgR7mo+JuZXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561851; c=relaxed/simple;
	bh=FrcWMoDVbMbpzp4CIH1n1Jf3KfV7MxTjfsHaS9A0FCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KlVzabqxaMIUOQOj7K9GOwFZI435hHfI3UPqTAlulGIoDkzdFmhou7rVrRtp7Zm7RxoZkvCkbFiq3Oh94eR+YbloSM8HaSQmYtcKZQtA0hOQyi4DmOAEDLDFp+kY3YDNUWvWSnIiqaFT/atOoLFAYz7BRqrYEUsUXS3qGVvTpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH8sI7q8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH8sI7q8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/lsJ0PSjJUTTQP4j3h3/faX0ng/XvkH6X4rWSQ3RUA=;
	b=GH8sI7q8u3uXlnWzND6MTU+GX3dpATMJ16Einyab2uHbiMpC1f/vlwGZAuuga5SylKCOXr
	Q0qReBxRQNggTcIk7SuonRHNMuaL+IQzNvQneX1L6VZOH0Eqg1ThtXmVmntxSk4F4FjSE/
	wxazINgjaWGHdo2v+mJ8XnPCgG2jrJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-YKYNtUbXNNyla42joM9cnw-1; Wed, 16 Sep 2026 08:30:45 -0400
X-MC-Unique: YKYNtUbXNNyla42joM9cnw-1
X-Mimecast-MFC-AGG-ID: YKYNtUbXNNyla42joM9cnw_1789561844
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e73659ac5so40925935e9.2
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561844; x=1790166644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/lsJ0PSjJUTTQP4j3h3/faX0ng/XvkH6X4rWSQ3RUA=;
        b=hWRBxbtKIcgLwOvtP0E+o69jGL4o70aF+PIAfShZpix87wnOSbEkJ8J2IeOcfARTCd
         K6telv00ZmN7qlTxfh7/eSzk5UIVpRKTjMqjj49mk+yUVuivc0K/vC3ZkPZSZFWpyXCa
         VaCooQ0UC1h0CVAsdTjlfUxpMnK3LkoPCYti6to72U0Lysj0821Fs9qYv3Seryh0kQ35
         TIUw/xa0JSW/wp836aREU++KqzJ9L/j/3jH33Nzdtc+9MvIgqtc5HLn5XqNPFF4DoJuX
         mV/F/8tyY4KTOMM7Zwd8nK//dwBwqKdXm1h8YyBBKfzYWE05+Q1iHB6yzlK0mTdVvlyk
         oPEg==
X-Forwarded-Encrypted: i=1; AKwUvBzzD/bQyL60UmT0VBeDSaBjUtOdHYCGYLAEFxMb3f+7qnvM6FlcWjRKuXheWyqey5ZvvO9D8OufYvP1IjfC1w==@lists.linux.dev
X-Gm-Message-State: AFuF++kq3inqqxSCFTc/H+z01FqXRakH1CAjSIvImd9dFQ350CzoxiKj
	okS1ck1cuQl+kbenY0H5acBPU2WUekRVAsz4jScdpLJm/wbcV1PfQ2gtp/YfjgUxjLDQ33VLilG
	7t6CjqaiAA1vDBKqlToXVavaA37Rvhr5DXrKcOtjF40B8mO/N8827lqmxmAjMcb11d3/b
X-Gm-Gg: AYBFou2lX82287WnwCCIp/HAxYRQ+3sDhW7vps9HLoDvLjZJWdtbGRAhZzncVtscHQB
	OC6Gq4P21E3ue2pWNT/S35sJMksgMHRlDCl2GnEPi3H0JJrRkvVd16uxTObay9+UCTSIlWHQDyM
	dX/Evc7LBGq/nCNJ03rahKsGojO5e0k6gU1CQCUvVdQTr+b32Uw5vpbaq5Kg/7U2fSyeJ6CpJsh
	AYgQb0U+wQcIdCeX0pnWqza3BQc0q2T5ihpQ8wPk1UMIynAzfdAD5hL2cHNjqQJOEquoO45HvSb
	DFRur1jkX54yNKGAiq5RlY6X6tTFbFTHwWBM8YqN8O+k9mZAWXPKj9H0eOnr+RzhO754neo3Xtk
	pNmdvyaTCyYXXufil9A/lZ4qtqHxJdWTXFSuzgKsT1YfTRg==
X-Received: by 2002:a05:600c:19c6:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49eac463955mr25967175e9.5.1789561843696;
        Wed, 16 Sep 2026 05:30:43 -0700 (PDT)
X-Received: by 2002:a05:600c:19c6:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49eac463955mr25966565e9.5.1789561843075;
        Wed, 16 Sep 2026 05:30:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83addf36sm76621175e9.5.2026.09.16.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:30:42 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:30:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
Message-ID: <aqp7CV9DnfsG1GJc@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6VNQhtZPgrQucfdTqYGfbHMlcsgxnr9Ovh_xyLZLnRg_1789561844
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 15, 2026 at 03:15:14PM +0200, Michal Luczaj wrote:
>A non-blocking connect() running in parallel with a blocking connect(),
>combined with a racy listen() that hits right after a connect timeout:
>TCP_SYN_SENT -> TCP_CLOSE -> TCP_LISTEN, while the connect() loop is still
>in progress.
>
>Enforce the invariant. Prevent a socket from becoming a listener after
>acquiring a transport.

We should improve this comment; it's not entirely clear to me, TBH.

>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f840498b58af..499e902becfa 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1973,13 +1973,13 @@ static int vsock_listen(struct socket *sock, int backlog)
> 		goto out;
> 	}
>
>-	if (sock->state != SS_UNCONNECTED) {
>+	vsk = vsock_sk(sk);
>+
>+	if (sock->state != SS_UNCONNECTED || vsk->transport) {

Are we changing the behavior when an error occurs?

If we call `connect()` on a socket (with no others running in parallel), 
it fails, and then when we call `listen()`, it now fails, whereas before 
it didn't. Can this happen? Is that what we want?

If so, we should mention it at least in the commit description; if not, 
perhaps we should unassign the transport in the `connect` call.

Thanks,
Stefano

> 		err = -EINVAL;
> 		goto out;
> 	}
>
>-	vsk = vsock_sk(sk);
>-
> 	if (!vsock_addr_bound(&vsk->local_addr)) {
> 		err = -EINVAL;
> 		goto out;
>
>-- 
>2.55.0
>

