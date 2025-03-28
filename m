Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F431DE2B9
	for <virtualization@lists.linux.dev>; Fri, 28 Mar 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743192813; cv=none; b=J7c9DmueTPaM2uyCQdEg4p5+89S/g6hGgWy6XD9vQMBjWRzZJXKiL51l3hFtQ7UIrMdORe1ojbU5nKiYgkxN1v/T1y+s8/c5T3ytE5jWZPZKQ+WCo2vbJOpJ47U03Wj2j8aO9OpI2iE+mHD5sWdKdPR8n7RNtxX4Lx89La/Bmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743192813; c=relaxed/simple;
	bh=OB3VnTMKOv3NvHsPD/ooOu7eM5k0ehHaCnOgt0T5Jaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXxb3FQf2l4+8mvAKWT0Avzp4JH/00o5XbD9PHCGFqWXewKv0PPUUc4RlnAu0ii/8LpT3AwNdcyMZdfkaKV8BaXpW744aATZhX1ViP3z8Sj+cQrDGdWLRanwmQ6108aIDdChSLEunZfyKoKwbf2WtI1lYvAG3gr7PdQS08rlyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajb8mq4a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajb8mq4a"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223f4c06e9fso50440975ad.1
        for <virtualization@lists.linux.dev>; Fri, 28 Mar 2025 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743192811; x=1743797611; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9FbjKIWjSUx83a1FAFt0nY/L0eU4FihK1314GKPDwM=;
        b=Ajb8mq4a4nMn8WbQeLJ6Aq5UuGWPLDWPljBdVs3fvjrE8iNfIR3nv374qc/WNTTqtJ
         L87DvO4QW8lVY5RhzgIFKWxCZiHXkDAKM9M6gY4CWnr4YV8Nssfr3zuIo/6GCTzwZN53
         X7ZeeJ0KdMEE1nTdI+XWDR04SauS50XDlPJ5M6EX1bTVDBxwOWgPcfAxSdgXTQ33pucQ
         af+0MhDPEjYQ8Yj0yKAYKxYg502MSS58VAvfUZjKLxEXtwYVjKYrFV/PZc0eHZCOkjTR
         kdRQbAvu9WQtk2c4qKNgVE1rEoHgYR60CXHFLxAWfYCGJ8gLm2VvDksEzZkE3Lu71iV3
         R80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743192811; x=1743797611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9FbjKIWjSUx83a1FAFt0nY/L0eU4FihK1314GKPDwM=;
        b=XyOBaffzvpAM/oRWRL/JWEiuf7bMl3fbKnPhguzSyvBCHixxuBEfPP65VpgOCF5VC6
         ZsrUDxB0wSQOCq/VC5v9QSQHYr/EL1NL4mRizGWTiEVBi9sTc5qiTi7LOHmzAaf6Zgeb
         FBbWmA1cXthb67xLQ2KuPquZdrcswtUlDBZwp90lCEiTdENswof6D6AAIJoAgs2ug3ZN
         BAvm+EctBLJcJPXfC7Q1xErhgbo0SacPgAXEFMsyE1CruZf82wD62QFKhevHziTFNsl9
         jvTLXiFv+RgYON9p/XmJXjJvTgETHYJCWxeFb8kjkJGGF5fpnCooNc8E9hIBh2dQbq9n
         7OIg==
X-Forwarded-Encrypted: i=1; AJvYcCXk0E8OmsWDJKX61G3gUbbq56uxIZ2q7+nqpdYCacHqadly+x3dJy+sQUGjtGdmXTEZsoxbmFCyJ0m6nAN5Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznha5c5X602P56mqVxY9YS+eQ8wPasqG/fJzmcgyuIS/+JIA4Q
	44TV27yrW1wSGMZ0/0Ph2SoSk9PE+caXpsla6Q54+XImfj1PlfEV
X-Gm-Gg: ASbGnctct56LM63bGjlju9T3Z9W3dCshUksQwNjKfy3JvVId1zhOl52NMlVmxfTHjOP
	o7YBIzrqeYXjw3fb3/K9+H4bVXw7sAjODhub4Kc/MXEKQx5Zv0przzPTmp5IuOLRJMegk6FwOZG
	HjrJfsORRvxu4AK2AwB/EEGFRcQdbT+ZUCD7Sjn3LctSOIAKxCCr9WDvE67MVEf7ynD1uS+GqJW
	xvR6ozDN2aQGb6V8uHXmuw/IW3+e80nVaXzl7n06/wxqA/GyAzo7z0mNuESBTbaP/tgq7MdAj0k
	U+lbRbhu9cnHKOZfEvLFLGc697B4galOJojdys8kTzmDMil/UV614vh5gCSFpNiCCw==
X-Google-Smtp-Source: AGHT+IEVlsZyvNY4r63OPSrnhwbvzQpJ4Z//xsphK1YGE1Hs7KUnQ3mWfMpJsygRPArflHFRx+tdAA==
X-Received: by 2002:a17:903:228c:b0:221:751f:cfbe with SMTP id d9443c01a7336-2292eefd76amr13290585ad.19.1743192810734;
        Fri, 28 Mar 2025 13:13:30 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec53easm22919495ad.24.2025.03.28.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 13:13:29 -0700 (PDT)
Date: Fri, 28 Mar 2025 13:13:27 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Daniel =?iso-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
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
Message-ID: <Z+cC5+ngu1nMKmFe@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>

On Fri, Mar 28, 2025 at 06:03:19PM +0100, Stefano Garzarella wrote:
> CCing Daniel
> 
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
> I was talking about this feature with Daniel and he pointed out something
> interesting (Daniel please feel free to correct me):
> 
>     If we have a process in the host that does a listen(AF_VSOCK) in a
> namespace, can this receive connections from guests connected to
> /dev/vhost-vsock in any namespace?
> 
>     Should we provide something (e.g. sysctl/sysfs entry) to disable
> this behaviour, preventing a process in a namespace from receiving
> connections from the global vsock address space (i.e.      /dev/vhost-vsock
> VMs)?
> 
> I understand that by default maybe we should allow this behaviour in order
> to not break current applications, but in some cases the user may want to
> isolate sockets in a namespace also from being accessed by VMs running in
> the global vsock address space.
> 

Adding this strict namespace mode makes sense to me, and I think the
sysctl/sysfs approach works well to minimize application changes. The
approach we were taking was to only allow /dev/vhost-vsock-netns (no
global /dev/vhost-vsock mixed in on the system), but adding the explicit
system-wide option I think improves the overall security posture of g2h
connections.

> Indeed in this series we have talked mostly about the host -> guest path (as
> the direction of the connection), but little about the guest -> host path,
> maybe we should explain it better in the cover/commit
> descriptions/documentation.
> 

Sounds good!

Best,
Bobby
