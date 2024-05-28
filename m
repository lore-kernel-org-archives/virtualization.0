Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA4A170820
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907432; cv=none; b=KlQk+MhorBb1AxJv6uiqNJwDMrEsK8LkQf3txM/51z9jU+U/ZgNdbOxFvAjm+LRibUwfaUQAneZ/LyfW+HzwWZChXW88UnfsJ3wJSALl4tm4LwjwplthhrhYO2lBdfm2uo3EUCyTMNrfOY85e3wpUo5WIjnSX5QdZyfL4FAlhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907432; c=relaxed/simple;
	bh=l8PL4ITreuRzuAabhern06z5m9w9eYF1RtNoXSO1DFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n3tRaSj+9kjrUmJqUM8qMoWkShRukgGp2fRBljQ3hEokrOGDoBbnkCe0xyqU3+81SoqvemxVI01/qfPjA0dx55WegxETdirT+apzP5R+dZcIFw3xLUAuC00RjzFe9NE2zbbxZ0bQ2c9ZwOa5wNPWV1kRyRez4W1O5TQmuSUXNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZXBzcuO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZXBzcuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716907428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ7SbRqo3yUKi400fXlwv6prAX+h9G6ATKUpe9IKZfM=;
	b=FZXBzcuOTw/evruV0hCgIgUvnOOjXKbLlnrnbaffEeAUA2gG7V4dp3knWA1b/rVe+hSKNq
	RsobWbI4og7MGjKEEc3HRMxeE8NFRi+2GRfjAHO+EWYbqRef20HvvdFNYbCD0VUxbQub4y
	QoUyecfYg+H6qtPmTpfTDFSd2A6++hg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-vGMMg9vzOg6WrrBF3IlRWA-1; Tue, 28 May 2024 10:43:47 -0400
X-MC-Unique: vGMMg9vzOg6WrrBF3IlRWA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4206b3500f5so7087285e9.1
        for <virtualization@lists.linux.dev>; Tue, 28 May 2024 07:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716907426; x=1717512226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ7SbRqo3yUKi400fXlwv6prAX+h9G6ATKUpe9IKZfM=;
        b=Aag9NNhjw+A+aa7fIusRp2BsCn/kIhCxy5XxhZGRKKznbrt+a94tYUw9Dwwi5qpbxv
         6M8dC/JC06w78fJcbPVxetagxHGpJM6pDHyCg6kN66AQzeShjyWAlxvIkdwvrhAk3j7E
         PphqN543a42/H3PZGC1LF/0PN7XQIR7r8zTikxU4ddFQKNxOMo1sn6f/gpb/sLDOPHY+
         ElJyiVbz7A8gdnAicu1GLKCE/A7jzME2xyXnDr5v0hBApnc7vLFbFLQj+5p19oOwe/sK
         2YnHidpoHMK1dIncLmlLLhygTF++Jbwjh5rkIO52E6cj+9n1Qms+It1P7wNHMlNu62UO
         bsGA==
X-Forwarded-Encrypted: i=1; AJvYcCX5UMV0//fgEKNJKRMFdJohWDbYPFkcNcpsxYOLL2RYsIczkjELhhOF8HlcwJ8H3qLRR/Mfq33HoHxLc4XkcBAqDcIzGfU4dnPHQZXuiPg=
X-Gm-Message-State: AOJu0YwgmHPw2tXMeVw+llZeGbnsirA7axkJKHDiWXIaX8OK/MIpaFev
	2euYjw61ZfxiXNEbeB7uuTzc9Fh1w44MdP7ifuL2orqBD5/z6YSxDeVZ4tjmgIwJxwKoy8p4kdZ
	eqbvJMuzM7QwAH3/xHsLWu++D6gQBexVFIg+lWrC9rf4PZU377YOcsT1JBWmcohY5
X-Received: by 2002:a05:600c:5129:b0:421:1fb1:fe00 with SMTP id 5b1f17b1804b1-4211fb1fecbmr19203695e9.17.1716907426132;
        Tue, 28 May 2024 07:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5W0e9gKn3FUSUFC5qJt7ioXJzCWomZRrdk8cPW4i6Z/Cawy24M4FleXwYrOgLgbaIzYuxxA==
X-Received: by 2002:a05:600c:5129:b0:421:1fb1:fe00 with SMTP id 5b1f17b1804b1-4211fb1fecbmr19203395e9.17.1716907425687;
        Tue, 28 May 2024 07:43:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210e63ea39sm116795045e9.30.2024.05.28.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:43:44 -0700 (PDT)
