Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED46F06A
	for <virtualization@lists.linux.dev>; Sun, 23 Jun 2024 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719137210; cv=none; b=Uu+5ZT+Ta5xUlj1fdJHQLMyBOqoK93yKcvkI5/LQXJOFZtccgyrPbIRuAxrjSy6UVQSu6i3R247I3CnyhLSJQWBWGQzJOL60nIIR6y8QB9bzUofYu9BgM3oJoIdjiYuGR0lL5OcKciuykzwinmNBin6nFHez5vU5DJiS4wvncak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719137210; c=relaxed/simple;
	bh=Y5mR5U660E8K+UgcG1a0yPGvlO5IM7YkNLcnZh8b36M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QkeUCbr6ZJVlD1rNEKBnVIieIqUZJSG8hJc7gGvkeCqQhgL2sKvBtmLdPtAQhVZ4IxG1ZVSNIkj9P/3SVPxjjvnlEdUuKr2xrIHo7bMQccegP7VLBETwjzgW1VFbznvyaKT6RXrxIOPPBpSWvfwXF1YN81T9KuzBgn5YDhJeRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOEQd/bo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOEQd/bo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719137207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goZq7iVINNND+hTePdj39SioZ3zpLylx4vwzmC5SbaE=;
	b=eOEQd/bolgHFHQZ28dwxfrCMnlsss5y0oFgJK11uNG6OmQczLvT6DogmSPPekPPedRuUik
	zfvZ+zLM4vJT/t51Tl9vCK4i7yqGGRdWcrFOZyT7lV8GNebARBH2VyMjecvDpxS3KzYNWp
	L2IUY7R66A9tGK18xT2+t8TwMov8izo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-LjrDz4jOM9C7sRZuYWcTfg-1; Sun, 23 Jun 2024 06:06:46 -0400
X-MC-Unique: LjrDz4jOM9C7sRZuYWcTfg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-366e087a1e8so691614f8f.1
        for <virtualization@lists.linux.dev>; Sun, 23 Jun 2024 03:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719137205; x=1719742005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goZq7iVINNND+hTePdj39SioZ3zpLylx4vwzmC5SbaE=;
        b=DOLWmulJ4oItO9mUa1R1EocL2Ze0FpnECldoSRCcLVjvYbNuU1HYV1EWp1231MWn4r
         /DtpYKZVK+5zcUquPpYpylcA10VYHB2RJR0naBNC1ifgWX+WbpNlHpva2mqK6sM+BEO1
         pRLWrq2h32Em1ea2HXkH4oUdMDnaXdIRKU5mkZAx9It45630jfMVpJFlNSYFeSVTZc9u
         oJSycUXZFXW3czHTdh2ux8UdHWuvjRtkGZ/OcY4mx/JY26GxG8vIZyXmoZXPadiFEU+W
         nI7V/oJzoBoNMzW5zoLQwh7YGZ4sVldtGyJgEO6+HpTAMskZN6LwgyySGiCmbqkvl7GN
         TB/g==
X-Forwarded-Encrypted: i=1; AJvYcCW/izHiP7IgHZrRau8bptOQ2NSO+N6N7+DXOVLop2f/m78XjhA1sZy5MqW1G8/r0/3bCitJPv5ek/UYIySQmPAjlVUgcuWgIogVs9Tmbgs=
X-Gm-Message-State: AOJu0YwUeLQrJftxiiTNS7EJZNPubvKWuzboR8RMqk/JLTXTvsIIwBh7
	253uoxvpeDFuUdyjNC4G4NbjFwhxqu2oU+5joLtIkCSFKWFnAZVlkHzXINFsdKNnXEMOWnRD9jV
	07lRIz6Ab1tgkR1wgE7NE2R0RigQcMtDAL4fA8C9JzP9bI1+AmISt80qFIz/rpAoo
X-Received: by 2002:adf:cd82:0:b0:35f:3051:1935 with SMTP id ffacd0b85a97d-366e9655165mr1283137f8f.59.1719137204869;
        Sun, 23 Jun 2024 03:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZloiO5bb0B1nR7c4eudkxd8K7vOTdoaaS7nCUqn8s47nQnrOiFMSu3oUwPPsyXtI3wLDcdA==
X-Received: by 2002:adf:cd82:0:b0:35f:3051:1935 with SMTP id ffacd0b85a97d-366e9655165mr1283105f8f.59.1719137204114;
        Sun, 23 Jun 2024 03:06:44 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366387cf44asm6838738f8f.26.2024.06.23.03.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 03:06:43 -0700 (PDT)
Date: Sun, 23 Jun 2024 06:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net 0/2] virtio_net: fix race on control_buf
Message-ID: <20240623060630-mutt-send-email-mst@kernel.org>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240528075226.94255-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 03:52:24PM +0800, Heng Qi wrote:
> Patch 1 did a simple rename, leaving 'ret' for patch 2.
> Patch 2 fixed a race between reading the device response and the
> new command submission.


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> Heng Qi (2):
>   virtio_net: rename ret to err
>   virtio_net: fix missing lock protection on control_buf access
> 
>  drivers/net/virtio_net.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> -- 
> 2.32.0.3.g01195cf9f

