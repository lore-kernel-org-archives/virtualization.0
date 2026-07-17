Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4693A3E87
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784267293; cv=none; b=pK30Zo/PPDFCgivbZ/8aW6b7ge30rM08fCnYuBROuHEvbHXiKz1mcU3vIP93Bb1ZA3nWOsMfmuFRbVmCJJVqdHsQf8dM+Rm/OYZx4b3zC2/rkE3lFX+wGBUdlW5UyOVuYnPAZxO655CxnKglcVJgpzZL3rnqSDZnhlfnvvH60Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784267293; c=relaxed/simple;
	bh=PcZZ4BBE+qex8AVlaEqF+DYjJeKsaWGxZ57l7lqcnPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rEcHPIMZwCpaFGy5A2naWhkF3ki1u6J+eRR7fmPhnN5LDNw6f5hXTrqQ+r3ghFHJWqCS+CqQbkzrPEeBrNlyHzT5JUPlVuO9uCNy5umnHr/Hulwafyp8YpdoTpbiX0FoVY2fKmvxnMxtkdSathzriGruc3hW+vUAy95niy4TWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBgLbBZ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBgLbBZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784267290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bmyp7ZomJkfJKG4Wnb+pC/++rhVrw/gdjngW3ibbXhE=;
	b=XBgLbBZ/5f1NbWLyGA6e3mj4CB3HBByDRaYXwI+V70YYAQPM6XYTb57/4RnWyhwNH8QaRy
	dBtAZUWKt7gioMlRyj7Km9Qcg+j4rjFTatS3VU9vjSHnALKoX0y+j9uuLcn9cAMUinvWQw
	CGaYmfJxS2GUaYYA5DRWV1++qzTMd20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-U7fK3ztBMm-IKU0baSXCTw-1; Fri, 17 Jul 2026 01:48:08 -0400
X-MC-Unique: U7fK3ztBMm-IKU0baSXCTw-1
X-Mimecast-MFC-AGG-ID: U7fK3ztBMm-IKU0baSXCTw_1784267287
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49402f0af24so40200715e9.0
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 22:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784267287; x=1784872087;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bmyp7ZomJkfJKG4Wnb+pC/++rhVrw/gdjngW3ibbXhE=;
        b=UjHGFMjq88YBXLB7YU28fWx+ibex3jIaWDsT3kUknvh80sWQdkyQWf2LgY/AwoPh16
         xuMXP7W9RGwRS7mN0p3knYUYABjBgoyzCgKeQ7pkXRY4fo0R2X4KUGxhEYci/Uxm2IE8
         LB7MgYsWh/cGUceanz9tCaX4IXl/PcmDJJvvLLYzYjNE5cIIMGD1HeVQ9tU4yNvtim/K
         p+hXKG5d1zeGHzLVZJDTzPU7gTyoAobpUZx2Iv0OXlsp7YmANfGh12juLat9BwNuhX5O
         x8HxZofi+NOjD+A1mCLxLHM8SHWffSehVKBpbdhu4wnPo/UFdfw1cEFXjARkU+mqBpR7
         XUKA==
X-Forwarded-Encrypted: i=1; AHgh+RqtJHyaSdeYanj0Mn4EolURdviUA6TfJgJTmtNmeP17AzDGh0vfNZXW7L24hPSxkZoDIB85St0UZPWt7oNtBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzPTvgrVXxYlhCsJ6KfIAyYeQmQdbHKfn0D/TgpZkd9T7nn5RL
	K5H+zRK2SP3oGMbeeCEBRZ9MkPSYcCv4MwbxV2meYRyEy9Veba9b4H7sTOKimY3HW59JUDw8FzV
	XSvnZIKmtkf7SO4jnXnT3Dvgwjd1xeXBxjNuVUC+ZDrj2+GAL6PvssQWRmhlkTctCRhf3
X-Gm-Gg: AfdE7ckaK6C1eL6mnZ3Qu4g8r9vZibG8qw8AVIqdxcraFieVojtQ+4wGlUx5xkHIdYR
	3X2ppJF1/Jn9YZjPBHOuDfKQD5svoea1oVqIlJYWc06Zd2HqYZXMSMS7Fbz6okiyK5fyJqFfoS1
	UZv+DauSrURKVQjBmoWQ4kAuLxZ13pTdUFrsb3up3h+NWwC6TEgIBZUF+n5vu91fpdIaUyonVmv
	UnF2TgkDQsEwMkGNu1cn3L/g3uZ4su7zvmPlgyVo9KMc65qvIFu77qRPQK0+VzyGtmnVrM/bueW
	891qDDW9YXic33Z0jwAeT/67dvbvmC7bWN/vsvVTGCjOL/21waoQ77ffpmeXF0ZINtEOjN/v66W
	NKWTpQppVXDjahebbmrV76wKl
X-Received: by 2002:a05:600c:4689:b0:495:4b56:f127 with SMTP id 5b1f17b1804b1-4954b56f1d0mr2196845e9.25.1784267287002;
        Thu, 16 Jul 2026 22:48:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4689:b0:495:4b56:f127 with SMTP id 5b1f17b1804b1-4954b56f1d0mr2196525e9.25.1784267286510;
        Thu, 16 Jul 2026 22:48:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495499d1d4asm17178085e9.2.2026.07.16.22.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 22:48:05 -0700 (PDT)
Date: Fri, 17 Jul 2026 01:48:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260717014134-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-2-harimishal1@gmail.com>
 <20260715164139.40957-1-harimishal1@gmail.com>
 <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
 <2026071635-relive-flogging-2a81@gregkh>
 <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ulw3kPaCoYn_B03nVujkppBaEn-4v8N0nvM2_HIE-b4_1784267287
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > Or do we just always trust virtio mem devices explicitly?
> 
> It's hard for me to understand where we draw the line, really.
> 
> But maybe MST can clarify what we care about in virtio world where the
> hypervisor is fully in charge of the device,

Generally:
- The guest is expected to whitelist drivers (most drivers have not
  been audited).
- Denial of service by the hypervisor is not considered a threat
  (this is how cloud vendors charge their clients, by denying
  service to whoever did not pay).



-- 
MST

