Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6AF27703C
	for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976350; cv=none; b=boIAxykivT9zjQnRAk1nob85RBeOrLzu+sv3wfjdsZJN0tm16AzJR/NUHeriwytNX3B5nHjaCldV/cJK9CZYlEYEhWyhucHHiVxiw854t+9EkzUHIk2PwLkZRBUnYv0gvtc3De6QScgop0E+5HGxhz4YK6SHY12fRE35e6d8aP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976350; c=relaxed/simple;
	bh=QXJo14oGqcFFPaCG1vYqjTuy/Ifc9HqL82bjZYd26vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ct7PRnG0DxoVzCkAv5jG8DoqgEwzW2kENpxhEYhOtHmHdIvAf5j1dRmW5DCtxCIHaWwCuX1KzAR9dXOsdj8xs05FPMN4PfYyPY7oTD4+bJE8PhGGHqQBuXcS/joFKoKjUXsUai378x2muQNwxMEmqXI7f1c30q9to88TCRk+tVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZjSpAQ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZjSpAQ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758976347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvwU/ByFIKVGNfDOxaWsoSUUnpO5CypDPAdcRbhjc68=;
	b=eZjSpAQ12n9oz9+25HBiyiOLEp1LbS7KiHYV7ZykggsSKZS2N1v1dCNdatBNweJSStClbm
	4zcHLfPVWtSlfQfH1mUSVzZWDpmpIXcphyBLa7o9RpINC62AcAGmMW7QJ40ji9FrlTGVwQ
	jVKGLftnswICrowm6mSv/d3vKp5/Dj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-fl3YAErqPQmjom-MiFWpeQ-1; Sat, 27 Sep 2025 08:32:25 -0400
X-MC-Unique: fl3YAErqPQmjom-MiFWpeQ-1
X-Mimecast-MFC-AGG-ID: fl3YAErqPQmjom-MiFWpeQ_1758976344
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46dee484548so17936825e9.2
        for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 05:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758976344; x=1759581144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvwU/ByFIKVGNfDOxaWsoSUUnpO5CypDPAdcRbhjc68=;
        b=XcxssU5FHyCTTfHfcK/Hvd4apWER9CSpIiruizcXWvHT/gTmxQG6ZIwVNZebxAMUj7
         xF8jkO36VXuIdiBZv2DfUH9JmJdhHEzopaN1ZHSiXQDShjWWcG4GQegF3J2+HkpEfsEP
         wYKLSrLc+bIeoPZzLzN4XHZd3IhqZtD+jKT83ii/OHdZNg/OoVWligpFsqHPyUecm818
         84FKcMU7AMm4XOyMgy3w4JmmZrTj5Q7K05s1zWhyXD/WlZVtpIVzEZa80C2EHJfjvfoM
         B3Ioaqkns3KE7NuLOaPZAW4H88XUUtIbDCDhzYCZFbezwZ14lo4Sgod/NmlZzg6MCui0
         GpMA==
X-Forwarded-Encrypted: i=1; AJvYcCW8N84tJoUsoFnmTtQi7cDCit1uimLFwhXchLyx9ZKdBvcaSnN0UNoEwYJuQzvBiUj9JyjNt6BW+ojdpxaqDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrESpac3gnLTopQo/KlnSx2y1++CpXKdaYuEhouPh7jBlaAnFr
	LqzLb2DPmeeDzst9n/PEj6Hf3TOldSXFfm0ruvCVF01EmE7JE3bgsKh57VNdCltGdWqs+ZT8Y/9
	3woQZX9zbi+zutcUFONKdkVR3q5uXZ/puoF78tkjZHlKrn1nWDzHd9IRYlYYAUf/taq3g
X-Gm-Gg: ASbGncvkC85WUDBH86cbMTK6vSuARYsYwai5mHooUSQqX9l73BURkN+mUu0hkJ8xdMw
	stI0mGLaK0owdaDB1JC8ReKdZCCvISbwWkQM8oYKQldSkJYgsnJTzpbJVyzpd18aqlpSe9BKEi2
	1CMA54AbNIjxO3bFszfmcnukD/gyyIkHQm+ZhWAh3s9HKpBPAMcr1T3lSXss8CM907sObXMrOa7
	zJuX6F8guX47p/M6ahopsAdMB4GwuqMsAb+CHR1C6gvk5Z0ZwGmkhGPIRQI4pE4SRfl69EoUpr5
	s6Z5/dZrN4NEtzTsvxfy35Sg9bSOZcIcFk8=
X-Received: by 2002:a05:600c:1553:b0:46e:39e4:1721 with SMTP id 5b1f17b1804b1-46e39e41ae1mr61745005e9.12.1758976344223;
        Sat, 27 Sep 2025 05:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTY0fdZdgXRDviUIBptO6FxVugLlKfaDdRO18KVHiVelnbnrO1C0c8G8WlptAx2IChMWMgtw==
X-Received: by 2002:a05:600c:1553:b0:46e:39e4:1721 with SMTP id 5b1f17b1804b1-46e39e41ae1mr61744795e9.12.1758976343755;
        Sat, 27 Sep 2025 05:32:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b562d8sm111137435e9.0.2025.09.27.05.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:32:23 -0700 (PDT)
Date: Sat, 27 Sep 2025 08:32:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Set s.num in GET_VRING_GROUP
Message-ID: <20250927083043-mutt-send-email-mst@kernel.org>
References: <aNfXvrK5EWIL3avR@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aNfXvrK5EWIL3avR@stanley.mountain>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g-EMSkCZ1D-55U1O83o6hU2_X9oLC7Fx-2p6EpGL7S0_1758976344
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 27, 2025 at 03:25:34PM +0300, Dan Carpenter wrote:
> The group is supposed to be copied to the user, but it wasn't assigned
> until after the copy_to_user().  Move the "s.num = group;" earlier.
> 
> Fixes: ffc3634b6696 ("vduse: add vq group support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This goes through the kvm tree I think.


Thanks for the patch!

IIUC this was in my tree for next, but more testing
and review found issues (like this one) so I dropped it for now.

>  drivers/vhost/vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6305382eacbb..25ab4d06e559 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -667,9 +667,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  		group = ops->get_vq_group(vdpa, idx);
>  		if (group >= vdpa->ngroups || group > U32_MAX || group < 0)
>  			return -EIO;
> -		else if (copy_to_user(argp, &s, sizeof(s)))
> -			return -EFAULT;
>  		s.num = group;
> +		if (copy_to_user(argp, &s, sizeof(s)))
> +			return -EFAULT;
>  		return 0;
>  	}
>  	case VHOST_VDPA_GET_VRING_DESC_GROUP:
> -- 
> 2.51.0

