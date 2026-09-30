Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61177513551
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786338; cv=none; b=WzWzS7vLlE8E1zTru6tcNgIF0tAhvq1BU1/8AQQVmpEsgReGvJufYTpDpRpddiQn/eSmBm3f4T17voBKvHBmera+NOxoehAjI8Y2O98pFy0QDn7vfpPA3UsEstR1UyuPkaUaPnablvi9afpaer1TLAL38rMmZEx+OeVhu8tFucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786338; c=relaxed/simple;
	bh=o3AW54Bx9T6ClPlwhvEHTfRTekzMJLbGQL0PsTSabaM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pB0mk10Jn7nf0ncIDCuArIlA9dvsllkFt1tI70WNF5OzNmAEg+sleXC3lI4fQgCH1kEwvCChd1e2HvRFYzz+I3nmdp7BG37hH9m2jgyCEhwprzL8U5EkG6X43+yM6oO5gbmggIJGleA9G4FyLHYprmHup4KbmALIneL+8HXWCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZsXla3Tc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsXla3Tc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790786336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ISooFonWzJDEkXzNcPGSh7bpkE+3RidaoragqzSoP2o=;
	b=ZsXla3TccnOVqoAdVWqHkToPkC6lwYOTU/BvIIU/VYKkqfZJWe1d7L67smyySIy2xcnfyN
	bUd9X6adaQaSL9eP8iFliN0tcoSjxIwRSosPUmvoc3LwcPOgCKqpjhSgOnK5VdGf3UQw5z
	EDo5FXUEvM6Faa7qWnioY1L/0WGuGoY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-LkEGU_3hMsSOcKpeU7UsLQ-1; Wed, 30 Sep 2026 12:38:54 -0400
X-MC-Unique: LkEGU_3hMsSOcKpeU7UsLQ-1
X-Mimecast-MFC-AGG-ID: LkEGU_3hMsSOcKpeU7UsLQ_1790786334
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a082c014aso472815085a.0
        for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 09:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790786334; x=1791391134;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ISooFonWzJDEkXzNcPGSh7bpkE+3RidaoragqzSoP2o=;
        b=Y3dE9DqTdeOO+YlVeQGdWURxXZKVrp/4oO51JLI2tW8tjbzrTi9jPqRcJfpVFbaDNu
         lw5gtsIOYJq/KD+n/vT83GdUD5iRNNsVtkePflql/gUoyrHWmccHiPRd1NEESEAb7JZE
         G9lMFDXvMbAxq2kxH2gX98rJWBVNIB3Eo7JH5poQClzgcr+NOs8TmJmyJ8cvXbHSBQR3
         zoz2BBZKeCMOQwI6naTbpAF2rxYWfoWkTSfpuMcNwq9uT4tj+xxgCQY5DCQ9OTmiPItm
         wAzYyAnEEutxq9tCtgE5sj21qAZjiH73TI7okSvxKVpur6r/ezE4O7yIQuF/LyaxpbTE
         L1Bw==
X-Gm-Message-State: AFuF++lvIbGmKsQjOJMs+bZdLX7JyvVLsr5YmMLIiEugdnf8c8B30iVB
	DDEKiHzINRjlWqNo/s0tQ0ZsDAmBANKlmxUJagUa4lPT3meJBFxC0NRNmIENB2G32rtDjfwlpg/
	j74GkNwTlIzkoGbBbeP+EEfbRRmn9htezzd73vMrwQT74jU13eT/BhEvymEZsIasZQPqs+lP/V3
	k8CmG9U4r+jzg1asd/kYJZyoWuduDvuypwimvJf5Evnkq78UoZ7Sy4mpAq
X-Gm-Gg: AYBFou2yNHFlI8CpX8n0jDVt1rdNpuzX4rgB4pZYqoJcMmwJ9ZCUJXsAG5SfO2x0mUi
	LD28Ob5367Qq4zd0D65FpXGF+AGP9cwfTKdTERypA8taGax590aeCPBm+m/MRsVKrGMKZJmd+2X
	MmNZ+wal6AxqWf66yFsjO5PujuBvAom3u6O+qowevyVH9KRV8OSiRxjm+jS0WCYL8ibWqqyw5Lj
	v4WrnAFywCcI8CtfpboFjm20p+gzUcf7g6gQiHYobb1bA==
