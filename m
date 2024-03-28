Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830564CF7
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619310; cv=none; b=pu5crjtFsbPKU+Dmi25tYieUP55f6LC19zwkCWHIQJWE1WGzfazvpbt86uTNcmn3l70No2c9wM4WJD/sBEKFBi9EYvifIacSRfjeN/kebBnCEXVJG05Lkk+Ied1Km5/BQ9AyLDLypLlamXDlt+JfJnSZ5GK7Y+0jHlXYBJmcx/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619310; c=relaxed/simple;
	bh=9vnJI+0gpz+i/GYyu2HPCOAIRPNpTxit1kEdQXpnsP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ty+tjJlvi+T56x7Y6VJRkBD9+brdYvBlMHafqxr1o/kqvciwEKujW+yi/PAVeqyt1DyceEHCEdLgFfRD0KTc/q4mEpuANlxWf7WdFE+7l8OTW2ITvTynAXRGgFIqmQ2rLK3zQQjDt670LCPngV2cbPPcSgpPptaXwUetp5mTdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGwnLX2a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGwnLX2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711619308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJEzAodsfnEL0K0FhCD5vo7II0EhJAX4+qdJjboZa+Y=;
	b=MGwnLX2aIGxaXjXaq2jmEA8o5wKM50Gdn1JPtYCpgkkjx2Th23yD9pfgjQ7hdXztszwt99
	gD2UQBqLwlU3mGOrsrpDmhOx9AJ0sWrOnSQF0Jp0ccE7ImOVVm67SPKlIVfsOS7bdqCOHg
	rb9PV8gYAxJP7qaHAfrY/2/IwUm0FpY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-I0V_3M_FMXqfo85VozWD3A-1; Thu, 28 Mar 2024 05:48:24 -0400
X-MC-Unique: I0V_3M_FMXqfo85VozWD3A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6f7def478so6608091fa.2
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 02:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619303; x=1712224103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJEzAodsfnEL0K0FhCD5vo7II0EhJAX4+qdJjboZa+Y=;
        b=FALsSd1YqViuPMw0VAhnStk6rQBT4wkMPUYKy8du04ihL2IjXl+mdkuvMypEI9PgnH
         xaD8Ro/IPOyGIg8B9WfAbeg8HWt5ZW0ORGDihwO4RpkauMOj/5IpTDRnO8UpEPKeD3zK
         Ip6ADdNnaTW8KCyoDE4MxHhTMaPjg7oa39AhJqNlnX4jKVWmYarovJdPE+f8zriGUkDN
         Y4PSdcRVF2naCDamnb8+yESd/8hHFSN1t7dQXlaVKpKElTKberlvfIHIOuG3XrgALhpy
         Q82O9MslgsdaOefyBwrBgxskI/gR7Ma+esDdNrSVcOosmhySDy/Hv+ZWNTzJ4qDh4hJC
         hrUQ==
X-Gm-Message-State: AOJu0Yw5pBH12FOuOpixeZpxfsQn9Lhfveh1IxvSAn7Ak7TNtu2tYJ14
	5lprWVbrOe8HqfUEtiWCV0BZzovZBMwIx72qQ3iVdg6PtgJogHH+Uu3WEqQEorgRpm6V35yXrat
	1TAU2HDuq2AkYFHp4lXYdZ97mAnzN/g4q1a7uQxYn3ms3QVIX75gOI0qStB8mxSmO
X-Received: by 2002:a2e:3005:0:b0:2d4:a8cf:e798 with SMTP id w5-20020a2e3005000000b002d4a8cfe798mr2029998ljw.14.1711619303300;
        Thu, 28 Mar 2024 02:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlr8XFRSqwaakS5+LO2iJaNYyntFn/LVoEhKaEqAKjIjW0cL05vZPccbrBZ3Q4IxQ5b5nPZA==
X-Received: by 2002:a2e:3005:0:b0:2d4:a8cf:e798 with SMTP id w5-20020a2e3005000000b002d4a8cfe798mr2029979ljw.14.1711619302927;
        Thu, 28 Mar 2024 02:48:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id fm26-20020a05600c0c1a00b0041547fef66dsm871554wmb.15.2024.03.28.02.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:48:22 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:48:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, jasowang@redhat.com, will@kernel.org, davem@davemloft.net, 
	stefanha@redhat.com, keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 2/3] vhost: Add smp_rmb() in vhost_enable_notify()
Message-ID: <yt64yc2lawevdw3ptgt4nkaqub5kzvh75ch2ertchcx7ubzmgw@k2mkbsfsjehy>
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-3-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240328002149.1141302-3-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Mar 28, 2024 at 10:21:48AM +1000, Gavin Shan wrote:
>A smp_rmb() has been missed in vhost_enable_notify(), inspired by
>Will. Otherwise, it's not ensured the available ring entries pushed
>by guest can be observed by vhost in time, leading to stale available
>ring entries fetched by vhost in vhost_get_vq_desc(), as reported by
>Yihuang Yu on NVidia's grace-hopper (ARM64) platform.
>
>  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>  -accel kvm -machine virt,gic-version=host -cpu host          \
>  -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>  -m 4096M,slots=16,maxmem=64G                                 \
>  -object memory-backend-ram,id=mem0,size=4096M                \
>   :                                                           \
>  -netdev tap,id=vnet0,vhost=true                              \
>  -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
>   :
>  guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>  virtio_net virtio0: output.0:id 100 is not a head!
>
>Add the missed smp_rmb() in vhost_enable_notify(). When it returns true,
>it means there's still pending tx buffers. Since it might read indices,
>so it still can bypass the smp_rmb() in vhost_get_vq_desc(). Note that
>it should be safe until vq->avail_idx is changed by commit d3bb267bbdcb
>("vhost: cache avail index in vhost_enable_notify()").
>
>Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
>Cc: <stable@kernel.org> # v5.18+
>Reported-by: Yihuang Yu <yihyu@redhat.com>
>Suggested-by: Will Deacon <will@kernel.org>
>Signed-off-by: Gavin Shan <gshan@redhat.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vhost/vhost.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)

Thanks for fixing this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 29df65b2ebf2..32686c79c41d 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2848,9 +2848,19 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> 		       &vq->avail->idx, r);
> 		return false;
> 	}
>+
> 	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>+	if (vq->avail_idx != vq->last_avail_idx) {
>+		/* Since we have updated avail_idx, the following
>+		 * call to vhost_get_vq_desc() will read available
>+		 * ring entries. Make sure that read happens after
>+		 * the avail_idx read.
>+		 */
>+		smp_rmb();
>+		return true;
>+	}
>
>-	return vq->avail_idx != vq->last_avail_idx;
>+	return false;
> }
> EXPORT_SYMBOL_GPL(vhost_enable_notify);
>
>-- 
>2.44.0
>

