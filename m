Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D75B1FB
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176555; cv=none; b=ZOdtz0RliVzklvm3j0oIKXdLstn7BYP1hrWkPP6UAfOjGHluRXMOxTQmRvSvta5UKjOc7sfdXLf9eIHzUXPKAjGAxpsB8Xx2ujq17f5GDrEnm7Oyb6OV1SX+3yXQIJsP9Zg+S3ZW0GpNf9i5Ea9BvnzevgqBP/x4JZIg7wRGiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176555; c=relaxed/simple;
	bh=+ykbfSP9QE6LjsxeHl6HZt6oWo4XQ54KD3PrDqCfUic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sEDQtWrNeDsaP1nuwVhNoCmH8kW179mK8q3z+1MyHNtaf+Jw4qB9p8W87huwh466jGBuzh3FF5ygz2vHD/WMOBlSmNdtXicMEW7G1EeBNs2ePyi4kmbytoK4TEf+3BwvW/Sqkdqeu1HVSVtgh6Un/ZlnNsndzmhksHEDgICJWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9z9+NAH; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9z9+NAH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F220A40261
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 07:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nlAlDwNBVmD4 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 07:15:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 061F54025E
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 061F54025E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W9z9+NAH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 061F54025E
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 07:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718176551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRPQpXge3I0Vcd7b2iojqZfH1RINuN+3D+5eFcM1E+A=;
	b=W9z9+NAHI9LKpS5GHjbZk0Dp/mPERJvoH5aLRjqr8a7yiatqMQnvgbxNEi64CPIdcaj0GO
	rLOlJNJC06O1E/S6KdCmv8/CsgTghWCfClUk+D4i1SiDVatG42ypg2sUf1aiSYVhw19f4R
	HeNdwOrazYWsgrseMLWX+auV9YzM2TM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-K2_C3Lt7Mpyps3dvX1bvRw-1; Wed, 12 Jun 2024 03:15:50 -0400
X-MC-Unique: K2_C3Lt7Mpyps3dvX1bvRw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f27bfa618so1485147f8f.2
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 00:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176549; x=1718781349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRPQpXge3I0Vcd7b2iojqZfH1RINuN+3D+5eFcM1E+A=;
        b=J3vTi10B2LeAd3Y1lGAaGsfym43Mhv7Q07dMWzsNcsxxTO9xYGvq2avLNQxrZ6v+tt
         QRvoDG0K63kpxYnPMXzF17ZjXyDzwqjJn3qFYt6LW8WByh48FlMkGHQd9eeTVy4Zefx5
         Gsp2XOEBxyqXn8NLEpaJKXey1mDFLhTdgWJYy3+Ockkt8wzD5YBTpVYxqEsHodMTJz8B
         rqhcE2JMwRO+5+Rj0DNmNzDPrRSwgK1jjmQVbqyU8lPuYasqimaHTad+jFYk8tn2oyLS
         lXqKMUETqEWTO1gRevaGF/V7x7q/5Sa1KWxC7TR2aQ3P4VLct8Lw9vREM3ENoVA7gtc+
         O7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Dwak0qrZaZeaEzlU9N8DXf/fghK/zdfLsscLBJQXWZ2hMGaQcGkvSYOiaBsyXu6MyZhvy5LfZ0IMvg1/ZII5t5Nj2qBmfCxrbo4XaOz+xisBppcM4OGdPQ==
X-Gm-Message-State: AOJu0YzRgZAI/Tsw5ngitDIA/fcfJ1qfj7K506VvlSzLVUWTnG2PdBfU
	mStEDOlYZ0i3GKfzw4GeIePzYq/O+gKuTI7RycwCtZdYCkRWEqKcsSm7uD9TJ3zJEJqZbfpZbJI
	UPM83eR3RYv2JUFUb+EvrZGHyTGxZ7McVq+EasPOJtdPd3K4tacJUwuZ8Z8XMGAkzJkqzrGttdo
	d1S3c=
X-Received: by 2002:a5d:5288:0:b0:35f:18ad:bccb with SMTP id ffacd0b85a97d-35fe1bfda3fmr603591f8f.35.1718176548716;
        Wed, 12 Jun 2024 00:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYuQ+XjKBy6z8bjJ/5ejaRe3tBk9OjBlBGeQH9fUUBsA31Sgruib/67gZGeejF7RYzsndo1w==
X-Received: by 2002:a5d:5288:0:b0:35f:18ad:bccb with SMTP id ffacd0b85a97d-35fe1bfda3fmr603573f8f.35.1718176548189;
        Wed, 12 Jun 2024 00:15:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:39eb:4161:d39d:43e6:41f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f23a651d4sm7641411f8f.50.2024.06.12.00.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:15:47 -0700 (PDT)
Date: Wed, 12 Jun 2024 03:15:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240612031356-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> Add new UAPI to support the mac address from vdpa tool
> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> MAC address from the vdpa tool and then set it to the device.
> >> 
> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> >Why don't you use devlink?
> 
> Fair question. Why does vdpa-specific uapi even exist? To have
> driver-specific uapi Does not make any sense to me :/

I am not sure which uapi do you refer to? The one this patch proposes or
the existing one?



-- 
MST

