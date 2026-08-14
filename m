Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE9426ED3
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694350; cv=none; b=T7W09juEVFTyArQMiLMBysmBrcsb7Q1SuJCD1Xwfu5eBwamhkvKUPQMawOAV9zYFA3AqcxeRYBWQ8xNmpBKHXQCC0kBPax2g+RJNqVZuC8AMvzHHqZDBh61EjeTcMUtg6Mn9NWMo285o/pCGSjHQOI3fwVFHgCImOC5aRmx9rDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694350; c=relaxed/simple;
	bh=FC1U7Bkume/g43id9Gi5fvJ0O8FBhgcpEYLYobLKUS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UH6DZavS8RzNOdaT/Myiq9qb9GLp3j2LUPEHVWJpnunOYf2kk3welFjpTF4puhVFXo6YSjLhXyFLw7q/FLyqpGiI/OLGt+VjPQHLBpVbuCPS8khTYGkZ/6UHN1TzQeYelEwvIo8DK6fVeenbmro/eU2Fi17mqDQt31ILeEgOG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADkwqYFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADkwqYFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FO98RYWplbEpkXEISYhcLGNF6lZeNFPlJN8RWdcoifw=;
	b=ADkwqYFq2diiReDKoSQXqtDCjKpdbb0Ch/sOfUCxQlR6gRvppzTLaX0vZ7/BDNTPRVKVJj
	9wQUUyGWoSRQgYRFzdTCAsaxnfByH4AE+Lm368EkQO44P8K73OYlCoh5bZKTEQuQ8s6tA7
	dys8ntyOGHFHoRskWInf7Ch0OiM5dfI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-2-qKT_9qPNmvfNIhXBsuow-1; Fri, 14 Aug 2026 03:59:04 -0400
X-MC-Unique: 2-qKT_9qPNmvfNIhXBsuow-1
X-Mimecast-MFC-AGG-ID: 2-qKT_9qPNmvfNIhXBsuow_1786694343
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso545254f8f.0
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 00:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694343; x=1787299143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FO98RYWplbEpkXEISYhcLGNF6lZeNFPlJN8RWdcoifw=;
        b=UwjNeVlkjcBMhFr+I2BTj4f3wjvoFFSpAH1NwfiVw5XdQn6SATmDK2UbDYz+/gdXzt
         WY2/FRhkVaTtxjycxr3W7tJcHNrFvRzInl7ATqTduYcUjU2WpEocKhHYVcn9S1GtTrF5
         6QEbDE/QuL8rAkR+Shq00ky7Jo8hXdzgCTiRQ+hRJX28HvT6ThDEzcR8f3r98DxNx6aY
         nd1HEW6UusX/tjO7cysmpQDtWp60pK7tliHuwMq/2hSAzVlHLCvUEVCPuRynOkOl1Fn+
         1f9DjstrffyhXZUcYhTPrOMGkGr7k/EynSE4KWDF8ZQixGFIiZdllU5gWFzD0hhIfpbL
         WYpg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2/mQZhAkmcdppaRdvjLzgL97IRn139Xhk5HWANZsb26etS9D9VCJDIQaX+bQbt/DPzKHUxrkUSCbkEFe4LQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8ocBy0X/ZBTYwIM9Crs6FGUE6aINobEgNRHQa0XzbtX2lHTHP
	55N/9TkylIokGwgzmtSiWKi9SXTmM/Nshefl3Q+r53pUotcfG0GaNEtQj6IcaA5AYscwoWu1vpv
	40ypSOPYnB/EueMc8CX51pvntXdwY/bDgG0PQK3dHK0/D5F7nXEqwKvfGI6k1D8XqoTOc
X-Gm-Gg: AR+sD12IpzFYRf7ztwyB64C9KdqeiiQ4K3FI3Aq/YmC8FlUbRB8g41sqgleH2/mzU8J
	YmkhysZIgndRFGV94+rrvt8PVB0JEm0Okhr0J0MPTLZwbCNEw8/aNDc/WIu3RtkR0BZ4CRPA2Ti
	HRHGYsudJ8b0c22evLTPQf7HT2+LzG4Titly5aj/glrvTW0KklFGdC9WZKc6EYvKh9lXB1qGEUM
	wyohI7UfZ8aM4RaHJqii7hMLytiu2OkvG+/2gD0mriiHwkd2LlR0Bm1H6yLuLL6IapliVMbHY8U
	Z3lA9aVV5AvFbTg7jF+W0hSWpkCUk13hBUVnWdNdYVSBJQNmXannYPa8mGqJhs6GYl/a10eDlVq
	4Jh+51VlvL/RqtPAap+J2sJViBIlVGssy/OgSZiRdijshTDpgIdgG
X-Received: by 2002:a05:6000:26c4:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-481606d2962mr5222671f8f.0.1786694343285;
        Fri, 14 Aug 2026 00:59:03 -0700 (PDT)
X-Received: by 2002:a05:6000:26c4:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-481606d2962mr5222619f8f.0.1786694342786;
        Fri, 14 Aug 2026 00:59:02 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f15b946sm6204391f8f.0.2026.08.14.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:59:02 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:58:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <an7HhRxxjv09faBX@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260814072903.124991-3-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: erOneWe8tbZsZ4t4nic2RQZSYbJzuOfsqXn5rbpaRuk_1786694343
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Aug 14, 2026 at 03:29:02PM +0800, Jia Jia wrote:
>vhost_vsock_set_features() leaves the device IOTLB attached when
>userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
>continue to use translations installed before the feature change,
>including HVAs made stale by a later memory table update.
>
>Use the common vhost helper to detach the device IOTLB before
>acknowledging a feature mask without ACCESS_PLATFORM. The helper clears
>each virtqueue's IOTLB pointer and metadata cache under its mutex, then
>frees the old IOTLB after all virtqueues have dropped their references.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..b69c260eaeff 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -863,7 +863,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
> 	    !vhost_log_access_ok(&vsock->dev)) {
> 		goto err;
> 	}
>
>+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    vsock->dev.iotlb)
>+		vhost_clear_device_iotlb(&vsock->dev);
>+

Why checking the feature again instead of adding an `else if` in the 
already existing check?

I mean this...

> 	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> 		if (vhost_init_device_iotlb(&vsock->dev))
> 			goto err;
	} else if (vsock->dev.iotlb) {
		vhost_clear_device_iotlb(&vsock->dev);
	}

>-- 2.34.1
>