Date: Tue, 28 May 2024 16:43:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Alexander Graf <agraf@csgraf.de>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, stefanha@redhat.com
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
Message-ID: <tg7l3dr2x7jbf4kf6fbl5vforfonx6b4ls7smrimq6fg4tlluc@udyk6ex7ymrr>
References: <CAFfO_h7xsn7Gsy7tFZU2UKcg_LCHY3M26iTuSyhFG-k-24h6_g@mail.gmail.com>
 <4i525r6irzjgibqqtrs3qzofqfifws2k3fmzotg37pyurs5wkd@js54ugamyyin>
 <CAFfO_h7iNYc3jrDvnAxTyaGWMxM9YK29DAGYux9s1ve32tuEBw@mail.gmail.com>
 <3a62a9d1-5864-4f00-bcf0-2c64552ee90c@csgraf.de>
 <6wn6ikteeanqmds2i7ar4wvhgj42pxpo2ejwbzz5t2i5cw3kov@omiadvu6dv6n>
 <5b3b1b08-1dc2-4110-98d4-c3bb5f090437@amazon.com>
 <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 27, 2024 at 09:54:17AM GMT, Alexander Graf wrote:
>
>On 27.05.24 09:08, Alexander Graf wrote:
>>Hey Stefano,
>>
>>On 23.05.24 10:45, Stefano Garzarella wrote:
>>>On Tue, May 21, 2024 at 08:50:22AM GMT, Alexander Graf wrote:
>>>>Howdy,
>>>>
>>>>On 20.05.24 14:44, Dorjoy Chowdhury wrote:
>>>>>Hey Stefano,
>>>>>
>>>>>Thanks for the reply.
>>>>>
>>>>>
>>>>>On Mon, May 20, 2024, 2:55 PM Stefano Garzarella 
>>>>><sgarzare@redhat.com> wrote:
>>>>>>Hi Dorjoy,
>>>>>>
>>>>>>On Sat, May 18, 2024 at 04:17:38PM GMT, Dorjoy Chowdhury wrote:
>>>>>>>Hi,
>>>>>>>
>>>>>>>Hope you are doing well. I am working on adding AWS Nitro Enclave[1]
>>>>>>>emulation support in QEMU. Alexander Graf is mentoring me 
>>>>>>>on this work. A v1
>>>>>>>patch series has already been posted to the qemu-devel 
>>>>>>>mailing list[2].
>>>>>>>
>>>>>>>AWS nitro enclaves is an Amazon EC2[3] feature that allows 
>>>>>>>creating isolated
>>>>>>>execution environments, called enclaves, from Amazon EC2 
>>>>>>>instances, which are
>>>>>>>used for processing highly sensitive data. Enclaves have 
>>>>>>>no persistent storage
>>>>>>>and no external networking. The enclave VMs are based on 
>>>>>>>Firecracker microvm
>>>>>>>and have a vhost-vsock device for communication with the 
>>>>>>>parent EC2 instance
>>>>>>>that spawned it and a Nitro Secure Module (NSM) device for 
>>>>>>>cryptographic
>>>>>>>attestation. The parent instance VM always has CID 3 while 
>>>>>>>the enclave VM gets
>>>>>>>a dynamic CID. The enclave VMs can communicate with the 
>>>>>>>parent instance over
>>>>>>>various ports to CID 3, for example, the init process 
>>>>>>>inside an enclave sends a
>>>>>>>heartbeat to port 9000 upon boot, expecting a heartbeat 
>>>>>>>reply, letting the
>>>>>>>parent instance know that the enclave VM has successfully booted.
>>>>>>>
>>>>>>>The plan is to eventually make the nitro enclave emulation 
>>>>>>>in QEMU standalone
>>>>>>>i.e., without needing to run another VM with CID 3 with proper vsock
>>>>>>If you don't have to launch another VM, maybe we can avoid 
>>>>>>vhost-vsock
>>>>>>and emulate virtio-vsock in user-space, having complete 
>>>>>>control over the
>>>>>>behavior.
>>>>>>
>>>>>>So we could use this opportunity to implement virtio-vsock 
>>>>>>in QEMU [4]
>>>>>>or use vhost-user-vsock [5] and customize it somehow.
>>>>>>(Note: vhost-user-vsock already supports sibling 
>>>>>>communication, so maybe
>>>>>>with a few modifications it fits your case perfectly)
>>>>>>
>>>>>>[4] https://gitlab.com/qemu-project/qemu/-/issues/2095
>>>>>>[5] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock
>>>>>
>>>>>
>>>>>Thanks for letting me know. Right now I don't have a complete picture
>>>>>but I will look into them. Thank you.
>>>>>>
>>>>>>
>>>>>>>communication support. For this to work, one approach 
>>>>>>>could be to teach the
>>>>>>>vhost driver in kernel to forward CID 3 messages to another CID N
>>>>>>So in this case both CID 3 and N would be assigned to the same QEMU
>>>>>>process?
>>>>>
>>>>>
>>>>>CID N is assigned to the enclave VM. CID 3 was supposed to be the
>>>>>parent VM that spawns the enclave VM (this is how it is in AWS, where
>>>>>an EC2 instance VM spawns the enclave VM from inside it and that
>>>>>parent EC2 instance always has CID 3). But in the QEMU case as we
>>>>>don't want a parent VM (we want to run enclave VMs standalone) we
>>>>>would need to forward the CID 3 messages to host CID. I don't know if
>>>>>it means CID 3 and CID N is assigned to the same QEMU process. Sorry.
>>>>
>>>>
>>>>There are 2 use cases here:
>>>>
>>>>1) Enclave wants to treat host as parent (default). In this 
>>>>scenario,
>>>>the "parent instance" that shows up as CID 3 in the Enclave doesn't
>>>>really exist. Instead, when the Enclave attempts to talk to CID 3, it
>>>>should really land on CID 0 (hypervisor). When the hypervisor tries to
>>>>connect to the Enclave on port X, it should look as if it originates
>>>>from CID 3, not CID 0.
>>>>
>>>>2) Multiple parent VMs. Think of an actual cloud hosting scenario.
>>>>Here, we have multiple "parent instances". Each of them thinks it's
>>>>CID 3. Each can spawn an Enclave that talks to CID 3 and reach the
>>>>parent. For this case, I think implementing all of virtio-vsock in
>>>>user space is the best path forward. But in theory, you could also
>>>>swizzle CIDs to make random "real" CIDs appear as CID 3.
>>>>
>>>
>>>Thank you for clarifying the use cases!
>>>
>>>Also for case 1, vhost-vsock doesn't support CID 0, so in my opinion
>>>it's easier to go into user-space with vhost-user-vsock or the built-in
>>>device.
>>
>>
>>Sorry, I believe I meant CID 2. Effectively for case 1, when a 
>>process on the hypervisor listens on port 1234, it should be visible 
>>as 3:1234 from the VM and when the hypervisor process connects to 
>><VM CID>:1234, it should look as if that connection came from CID 3.
>
>
>Now that I'm thinking about my message again: What if we just introduce 
>a sysfs/sysctl file for vsock that indicates the "host CID" (default: 
>2)? Users that want vhost-vsock to behave as if the host is CID 3 can 
>just write 3 to it.

