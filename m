Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF98F9C1
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694594; cv=none; b=cO3tXd0sMGpsq1Np/hC+Xj6unG4ck5UrPne7qEsX168BQdEPbSLQfaZC4CbfLq1lNfzOLQXQAQWuwxQI/QEl0R8BXYput7StyrY3JyPy3vrhsmmPHDi1YLS31bA3UCM0mdoH3oMLYNvtcxiFPpFkCJpkxBy+c6En1ADjkH+AMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694594; c=relaxed/simple;
	bh=wYoHhlyTQLrXzZnfKqE5TTY7hdPbb+343tQnEnwumRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KtIvy62xuaB2Wi6uPhlBQs2W8T/VAMWHBmcXZd/SmpHqTaRNpPdLqPemSoPVA6z7kfnR3jNCEv9fLJnEwRWu+B0WqOZJKrWI9Frd7Azu4w3DSVRxJVZIBdCXtPHYGv7Rlb3SvYrGY9clBc1/eV91NxvTUVfQ75ngZ91G2o330tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WG7tDhRP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WG7tDhRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758694592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYqDEElUq6PE/aUwO89wI+I285Xe17iMxShOwBkPxgY=;
	b=WG7tDhRP7cEKTgXdGzOoB/VjEFwGQD58x33UD1dfywW+MkqkGxW5YA5iX7taZY77MKlFSm
	gedz6HVhQX/bLyElPY7STD6D8wbgSdiOTg2ylfRt+yOqOfuHybKH616vRaqF56QV4j4sD6
	a+WyFYaVvDWpwZlgNXxlIVC7peMI+Kg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-lJ5GvQEMMzifNs4lAnN3qA-1; Wed, 24 Sep 2025 02:16:30 -0400
X-MC-Unique: lJ5GvQEMMzifNs4lAnN3qA-1
X-Mimecast-MFC-AGG-ID: lJ5GvQEMMzifNs4lAnN3qA_1758694589
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f030846a41so2802672f8f.2
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 23:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758694589; x=1759299389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYqDEElUq6PE/aUwO89wI+I285Xe17iMxShOwBkPxgY=;
        b=aFsD/O0e1jICilrmrXQC+Fj4CqlAkTYeW0y/FCa7n9yJV43YOrDlHX6Ggd7KqG4Whk
         qOJ5nx92bCCTncwbv2oR894X/WPjUb5boZkxfHRxzx4vREuu+cAZ+DqniXAEFSLo8ldl
         zhxALWN1zV1eQhrwfu+xnF2u6nd7JIeeYRXd/90USqoP8ik5s/4CAYv76kTTcfhzRUMU
         YAWWr0khqG4Rkqx4F0+3RVtCPd+6ZD5oJpvSDBWx174Nt8jDbqRjpQKIYbZKbP3sYFdX
         OiQoOcyrGWYmb8rQAMvPLEfMi/3LDHD254nVtrpfYj1+eIuZ3MmcdCbN3PoG/lUs0/5P
         59kA==
X-Forwarded-Encrypted: i=1; AJvYcCUy+3f2uBcu/LVzdWV+0LA/UDCoopQfr76uHiyWs19ukl1AuRNmF3+6PcDaEIrmHrzq70bkkVes2JJ0pWOrDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9nXQwbpxQg4545l3nUSr30HVYvh7UCf0hBzqAlZhnrolwfcxT
	Qy4Wbat/hHOmI/jJmivrdJcSOxOtSufvGzW4q+UY7qPtNeeLPKKbikMrbygRJomZXu1ZzMuLM+B
	82xMrIv13ZCIE5bbgZEWqyqFom9776KBOq5YAtBYzCfIDOUyJkjLVMuwTcSyi95Ssq2jt
