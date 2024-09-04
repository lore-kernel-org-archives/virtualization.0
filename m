Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67AB1465A1
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433853; cv=none; b=pqb7CGGvjjjmjdJ0s3/wj1mq8b7oxLdr5paeDHUqlnfwdsMyvxvlJeGLDVLedCIiovbQK/to2YQroIB+qZlhCzKMjF2P+tXoB03rGzkkxH+RhxWEqEgKFvsOp/suMYC7k2ITgRqIRj9YsMzz0Gl+nCWN19jsRycxLSxxCWw/zYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433853; c=relaxed/simple;
	bh=NdyEQSOZtQ/KRk/q/9RM3WZZDXsXtrg4/pFCDCMMNc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uFoUkIGtOxRu5LazKkzS0ywgqrXvVuqSNtuutJAOV5WNuiaXofDRSWLw5RSxkvfKJ2N49ArSLLhI/LQ/Zsj+CH97EZgAi0LVa9YD5j57eKEbxNxLqyqK3ndxiiKVTxTkJmiuAgIGcU3TX/XrIDX9xfWqIWxv6Gq5xn8t4BNkfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPR0a/YE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPR0a/YE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725433850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q60RHAHmLLE0VxGoZCTOWMkbd2/aqs6wkurKJ3hsm2c=;
	b=DPR0a/YETZP3QJo1+ajuj5s3WPdcpHKDGbLpyHg4uG9seTZL5ErVIft9jFRrhLK8HhcokR
	W5DxWKTUr20DSEnSOc/pDaKmcuVZrOcaGzpuTcfTsoebZldLmgi7eoRAlTvWHLll+aEyTI
	tc1225mH8u8IQEOFWtLsRNwa9fpPC2Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-6Senz-saOmS0cg52BMg6wg-1; Wed,
 04 Sep 2024 03:10:46 -0400
X-MC-Unique: 6Senz-saOmS0cg52BMg6wg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2D8A1955D50;
	Wed,  4 Sep 2024 07:10:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00BA219560A3;
	Wed,  4 Sep 2024 07:10:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id DEC141800639; Wed,  4 Sep 2024 09:10:41 +0200 (CEST)
Date: Wed, 4 Sep 2024 09:10:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 2/2] drm/virtio: Add support for XRGB8888 and BGRX8888
Message-ID: <mweukcefxzwxzbty5ql5mong2m2ljt5262mtn6fwvio7rdjebb@jpknmy43gzp4>
References: <20240903075414.297622-1-jfalempe@redhat.com>
 <20240903075414.297622-2-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240903075414.297622-2-jfalempe@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2024 at 09:48:27AM GMT, Jocelyn Falempe wrote:
> On big endian machine, fbdev wants BGRX8888, but gnome/wayland wants
> XRGB8888, which wasn't possible because virtio-gpu could only support
> one format. Now that it's fixed, it can support both.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

