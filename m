Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439886;
	b=LBtRWeJD7O1zXxKyc9TTwHPkIs8t7BW43T4R5bMsKla7iUhi1oBfkODAj69CHPFWxeYk
	 hZGAQEIkUPqwQvazWWvNE2ueOsrH3vOvgHEfTFrLBN1+YnPTqzCzSVgT/U6rhsUXqr+61
	 rxLE9vZJjtHTK1kRPkDWeVIvXuCIW3gfL1FfNem4rbpbGaiMjw+2ufmWi5RulRqQinbdN
	 bs+1BhyhFlD7hLThXhiQs8l9uR/jkkxdnUmdIrpURFqZ0FTEEYZRyfQzJ+L9mGGbQJ6XR
	 PN9lJElN4aVGAnRmOQDMqtpj27N83Rj9tl4rf5uh3th/nIlx4ULfoK1ghWu5ye4r4wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439886;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=G8b0M55Qsr5j/jjPgd1PFdARJOj0KhBIrnCc7fyRQ00=;
	b=CqDP1S4ALpMDLnbE2lqdCxE9cdZTzQEKyQ4lYiakHYD9Szzyl3XPsbdDKOM2kOuYTAdq
	 QbFi10uQN72KSbuLVjELXmbEpp+o3ALEcfvOx81wS7R+xjVICkMGkxUpLL6eWL8ojCy9K
	 +iGPrzi/00Q5rWtUse+nG78WAsvj0UNVsDkyB/j1+PmXzjYMZ+yLs7RrMDtjPJCVtD889
	 YGRjp9PGm75GXrwHF2xOkg1nBr0NFzW3qnSd7RY+Cdgmp5hYEGonlNFh07MBYkGHyon10
	 ss8NPOvqN+o32Ep8yvomhwBfmcNIOWHFig87XqBPPs/rbho9jryxtXqXHj8//lk9DlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AoiiIpj0;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1787606A321
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 13:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1787606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AoiiIpj0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795439885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G8b0M55Qsr5j/jjPgd1PFdARJOj0KhBIrnCc7fyRQ00=;
	b=AoiiIpj0VZTp93rJAZ3T8xrfi0Oih6SS/iRqZs+Sd/TTloTOuS4JD6P2Ere8+TnUYGq+PX
	tVbxLoWm7HN4LGuFdrGZiU6cae+j7QHwSmS+zDVxxRZ/HTv3Y/z5+H4kfjNzls0zHxzz2X
	hVSkmFq+MSw8hWyz5z3e2RysP3O/Auo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-lakETB_iOVmzXbNPrdPRlg-1; Mon, 23 Nov 2026 13:18:03 +0000
X-MC-Unique: lakETB_iOVmzXbNPrdPRlg-1
X-Mimecast-MFC-AGG-ID: lakETB_iOVmzXbNPrdPRlg_1795439882
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4901562b819so2390739f8f.3
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 05:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439882; x=1796044682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8b0M55Qsr5j/jjPgd1PFdARJOj0KhBIrnCc7fyRQ00=;
        b=PFh0rqB//VJgBfo5lvJyq6u/LvUTQgPvXKYkj/LMIntd1TUAWWw+amGtA1WLta65b+
         p4HubZ4tT2gw7tNpe1FYCLryGvJyUMlEK5FUnSgVPGwhTR8QwiGu1cKxiBYhlzh4NnEk
         yszgwWIXNMHOYxo9K0LI1gxGymoLW3imvK7MFw1E3OX0EhS3ow+9+o3cfPgiAgIhNPo9
         k6PQK+n5p7qsYq+vdXSrBZ43pO2O96yxAQ0bAx4Rj0HLjvWwhapfQgXl9MRchHr0UWih
         r5hBfy93ItQYSsrMaD9XOJfiGoElHFzFlYvk7DLrYnRJjK1wYLHSKoMneYnN2ngvUHj5
         zNQg==
