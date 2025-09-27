Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994642D5437
	for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758963745; cv=none; b=Wdd4eRxf33sw4DkAgicAZJA4uZQO/jnZz3RnPiAXBYvthWfQpHnKoPxIuuFKo9/s+bLfrAhpmdURdNRi3qoUZ+IaYB2kc/TNAt25gBt/bFbuGiQcdPRrMf1l5RSd+p8z3ME0Q3Dxuq6jx5YJzvuZL0gJE7e354WuuihcfjeiPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758963745; c=relaxed/simple;
	bh=0cVnGuREPBEousW3ICfS8xU9h5IzQoRJffkth/1/cRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jecHBqMzkOB8lbVZR9m1v8fzehYlQC462g20JHJMgWB6j4A03yLGF2U5U/qTHQf3W697qDKyoTxEI5MOU3XrX6Q5aZ0nAyyOJWHODtiXPJx21LV7G6+6UPLa5L42wKzjh+VvLYHyddCQpv/antMIaVGA266yX2cT8WeRmuCRJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dR6c4Dau; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR6c4Dau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758963742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Q29ePBvNLNX3RyQTzBYKbm0zTToczl37eoxUDzMUR8=;
	b=dR6c4DauYCoUh3p6SKzVoYaGHLnp/dZBcb1kyI1u0QklTxVc919V3YIyRcldceEnvdA+6b
	qhLiy9BSOPAPCuqgVY4VgTfa9JlYmOtgCRNlQydC5O3IZHf12oA66yxWmnFKOdJKfO7Zor
	ShVC/Bl3z1VByPlCokxyN2ourFqNcDk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-BLEHdfvMPXi55rfLzon84A-1; Sat, 27 Sep 2025 05:02:20 -0400
X-MC-Unique: BLEHdfvMPXi55rfLzon84A-1
X-Mimecast-MFC-AGG-ID: BLEHdfvMPXi55rfLzon84A_1758963739
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ed9557f976so1976147f8f.3
        for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 02:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758963739; x=1759568539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q29ePBvNLNX3RyQTzBYKbm0zTToczl37eoxUDzMUR8=;
        b=vEpFKs7yS8as1NNBmqlDASKmx/Qi6R1yYpWVXeHSfRcZLZMa5oR6bE8BaXURiH/fRD
         B+Ypt5K6AZ5Th9su0bqLQrX07FgabbJ3rLW8nrN1sHTidaYBa955It4bvwS4VPt2Zq/F
         XEUyWSaURMkat5RrlQdipK9vqcZUQBFGSbNCfJ3r/bpsvYcQDeItK1od70dp0ESAufU6
         sBI1zIM3EKCi+i3B+JB8MPe/iwMoTNScjG8scXaaETald4TvvabobEW8oTYgcgwNS/IR
         4GCEjCaSuFRt/PxrFKoCRMgdOmWgvq+lsSvb72vJC1rxqv3JwIbWgZ2kqVlICYTWJNJc
         1Qsw==
X-Forwarded-Encrypted: i=1; AJvYcCUQJ4g0l8xNIWElEj/pfEeslUNI09K7ZzxOLKRICjIXntStPs1RnVQdboGHKHkXv9ykgiAOsZOCNfHJih6dYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8GRI0TNeHc/X7Kbht1ozk4D8HyGCJvNaINv7BvPo4KJ/KHwwP
	5dcHQ+nBmhXtP/1UxZwVXswC59ThKVB2EmtRkhGAWZba9KenO4REfq9kn0nSwQHG8/tzahELGwJ
	6AWjWiXg/qKIsuzw+lOUS1sz3V7FbPvF6IoWjCmss5FhhroeZpxVNm6C4L8Dvj9cavepe
X-Gm-Gg: ASbGnctgOKDB3SO7pOrcLU4NsblmdtdEYM3IlFY7p0Sg/UGdKooLZ9DoSYp7VQnQRZb
	VdXGGeYgY2Oj8Tc6WtGRwUecI4QtPrCctm+LZvSK4OmGH/RJFjkqTzT4tBnkPjNjxTkiNbkzWEE
	5XMsLTyeGNC2IMj+vxGwvZLILA6aI4CRnDX5OuuT6blDfj+eRwWfY7c+hEslDyHQfch2yCN2eB1
	+SsoJVIbVp0sYAimlh/+3FyT/XiHbEXauovv66qv+A0aRg2+yLEQZG9qzQO1Dd09sRrlbWFmrwW
	21p7idVHkB++PZ7DqGRloX0zo/7rxuSXkVs=
X-Received: by 2002:a05:6000:25c3:b0:3e0:e23f:c6d9 with SMTP id ffacd0b85a97d-40e43b08a91mr8457936f8f.17.1758963739140;
        Sat, 27 Sep 2025 02:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzfwp51UeRct/ixNCdhk7ku6um/ThtAGSfqA38FUWoj7+zrfA6BL0jhAYPeE5wtPhNAuqm9w==
X-Received: by 2002:a05:6000:25c3:b0:3e0:e23f:c6d9 with SMTP id ffacd0b85a97d-40e43b08a91mr8457901f8f.17.1758963738703;
        Sat, 27 Sep 2025 02:02:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e42eee0b6sm36103265e9.10.2025.09.27.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:02:18 -0700 (PDT)
Date: Sat, 27 Sep 2025 05:02:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 04/11] virtio_net: Query and set flow filter
 caps
Message-ID: <20250927050033-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-5-danielj@nvidia.com>
 <20250925170004-mutt-send-email-mst@kernel.org>
 <3097d7ee-b2e7-4232-9a80-fd7f33bb9fe2@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3097d7ee-b2e7-4232-9a80-fd7f33bb9fe2@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9fVkFknK8dLk3mwYX6Kt0GtowYsOPbqDk8HeXiCFqas_1758963739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 09:12:48PM -0500, Dan Jurgens wrote:
> On 9/25/25 4:01 PM, Michael S. Tsirkin wrote:
> > On Tue, Sep 23, 2025 at 09:19:13AM -0500, Daniel Jurgens wrote:
> >> When probing a virtnet device, attempt to read the flow filter
> >> capabilities. In order to use the feature the caps must also
> >> be set. For now setting what was read is sufficient.
> >>
> >> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> 
> >> +	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
> >> +	sel = &ff->ff_mask->selectors[0];
> >> +
> >> +	for (int i = 0; i < ff->ff_mask->count; i++) {
> > 
> > 
> > I do not think kernel style allows this int inside loop.
> > I think you need to declare it at the beginning of the block.
> > 
> 
> checkpatch didn't mind and there are many other instances where it's done.

That's because checkpatch is kernel-wide. But netdev has some special rules:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

says:

"... is discouraged. Similar guidance applies to declaring variables mid-function."



