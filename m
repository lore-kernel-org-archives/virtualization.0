Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3923AA9D8
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278552; cv=none; b=EZ4OxJHl0CH++SS9PDCgl0uYS7DIwV8wpNAPYVJKd1C2CegL7V4XjjzeS0O/nbxakvfqrZSVBfXhTd1ZMdt74iQU/MNZsXC51timlMdGkG5+YLbaFE2y+pXAL0eDU+WbpUBb5KdS/ghYiC19RC34u8gXmK0cGSIWfNCZnOP67OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278552; c=relaxed/simple;
	bh=3cCYb2GXxCqt4CUkuLjwjUMCfJzRvE2ILorj6jcE/uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kwupvfrqVnG9V2TPpZt4W2AcoltYcH+UpfQOCklTuzu5iGCZZl4SoTxgpgqKYhn97/flnXPvxNF/S1GhtV+vJDKh4LqYXa3VSobMBMe+P4bcAw9x+55pcZQP1+VEt9vzA2atJ7uVpswBKeIp4n+nTt9upNAGZGWI/vKG1jApGLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWxxhEz1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWxxhEz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791278545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rT3Z6FD8ZJHJrigocAucu2rhc50doTFkH8wYejbkVS0=;
	b=IWxxhEz1ZkoKuilG8NXYTT+8wfcw8SoQf0dnB6Dr4zyYDluRgZNwOjzHn8yrEnek08eHTF
	GP8EIJhrH7D9TUrfy14wuRY5gDKXCUBRjMCyebLWIYxJK1MG70jvjZ0n8wic3jnOtZ2ed8
	Zd+f0Dpz65R5T+ibKy7cArQrBQikG3c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-0yAaKcScMQqiueQrANlR3g-1; Tue, 06 Oct 2026 05:22:24 -0400
X-MC-Unique: 0yAaKcScMQqiueQrANlR3g-1
X-Mimecast-MFC-AGG-ID: 0yAaKcScMQqiueQrANlR3g_1791278543
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c437ae7dbso590130f8f.1
        for <virtualization@lists.linux.dev>; Tue, 06 Oct 2026 02:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791278543; x=1791883343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rT3Z6FD8ZJHJrigocAucu2rhc50doTFkH8wYejbkVS0=;
        b=uIK7erObJ4lIPwAxra6lXBkbUBHoyQdzbsS6+RCF5dJn5UwjCyMK6OZDVuU3MnM6qI
         CmpQmirMwoibjkt42JrZ6QIu18PtIf0E5G/7F/dKY8o7rcO4o13fXNRUlOIH2vQROdN5
         ZUiq3RYTa5NonhSbLcW8qJIIGosPrIAlIw2j9iTMi85IEDYttDhXA3GpakSRal5mrHds
         +L506d+C5gDjMHZYm4HUcodeKLrbjDmeTrFPfrBFEl0i57f2rXug1RS449NzTztDD545
         Rs9qsQOONOE8koJQxr3Aove1mRyQ/UsOYtNZs0UV/CWZJcBjgsGAz5d9tFriC8ZC4Gid
         uFeA==
X-Forwarded-Encrypted: i=1; AKwUvBxpDV7wapeX2v+35dMTQ4bB5aJCbDaGvRD3OY4RU2HKcxiA5KdodXTFgUiQjE1SatbMWsTTv3+tRHepMT0hAg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJv/h6ApgCx1mN/zcePBVSNMJ0G2MZ7MNnj4olIgI78N24/o8Z8
	nYACSdUtOvVpC3/3TRCX6jKNlH/2awcFXbdBdHy/oY9l3xvbdepLWAfNYtKP/z/2rnT5WqzuZz7
	febiLBMfcecIu/3VyJHxYVcx9JycweAoGigvlhgzxIR4Nvv3yU0XbFWbXEPw7bWJXnK+8
