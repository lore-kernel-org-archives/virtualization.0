Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15281B042A
	for <virtualization@lists.linux.dev>; Wed,  8 Jan 2025 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337875; cv=none; b=dfRw73Ghhah74AQ7CCkYBaW9KdvOpHSq6F0bCafQ6uSvwePFWTT8XU6IKpl/KeWieHz+yCf40WPk6T/MmaoKpMG4nZAeJPSVF9FQGjYEoi+Vx06+a54m5ZJ0kFNpK5yQE8SAwH9RNVPlLgw3pRr9AzqM4FwYnjE0KO5UN4pRda0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337875; c=relaxed/simple;
	bh=113mJZlj7lrmpmGDuKQWu73sMEvYBfWYxx3E+OaCMQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h6F87K5z6sVVQR6QNhvoXeudhCBIfo5Ddv/lwzZey6TCfY+AudDS06EmHccslF5IXpYzzCs5gRfm1UnJdsAOCCHqsbXEeUkkuydBenlm54dNnLC7iQlM+aU4eO9bcsR8hkLmzvJZRl77le9J+NbYr7Jim7HkvQ+olUU7XNfEioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/6/g6AX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/6/g6AX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736337872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=erQix5YBM/Y/uEtirG3GeKXgXkkPiaihYorhESefFJA=;
	b=Z/6/g6AX54ptMQMDmjIQK3YqN1Nz7W5o30nePrqHSICVzUaKtGQv6ISoP1Drxnr0+EUwDj
	7/0Qd7mo2nlBDHfNqc0a+n6VLKQNl73MmFakEarrH+z5b2EnSnFhUtlbSdBVr09bQHktV3
	KX8OJ5aF+5El25kB9EbN2QW13DFgQq8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-BOFWj2uMO8-dNNFqcMUXzA-1; Wed, 08 Jan 2025 07:04:31 -0500
X-MC-Unique: BOFWj2uMO8-dNNFqcMUXzA-1
X-Mimecast-MFC-AGG-ID: BOFWj2uMO8-dNNFqcMUXzA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so120621035e9.3
        for <virtualization@lists.linux.dev>; Wed, 08 Jan 2025 04:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337870; x=1736942670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erQix5YBM/Y/uEtirG3GeKXgXkkPiaihYorhESefFJA=;
        b=RKJInRw42HoZx+w1Gs+WHfyWev+pUaXiVo2E7yB/fIylr3JyBPKD55tgwK2Oi30MLJ
         fmGWT/nmDPSr5bLSTtSEh09Q1Hpkzsd66lKFlydojLq++R80+sbWqCNHTZ22xmr9+gqh
         JmutGiib6gqjmtx72ydMhRTUDil14R9zFHD/F8iXyjWB2VlLROeyn14WQ5w7aJle8Ui3
         8AcQFQXdPTGTSZY/k7xw6IQglqV/LU+fONJNmRmszyZ97w5EtA+jx0zDDXzmezfJ475q
         7FwjTgO/cbvfUpjlffibkYOPC8T3a/iOcY1dZss1VPkEzhFp3nRDLRvHSZvqssjfqx57
         Y57Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBGTPFVXeyjdCHivkTtFjhpM5C6ofE8qVXqmjK+Q8bzesrHTdlz4mdRvKxwqkCgPgkMX8BufuXQiA4iIk+lA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2SlBvqhYofTUumi7otQdMyVwHYzCAD+JbZmzOAQrNsEBuZZIj
	/WVbOb9aNq3aTCU++UsWAtZPCPJCFNG6I6xrf03KHkoJa64EMAgTVvO6gRK3GuQfqWdIhPkIiu0
	0bnDYYFGTPyAd6Ve+5eItGvllcczkN8THaMq4TQojAAgErfXNn9fbleciQgctjasMye65w6K6
X-Gm-Gg: ASbGncuOk46IJkntlwN9OjSGVfLl95mWQtShbzZrH0PMXkRfIzWDAo1DVuYRTH65pfp
	XRxiJ7jqyXhUZsXfAQCyuGsn1IbU3JsR7CRl3ixwxKIW1IU70jhvYo2L62MA+GA4nw7BBuwjlVN
	JJH06R0LpRy8O1dGm+wild2kw0d4zqcCDBwRX2m0LDltcVTskhK3sYsErjq6sP00IFVXewM//iS
	wA1bfB2Q6no9uN0qmak5HHz3fH2gQeDqpzU2M+l/Gb5Zg3niyI=
X-Received: by 2002:a05:600c:5251:b0:434:f4f9:8104 with SMTP id 5b1f17b1804b1-436e2700050mr18200285e9.33.1736337869687;
        Wed, 08 Jan 2025 04:04:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUR05pl8seK2xsW/qB5D6saVHw6QWnqhWJEnho0PIwlVj0Pr14aAjP/a/iJR8rsa6d05BmGw==
X-Received: by 2002:a05:600c:5251:b0:434:f4f9:8104 with SMTP id 5b1f17b1804b1-436e2700050mr18199815e9.33.1736337869281;
        Wed, 08 Jan 2025 04:04:29 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8bea5sm18342805e9.31.2025.01.08.04.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:04:28 -0800 (PST)
