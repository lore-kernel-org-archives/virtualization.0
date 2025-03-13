Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3726869C
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880249; cv=none; b=gZZdLl0a7bteAclyQMqUoSLaltGHrpsuHdqqr3nUQwUgfbQbxz4xRGGgmusuu4jqfh3wQ7g5X2FOvGdPV7jGhrMNYNyjrOsFEgnpXWnSUIgDN/ZawhFlX+o9vhLJhwhoCmZY9gPb5QZqBh7HeVms5CEkDR3jk5+qyWV5uvQY+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880249; c=relaxed/simple;
	bh=Y77Em3/niRgA67iEpRFgCcPBmNOvas3WDyQvzjEYZrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XkmRG8R434ecASvPi/On2EdgfWC1fLvn6rlhG7Ofcb5Yk8ygdFnWpBTxc8ISSwfB7q0N/x3cT3OpPcwOwzFzCTuSo6LLjI0cIwRpSYos70MoyDVsCs+eU2E/QI8GbsOP5ni6tD3/qTp08MwokTt6AfdIGi08ao4RDSjZjjbPt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fECgTV8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fECgTV8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741880246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TozB4Fx8fnL74+/ZdpiLO6KqtqXqLhZ7FUHL1U433aE=;
	b=fECgTV8p8SILYt+K9zAKo7uagrzy93jdw4CPMngiLwtrHDH7DtNaqkFEX+fTlZg+U1WtiM
	aD2wxdmjODvTF0bOmK/w/5S8DudG33XgeW7vNQqJdT33tvfERH3TqY8G9R5wKDHTduElGw
	bhLZ2+WMA1RRM+ivRIVaFZhiEXT9H1I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-hveuW6MnOIy-y97Y8wdw5A-1; Thu, 13 Mar 2025 11:37:23 -0400
X-MC-Unique: hveuW6MnOIy-y97Y8wdw5A-1
X-Mimecast-MFC-AGG-ID: hveuW6MnOIy-y97Y8wdw5A_1741880243
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so709041f8f.0
        for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 08:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880242; x=1742485042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TozB4Fx8fnL74+/ZdpiLO6KqtqXqLhZ7FUHL1U433aE=;
        b=iIuZwLLjcRczcUmGxgshKD0alaziMEQ5Wnch92pwzfO0Eq7BcKXtoo84Hzx3uwBruJ
         9m6haXX44WQixQVprkNWaz00FZyRYql8xqZuqGB/jd13zKyS3U+oJ93dVZGCUe8TM/Kb
         p1wVzSLk/1TBVP/ofwesFTjF9Hs8kc8H3Mqu3yZn4OYOH1LMkidrn25FdW+2Cf61hE2L
         Df2tvzzZggoaw4bQwJyLmi85LJuYV4YfiIFYHdSTQIVUO3O84d+5iufzm8ji/tzk3/jE
         4a1sgsuka/6N5Fq7yVcf9jkwoYLFva1uDPZAaHoCo5aPI7cI/LUbGi5EUudewjpffFQM
         QfnA==
X-Forwarded-Encrypted: i=1; AJvYcCXwy8iR8rfCM8VV9pgIOkNZySHmDYzNnu/Hm1VV9mO2tpYRw9R8MUEVOmV/M6qv8K0/RfrMRg+XXTDTBrKWrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsVU5ZBsGl8SeVRlN3fSwjd8UvXq/1aRPdUVOCkVZ2cECqc71k
	XZYy7QunIOO9OFLv2dFbJcx/u6aebDyCJ0LxP+Mr45B8hKKBSAr5OGCIl89Hi/HjK46nR65sYaH
	vX32Vzar1Q7l4BIaj7mxc9hUOLPF9aptBRw0zWWc07DKdJwpDA8+NHK6JdwSuS/gY
X-Gm-Gg: ASbGnctLf2GQEDiS/0IMTBlq8VSpFwWo5jseiqcEXZVLWDZ4ueCiNL924yzeEOvT9fq
	pp46T4+MbMoULfCCyvq2YxnV083JAvDr8g99msE7dWttO4UDcqUag3+nAkQhVpFLeEVlZHvD8V5
	4ewwBupA7qv3uW+duC8yRnIh1OA0FqF2iOv9rVhxaM4zmVcF+bBgrhOKFHtixJkppFNr8UUmKj3
	qez3yNnbGQFXOaPh6WjsqkuPgqetmp82Sr7UORR9/NT8UAYJYH4YwTSjZ+J+Yjoo+xU5bclDtda
	X6NbDvLeoJxeXV00ifiGD/Z7bWzbQKaEsfnnQ+Ar/rTuTNX68DOXh/zzu3eZ+o5A
