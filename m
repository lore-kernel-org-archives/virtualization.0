Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6355342C92
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768260081; cv=none; b=ogbDxJXvEAY63cTZiOdWENSL8wzlmYW0vAA+pzT4GDsdNk6mBD1SqAxsGtfskH4HEJ4db6vOpBPPy2ZTlRPKqh8oizmy7Jzq8xB0swCYjn+xA4ZKZJwADHQegesgvAdKUH8wwicQIG01J9Noijmzf4KG55wd3ZmXCi+yw3ZE+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768260081; c=relaxed/simple;
	bh=7L4AuwoQwpFDKJ+QfvB8n+UzDOCrhQdo2yK39qUc8cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syN8arqzky0+LRXJv8aYQ+sM+RPcpzVko8KbeF6pNMP2GanXpLP7Kx8hNaRUd9hus4SooxURRaNprkx9rVBxpnMSSQtkeqx/IyPRd3aRt+//bEYWwZa2eO7taDYuAG82pDY4BZsKZ07WCl8FVJ09Rsbv3e/KkvP8naNnIeIBVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iueOJFTr; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iueOJFTr"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6467b7c3853so4754255d50.0
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 15:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768260072; x=1768864872; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtoLeYJaY/2ODhxZmDU22B5G0cJLjLhdpG7Ly3b1Aek=;
        b=iueOJFTrm+ZkmNFlJH+Vpq922n8g3Xv9kqR1pwYHCj0dHP4xCO0nY+oDSmueRMdlOs
         MaT1KRTZz4d7/Y4tNOPh7gp230XMo5GVtnmhsJ4yqs8L7Mx3wRnXo6N1Eldikccak+Ih
         zKd9M+YrYLjdRTZpQwxFtwUzgIrsosn6g5j9JoGoSxmM2elgOdX1zbP0+DMXufp9kFwp
         2wW0ged6B2iEBbHnYnM8cYklVsMnMS3MWtE7Qp56fttZLnXL98pxSf/fcNFroANeyY3e
         7G8HCHHELFPWfAQcsw2GoxxsWFchI5nIR3mzGLsqZUylAWzCvM3jJFgudyewvsd7tM40
         N6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768260072; x=1768864872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtoLeYJaY/2ODhxZmDU22B5G0cJLjLhdpG7Ly3b1Aek=;
        b=F9Jjpvz1Zc54E/LV4j6SqcDQ02V57rhoRrteQZLLBum1lOZwzzw0nzpcP6jMIgsDYY
         HZ0KzEevAluUUfnwPhgJUQRg774nufDnT9AVIxiM25R7+2t2iAawi1ZyeZrNpuWm/JpG
         +81dS86BF0Jcot6TSyIFbxJiTYvsRwOId2Kxtzj3oeuQryAvNIPbNEPPKBjbgyBICw7W
         rB0VhqCvHNBxgcdawTCKIboV7XacWbn/sR+7ED+vtGYPzeBMZh3EC+4ycVX7J/pw1A8L
         LbAt2zScrmiOb51fTX0geO/VCY1jCo70KxbOABY3ZZWfBZfTUOQfhuCih34EeaTsBIvH
         M5RA==
X-Forwarded-Encrypted: i=1; AJvYcCU35BIAcWQtzcjza+3Y3qvkY8N+Z1nbalDzyHfYKhYFXo2/ohoTHo1poMmrDKJI/7OATmpR6++fX0HsmSnenA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3td0L/tZVDqVLUa8C59kzTeHmZAVN5LVmOEiOwl57Ka8n/0ms
	c/JHvSN5TeFGUCW7wuxloXC7jvkd8Tpu8VLaueF9+vIfXVQBaTBYTSiG
X-Gm-Gg: AY/fxX517jWjSHuXVEoAVzQIKp0T1H8JDun4HRmyiyNt5HhWQ1tsSVI9Aeo45b9TYaw
	T9y2XGQMuMSl/Mo1VAHjhHaXt3J0pBVOHLuilP2tvMqPAMh8OzuRcrR8Ewqgp6GgQgq+i7NAFlW
	zn+tJcZ5uIBwsqEKZVSlZTiFWhLkq6nK/GMjJCXkKrOh/R2V1zGprmiUhxdiwM2101hMjGzZoeP
	k5ERYMBID+12RNnp6+jFSz9yHUn2SAtVWezKUda4V5FpuDIiDeNQtyio0ib+LZnwGwP+wWEM+Zx
	RGn5FZ+mrtDazeNPmm3DLZ32vC2ee/4QroYnXc/lccShvfRpbyyu2767YWIf+dbsOQWjN6daDxl
	rkEDyx1Mt9Rn3MQEakuWEQeYH56atFHahZelV361+a84xrNpYmoh+lmmu5yAwMg/cXMn83yYAT6
	+zuZtfsQIgUXTrCDi4v64C3RMqDxw3mHiusA==
X-Google-Smtp-Source: AGHT+IGPR3yHTofTNuLsmIGRF/vxUZuNpadx2Jh/erk6LsyOgtC+kyjO5yp6nCVt3XNr+Y0sCRmwIQ==
X-Received: by 2002:a05:690e:4085:b0:645:5297:3e65 with SMTP id 956f58d0204a3-64716b35ea6mr16989024d50.11.1768260071815;
        Mon, 12 Jan 2026 15:21:11 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6e12ffsm74065287b3.53.2026.01.12.15.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:21:11 -0800 (PST)
Date: Mon, 12 Jan 2026 15:21:09 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Subject: Re: [PATCH RFC net-next v13 03/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <aWWB5bvx677ep317@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>
 <20260111014500-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111014500-mutt-send-email-mst@kernel.org>

On Sun, Jan 11, 2026 at 01:46:43AM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 04:28:37PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Associate reply packets with the sending socket. When vsock must reply
> > with an RST packet and there exists a sending socket (e.g., for
> > loopback), setting the skb owner to the socket correctly handles
> > reference counting between the skb and sk (i.e., the sk stays alive
> > until the skb is freed).
> > 
> > This allows the net namespace to be used for socket lookups for the
> > duration of the reply skb's lifetime, preventing race conditions between
> > the namespace lifecycle and vsock socket search using the namespace
> > pointer.
> > 
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v11:
> > - move before adding to netns support (Stefano)
> 
> can you explain about the revert please?
> I looked at feedback from Stefano and all he said
> aparently was not to break bisect.

The patch that brings support into vsock_loopback depends on this one to
avoid a introducing a race condition, so it should come before that one.

Best,
Bobby
