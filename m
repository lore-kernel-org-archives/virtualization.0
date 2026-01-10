Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303644A23
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003876; cv=none; b=hDSyx2txlsAkHsi+CLbPuKhXZ8Y+Fu7JZ9QyPkSXVxvykJvQtlDiTXx3qgn0meWCnWDXlI2VEFjY3jPiYwGSioYyz4iPI136poD068lYWNK0unTF92MU+v4MK+gdXs7ON7kPh7/yUxcpE+p0zE+n7E0fjEaHdriJHgBH2bb4zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003876; c=relaxed/simple;
	bh=XszBXPJ18HkMpycCWMX0Y8i3Aoh/kyFsduWJiX9qSIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTM0zD74ipdRKCtpsGsNLMXxuTdEE1wq5tBEf2lYYQCDw20M2Q5dkqVzIe2Y3cYRbLLmoEqljPTD8PC2qelk/IXEDHeSH3hMQqyZDLXNheV5GiBNSDssD2PhXAtW4x9qVNOnpXuK/E7wS7b90VSb2XlxEB73gbEbeSVUYe42jdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7AhEWpW; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7AhEWpW"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6455a60c11fso4019368d50.2
        for <virtualization@lists.linux.dev>; Fri, 09 Jan 2026 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768003874; x=1768608674; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N0A2c2LYMc0dJDgYzdUUiKfOdoal/WEyiilk+5HTkg=;
        b=P7AhEWpWX8VI2MjayEZCL1S5TIHJwfU/GSBxdWyTzI+Q2aqm38qXGdUDE1wTaUNOvy
         l7cBtcaPIQpVOkJEvEze/HHlxqSSN77/aWzZN9D08QXGtXF7K8VeimJj834aI3Egdt7/
         uu6daNjgt4UACjUoToAxR5rUlNKTZa7tVm1BJ8lbTOKWNO8niSBfWMY7c95XkjogXz1r
         s/tE5FxhVItJ6rCsA1SyWJ2T+R3Zi7BJuE/Ve7+gZS7LDdp3aNkjUK5VtQo7+wSdiqyY
         HgkS5h1Tv3Yl56IXXCV5tzwREE35eMrS9+TrBiPkujXdeqyxdPnBW7fZjF+c2bFsfhHm
         LnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768003874; x=1768608674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6N0A2c2LYMc0dJDgYzdUUiKfOdoal/WEyiilk+5HTkg=;
        b=J1x6fXqETC97h2QXlB5rR/CDLmQ4f0MKIfMbNPIfKCDuE+UrbIkMJKuCPvJKecdRa2
         LWJ0Pyj+Pp4YbzrBu9nWFts3eWO9h+9COM1yaePH8dIuAnbiAZcTFitgzYGzWOufhWJH
         Cs5UvV9a5ILNBt9eu8FzNOdBf1DmN3HEsd91KF7lPWKbJ/jyiBFMwKGN7gmmWUKHk3BB
         QGMpyzmMIsoXZGSuRL6vCivRzUD9RfOHJ5D3Ur+AXSLIpK77d6FN5OG/KaIvQQRj+OKa
         IRSGEh2oT2ZAZsAzMRugdvYJrG51L0I6Mwsygl1xR/LX4mnCApLnGdEbrvv+SO2DS3PT
         ID0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+m1FviCZe+TPRbe1fDiHWx8F8XQu2ZNsLBBFBbPzK1Sodsdc9BmvnFYk8YNITFDlwj8kP39VdlrQOSgYELQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFzlz71Cl14jWzsSPLyB0YQG2gc8WgemXkmsub1RvHVvMr4pmv
	ILq2KdzdxcOLgneXIioc2TLT1JoOXxSq1uBR6n0Fm0rQT3bewHjM0KKP
X-Gm-Gg: AY/fxX4V6WxeE4BcuyXi84k/E/Iken7f7Vm2AktbA8stcw8Xclq17g6cGmrzYybFJg9
	2jSegVGYvq0tnhTnsggs+d9ZNPx983qr/yR7yaj5z3+Dh7+UjsBHCWQwEdN0oOoBRftZhtKCgys
	qfeVIPp4GgpsdYdLV2KigcmzRAkD0M+tQRfJBXzkjKhYlP9soVUbCFu5ob0NqrmyuwO+x19SVDY
	JgrGgaFKMprr5BSyGIZCUjE5De1PHrJUZYrXC4ZW4C9W5v03x1GNKRozjnIx6ozHhr/etdI5/di
	Ix+eS2YTgN0Uf+WovgrdfrV2BabRLCbRE4/JNn8jqLZKI+qFlgkRvIh6NrttdCdXCNmf9MWN4/1
	f0HnNacqZKJcjRVJbFhX1xTvHzp0h8/z38ezOJemLM12cSauGelgq+0F8kgvrAvw0ivvFY4Ujh4
	NiqqGWqWztVuf+GJZAisnaEQqJTvnLF3p94Q==
X-Google-Smtp-Source: AGHT+IE5CW/VP1bFR/Dosae0XD0Rb9scRJI8ZCC2GQQ5cF/xpuuKEVGU70q9buii5G2BZNROzhlUqg==
X-Received: by 2002:a05:690e:1611:b0:644:7712:ed72 with SMTP id 956f58d0204a3-64716bd7b38mr8182868d50.43.1768003873903;
        Fri, 09 Jan 2026 16:11:13 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa553ac3sm46524707b3.5.2026.01.09.16.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 16:11:13 -0800 (PST)
Date: Fri, 9 Jan 2026 16:11:12 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>

On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> This series adds namespace support to vhost-vsock and loopback. It does
> not add namespaces to any of the other guest transports (virtio-vsock,
> hyperv, or vmci).
> 
> The current revision supports two modes: local and global. Local
> mode is complete isolation of namespaces, while global mode is complete
> sharing between namespaces of CIDs (the original behavior).
> 
> The mode is set using the parent namespace's
> /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> created. The mode of the current namespace can be queried by reading
> /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> has been created.
> 
> Modes are per-netns. This allows a system to configure namespaces
> independently (some may share CIDs, others are completely isolated).
> This also supports future possible mixed use cases, where there may be
> namespaces in global mode spinning up VMs while there are mixed mode
> namespaces that provide services to the VMs, but are not allowed to
> allocate from the global CID pool (this mode is not implemented in this
> series).

Stefano, would like me to resend this without the RFC tag, or should I
just leave as is for review? I don't have any planned changes at the
moment.

Best,
Bobby
