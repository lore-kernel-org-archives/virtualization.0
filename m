Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3520B218
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506597; cv=none; b=IhOdl5TtUj7FrSbRDfniicBPYu87oYUJN7u8OpYos4FhxeOXvoaa1zOidCWyLb+yw16oDYxq6cW9IAkYwvdKUBzuz08lhbza3egjSfsiHG5qZ67+fPemxvRqUwU4uhJBPvs8PRlvJqay665c/dRwMH00GFVeVvFTmsWs/WYkCn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506597; c=relaxed/simple;
	bh=VpaS8bAQyw3p7i5yPlKdG6wr5isGrSmLsdJlLMostJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l9+15SjOCwDshh6UrDc8kfrCxdu+wmMpTcu1OchNwg3HTZBjq7smop6SQWy+auP5RCdPoastvcyBXS8Ubh/Izw6YUtKv+YicEkJUPN50fd/1cObAEU6PON3e5GitlC7GCJlFNWVBkdeYfVVe8uoai6fsTG9wuLVelDCxUm47hRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/4irTWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/4irTWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736506594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wp2/Dl1jDgRS4MRZ7ZCAJJFdKOiZ0bWzlPWkS/TsPH8=;
	b=d/4irTWIVSPvAVByje1jQ7AfLj4XVcgCocZPZpCRKXcZTiqea2K9CadMryRTaxgYrZ+iX9
	1/kYjiHwwjPrc0vWD6V9jY2JKMFwiLPWn2PpKeptbj4pTxRZBt0s+OS/Z7zuUyuCg9tmSO
	9cuhr+3hV/lkV05WFTG9CnnDv9ZDxng=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-EiW_uZ_uP3Kln4IvoC75mA-1; Fri, 10 Jan 2025 05:56:33 -0500
X-MC-Unique: EiW_uZ_uP3Kln4IvoC75mA-1
X-Mimecast-MFC-AGG-ID: EiW_uZ_uP3Kln4IvoC75mA
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa6a6dcf9a3so147165366b.0
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 02:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736506592; x=1737111392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp2/Dl1jDgRS4MRZ7ZCAJJFdKOiZ0bWzlPWkS/TsPH8=;
        b=h/bxb2qfJA14+pmMA7Nuj7SEsqNr2dbz9qY2Ycp9lSl24qyVHrWIcClRZ4dw0uXAT8
         QwQWT1Ge1YYGdIRJwwv4mewpo7GCqLRHmHixREc5w+tJXoHXCYZBPHGWzlfn90nlRjA/
         05IM5Ss28+/pbCohSNLE4oNcVY9JSQO9AZNVqmiL/yLEmIvhdXfLL4o1YriFrVLkuxNV
         TPKCAszYdo11+AgdODJ7Kn0dXvsveOwIaR8IGw2aLN+b7W/1mxFjmpJ5wrqBKQLtNo2o
         COf9cjjjwWn6+Zo58TW5hd1spM54YEt7pdgXmn7jTnNpVe4H6BOYAxK0Y0aKLR3GxW7T
         PBRw==
X-Forwarded-Encrypted: i=1; AJvYcCWvSUFnCrHiAHaFEpNjBr415kD5TkNwjGIiPGGxA8TkP+zpK4Q9lC0uPX78a5/Hg8iVJ6xs6zmoe9KHZbRRIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlHqlXEWsdvbXmJMIUuD82O+ikpa1BnMpU04SqR6FO4HUwj4Vq
	ZSyu7x7jooz/lOCC5N0fe8xyeNL5tb1B4UiybKoinTv9/um/fHs7P0o6HPy1mb2nUcUIHphjqV2
	p1k+rHYde6KlExiYAsGQOkAmY7F9enAKGVWnm4cgvrY3jyQIu70Iu5BaeVyYD3dp+
X-Gm-Gg: ASbGncuE6NQJ7u7+KM6PUf49g/jLc5WMXjQHjws2TEQkU5A35vwofzsmBAt+Chou6U9
	EeyMHXNiEcIHqv0ZlNhTaatUm4xZfkWVGWIICdwYbn23glVbn/jub2F8wUZdQe2BNAyU5dcciDG
	cwxUTx0piPZ+ZH635sSrWV1dep8qTOaONZQIwESOaO2ykAnH8wYmcLbMmIWgCauHlyMPOqzZA1b
	tHqEM4VS0T1kCgXws6Lo7c+Os6wZy0E2Yxjxtjtk39Ydo9/rCVudb096UlP
X-Received: by 2002:a17:906:c153:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-ab2ab6a64fcmr802391166b.14.1736506591800;
        Fri, 10 Jan 2025 02:56:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3RAnhLiLE0Ufj7mjhyCOMtKbT/PK9cbWY0n89eBu/2UqooguiKKCOcaocF+kmmlz9Ef1oVA==
X-Received: by 2002:a17:906:c153:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-ab2ab6a64fcmr802388666b.14.1736506591351;
        Fri, 10 Jan 2025 02:56:31 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9562ea8sm156141666b.93.2025.01.10.02.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:56:31 -0800 (PST)
Date: Fri, 10 Jan 2025 11:56:28 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, Jakub Kicinski <kuba@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 4/5] vsock: reset socket state when de-assigning
 the transport
Message-ID: <esoasx64en34ixiylalt2hldqi5duvvzrpt65xq7nioro7gbbb@rhp6lth5grj4>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-5-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250110083511.30419-5-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D3wQiSKjSNySJXzWRJ1TG451lleZ-OIpQVkom9JU8bo_1736506592
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jan 10, 2025 at 09:35:10AM +0100, Stefano Garzarella wrote:
>Transport's release() and destruct() are called when de-assigning the
>vsock transport. These callbacks can touch some socket state like
>sock flags, sk_state, and peer_shutdown.
>
>Since we are reassigning the socket to a new transport during
>vsock_connect(), let's reset these fields to have a clean state with
>the new transport.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/af_vsock.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5cf8109f672a..74d35a871644 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -491,6 +491,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		 */
> 		vsk->transport->release(vsk);
> 		vsock_deassign_transport(vsk);
>+
>+		/* transport's release() and destruct() can touch some socket
>+		 * state, since we are reassigning the socket to a new transport
>+		 * during vsock_connect(), let's reset these fields to have a
>+		 * clean state.
>+		 */
>+		sock_reset_flag(sk, SOCK_DONE);
>+		sk->sk_state = TCP_CLOSE;
>+		vsk->peer_shutdown = 0;
> 	}
>
> 	/* We increase the module refcnt to prevent the transport unloading
>-- 
>2.47.1
>

Hi Stefano,
I spent some time investigating what would happen if the scheduled work
ran before `virtio_transport_cancel_close_work`. IIUC that should do no 
harm and all the fields are reset correctly.

Thank you,
Luigi

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

