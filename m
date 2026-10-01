Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA538B7A5
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843540; cv=none; b=ogi2s22m3A8PvKkrst9jE6a1cCNKD8yxvNWJSw0L947Wbl6H7lQOzH1TVBjO+wACF4pftxR8dMPcR4s1DftMoGgpXcCtJHiX6P33LTvAgzRrQXMvwC7wFWAnECRQSC67UEADwvY0R1a4HJjVEPiAs9K/4i1RfOocZm/ceIxCIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843540; c=relaxed/simple;
	bh=snseJyIZhYVpDz4WCs8HOKzLtfTRvl/CCa6utsUZeeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kFuUYvOmIiLeIO9Otjr79rHRJJn99VZjKEgagXcthE0zzN4t5pgNdplsbCM0ykn+lLKNUPsGF9cAQcDceRLvvfJwvdRmUkJFToR5mZHuvn85T0xToGCOAxzmMRgcsOBvZippM0QM/szZ9EC+bK8m00WrqNyJ9goWGZSvMdE9J24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/3WeptS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/3WeptS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790843534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96UgSydltxa/aXK5jn89QtK6huSyIDJAMZTOZOEjhK8=;
	b=K/3WeptSoOCZPCFUlTlPkLS36qpXPRP87a/+ShhOxLJzXlCy8vCC5vacSAip8AOsAP4UTk
	vNA1c0BODGysWdC79x+opMtxjqN4K1rPJdizNF4WS4gJLLUbPfS0nZgvddLrr/4rQA1jWQ
	Qm/QCxPixEwPCJaGiOFIxFJCuJ8BVrg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-gk7jz__fOW2HAlOG26wIfw-1; Thu, 01 Oct 2026 04:32:13 -0400
X-MC-Unique: gk7jz__fOW2HAlOG26wIfw-1
X-Mimecast-MFC-AGG-ID: gk7jz__fOW2HAlOG26wIfw_1790843532
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0023f2b97so23027935e9.2
        for <virtualization@lists.linux.dev>; Thu, 01 Oct 2026 01:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790843532; x=1791448332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96UgSydltxa/aXK5jn89QtK6huSyIDJAMZTOZOEjhK8=;
        b=SBJE5kCRugwYTFnvLQXJYmETtdWVLzX6xw7hZSq8GFH1Z/VS7iRpRy/aqV1s5ZDDHT
         Mwl+cZXFgDyaVUIAEkd+LW7dbB9vF9r3PNtyiC7EU1e1Xm+O3RSfsNRGMEeHzDuQij1E
         eqcC+88SxDoxIlX+39Fq8DROUcMxt9ng61DIkXPt3/Yd1/bAbPiy3WFfKfmjP7B7Y+xV
         Dug2IuEmge2D0KX9WzJrR2WHGlVTlyoaIgDO7cURUgmNrCDxfxtOePYtsicZBKZ7Nd1Q
         6moL5eV6+d/G0wFP+w4bCqnNvcvXiL12HVjr0bXCBoTPpy7hYfUf6sA3NfJRRM5nGb9y
         ZRpA==
X-Gm-Message-State: AFuF++mkoyPa/OCjd1+SiCtfRZcam2hTRwmo5XRXTKRK+hgJ494qGZcw
	D1EwFmy/m9df0PAH5oxrdYe1W+oyu2GRKuKa5zUeANDC34hhWt3TPqrWQd+XkBxpEOiZMoiw6G7
	41cJfy3ASzSJU0Ac6bZZ1soxvvB+AJNvuPIAeRxy0XBtRxcrimK9Varkp6V10Q7YmjQYd
X-Gm-Gg: AYBFou0hQIN7FXMhfya7u55NiVJ9HGbh6+Ehr0IXnN23LOGjbW15eMGFZSnu78va1tA
	SHEh0ArouX8NR31Yb7WRvvIWrdRUpt4IvSUTDs6ENNWfFFgiwg10DvykIbaNw79hwUCfESIRFZd
	rdECTIqdoqdDGoUBGSE2plzv1zHTij5A0CQlvqQvryuaq9ZxXUUKkcz90cq9kSrryK5Yd2s02Cn
	iquU35nF+8zRivlpNvaKqlEtWaOleXq1QBEXF2QYEQKOaKTMcAkZwWBYAWR/ApAn0Wlvb/A8N6t
	Z3dAqW5WW9TlB0fJH+tCFt1cZVLv9YjoTFQGByERqqXJwpyCLE9ymjV+8RNyKdjTHNl4xSHSrDk
	LHCoIlTS9b78=
X-Received: by 2002:a05:600c:45d3:b0:49f:df99:ff1a with SMTP id 5b1f17b1804b1-4a01affcfa9mr56849185e9.17.1790843531647;
        Thu, 01 Oct 2026 01:32:11 -0700 (PDT)
