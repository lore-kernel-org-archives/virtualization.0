Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD2269CEC
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882821; cv=none; b=uTr2lAnli8XMuNMe2H7LW9bC3qLgbk6nN9HvUmHBH4CfQTtb97qyX8WYqkPQeA2ANKKC4CANWpSufCbAt1e8Aw1uwVFONbIzCJNPnODJa3cszkx6+Ms7V0ERBRHQf5Q1+5M/U8rSj9msj5wPHX1sCzDHKDC9j6/N39ogYLwXtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882821; c=relaxed/simple;
	bh=MeouaPYUY+Y6+m89zPz2q/9mjsxSalWkhr/0fnbRPfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF/3Jwb7rjwdQ8AEbS1wSnpx8ct3S2zMxIR+wRVBWBXPeqDqbK4Oh3wBBwemF4BNXGwPgiEA+akmxN/ZSdLFsvp1jMcmo3AoRi+Pvo1Smy6FSSD5tgL4FJrVKyPEL6ahdRLHv4MRmUvRdmTdP1zRnMti/EhSkDU1nV4+X7OhrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFjvSOhj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFjvSOhj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso25313455ad.2
        for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741882817; x=1742487617; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FrtSM5QYV3ZSnhILX79ajDFfaROpVELvpAwwKaRM0o=;
        b=LFjvSOhjpLq1dlO/Pd5jGahnFpaWHwYGtP1TA1FGBo4WnfhcRH2Trul30o26RmJ2Tb
         3HYmzbuHERprHn5+mQQykcD5FpEAhxCHOEm/HUVDfXO0kQ9TpeD7RxW4qRyzRMJXgMnG
         ryJRGbiJdBAKuSX+3JmLi6JNVnRMpVP5oEa7FYZMzG7KHKzubDtVSAgimG8Yz5PY7pF3
         BTgQSlzV0sjEWwyIpwWdausw2O9C92gNtNltuZJ3eUYtpyYoVnrVWYhUAYrrL+/R31qm
         DlxoHt7TTB41XG6Fyase+m5R9ujOhp2GWV8PG1NfYjdZp2enC6DVHfwmJUSDjToTZV4K
         9zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741882817; x=1742487617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FrtSM5QYV3ZSnhILX79ajDFfaROpVELvpAwwKaRM0o=;
        b=QwXF2aCp+7vNz79eAn17cRtXU62HuGkQjpZodyxwNtASciECcgWvnNPgPMu8z7nbNv
         T7e92SISVqLwSVnUe9+XAOGwFpYlSD25B0AYla3eTam7YxKx3VkQRo7uRWs2FTNXcYCE
         BViJKsf9DwzWLI7+BrEpLz+3YmyX6sBPY2Rr5Z+cO+ziVhAtoaRvsBQER6GgYA5T+HxN
         JbKq8+YQD2LiHZk6puQiP2NZkPXqgfjrV9/d9QK6pY/cf3al3r1wYro4Cr/fI0gd3A7Z
         LTFYMK8azT02xsPouIh2hNn/h4iesMGILr2JoyU2YSpSs+lCgvxrwndw0X9rl3W5Pq4F
         +ytQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+4ra3kz/k1ijFQbz/DV0TuPpZGrZCaWE9yvDYV9jHXtu/DrJSLRul95DPknAkzdD8Rrw45Yg9unwwQMMWyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvkN6bFTnozIL29A9KJDGHh/oQr4AdoX0u3Ct99GRqd2aJGzI6
	vbPg0iZEW2fDGa1EcVH1TRHEJmYfPL0x2sbywvGoDiuv6Obi90n/y/SosTn4
X-Gm-Gg: ASbGnct91PhETDv+V3gub8wlIEbWFGjCrfkCGv1aVgiNWNl8PoVdiDFKiVQg4JbpBui
	lFH3FEtcPxVG2Bufhb99dilziMD7fg7xkbJdpa7LZLb0LvdbwZ5RFXDOOHF9naVc2rnJkSPSUkg
	MMunVpNxFdSBRQ5e4kXSe5w+JiqUNkhtJE9jHq6GzCJG8jo4BiZldU5hTuyjDnq/jglXlnR4+Vd
	fWgOTDbHvRiYAOopqaVOSOoqD8IOFIHdz2KR+wkil+03lMxD7UJLP8yNVbLk7cw/meDcKSMvZc5
	THel9DFFFJGt/F/Sm8zj/mOpHUS955/QegqTvOmvVEzvSOoKTOPp+/NjS/FogHYa8g==
X-Google-Smtp-Source: AGHT+IEWJGd9h0feAugm799oiQTdsY9teLTJc2OsgE9nTLRDIkiU9dBSoHavuE6qoQrpZvxOwMlLtg==
X-Received: by 2002:a17:902:e748:b0:220:d601:a704 with SMTP id d9443c01a7336-225dd84bc8bmr1960855ad.18.1741882817018;
        Thu, 13 Mar 2025 09:20:17 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba724asm15226325ad.152.2025.03.13.09.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:20:16 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:20:14 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <Z9MFvkALRY/k3ITG@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <Z9JC0VoMwAHKjqEX@devvm6277.cco0.facebook.com>
 <zz5fnulfljo6hyxaveseq3dxfgljfs33m7ncsw6uod6wouaqhl@jzdmg6s7g5dw>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zz5fnulfljo6hyxaveseq3dxfgljfs33m7ncsw6uod6wouaqhl@jzdmg6s7g5dw>

