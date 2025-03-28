Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D01D4356
	for <virtualization@lists.linux.dev>; Fri, 28 Mar 2025 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743192902; cv=none; b=FzBiQCjG5er6FAM8ORXiQPSFDCwkfBEDCVbMHdIxKDUdfPWEdwqFevbEx6I3bX4q75ins7ATZcOd98lni3oVt3KtM1hg+B/tqJjlCv0J0PhRvBdZhK7YyXZyhRH3637TRBTfE+9vPYPyQen/J7xFcE5+1yuFGxYlkv6/iLoNtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743192902; c=relaxed/simple;
	bh=pJMjQjWVDeywadOsaTgmup6GpKyj9JDB+t9KWtcJj/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fwx5isM3jG2baOkhHe9g+z3hKdIoarGMhCqMXQW5asDQuiDbHBIOblD37BP7lbfIPAJ5xD7V+ZUW7OM6KnkpR9PziXXMjb+1+rbw1oar/0y3U9t0nYW0WR1LqgbQeDBWjrmC8EfQepGG1CoGbUHCtrTyP4VUEpaVsPoCMISyfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6EUBRF9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6EUBRF9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2243803b776so16954135ad.0
        for <virtualization@lists.linux.dev>; Fri, 28 Mar 2025 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743192900; x=1743797700; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytSt5nyniCNVmizjfTwiWa0OGl8PzPbyb3HIq2epauA=;
        b=H6EUBRF9/GgvBbWCbiEvxutoOGbop0GUL6SpVEM5aaJJ+IuuYeAQvfFBZHq9yunVBr
         MuA9ZNDqliikaJFatzxaSaKPnsW4tgJFvfz3Z6saQ2MC8Nxddgm42xG+4Ok/ze1zfWdd
         bPpTfiM6OGg34j7JIpbF82UckAzlmarmyT+8Slf8FWHIIlTe2VYul7PDAXzamRzqkL+k
         RHyhBwzKhfzybN3tNJZRwDXjYIBY/DwPXlktDLdMC1TtEhLhWseVsBpm4VEGmkrmxUfo
         Mz45on8PDMhAfYmVGNhhtF7G4oRKyHFkhbaYgz9cYcncP1mUHnyEuaRiykJv/U4QzkPp
         fMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743192900; x=1743797700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytSt5nyniCNVmizjfTwiWa0OGl8PzPbyb3HIq2epauA=;
        b=oyuHeDh3ONrCbFl01IgoeZu4Iy9xA4JRNlQTZdhVZ3mXw7d8v9B4BVPZtHjDHFgLQu
         xRkO/bKqn9W9eeYgV7/l2LFPkqVt5dIyd1htnfX6cQYJ+R59qqhGy7YMaIYGX3WpdcbG
         2xKJ8pMcZb2tzLs9eqmfUm/N47oPihEqDlplfMmqo8vcJ0MI2tcMxeomlDB1gqqrxiJr
         9DEktyQ3oN+pmZzYqxyZc2jUWfWt70P1dW6SUmIZ7+eHokDmFg4Ljld9se05TwrhKYue
         d2IJms2zTAGrYU6mJnkVrAuta/4SD7T9GNva1UcsCygEpxmXCIChRr+Lxd5bKJbruOiq
         gtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqY9CVcE/fN9QBg598ArdBfFLCnfnX8QXXIy3JbHfvRlHEuKygnVCcVFS0PkBj15XuEO6Zpj7tOC4Lhh1qtg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz3gL1VIgsTPwcO+J4qfNVjs6AXYBkMpNm6GDJrHMlZddQM1te
	gEKijIEorfYm+aRK43bvQmKbS9CDqg5riUNxw/kre3qhrQVffgBG
X-Gm-Gg: ASbGncuV9jWInjOlSEbdxvZWm8CgPH8g+Mc9UNlSQ+Ajedt/n7UQzaSLud21ZrW0x0x
	A/snZjp+xyt5Eu6zNM7IDSBrn/x8pTeiHXpxitFYe9T7N4OMo0RfONhDFqpDqQGaVU5ifD4YMef
	NZe9bOcgE1dmPQXVtqAJrh0Yy/Q05vrVzvyFu33cELqiJqY4WGS+oeTOXFlIZZWcWW7kqByhDpW
	eulWQv7KrojvKCl7TVMqxRUBf629ACf3gok3ziKdLPsRxghLx6wB7Sx7YJgbZ4UfdBTB6lc7vr/
	ufidc98M4faWQzGqQDqY0J74GdLgKdADpZ56mVcMSaDHuZIkePdzwKtUDerxEuVW2E0=
X-Google-Smtp-Source: AGHT+IG3V62sPzgz2xRNNE+uQm5daMt0XJ7v3b+sinEmZ97UyPC/XNV9Rm0e5/8hmIrydE+Rm3fk9w==
X-Received: by 2002:a05:6a00:b8c:b0:730:8a5b:6e61 with SMTP id d2e1a72fcca58-7398033a575mr716156b3a.2.1743192899756;
        Fri, 28 Mar 2025 13:14:59 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e27b97sm2314410b3a.62.2025.03.28.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 13:14:59 -0700 (PDT)
