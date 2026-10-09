Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053C4A205B
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539086; cv=none; b=bnhYm3GkXpbMbcqWL1HZjNZurJgEHISsdQ93dr9zTyi+wyolBGGmjxnBFaKAxySD7WgtY+Gfaa45Lj9catlGyPlKC/m4PyY+vGoLM5ix1csVGQoXdT0B/JAmS2zrHz3M9PY4YB23MYGHEYnmL7bP75vgFzjjIZ3kBKEwr2J7I1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539086; c=relaxed/simple;
	bh=bExytepNqeEnYoIxPmIR3Yt5a0tGUiyPzEQmZBVvvIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sSK/NV/xE3i/369jdPjpB+SJgiHb6mJrbU/fO2PeNZc6/c1UOhMeUM16AoDvRmQwQ3CcOAhVZXJc9Xcvkvdf5mYhEodrrjy2j91naqFb6DCmtkhUmlGxs86l/27r2DtIuQtkAgPoRfgmQ8jLAMdKUs73m1OXhAJZ2cHlFTT/hyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlDWB4qI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlDWB4qI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791539078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ElzbfGJ6k9OnVXRhdCGGIydQGM/Gsew8hwRjohyR8bE=;
	b=KlDWB4qI1lbkIrF1WGNLDRsCSYEaclSfMp3aJBBLZX7H+4p8i5HxEd0ffnMW5OWFI2PkiW
	rvdOSnNzS92VOsH2eL3d/s6xGUaDpAbVNexHdSa2xruyM4FrZTx9nCqrZB4Q8kyA9itnkN
	DwFwqmn3sU/RKqqzmBZ3WTgADx41iSw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-JIDJFB4PPT6SayW9OjStQA-1; Fri, 09 Oct 2026 05:44:36 -0400
X-MC-Unique: JIDJFB4PPT6SayW9OjStQA-1
X-Mimecast-MFC-AGG-ID: JIDJFB4PPT6SayW9OjStQA_1791539076
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1813fea7dso36197525e9.2
        for <virtualization@lists.linux.dev>; Fri, 09 Oct 2026 02:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791539076; x=1792143876;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElzbfGJ6k9OnVXRhdCGGIydQGM/Gsew8hwRjohyR8bE=;
        b=kmjxGW6JK4pCRYCBmWAMUNoMygKKyPZeQpeJJNJFefO25mj2+GrcjoC6ruToS28uGi
         uNlI6770SOMDu/GqRl/8HtTGh+IrwQqNpKR/m5JlJyIBhxgkvGrdG4ptYl88hEfZcSfD
         AY5X01Tifa6gtDEjbfFmUTb/edMbuyo6oy/MY8TbGaf4IVeo8besmflUwEBHHdFXmu9Z
         A9QFXQHYbgycXCYwpPVr70aU56o9uwjPiCPZ0hlK8otQyhIJng4rsGgmmeH/uT7dNTj3
         9J/HZj+FwIey6wPyBqI+Ml3zN2bmdvCoFNoaAyJceLS2lvvOa7dl+4FIfE42tZHpUCTr
         O5Qg==
X-Forwarded-Encrypted: i=1; AKwUvBxY8vOH7DFog+3lYV/9IaQCBresLPi78nnQ670Vd7IXA4dP471n0VDVY+n1MeyA4DDJYUJO5EI2qHtrljF6Tg==@lists.linux.dev
X-Gm-Message-State: AFuF++kKSRsatpmh8xqf32U+jKvClro4+YttPcEcNQnpiz5H2bYBCOQn
	Jwtb7UgY6pQlNxexTB/jDFxr1zPjZYkNGefUUlNIpKh2WLE8ZKjtP0sqdBUJt4FuTtNTC8DteGu
	4mf7owZc6HVU9bI3TaMRl4+R8NDowBeENlGE3m1VVg1hpdVFAYPLTLwUkH2YMgF3kPCUK