X-Gm-Gg: AYBFou1HkF3QeXXvmXfWzDnzmklQAJJ1lquBvR2pzEDTss6wT+KJX1bowB0bThFlynJ
	L/YZeTnb+lKP4QmzijGAjtWfcauwAXS9hdJRCTk56qW43cttUsPzYzB2IZLxTDLefMSs2WprX1+
	Ufsn4M5V45GtAsg0DWF8ceO2es6J0vOp7XkiPojyuHyEFIc/wZiiZ+NmR+CJpgw1mit4fistL0Z
	SHe4N2dM4i/V7iZnzZRfV/WWX28vMLtYKXVt2pIjxDVhcPuWr/lkYLxAJJ+kjxL7FIoRsj1Vwe9
	fLCvRo6J0Rot0dKeby0RKpd9x1PsF3fn5mI7oJnKZQHFt/zi7TiGXmqjc0YQ682ERW9Txx4=
X-Received: by 2002:a5d:66cf:0:b0:487:1577:9e33 with SMTP id ffacd0b85a97d-48c688ea4cfmr3097595f8f.25.1791278542933;
        Tue, 06 Oct 2026 02:22:22 -0700 (PDT)
X-Received: by 2002:a5d:66cf:0:b0:487:1577:9e33 with SMTP id ffacd0b85a97d-48c688ea4cfmr3097554f8f.25.1791278542366;
        Tue, 06 Oct 2026 02:22:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622d282esm8705325f8f.33.2026.10.06.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:22:21 -0700 (PDT)
Date: Tue, 6 Oct 2026 05:22:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: Jason Wang <jasowangio@gmail.com>, Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [BUG] virtio_ring: VDUSE backend can corrupt split-ring free list
Message-ID: <20261006052105-mutt-send-email-mst@kernel.org>
References: <20261006091210.828229-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261006091210.828229-1-tjdqudcks0424@naver.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x_QGidbSfPDe0sk5IH4HI6dp4L8fMa4hR_QUh6Ni0Tg_1791278543
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2026 at 06:12:08PM +0900, sungbyeongchan wrote:
> Hello,
> 
> I found a split-virtqueue free-list corruption issue reachable from a
> delegated VDUSE backend.
> 
> virtqueue_add_desc_split() records descriptor flags and next indexes in
> the kernel-only desc_extra array before publishing the shared descriptor.
> During completion, detach_buf_split_in_order() follows the shadow next
> index but decides whether to continue by rereading the backend-writable
> shared descriptor's NEXT flag.  A backend can therefore change the
> detach length after publication.
> 
> I reproduced this twice on commit
> ff47652a4b66c067c765a7ad464d930b5a9367cc using production VDUSE,
> virtio_vdpa, and virtio-net paths in an isolated QEMU guest.  Initial
> setup was performed by root, after which the backend ran as uid/gid
> 65534 with no capabilities and no-new-privileges.
> 
> Changing one published RX descriptor from WRITE to WRITE|NEXT caused
> the host frontend to detach the adjacent active descriptor.  Completing
> that adjacent descriptor normally then detached it again.  Six valid
> completions increased num_free by seven and the following refill
> published descriptor IDs 5,4,3,2,1,0,1, demonstrating deterministic
> free-list corruption and duplicate descriptor allocation.
> 
> Four controls were clean, including no mutation, a one-descriptor
> NEXT-clear case, an invalid used ID, and mutation after completion.  I
> did not demonstrate an out-of-bounds host access, chosen-address access,
> information disclosure, panic, code execution, or privilege escalation.
> 
> I tested replacing the shared flags read with extra[i].flags, which was
> captured before publication.  The same forged workload then refilled six
> unique descriptors and the normal control remained unchanged.  Build,
> checkpatch, and fixed A/B validation passed.
> 
> I performed a best-effort public duplicate search through 2026-10-06
> and found no exact public report for this post-publication NEXT mutation
> and split-ring free-list corruption path.
> 
> This report was prepared with AI assistance and is being treated as
> public under Documentation/process/security-bugs.rst.  A tested source
> reproducer, logs, configuration, and proposed patch are available to the
> maintainers on request; the reproducer is intentionally not attached to
> this public report.
> 
> Assisted-by: LLM
> 
> Regards,
> sungbyeongchan

As far as I can tell, you are saying a device can confuse it's driver?
So what?

-- 
MST

