Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC242D757
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693991; cv=none; b=gThNuavyJ8l/ESJPWnFLOSX/7W7+x28x0nK8uzGvnjRFeS/U5+Xa4L7WABQ77j0QYBg48qzhCNE9VAt4Fr6/lN26WihAv2aVYj/j5JsdLhO4wXKck20kBsLpZRAMyZNdD9ZPZVmPcLcQM3eLONg//tLZFowy5gWqkKJM+q9+HjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693991; c=relaxed/simple;
	bh=H+L3QTFFkyCFXwrBvc0mOg6GVJz81+DSixh03RV0aKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WkCc6v0z6FNWT8jWphSIeKREZxUJFpErII+146olq/BXOC7gqYBIyjXElwsopginPWTY5ouSwsSzf+Rh/eIXb3ISBPPcCpr8H5ovTHpaVHgHxmxBoc6hLogHPNgNFuiOCALZkda2ahIALcCsQId9Z9vKLbxAOYY5qtNsksmYF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFlSikGh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFlSikGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786693988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBgk91sGaugiFnpdKSnVzGaySlJCzjj+raiMAVYJqa0=;
	b=CFlSikGhvTqCzK4HG0RzR72BSVA/9w3CBhywsL4rBi1aAWSFkJCR3vM0S/h7L/vzIRB56i
	3IsPJIkd07yVFi8BuBf7WULku/RZ5voEFAwUOCFw1p+G4A6vBoVhD0JYRKSRn/L0+PR4Qi
	iPOYQpxMQwvxPuvJAdU9T8vUyy5V7bM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-LwAjfDzGNRW7CsdpwbUdVA-1; Fri, 14 Aug 2026 03:52:52 -0400
X-MC-Unique: LwAjfDzGNRW7CsdpwbUdVA-1
X-Mimecast-MFC-AGG-ID: LwAjfDzGNRW7CsdpwbUdVA_1786693972
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49571407d1dso4896595e9.0
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 00:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693972; x=1787298772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBgk91sGaugiFnpdKSnVzGaySlJCzjj+raiMAVYJqa0=;
        b=KhFVTvnMYzAv1uRt6KIF3NsP8C4VcF6rHdVll96t+klS3horPYjiWr8nnM4lt8r70i
         PJ8IunOYWyqx7Q86EZ9lkowT86agKKNB73S1NoyCzJwUMWcZPIlQZwZPkjmxgRTb12lh
         0h5z5pOgsDMlsBQHH4UXal7sYdAH2slYJhKXzyfuflkwLeBKM/8Bh1UwP+HPrLH0N4Gp
         DineDfRdm8FalbePBiXevrPrKzahVy08XNVP0sgEjg1C7khCRQayfE/LwFiH1vxLt+1r
         vjo+14WfSthVw9a9ep+1oJJjumG/TBV/1wDuRnWU3WMeYL45UWm0PCJ3ZNIKt44gok7f
         SDLA==
X-Forwarded-Encrypted: i=1; AHgh+RoqL2wuXQQrEJjr+Jsg2nDO0CkACjnWTL2gjfotXjHdveHNfi0ZYIrSM0DjGHjcCzpy2VYOfZCgXaALY7w3zg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze4jqJeuz8ROl4XzK9VwqSyPqALLZMcKLLe8RDgySQlgn995vM
	R8NlbAYatlssIzpP7q+SXYzUD672PKSjXxGqcUlgpfiAixbDrNP2a2W+RDRPwARUb2DDQuyxCAn
	f+oqwOKNNbz1lyrblhtDLL5oE5rVoP9zTxIEPhetIOK6FvdP0RYztwBxbCr76kNdaDw0q
X-Gm-Gg: AR+sD10P8mFxYyhWHDbXovkliZjqPvFdHGcbCWXqwdZ83UyHk2b+mPa4SbazQEJTbXg
	q9LN2BiHuMfdbzArxAdNSKlbcwsFnCEpPwPlCI7KeiAQv5qA7LiniDkhgdKbUGFIreCE6ph9Lpf
	SrbxQWfzumTl7N2bvI+uBoMCK0dlGH+QpQNVsdjBhktPiiMqWmLcXPOO1LphR8/T1A4WWttLGZD
	mIgyQGldxAqr0M5KwbmUL2s4Q/2gocxpKWKXPJBlxl52PN03MNfRA5PZb7ipNkc3RADDSgjbcUA
	3N+AZt2GY0f+pBBXiY8aCBZwuJ8scWQcBcNKiZt9VaK9HgZhSoxbs2YZuk+nBFlia7KWApyCQyc
	vkAhwfQwW25jXzy2B0vJ7WPSxrLKtpCMN519iuIeEdC1DXifQe/hZ
X-Received: by 2002:a05:600c:1da8:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4998798467amr50729595e9.12.1786693971591;
        Fri, 14 Aug 2026 00:52:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4998798467amr50729125e9.12.1786693971141;
        Fri, 14 Aug 2026 00:52:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d33asm33182265e9.10.2026.08.14.00.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:52:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:52:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] vhost/vsock: fix device IOTLB feature lifecycle
Message-ID: <an7JAlFpRVOiC4WQ@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260814072903.124991-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nAVSVFElQ6vs1_gyJ_hQ9lvIgkwAFNygpNcL3i5a6Z0_1786693972
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Aug 14, 2026 at 03:29:00PM +0800, Jia Jia wrote:
>vhost-vsock leaves the device IOTLB attached when userspace clears
>VIRTIO_F_ACCESS_PLATFORM. It also replaces an existing IOTLB with an
>empty one whenever a later feature update keeps ACCESS_PLATFORM enabled.
>
>Patch 1 adds a common vhost helper that detaches the device IOTLB from
>all virtqueues, clears their metadata caches, drops queued IOTLB miss
>messages, and frees the old table after all virtqueues have released
>their pointers.

In the v3 you mentioned that this could be used also in vhost-net and 
maybe vhost-scsi. Would it be better to include the other patches in 
this series as well, since we're basically fixing the same issues, or 
have they already been merged?

Thanks,
Stefano

>
>Patch 2 uses the helper when vhost-vsock clears ACCESS_PLATFORM. The
>acked_features update remains in the vhost-vsock-specific loop.
>
>Patch 3 avoids replacing an existing IOTLB when ACCESS_PLATFORM remains
>enabled across a feature update.
>
>Changes since v3:
>- move the IOTLB teardown helper from vhost-vsock into common vhost code
>- keep acked_features updates in the backend-specific loop
>- add the common helper as a separate first patch
>
>Jia Jia (3):
>  vhost: add helper to clear device IOTLB
>  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
>  vhost/vsock: keep IOTLB across feature updates
>
> drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
> drivers/vhost/vhost.h |  1 +
> drivers/vhost/vsock.c |  7 ++++++-
> 3 files changed, 31 insertions(+), 1 deletion(-)
>
>-- 
>2.34.1
>

