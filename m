Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2913E054
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711497351; cv=none; b=SzKsWUzUhhOsmv2tBYwptAE5SXNpjZT70IJ0uJEsC8V9jv04tmhdoAE8/KrlygrlwCgp9Ywbq5TT000PqUzw5iu4nF8ir0CcM081hpePH6Vfk8ZEbMH6FNwvkmJNyBLcI85MIvO5ZJjbSvTX6gn31mFUaFMjEBb3cofoMgGMW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711497351; c=relaxed/simple;
	bh=CGBZO6sWtWt1UsxFRGNjlem6tqqGRAu237yPiACZoHw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ni7PkXiUDXaMDSSRDOf541HA1BK1+xNmJLIOKqy2P8kRxZymP4Lzvni2Jl5LwzZ/xODrO+YhymPuO3Pnjy9YY5BdqWDAwxUkMBPJk5br1xwvfI+m25rHD5OCSVLBCBNFHu94Bc8BH1JoPC56q1oDs37jNz49IKztQ8YIwv+tWCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1XZ9CgR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1XZ9CgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711497348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BGsDJu8XpAr6x1oX6/jFrO71+5iqc/pjZkV4HoqWC1Q=;
	b=G1XZ9CgRjY8T3w5lAlU+3/IbR323MJRa7+QuizTh1nH3fCpENWglYLqN+SgSiBXVtcy9gZ
	prjF81+ARHzu3oQ57M1RH6wQFhSZ+cMz26JI7y3cblmncGVgNQVpa6fopsbJoRWT/d6jtE
	3Z5hBH/k2+ESkyt9/Sle+FppM7Flkd4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-_8FDdDziPY2DJWRRoMcc0w-1; Tue, 26 Mar 2024 19:55:47 -0400
X-MC-Unique: _8FDdDziPY2DJWRRoMcc0w-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e0bc330263so18053385ad.1
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 16:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711497345; x=1712102145;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGsDJu8XpAr6x1oX6/jFrO71+5iqc/pjZkV4HoqWC1Q=;
        b=b87rONa8dUaeSPC2G5xgBcxl6sr01By/QJSrqLaahvZYw0sHY+M+0bDeknQXCBm4it
         0LJAvuauUhPraC3zDCkotkev+EqSdqVNIX33JU+NwnhrCRTt+HWi7a5AC6LGfDxREQ9q
         YUj9C7pke1OV0fgtpsPspy+041zNz7v2AqUTPzBzuxLATCAdS6ll0Lae4OWJN9o7k0eY
         LQ2kcsmZtHYiRF3pUFsu9S8KXlpoBoE54vXqcYx7cnR7SVbPltG3FUbs+zNTOcmF+gc0
         aVNM09I2FRGEvSvQTJvG1RTJmJp+y8CJ90NGfZUwLrJMG4lFGFf7QHAmFNX8J+mwjroc
         ITxA==
X-Gm-Message-State: AOJu0Yx4/QTGunZELhxNry1b6Mfk/TS01DJK435u0blBQL8234Z+ZOmZ
	TwRhM7LxW+CSpO8WR4PyuBDbB/5AoU1K/cayOD1/mdpOVnRTKcNGt/V5teOm1rZ751Dv8bDL5Cu
	1GeWwRCurcYSJxVsB+36lmt0T+fHP1omMSREkEZPSEdVOSgjhs2GaqNuCLuh9upWuGdWufYnb5n
	LSBmIf03kpjii3IGhQ5oUyeBs2Ji3AUXHCwDa22Vd8CpLN
X-Received: by 2002:a17:902:e546:b0:1e0:2377:b23c with SMTP id n6-20020a170902e54600b001e02377b23cmr11306273plf.51.1711497344962;
        Tue, 26 Mar 2024 16:55:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0PwA7G3bbW59cTMwsRfBzB0MvWtcaXY+g1f6iUtKsH2Z84f05R+a0cugj0CKI9MKqWCmnSA==
X-Received: by 2002:a17:902:e546:b0:1e0:2377:b23c with SMTP id n6-20020a170902e54600b001e02377b23cmr11306241plf.51.1711497344429;
        Tue, 26 Mar 2024 16:55:44 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id k24-20020a170902761800b001e1153c3047sm48387pll.106.2024.03.26.16.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 16:55:43 -0700 (PDT)
Message-ID: <46c6a9aa-821c-4013-afe7-61ec05fc9dd4@redhat.com>
Date: Wed, 27 Mar 2024 09:55:37 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] vhost: Fix stale available ring entries
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 davem@davemloft.net, stefanha@redhat.com, sgarzare@redhat.com,
 keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com,
 Will Deacon <will@kernel.org>
References: <20240326233846.1086253-1-gshan@redhat.com>
In-Reply-To: <20240326233846.1086253-1-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 09:38, Gavin Shan wrote:
> The issue was reported by Yihuang Yu on NVidia's grace-hopper (ARM64)
> platform. The wrong head (available ring entry) is seen by the guest
> when running 'netperf' on the guest and running 'netserver' on another
> NVidia's grace-grace machine.
> 
>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>    -accel kvm -machine virt,gic-version=host -cpu host          \
>    -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>    -m 4096M,slots=16,maxmem=64G                                 \
>    -object memory-backend-ram,id=mem0,size=4096M                \
>     :                                                           \
>    -netdev tap,id=tap0,vhost=true                               \
>    -device virtio-net-pci,bus=pcie.8,netdev=tap0,mac=52:54:00:f1:26:b0
>     :
>    guest# ifconfig eth0 | grep 'inet addr'
>    inet addr:10.26.1.220
>    guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>    virtio_net virtio0: output.0:id 100 is not a head!
> 
> There is missed smp_rmb() in vhost_vq_avail_empty() and vhost_enable_notify().
> Without smp_rmb(), vq->avail_idx is increased but the available ring
> entries aren't arriving to vhost side yet. So a stale available ring
> entry can be fetched in vhost_get_vq_desc().
> 
> Fix it by adding smp_rmb() in those two functions. Note that I need
> two patches so that they can be easily picked up by the stable kernel.
> With the changes, I'm unable to hit the issue again.
> 
> Gavin Shan (2):
>    vhost: Add smp_rmb() in vhost_vq_avail_empty()
>    vhost: Add smp_rmb() in vhost_enable_notify()
> 
>   drivers/vhost/vhost.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 

Sorry, I was supposed to copy Will. Amending for it.

Thanks,
Gavin

