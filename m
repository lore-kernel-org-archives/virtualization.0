Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362195;
	b=xZ4GE1qT6uwf4iZsCAn+KF5b6jdTsc6e9Ah1h2pfH/om8z1Z00k2UobVyzFpqmBOWMRI
	 ton/LxqO3tFQz6PYcu7lJnA1Zr4/UYsfEKkPc6N3jq+h7pfV0bP5HCMcTttDuAMWPPy1B
	 dMYG9nVsQ5OEhv5nxM0p/2WgyJpXF6Q3rBzACgsvm/h/mQkwclv/+THNIVjJO6ohnQOIP
	 iJta0f5FpvjaZEpH8lWdzOVgL9c8nBDsrgxwsoj1SMqQAzaVeKJS49ki+am46B+9jK5xW
	 FTC5UTMim+E5mCc50e+wAq/XtZVGjyUhYYwpn1xlIUG+4qxUUkyvXQpldPKIboQF07w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362195;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=hdnZT0z7davEfnf6scqYwmgfFD2zK/8ZHhv4LP8xp6I=;
	b=oCBlP/6xYrSzzScBhuUeAgp/JZKvAPIEbsF7LWoGAWFtVO2uYT6ezvWc6OmRqvAlrKkU
	 BzHQNVtv7fXVyQhV04uc0gSNlb/hF19ljtyX5orGPMsCOwrPxPjKdgJzwjL0SWCGhRB7n
	 5/S1vb9OBrpVzMWWF3lwRyfofSt4BlKiM+y7VJneCGv1t7Gmh86Nf0IepVoIX+QQQwJtk
	 ku4T/pRHIqJIYIqb5AyDyluhTrpqYMOyKh7nsOjkXDBa3t7agOsRqM03r0qrbB431gVka
	 Pvu9Nhi1zdHpr53aWT1Ef868Np53R/4E7yZyYoZuH+oJneZH/7pwH2SRn5o54Kj7ViQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DXUi28+h;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C12606A31D
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 12:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09C12606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DXUi28+h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793362194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hdnZT0z7davEfnf6scqYwmgfFD2zK/8ZHhv4LP8xp6I=;
	b=DXUi28+hbO6FmC5/d21Xahoxavw3ah0vJ0o5YbmpVXXx0WJrG55MiS6amcdez3pMMW4JM8
	1ql2sd+pT5eQ+oZ357P6GGTFzcQs+5Pxna/FqTXD0IQcDEy34n7+lnGbOvoc6wZd28hO8c
	LeJt0EOVKpDUNkg0IHEBjsbfEs9nIHM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-H4ve8s2SOKSojytRQa244A-1; Fri, 30 Oct 2026 08:09:52 -0400
X-MC-Unique: H4ve8s2SOKSojytRQa244A-1
X-Mimecast-MFC-AGG-ID: H4ve8s2SOKSojytRQa244A_1793362191
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so7650205e9.1
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362191; x=1793966991;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hdnZT0z7davEfnf6scqYwmgfFD2zK/8ZHhv4LP8xp6I=;
        b=Ri/ZVzhrVgt1uIaiLxE+7bwo6c4JdnPpF8Qf+lK0Inrem+jhOEgXMyyEiUe6K+A63Q
         hgGYRvfj51yn6HzesmL1lZMicJqpYyuTRf3fQ63I3ZgWldGQjH70k+mbdeALK1/65q+w
         CoXPgIK5D74JSzb7iYmBqSnJ9HXMF0EYLX0GZtnHiroUTAP2VkiLnVIV+HDhBBMRkR12
         y6kmA5Xc2eIdXt2SQ7L0u7hii0tiijGgvGQwxcdkIapSEkBWq7SNARAPz4PlUG9Sq8wH
         D09I84Sxa2E8XicQnTFoG2lKzpOrQaTk9kRZxmcKDOL8HChkf4yS5fkvf7/pOMGkT8fS
         cduA==
