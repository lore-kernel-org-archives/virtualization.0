Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABC376
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947915; cv=none; b=e3ndDGZzbKVWEUDICE1gOrlHL+L/ertKCoECAe9aiLGiMwkHE8NPO/7gKXyni4ph3aonUqQRzwYfiZrOZsQxxOgWEA5YTL4TtdCGWmdvCoIAuyLtyw4BMqPd/gMH8WjznpAIBT13spkh82p5aSqIR+Rn4BME09qgGEk1lW5RNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947915; c=relaxed/simple;
	bh=Ds5elK0EiYSgBbG1o5wtpaJmT1vD/nl22PdcXN437WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7jmJ44i2kCTuTtGzXwUzUCCfEL2hojtIWfSh2PEaMq+gLEzr91pCzduTX0QfKoiCAYYYsLx/uAmj/mMKy3dpckvQooHDXvfS28aQOUEs597KIwjjQleUeJenA0dZS8a3cnYrDTPj+nMOwbudgslr4nYXuv6yHDel/k7CmrE0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOGT+rCa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOGT+rCa"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22403cbb47fso123232485ad.0
        for <virtualization@lists.linux.dev>; Tue, 25 Mar 2025 17:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742947912; x=1743552712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CY8eIyZm61ckxiaVzTuPDCRXGNO6HtSN1mJX9W6zGQQ=;
        b=OOGT+rCaXu7mXIlc6fWPAZWz2IoI3cy/FJ4RIiGRGCSbvYVUDJhqc00h5Qe54w1Ko/
         nNdsK3UB+VBR4+UPDNOw9wZPa3sIJ90gAH/54nBJB2oyjS6W9hRoFPRiMcjrdtDL7AZE
         ie29dc4SuIGgHndIZD/nWVN5efnreeJZHFaaUnajOa3rfbOePmkbVH8EhQYqvMbvK1WY
         uzW7d5eyX+L2Zh1SPBiz9Kiow4MyQZs7OZc4NYv2p/Ts9FPN1owPxGMpNd/2l8jSApfx
         XUjBcEnS4VH8GzbcmWpb5Km/CjU5o7t75YtqypztU0MRuQ4UQmqtLg6HCWw9bWvuDaEo
         RQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947912; x=1743552712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CY8eIyZm61ckxiaVzTuPDCRXGNO6HtSN1mJX9W6zGQQ=;
        b=vYqXHkUDk3VIN1xxOLhpYxAOauwMd3Em3r1M1xFiqtJrKEz8OL+UDt4ZPKNtL01In6
         d52wNSoPazXu5MhaGHcy6RYLYDjBayKcag7sH09oHd9plLNF3CQ2Bp8rcmJ7dIUtQMoj
         ZFr3Xxc6Z7L2YFKV5lXnZqBaoZfy0XVRsOMt3cV3uREgQcEld0ADIDkZj61tx7iUYhbj
         O7u8e9HptW1IaGQt+RTfDlAA0VbjKfLWp59oSwhpMydRFRohu+aNqUiHJJrpGHl4SPa7
         YXQXDlnrgALpZx50RRlULp19kkjpG6nfjI0tEQX8f6AcNERLjBgKK7zck/2tSRxb6PGG
         OZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+ThDkGDC9Z3dXDzV2F12hI/Y7MCY2t6BeyTfW95VKh/arxHbM13AqANEjh3Yv9USjIXe5F3fIZlk7XUGvuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK3cXlk9Mp9Pwerufs5aXm3Agn2TehYpJyf3wGSrvaffj4eUUJ
	BsMmbnZ7uLSUi+Nl/xMGwGpNubkRrMF+ILz1GwNdDyyp59R9Vrfg
X-Gm-Gg: ASbGncuc67Wdp83Nes54sv9zIDdWFb6qd6/CqHTnFvhEAO6usMHfAnve49G1I2BZdmZ
	UKJgnycKOEqR3FYZ5m9HZE8YJAH8noGwDAQ+7MP6JI5300TkXKNEraPzHrcTQBz+mCU7XNg+rnu
	lDVgr75ktFdF+CpycjKTqWU2HT9kIkNXWek0nUHkjDRukM085LzIhXJ37bAZPSpuQl7VDTz+IcZ
	tObBgNWi/GMw1vd1AvxRJR2xcJtlwvnKX+eMfnK+gbk9scn6g3rJUVmt6tEdgsCOOF4GdPamMV/
	JNVQsoiL850VirREHl96ZPexOLTSD1iENTkWncGbcYR2mi1qj2Ydfm1lFX25GqLvAw==
X-Google-Smtp-Source: AGHT+IHxY4Vgr8ATi1uVdyopW2+f/aLhWWNzfk7UHIfMOoRiFLbmaJkjO523spjjVjgNAJSnkFxkQQ==
X-Received: by 2002:a05:6a21:339a:b0:1f5:51d5:9ef3 with SMTP id adf61e73a8af0-1fe42f995edmr26069754637.20.1742947912351;
        Tue, 25 Mar 2025 17:11:52 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a280e572sm9690206a12.32.2025.03.25.17.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:11:51 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:11:49 -0700
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
Message-ID: <Z+NGRX7g2CgV9ODM@devvm6277.cco0.facebook.com>
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

Hey Stefano,

I noticed that bpf/vmtest.sh uses images hosted from libbpf's CI/CD. I
wonder if you have any thoughts on a good repo we may use to pull our
qcow image(s)? Or a preferred way to host some images, if no repo
exists?

Thanks,
Bobby