X-Received: by 2002:a05:600c:45d3:b0:49f:df99:ff1a with SMTP id 5b1f17b1804b1-4a01affcfa9mr56848705e9.17.1790843531145;
        Thu, 01 Oct 2026 01:32:11 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.112.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690d284sm4627928f8f.17.2026.10.01.01.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 01:32:10 -0700 (PDT)
Date: Thu, 1 Oct 2026 10:32:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>, qemu-devel@nongnu.org
Cc: virtualization@lists.linux.dev, rust-vmm@lists.opendev.org, 
	Albert Esteve <aesteve@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
	Matej Hrica <mhrica@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
	Gurchetan Singh <gurchetansingh@google.com>, "Jorge E. Moreira" <jemoreira@google.com>, 
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, Alberto Ruiz <aruiz@redhat.com>, 
	Erico Nunes <ernunes@redhat.com>, John Ferlan <jferlan@redhat.com>, 
	Michael Tsirkin <mst@redhat.com>, German Maglione <gmaglion@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, t.ampelikiotis@virtualopensystems.com, 
	harald.mommer@oss.qualcomm.com
Subject: Re: Invitation: Virtio and Vhost-User Ecosystem BoF - LPC 2026 (Oct
 7, Prague)
Message-ID: <ar4aTDEPwCbmjR3a@sgarzare-redhat>
References: <CACzuRyxNzJ7E_K0zL3J4F9MGm+UX01uRkNhtEXKOHT732JytBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACzuRyxNzJ7E_K0zL3J4F9MGm+UX01uRkNhtEXKOHT732JytBA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WnbE9E-SMXD42g21ZAZG1riRSWm-Jvew10kZQzUo3n4_1790843532
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline


+Cc qemu-devel

On Wed, Sep 30, 2026 at 06:38:42PM +0200, Dorinda Bassey wrote:
>Hi all,
>
>I'd like to invite you to join us for a Birds of a Feather session at
>the Linux Plumbers Conference 2026:
>
>"Virtio and Vhost-User Ecosystem for Production and Automotive Systems"
>
>When: Tuesday, October 7, 2026 at 17:45 CEST (UTC+2) (45 minutes)
>Where: South Hall 1 B, Prague Congress Centre
>Speakers: Dorinda Bassey, Albert Esteve, Stefano Garzarella (Red Hat)
>
>If you are unable to join in-person, there's also an option for remote
>attendance,
>See the link on how to register: https://lpc.events/event/20/page/267-attend
>
>Description:
>The vhost-user protocol started as a simple QEMU feature, but it has
>grown into a standard used across the entire Linux virtualization
>community. Today, it powers production workloads in the cloud (e.g.
>QEMU and cloud-hypervisor), lightweight environments like libkrun, and
>modern automotive systems.
>However, as the ecosystem expands, we are hitting new "plumbing"
>bottlenecks. For example, the protocol specification is still stored
>inside the QEMU documentation, which makes it harder for other
>projects to participate in its growth. At the same time, automotive
>deployments are introducing strict new needs, such as safety
>certification, real-time performance, and long-term support, that
>impact everyone.
>This BoF will bring developers and users together to address these
>challenges and other emerging topics across the ecosystem. Our goal is
>to establish better coordination, align technical roadmaps for both
>cloud and automotive, and build shared tests and tools to ensure all
>implementations work together.
>
>Key Discussion Topics:
>- vhost-user Specification Governance: Discuss official location for
>the vhost-user specification
>- Automotive Virtualization Requirements & Reference Platforms:
>Coordinate deployment needs across Automotive platforms [1]
>- Real-time performance needs (camera, display, CAN)
>- Status Update: Ongoing work on vhost-user device (virtio-Media,
>virtio-can, virtio-rtc, etc) [2][3]
>- Graphics Stack Alignment: on roadmaps for shared dependencies like
>rutabaga_gfx across libkrun, crosvm, vhost-device-gpu [4]
>- Shared Virtio Message-Parsing Crates: Evaluate creating unified Rust
>crates for Virtio device specs to share virtqueue parsing logic across
>backends and VMMs
>- Open questions about:
>  - vhost-user Specification Refinements: Identify protocol gaps,
>missing features, and necessary standard improvements
>  - New Virtio/vhost-user Device Proposals
>
>References:
>[1] https://source.android.com/docs/automotive/virtualization/reference_platform
>[2] https://lore.kernel.org/virtualization/ab2FlQTWUxl0KmlT@fedora/
>[3] https://github.com/rust-vmm/vhost-device/pull/944
>[4] https://github.com/magma-gpu/rutabaga_gfx/issues/24
>
>Session details: https://lpc.events/event/20/contributions/2365/
>
>Looking forward to seeing you there!
>
>Best regards,
>Dorinda Bassey
>Red Hat
>