On Thu, Mar 13, 2025 at 04:37:16PM +0100, Stefano Garzarella wrote:
> Hi Bobby,
> first of all, thank you for starting this work again!
> 

You're welcome, thank you for your work getting it started!

> On Wed, Mar 12, 2025 at 07:28:33PM -0700, Bobby Eshleman wrote:
> > Hey all,
> > 
> > Apologies for forgetting the 'net-next' prefix on this one. Should I
> > resend or no?
> 
> I'd say let's do a firts review cycle on this, then you can re-post.
> Please check also maintainer cced, it looks like someone is missing:
> https://patchwork.kernel.org/project/netdevbpf/patch/20250312-vsock-netns-v2-1-84bffa1aa97a@gmail.com/
> 

Duly noted, I'll double-check the ccs next time. sgtm on the re-post!

> > On Wed, Mar 12, 2025 at 01:59:34PM -0700, Bobby Eshleman wrote:
> > > Picking up Stefano's v1 [1], this series adds netns support to
> > > vhost-vsock. Unlike v1, this series does not address guest-to-host (g2h)
> > > namespaces, defering that for future implementation and discussion.
> > > 
> > > Any vsock created with /dev/vhost-vsock is a global vsock, accessible
> > > from any namespace. Any vsock created with /dev/vhost-vsock-netns is a
> > > "scoped" vsock, accessible only to sockets in its namespace. If a global
> > > vsock or scoped vsock share the same CID, the scoped vsock takes
> > > precedence.
> 
> This inside the netns, right?
> I mean if we are in a netns, and there is a VM A attached to
> /dev/vhost-vsock-netns witch CID=42 and a VM B attached to /dev/vhost-vsock
> also with CID=42, this means that VM A will not be accessible in the netns,
> but it can be accessible outside of the netns,
> right?
> 

In this scenario, CID=42 goes to VM A (/dev/vhost-vsock-netns) for any
socket in its namespace.  For any other namespace, CID=42 will go to VM
B (/dev/vhost-vsock).

If I understand your setup correctly:

	Namespace 1:
		VM A - /dev/vhost-vsock-netns, CID=42
		Process X
	Namespace 2:
		VM B - /dev/vhost-vsock, CID=42
		Process Y
	Namespace 3:
		Process Z

In this scenario, taking connect() as an example:
	Process X connect(CID=42) goes to VM A
	Process Y connect(CID=42) goes to VM B
	Process Z connect(CID=42) goes to VM B

If VM A goes away (migration, shutdown, etc...):
	Process X connect(CID=42) also goes to VM B

> > > 
> > > If a socket in a namespace connects with a global vsock, the CID becomes
> > > unavailable to any VMM in that namespace when creating new vsocks. If
> > > disconnected, the CID becomes available again.
> 
> IIUC if an application in the host running in a netns, is connected to a
> guest attached to /dev/vhost-vsock (e.g. CID=42), a new guest can't be ask
> for the same CID (42) on /dev/vhost-vsock-netns in the same netns till that
> connection is active. Is that right?
> 

Right. Here is the scenario I am trying to avoid:

Step 1: namespace 1, VM A allocated with CID 42 on /dev/vhost-vsock
Step 2: namespace 2, connect(CID=42) (this is legal, preserves old
behavior)
Step 3: namespace 2, VM B allocated with CID 42 on
/dev/vhost-vsock-netns

After step 3, CID=42 in this current namespace should belong to VM B, but
the connection from step 2 would be with VM A.

I think we have some options:
1. disallow the new VM B because the namespace is already active with VM A
2. try and allow the connection to resume, but just make sure that new
   connections got o VM B
3. close the connection from namespace 2, spin up VM B, hope user
	 manages connection retry
4. auto-retry connect to the new VM B? (seems like doing too much on the
   kernel side to me)

I chose option 1 for this rev mostly for the simplicity but definitely
open to suggestions. I think option 3 is also a simple implementation.
Option 2 would require adding some concept of "vhost-vsock ns at time of
connection" to each socket, so the tranport would know which vhost_vsock
to use for which socket.

> > > 
> > > Testing
> > > 
> > > QEMU with /dev/vhost-vsock-netns support:
> > > 	https://github.com/beshleman/qemu/tree/vsock-netns
> 
> You can also use unmodified QEMU using `vhostfd` parameter of
> `vhost-vsock-pci` device:
> 
> # FD will contain the file descriptor to /dev/vhost-vsock-netns
> exec {FD}<>/dev/vhost-vsock-netns
> 
> # pass FD to the device, this is used for example by libvirt
> qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=mem \
>   -drive file=fedora.qcow2,format=qcow2,if=virtio \
>   -object memory-backend-memfd,id=mem,size=512M \
>   -device vhost-vsock-pci,vhostfd=${FD},guest-cid=42 -nographic
> 

Very nice, thanks, I didn't realize that!

> That said, I agree we can extend QEMU with `netns` param too.
> 

I'm open to either. Your solution above is super elegant.

> BTW, I'm traveling, I'll be back next Tuesday and I hope to take a deeper
> look to the patches.
> 
> Thanks,
> Stefano
> 

Thanks Stefano! Enjoy the travel.

Best,
Bobby
