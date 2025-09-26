Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678526F292;
	Fri, 26 Sep 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919521; cv=none; b=GC60sN9tKyD2ga36sodk8U/JKuLwICv9okjlmJal2CsFM7rUlcf1t23URwvzpbr95+mlpMHelVT8fT3Bp0i3oqRonvEgKX9MykdqN6t5IZCOL+ImufISFsqlK58sQvRaF96Lz4StJZPRYnsb0LlHPDD4qybRNpDN8kzmQkSuINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919521; c=relaxed/simple;
	bh=nK4s3PChxs9ivgkRpl+7c0vitjJwwK0qPwlyJ0//ySU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+gSW6jF0MzPoCeLxCCScwdvSRBNI8neCRgystNa/hLvJCX5u0ZuVNX/qhY5py3h4+WpXBqvKjd3CGeE0vAQlWM9ab/29rp8Tus8UuBfpoyrlpJCrVanRf8uOmYjBLwDg6Tra/bbMuDN1Ef4NqjDc7a+ikAOUZcdFPc64CE1sPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeJ4X9Vf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeJ4X9Vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C32C4CEF4;
	Fri, 26 Sep 2025 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919521;
	bh=nK4s3PChxs9ivgkRpl+7c0vitjJwwK0qPwlyJ0//ySU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VeJ4X9VfCc9NDA6LowNjOrAE+wQlbVvlyOkrlJDcABolKSKzNBC5D/kBfE/hE1zEM
	 zoEyflQon29VK+oJQaaEFolM/hvR/JvVG43Yg3ir4dL1vvqgZoVVg3S5W5E9J9I/Nq
	 V9ry6jyEj8QJayhtD3e8BJmd/tOuudwbUrwHi9ZmG6QRG0l5o6ZlGaUvgoVVe1+Qt+
	 /IxbL5TbeHvymcIX2NEm/cGlXAv3EYmgViJ9kn0Hgez36/zL4m68m0+WdBY6ZcbTaD
	 CwuRxfJP74RsK5c8CGXZQrlF7FMriWRmCu9OIzOE9ujZrekG/jPIjVkV9lLKztDQ7F
	 ix4E4asVR1Z5w==
Date: Fri, 26 Sep 2025 13:45:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <alex.williamson@redhat.com>, <pabeni@redhat.com>,
 <virtualization@lists.linux.dev>, <parav@nvidia.com>,
 <shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jgg@ziepe.ca>, <kevin.tian@intel.com>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>
Subject: Re: [PATCH net-next v3 04/11] virtio_net: Query and set flow filter
 caps
Message-ID: <20250926134520.502f0009@kernel.org>
In-Reply-To: <20250923141920.283862-5-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
	<20250923141920.283862-5-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 09:19:13 -0500 Daniel Jurgens wrote:
> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list __free(kfree) = NULL;

Please don't use the __free(), you already have an error path in this
function, what is the point. Plus

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Netdev remains skeptical about promises of all "auto-cleanup" APIs,
  including even ``devm_`` helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.
  
  Use of ``guard()`` is discouraged within any function longer than 20 lines,
  ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