X-Forwarded-Encrypted: i=1; AKwUvByr3Tun6RkA8BJ9uG7ce7U2AR48eFvXvh8T+Ms7ltTlyBgDqRgrjVsjN2wMfnzChoHDUA0vosubVuuezEDSqg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLEYMEr/2ZwwOjiBQAitS+V+cEsjtVFHfgmFxp3WbHVF5OVaNRH
	XI9DiHZJET1vDIKqp1onWkqKlJBU8pIQZX3kZiP4Awcu5YVPvwMtNh1qYgzArrGNN941IBExQHO
	QMxMuSmsFMrVmW2gxMKq5DzT2Y6aY458hNNMjBNN/ps8KFt76tzunAXveNT87A3vV9wCH
X-Gm-Gg: AYBFou049309sssFE7YKXlniweipG/WYrJHmHy4nk0UhrDOiKTLuqsCxdWd0YkkDFQZ
	fabJBx9EzWaPrNkCP+nS0Mr5NBfFvpkruuL/eUmKMWME7FV1y2Gr9ejZWbKOyEYLj7hhxXBjW3L
	DFLtBxsF/UfMIcvopkh3Hp3jaA05R5LLxQ5hyiCO+PUwsJrt2A2H7SursO1QgLf1KM4lBcTeEfx
	15NR8bd0KhfbuA5bvK/ikGSiXC15n+yPG+YHxG9whY0qFXtHp/QumVTH+CbhpNrBCL/yN9l+4N5
	KJh9X8cLEOAAf5Ue/GYds0xAXayTyAN5boYwWgNpgFsv6zOd65R9gu+r06Mqo4eYNRqqQ90LPqq
	o+2m5d2vBDzeuXxqrWoxo+M+YfbwaKkt+6nOuEIWVT6AFlNov4IvMOZrxyVTIfD05rkE9c5INFy
	YTCPEDissaM8eRPGg=
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr47053995e9.6.1793362191513;
        Fri, 30 Oct 2026 05:09:51 -0700 (PDT)
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr47053415e9.6.1793362191072;
        Fri, 30 Oct 2026 05:09:51 -0700 (PDT)
Received: from sgarzare-redhat (ip190-139-192-82.pool-bba.aruba.it. [82.192.139.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aa704sm54507825e9.8.2026.10.30.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:09:50 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:09:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: phind.uet@gmail.com
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: reject negative tv_usec in
 SO_VM_SOCKETS_CONNECT_TIMEOUT
Message-ID: <auSIGIZctLp1oOhf@sgarzare-redhat>
References: <20261030064428.73930-1-phind.uet@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261030064428.73930-1-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e_QW-l-RaAvg03KzO4D62m81c0YY2P10BmLeC3NI2Sc_1793362191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Oct 30, 2026 at 02:43:50PM +0800, phind.uet@gmail.com wrote:
>From: Nguyen Dinh Phi <phind.uet@gmail.com>
>
>The timeval validation checks tv_usec < USEC_PER_SEC but not
>tv_usec >= 0, so a negative tv_usec makes the timeout computation
>wrap into a bogus value, later tripping "schedule_timeout: wrong
>timeout value" instead of being rejected.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>

This blank line shouldn't be there, maybe it can be fixed when the net 
maintainers apply this patch, so please wait their comments before 
sending a v2.

>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d0508887a2fb..1d7d53542724 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2156,7 +2156,8 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 					     optname == SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD);
> 		if (err)
> 			break;
>-		if (tv.tv_sec >= 0 && tv.tv_usec < USEC_PER_SEC &&
>+		if (tv.tv_sec >= 0 && tv.tv_usec >= 0 &&
>+		    tv.tv_usec < USEC_PER_SEC &&
> 		    tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)) {
> 			vsk->connect_timeout = tv.tv_sec * HZ +
> 				DIV_ROUND_UP((unsigned long)tv.tv_usec, (USEC_PER_SEC / HZ));
>-- 
>2.43.0
>

LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