X-Forwarded-Encrypted: i=1; AL+hErF3s2/Idx17CALFwtDzis6BrdVJYUn3DoAPOkg3O4gUVNbHeE3EqPtVWXpIIcJUzn0N5IvkHkeuxAG4ZqNz5A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/N9HCVcvutvtwwAXV1uo/yNcAWV0szH77NBnEUwdpfC3+tC/wr
	FjsYwxNqsbWrh/LNBK+ljlwozWC7kmlSyB6iVsTaR+x4wyvR69mas6fEUP4EFrC+ACuEBjX9YKH
	aRcmgZC/UlG0ybvG+ysDZWhDIuRcmKy3W31sDcgPC0RsgKnBLd8THmp9TCju/tFFJcqof
X-Gm-Gg: AZFdTZcPLIo7IgezKIKAskb5/D5KBxmDo/8Bkg0l6JEk0oNttmFRdgNDRm4uKxECmu7
	VqYpi3OHEfxwXLWo1gpMRjtuKAN/aNkqGKamYRZ0oHMLT+69lsV6EoEu89mmeraEYA3aO9FZ2HP
	Yvk3kH70jWxhWA3wCAa9ZsZTwMsGxvO6UCPM12CBKmvy7UhE1NtF1NA5uCRxRs8nd8YU7Mlehie
	eI9NFXvpni4jV3/eSaiSYyORTtswzxhjJNmcRtrZN1Rbnhc9pXhs2CQdTtXaAsSoyPVLnjbVZHn
	jA+J+kU8+JxeFR0957MlkZhB1NRooFQkkkkACNsBXZZRVsYwPNo9zvdkCBQy9EMmVN8xAifct+X
	9lQFe3rjE87/TDGiZqAAYnFZCbDRFuKrvqxIkW+DWLIeQ96nFCwaa0g==
X-Received: by 2002:a05:6000:491a:b0:4ac:37ff:140b with SMTP id ffacd0b85a97d-4ac37ff143amr20351757f8f.25.1795439881941;
        Mon, 23 Nov 2026 05:18:01 -0800 (PST)
X-Received: by 2002:a05:6000:491a:b0:4ac:37ff:140b with SMTP id ffacd0b85a97d-4ac37ff143amr20351692f8f.25.1795439881467;
        Mon, 23 Nov 2026 05:18:01 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm22435688f8f.58.2026.11.23.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:17:59 -0800 (PST)
Date: Mon, 23 Nov 2026 14:17:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can
 reach the device
Message-ID: <awQ5xzF8P0NJiCsv@sgarzare-redhat>
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <awQJo8WE5Gn4nYHp@sgarzare-redhat>
 <12a2b44d-3d24-4b77-9dd5-24361d5fe910@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <12a2b44d-3d24-4b77-9dd5-24361d5fe910@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _IHEBSZ5dXg5G_9AWAoj_0gPmFc6SR-S77U1cmE1K1I_1795439882
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 23, 2026 at 12:58:38PM +0100, Paolo Abeni wrote:
>On 11/23/26 10:43, Stefano Garzarella wrote:
>>On Mon, Nov 16, 2026 at 03:46:49PM -0800, Bobby Eshleman wrote:
>>>vsock_deliver_tap() clones every packet to every vsockmon device on the
>>>system. Creating one needs only CAP_NET_ADMIN in the owning user
>>>namespace, so an unprivileged user can capture the traffic of local mode
>>>namespaces.
>>>
>>>Pass the packet's netns to vsock_deliver_tap() and only deliver to
>>>devices that pass vsock_net_check_mode(), the same rule socket lookups
>>>use. vhost passes the vhost_vsock netns, loopback the sending socket's
>>>netns, and virtio-vsock NULL (global mode).
>>
>>For local namespaces I think we are fine, but what about global?
>>
>>Is it okay that a namespace with global can capture all the packets of other global namespaces?
>>
>>Asking because at this point the CAP_NET_ADMIN is useless, since an user on a global namespace, without CAP_NET_ADMIN, can just create a namespace to have CAP_NET_ADMIN and access all the traffic. Should we fix also that?
>My take is that the above question is quite orthogonal to the current patch
>and may impact old applications relying on the legacy behavior.

True, but I'm not sure that behavior was correct since the beginning.
E.g., what is the point of having CAP_NET_ADMIN requirement if an 
unprivileged user can just crate a new namespace and get it?

Anyway, it's eventually pre-existing netns support in vsock, so it 
should be fixed with a followup.


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

