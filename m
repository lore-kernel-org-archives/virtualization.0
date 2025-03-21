Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016A14601C
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575411; cv=none; b=WyEW5E5u3EBeESttPU+rYVElMVP3D5NPxf1vM5fV2H9htAHRYzpJeaAH2bwqC6aS2Ne9s07hzOrinFDOssptR0dCj48TldKasuR+r4rzAtAGjxT8ov9+eFXZcynazQXuzqnAzjBNMkT188QizTI17W45sqEAFpY9inFFw79qwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575411; c=relaxed/simple;
	bh=q8gY0EHYv1f0SNCN1IiS93/JbkcsovraFqehXvDUYac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0w379Fa5utKDQb+/69y+Ut8tVJD8lmvvqKnY/rs6ZGo+eV6+0YOyGZLUwZWsG1auCwB7vjxCAY0e8DeNp4ZfuNnVFkcXcXQrIx7y1ky+B62BC11NcA1wCAo5HVw0XmrboFUlCjQ1iHH/oFZ9thARvuoB4YGO7yDroE30C8OxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co3WYOzZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co3WYOzZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239c066347so53179785ad.2
        for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742575409; x=1743180209; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aJTPH+1xMkR4Zaf05Ht/L3jxae3E9cyEnH7B1bM0G0=;
        b=co3WYOzZ1zgO5Mi8Yt/lyiDIOiyOG6r/s+1bfl+pf93l/EPm4k2D7Bay9j/lWSwXY3
         3EESUAYhhDyKEb3a+pehhm6syg30zMezl69JbgL3df3ODgbgItrcDlnudcOP+QVWR6Yr
         V7YTEPzcqOpCRMoSiqGK8mnIya3aDlnzmvP15Pdlhzo0kR0msEFWrstMNg/4nz7Ee2vB
         EWRbstEYbUaOMMMeZiacE9TpNNQrWfiD2kyciPLdLIKO5/quHzEA0JuUTnY4AiynHYey
         z4b+ypYwVQYCc3K+GTYhY3n3t4btTqnPw8WlNbs+hRrNXXaXmpJdgh/ohrh8dMOoDKje
         8x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575409; x=1743180209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aJTPH+1xMkR4Zaf05Ht/L3jxae3E9cyEnH7B1bM0G0=;
        b=aV6gWtP7CA6LwUSb6BREQzUA3qx9yl4RfRP73tYyUEwgkRwwFM6C/Fw3ThZBwxZETS
         8jlRfXUhbAoNHRXA6F6pcSmkniANLGpCmlv7JTv9UWrLVX0fBdmY4fdu1Qu3dvJFEHDC
         cAu27wBgaYP68x7o2ripUXjdvg30Krttg4omrJHWJgve2DusJd7FKgs8xp6gUjMxik4u
         k4MrB95LKyjD6bS9rD1LhgDo25Yxx5ydhsF5j1pI8GzAgzDk3vaPtJ0JQj50BKxXrZJP
         Wy2OHzTa1kMyI58BiVnmxO4X0QQuDyUHBAjcXRtMPPD1CMrS5zSGtRBIdsYgbEc1FozI
         HyYg==
X-Forwarded-Encrypted: i=1; AJvYcCUpbWyOKPWpHnZCyb4+ZNmLkwOXRQAhitJULqxqfTCNXS+RHhQdrCws3B76I9nCK5ko+BMLqT0IYGDAHYmPXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4WLWytIpT8+QI7gnk0YDJBSNWjREE6DZ5q1ph1jp7tDkVc9D8
	c9QK93OGgZW7b97ziaOLRhnLBRiQO2E/fbBJTJGV5Gvmn7PYkCfd
X-Gm-Gg: ASbGncsZWqd8D9e9bP/bH4CaPFubmurmedBdQieZiA0Aedzyr6B/FDEkkJ57HwO418T
	hlBIejE07TiD1erChLHoukzq/e0Udqs8ZncZ1pCBg2kcJzmbXrMxCHucxmr6kK7oofr2TA3bPMa
	wiEKMuF55mA2Z+aIvGenvInyXCBOh5yIuiJWhIEaFekDBV++/5OaXEQFFuAE6BTlNSxn1c8WhJE
	jT8Lkk+FUbdAllQtOGAxpI5lBKeHbBaK5F34nIxcnBnEkDRpbTvcsB45yxdn6T7ysW+rtmtS4vO
	gGGS48okG1LjEkjQrrQydqYFjOo9c17c+hzuXZ0WJ6XFOCYg6dhppGZnv4H7YzgQFQ==
X-Google-Smtp-Source: AGHT+IENp6UIAwlpkbF6We8IKTNIq+1iFjd3EWQYgWjKi8R9GSQ9a0yFuxD7FT/yHfceTqi0iUTpuw==
X-Received: by 2002:a17:902:ef12:b0:223:88af:2c30 with SMTP id d9443c01a7336-22780d8cfeemr57519585ad.16.1742575409441;
        Fri, 21 Mar 2025 09:43:29 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2b30sm19212985ad.120.2025.03.21.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:43:28 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:43:26 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
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
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
Message-ID: <Z92XLufHveVjpI43@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
 <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
 <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>
 <aqkgzoo2yswmb52x72fwmch2k7qh2vzq42rju7l5puxc775jjj@duqqm4h3rmlh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqkgzoo2yswmb52x72fwmch2k7qh2vzq42rju7l5puxc775jjj@duqqm4h3rmlh>

On Fri, Mar 21, 2025 at 11:02:34AM +0100, Stefano Garzarella wrote:
> On Thu, Mar 20, 2025 at 02:05:38PM -0700, Bobby Eshleman wrote:
> > On Thu, Mar 20, 2025 at 10:08:02AM +0100, Stefano Garzarella wrote:
> > > On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
> > > > On 3/12/25 9:59 PM, Bobby Eshleman wrote:
> > > > > @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> > > > >  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
> > > > >
> > > > >  	vhost_dev_cleanup(&vsock->dev);
> > > > > +	if (vsock->net)
> > > > > +		put_net(vsock->net);
> > > >
> > > > put_net() is a deprecated API, you should use put_net_track() instead.
> > > >
> > > > >  	kfree(vsock->dev.vqs);
> > > > >  	vhost_vsock_free(vsock);
> > > > >  	return 0;
> > > >
> > > > Also series introducing new features should also include the related
> > > > self-tests.
> > > 
> > > Yes, I was thinking about testing as well, but to test this I think we need
> > > to run QEMU with Linux in it, is this feasible in self-tests?
> > > 
> > > We should start looking at that, because for now I have my own ansible
> > > script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to
> > > test both host (vhost-vsock) and guest (virtio-vsock).
> > > 
> > 
> > Maybe as a baseline we could follow the model of
> > tools/testing/selftests/bpf/vmtest.sh and start by reusing your
> > vsock_test parameters from your Ansible script?
> 
> Yeah, my playbooks are here:
> https://github.com/stefano-garzarella/ansible-vsock
> 
> Note: they are heavily customized on my env, I wrote some notes on how to
> change various wired path.
> 
> > 
> > I don't mind writing the patches.
> 
> That would be great and very much appreciated.
> Maybe you can do it in a separate series and then here add just the
> configuration we need.
> 
> Thanks,
> Stefano
> 

Sounds like a plan. Thanks!

Best,
Bobby
