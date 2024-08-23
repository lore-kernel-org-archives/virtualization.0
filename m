Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1BD1E517
	for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423667; cv=none; b=MAOs3Fy8veOT2+3mR3Qtt/p8SgQmuPh2GAzozNSDAU2ulrI6j+0Zw48Rl0gV5gi+7suHaSifEu9zP5/90HCyTrWExfLENjbcoJm0wlZSuDNZwZ1RAs5agp5imfgonVnzAepjb1GS5RXaScgA5XhOpMwsUrc6CjEP7PSDtOgnqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423667; c=relaxed/simple;
	bh=YG9GylUhZPLrhu1ih8FBmf3Lr1DVSOqTyfo8kRwy7q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=X94NSNMNIxp3IcYV+98ZV6p/DR6QqcOwVtlnTpWjH+YUoktKzZQdq/1h200alp2SBJ4TLi+cz71b6OFM0xu8bKMDlE80MWaVTd0ucU9SANRLuyERNfljORXKkn+JJYDD0fwrbRYPm8qxpuwS3jTIE/HrhNInW5InK4Jdt+N1BEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhJBq7P9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhJBq7P9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724423664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fjNZBRuZGsbkeNaHK2sXWLKAuqcqEXvd1LH3yVahOM=;
	b=JhJBq7P9vGoQJNngnaBNW9c9ChfYgII3x9TCF47HJahqHK7d4pdnff7fAKTJgnlDlBdVfX
	jDgkcjFysUHOWKf6EcfGs9c2rRpvClEvXEssWsMXw3dF1IragwXBWHXz7QMUrcqTm43T8u
	/lpKXiYp9KtNn7Eatcne/eP1ZNZEIHI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-RoAN9ylEMFaYXQhvxhUtyg-1; Fri,
 23 Aug 2024 10:34:19 -0400
X-MC-Unique: RoAN9ylEMFaYXQhvxhUtyg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEEA81955D48;
	Fri, 23 Aug 2024 14:34:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.20])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F143919560A3;
	Fri, 23 Aug 2024 14:34:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C66A818003AA; Fri, 23 Aug 2024 16:34:14 +0200 (CEST)
Date: Fri, 23 Aug 2024 16:34:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org, 
	maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 00/10] rm/bochs: Modernize driver
Message-ID: <sksjddgidfrk4bvcxvb46khevp4a4nfvl2holgdw636wld7oov@vdbcvdf3ch6m>
References: <20240823124422.286989-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240823124422.286989-1-tzimmermann@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

> Patch 8 replaces GEM VRAM with GEM SHMEM. The new memory manager
> is more reliable and allows for larger resolutions.

Valid point.

> Display updates were so slow that Gnome was unmanageable with a
> flickering cursor and single FPS. The new memory management makes
> Gnome at least useable.

Hmm?  I'm wondering where this huge improvement comes from?

With enough video memory VRAM performance should be ok.

If video memory is tight and ttm is forced to shuffle around
framebuffers between vram and system memory on each page flip (touching
much of vram along the way which causes additional overhead on the qemu
side), that is obviously very bad for performance.  One of the reasons
why cirrus uses SHMEM + shadowing since years.

Shadow buffering comes with some overhead too, so the switch isn't an
obvious win (assuming enough vram).  Hiding the page flips from qemu
might reduce the work qemu has to do though, especially if the shadowing
uses dirty tracking and only touches the vram pages which have actually
changed content.  So there is a fair chance that this outweighs the
shadowing overhead and ends up being a net win.  I don't expect the
difference being very big though.  Also different display usage patterns
might yield different results (fbcon vs. gnome for example).

So this probably makes sense, but I'd like to see a bit more background
information ...

On vram sizes:  The default qemu vram size (16M) should be fine for the
default display resolution (1280x800).  For FullHD vram size should be
doubled (-device VGA,vgamem_mb=32).


Skimmed the other patches, looks sane overall, but I don't follow drm
close enough any more to do an full review.  So I leave this here:

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

