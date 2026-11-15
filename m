Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730962;
	b=4A3gaJIHabF+Iu+4TO0R9AySP+zKPs0MjQR5nnjbVOfOR0bIa8qMN2LZtL1K+jmL5ZxI
	 OKQ5W5usPqv+VYAhMiBkc1+ERdeRm08YeSsh2dhNX2AALZIY+5Wh14oml05TKubJb4vMz
	 /232eynvtS5oP/A478bK374eHVLx9kOxhi10B26P/6bZ3+M/HmgN3rxkgxpFuNLcZJogv
	 oJ392rhfOlMARdrWQ+2w7KzygDitULHZra1JzwXturNYHsdF+bIhqKefBI3wupvbVbDGJ
	 E112t4dIB7S8M7jSCMdIf9XOGUivkv9N2ao/MQ+rnza15ABvaJIARMSvr9yEIwNu1Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730962;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=hOqx9PI7nO87s05epf/KxKW2rSgtDSMLjv2nLVv2RsY=;
	b=cCinHeg+Z8P2fQ/N4XBFhZf9be1FSmwelPi5eOK4cf9fzwewqnPKgnHEXlxjuJ3bGAUk
	 R2T0O0n/6sSSoY+2m5smWXyQEnG3gdeBo4+CjelgHm4mXzd2bB0j3Z2bWTVHStkpJxOah
	 PI+5Mo8H2yArhrEmh5+oArOHtBhiQqJrLCkJugsssPC8rurcDiw/C89TnTSpR4r2SrT39
	 dtMx5+FrhXGd151rH90vt+t84/Ei2qsdP6p9CMpJ5L1wuCZXvi1IQlMa2XVTn4P6IJQhX
	 Jaxxo5wxmbbaPXE4lb2iekpP2TRZAFwfA928NwBWwg+bKBXoKJyKAJgV3Jqkgrg8t8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzae79s4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C6606A323
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 08:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA7C6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzae79s4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794730960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOqx9PI7nO87s05epf/KxKW2rSgtDSMLjv2nLVv2RsY=;
	b=fzae79s4r33XIm4X0Qplugnvzcx6gmPVHrx9mtrZBkRTm4nlRPUcw1+SPvXJg7RI2vN7db
	cMANMWjWd4+a8HcnjUfAdloBcKJBlC61C8d9w+Yj3H6YmqZPNcP33FoP1P7YrLhbM37cjL
	fv+ZjYa3kgtVouWIOS3xtRXdYH3jv8s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-cFVGPZ8uNKekJgS3DciXew-1; Sun, 15 Nov 2026 03:22:39 -0500
X-MC-Unique: cFVGPZ8uNKekJgS3DciXew-1
X-Mimecast-MFC-AGG-ID: cFVGPZ8uNKekJgS3DciXew_1794730958
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4916d47eeb5so2204556f8f.1
        for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 00:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794730958; x=1795335758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOqx9PI7nO87s05epf/KxKW2rSgtDSMLjv2nLVv2RsY=;
        b=TaivsztvMuBAb0xkBq82eiGrNpTDECMMmATQFwj91veq0uYF+WCfCpOYER14jkPatU
         NPXlF6rNf0G4B+U//HzsADB9nyKy3E5qMyWL9T1DRpArf2dfhikCMrAHs6KBBNGNt2Af
         6j1DMHw5g1Fw7TA7gzmN/aVKFYL62Yrg9Tm/O/phSro4kkvEp2sFBuVhE6U89/trGRyQ
         XHsWOKtV95aMqkFg6KTjUskuJMgLqWBioUESwHSmerm63/zWJgMqLkTpbW8WSOq3KJHS
         QC4pbfRezorNhT/FdESYk22yx/SjsobJskeW8g4WL8/B1XamrI3mfvRnk+y5SUmPgKIu
         mRpg==
X-Forwarded-Encrypted: i=1; AL+hErECKq5/M1vVLGW5w4SFfMQNcT6xk9WOF9R7uUJvqWIkUEVO6sYNnP0aRs6FrESlx9Cwkbi2jMqEs3G6sLZe/g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9RyRA0NFIazxxewnKYW7RP0Zp/BouPPc4UjJ/1eZOMdssLACeh
	wHpUZ7CCq5UfGNWmxz1RJSGJPdxwYIc+6jAI26819f852dOKbtWDtKMX7tcpE8TW9hUWBnLUUrT
	5uSBXMHQEY9LmKL9WpTfunjrXnmT8kzTVghDOOhoK7ToH23YK6+bYwkxLYqUVnaBwIJI/