Date: Wed, 8 Jan 2025 07:04:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] fs/proc/vmcore: kdump support for virtio-mem on
 s390
Message-ID: <20250108070407-mutt-send-email-mst@kernel.org>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xzDsnnFEHVYsUT6kW_6LpwhKhzetqnQcScbGLoj6Whw_1736337870
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 04, 2024 at 01:54:31PM +0100, David Hildenbrand wrote:
> The only "different than everything else" thing about virtio-mem on s390
> is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
> during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
> kdump kernel must detect memory ranges of the crashed kernel to
> include via PT_LOAD in the vmcore.
> 
> On other architectures, all RAM regions (boot + hotplugged) can easily be
> observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
> the elfcore hdr.
> 
> On s390, information about "ordinary" memory (heh, "storage") can be
> obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
> that information is stored early during boot in the "physmem" memblock
> data structure.
> 
> But virtio-mem memory is always detected by as device driver, which is
> usually build as a module. So in the crash kernel, this memory can only be
> properly detected once the virtio-mem driver started up.
> 
> The virtio-mem driver already supports the "kdump mode", where it won't
> hotplug any memory but instead queries the device to implement the
> pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
> the vmcore.
> 
> With this series, if the virtio-mem driver is included in the kdump
> initrd -- which dracut already takes care of under Fedora/RHEL -- it will
> now detect the device RAM ranges on s390 once it probes the devices, to add
> them to the vmcore using the same callback mechanism we already have for
> pfn_is_ram().
> 
> To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
> add new PT_LOAD entries that describe these memory ranges, and update
> all offsets vmcore size so it is all consistent.
> 
> My testing when creating+analyzing crash dumps with hotplugged virtio-mem
> memory (incl. holes) did not reveal any surprises.
> 
> Patch #1 -- #7 are vmcore preparations and cleanups
> Patch #8 adds the infrastructure for drivers to report device RAM
> Patch #9 + #10 are virtio-mem preparations
> Patch #11 implements virtio-mem support to report device RAM
> Patch #12 activates it for s390, implementing a new function to fill
>           PT_LOAD entry for device RAM

Who is merging this?
virtio parts:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v1 -> v2:
> * "fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex"
>  -> Extend patch description
> * "fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex"
>  -> Extend patch description
> * "fs/proc/vmcore: disallow vmcore modifications while the vmcore is open"
>  -> Disallow modifications only if it is currently open, but warn if it
>     was already open and got closed again.
>  -> Track vmcore_open vs. vmcore_opened
>  -> Extend patch description
> * "fs/proc/vmcore: prefix all pr_* with "vmcore:""
>  -> Added
> * "fs/proc/vmcore: move vmcore definitions out if kcore.h"
>  -> Call it "vmcore_range"
>  -> Place vmcoredd_node into vmcore.c
>  -> Adjust patch subject + description
> * "fs/proc/vmcore: factor out allocating a vmcore range and adding it to a
>    list"
>  -> Adjust to "vmcore_range"
> * "fs/proc/vmcore: factor out freeing a list of vmcore ranges"
>  -> Adjust to "vmcore_range"
> * "fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
>    ranges in 2nd kernel"
>  -> Drop PROVIDE_PROC_VMCORE_DEVICE_RAM for now
>  -> Simplify Kconfig a bit
>  -> Drop "Kdump:" from warnings/errors
>  -> Perform Elf64 check first
>  -> Add regions also if the vmcore was opened, but got closed again. But
>     warn in any case, because it is unexpected.
>  -> Adjust patch description
> * "virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM"
>  -> "depends on VIRTIO_MEM" for PROC_VMCORE_DEVICE_RAM
> 
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> David Hildenbrand (12):
>   fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
>   fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
>   fs/proc/vmcore: disallow vmcore modifications while the vmcore is open
>   fs/proc/vmcore: prefix all pr_* with "vmcore:"
>   fs/proc/vmcore: move vmcore definitions out of kcore.h
>   fs/proc/vmcore: factor out allocating a vmcore range and adding it to
>     a list
>   fs/proc/vmcore: factor out freeing a list of vmcore ranges
>   fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
>     ranges in 2nd kernel
>   virtio-mem: mark device ready before registering callbacks in kdump
>     mode
>   virtio-mem: remember usable region size
>   virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
>   s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)
> 
>  arch/s390/Kconfig             |   1 +
>  arch/s390/kernel/crash_dump.c |  39 ++++-
>  drivers/virtio/virtio_mem.c   | 103 ++++++++++++-
>  fs/proc/Kconfig               |  19 +++
>  fs/proc/vmcore.c              | 283 ++++++++++++++++++++++++++--------
>  include/linux/crash_dump.h    |  41 +++++
>  include/linux/kcore.h         |  13 --
>  7 files changed, 407 insertions(+), 92 deletions(-)
> 
> 
> base-commit: feffde684ac29a3b7aec82d2df850fbdbdee55e4
> -- 
> 2.47.1

