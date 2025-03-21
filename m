Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824641C72
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551367; cv=none; b=Zthj08Fm+xZ4ti6rd7WJvV8kxWp9KQJcQriwwFexkEOA5PZaJ7A9ZQAyPd0cHodpF+VlzMc20J2WF+QvTMbAAgykYA8ZfVQVwy+qXqAuyfVvQpzQ3irMY/Zl3DB6fZ+PxV8N/sCG/WhqGr+F0eV478kU2+QwxyLfoweCsnms/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551367; c=relaxed/simple;
	bh=7FXB9MgUSNIAeCSTjixx/fGT1P/pEpqm6PYZY4ugldk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Pdo7q0JWV4Gz2atjsix9NECKF4C5wlXWrCthGfj0I53BUFW8ELYdHZb+Ok+/mSELbst8kIJnkaAD3gQVeurURjIq8zEKv+uN/rM8Cs2o0t5ZLVOUykaeOSd4zdyPML6PYLPH/RTaX76EZPG6nhcD2aWO7smdHkLuDjNKS/Fucxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fh2ozByb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fh2ozByb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742551363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1fasRIza0+wiA592mMux1XtH5KpwcITkoYkMYOlXyU=;
	b=fh2ozByb7XrKwBDe232od9RzU4T8w7G0yMGs6geOIeClm1OdZd5M1RFiAOPsb7z8nrZKQW
	cya4Q6z4/LgJNScLmHjSjUDuke66TkB+7Z86XkiCYpldJ1iOWgBiAJ0PLhxLOuo2RBtNqR
	zj79BGx3LkZGjSuwa0hAzPlhgRRvAFM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-AYGIU9QiPzqJePQ8URtYFA-1; Fri, 21 Mar 2025 06:02:42 -0400
X-MC-Unique: AYGIU9QiPzqJePQ8URtYFA-1
X-Mimecast-MFC-AGG-ID: AYGIU9QiPzqJePQ8URtYFA_1742551361
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac28f255a36so144667666b.3
        for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 03:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742551361; x=1743156161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1fasRIza0+wiA592mMux1XtH5KpwcITkoYkMYOlXyU=;
        b=ZYoTKhoNLElWfYCSpfB/n7fjplZBoIbJ7/MByFLaRL/urUBxFTYaHRh8frCCovMxFh
         v7kQVyZLle9f5fGZOfy/XWNI+YT6eZYEOK6xCAy99mxnzGTOGwFbz/a6hDxT7+mmYyTu
         jM7Hf1pBzETM9ug5GTS36uzh5bnj7pxYbUwIGFVUL1cuvPOJy7o9Zn7qtMOMyurC9l4D
         uc4eSOmWqo+1Czh2oEkQh0VKe+4hVL+17RSG8JfScFtnjjKEPcnF+zaZfgi5Nm3DCGlM
         aoX9bwBFVdsX8DyTvYAk0BP+Hm4G5aT9k+p+1mRo0YMVjcSuoBass3dppIk4vZIfv4GB
         CXwA==
X-Forwarded-Encrypted: i=1; AJvYcCWjdVEzMG57hjAlRR82kwKSQMHN/koxApW2DJnZnVzE/1ZEYq2kjOK7CmqmxW3YCs7VqLPOwxbfR7J/oQfVxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdE0SHhw3EflVsI7NXe366A14ZBNAtQgBUazCNuYmkNWjRObIx
	Ucz0qTnmbxYoVFnfNjXwnl6Qvcguc4jMVijsA7nSAfdSd+yV8HLL1j5gJCTWfpFgJDhSW8VKW6y
	P9eaBUEw11dZS7MF4P9HDIvECMnygaCc9AI7Moh9fdzXvwb+M+fxkwnQzIci9xSzV
X-Gm-Gg: ASbGncuBEUQIt0vixk6patC9Mee6IFjeqT5N3pLnnGEmIsGnvDHl5VNHV+Rg2j+EEJh
	kdb9gVAk/70EQsd7CviJMCdliACBAyYWyXMe3XMMCsk/LB56gVVHeZX1vAsm2twLdKHSjR9Ik0P
	gv7OH5aMx9U0UCys1IpP685Q7yciHODN80w6MFClnuJPQ11f2dJRO7xr0F1c+QqsL7DjOt8gTN/
	CKvaKQ1bjvGY+qp7U/ri3pp8KZXb6KTsML3NfAAzn8e0G5dezONXrm2ZBEtGn/bjx+JEZALkSxo
	hkhitiSDjmwwRfDJGhkWw6xFFq+7Om05oed1juUmT5wuaiWqOj+ypDxlhAS6Uy0Y
X-Received: by 2002:a17:907:d7c8:b0:ac3:9587:f2a1 with SMTP id a640c23a62f3a-ac3f20f2eadmr273954966b.20.1742551360975;
        Fri, 21 Mar 2025 03:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI1seRG9imWZDzSDGMTwRVM4KqTGFuBDv5cjB/u4qDI0LlvpoSZCACNxNmno6+XKEHNnW4Jg==
X-Received: by 2002:a17:907:d7c8:b0:ac3:9587:f2a1 with SMTP id a640c23a62f3a-ac3f20f2eadmr273949266b.20.1742551360312;
        Fri, 21 Mar 2025 03:02:40 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e50b9sm125525366b.55.2025.03.21.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:02:39 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:02:34 +0100
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
Message-ID: <aqkgzoo2yswmb52x72fwmch2k7qh2vzq42rju7l5puxc775jjj@duqqm4h3rmlh>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
 <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
 <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zgD-75iNvyzWzIKULsbscpkTyGDja0uD6ZDcbf2c9RQ_1742551361
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Mar 20, 2025 at 02:05:38PM -0700, Bobby Eshleman wrote:
>On Thu, Mar 20, 2025 at 10:08:02AM +0100, Stefano Garzarella wrote:
>> On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
>> > On 3/12/25 9:59 PM, Bobby Eshleman wrote:
>> > > @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>> > >  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>> > >
>> > >  	vhost_dev_cleanup(&vsock->dev);
>> > > +	if (vsock->net)
>> > > +		put_net(vsock->net);
>> >
>> > put_net() is a deprecated API, you should use put_net_track() instead.
>> >
>> > >  	kfree(vsock->dev.vqs);
>> > >  	vhost_vsock_free(vsock);
>> > >  	return 0;
>> >
>> > Also series introducing new features should also include the related
>> > self-tests.
>>
>> Yes, I was thinking about testing as well, but to test this I think we need
>> to run QEMU with Linux in it, is this feasible in self-tests?
>>
>> We should start looking at that, because for now I have my own ansible
>> script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to
>> test both host (vhost-vsock) and guest (virtio-vsock).
>>
>
>Maybe as a baseline we could follow the model of
>tools/testing/selftests/bpf/vmtest.sh and start by reusing your
>vsock_test parameters from your Ansible script?

Yeah, my playbooks are here: 
https://github.com/stefano-garzarella/ansible-vsock

Note: they are heavily customized on my env, I wrote some notes on how 
to change various wired path.

>
>I don't mind writing the patches.

That would be great and very much appreciated.
Maybe you can do it in a separate series and then here add just the 
configuration we need.

Thanks,
Stefano

