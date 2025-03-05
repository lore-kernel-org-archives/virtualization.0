Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F924EA94
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190081; cv=none; b=ayGy/h9MJmOg3xtbKxy5mUaNO1CV3+ciwysVJdjIhRhKhlzbsMWMWgHjMwzQsGWCDACDKkfLD/Mb5ACEweBaLWKL3EntrN2lmnoWjsDJbqO/9BwY/GudWirejLSPWqiRVCRDn/QOcrsf4xiYCHmU7av1kmtwSx4BjwhjeS2Dm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190081; c=relaxed/simple;
	bh=ruhS78A+AtEtKl22culYdzmPSc1jjG/Tbxd9IG/FgJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb7I7Vlr8rcEd20MCxOWTi4DToH7G67iybyR61nXyqj4SbauoNdPkIbIaHHYD8HGWOUctpDzYTM3XbnW5EmC3myAVUNvv8HbvtrB05DH3lHAle4UfyssYeGnRMmGOa+iI4F/CPvMD40wv62Vk/TDBtuTieV0n86OYNcTVYG41ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJZUsNmE; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJZUsNmE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A589B60884
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 15:54:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kaZjsRSMZkVI for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 15:54:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=bobbyeshleman@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 01C1B60733
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01C1B60733
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BJZUsNmE
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01C1B60733
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 15:54:38 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2234e5347e2so144457145ad.1
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 07:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190078; x=1741794878; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vIc0DMsQO6eS51lnk/KHT+RqFvDL3u0FZpOodk49SU=;
        b=BJZUsNmEuHUstE76rErUQIfgkOGpwxJvZVDFLwjtCmoNh8FZ1oFydKbIu8dlz57YFz
         vQ0Q/K71IL/0hNRHGxOwL7ji04jTt6r2vcpQVEmKCz3tcOkXNktzWrjy09zgGNVncaxy
         tqQoQkq61Rivvjsf+YPIYWSa+9UGm04F3EGIXthXWMGAYP01EqmCruei1KxCLkQx5RQY
         HHukOVh/gM+iSFXkDcMsX9n6yynhZDi/yPbswUVA2duAy1F4NwVzJK9EoXLC/6jOQ84/
         5F9n4dHFHL19zvpicNfjlW2uOKwnXpb9Rvz3tlOYVbDEQiUn7W5FJ8R0QhZ72zjXJA7A
         Io5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190078; x=1741794878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vIc0DMsQO6eS51lnk/KHT+RqFvDL3u0FZpOodk49SU=;
        b=EBaGfyw0JnXwy+k+EqJFKfZTdCwuNf6KMUrnO2rxNqAUlc02fgDLcfa96Bdojur4wQ
         rMs16h0jnBq2WQ7PURop0CtfrPL9b2boXlkOxkhXDgLiuBmPyryE/faditbcPRUp+esD
         O+/yRDJqBDgIBo6NSGpP2PAcJU4te57cRDY+oYX2SZd8Qhsn3HnZ8CRqEu6HMAAuRCp5
         gJoCF5AMx+xmykAUNeCOPDVswCoLyHm67QtOv4eHfgot6Md+/Y0KGpNEmWZsCSU1BzGi
         SAPu6/zG/C88dOKINSO+9WPsLlmMEtp09r1fCTrfUKT4zE9iz55CBOXaRxWJczGqrRmv
         t7uw==
X-Forwarded-Encrypted: i=1; AJvYcCWxQ0/ktZFyUsOXsFpRZL3zKU472jgciwhfHG2vihwH4I0rAtNADtXlNOqRAU2MfpP5w0b02oeVIQXaK6BoXA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yygadlw9inZUN2yPUSerhxQcUJ/iPPkmxZDoM0+jpQij4B/If5v
	AHs99q58wiRlZe6M14hi+27Y+FuDfBwXqvKppPRSIbPqYIo5C2lT
X-Gm-Gg: ASbGncsTtfXRe7ZKWSDCsJhNlBd0acWUKRRQilDJKyeLwMG0zMZo8wk5ir6mylR9RKV
	H6GbZrU3T8+eeku3Z8SZqIZLrOyw4EbiGHQE0brlSMPVeXb1PITUU256SyIQ0WXbL6tpTKT0Bry
	GbJwO9CCgyDAwtyipEDHAU/vCJJmIoampVEdUanNgxtBCsvIlstx+es3AH9UeTA2ZpawzySi45j
	W43nil41hdW3S3FYOvWhz5H925CcAhEAz5CMHS+gO3tBUohuwUr+HchoOYzBkBsDOx8H5jeWK1L
	qlrfpONVANW/OFgZBGRvmgoG0xvNQIEaX5bljGsNWdZDmJ1PfFDm/If1kZMPgVXX2w==
X-Google-Smtp-Source: AGHT+IGxwYNgRJxj/Y20mv0OZbh6G4d3argbKiFxAPkI+V5vuufD3HZdLhPGHXdzRe1CMg/k0x2Reg==
X-Received: by 2002:a05:6a21:78a8:b0:1ee:e58d:aa67 with SMTP id adf61e73a8af0-1f34945f651mr7240995637.8.1741190077952;
        Wed, 05 Mar 2025 07:54:37 -0800 (PST)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af15490ae3csm9391147a12.78.2025.03.05.07.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:54:37 -0800 (PST)
Date: Wed, 5 Mar 2025 07:54:35 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <Z8hzu3+VQKKjlkRN@devvm6277.cco0.facebook.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org>
 <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>

On Wed, Mar 05, 2025 at 10:23:08AM +0100, Stefano Garzarella wrote:
> On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
> >

[...]

> >
> >
> > I'm not sure I understand the usecase. Can you explain a bit more,
> > please?
> 
> It's been five years, but I'm trying!
> We are tracking this RFE here [1].
> 
> I also add Jakub in the thread with who I discussed last year a possible 
> restart of this effort, he could add more use cases.
> 
> The problem with vsock, host-side, currently is that if you launch a VM 
> with a virtio-vsock device (using vhost) inside a container (e.g., 
> Kata), so inside a network namespace, it is reachable from any other 
> container, whereas they would like some isolation. Also the CID is 
> shared among all, while they would like to reuse the same CID in 
> different namespaces.
> 
> This has been partially solved with vhost-user-vsock, but it is 
> inconvenient to use sometimes because of the hybrid-vsock problem 
> (host-side vsock is remapped to AF_UNIX).
> 
> Something from the cover letter of the series [2]:
> 
>   As we partially discussed in the multi-transport proposal, it could
>   be nice to support network namespace in vsock to reach the following
>   goals:
>   - isolate host applications from guest applications using the same ports
>     with CID_ANY
>   - assign the same CID of VMs running in different network namespaces
>   - partition VMs between VMMs or at finer granularity
> 
> Thanks,
> Stefano
> 

Do you know of any use cases for guest-side vsock netns?

Our use case is also host-side. vsock is used to communicate with a
host-side shim/proxy/debug console. Each vmm and these components share
a namespace and are isolated from other vmm + components. The VM
connects back to the host via vsock after startup and communicates its
port of choice out-of-band (fw_cfg).  The main problem is in security:
untrusted VM programs can potentially connect with and exploit the
host-side vsock services meant for other VMs. If vsock respected
namespaces, then these host-side services would be unreachable by other
VMs and protected.  Namespaces would also allow the vsock port to be
static across VMs, and avoid the need for the out-of-band mechanism for
communicating the port.

Jakub can jump in to add anything, but I think this is the same use case
/ user he was probably referring to.

Best,
Bobby
