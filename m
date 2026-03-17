Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96673E7154
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758952; cv=none; b=mMv1arbAttjkged2LpN6xrrAeVomHiwm5RlkNH/kCfS5S/j1ikFjzLD+/rlq55uL/cm/kts5UK4kS3uhfQ522jhQzHSxmak8Ps/X0slcc7Q5vCSBOtwdMI9sowM6uPodi8aC7XWUgUrsCUn8H6ACSrX6hxrIZg6VA7XrhidPauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758952; c=relaxed/simple;
	bh=iNJs/u1TpYWfU0Qz9eQPyh9AhCbCAQ1n9YEhxTfTWls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O8rOL35IpHuP3NjogS8w20UZ2/SU5tL+2FwybTxq244EoBJW90ievkHbhICMiIi925eUa9rRYpLCRgnDbgd4LKh8wy985B7FjuI6V8sGabVhi2b2vbyU5/DnvWD0X1oIpUo9EaBNSDgwYyYHryrt3mB8fCI5g6QmZ6TZ0/u/scI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=H9NP+HUg; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="H9NP+HUg"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F353540C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773758950; bh=wkDfJ+MhK/Z+X+CYUG17c6gVD0tWJHWYlkOrN2nR1Gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H9NP+HUgQiY0qPDtNgc6P00Il3c/wcdbtrAJEhSzq5gLIUtqluRQeE1kGho5pVTQD
	 QWpbwFXg5uNOMJzokqk1Uxy3n2wAJIOya8L6Rbm0Uu3X9a+Uvr76Jn8ZLfXjuAaCAG
	 C0HNnz6EPuJARNb9sYI2gF9gKfWDLR6LX6tAB0l8C1Aq/4ZniTFy1UsM38GSZeUzp/
	 SAt957trGF8oYonOJTSGveMU6bFdjk4V9xyvQnl/nqq/YaIQ1gjCafne2+uNOE529b
	 Z9brsHhHMJyc3qepgyNEGcOEPYppiKW7Ij/1P6k6mtJ/QAaKmvDryO7TFeJxl9plv2
	 T67NB6jykCuIw==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F353540C7C;
	Tue, 17 Mar 2026 14:49:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: John S <xaum.io@gmail.com>, mst@redhat.com, jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 skhan@linuxfoundation.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: document the map API in the driver writing guide
In-Reply-To: <CAAZVx999y-DvB7Dp2ekoHk6s8aqqScd2gKSY4ySGAK6NNXeH5g@mail.gmail.com>
References: <CAAZVx999y-DvB7Dp2ekoHk6s8aqqScd2gKSY4ySGAK6NNXeH5g@mail.gmail.com>
Date: Tue, 17 Mar 2026 08:49:09 -0600
Message-ID: <87wlzacxzu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

John S <xaum.io@gmail.com> writes:

> Add a new "Buffer mapping" section to the virtio driver writing guide
> documenting the virtio map API (struct virtio_map_ops). This API was
> introduced in commit bee8c7c24b73 ("virtio: introduce map ops in virtio
> core") to allow transports and devices that do not perform DMA (such
> as VDUSE) to provide their own buffer mapping logic instead of abusing
> the DMA API.
>
> The new section explains when and why custom map ops are used, documents
> the virtio_map_ops structure and the union virtio_map token, and
> references the driver-facing mapping helpers with their kernel-doc.
>
> Signed-off-by: Kit Dallege <xaum.io@gmail.com>

So what is the story with "John S" in the From line?

Please, slow down with the AI-generated patches.  Perhaps focus on
exactly one of them, and get it to the point where it can be considered
for inclusion before doing any others?

jon