X-Gm-Gg: AYBFou1bt8sXnZMcE+xrBjhcFKOvEiC5Rnd5R58eKBAxs845Pvue/otn9viWUJQG7r2
	gzxtWFnRr8ZoHn+PKcsqo72xZxrAeZxeYa//7Wl/rPDwU4TDy5oyEWnrgEHpmmN+wF5NPfIh4Xw
	27NotPdzIlMcYQ1chlfDZFdkRizMgXXazmQ4YFyH6sM5zZe/vpTSLHbql96XitJne55o26fomcS
	6qlNQ7HxwVVNngLl7v/EqKxC0MZPfCCXHHgZuHjl0lkBPrPGBjv83thr3hC9FJBW19P/esodXCj
	3QaXKa4EhSD4Bazdwp2y6fX2qpPHQFt8o1+gMCq7Qn8iED5iIhy6PySpKKTp3XMHxRKTtAtMOIu
	BYZCkTvU88BYcrA0VtNpDr1bb/YHVSFRk/bZDonPfLgNQT+695hyp+A==
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr155906645e9.34.1794730958285;
        Sun, 15 Nov 2026 00:22:38 -0800 (PST)
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr155906215e9.34.1794730957813;
        Sun, 15 Nov 2026 00:22:37 -0800 (PST)
Received: from sgarzare-redhat ([193.207.75.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm297980195e9.15.2026.11.15.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:22:36 -0800 (PST)
Date: Sun, 15 Nov 2026 09:22:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: reject datagram binds in local network
 namespaces
Message-ID: <avlpwYZr4pSpunEl@sgarzare-redhat>
References: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TDkEBH8Wfe4Od8Nv1lCfGiOkM62UmqClm4KlGywMUGA_1794730958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Nov 13, 2026 at 06:04:40PM +0100, Sergio Lopez wrote:
>VMCI already rejects datagram sends from local network namespaces, but a
>datagram bind still creates a receive handle in VMCI's global port space.
>A VMCI sender outside the namespace can therefore deliver to the local
>socket. Its handle also prevents a global-namespace socket from binding
>the same port.
>
>Reject VMCI datagram binds in local namespaces. No namespace-local
>datagram transport exists, so EOPNOTSUPP reflects the available receive
>paths. The receive callback also rejects any local-mode socket as a
>defensive check.
>
>In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
>delivery and the global port collision before the fix. After the fix,
>local bind returns EOPNOTSUPP, the global bind succeeds, and a global
>VMCI datagram still reaches the global socket.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
>Signed-off-by: Sergio Lopez <slp@redhat.com>
>---
> net/vmw_vsock/vmci_transport.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/net/vmw_vsock/vmci_transport.c 
>b/net/vmw_vsock/vmci_transport.c
>index 1f186e8f8364..282131544c42 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -627,6 +627,8 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
> 	 * outside of the create and destruct socket functions.
> 	 */
> 	vsk = vsock_sk(sk);
>+	if (!vsock_net_mode_global(vsk))
>+		return VMCI_ERROR_NO_ACCESS;
> 	if (!vmci_transport_allow_dgram(vsk, dg->src.context))

Why duplicating the VMCI_ERROR_NO_ACCESS return? Can we just put them in 
OR ?

The rest LGTM, if you respin, maybe we should mention that also 
connect() and sendmsg() are affected since they call vsock_auto_bind().

@Bryan, @Vishnu PTAL.

Thanks,
Stefano

> 		return VMCI_ERROR_NO_ACCESS;
>
>@@ -1697,6 +1699,10 @@ static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
> 	u32 flags;
> 	int err;
>
>+	/* VMCI handles are global and cannot serve local namespaces. */
>+	if (!vsock_net_mode_global(vsk))
>+		return -EOPNOTSUPP;
>+
> 	/* VMCI will select a resource ID for us if we provide
> 	 * VMCI_INVALID_ID.
> 	 */
>
>---
>base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
>change-id: 20261113-vsock-vmci-netns-isolation-7e46732dcd73
>
>Best regards,
>-- 
>Sergio Lopez <slp@redhat.com>
>