X-Gm-Gg: AYBFou3Fia4TBH97tqAaQ2qtQX924+6TsY8MMuWRQBnCKfCflBMIzpyhwY1JYuiR7sb
	dhm2TyxqxaaLe+UkvUq7NclBBcKtTUVoaEBO/iaNOZN9XCKFfCvvzpUNAxlsLbu7SOh+lupBhnI
	OgYfG8yRu0OpZywdlEzaDPHO8wuoVVkc3+GsiwhUWuwt6G3Eha5fUciEYGQTOUxwH7sk+Ld7N3k
	bRlYvE6wJN7W1QH1IH0VXI6XHVx0BiO4Dz5nnGfrmCJpH5KnBnI89TiO0aMjZQ1WWVAauaddAwa
	z9sTDcfXwXT09SdccLyBU8/W2BC0mDMeTM2TDC1c3OIbxmnCrKQaN0trc4oE9I8QHRrBCPNhzUJ
	2
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a18e4aa206mr24728345e9.27.1791539075669;
        Fri, 09 Oct 2026 02:44:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a18e4aa206mr24727965e9.27.1791539075228;
        Fri, 09 Oct 2026 02:44:35 -0700 (PDT)
Received: from sgarzare-redhat ([5.11.115.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm44828935e9.13.2026.10.09.02.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:44:34 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:44:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev-bot+sashiko@kernel.org, stefanha@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net, 
	xuanzhuo@linux.alibaba.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	edumazet@kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4] vsock: treat TCP_CLOSING as once-established
Message-ID: <asiySxBYMDbRa73H@sgarzare-redhat>
References: <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
 <179133282699.434549.6239722975007408103@kernel.org>
 <011a9085-0bb4-433b-afc5-9c787cde0e12@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <011a9085-0bb4-433b-afc5-9c787cde0e12@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LSboyzuupeZizCOxRvyxYh3P4v3nJ6G1XR2asD6Sh80_1791539076
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 07, 2026 at 11:24:32AM +0200, Michal Luczaj wrote:
>On 10/7/26 02:27, netdev-bot+sashiko@kernel.org wrote:
>> [Severity: High]
>> Can vsock_connect() still reset a socket that is already linked in
>> vsock_connected_table? This check only covers TCP_ESTABLISHED and
>> TCP_CLOSING. At least two transports move an established socket that is
>> already in the table straight to TCP_CLOSE, and neither one unlinks it.
>>
>> net/vmw_vsock/virtio_transport.c:virtio_vsock_reset_sock() {
>> 	sk->sk_state = TCP_CLOSE;
>> 	sk->sk_err = ECONNRESET;
>> 	sk_error_report(sk);
>> }
>>
>> virtio_vsock_event_handle() calls this for every connected socket on
>> VIRTIO_VSOCK_EVENT_TRANSPORT_RESET. It does not take lock_sock().
>>
>> net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
>> 	...
>> 			sk->sk_state = TCP_CLOSE;
>> 		}
>> 		sk->sk_state_change(sk);
>> 	...
>> }
>
>Right, that's a known issue[1], to be handled separately.

Agree!

>
>> [ ... ]
>> sk_state does not seem to track table membership reliably. Would it be
>> more robust to check sock->state == SS_CONNECTED instead (the transports
>> set it together with vsock_insert_connected()),
>
>vsock_shutdown() complicates this. It can flip SS_CONNECTED to
>SS_DISCONNECTING.

Yeah, I'd avoid to use sock->state for what we are going to fix.

>
>> or to check membership in
>> connected_table directly? That check would have to guard both the
>> signal/timeout reset inside the loop and the sock_error() reset after the
>> loop.
>
>Lack of membership check for connected_table is not the root cause of the
>issue. But, sure, we can discuss adding it as a sanity check.

Agree also on this!

Thanks,
Stefano

>
>[1]: https://lore.kernel.org/netdev/arpBYXWb9pohx-8v@sgarzare-redhat/
>

