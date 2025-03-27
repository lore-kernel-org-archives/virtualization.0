Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422220CCF0
	for <virtualization@lists.linux.dev>; Thu, 27 Mar 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743066912; cv=none; b=WG1JxKTOb+Rw22e8eUTWwqSG/QlMaSPIp6e0jNUAuVe45fxUc0/sHJW5GPgX9DQIJyB725pa9mxRIP/bfAgGYWDjwrnYlKs1HFKE1jjdomtdIaUzKuyL740zSagOnMdD5aDDq93A+ztum4KqoXgNRFvoA1l6HHip6yuyzfzWsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743066912; c=relaxed/simple;
	bh=54HKEDtFDLh4IFn4peAyaMx3n68MNsVlNAvR4SWRk0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qYdZ00sr4Lssq8BF4TlUaSSTyKQe8NdfeAmAQux65qRrv4qxuWsFocidg9/yw4TkZ/1ehFrRd6OMlJcxcfHdwVVcBtdBm1lQqQbVSoIYVBtkDqf709HW5POnnGiHHvZAfnzfIQUofFilT5pTGzN4kF8FyC3tSE29GaUtFoLVQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2/8CyMN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2/8CyMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743066908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yf+kBjYifcomTwCXfumXhiLWiiEWa8vvr8UjeDev7tQ=;
	b=J2/8CyMNMyy5mmFzasj22HNIKk+jKg9/vHNWHKaR8gVUBBljEnn5tegbyjOwKGAOFwbTur
	tqoR+C6lNdgFd5hfU6c5f0bMoiXX7fKKToTf4AhCJ9yC/9z5mjXxT0VH7vmVUoBiN16cXw
	+3INZUkBJ8fg09Rx9K3o6XNY8yU1LGs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-MGDZv5w1Nh-e83HyvQWqOg-1; Thu, 27 Mar 2025 05:15:06 -0400
X-MC-Unique: MGDZv5w1Nh-e83HyvQWqOg-1
X-Mimecast-MFC-AGG-ID: MGDZv5w1Nh-e83HyvQWqOg_1743066905
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac293748694so78243166b.0
        for <virtualization@lists.linux.dev>; Thu, 27 Mar 2025 02:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743066904; x=1743671704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf+kBjYifcomTwCXfumXhiLWiiEWa8vvr8UjeDev7tQ=;
        b=sp+qiEbxmmX5GCj75qzCsNOXXxOFTTTxNOv0Nv/0Bd18EDn/8ZyVUlsKNJmHI3m1Z7
         xWFgg7QIqWuCPfPhIlEaVH4gM1SSPAcdELo9kTd1Y2h/T+97cur3dDplOstBVrw1AZTf
         Meyx6NjUZxNCFoNmJBhgcanJjLqMK87jsWEZlEBoN3tFQQvajMDa1dXwhukLIM83/ton
         qFZkiQuk5eYuoMT9cRNSnvhEqoBzn+dry83MPnAUO/k6pyxMVRQaJcp0vxFbisQwqoIi
         rMyM/6aiPRqFnxFZm6izn51PuDYKJ2U1QtLe/TS3KO507Pnfcry1mwboMvv681sS2IG2
         Hccw==
X-Forwarded-Encrypted: i=1; AJvYcCV7xZjWArGNVuXp9O/1021KY7ohSqc62MXE/IpbrwPVP4GFeO8doRYuw6X8OmvMlnZgNCICbvU2aq7XgfaJmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJLfXoCxUjuEdOPNoi/MNi9EnEEbDym64AXWs1+8GcxMs8nCDs
	ZUAqgZmx/2TIBo8PMsSXEb2WPA4z0zNfmBqjoYk/qxpEmSr4HNC9uzVscx0b0/apJijHBbmLQGJ
	eDbzQC6XGrh+DSb78Fv89cyjRECeIKrEPATxHcES/KQj3iOE7ZPaONOr8gtqeXOAU