X-Gm-Gg: ASbGncumZLqrJC+/Hpt44d5aPph8FM9XwnUlN6MnVbTgVU1PonQLCmh9s0y91/Llzqd
	MLiSbFZUNa0ljcMRvpWKrJnc8e0z9y50vyPCayueVSzpbc89QqaFDmVIwTS+zYiB2WdaBEYEBTX
	m49I/9JBjFWMQ6Qa2SqTDkM+xBH6iBofKdvf/RHgBtwY4hjuxnfokkVYEuG5enfN8co/Aa+SJgc
	B+tL77lrMumLVgYtI8IbysBDlbKCxgEWwyIX0oXj/hu6YPfrDf3c/7EleTsRhG3YepOUTDYEQip
	AQPUhSsZE2ZsBsjl8Aw98mXUqu5RjE8q29k=
X-Received: by 2002:a05:6000:4205:b0:3ec:1b42:1f90 with SMTP id ffacd0b85a97d-405cb9a58b5mr4240170f8f.60.1758694589125;
        Tue, 23 Sep 2025 23:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFawYpDl5FDdbDTaRogi0vy2KU6XJAI+3T8autcDErz2jQEJ88pc53RcQP8+2rm9oLn7/8iCQ==
X-Received: by 2002:a05:6000:4205:b0:3ec:1b42:1f90 with SMTP id ffacd0b85a97d-405cb9a58b5mr4240140f8f.60.1758694588591;
        Tue, 23 Sep 2025 23:16:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm26600355f8f.21.2025.09.23.23.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:16:27 -0700 (PDT)
Date: Wed, 24 Sep 2025 02:16:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250924021444-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250923141920.283862-2-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KzEnfsG73P9v1s9vy8P_U7QjLVekw0bu499mzVcr8aU_1758694589
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 09:19:10AM -0500, Daniel Jurgens wrote:
> Currently querying and setting capabilities is restricted to a single
> capability and contained within the virtio PCI driver. However, each
> device type has generic and device specific capabilities, that may be
> queried and set. In subsequent patches virtio_net will query and set
> flow filter capabilities.
> 
> Move the admin related definitions to a new header file. It needs to be
> abstracted away from the PCI specifics to be used by upper layer
> drivers.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>


...


> +/**
> + * struct virtio_admin_ops - Operations for virtio admin functionality
> + *
> + * This structure contains function pointers for performing administrative
> + * operations on virtio devices. All data and caps pointers must be allocated
> + * on the heap by the caller.
> + */
> +struct virtio_admin_ops {
> +	/**
> +	 * @cap_id_list_query: Query the list of supported capability IDs
> +	 * @vdev: The virtio device to query
> +	 * @data: Pointer to result structure (must be heap allocated)
> +	 * Return: 0 on success, negative error code on failure
> +	 */
> +	int (*cap_id_list_query)(struct virtio_device *vdev,
> +				 struct virtio_admin_cmd_query_cap_id_result *data);
> +	/**
> +	 * @cap_get: Get capability data for a specific capability ID
> +	 * @vdev: The virtio device
> +	 * @id: Capability ID to retrieve
> +	 * @caps: Pointer to capability data structure (must be heap allocated)
> +	 * @cap_size: Size of the capability data structure
> +	 * Return: 0 on success, negative error code on failure
> +	 */
> +	int (*cap_get)(struct virtio_device *vdev,
> +		       u16 id,
> +		       void *caps,
> +		       size_t cap_size);
> +	/**
> +	 * @cap_set: Set capability data for a specific capability ID
> +	 * @vdev: The virtio device
> +	 * @id: Capability ID to set
> +	 * @caps: Pointer to capability data structure (must be heap allocated)
> +	 * @cap_size: Size of the capability data structure
> +	 * Return: 0 on success, negative error code on failure
> +	 */
> +	int (*cap_set)(struct virtio_device *vdev,
> +		       u16 id,
> +		       const void *caps,
> +		       size_t cap_size);
> +};
> +


I do not get why do we need this indirection. There is a single
implementation in the spec for now, and your patchset does not introduce
a new one.


-- 
MST

