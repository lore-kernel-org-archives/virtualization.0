Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4028B407
	for <virtualization@lists.linux.dev>; Wed,  8 Oct 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934331; cv=none; b=bwnb89SAzfC9KQIx2+ozMMu8oxRw3X4QL2tp3hRmz/90SgxHOh8TO0q7f9+eg3AMC29kc+w/6nQfMnntmNg2cb4uRiWTHyzmo42H5Ig1so1OwWq9sK/DKa8h5vzCgxi0Svdf+EI4Htd5hF1Q/vBFc07aoQ9rnDdcB0sLDilifiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934331; c=relaxed/simple;
	bh=XxBZrr4J/BKwYjyOj93+s8yCyZnalg/JfwNTBEQOAqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KvNq263iJuqSnTGBGNIF0Nru8hA3Uh2T5t3/caG0xIRb363nPGTszU+MsKsiCz8hNZeddQjLGlO3KiwnXMC2CKVBOAEG4JFYeF14KeQDo2AerTFPnXdx8iYCjtjSB8VmiPNFXKC7jzOhhuG1IfXA2QoFqzzNljdMqCcW3kYHMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ei6Jyo9b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ei6Jyo9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759934329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JkTI8QZNoSWAXTBH7aMuJjS39CxZo4GnqrPRIh0slw=;
	b=Ei6Jyo9basbF9Y9AbLfc1IX72djyNxGsiyvcAZBKooG1Jh7kASBjOykNPNEpj4sUJweXkW
	T2hN20kU0rlO2jGOhZbyOzs6y/ZJAKJwjsisDRAc+pV0mZ4v0Rdgzf5pXmUHA2Nm7iI1l5
	wS7YT4Ejwo9CkWE4bWrtuABv88OsuBI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-54Hq9rQjMNqVMwl43zMidA-1; Wed,
 08 Oct 2025 10:38:47 -0400
X-MC-Unique: 54Hq9rQjMNqVMwl43zMidA-1
X-Mimecast-MFC-AGG-ID: 54Hq9rQjMNqVMwl43zMidA_1759934325
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BEA81800343;
	Wed,  8 Oct 2025 14:38:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.183])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC17418004D8;
	Wed,  8 Oct 2025 14:38:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 4C136180009C; Wed, 08 Oct 2025 16:38:42 +0200 (CEST)
Date: Wed, 8 Oct 2025 16:38:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
	virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	spice-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/qxl: Use vblank timer
Message-ID: <fmzp2c2ir76bypfo3tzc4dxba3dduqdi7myzejxcenkw3mon2f@orpoujw77ul2>
References: <20251008122911.231674-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251008122911.231674-1-tzimmermann@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uLzJ9-MUZH9falE3-EPpv-cWvVZ-P7SCJm1EZBQWuIs_1759934325
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2025 at 02:29:06PM +0200, Thomas Zimmermann wrote:
> Use a vblank timer to simulate the vblank interrupt. The DRM vblank
> helpers provide an implementation on top of Linux' hrtimer. Qxl
> enables and disables the timer as part of the CRTC. The atomic_flush
> callback sets up the event. Like vblank interrupts, the vblank timer
> fires at the rate of the display refresh.
> 
> Most userspace limits its page flip rate according to the DRM vblank
> event. Qxl's virtual hardware does not provide vblank interrupts, so
> DRM sends each event ASAP. With the fast access times of virtual display
> memory, the event rate is much higher than the display mode's refresh
> rate; creating the next page flip almost immediately. This leads to
> excessive CPU overhead from even small display updates, such as moving
> the mouse pointer.
> 
> This problem affects qxl and all other virtual displays. See [1] for
> a discussion in the context of hypervdrm.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://lore.kernel.org/dri-devel/SN6PR02MB415702B00D6D52B0EE962C98D46CA@SN6PR02MB4157.namprd02.prod.outlook.com/ # [1]

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

