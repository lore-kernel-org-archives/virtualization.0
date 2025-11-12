Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27258202C48
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975976; cv=none; b=UXU8faLaB2qgbeqW6gDfddVyFZtM2GxjMgjrBTPfGsHEPlZXAIwYm8CbZ5nlhxVFGWzbVrukkMwpT43vEOaGSYQ6oMEvfs22coZGfar+EzXMW9fsxN9weMw9R52GGAmqb2Zso7y2Tt9aAXEp0iS2u0C4HiDn0nWXLY1mPEvDOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975976; c=relaxed/simple;
	bh=SUUhDfoBmuPhmMw0GL7Ir4bt1svau2Ajo0eTYsuBFqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbJ64XIv1pP0LgB1/se/cpSudvtDePNNPuDLAvBMOA5W+WTPXDDzdVg6a5tGJucW/RAU+lVv9vHNqSsFJrtJ3bJrPocC+a5xMIA4wEWt6MOcdIM4ct7t9A5Yk0r6Io+JFUWZKWe8/LnsoLbh9nP6y5G7dlp/0sOD7NckjjylTww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGm5Ivv/; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGm5Ivv/"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640e065991dso1729754d50.3
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762975974; x=1763580774; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxubWASL3+7oeSYOF8cRfS3IaF1lf07GjfI/BFusVlo=;
        b=fGm5Ivv/Dz034TaHzjSVyhGkAZMVvyEsgMT9sYTbduAhB9Edpf2bem5UeW+X8Pm58X
         ksjCuWxUWcibk9ypiM6tTh8JopoNSGlTqC9xwr2iexytDYcoJBuYyGXATvtl/Dnj6hXE
         Kl9j81gH83ge6QR7WjFaFPBUMYqzv4f5656mGjUIF8sdl9MSFEEehOBQ5x3y5ns+IKcP
         z585BVWtemomJd49a+o5oeOX06vNJbfS8PtHkLLWIffVP6t7reNDuzs3gNP6rUpADFjT
         wjs+8POPiRZp0C/lXOiHj5ZUhHzLne5pQ/xLf1JhFnljwinpVwjP18H+PScvCBh8ew7B
         3lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975974; x=1763580774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxubWASL3+7oeSYOF8cRfS3IaF1lf07GjfI/BFusVlo=;
        b=rzr/nEdVFUtAvjC/B+ftiyKl8VKv2FilOLhno6eeWripc04wlheDiFQPSfo32UmT10
         1VUipIm0bqF2juPPLxj2l7bBq6Zm5hU+TczmKP21JoS13TXQJO8RHqRTUnhqVCzvwawl
         dp/XqU8/8FYa1zCTnnbUXlJEX/28mPM3o1z9DWaZixSJO6UwL4MxgpiC28GaewXgr0pL
         d3XO5RbLvrwZryEkq12DCP4pu1nYh6rbpZ6egyLMVvVwPijT3urpi8J1CnfycBLfTdsK
         /tJPzkiZ/s7eDC95xRspbLBsva/N89JOJi9HQv9wmxLo38nyZRWYfNvxBIW+7HVZjO1Y
         I84Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4cvLQ2wBq1UnfQ5GA0GFul1hrSj3+uu9HsDvLZVoufb7fikNGKtb+bSguA3Z8+VP2D5CPh9WzfXbsa1+vsA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3E42k2IwOOFgM0vIHCrlHRaSv2qqjZ75zkQrazIm71dntkX5k
	71wS62Mm7npU8eTnHr4DSkQVBI1Oan6ElRGCNqG72wHA+LHFIq0DXSbg
