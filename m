Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693D1465A0
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461217; cv=none; b=dB8JKvyBolxep3geXwk4H5SGHybRcZ2dr7qksGBlbsY6j+gCwSSRutn6IeZvW/foip9WTcGPL6EYNP6Cth3iG/3ZX2wT5vC8LMillJffCP6e4X3YkED2E+5WvVNhLKIhAj0lrWwGO+pfhFsiRLtPI+HhC88WoFsfYNMdTfLOFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461217; c=relaxed/simple;
	bh=iQ3P7ytni9AIjalxjfPLxS1i4uht+yfn7fa1wRJhkPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Oup3oEpSwEN4vMbJ6IceEA65Nj1v+pwMvdZU/AZoG3OCJDienFQCIwqk2AQfHEOPj9YUKZM+MyRtgq8xJ1oNFNZ6idSG1MmoOMVuIXcFHU3gJnN/rWymp3yXDVSLCxMSEJ0RY4e606UEWltMi/5CkSvLRu2+MBoymr2oqULN2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHKrJSiq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHKrJSiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716461215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyjB8EQOWovyipEoWCgaFp7DoAbCqwJISn6BYO3MOco=;
	b=SHKrJSiqw6fUPccFDIMoyJNtmQwe9KgmGhcCptVOMWDB95sElAue/h05vOI1Ny9kCDkrZy
	tBJih3gYsVsMp7PyJfpvjLJ2wOGOffFQFx9/K59riD8hLKuY19nPw5t2NW2M1pKZMDpyTo
	C7M5/eAnVUBUbdXigiuHowejqoo3oYI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-3rQ76hR3Pka8kAGzwJsjcw-1; Thu, 23 May 2024 06:46:49 -0400
X-MC-Unique: 3rQ76hR3Pka8kAGzwJsjcw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43f8e015e34so41279791cf.3
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 03:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716461209; x=1717066009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyjB8EQOWovyipEoWCgaFp7DoAbCqwJISn6BYO3MOco=;
        b=vqZitYH8tzVaVoYXREbZd81MWglP+eOow/DsSeiCTXlq032N4mbVrDSepgAADnxOxY
         +i5g1hUL/chnQLc0Rmr53yF01sqljUwE1wn0YEzJonVKV4z5HSSdJIUgvPxee4yWz7CI
         ou7DGWaMUbVv1yq2hSAYWX4rh3/JPiXhzrwxZZLD1AXjgOhFd0COnMAAMVHcd7CW9A1z
         G45NVHubz44/PReSbGgh9sJhbrgQ0kBSqsiWioBvCao6XZopDeY3h0bBeKDtdzF8y7di
         VRs2AJUXSNz5HPgLvlYZCWNVIA8ip8gJOJVdnP6X5sDy4fADLsK9YQW+XFbepp9NYIik
         fcWA==
X-Forwarded-Encrypted: i=1; AJvYcCUuJ3eyz99Jg7atub77qrehgBxdA/IK0SYMVPjLJQhPo3/q4hn5VV8vOxuppY/Zl7nJCCCarGI3FXGe8DKq9S5HjwfuxqyC4uwiHG2SjnQ=
X-Gm-Message-State: AOJu0Yz/zg2QimfEGDohCG+Ew3W3gs//GWAwXSq2Gilu1AhNFJM5iHwm
	nmGcaIcxL1YzhuCzM15AxtxFElvSrqidKJbw6UKpDNPNlNAALQ4Oi7SKh68vITdOQU6rY9ZKGvY
	UOZQJVoZJrV4NpYMwCH8jqa3IMkbpaY01rQzqVQz8lrVGq6JZYcMfpXOuOlq/1V0r
X-Received: by 2002:ac8:5dd0:0:b0:434:5008:3bd3 with SMTP id d75a77b69052e-43f9e0c5b39mr62062411cf.23.1716461208550;
        Thu, 23 May 2024 03:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB/iXgse940hkckYv02XgQCMFgs44epPyBlQeySAf2cYExIFsi0YPz/luKMHz3Bh96Do23dw==
X-Received: by 2002:ac8:5dd0:0:b0:434:5008:3bd3 with SMTP id d75a77b69052e-43f9e0c5b39mr62062221cf.23.1716461208092;
        Thu, 23 May 2024 03:46:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e19256258sm139970761cf.49.2024.05.23.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:46:47 -0700 (PDT)
Date: Thu, 23 May 2024 12:46:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 0/5] vsock/virtio: Add support for multi-devices
Message-ID: <hloqtbnyooawma2fhfvtblgabiebonskfkoky2invqasikhg42@gwvmreq2ysy6>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
thanks for this RFC!

On Fri, May 17, 2024 at 10:46:02PM GMT, Xuewei Niu wrote:
># Motivition
>
>Vsock is a lightweight and widely used data exchange mechanism between host
>and guest. Kata Containers, a secure container runtime, leverages the
>capability to exchange control data between the shim and the kata-agent.
>
>The Linux kernel only supports one vsock device for virtio-vsock transport,
>resulting in the following limitations:
>
>* Poor performance isolation: All vsock connections share the same
>virtqueue.

This might be fixed if we implement multi-queue in virtio-vsock.

