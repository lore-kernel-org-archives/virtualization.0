Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5A1A0BDB
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994309; cv=none; b=DaOyj6/N70vZjnRq9nNgUQwf3nriL/IZoKF6DMuogsr8YHTF0tL8wJjzGUXtAZg8fy8pewAc+SGalH+C+aR9VNOHZf5EHQGeEi8iYMprXHtKEMPGORPgvXwGhBOxqOUaUKUp5Gw/gUtaviDpN0MW9EdKb/vEOIODXMBRdawdT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994309; c=relaxed/simple;
	bh=Q8KRqjjlHZ40u/KO7uaIEHQ3ZCPEbh9kJxiy/RGAiGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=swngd/RBtjFrpkzy8nJsgatmjlEvZvrtv/opRmZYNt4uoQJMUH04ufZWOaJ8//xRproLawazEFH0QFBUjWrT/ovNMc5KQu8F4iCgo8kr0rNWR/fV4vHfIjUwyKA9u3V70P825C54KbEgCgzK6XRGXye7fuNYnQ++gKcnRr6t5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oo0ert7t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo0ert7t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742994304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVQHKi1v6ZJuoZpbTUeTTwk753IlYenrtjuxZpJpJjA=;
	b=Oo0ert7tNro5xRn/D9MGLPUAW2KZsn4cf3ym86pZTQm9S/YycMzyUZ7apt5B30JAZ0oo/x
	zMGD4FSyFQfnCNnZO9RDI5ad/dFrw5yYsztsDSMcVKCJJFhAD0df/CEi3XC5sXw/1i0Wx8
	GIGIIpQpMYtw1ejn6At+94dP5ySgEqc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-jrUx5pFNNvaUdDFRIVmFcg-1; Wed,
 26 Mar 2025 09:04:59 -0400
X-MC-Unique: jrUx5pFNNvaUdDFRIVmFcg-1
X-Mimecast-MFC-AGG-ID: jrUx5pFNNvaUdDFRIVmFcg_1742994298
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 784641809CA5;
	Wed, 26 Mar 2025 13:04:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.27])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B5711801756;
	Wed, 26 Mar 2025 13:04:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 2D2741800787; Wed, 26 Mar 2025 14:04:55 +0100 (CET)
Date: Wed, 26 Mar 2025 14:04:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/cirrus-qemu: Use framebuffer format as-is, drop
 adjustments
Message-ID: <iks6ntl56uyo2cx3k4trgeu5z6ilxe6leaoexi7azd4woutefa@yct7554fra2i>
References: <20250325171716.154097-1-tzimmermann@suse.de>
 <20250325171716.154097-4-tzimmermann@suse.de>
 <hujnqeg74eoiz4lj46xhetdpytfgndg4iegwpszqf3ztjzuw6o@tis4zsp7slc3>
 <98df4fc3-019f-4feb-a49e-987a97e36c95@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <98df4fc3-019f-4feb-a49e-987a97e36c95@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: biKKMEdIeG2jFNbWrg032XzeoIs8Q5WWaB9C4DWk5rw_1742994298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 01:30:13PM +0100, Thomas Zimmermann wrote:
> Hi,
> 
> first of all, what about the other patches?
> 
> - Patch 1 is a bugfix.
> - Patch 4 depends on this one.
> - Patch 2 should be given consideration.

Looks reasonable to me.  Don't feel like giving a reviewed-by due to not
following drm development very closely any more, so

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

> > Second, because there is no way to communicate the hardware constrains
> > of the cirrus.  userspace can query the formats, and userspace can query
> > the resolutions, but there is no way to tell userspace that not all
> > combinations are valid and that you have to go for the DRM_FORMAT_RGB565
> > format if you want higher resolutions.
> 
> The viable strategy for user space is to allocate a variety of different
> configs and check them one by one, thus filtering out the ones that work.

Last time I checked (which has been a few years) alot of existing
software didn't do that.  Maybe that changed with atomic becoming
more mature though.

> > Essentially the format conversations allows the driver to hide the
> > oddities of the prehistoric hardware from userspace, so things are
> > more smooth when running wayland on the cirrus.
> 
> I'm aware of the situation. We've had similar discussions about other
> low-end hardware, but generally went with the hardware limits.
> 
> Please note that there is a trade-off here: the effect of this series is
> that the maximum resolution will be limited to 800x600.

Ah, ok, this is how you deal with the problem, go with the max
resolution the cirrus can support at 32 bpp.

Could be more explicit in the commit message, especially the 800x600
limit, there is a high chance people search for that when their display
resolution changes after a kernel update.

> If user space would appropriately validate atomic states, lower bpp
> could still support higher resolutions. But converting color formats
> on the fly isn't free. I recently did some simple measurements in a
> different context and converting from 32 bpp to 16 bpp took 3 times as
> long as memcpy'ing the raw pixels.

Ouch.  That is alot.

> > PS: https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
> > still applies of course.
> 
> It's been 10 years since you wrote that. So maybe it's time to re-consider
> cirrus' exceptions and just go for a 'dumb implementation'. Anyone can
> easily switch to better alternatives.

Fair enough.

With an improved commit message:
Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

