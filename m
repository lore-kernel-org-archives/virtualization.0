Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183022173D
	for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768113827; cv=none; b=U7G4f2CYVUMc1JVJeOj40z1zF1dGDUQnhPMilHRoI6pE5Ixa+SmjKvnrMIVx7v3VdrNCVW/TjK0C+iglE273ZbuWeinKDM/czwi4kgV3EHm3XKSY0tziM2DWhBzoDTQCaITW83zcG680Syol5lgB7XCveP0Nh5U1egIOV5/csX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768113827; c=relaxed/simple;
	bh=JD9UEMV2ESqXFzdZlTaAIe3B3dw0Y3l06h1cl/AHTH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gf7IzHVYUc/0+hkhOe1E4pktqLbJdO9Jb485jq4eu3linhU1e6wAtIYHXv482qKB4zmA6PIsnAki4CcemLm/yyCcaxPPMxLXvrHnm/eVV8nvm3/qGaraM73vSW8xXFu8tJfyr4Bl93cxGA4aJKKxTGqskkDb87IY8PlDDpMmCNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqtMKNLL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqtMKNLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768113824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6/EDkpRsLZ7JjY4jSYMGAe1PlTU/1r9sRvOnftJVsA=;
	b=dqtMKNLLwsWFQizCwj45yG6XwFqYeIc6hV2QY8Mhf8RHuxcM6N06xNgN7m9gevW8m3TuE/
	SK5iHtBVnCfDGhvhhXfi/yQ/Z4Ut9ItwajKp9x+QliLhbKKN6pGPK8a7SJ6ajSmcHRlaoJ
	zxWbCRrjyTX8vpi5W1ySpNRIY+XKwXA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-OIGXDLnAMgaDBKvW9AkO-Q-1; Sun, 11 Jan 2026 01:43:43 -0500
X-MC-Unique: OIGXDLnAMgaDBKvW9AkO-Q-1
X-Mimecast-MFC-AGG-ID: OIGXDLnAMgaDBKvW9AkO-Q_1768113822
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso64724455e9.2
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 22:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768113822; x=1768718622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6/EDkpRsLZ7JjY4jSYMGAe1PlTU/1r9sRvOnftJVsA=;
        b=e7gKU3rom0iEpPhuuq6lOhEoLkPVeCnMe0lkVEVXjqNrgmaRGwrZqr+AuKnNj7WUoQ
         vABY39yYrOvcR9xgmPoPxHjUhJqwNOmcZI4s7OftzzgAUDZKA0YINwguiHFRjmMvTQ9n
         YVLKFa7YrHZ020sSQON8P4ijRnh4Tws8HldjVz45f/FbpydJ4I5E0O9bAMQVTyUbPgXT
         uOge7aY4nF6qFAveNvRu0FZH2HEiJsxyYk+lNudukOQrP4wKpTLb19FR29cuKVkIpEUH
         KZH1IOL6Heu7zzd0o9P90vF+cwj6GYzM/aUzcFP6ZHbfyb9EtQeMBbhU8SIPyBM/uHsC
         gSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyRtM0Xwz+6Vz8ySNhXmfxUjHtH3a3SwQPIr2ROgEDKvGaYRsHvt1y5GOv6szh5Epq3s3/JpwVWVHbn04B5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEXZEZpX5wyMt8MK6U9VVdqPF5aBMpUOyPQmzK9ZpR0qvgn6cm
	qR3ZxujIFraHGUF7O4I0dO7GQdB4VnLbyK1besVubCyx0NgCy3HNE71RgVYKu7VTyfovCmyRW9m
	YRt7vH44qPNyePa6TOrxqNAYTzZy1XKf+H9HmjBHF6MOROhFMy5sKfCwf7H2hziQ6OCMF
X-Gm-Gg: AY/fxX55/oDcRDmTotJY2+zY+w+uziP8b3uUpo/Z6/QV5i4UUU20pVt/Ptb/HOswg03
	ThXtrYqMUVUsD0Km8fl74FWdDlF5MMjj+XMdeyMrkZoBcDIl/HDk7VhpUj/R02su9RJrzTLkCO/
	TQvVBTUcpaJPnPTOHFFSWZUiqfHas7RhLt5leCINUzVGFC3++CErN1A6f7LHSMfX7YkdlIe4IfD
	9vbq0z1l+05B9C+WkbYJqhZC9DkYZSk9tL/rD0CGviymRutnyWt9ndVHgN6mGqmTAl4jetDyE98
	Y9iRZyKap8vOVIFw1bguzgspOA+uDL+ETO07ucUIn+H9W4DzfsgPy3OPVuFsNHIArCWZEiuBcP+
	9e2VqIH9k/z7owpcS4he/qlS08ilPbeE=
X-Received: by 2002:a05:600c:190e:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47d84b1faffmr173261175e9.9.1768113822024;
        Sat, 10 Jan 2026 22:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFprQahh0jRaFJb4VDDWHvHnytv+WdXNUVMhHUBmCAuMZpoJ/VdEFWzP+x0Gcih4TrON/Ayw==
X-Received: by 2002:a05:600c:190e:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47d84b1faffmr173260995e9.9.1768113821580;
        Sat, 10 Jan 2026 22:43:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef885sm284657415e9.9.2026.01.10.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 22:43:41 -0800 (PST)
Date: Sun, 11 Jan 2026 01:43:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 02/13] vsock: add netns to vsock core
Message-ID: <20260111013536-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _a8eIJBVk4VJah8L95EwoqmOIS-dYIZyp0gluFvaowE_1768113822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2025 at 04:28:36PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add netns logic to vsock core. Additionally, modify transport hook
> prototypes to be used by later transport-specific patches (e.g.,
> *_seqpacket_allow()).
> 
> Namespaces are supported primarily by changing socket lookup functions
> (e.g., vsock_find_connected_socket()) to take into account the socket
> namespace and the namespace mode before considering a candidate socket a
> "match".
> 
> This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> for new namespaces.
> 
> Add netns functionality (initialization, passing to transports, procfs,
> etc...) to the af_vsock socket layer. Later patches that add netns
> support to transports depend on this patch.
> 
> dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> modified to take a vsk in order to perform logic on namespace modes. In
> future patches, the net will also be used for socket
> lookups in these functions.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

...


>  static int __vsock_bind_connectible(struct vsock_sock *vsk,
>  				    struct sockaddr_vm *addr)
>  {
> +	struct net *net = sock_net(sk_vsock(vsk));
>  	static u32 port;
>  	struct sockaddr_vm new_addr;
>


Hmm this static port gives me pause. So some port number info leaks
between namespaces. I am not saying it's a big security issue
and yet ... people expect isolation.


-- 
MST

