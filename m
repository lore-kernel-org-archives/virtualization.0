Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE5198A19
	for <virtualization@lists.linux.dev>; Mon, 25 Nov 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533777; cv=none; b=U0YAV8BxPZHq0u9l5N8YUUw6bp2aDVNm28mk+PDl2LABdkwSVV/D11K/v0CWSKQXNDzfx0pUPcLY8bcQZv3ik1sWMoX7cT/aB3v6C2YSh0Kp7/+f8hLvyOdG+WHevURX7g5IGTE0azhq9Qyjgj5hCcS/2xx9kmnjkU5i55Nt8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533777; c=relaxed/simple;
	bh=oQGBWZDbV3Z/yqFMCRsbdBmECwKQG0BuBJYp0mGmk44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=t6UgYE34qlfKiiD/rrbEQ+UTiPwr8pWTWjFRLLyMjLo5U/ahZl25OQ4Sd+mHcrC9MxPYNBA2VhbZWMGqVUmfWJdItOXqZQ97Z6dd5T1lsWCEcYB9hPxWahrmCXQbthgueAyhEMSZWp7NIUhBrqeoFjiwfvvVdVUKB1Ip3RQpdqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+0AfdAi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+0AfdAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732533774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+sllFXXJNcJZ+f5cFnwVtlcSwPFXESaku6gH0Ws76pc=;
	b=B+0AfdAiw3pK92klF4bcSioh/FhAVdhX/+2BVaBSbzwub3wR11il4Yt/gcOKh7qJXo8vbX
	ZxqOqgqRcs0+xl8Yv4pc7q6XpL/dLegtr6VpcHLji2FyuHhp4wzgvIfYqVvrLop+C6WfCs
	u6UeHMYUKre3EuY5O+klEFLU3EAF4DI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-O1huZqNjMeW5-jwNl8FMJw-1; Mon,
 25 Nov 2024 06:22:51 -0500
X-MC-Unique: O1huZqNjMeW5-jwNl8FMJw-1
X-Mimecast-MFC-AGG-ID: O1huZqNjMeW5-jwNl8FMJw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E5351956088;
	Mon, 25 Nov 2024 11:22:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FC1030000DF;
	Mon, 25 Nov 2024 11:22:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 152DA1800392; Mon, 25 Nov 2024 12:22:47 +0100 (CET)
Date: Mon, 25 Nov 2024 12:22:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] drm/cirrus: Use virtual encoder and connector types
Message-ID: <6m4dw6orj6frsmufdoeea3cllssvmwxzf7r44fwmd5t45pc7te@4oz27uvldojr>
References: <20241029143928.208349-1-tzimmermann@suse.de>
 <20241029143928.208349-2-tzimmermann@suse.de>
 <y74662j6zqvocvpa3zbig5owhqu2o43xdrwkeswgwd5mak2cx7@esgliauvzkh5>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <y74662j6zqvocvpa3zbig5owhqu2o43xdrwkeswgwd5mak2cx7@esgliauvzkh5>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EG57Rtr6XNoW4Q6GN-sC51Q_T5eZxGGJZWVr9ZYL8lQ_1732533770
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 23, 2024 at 06:28:30PM +0200, Dmitry Baryshkov wrote:
> On Tue, Oct 29, 2024 at 03:34:23PM +0100, Thomas Zimmermann wrote:
> > The cirrus driver only works on emulated Cirrus hardware. Use the
> > correct types for encoder and connector.

> >  	connector = &cirrus->connector;
> >  	ret = drm_connector_init(dev, connector, &cirrus_connector_funcs,
> > -				 DRM_MODE_CONNECTOR_VGA);
> > +				 DRM_MODE_CONNECTOR_VIRTUAL);
> 
> This will also remove the EDID property from this connector. I'm not
> sore if that is an expected behaviour or not.

Well, the qemu cirrus emulation does not actually provide an EDID,
so this is probably a good thing (even if possibly not intentional).

take care,
  Gerd

