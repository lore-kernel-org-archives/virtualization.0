Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529826;
	b=xYJgCqvTlYf2veSpHDxBQVtWuke3X5ybtpXyUBKLn8lgTJS2JL13cRP84SUsWh4xKa76
	 B9bhudXer4Hc+UDPlGKs4aZDE/KAdae7y89LGBtGqqKnbZ/doQdNn14WnOpJK+gP8EMku
	 v5a/oWU6rln9iosWEnUZXH8YmSM7fPebfZTYXAT8k/19TMx/848zipQunSW3+BgXoKu+9
	 OgD2b/PRAIet0e+nCuWCFxSnmOjhTOphtuNVySrISUOni3oFHRxuIVOibG59QpibTnvyp
	 bJ7Gao8ToylwZMfrI+xl9qeNPIAexkE7nLalthWo/SRkEnf0hUvWWaAwhmHaRwSgSpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529826;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=cv9aRKSX0/tOF0YOH867TlpVtpIDhyHmrDapDoadVQc=;
	b=WzsuRNegm/AEzAX01KX4+YUvdCUmB1wV8u54BANX4ED+AzXtHbl0Yy+IxReNqm8jntoK
	 4itlkKi+D1GeCMVpZSxe4+W99C1uDq+olHFocgvEd6bT1imEvmpZSIOhoyhY71CB8PkcP
	 pQUi7B71U+qlILvoqGM4qLIaTnWUW3dc0t2jvjYkXUIDO/Rd9T6jseaPlMmNmLfNuLcJ0
	 ZCEzyITK/g+8xoDgAR0ufSwo6gkpWFlBf23WL71zspvpNoU0CwsYuEPuzvLZ4mqY8kSZP
	 llPcB20NYV8gzIcBaYhpxluwUVCoUN/4ltI0iqDyZWqWF/CNJukyoJW3WAtbD0txD0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tg4BB2iF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29862606A32D
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 20:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29862606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tg4BB2iF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792529825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv9aRKSX0/tOF0YOH867TlpVtpIDhyHmrDapDoadVQc=;
	b=Tg4BB2iFhUMsMLdomV0/0BCyzwz36YshHKe5QG9MX8FnYMAm1804DK69dmPopQ1QMcL2bT
	ZtNIkVpIRYSU3GQQTSdlYtywUN+IpPlkqN65hCECgQT3MtGIXs4TihL7UltoleVt0phlmo
	xqV8pKhbM5DnA851Hr9uoWd3YKOEqbs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-JTrm6WTdOwCB_ZCgFy1ylQ-1; Tue, 20 Oct 2026 20:57:02 +0000
X-MC-Unique: JTrm6WTdOwCB_ZCgFy1ylQ-1
X-Mimecast-MFC-AGG-ID: JTrm6WTdOwCB_ZCgFy1ylQ_1792529821
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a16faefac0so297955e9.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 13:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529821; x=1793134621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cv9aRKSX0/tOF0YOH867TlpVtpIDhyHmrDapDoadVQc=;
        b=YjAP88KFiSEptBp8PtgSHAomqU//0jvpQyK8E559d4AWyg6mJOqu3ZH8l/NwQhop3/
         PGEMyK1IFHQShNB7cfZZO18BY3sF8XHI0pQD5LnnIrWkgjP2pH/HqLGwz0TuXtPwzAhG
         CDC0C8LrynT63IFZdx+GSsJXPtdYlHRXxYXmDu6s9MsVCf8FIluz3/VZ59TgZstRB1Sx
         WPaNUAixPT7HbazftEHbN7zkTDedSsaz7UNigR4P0sTSEkzssbvVX+TrEOUzm+R2hVWa
         RaqOa0FaNDHRjtKyB/WMN4Hq3B7Ob6Ar2OE6iUcGpjvT+8qIUnFEA+Xlu3idSi6uKA1h
         esrw==
X-Forwarded-Encrypted: i=1; AKwUvBwJB8ucEksH8sxyNlBm0ENGuC+X0nxOxAVh1wgWDIQMjqalJqc3ogMNWGh6iSqB/D3fdOsQOIw8ee6ES82XGA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLQcsZawcstubqyxbyyaEZmMc7TRd8uWQHHqWQZsYvmOZvWNSXH
	M2evkR0IACY1VeuTTk3Okhh+ixVySLMsuvrDsPqxcv2NXYQBkX5qqazB6iWAfh8EcsZ2P4WUkrK
	5ZOhCbcvdc+daP8a33qKnIz3ihWUZEZcyS/fXrKxzRW+ONxl5cDDEJhA443+VefJjEqsz
X-Gm-Gg: AYBFou146Oc/JrTB6ajZ4402veJA5VPibOPtQfNevXdSdimUDIXjNb6glW4XIrzEW46
	QrkTKjwZuL4HeItyReh1CLGofDTAkMkNHrsF7sWkV2104+4omHRpWGWaqB+9G0XS7EREEMGfFmk
	2unq6c0Got/3GA8N1/SYxUwggHNx4QTSwbsR4kawQLFwn0cS2HAIrSjYB2ws90WgaDWyQYo2+l/
	nU5RdZ5VHgK6ia1VGSAmIevahmgvayoCSp/K2uVTXGOUKbMdIj0g2vTecylKaFLZybJenuRU6Ti
	5hN7KLTkFMTPxhXpWKr/+s7tWeqPE0PFQ8T02JW3/ASthe487Xlixz8wHNZckoxeEW8icQ==
X-Received: by 2002:a05:600c:888c:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1eccb55d9mr101082585e9.6.1792529820661;
        Tue, 20 Oct 2026 13:57:00 -0700 (PDT)
X-Received: by 2002:a05:600c:888c:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1eccb55d9mr101082315e9.6.1792529820216;
        Tue, 20 Oct 2026 13:57:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f0bc2sm865375f8f.1.2026.10.20.13.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:56:59 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:56:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <20261020165610-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 96LlsuKJE4pXjVsy8oJuaSZ6xZWtwycBq9dDLqFLEwE_1792529821
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > +/*
> > + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> > + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> 
> it appears that they take the mutex_lock below

Some of them? But
virtio_net_hdr_csum_check_disabled doesn't, that's the point, right?