X-Received: by 2002:a05:620a:1d0b:b0:93c:4e52:6b49 with SMTP id af79cd13be357-93cb5647a30mr41891785a.4.1790786333772;
        Wed, 30 Sep 2026 09:38:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0b:b0:93c:4e52:6b49 with SMTP id
 af79cd13be357-93cb5647a30mr41888585a.4.1790786333251; Wed, 30 Sep 2026
 09:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Dorinda Bassey <dbassey@redhat.com>
Date: Wed, 30 Sep 2026 18:38:42 +0200
X-Gm-Features: AclHuK-tDCVoN3c864mRNBYBuSbpap4NBjU7BIPacL5paXgnrHLI2dX-O4f9S_8
Message-ID: <CACzuRyxNzJ7E_K0zL3J4F9MGm+UX01uRkNhtEXKOHT732JytBA@mail.gmail.com>
Subject: Invitation: Virtio and Vhost-User Ecosystem BoF - LPC 2026 (Oct 7, Prague)
To: virtualization@lists.linux.dev, rust-vmm@lists.opendev.org
Cc: Albert Esteve <aesteve@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Sergio Lopez Pascual <slp@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Matej Hrica <mhrica@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
	Gurchetan Singh <gurchetansingh@google.com>, "Jorge E. Moreira" <jemoreira@google.com>, 
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, Alberto Ruiz <aruiz@redhat.com>, Erico Nunes <ernunes@redhat.com>, 
	John Ferlan <jferlan@redhat.com>, Michael Tsirkin <mst@redhat.com>, 
	German Maglione <gmaglion@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	t.ampelikiotis@virtualopensystems.com, harald.mommer@oss.qualcomm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TkjSn0vhtB6FQeRlFBMx_17AeHnQMz09idDSC7LJsac_1790786334
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'd like to invite you to join us for a Birds of a Feather session at
the Linux Plumbers Conference 2026:

"Virtio and Vhost-User Ecosystem for Production and Automotive Systems"

When: Tuesday, October 7, 2026 at 17:45 CEST (UTC+2) (45 minutes)
Where: South Hall 1 B, Prague Congress Centre
Speakers: Dorinda Bassey, Albert Esteve, Stefano Garzarella (Red Hat)

If you are unable to join in-person, there's also an option for remote
attendance,
See the link on how to register: https://lpc.events/event/20/page/267-attend

Description:
The vhost-user protocol started as a simple QEMU feature, but it has
grown into a standard used across the entire Linux virtualization
community. Today, it powers production workloads in the cloud (e.g.
QEMU and cloud-hypervisor), lightweight environments like libkrun, and
modern automotive systems.
However, as the ecosystem expands, we are hitting new "plumbing"
bottlenecks. For example, the protocol specification is still stored
inside the QEMU documentation, which makes it harder for other
projects to participate in its growth. At the same time, automotive
deployments are introducing strict new needs, such as safety
certification, real-time performance, and long-term support, that
impact everyone.
This BoF will bring developers and users together to address these
challenges and other emerging topics across the ecosystem. Our goal is
to establish better coordination, align technical roadmaps for both
cloud and automotive, and build shared tests and tools to ensure all
implementations work together.

Key Discussion Topics:
- vhost-user Specification Governance: Discuss official location for
the vhost-user specification
- Automotive Virtualization Requirements & Reference Platforms:
Coordinate deployment needs across Automotive platforms [1]
- Real-time performance needs (camera, display, CAN)
- Status Update: Ongoing work on vhost-user device (virtio-Media,
virtio-can, virtio-rtc, etc) [2][3]
- Graphics Stack Alignment: on roadmaps for shared dependencies like
rutabaga_gfx across libkrun, crosvm, vhost-device-gpu [4]
- Shared Virtio Message-Parsing Crates: Evaluate creating unified Rust
crates for Virtio device specs to share virtqueue parsing logic across
backends and VMMs
- Open questions about:
  - vhost-user Specification Refinements: Identify protocol gaps,
missing features, and necessary standard improvements
  - New Virtio/vhost-user Device Proposals

References:
[1] https://source.android.com/docs/automotive/virtualization/reference_platform
[2] https://lore.kernel.org/virtualization/ab2FlQTWUxl0KmlT@fedora/
[3] https://github.com/rust-vmm/vhost-device/pull/944
[4] https://github.com/magma-gpu/rutabaga_gfx/issues/24

Session details: https://lpc.events/event/20/contributions/2365/

Looking forward to seeing you there!

Best regards,
Dorinda Bassey
Red Hat

