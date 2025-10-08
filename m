Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C862EBB86
	for <virtualization@lists.linux.dev>; Wed,  8 Oct 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934281; cv=none; b=mlnq0WrTcg3176eXtaqygo26rgdezK+9Vu6xS4EJdKx1levlCMZGD6+MMbzZoJyepb9mRF4IwTUzLrTnWrxZwzDGsJfe+Lb3ehBegOv5nXxs1GCxLTV3HMWu1Nl2DAD78vFki+a5Dv5m+MofvKX7L+Qh7wHMpRcXi+TxamzOtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934281; c=relaxed/simple;
	bh=pbKhd1oJA/yuTL8/naGBl/yvmJ2OwKwj3fxOh0WLWeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BoJPCoIlgwFnagiQOwtLi1APwTRPmB/fZijaPT48SGRYzI9tYAyIXzGayObqZR94Brfg3Q1rV0NXkGGDBaGQDhzQjcyq1biDdpQUrc1f1tWaauypoZCCkUpUM+T892kW0Lsb7Jc3tzQTF4EsOAApWY9RfYVsCpjs+2wI9M40sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ON7n3a7B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ON7n3a7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759934279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dchCMVZ+CKcTImYvSYXlRWnDOdGkh1Qf1tqStte3bbA=;
	b=ON7n3a7BnVcE8a3ywaHmllR033eBFEZkOLa4YeX7eDVdsh/GIO6+8YA8x1xynDrGdoZVOo
	1L3AiJdOR3MXuKSO+4BGlwy/Pn1Iq6xEqmb3WpdqlojxMnjUirp6XFgmW7ufU9gUytDoX1
	pygTqHqKR8wjtjZ49j01kAFcFxaS4R0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-L4lUrBJQMhGfUiqq4sJSXg-1; Wed,
 08 Oct 2025 10:37:53 -0400
X-MC-Unique: L4lUrBJQMhGfUiqq4sJSXg-1
X-Mimecast-MFC-AGG-ID: L4lUrBJQMhGfUiqq4sJSXg_1759934272
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A3B180057A;
	Wed,  8 Oct 2025 14:37:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.183])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CAA919560A2;
	Wed,  8 Oct 2025 14:37:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C0FA4180009C; Wed, 08 Oct 2025 16:37:48 +0200 (CEST)
Date: Wed, 8 Oct 2025 16:37:48 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bochs: Use vblank timer
Message-ID: <rh66ged6cx56dosejdhfzsbfviknuf7byeo6pmfyztibrtcz57@3sccpqdhc24k>
References: <20251008093931.19138-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251008093931.19138-1-tzimmermann@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ckaj2lhbNfP54ryPHM3phJvRfRLyGj26jKzTXfSBLes_1759934272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2025 at 11:36:55AM +0200, Thomas Zimmermann wrote:
> Use a vblank timer to simulate the vblank interrupt. The DRM vblank
> helpers provide an implementation on top of Linux' hrtimer. Bochs
> enables and disables the timer as part of the CRTC. The atomic_flush
> callback sets up the event. Like vblank interrupts, the vblank timer
> fires at the rate of the display refresh.
> 
> Most userspace limits its page flip rate according to the DRM vblank
> event. Bochs' virtual hardware does not provide vblank interrupts, so
> DRM sends each event ASAP. With the fast access time of virtual display
> memory, the event rate is much higher than the display mode's refresh
> rate; creating the next page flip almost immediately. This leads to
> excessive CPU overhead from even small display updates, such as moving
> the mouse pointer.
> 
> This problem affects bochs and all other virtual displays. See [1] for
> a discussion in the context of hypervdrm.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://lore.kernel.org/dri-devel/SN6PR02MB415702B00D6D52B0EE962C98D46CA@SN6PR02MB4157.namprd02.prod.outlook.com/ # [1]

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

