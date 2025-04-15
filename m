Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91659289371
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715804; cv=none; b=pB+NRJlQTIP5guXGKCnjW1kNwbtISmevtTMLXmvd7WWwuJRRLFzWevmEVYCcawWe+IxFImAmK0lAv1VOZphfQD25VnsqWv/ksgxl+Q2uscDiirH0OocU5GNM+GzDhfZZbjza2pi7VBv010lSk4Zy8415Xmy9bmWzKIH2RojYV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715804; c=relaxed/simple;
	bh=qZDMXZPxBqWPeatleASSs0jexzsJHncPnYtk73uQ+dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IavSLdulK9nSNt+v0mQGmkYWt5qSzz7/cNdLj6vr0J0dt5f4EVPjzadLoPUf8tt1NczH+N9ygaKuEz2tLEZyYtMQOSe+siZm54rs6O3UiUvN5aWXjouhelBf/Y75t4u9jxlrNSujJFV1QuB9uiO6cbnVjmqStcKEITyaQJeaOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHM3S/7g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHM3S/7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744715801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kXgMou/l/Hcg5M+ECqP6mWwiyHOFu0lEK+Kiw7ZYzGM=;
	b=jHM3S/7g4HtRHyGUBc/y7PioUfRWaTxBivQdVxip8sLF9M+FjIJ4RhlHsTRFIvimp+uauQ
	VN7U2RkA8DGt/F1GYUIA91aDLJudGJQy01MIrZ7UWif+zOyhrx0xldzKHSjQ6ukpciX58Z
	vqbVyubz1K3C7x9/Qlzdd6BKWOfXcfI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-_YdZTtXoNc-uIJIP4uXnbw-1; Tue,
 15 Apr 2025 07:16:38 -0400
X-MC-Unique: _YdZTtXoNc-uIJIP4uXnbw-1
X-Mimecast-MFC-AGG-ID: _YdZTtXoNc-uIJIP4uXnbw_1744715796
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01192180025F;
	Tue, 15 Apr 2025 11:16:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.216])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC78B1801766;
	Tue, 15 Apr 2025 11:16:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3B22D18000A3; Tue, 15 Apr 2025 13:16:32 +0200 (CEST)
Date: Tue, 15 Apr 2025 13:16:32 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
	Eric Auger <eauger@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtgpu: don't reset on shutdown
Message-ID: <ge6675q3ahypfncrwbiodtcjnoftuza6ele5fhre3jmdeifsez@yy53fbwoulgo>
References: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

  Hi,

> +static void virtio_gpu_shutdown(struct virtio_device *vdev)
> +{
> +	/*
> +	 * drm does its own synchronization on shutdown.
> +	 * Do nothing here, opt out of device reset.
> +	 */

I think a call to 'drm_dev_unplug()' is what you need here.

take care,
  Gerd

