Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BE542EE8
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081391; cv=none; b=mO+vPCogMwjzJaaluWE2R8JTS7DFAXMFFbe6/H/w8dpvRZ0YmDa9WYvywgFZ2brqEO7RAPSLXa1dKWIvjLbK6pCkOR9PjZ8sIa1pk/vDIGpxUKrOj4jgKjFALB3km5hTgN8/TP3ECein74X8kIvt1AUHzss3tgrz/n7beAdQ1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081391; c=relaxed/simple;
	bh=H77B/1XoUbsQHeqCDGjv35YwEIvkYUiwrSWHUSL0kKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DnTg7jpBqGVIeYLmkVU/f5F/sg4SZQmxX0HwGi3bZVwkX/UDm4q2PI4SZNGtG00YKOwYGqTShnJTrfD3p4g8z6HpTMWULIh6hb41Y6FPCA9Hd355CxCropnsvOCg39UvS21tKE7XhWmCCJ108odqrwsWhCThU4PdjlqkYiy+DQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcxqrO7G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcxqrO7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790081389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMtW18PYGgs3eeFoZyurBYg14pG+Ej8vE9R6o+NDZ70=;
	b=WcxqrO7GlSnu9cGv7lANg2I3/8zqjVz9vy9YjKmpm2P3v6FM87VkLIt5q5zUuUEiwcoYbk
	hgok/Mudple2xDuhqT2MXrzTlfmeE8yj3wAHSVuFl7pXQENeouB1U1y2j5h9l3fDNR6XF1
	Xx91pAKRA3Tj73SYvoUkcz9jlPkV4nA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-M9gtmOyLMGKJ-QQ99vzOaA-1; Tue, 22 Sep 2026 08:49:47 -0400
X-MC-Unique: M9gtmOyLMGKJ-QQ99vzOaA-1
X-Mimecast-MFC-AGG-ID: M9gtmOyLMGKJ-QQ99vzOaA_1790081386
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-485866e0066so1317451f8f.2
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081386; x=1790686186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BMtW18PYGgs3eeFoZyurBYg14pG+Ej8vE9R6o+NDZ70=;
        b=EDMHUCHK3YRNyhog0W/fPJipvHauNv7Ig8xSxQTAG7nGJFlMzvDiDIrTeaNRKtfiUw
         0TjDsl3TY2+xl/xMtsA0OAM91uLWs7MnSoNLspPK9jPiyQYfLZqa5xJ/BldXiwezEGPj
         faWLLWn38sRmN/JT8qI743Cb3LukbjdpNYeh/bcAhlCgLITpu4UIFWEcdTlXx8hk4eLS
         +aeSV33owO5uVdF0Cj4Q0O5R8bZCEckBi/uqLqZ3xP84y+Ar3tPt3ixHQON7BfsCvy1w
         2YaV3QVSy3qF0E7xmCmJTi/8JY9hkELnvk7Ch2xl0ZV88Bh0P5QSTgFIZoYxFUaeiQrU
         jTLg==
X-Forwarded-Encrypted: i=1; AKwUvBzo11Iyx6PIsXEHvR8EXS2f/nh4/DS2DntF0XWR8TGVZ1mbksSuRicAlK7ddnmMUnpBgHWj5EkCPgOa5msvbg==@lists.linux.dev
X-Gm-Message-State: AFuF++mA5zRbhK4R69OTYSWleG7werzPfHhSlOIF9mMAH3GNiF23Y2oW
	HcUiUcXMT5icqkMF6NQuYCVz3FLx0i3LIIdo88Hlx8ujOUif1ql2PDbQlsxBDDV3XrG9uF2ncQH
	GW8NiT39ium79G4kdXZolgtx5wqlp5JjCIqSONq9wW24Bps0cv/aW+nnjR/RzWjfZONhH
X-Gm-Gg: AYBFou01eu6tukqBFCj8DqXh62vh4QEdFNQ1coxV9oLUQwAlGSAQaM4/AKe5LsLcjZU
	9kwgyUuJPapLG9WdwRypPnamR7yPZv1aleqdUBks8GOCxwYGhhyFK2jc17HWeze9OslEstreuoB
	CnV30DvP0s81c0FoOCylQX/RQiVHtsJb2DbmJIe6zxRx5Qz0mydaDEiZrUezjRdhVM7fklee+N8
	R344bJOL8LVDygWXMutBickqSmKnLSSvii7NFlstvRdyFCjV0cT1Qzwkt8SWHHCh0hBCsXX9ikp
	mymrtpWDbM0HVCiqAGdCMzaqNb0NVaXTYR/Qzs7VQSTKfzcB9RDWqaxGkcWjVE6VnpZ0QCYVJgn
	dQJl56vECkXOMpRwPsGm3I5Wa4FSuRkfGCLmL9Aa4VoInWwaw43I=
X-Received: by 2002:adf:e19a:0:b0:486:fba3:b95d with SMTP id ffacd0b85a97d-4871e2161fbmr20532326f8f.7.1790081385750;
        Tue, 22 Sep 2026 05:49:45 -0700 (PDT)
X-Received: by 2002:adf:e19a:0:b0:486:fba3:b95d with SMTP id ffacd0b85a97d-4871e2161fbmr20532296f8f.7.1790081385348;
        Tue, 22 Sep 2026 05:49:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862774882sm5070366f8f.13.2026.09.22.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:49:44 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:49:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vsock/vmci: enforce per-netns mode on the
 datagram receive path
Message-ID: <arJ5LVnY1y0MELJF@sgarzare-redhat>
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
 <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vH755REVmtrNfZ9JmiPN8NKoNQud-QgurIsIIsa8C_M_1790081386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Sep 19, 2026 at 02:31:57PM +0200, Bartłomiej Dmitruk wrote:
>The send hook vmci_transport_dgram_allow() refuses datagrams when the socket's
>netns is not in global mode (vsock_net_mode_global()), but the receive path
>(vmci_transport_recv_dgram_cb() -> vmci_transport_allow_dgram()) did not, so a
>socket bound in a non-global (local) netns received datagrams from peers it
>could never send to, defeating namespace isolation.
>
>Add the check at the start of the receive decision, before the
>VMADDR_CID_HYPERVISOR short-circuit, so the hypervisor CID is covered too
>(matching the send side).
>
>This was found by code inspection; I do not have VMCI hardware to test on
>(compile-tested only).
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
>Assisted-by: Claude (Anthropic)
>---
>v2: perform the netns check first (before the hypervisor early return) so
>    hypervisor datagrams are also gated in local mode -- the Sashiko AI review
>    noted v1 left that path partially bypassed.
>v1: https://lore.kernel.org/netdev/20260917220225.56200-1-bartlomiej.dmitruk@isec.pl/
>

LGTM, but please add a cover letter to a series with multiple patches.

Stefano

>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -532,6 +532,14 @@
> static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 peer_cid)
> {
> 	u64 access;
>+
>+	/* Enforce the per-netns mode first, symmetrically with the send hook
>+	 * vmci_transport_dgram_allow(): a socket in a non-global (local) netns
>+	 * must not receive datagrams it could never send (this also covers the
>+	 * hypervisor CID).
>+	 */
>+	if (!vsock_net_mode_global(vsock))
>+		return false;
>
> 	if (VMADDR_CID_HYPERVISOR == peer_cid)
> 		return true;
>

