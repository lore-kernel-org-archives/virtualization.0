Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DA46B5
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504743; cv=none; b=KgbWQ7NoDtyR4grYL2MZ8aS1K/cCExJb+Wqc4P/JXqW1tzSXtExQuTXZSqa74cpbsOF/TN/c41pHNHrQENScPq1Yff57WWk+vZpkcM1gIVP2xvppyRhZbOit+h0ifsCgkgu7fIQqjdqS3As8D2QiqexUOC8Zap3aDc3+t666828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504743; c=relaxed/simple;
	bh=YgdpRvORfQrJXyGjouHiXsPKxSh1pKbm6IQi0Z4fEqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQ31EbaxPbzl8SrQ+N+ePqGeaY/SVKVNhijQUuErqYwUi1pqC62VyhW/xezQQR6EZaEt1pZVxK0TsfHrim2b+FBf2rNhsnBuU3myNBUuDKXTH6V4DV5VjPgNpjUc0Kxq+arNKChpFn4u4AcW0Vur/Zige9kbpCiDiLR1CsQRfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRPT5axM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRPT5axM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fb0f619dso26686055ad.1
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742504741; x=1743109541; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jPDdAZsU2RRMMAuFebBCueBYeGg/JKuNefmjD9nyKY=;
        b=TRPT5axMARdxcXieGMkkoPTnRjBl7sO1aced4K8rD30OSA9tJh2dTRsXScy+xgtAOO
         1W6PPiKI9I3dHTsOjQx6m9xul/AsIUOtG4+RvLq6b0Xt3mx+zu8rg388KTsUtU2nhRtT
         YGinhs5kahf4SU0Oneuz21Ndn2VE+d560/WD2zl4yqeXgIsRW78qVcWUTNdueSerMgBp
         kjSB+bqM6hB4LbT15K4nC4pn/rJOa98Zzc+5OU4PUv0pkMF0w3/sl1S9riZqmEWUhZ0o
         HddIQppfBi9lpiz1PZDqCjmzf5S3EJjzOj7l4NMZ8FqzMmHKeTGg45aSUY1OHFIKNkN/
         edSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742504741; x=1743109541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jPDdAZsU2RRMMAuFebBCueBYeGg/JKuNefmjD9nyKY=;
        b=cnTXpMj9rJ2mJL7TpVgA3d4QuYhrXCWuMYfdIu63Sot4cOrxWUWqgqlnRtfF2pcEUH
         RglmhHTYhsVq/mIoERapucTdv14i5ig0TA38SpGKSoDPB6SQYJbFxd5gEHJZG1BAxdHy
         0T+1QuCleHQNkBzaiC6IvNUsIh7AnPoJ7mel7foshLOWOheH0dpcBCz4c/tHAsNh8kgC
         gaGLmKeAGdrKkHUmLGK+z3BJhbYy7nKarnq4gGIpt86chdCpVOmbEj/oNNMoDtXOvdU1
         SHdaQyx/Mqp51krJLUXsxXzv4HwXpI8QCJMXe/B6drMeDqwi//Lc3I55OzUyOr1sYLO/
         fJzw==
X-Forwarded-Encrypted: i=1; AJvYcCWZnomfmn0Tavm97Oc4QKfDilcJrUxMjcogRoEg8596DXbTCLwrWJeBNHrE56X7RN76OpvxCbbwmc/3T0KukQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx70TzmpaOZ33t5wQGsOmmnBsyuFSFRfB/AIRUYKgF6izmwCEeC
	oDPEaMn5VKyxOHVeQ5HlkZEXJPasBmTGTocDlp3vmJPLDuJsiv9w
X-Gm-Gg: ASbGncsFMDz8+C+3gEqbjXK/R+uuluP3zkIEiFhH9wDIqy/z7t4G62XDJzoey9imnZt
	q/a3afkxfs6o+EHH17rn0UaNFR74T8apa65WVOmqaJfkST8cShwm4Aj43597eWp1MSOQdeSdz5Y
	BNR/EP2o5XgDWwmbaGPn7NOXtqEFtQr/DwQKSXhQljXTz/t6KWOnPf9p7GjUVVWV3qX7gch868v
	HxYR93fPjgnUVeFaJ8nqEB8XJzylLdm+rJ+8HeTBasOim8ivHQuGDTLryvV1fHLYNOm3ObLMk3Z
	GMi05/kaBLsF9TZJElbbm7QHGGDQVcXmkHM09qfl0iTGRWxj5b0MmXdasKeqPOrl7w==
X-Google-Smtp-Source: AGHT+IGByHBrbBgXXk1MNKK8PoOJzGBZqACnvtAZVXwzJ5Mt98hUmINKtxNrRQVVmQU2iZkin8qKTA==
X-Received: by 2002:a17:903:182:b0:223:653e:eb09 with SMTP id d9443c01a7336-22780c50a59mr11694335ad.7.1742504740770;
        Thu, 20 Mar 2025 14:05:40 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2278120981fsm2458075ad.250.2025.03.20.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:05:40 -0700 (PDT)
Date: Thu, 20 Mar 2025 14:05:38 -0700
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
Message-ID: <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
 <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>

On Thu, Mar 20, 2025 at 10:08:02AM +0100, Stefano Garzarella wrote:
> On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
> > On 3/12/25 9:59 PM, Bobby Eshleman wrote:
> > > @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> > >  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
> > > 
> > >  	vhost_dev_cleanup(&vsock->dev);
> > > +	if (vsock->net)
> > > +		put_net(vsock->net);
> > 
> > put_net() is a deprecated API, you should use put_net_track() instead.
> > 
> > >  	kfree(vsock->dev.vqs);
> > >  	vhost_vsock_free(vsock);
> > >  	return 0;
> > 
> > Also series introducing new features should also include the related
> > self-tests.
> 
> Yes, I was thinking about testing as well, but to test this I think we need
> to run QEMU with Linux in it, is this feasible in self-tests?
> 
> We should start looking at that, because for now I have my own ansible
> script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to
> test both host (vhost-vsock) and guest (virtio-vsock).
> 

Maybe as a baseline we could follow the model of
tools/testing/selftests/bpf/vmtest.sh and start by reusing your
vsock_test parameters from your Ansible script?

I don't mind writing the patches.

Best,
Bobby
