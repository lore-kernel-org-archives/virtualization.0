Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F228541A
	for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763278596; cv=none; b=TVudZFN9O2n5ndo4W1u+v4hy3Koxz/9jnQ5N0XNn7Jp6t5bz0O0LPRskOTHbxtOMqwhZJDhGfrSXNeCfe7umwGNqgxom7TjFOxJV//3TFAcpvH3wCj1RtZ2cJlerje+Od4o0LoQTrQA8iZddM9kaLiGUZ7g8HB30THmxs4VuqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763278596; c=relaxed/simple;
	bh=/wU2PjO/9k2SX10eUAJ2SEQukhtmpyHpHIXxtUzeWto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hqlDd2wyRiHgr8yehg7CXbh9gpbTO8rGu9+C+xAZx5mlRAKVl1N29344/UQzQfAcaharkycNWn/CLov6PSBUFifz36i4JzUICItVwUqrGtiCWBoc6Y6vdB5/k6KfCWC8ipzhSAv3Ji74LBBvQgFPkTCpTsf5Gbf62C/XB23tXGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVxE7X4E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVxE7X4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763278593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=b0yaVDVgrAO7aUVp8P++ObXwpVxREDZ1FEXCsETlzo0=;
	b=GVxE7X4ENlScj1fJJahzREgc1flYEwPCrXSsSUeNvy0QILsMt+0JddfiskKjd3DpT1oE8n
	NKrzvPU+/m9j9FEaoul7a3Z96pY8d1GFpcf4ueURE5hIXy0RjSlWZsWEkKP7mKhN3kO0rd
	N0cUerxPlKjb6LorUF8ysMIgO2s9mSM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-mwdun2gBMpGBPUwUAgA3bA-1; Sun, 16 Nov 2025 02:36:32 -0500
X-MC-Unique: mwdun2gBMpGBPUwUAgA3bA-1
X-Mimecast-MFC-AGG-ID: mwdun2gBMpGBPUwUAgA3bA_1763278591
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563e531cso28125765e9.1
        for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 23:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763278591; x=1763883391;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0yaVDVgrAO7aUVp8P++ObXwpVxREDZ1FEXCsETlzo0=;
        b=oyfsCdNKRjzFoxIvwKNfq02SWS2oAoUEl9oeCwDIUzQG2sfwJl+8csVJIXVDzM/4Zr
         4nWRjIDCnSrNH1ZeU0TwTO4wcANOPe6zGCXgtfh+PTT3qbqleh1qubLgKL6sjJtT/Xcu
         aRuDGu2Kkzptrxb1MRongBXwiFKdks0knWbGaxcrKkjwV8PBRTM9B71+JCWlJIz+sjBV
         YJpJLzH+SVn8lGTv6sxAQlpkbQ5PBi+ozlK8SSPLboHLNMMefciDhEipJ5UY2KPWpuyk
         2/SX8PQCkiAYxXbWeHOj3XYXIMYfCiiadQtfeDowwPZu8/3oOFbeJKx9cH3+sSQFKzET
         /tSw==
X-Forwarded-Encrypted: i=1; AJvYcCVF4X5z4txRBybVnHRhsq79qpiQNWnu5x5WnHI1HQcLy4UhSiHOFXmjhScqwnX8X66CO+V7vOOJH46zQpncUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywl/ZRTlF021TaEexD4kUDAruA108vzexUZ8njEohYxIRQqRodV
	FG47TYuZ2gu3U53S6gVv/CnsyTh5j9F1hTc+4zv+PQdQJ946ah6XdjlDtywZkfj7y6SQ2sUJT1N
	sBkIrEutteJnTiGP909zHiGsrvU505QaoDOquBAP5yupQV8fF/dC7XY8QFzx90ZxJvbUY
X-Gm-Gg: ASbGncvWOjSoGp7icrwjTqDbS1Pd/487qH/q7APYHKUFwya7IgX5Zv0Hu0DLJfrB/ZL
	TUuCXZUv3VS6w4RKGODmgrg8y7tdnZRs92TikcXVZH4SoXAFcia20QNtH6ycDitjXGdLELYLx+e
	0REOzLYhJdqPUHKPoX7gr0c84JkMT1dZY/4n5CUweQ0OUTLtUw7JsC/r9WE56Sa5/SAqwAjUiQv
	48Ze41VlvJXfgtB8s4cg88Zl9QRKlrtmTOfCDwXkz4IL8rxOznhww5vN/WHzPaVuscg6or20QTQ
	uYybI4L5SuoQv7HOscmhYur7QDAMDHZworwQdVwZ8qccn+GG9L9VrIqpuOKKMWEq2/Md/h6YmFv
	2iluK+79pzQjbf0pq91U=
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4778fea8ab2mr86716295e9.33.1763278590825;
        Sat, 15 Nov 2025 23:36:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqZuOeT1wAABazsJ0HksCXcwMYVBBLygHfL8/xmHfq4axK6seTI4Hh3FvYH1PcGLCWD6fslw==
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4778fea8ab2mr86716095e9.33.1763278590441;
        Sat, 15 Nov 2025 23:36:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47796a8a695sm79746965e9.13.2025.11.15.23.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 23:36:30 -0800 (PST)
Date: Sun, 16 Nov 2025 02:36:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 0/2] virtio: feature related cleanups
Message-ID: <cover.1763278093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C-YQQZBD7Er2C2WjmOU58DAifSIdPPGtaCQSfytgZUQ_1763278591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Cleanup around handling of feature bits:
- address word/dword/qword confusion
- simplify interfaces so callers do not need to
  remember in which 64 bit chunk each bit belongs

changes from v2:
- drop unnecessary casts
- rework the interface to use array of bits not
  arrays of qwords

Michael S. Tsirkin (2):
  virtio: clean up features qword/dword terms
  vhost: switch to arrays of feature bits

 drivers/vhost/net.c                    | 44 ++++++++++++++------------
 drivers/vhost/scsi.c                   |  9 ++++--
 drivers/vhost/test.c                   | 10 ++++--
 drivers/vhost/vhost.h                  | 42 +++++++++++++++++++-----
 drivers/vhost/vsock.c                  | 10 +++---
 drivers/virtio/virtio.c                | 12 +++----
 drivers/virtio/virtio_debug.c          | 10 +++---
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++--
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 29 +++++++++--------
 include/linux/virtio_pci_modern.h      |  8 ++---
 scripts/lib/kdoc/kdoc_parser.py        |  2 +-
 13 files changed, 114 insertions(+), 72 deletions(-)

-- 
MST

