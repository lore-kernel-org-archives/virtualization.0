Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4261D63F9
	for <virtualization@lists.linux.dev>; Fri, 28 Mar 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178048; cv=none; b=o0DsmKYwLtJk4QqypdQaq8ngPfEPC02FJ46cuEBRLVXoJ5QJV6s24yTFTHAlmTx+T8Rcpi7Yi74NQ+Mtr4tAbiw9frKBvY5kyIaRgua7iBHJroHX1AmQCUdoHkoEMNdszA7yE718X8RWvD3jm5rjupdEDuQsJlOzeheeQpgbUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178048; c=relaxed/simple;
	bh=c0j910ZiAZFrp/s4+c6ipOgzsstZTwOsE/TkukqWNqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVAdnAL2xKQ6pExTSU3Zb+EwrqMDmYY6u/NXoVn+rw2FIvBfdKYWqsD5AtXM1Agdv0M86iE7P00USt72MuA/y1jLY42xZA1RqsPrLCrVuz6dFupvo0B7MfISyv5fkpYo8O9yTuVBKMfOjZECXxk5Nq+fGa4qNztibUvBan9jRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anaEgKcW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anaEgKcW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224019ad9edso10005845ad.1
        for <virtualization@lists.linux.dev>; Fri, 28 Mar 2025 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743178046; x=1743782846; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxAOXk/S249RiBgrNfpXKllNIaswYYUKjL6n0ffpSMc=;
        b=anaEgKcWeL7M99OQwp/MJ+wZ/eCWxJa0QUF87/I67oAXH7lYc5FTJG80CQEW0h8xLA
         eYJz0FrXae/wFfteO6VhOA3MLyiCsjx1wyoShNc4Ke48T4hjejynL5dfIBn3bqwNyR/H
         /lkSu4a5HcbTLbfUW4AxKhSYGn/1cjqGcIxjRdHLzW709G0shAaGnCTi8E3K1nS808Ul
         ZyU66gPVCEej0/R76vMxSsowHpD14MeWwzkLEpXSTr8JGQLuZLSo7i0Q8t1NHuX0OzUJ
         cbWyxgAHFAQrQ8S1gx9MIJiRIhJF6yRFgk+zApSxegWE8lj+JuDR1UCyanyQOpBend/d
         0q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743178046; x=1743782846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxAOXk/S249RiBgrNfpXKllNIaswYYUKjL6n0ffpSMc=;
        b=LJB7eVyQ3pXvYeNG2eflNJ25lUof2GUUuUTeLmETNqPccTcjio27FiI20ijk3nZTIh
         8EBgykeEmrTAwGuqnKc/KnvVGv5peU4Z4f4Cf0i+gN1kgE/HS5Lv5RMje+nhB+Tqew4s
         TtsTF6rJpjZeAbWY69D3vmugdpV6xFMFB/dfvZfFMJ4ix1A8/h8nXN/BsMsdwy1z/kzi
         goguPrfJTm3MjoumkNMuCWHyENvgSP2vWX6ITYghgL8LDOZ90+/XmufgElwBX70p25xs
         4O3L6BwA1xxryk/em+SuNV18WD+00gpVFWnjUQkmV4TsLZUrKBHkShzMOzDVN+Kl/adN
         Yd2A==
X-Forwarded-Encrypted: i=1; AJvYcCU6wZalgNkp+dmVQNnz8o8dNzTe31sMkiS+BYovr2q3t9nt1m7U7ZJ7vmnuyu07zhIC7solXJGHzxyNmKzBjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnogYCPAYHo2LchEk195he7S/gT/EQnhBM7nSlmnYIzKxiqGDA
	D9G9StO1N69+seeu7fDTTiDsYLD934YK28YsvFno/s5//LqYtcanJsVbjJe8
X-Gm-Gg: ASbGnctxmk74LR2IVX6GctH2hK92hoXraDFW9w/2j01u4ToiaWKgBkGSx/656181Bp7
	PsOQo/4XJs9/6qalvoTBYyYXXlshBWmPukaw4+nVxvtpQodBOlFNTmDEBWoolnD/SUIjHwaRUuN
	C50kM+9WlYMxfCoff+ikj3dbBn2RDOw3wIlzRL4vdmW4FEDah+R9LDEs0GZUHU1HYu9FuP3HkK+
	D73AFtvTFcxXXrmFkBlpUFJupOWZTerOJExLFDcULQlJEfwJFOg26MVdDqg6QRMA3ROBFeUdVv4
	+0rUKrGq3CvKobChR24v/xdFBKr5Bi4JoODsXIwCeIlnuNmkKTzPRmh4jT4byqSfbCLrbpmt/Jb
	l