>* Cannot enable more than one backend: Virtio-vsock, vhost-vsock, and
>vhost-user-vsock cannot be enabled simultaneously on the transport.
>
>We’d like to transfer networking data, such as TSI (Transparent Socket
>Impersonation), over vsock via the vhost-user protocol to reduce overhead.
>However, by default, the vsock device is occupied by the kata-agent.
>
># Usages
>
>Principle: **Supporting virtio-vsock multi-devices while also being
>compatible with existing ones.**
>
>## Connection from Guest to Host
>
>There are two valuable questions to take about:
>
>1. How to be compatible with the existing usages?
>2. How do we specify a virtio-vsock device?
>
>### Question 1
>
>Before we delve into question 1, I'd like to provide a piece of pseudocode
>as an example of one of the existing use cases from the guest's
>perspective.
>
>Assuming there is one virtio-vsock device with CID 4. One of existing
>usages to connect to host is shown as following.
>
>```
>fd = socket(AF_VSOCK);
>connect(fd, 2, 1234);
>n = write(fd, buffer);
>```
>
>The result is that a connection is established from the guest (4, ?) to the
>host (2, 1234), where "?" denotes a random port.
>
>In the context of multi-devices, there are more than two devices. If the
>users don’t specify one CID explicitly, the kernel becomes confused about
>which device to use. The new implementation should be compatible with the
>old one.
>
>We expanded the virtio-vsock specification to address this issue. The
>specification now includes a new field called "order".
>
>```
>struct virtio_vsock_config {
>  __le64 guest_cid;
>  __le64 order;
>} _attribute_((packed));
>```
>
>In the phase of virtio-vsock driver probing, the guest kernel reads 
>from
>VMM to get the order of each device. **We stipulate that the device with the
>smallest order is regarded as the default device**(this mechanism functions
>as a 'default gateway' in networking).
>
>Assuming there are three virtio-vsock devices: device1 (CID=3), device2
>(CID=4), and device3 (CID=5). The arrangement of the list is as follows
>from the perspective of the guest kernel:
>
>```
>virtio_vsock_list =
>virtio_vsock { cid: 4, order: 0 } -> virtio_vsock { cid: 3, order: 1 } -> virtio_vsock { cid: 5, order: 10 }
>```
>
>At this time, the guest kernel realizes that the device2 (CID=4) is the
>default device. Execute the same code as before.
>
>```
>fd = socket(AF_VSOCK);
>connect(fd, 2, 1234);
>n = write(fd, buffer);
>```
>
>A connection will be established from the guest (4, ?) to the host (2, 1234).

It seems that only the one with order 0 is used here though, so what is 
the ordering for?
Wouldn't it suffice to simply indicate the default device (e.g., like 
the default gateway for networking)?

>
>### Question 2
>
>Now, the user wants to specify a device instead of the default one. An
>explicit binding operation is required to be performed.
>
>Use the device (CID=3), where “-1” represents any port, the kernel will

We have a macro: VMADDR_PORT_ANY (which is -1)

>search an available port automatically.
>
>```
>fd = socket(AF_VSOCK);
>bind(fd, 3, -1);
>connect(fd, 2, 1234);)
>n = write(fd, buffer);
>```
>
>Use the device (CID=4).
>
>```
>fd = socket(AF_VSOCK);
>bind(fd, 4, -1);
>connect(fd, 2, 1234);
>n = write(fd, buffer);
>```
>
>## Connection from Host to Guest
>
>Connection from host to guest is quite similar to the existing usages. The
>device’s CID is specified by the bind operation.
>
>Listen at the device (CID=3)’s port 10000.
>
>```
>fd = socket(AF_VSOCK);
>bind(fd, 3, 10000);
>listen(fd);
>new_fd = accept(fd, &host_cid, &host_port);
>n = write(fd, buffer);
>```
>
>Listen at the device (CID=4)’s port 10000.
>
>```
>fd = socket(AF_VSOCK);
>bind(fd, 4, 10000);
>listen(fd);
>new_fd = accept(fd, &host_cid, &host_port);
>n = write(fd, buffer);
>```
>
># Use Cases
>
>We've completed a POC with Kata Containers, Ztunnel, which is a
>purpose-built per-node proxy for Istio ambient mesh, and TSI. Please refer
>to the following link for more details.
>
>Link: https://bit.ly/4bdPJbU

Thank you for this RFC, I left several comments in the patches, we still 
have some work to do, but I think it is something we can support :-)

Here I summarize the things that I think we need to fix:
1. Avoid adding transport-specific things in af_vsock.c
    We need to have a generic API to allow other transports to implement
    the same functionality.
2. We need to add negotiation of a new feature in virtio/vhost transports
    We need to enable or disable support depending on whether the
    feature is negotiated, since guest and host may not support it.
3. Re-work the patch order for bisectability (more detail on patches 3/4)
4. Do we really need the order or just a default device?
5. Check if we can add some tests in tools/testing/vsock
6. When we agree on the RFC, we should discuss the spec changes in the
    virtio ML before sending a non-RFC series on Linux

These are the main things, but I left other comments in the patches.

Thanks,
Stefano