X-Gm-Gg: ASbGncs3Abc6jAqPmCq6TLvWSAxRLdgQx30NiZ1OhYVdtZJcwwGcpAewQnboToo9vZU
	MzXR+n1PxJUQ7sHvuoWQKMO7PiQJmIm3dzOIP7EiRBM6d3y62DUpqjXFgtE53zUjcD5kIh837DD
	RVvC1QfLBzYiZoqY8gIX5rpISRbpBaKsRFd7E1J9B0uAiyZW3UlEiObKN6T5dj1kkFkg+Bq5xhu
	nl+ef9TBCLFeYentyBMxF2BllsgZHt6urkVSX2wO4rezqw7KQfv1sQXJ1M1GpjZBBL1e2ZrFpDs
	o1EX+on7514In4h4Qe+OBkjJ0hQVFRIwOWnCSc2P356VavgpZ4yjvblQ9GfTR98r
X-Received: by 2002:a17:907:86ac:b0:ac3:25d7:6950 with SMTP id a640c23a62f3a-ac6faec918amr233579166b.20.1743066904524;
        Thu, 27 Mar 2025 02:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9TEdGEiJU8XChL/roZ9oFLUORJvGK9UhKTl0IMh8XLgAXK5tF7SuMvemJlvPj64pT1hjqfQ==
X-Received: by 2002:a17:907:86ac:b0:ac3:25d7:6950 with SMTP id a640c23a62f3a-ac6faec918amr233576966b.20.1743066903811;
        Thu, 27 Mar 2025 02:15:03 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef85c731sm1185185866b.24.2025.03.27.02.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 02:15:03 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:14:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
Message-ID: <apvz23rzbbk3vnxfv6n4qcqmofzhb4llas27ygrrvxcsggavnh@rnxprw7erxs3>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
 <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
 <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>
 <aqkgzoo2yswmb52x72fwmch2k7qh2vzq42rju7l5puxc775jjj@duqqm4h3rmlh>
 <Z+NGRX7g2CgV9ODM@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z+NGRX7g2CgV9ODM@devvm6277.cco0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lm5RwSF_l_i4IBnneVEQiS0H2kcW5zCpfJG_BE3A2ho_1743066905
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Mar 25, 2025 at 05:11:49PM -0700, Bobby Eshleman wrote:
>On Fri, Mar 21, 2025 at 11:02:34AM +0100, Stefano Garzarella wrote:
>> On Thu, Mar 20, 2025 at 02:05:38PM -0700, Bobby Eshleman wrote:
>> > On Thu, Mar 20, 2025 at 10:08:02AM +0100, Stefano Garzarella wrote:
>> > > On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
>> > > > On 3/12/25 9:59 PM, Bobby Eshleman wrote:
>> > > > > @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>> > > > >  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>> > > > >
>> > > > >  	vhost_dev_cleanup(&vsock->dev);
>> > > > > +	if (vsock->net)
>> > > > > +		put_net(vsock->net);
>> > > >
>> > > > put_net() is a deprecated API, you should use put_net_track() instead.
>> > > >
>> > > > >  	kfree(vsock->dev.vqs);
>> > > > >  	vhost_vsock_free(vsock);
>> > > > >  	return 0;
>> > > >
>> > > > Also series introducing new features should also include the related
>> > > > self-tests.
>> > >
>> > > Yes, I was thinking about testing as well, but to test this I think we need
>> > > to run QEMU with Linux in it, is this feasible in self-tests?
>> > >
>> > > We should start looking at that, because for now I have my own ansible
>> > > script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to
>> > > test both host (vhost-vsock) and guest (virtio-vsock).
>> > >
>> >
>> > Maybe as a baseline we could follow the model of
>> > tools/testing/selftests/bpf/vmtest.sh and start by reusing your
>> > vsock_test parameters from your Ansible script?
>>
>> Yeah, my playbooks are here:
>> https://github.com/stefano-garzarella/ansible-vsock
>>
>> Note: they are heavily customized on my env, I wrote some notes on how to
>> change various wired path.
>>
>> >
>> > I don't mind writing the patches.
>>
>> That would be great and very much appreciated.
>> Maybe you can do it in a separate series and then here add just the
>> configuration we need.
>>
>> Thanks,
>> Stefano
>>
>
>Hey Stefano,
>
>I noticed that bpf/vmtest.sh uses images hosted from libbpf's CI/CD. I
>wonder if you have any thoughts on a good repo we may use to pull our
>qcow image(s)? Or a preferred way to host some images, if no repo
>exists?

Good question!

I created this group/repo mainily to keep trak of work, not sure if we 
can reuse: https://gitlab.com/vsock/

I can add you there if you need to create new repo, etc.

But I'm also open to other solutions.

Thanks,
Stefano