X-Received: by 2002:a5d:6da3:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-396c1753759mr12317f8f.1.1741880242298;
        Thu, 13 Mar 2025 08:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF02exxmoWcKdhQRrcSKqOBNvSNn3RWXG71ebE8fKId+jw35Z2l6uHrxPDWlYovTWlQpC4iSg==
X-Received: by 2002:a5d:6da3:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-396c1753759mr12284f8f.1.1741880241718;
        Thu, 13 Mar 2025 08:37:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a731265sm57233895e9.4.2025.03.13.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:37:21 -0700 (PDT)
Date: Thu, 13 Mar 2025 16:37:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <zz5fnulfljo6hyxaveseq3dxfgljfs33m7ncsw6uod6wouaqhl@jzdmg6s7g5dw>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <Z9JC0VoMwAHKjqEX@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z9JC0VoMwAHKjqEX@devvm6277.cco0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ca-Oi2kZOOe_l01teQUraiDGrtZ8ZkYtzUVNXMGg-7I_1741880243
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Bobby,
first of all, thank you for starting this work again!

On Wed, Mar 12, 2025 at 07:28:33PM -0700, Bobby Eshleman wrote:
>Hey all,
>
>Apologies for forgetting the 'net-next' prefix on this one. Should I
>resend or no?

I'd say let's do a firts review cycle on this, then you can re-post.
Please check also maintainer cced, it looks like someone is missing:
https://patchwork.kernel.org/project/netdevbpf/patch/20250312-vsock-netns-v2-1-84bffa1aa97a@gmail.com/

>
>Best,
>Bobby
>
>On Wed, Mar 12, 2025 at 01:59:34PM -0700, Bobby Eshleman wrote:
>> Picking up Stefano's v1 [1], this series adds netns support to
>> vhost-vsock. Unlike v1, this series does not address guest-to-host (g2h)
>> namespaces, defering that for future implementation and discussion.
>>
>> Any vsock created with /dev/vhost-vsock is a global vsock, accessible
>> from any namespace. Any vsock created with /dev/vhost-vsock-netns is a
>> "scoped" vsock, accessible only to sockets in its namespace. If a global
>> vsock or scoped vsock share the same CID, the scoped vsock takes
>> precedence.

This inside the netns, right?
I mean if we are in a netns, and there is a VM A attached to 
/dev/vhost-vsock-netns witch CID=42 and a VM B attached to 
/dev/vhost-vsock also with CID=42, this means that VM A will not be 
accessible in the netns, but it can be accessible outside of the netns,
right?

>>
>> If a socket in a namespace connects with a global vsock, the CID becomes
>> unavailable to any VMM in that namespace when creating new vsocks. If
>> disconnected, the CID becomes available again.

IIUC if an application in the host running in a netns, is connected to a 
guest attached to /dev/vhost-vsock (e.g. CID=42), a new guest can't be 
ask for the same CID (42) on /dev/vhost-vsock-netns in the same netns 
till that connection is active. Is that right?

>>
>> Testing
>>
>> QEMU with /dev/vhost-vsock-netns support:
>> 	https://github.com/beshleman/qemu/tree/vsock-netns

You can also use unmodified QEMU using `vhostfd` parameter of 
`vhost-vsock-pci` device:

# FD will contain the file descriptor to /dev/vhost-vsock-netns
exec {FD}<>/dev/vhost-vsock-netns

# pass FD to the device, this is used for example by libvirt
qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=mem \
   -drive file=fedora.qcow2,format=qcow2,if=virtio \
   -object memory-backend-memfd,id=mem,size=512M \
   -device vhost-vsock-pci,vhostfd=${FD},guest-cid=42 -nographic

That said, I agree we can extend QEMU with `netns` param too.

BTW, I'm traveling, I'll be back next Tuesday and I hope to take a 
deeper look to the patches.

Thanks,
Stefano