X-Gm-Gg: ASbGnctVRRAYo+84pCQt/5cS51ypRpmifpXvmXW24mmfF35+Nw8xr8SVONNmD/aHDoa
	qFlW6ZJx40/iouXJcgY1sDqaOj5kJ/dx1etEMNp4ni7AWXqUYptFx9Jyswc95sFXicrrrS28DjB
	tE3TegfETMln/6Vzw4gOXkSr1ZZKiUv9k8MVG1f/mpFfIIYrTYWTe9V7Hw6pLHdICf+7CAdkxMR
	9IradCBTvkcn38VHQ6RJORivVbaCHxEi8s2RTliNgbxO6dR/WKA95QsXG/EKWEUVSqKkjpcIxzc
	A1v/cELS0xkmjaWFeh3Wq2+bduMDS2SKELdI/S1uJcDtk6jrk6OPdcbvIdybZMoAVnh6GbF9ZMz
	YXxAs9VN/TKQFMumThcYvnSPVhHzs5ljC8gzAU2o6yYE899Byv2cQvdWpEbHVtmPqkj+elIhsAN
	tYcnPRo/wp25UJJiGLx6VA/gMZxR8tJeiKyWPd
X-Google-Smtp-Source: AGHT+IG4MyRZebV1Szufgtc9uf8er54fQt94boVEX+HeLHRTnsDHzaHu6bkb0vk12BKBHmbmHT/a7Q==
X-Received: by 2002:a53:b10f:0:b0:63f:a818:6d34 with SMTP id 956f58d0204a3-64101b29733mr3157363d50.32.1762975973985;
        Wed, 12 Nov 2025 11:32:53 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-641015aece9sm1236185d50.3.2025.11.12.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:32:53 -0800 (PST)
Date: Wed, 12 Nov 2025 11:32:51 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 03/14] vsock/virtio: add netns support to
 virtio transport and virtio common
Message-ID: <aRTg4/HyOOhYYMzp@devvm11784.nha0.facebook.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-3-852787a37bed@meta.com>
 <cah4sqsqbdp52byutxngl3ko44kduesbhan6luhk3ukzml7bs6@hlv4ckunx7jj>
 <aRSyPqNo1LhqGLBq@devvm11784.nha0.facebook.com>
 <bhc6s7anskmnnrnpp2r3xzjbesadsex24kmyi5tvsgup7c2rfi@arj4iw5ndnr3>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bhc6s7anskmnnrnpp2r3xzjbesadsex24kmyi5tvsgup7c2rfi@arj4iw5ndnr3>

On Wed, Nov 12, 2025 at 06:39:22PM +0100, Stefano Garzarella wrote:
> On Wed, Nov 12, 2025 at 08:13:50AM -0800, Bobby Eshleman wrote:
> > On Wed, Nov 12, 2025 at 03:18:42PM +0100, Stefano Garzarella wrote:
> > > On Tue, Nov 11, 2025 at 10:54:45PM -0800, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>

[...]

> > > If it simplifies, I think we can eventually merge all changes to transports
> > > that depends on virtio_transport_common in a single commit.
> > > IMO is better to have working commits than better split.
> > 
> > That would be so much easier. Much of this patch is just me trying to
> > find a way to keep total patch size reasonably small for review... if
> > having them all in one commit is preferred then that makes life easier.
> > 
> > The answer to all of the above is that I was just trying to make the
> > virtio_common changes in one place, but not break bisect/build by
> > failing to update the transport-level call sites. So the placeholder
> > values are primarily there to compile.
> 
> In theory, they should compile, but they should also properly behave.
> 
> BTW I strongly believe that having separate commits is a great thing, but we
> shouldn't take things to extremes and complicate our lives when things are
> too closely related, as in this case.
> 
> There is a clear dependency between these patches, so IMO, if the patch
> doesn't become huge, it's better to have everything together. (I mean
> between dependencies with virtio_transport_common).
 
Sounds good, let's give the combined commit a go, I think the
transport-specific pieces are small enough for it to not balloon? 

> What we could perhaps do is have an initial commit where you make the
> changes, but the behavior remains unchanged (continue to use global
> everywhere, as for virtio_transport.c in this patch), and then specific
> commits to just enable support for local/global.
> 
> Not sure if it's doable, but I'd like to remove the placeholders if
> possibile. Let's discuss more about it if there are issues.

Sounds good, I'll come back to this thread if the combined commit
approach above balloons. For the combined commit, should the change log
start at "Changes in v10" with any new changes, mention combining +
links to the v9 patches that were combined?

Best,
Bobby