I don't know if I understand the final use case well, so I'll try to 
summarize it:

what you would like is to have the ability to receive/send messages from 
the host to a guest as if it were a sibling VM, so as if it had a CID 
!=2 (in your case 3). The important point is to use AF_VSOCK in the host 
application, so no a unix-socket like firecracker.

Is this correct?

I thought you were using firecracker for this scenario, so it seemed to 
make sense to expect user applications to support hybrid vsock.

>
>It means we'd need to change all references to VMADDR_CID_HOST to 
>instead refer to a global variable that indicates the new "host CID". 
>It'd need some more careful massaging to not break number namespace 
>assumptions (<= CID_HOST no longer works), but the idea should fly.
>
>That would give us all 3 options:
>
>1) User sets vsock.host_cid = 3 to simulate that the host is in 
>reality an enclave parent
>2) User spawns VM with CID = 3 to run parent payload inside
>3) User spawns parent and enclave VMs with vhost-vsock-user which 
>creates its own CID namespace
>
>
>Stefano, WDYT?

This would require many changes in the af_vsock core as well. Perhaps we 
can avoid touching the core in this way:

1. extend vhost-vsock to support VMADDR_FLAG_TO_HOST (this is need also
    when the user spawns a VM with CID = 3 using vhost-vsock).
    Some new ioctl/sysfs should be needed to create an allowlist of CIDs
    that may or may not be accepted. (note: as now, vhost-vsock discards
    all packets that have dst_cid != 2)

2. create a new G2H transport that will be loaded in the host.
    af_vsock core supports 3 transport types to be loaded at runtime
    simultaneously: looback, G2H (e.g. virtio-vsock, hyper-v, vmci
    driver), H2G (e.g. vhost-vsock kernel module). We originally
    introduced this extension to support nested VMs. This split is used
    mostly to handle CIDs:
    - loopback (local CID = 1)
    - H2G (local CID = 2)
    - G2H (local CID > 2)

    Perhaps the simplest thing is to extend vsock_loopback to be used
    here, but instead of registering as loopback (which can only handle
    CID 1), it should register as G2H, this way we reuse all the logic
    already in the af_vsock core to handle CIDs > 2.

    The only problem is that in this case your host, it can't be nested.
    But upstream there's a proposal to support multiple virtio-vsock
    devices in a guest, so we could adapt it to support this case in the
    future.


WDYT?

Thanks,
Stefano