>>
>> Test: Scoped vsocks isolated by namespace
>>
>>   host# ip netns add ns1
>>   host# ip netns add ns2
>>   host# ip netns exec ns1 \
>> 				  qemu-system-x86_64 \
>> 					  -m 8G -smp 4 -cpu host -enable-kvm \
>> 					  -serial mon:stdio \
>> 					  -drive if=virtio,file=${IMAGE1} \
>> 					  -device 
>> 					  vhost-vsock-pci,netns=on,guest-cid=15
>>   host# ip netns exec ns2 \
>> 				  qemu-system-x86_64 \
>> 					  -m 8G -smp 4 -cpu host -enable-kvm \
>> 					  -serial mon:stdio \
>> 					  -drive if=virtio,file=${IMAGE2} \
>> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
>>
>>   host# socat - VSOCK-CONNECT:15:1234
>>   2025/03/10 17:09:40 socat[255741] E connect(5, AF=40 cid:15 port:1234, 16): No such device
>>
>>   host# echo foobar1 | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>>   host# echo foobar2 | sudo ip netns exec ns2 socat - VSOCK-CONNECT:15:1234
>>
>>   vm1# socat - VSOCK-LISTEN:1234
>>   foobar1
>>   vm2# socat - VSOCK-LISTEN:1234
>>   foobar2
>>
>> Test: Global vsocks accessible to any namespace
>>
>>   host# qemu-system-x86_64 \
>> 	  -m 8G -smp 4 -cpu host -enable-kvm \
>> 	  -serial mon:stdio \)
>> 	  -drive if=virtio,file=${IMAGE2} \
>> 	  -device vhost-vsock-pci,guest-cid=15,netns=off
>>
>>   host# echo foobar | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>>
>>   vm# socat - VSOCK-LISTEN:1234
>>   foobar
>>
>> Test: Connecting to global vsock makes CID unavailble to namespace
>>
>>   host# qemu-system-x86_64 \
>> 	  -m 8G -smp 4 -cpu host -enable-kvm \
>> 	  -serial mon:stdio \
>> 	  -drive if=virtio,file=${IMAGE2} \
>> 	  -device vhost-vsock-pci,guest-cid=15,netns=off
>>
>>   vm# socat - VSOCK-LISTEN:1234
>>
>>   host# sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>>   host# ip netns exec ns1 \
>> 				  qemu-system-x86_64 \
>> 					  -m 8G -smp 4 -cpu host -enable-kvm \
>> 					  -serial mon:stdio \
>> 					  -drive if=virtio,file=${IMAGE1} \
>> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
>>
>>   qemu-system-x86_64: -device vhost-vsock-pci,netns=on,guest-cid=15: vhost-vsock: unable to set guest cid: Address already in use
>>
>> Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>> ---
>> Changes in v2:
>> - only support vhost-vsock namespaces
>> - all g2h namespaces retain old behavior, only common API changes
>>   impacted by vhost-vsock changes
>> - add /dev/vhost-vsock-netns for "opt-in"
>> - leave /dev/vhost-vsock to old behavior
>> - removed netns module param
>> - Link to v1: https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com
>>
>> Changes in v1:
>> - added 'netns' module param to vsock.ko to enable the
>>   network namespace support (disabled by default)
>> - added 'vsock_net_eq()' to check the "net" assigned to a socket
>>   only when 'netns' support is enabled
>> - Link to RFC: https://patchwork.ozlabs.org/cover/1202235/
>>
>> ---
>> Stefano Garzarella (3):
>>       vsock: add network namespace support
>>       vsock/virtio_transport_common: handle netns of received packets
>>       vhost/vsock: use netns of process that opens the vhost-vsock-netns device
>>
>>  drivers/vhost/vsock.c                   | 96 +++++++++++++++++++++++++++------
>>  include/linux/miscdevice.h              |  1 +
>>  include/linux/virtio_vsock.h            |  2 +
>>  include/net/af_vsock.h                  | 10 ++--
>>  net/vmw_vsock/af_vsock.c                | 85 +++++++++++++++++++++++------
>>  net/vmw_vsock/hyperv_transport.c        |  2 +-
>>  net/vmw_vsock/virtio_transport.c        |  5 +-
>>  net/vmw_vsock/virtio_transport_common.c | 14 ++++-
>>  net/vmw_vsock/vmci_transport.c          |  4 +-
>>  net/vmw_vsock/vsock_loopback.c          |  4 +-
>>  10 files changed, 180 insertions(+), 43 deletions(-)
>> ---
>> base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
>> change-id: 20250312-vsock-netns-45da9424f726
>>
>> Best regards,
>> --
>> Bobby Eshleman <bobbyeshleman@gmail.com>
>>
>

