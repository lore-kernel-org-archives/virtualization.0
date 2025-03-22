Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33E4C6C
	for <virtualization@lists.linux.dev>; Sat, 22 Mar 2025 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742605489; cv=none; b=TQLhOPofJF1oNtUl/n+mCKT1IWs27ZTHRMbUftPCYH1bhzFSbAfXl0pf8GgfFVvDO9UgW2++F78zu1p15mR87zwstECbZc9664XRqa2p7HeHmiaFy1/Qw1fWPJwjcVBfmJHZBOXMMezyF1JXrF9e15Hy/ECpYDYTATB8o8f4XHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742605489; c=relaxed/simple;
	bh=aHWEoyZwm8s25Ueay7Kinp+YHcLq+mIXDmffZMu7ec4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKXRfHnbnmEljceZBb2nlOc+qR1DA1Q1t/5QJ2RWrqq/lkLCaRkqq+K+cqUsKIqlJVQeL5+/IskwytAr/YaMy4lDS2PljSxQDKpz/USk4+RUdUI3Bytn44Wk1w+7lQFOagk6TPW9rSwv2gT3KASe2ohXMazeFMC4MBtSmJ5FNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQol54k9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQol54k9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301cda78d48so5006619a91.0
        for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 18:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742605488; x=1743210288; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c35jq7Zk6VAC2p9swunNZp8j09umIQmd2y6i+B5qS2c=;
        b=iQol54k9pYpeoYraRJiIPXkmALKAcuXyoWSIvRCqGj/XE+azPN53uNL0TlsNFeQuS/
         VNYXiYKWlZ8KzndwzieRLIYcCT0W9so1x3GUcRAjaV0QqXxdF6D6ZxUcoNAMtvUdyVUy
         J3T4ELFUrUMGgvtkJX3nMjnTZ5Npb8Drc3iHEFhSFy800xPJ6OlQFvebuOiUzOUgJHMr
         jmcA3gJ13e0mhzonF0YI1+BUXSLHLEFMxomHo1ygjBCB+J9gBZWv738JCDJeEMyYXOXW
         JM7/jzKv5oPvvu7UFuHlhG9TUaQue8pfC+JIbeSELVdDUnoznymhJL7i9KVef1tgK7Zx
         LsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742605488; x=1743210288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c35jq7Zk6VAC2p9swunNZp8j09umIQmd2y6i+B5qS2c=;
        b=UBOf1/y66OyAp1K6drZgbCUec+E9sxWlAxR6ymDR2QWmTW1bz4ayk64CJG2bWX7cr/
         s5azKPRdboQjVxjmWfH56SDRdU/bNRBe0fhssielQz25FmnAXLVwRb7vIP+cBlD4TDJD
         yqj4x2U8pcaFRDfgaK1/hAicaj5lkVbtXnRC/TgKR6Ik0raKjrzUxZUQ0H49HqqJr4/v
         iXDnVPXKWRtlrXwbSFah3aUqMd5MQl+N1ThBNWBY5X/8D3b5vrVXOGkNeCJ0dI8hIUVJ
         iBTkoE5E1k/p2Es1lNAZ20adHy5vQx8Zf8Prv3sPwP60BrPNr5qrx9YOPNmKv7u9uaO+
         TQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWs0Zb1VzOjXefU678yjU33Ok+VPns7WIj/1Tp2HuH2F+uRwnHyNVWS2Hc+qG3uxbmvqMBzajU7YyhBiei2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfN85/yiaQEOm5q6H0J2mAkAYnZwUNHN9C5ZdVcMq422Jmqoe0
	bBU9D+Z0pFbq0XHhBppLOkWlGh1yhoYA2Zt2g2GLRUnj1W774kxF
X-Gm-Gg: ASbGncs13uPTR6pnqvwOD2Vy9cN3Zue3dNmTJiSuvPDBbshgzpRf28lHTvY/nGDhkbf
	Z6QGF9BlkGKxMysyICGKykCmrzuS0f529m7kRs7sA8tAPsXk4edRifqQumPyQnHNWRJki5tfpv4
	8r3sXRcRgS+GcrcJoArmd6+iQ9bQLnMU54iTA/yTyMG4DwFD0jTNBwJxQihQk/hAoxhP0wv1PiV
	dFnE5mc4BEJBcQcGIomT6r+66FxkFVxazFQZlmYcLTAuNb1croiNa1m10OjRMMH3pXYGLvWcy5t
	IT2zthumt83Loe2Q363oQm7NvPFDLda5NGflX1XMf4ySB9BNlS3xA6lsvNYICNqFIA==
X-Google-Smtp-Source: AGHT+IGwgm/iem66z0f29AU0aiEjc4aN+XSZ83V3BdggHxqxoQdD5aHTSOOQXyr9ICwMM4Rwy4qg6g==
X-Received: by 2002:a17:90b:1f86:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-3030fe83c21mr8500288a91.8.1742605487804;
        Fri, 21 Mar 2025 18:04:47 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2aefsm24515665ad.109.2025.03.21.18.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 18:04:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:04:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <Z94MrEM/wM3G72pf@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250321154922-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321154922-mutt-send-email-mst@kernel.org>

On Fri, Mar 21, 2025 at 03:49:38PM -0400, Michael S. Tsirkin wrote:
> On Wed, Mar 12, 2025 at 01:59:34PM -0700, Bobby Eshleman wrote:
> > Picking up Stefano's v1 [1], this series adds netns support to
> > vhost-vsock. Unlike v1, this series does not address guest-to-host (g2h)
> > namespaces, defering that for future implementation and discussion.
> > 
> > Any vsock created with /dev/vhost-vsock is a global vsock, accessible
> > from any namespace. Any vsock created with /dev/vhost-vsock-netns is a
> > "scoped" vsock, accessible only to sockets in its namespace. If a global
> > vsock or scoped vsock share the same CID, the scoped vsock takes
> > precedence.
> > 
> > If a socket in a namespace connects with a global vsock, the CID becomes
> > unavailable to any VMM in that namespace when creating new vsocks. If
> > disconnected, the CID becomes available again.
> 
> 
> yea that's a sane way to do it.
> Thanks!
> 

Sgtm, thank you!

Best,
Bobby
