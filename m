Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17409372B58
	for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926914; cv=none; b=Pf4ktWzz5FVt5Q5cTDCBpQeh21SoyL/jhMpg/g9RiMbipcb7KpV+6Q/vw6/w3ViUSG19mlqbJ1QYzTxcjTFmwZYLwpbifbVBCMR5/7wN5N8WLWe2J+cUrTi4eQXLf4UGeOqKxSPEtnmjJCbYuo4Ih1n8SnCoGsWJExN8oIw90mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926914; c=relaxed/simple;
	bh=ELCHW2MDcGHyAOjCI5TzQdz1gK18QvxlUMKh2Jmx5xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HWCk6neAcjzx8nHCgA7zJpRzIH8C6hbnG4YjETvEBHYOZpi7s64mK0Pg3gvvTw+7q8SUf5t0AdreCZryw8gWzaCH7wdvFXNJgHLuSs1Mqvpg9WZC+0z27LEwBJisw36LxWYT6TI7J3Am0CDFGQqMELM4lObz/pIgh+pumq5lKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyAkQQOP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyAkQQOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771926912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drtPn3RRebLcYs+RKWbzRzgsO6cnVFeivrQ9r6WAvBs=;
	b=AyAkQQOPNyyoiijCIBWIjsOTvrVtWffr/mFXzw+sAvW6dUsab+zS9xLFcaEeoG5QTJhxZ3
	kDhB2FfW66oYW1xK4QDHBqaXA6WolO9PWhEmiUl5sBITqafafiinq2qkwd8Cl0qz2TsNKh
	HCWaQnyVqcoLDKLW3LFjm0xAw7tOyK0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-6Bz221baOP-RoVsaxzjlpg-1; Tue, 24 Feb 2026 04:55:04 -0500
X-MC-Unique: 6Bz221baOP-RoVsaxzjlpg-1
X-Mimecast-MFC-AGG-ID: 6Bz221baOP-RoVsaxzjlpg_1771926904
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4398ad5d81dso134286f8f.0
        for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 01:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771926903; x=1772531703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drtPn3RRebLcYs+RKWbzRzgsO6cnVFeivrQ9r6WAvBs=;
        b=bj95CFKyTXLTTMLEzgCV1mcBrFwQheRbBTwqAqWw/0X2Ohu7eNoBa2OapzQh54RTXF
         xpgWuhrtFbGY08v/52NdCRPGBcegNxj8c0oU+oijYFj/btX6UuahBhhro1IP5ibiDHEu
         tSdHEklajYnADI0M5wC22mmKb0/ueAx1HbzaG58Y513mxGxUv8CLpYh7g6h53lzWpUTz
         Yz4TEbXtifLAC4nAXH4+vvhHFq0GhzP4PGzO5exIqElBUVjBSjmdGbyQfjs7wEZr6E8O
         iUXTV3SlzbtRGy2mj1BYhMumwYNgHjjAUBRrMzFZtxCAFpXYwa9ErmIO9GydzP0ecszp
         wewA==
X-Gm-Message-State: AOJu0YwBR/a0N5FcOLPaLN7g+YwvRmmRD0GSS3p1xV1iBXkBV92ppQRc
	9HajrCYodaFU7GPUL4GEmGBiqYCdaRKExB8vuTiwsXOfsciV93XVYYWS+sQecM0ZNZ4AqniFL1U
	t4T64M1d0d1wzMwNVDtVAuG2MXd+ZLRLfypxTzZqGQJ/Y/2g0bul1LYpKcxQ/9i32nIo8xB2PCY
	Xa
X-Gm-Gg: ATEYQzxyuokeb7MwCDk7QUNomf2EOB4Yr4HEwGnG6ChFr/I9Ep9wNeaIoWsKe+yV/rI
	oHhwam8ZVjQmjNV6LrkNGo+53IuBrOW0AftXpIvR+KiYRmP5wjoyajAAbg0y6DGH5C/afaZHpDn
	HBlRQZJXo7GrUzv+BE95SDsxAZyG4qg5Rql70TuSfs5R4VIjZ6GXj5kfOb6eGtGt2z8Lsyazp5y
	wQTYrMjuFCzU8Nu4QCHW66MdYCRocDKpJA8c0v6obRv9s2xINDBCJtZ2Vh1o7UTVdx83e911kDq
	6jhMOhjZffSJ8FR9l2hP8dR9VP3mqNBj4XuOu7ANexDkxoWFkRN8Jeijc8vxr1haitF2n3hhHVB
	98fmsKMbOTbZgBiGkjoaIBli+GaEFpx3NBc7sN+KSslIGYDuxGONcWa6/+nSN7q65V6fgaaQ=
X-Received: by 2002:a05:6000:2011:b0:437:6dac:458a with SMTP id ffacd0b85a97d-4396f18f82bmr19853120f8f.57.1771926903203;
        Tue, 24 Feb 2026 01:55:03 -0800 (PST)
X-Received: by 2002:a05:6000:2011:b0:437:6dac:458a with SMTP id ffacd0b85a97d-4396f18f82bmr19853090f8f.57.1771926902713;
        Tue, 24 Feb 2026 01:55:02 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c09897sm26032093f8f.17.2026.02.24.01.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:55:02 -0800 (PST)
Date: Tue, 24 Feb 2026 10:54:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock: Use container_of() to get net namespace in
 sysctl handlers
Message-ID: <aZ1oTufA5JkTBl35@sgarzare-redhat>
References: <2026022318-rearview-gallery-ae13@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026022318-rearview-gallery-ae13@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VXNvKKPaM2gqtCoAOr4eIdAu7t5qHfan38lkTc94JLQ_1771926904
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 23, 2026 at 06:32:18PM +0100, Greg Kroah-Hartman wrote:
>current->nsproxy is should not be accessed directly as syzbot has found
                   ^
nit: "is" can be removed

>that it could be NULL at times, causing crashes.  Fix up the af_vsock
>sysctl handlers to use container_of() to deal with the current net
>namespace instead of attempting to rely on current.
>
>This is the same type of change done in commit 7f5611cbc487 ("rds:
>sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")
>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: stable <stable@kernel.org>

I'm not sure this is stable material since these changes landed in the 
latest merge window (v7.0-rc1), but yeah, you know better than me, so 
there could be a reason.

If needed, maybe we can also add:

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")

>Assisted-by: gkh_clanker_2000
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
>
>Note, this is compile-tested only.  Some of my scripts found this when
>looking for places that are missing fixes that were applied to other
>parts of the kernel.  I think the af_vsock code uses namespaces, but as
>I don't know the network stack at all I figured I would let you all
>review it to tell me how wrong I got this change and all is fine with
>the original code.

Thanks! LGTM and tests are fine!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>thanks,
>
>greg k-h
>
> net/vmw_vsock/af_vsock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9880756d9eff..f4062c6a1944 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2825,7 +2825,7 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
> 	if (write)
> 		return -EPERM;
>
>-	net = current->nsproxy->net_ns;
>+	net = container_of(table->data, struct net, vsock.mode);
>
> 	return __vsock_net_mode_string(table, write, buffer, lenp, ppos,
> 				       vsock_net_mode(net), NULL);
>@@ -2838,7 +2838,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 	struct net *net;
> 	int ret;
>
>-	net = current->nsproxy->net_ns;
>+	net = container_of(table->data, struct net, vsock.child_ns_mode);
>
> 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
> 				      vsock_net_child_mode(net), &new_mode);
>-- 
>2.53.0
>