X-Google-Smtp-Source: AGHT+IEjbz2Ou03FHxBjKejC/IRYMYdYwsO+YNVeP9ZUf4AV2d+oVINxue2W6u0U4PeII/VOUsW2Uw==
X-Received: by 2002:a05:6a20:43a1:b0:1f5:889c:3cbd with SMTP id adf61e73a8af0-1fea2fa20d9mr14777935637.35.1743178045644;
        Fri, 28 Mar 2025 09:07:25 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b8ad858sm1800451a12.60.2025.03.28.09.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 09:07:24 -0700 (PDT)
Date: Fri, 28 Mar 2025 09:07:22 -0700
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
Message-ID: <Z+bJOsG457Vg/cUu@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
 <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
 <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>
 <aqkgzoo2yswmb52x72fwmch2k7qh2vzq42rju7l5puxc775jjj@duqqm4h3rmlh>
 <Z+NGRX7g2CgV9ODM@devvm6277.cco0.facebook.com>
 <apvz23rzbbk3vnxfv6n4qcqmofzhb4llas27ygrrvxcsggavnh@rnxprw7erxs3>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apvz23rzbbk3vnxfv6n4qcqmofzhb4llas27ygrrvxcsggavnh@rnxprw7erxs3>

On Thu, Mar 27, 2025 at 10:14:59AM +0100, Stefano Garzarella wrote:
> On Tue, Mar 25, 2025 at 05:11:49PM -0700, Bobby Eshleman wrote:
> > On Fri, Mar 21, 2025 at 11:02:34AM +0100, Stefano Garzarella wrote:
> > > On Thu, Mar 20, 2025 at 02:05:38PM -0700, Bobby Eshleman wrote:
> > > > On Thu, Mar 20, 2025 at 10:08:02AM +0100, Stefano Garzarella wrote:
> > > > > On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
> > > > > > On 3/12/25 9:59 PM, Bobby Eshleman wrote:
> > > > > > > @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> > > > > > >  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
> > > > > > >
> > > > > > >  	vhost_dev_cleanup(&vsock->dev);
> > > > > > > +	if (vsock->net)
> > > > > > > +		put_net(vsock->net);
> > > > > >
> > > > > > put_net() is a deprecated API, you should use put_net_track() instead.
> > > > > >
> > > > > > >  	kfree(vsock->dev.vqs);
> > > > > > >  	vhost_vsock_free(vsock);
> > > > > > >  	return 0;
> > > > > >
> > > > > > Also series introducing new features should also include the related
> > > > > > self-tests.
> > > > >
> > > > > Yes, I was thinking about testing as well, but to test this I think we need
> > > > > to run QEMU with Linux in it, is this feasible in self-tests?
> > > > >
> > > > > We should start looking at that, because for now I have my own ansible
> > > > > script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to
> > > > > test both host (vhost-vsock) and guest (virtio-vsock).
> > > > >
> > > >
> > > > Maybe as a baseline we could follow the model of
> > > > tools/testing/selftests/bpf/vmtest.sh and start by reusing your
> > > > vsock_test parameters from your Ansible script?
> > > 
> > > Yeah, my playbooks are here:
> > > https://github.com/stefano-garzarella/ansible-vsock
> > > 
> > > Note: they are heavily customized on my env, I wrote some notes on how to
> > > change various wired path.
> > > 
> > > >
> > > > I don't mind writing the patches.
> > > 
> > > That would be great and very much appreciated.
> > > Maybe you can do it in a separate series and then here add just the
> > > configuration we need.
> > > 
> > > Thanks,
> > > Stefano
> > > 
> > 
> > Hey Stefano,
> > 
> > I noticed that bpf/vmtest.sh uses images hosted from libbpf's CI/CD. I
> > wonder if you have any thoughts on a good repo we may use to pull our
> > qcow image(s)? Or a preferred way to host some images, if no repo
> > exists?
> 
> Good question!
> 
> I created this group/repo mainily to keep trak of work, not sure if we can
> reuse: https://gitlab.com/vsock/
> 
> I can add you there if you need to create new repo, etc.
> 
> But I'm also open to other solutions.
> 

Sounds good to me. I also was considering using virtme-ng, which would
avoid the need, at the cost of the dependency. What are your thoughts on
that route?

Thanks,
Bobby