Date: Fri, 28 Mar 2025 13:14:57 -0700
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
Message-ID: <Z+cDQQtp/80V8Tbr@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
 <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
 <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>
 <aqkgzoo2yswmb52x72fwmch2k7qh2vzq42rju7l5puxc775jjj@duqqm4h3rmlh>
 <Z+NGRX7g2CgV9ODM@devvm6277.cco0.facebook.com>
 <apvz23rzbbk3vnxfv6n4qcqmofzhb4llas27ygrrvxcsggavnh@rnxprw7erxs3>
 <Z+bJOsG457Vg/cUu@devvm6277.cco0.facebook.com>
 <3qjjlbwyso22n4ziylbeunfwpc7gl3rcin6v5qsr2npjfkbfjh@c745sejq6rig>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3qjjlbwyso22n4ziylbeunfwpc7gl3rcin6v5qsr2npjfkbfjh@c745sejq6rig>

On Fri, Mar 28, 2025 at 05:19:44PM +0100, Stefano Garzarella wrote:
> On Fri, Mar 28, 2025 at 09:07:22AM -0700, Bobby Eshleman wrote:
> > On Thu, Mar 27, 2025 at 10:14:59AM +0100, Stefano Garzarella wrote:
> > > On Tue, Mar 25, 2025 at 05:11:49PM -0700, Bobby Eshleman wrote:
> > > > On Fri, Mar 21, 2025 at 11:02:34AM +0100, Stefano Garzarella wrote:
> > > > > On Thu, Mar 20, 2025 at 02:05:38PM -0700, Bobby Eshleman wrote:
> > > > > > On Thu, Mar 20, 2025 at 10:08:02AM +0100, Stefano Garzarella wrote:
> > > > > > > On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
> > > > > > > > On 3/12/25 9:59 PM, Bobby Eshleman wrote:
> > > > > > > > > @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> > > > > > > > >  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
> > > > > > > > >
> > > > > > > > >  	vhost_dev_cleanup(&vsock->dev);
> > > > > > > > > +	if (vsock->net)
> > > > > > > > > +		put_net(vsock->net);
> > > > > > > >
> > > > > > > > put_net() is a deprecated API, you should use put_net_track() instead.
> > > > > > > >
> > > > > > > > >  	kfree(vsock->dev.vqs);
> > > > > > > > >  	vhost_vsock_free(vsock);
> > > > > > > > >  	return 0;
> > > > > > > >
> > > > > > > > Also series introducing new features should also include the related
> > > > > > > > self-tests.
> > > > > > >
> > > > > > > Yes, I was thinking about testing as well, but to test this I think we need
> > > > > > > to run QEMU with Linux in it, is this feasible in self-tests?
> > > > > > >
> > > > > > > We should start looking at that, because for now I have my own ansible
> > > > > > > script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to
> > > > > > > test both host (vhost-vsock) and guest (virtio-vsock).
> > > > > > >
> > > > > >
> > > > > > Maybe as a baseline we could follow the model of
> > > > > > tools/testing/selftests/bpf/vmtest.sh and start by reusing your
> > > > > > vsock_test parameters from your Ansible script?
> > > > >
> > > > > Yeah, my playbooks are here:
> > > > > https://github.com/stefano-garzarella/ansible-vsock
> > > > >
> > > > > Note: they are heavily customized on my env, I wrote some notes on how to
> > > > > change various wired path.
> > > > >
> > > > > >
> > > > > > I don't mind writing the patches.
> > > > >
> > > > > That would be great and very much appreciated.
> > > > > Maybe you can do it in a separate series and then here add just the
> > > > > configuration we need.
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > > >
> > > >
> > > > Hey Stefano,
> > > >
> > > > I noticed that bpf/vmtest.sh uses images hosted from libbpf's CI/CD. I
> > > > wonder if you have any thoughts on a good repo we may use to pull our
> > > > qcow image(s)? Or a preferred way to host some images, if no repo
> > > > exists?
> > > 
> > > Good question!
> > > 
> > > I created this group/repo mainily to keep trak of work, not sure if we can
> > > reuse: https://gitlab.com/vsock/
> > > 
> > > I can add you there if you need to create new repo, etc.
> > > 
> > > But I'm also open to other solutions.
> > > 
> > 
> > Sounds good to me. I also was considering using virtme-ng, which would
> > avoid the need, at the cost of the dependency. What are your thoughts on
> > that route?
> 
> I just saw that Paolo had proposed the same, but his response was off-list
> by mistake!
> 
> So I would say it is an explorable path. I have no experience with it, but
> it looks like it could do the job!

Sounds good! I'm currently prototyping with it, so save for unforeseen
issues that will likely be what v1 uses.

Thanks,
Bobby
