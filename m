Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D17347C
	for <virtualization@lists.linux-foundation.org>; Tue,  6 Aug 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967055; cv=none; b=IPb4pbdf2U/BDZMFdx9m2jcJRdur+rYt94hd3Kqgrdst+0xHvVYhmSAAb/p2RLYfRszoak6SLpxFJbU3TZKsJ20yJ3ZPz8QebVH1aAPz4KJdpDav9r3SRmh/38YxcPmep+NaJtQKqY/f34gQ5hYXKyOzV+KNAfVpvPzBqOUfNJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967055; c=relaxed/simple;
	bh=Y3kpDopP34wSS4aefVZmlrz8cQFzCX6exogFHU3d/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p2f7Iuvs5IIcyfZGKCC/oipOWS6hd0nauz1X3kpb7eUMUPQmw/ozS0RDL4D1Y0W9Grhm3sYgN5kzKI8V3QP8WnvV807mTPb0DMAjGzZt12A7NbZS4JIQuV4SfdyGnnEWhV3tONXqvNbok7LzEgMINMtLGbzzWQhQmcphmNdJjrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AF8ql0cm; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AF8ql0cm"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B54DD80E24
	for <virtualization@lists.linux-foundation.org>; Tue,  6 Aug 2024 17:57:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dm6uEB3X3cvh for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Aug 2024 17:57:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B2D5580E1B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2D5580E1B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AF8ql0cm
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2D5580E1B
	for <virtualization@lists.linux-foundation.org>; Tue,  6 Aug 2024 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722967051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PCE6y3gd/ZLdIqr+zXDfXpXA+sJAwSBPUwATht6B/14=;
	b=AF8ql0cmMzJaX74Hz9Q9/NgpsyBfPIbkgAiqn5eTMl2eMqnU8Gq/a8llaFiI2XcvnvlbCg
	y0+iSY7dGQiaEPZIEHEuAahgxkW7nLxPMqIdAao3xdEvCfdFtgr/QFe31oOh8dIeMIPaAJ
	Vmkqa7Tum771jT+e85c8eaycn9GXdGM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-KSqM-0ryN0eyuGZGH6CytQ-1; Tue, 06 Aug 2024 13:57:29 -0400
X-MC-Unique: KSqM-0ryN0eyuGZGH6CytQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a7b5bd019cso803488a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 06 Aug 2024 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967048; x=1723571848;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCE6y3gd/ZLdIqr+zXDfXpXA+sJAwSBPUwATht6B/14=;
        b=gMEJx5aM9EEVlHtDxGlK7ESDyVIidO3z+qHPHvnCmxO8SkgloDt+S5/fGFNytWiQN2
         sd4e3VLIti8Dr6qOdpSRVtnn2e8oo9ohA1EIslMDCvwp/NaQvLwaGCb0LxNtQJivvMnS
         DhtNxGcnlPxUCWLzHnJ9hB8b/UfP7Nqc2WWHbsl/ormN9Gu9esk7TXDGRpfnTO1Vcqfr
         M6IeOndik9KKnO64zbX4rDKulpRnUUECcpBFmpHpSGv1K/bVHSYNPhlv4r5ad5pWicZI
         NkefZDVbUb+chkVyiXn6X8IPFe/Eqz0sbs9KoaNSRCfFqF4SxM3rLaPL90SIJmzGJAI4
         0EUg==
X-Forwarded-Encrypted: i=1; AJvYcCXy5oc+3Qt1RFmHVhReD6LBA56iPl2rdl9rSjWQvVpsB8DGYqIQb3YqJEsEt3GnByEUuDfn/aSxBqCWrGOVYfZM1lezaLNmDk6lRYvz59eSQ8frfk9cxbQFhQ==
X-Gm-Message-State: AOJu0YwTKFKhSVTqZ9LZy3i4HUfoay1C2BnPKgvGgI/IrVLNHZiXfNXk
	s0CGjuPNKa0ByuhdeQ8qMSgi1/m/RHFt8ES5x2Xa+tYooOwu7NBYhyeLbdM4r2cUbFoMJVCDVfM
	iL3+V82n/3AS1Plg+YCF9Ho6aPJpwXxsYIuyir1sood4PylxCbjadqaZPaUUutBLiOPLXLYhRFB
	u5I84=
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5b7f5dc5d68mr10453930a12.36.1722967048121;
        Tue, 06 Aug 2024 10:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9wiBpXfkiQpEvZZyARq7/ap2Ik8pTsT+kT/0l0ZHqK+AvR7K5fHmkyUYpLFX0WwVH0aYZHw==
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5b7f5dc5d68mr10453907a12.36.1722967047202;
        Tue, 06 Aug 2024 10:57:27 -0700 (PDT)
Received: from redhat.com ([2.55.35.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba442ed7f1sm4421307a12.81.2024.08.06.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:57:26 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:57:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dtatulea@nvidia.com, jasowang@redhat.com, mst@redhat.com,
	stable@vger.kernel.org
Subject: [GIT PULL] virtio: bugfix
Message-ID: <20240806135722-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6d834691da474ed1c648753d3d3a3ef8379fa1c1:

  virtio_pci_modern: remove admin queue serialization lock (2024-07-17 05:43:21 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 0823dc64586ba5ea13a7d200a5d33e4c5fa45950:

  vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler (2024-07-26 03:26:02 -0400)

----------------------------------------------------------------
virtio: bugfix

Fixes a single, long-standing issue with kick pass-through vdpa.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler

 drivers/vhost/vdpa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

