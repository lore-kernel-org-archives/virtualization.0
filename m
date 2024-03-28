Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983C12B76
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619239; cv=none; b=UGdOAdLB2wFAj3ufTvdiYnQuRSQ1z44SiTRjJ9EX6NLeFPHxltDin0dHBXSwpFmbSOTjiQylWwjH+g+PbTPFec/CdUpOZp7IERQOqu+2Modzd9viju6v3IOc/jYMZoSPGApAkcMgrqMSYSgLbiA7t2Xy1Lq4tf2dYn7VcQ2NlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619239; c=relaxed/simple;
	bh=Zhd/gbtIg5+29hYVKLgk+X6BsacEEqQfNBoqWdGJE4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PUnld+RXv9uoP0dQqU+O6eEVCc+WlkfIdu3cyKKHBApqPGbpyB7QFcYRgh37919Z1zBWvT/fpkwPHTAqvXRumZC6IxG4WRvDjoilulPFMnSSNsc75kb8glqMt8eISlJ5pIXGzycjVBhY0PKUcysFZrdiRS7XktaAj/bYdI9QbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GENr/cSW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GENr/cSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711619236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SawYsKogFb5sBQUjEROENSyTBb4ST5HGRjoCZJ/Iff4=;
	b=GENr/cSWWF2aX+thvK2rjpVK8F3N45weQy1zi4ecIluJw1H7VEYtb2nQjXHq2ywD7uu0fQ
	Fq3U9SZme4mU2lIBR9wxgSGP18DCR7e0SmSHfkt5TMpkON/VgM7OVT+L8ZWsp0wohM3JcZ
	AqvhZwMY0EWHYc5Z+mGdjDouEEAnkDo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-BPO7ZHL4NZ2-mHDnkUfheg-1; Thu, 28 Mar 2024 05:47:14 -0400
X-MC-Unique: BPO7ZHL4NZ2-mHDnkUfheg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-414aa7bd274so3819575e9.1
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 02:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619233; x=1712224033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SawYsKogFb5sBQUjEROENSyTBb4ST5HGRjoCZJ/Iff4=;
        b=igPVjUY2zg7GhXi6Ftf+EFUJ0abdrC1BUnk2aBxl134qtdx14FGO/Ad7Itpkx36z87
         JNAPsCeTlfqSikgHgDzf1q1AGiXwxCbjAhpz/shzlYjBf90QR2Rk/DEpt/y7ZJOMfKoG
         WrKXfGmKwt4yIAvcg6olZImIKdIu0KSzCgXaiTw9kGsrSdPf/zRgL7CZjM8FH1qO2uav
         S89F6/PHROKBbhewhLaWURUHqw/7GLKTAeGD7tImKCnZ78FTt0pp7nFfNRbhDp2F1Rx5
         Y3oMoxn2JxNjMh9E4QProxvutrK7lMIvqG1efVJDrKjx8nFDcLu9UpkaPLlJW9tj3iKf
         JWgg==
X-Gm-Message-State: AOJu0YzIIrNGcCtTXoDsp4gvDF6lOKVn4EJ4igUVWQtjU0d3z9dFpg4g
	dalftDUPLgV/MC8UcYnNP3nYn0rey6Ircm0VKhl+I5sqKTHvecJgl/7le390lCxB1OWaH7+C7IS
	0r3yfwXyv7wJX4PwmSXGNKr4rCeRimhC2hhkmJLfWY6COzZhClcjWi4EVVwa3BVeU
X-Received: by 2002:a05:600c:4586:b0:414:ff4:5957 with SMTP id r6-20020a05600c458600b004140ff45957mr1947281wmo.5.1711619233562;
        Thu, 28 Mar 2024 02:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZaFue3I1OldWu34i+/lGac+Nc3OvI4cwseDnh40D/n1EiBcBwQytbmiQPZsva/0cyFykNIA==
X-Received: by 2002:a05:600c:4586:b0:414:ff4:5957 with SMTP id r6-20020a05600c458600b004140ff45957mr1947271wmo.5.1711619233212;
        Thu, 28 Mar 2024 02:47:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c46d200b0041488978873sm4875877wmo.44.2024.03.28.02.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:47:12 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:47:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, jasowang@redhat.com, will@kernel.org, davem@davemloft.net, 
	stefanha@redhat.com, keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 1/3] vhost: Add smp_rmb() in vhost_vq_avail_empty()
Message-ID: <se44xqedp6lh33yv3cnckpvik6qujrywu7ia3ws4gigkxib4o4@ygwrhlkmkekz>
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-2-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240328002149.1141302-2-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Mar 28, 2024 at 10:21:47AM +1000, Gavin Shan wrote:
>A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
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
>Add the missed smp_rmb() in vhost_vq_avail_empty(). When tx_can_batch()
>returns true, it means there's still pending tx buffers. Since it might
>read indices, so it still can bypass the smp_rmb() in vhost_get_vq_desc().
>Note that it should be safe until vq->avail_idx is changed by commit
>275bf960ac697 ("vhost: better detection of available buffers").
>
>Fixes: 275bf960ac69 ("vhost: better detection of available buffers")
>Cc: <stable@kernel.org> # v4.11+
>Reported-by: Yihuang Yu <yihyu@redhat.com>
>Suggested-by: Will Deacon <will@kernel.org>
>Signed-off-by: Gavin Shan <gshan@redhat.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vhost/vhost.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 045f666b4f12..29df65b2ebf2 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2799,9 +2799,19 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> 	r = vhost_get_avail_idx(vq, &avail_idx);
> 	if (unlikely(r))
> 		return false;
>+
> 	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>+	if (vq->avail_idx != vq->last_avail_idx) {
>+		/* Since we have updated avail_idx, the following
>+		 * call to vhost_get_vq_desc() will read available
>+		 * ring entries. Make sure that read happens after
>+		 * the avail_idx read.
>+		 */
>+		smp_rmb();
>+		return false;
>+	}
>
>-	return vq->avail_idx == vq->last_avail_idx;
>+	return true;
> }
> EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
>
>-- 
>2.44.0
>

