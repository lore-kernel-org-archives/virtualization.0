Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DB3D6F
	for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768090339; cv=none; b=THHmefGlUVl2q/ZhXn8pmNkMyqw/nT/B4EbSUMSQwO7ooZRB9FeMc8sXchPoqgRZrxtmjz72bJTjwZnfdCwPNCrXaeXX6+ZAO0vmZPsLuzAU78ZqX696gVTK6kSc75xT5jYtL+FoVEgMUubSxmIFskwc0HXAAg5DCmyKCRFsWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768090339; c=relaxed/simple;
	bh=mLWLZ8V/CeaK+tkNrj5VuZDldGSy5v1mTtg2DMNYb/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=d7TylyUixg5F7G0+o38jNEEl1aKkxsshxQRDLS6rlJ8Ek7I0o4LqxRE6MTlFvzkpM0/fN/WPfptxlVzuEYBUB54nBO2hIhoKuoxWafjqspSHtWKUiHUqPGyuYhXNXAziK6RVHhWQXyp39/XqtZ1w3EtBMtUfD395MWCnQYYacg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVrgRPNk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVrgRPNk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768090336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
	b=eVrgRPNkykTbZOl36bAOdF4+zP42QWFqi/3+04yiyMoBNZMEaUWzt/bmg4rARhYfyfxlxX
	wKt1dtpm3CUDLaDAeX6EbzaJYq1TeurBI88EW0xd+ugN2ygB48bBwRFaEbKUgKOQ7lNHMq
	hN7BdHlPMnZDnH2d7gfG5R5agfqJmY0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-xUDmKlgjO2CO838ZUKiwBw-1; Sat, 10 Jan 2026 19:12:13 -0500
X-MC-Unique: xUDmKlgjO2CO838ZUKiwBw-1
X-Mimecast-MFC-AGG-ID: xUDmKlgjO2CO838ZUKiwBw_1768090333
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso49129835e9.0
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 16:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768090332; x=1768695132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
        b=YZhhng3IA3MbnnQUvsGR2wRCEFSJ98mtrMg3MjO7t1ZG/jzR33ulfYDJ48fhD4wIrf
         0SQy9oICPwzXO7E8sv2UymG9QRDQvCc7B0ULKZc9Wr+NOpKjWu+mq1z8vf/lXmES2RN3
         79L5HWp1xsllZ684xa287nziSK5KbVwV+oHGIUP1WQZ84zIruA+XH87+emke7llKFGsS
         4M2zV4Wg7C2uzAFRT3WZhf3w8/YW0X2Juif725+zymUuKhZIvdM0WruLgqE5mLHxGdQh
         2yt7ZK7I2oHvDXNm4Wknyiv25wuzOSuoCuGE6buvG+5VaTaJlTk4Zi2wVW9OzkgBBECz
         w5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBBdVwmiC7aGj6gO7WLawIe9hd+rZqB5nScoPRWAoPAvekN3MHox2CpRNLWfkeV1qFMpAsuVx7tKLiEryxcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgxlU3lq+RW2zREFFbbeWtEquof0iXbXOu/Pq0EehmLZ4fy9xQ
	nBZhnZ6B2tfvkpR3ffZbId8n9zulPKOiYjqNInHgTMz6RcdoqTVMeRbO5T8xmXwTzoSxai0+SGq
	YW4ArriXzKgsnPMUDf+YWBQFFU1v4iddLK9RUFIn7m8LV4040d3mLC18baukIZ9TguZQ+
X-Gm-Gg: AY/fxX796TzCMVwMuxZib9jl+GZpxjMIRInRRaSqKycM7xId4w4Pj7e4lndQlYEMUN2
	GYu/bDXLInvgbf83MuATOhrtiYHvEEjw3STe369fwCT7lIdPx2YGNrAhdSF+oZ9VbcSFQjwG7Qr
	mmaRy2Svjsh4XTKCzbVeDEFhGUP2DwmxvjWhL6J7gttptLMUlEp13sgcINMuooX+5GG/oUs9TKO
	DZ4kUJwTZmkXSsvbgfdeSRosThuDteMESaXSOQI9QdNbwfpUcjxCmD8lhaONlLlNZkZIgfk/m4y
	MMbbE5K/JX88C78FPQdWSuLufnuk8OOjVEPm+Wr/cPDCPfYIFSrelkTOExq1jUCFeyV7JHmBy2u
	I5NH4KZoaE94cAXnPQtawvApCuSP7N6s=
X-Received: by 2002:a05:600c:4fd0:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d84b1f7efmr165064585e9.10.1768090332617;
        Sat, 10 Jan 2026 16:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnuDsqC9m+l3yDfJUMvz3utaUAG5Ge2RfD+SugU7SA1yuuWtgjR7DEiLIEaKlXtpa9H3hyeA==
X-Received: by 2002:a05:600c:4fd0:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d84b1f7efmr165064445e9.10.1768090332218;
        Sat, 10 Jan 2026 16:12:12 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41f5e0sm272650555e9.8.2026.01.10.16.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 16:12:11 -0800 (PST)
Date: Sat, 10 Jan 2026 19:12:07 -0500
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
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <20260110191107-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IGxKDlodFmAf0dE7ky6ZHABiCDP2kSQpF04yWXhYy5A_1768090333
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
> On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> > This series adds namespace support to vhost-vsock and loopback. It does
> > not add namespaces to any of the other guest transports (virtio-vsock,
> > hyperv, or vmci).
> > 
> > The current revision supports two modes: local and global. Local
> > mode is complete isolation of namespaces, while global mode is complete
> > sharing between namespaces of CIDs (the original behavior).
> > 
> > The mode is set using the parent namespace's
> > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > created. The mode of the current namespace can be queried by reading
> > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > has been created.
> > 
> > Modes are per-netns. This allows a system to configure namespaces
> > independently (some may share CIDs, others are completely isolated).
> > This also supports future possible mixed use cases, where there may be
> > namespaces in global mode spinning up VMs while there are mixed mode
> > namespaces that provide services to the VMs, but are not allowed to
> > allocate from the global CID pool (this mode is not implemented in this
> > series).
> 
> Stefano, would like me to resend this without the RFC tag, or should I
> just leave as is for review? I don't have any planned changes at the
> moment.
> 
> Best,
> Bobby

i couldn't apply it on top of net-next so pls do.

