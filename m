Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D3242914
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673474; cv=none; b=PG6CRY4ASVb3q5DIQ5zSyoICFOFovt7BP+AFY83qZDg/ogWtUHbhg2jbkXGcYDBsj5ABMU3OC2unY3GwiD8Qcqtn33GoKjsRGDhWvhxfyxqsiKBRXnK4cEVov1bPq0bnpZxXYuHsQiTMSdDBGvlIqjsqaINpsjACyhfuaOkpiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673474; c=relaxed/simple;
	bh=3RucRNF7f/0e4O35Hd5elBCl4Zt1WkVLOuvSALfHk/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSRK6H5m6WZCbFp7zVXHgVLJz6b9kbhLcPyGuGh7Sna653qkYwVlJiw/P0nJUk6RhFd6r7IypuVNGJq69LGsCwrkPiOoZZEx3KVy/4fN4+rQVwHoHdv8q+/z02twpoGnkM+JTAgXlik+sN84rtmmjLyZxX23iZOg3iZwlKYuNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpnyCEOC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpnyCEOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743673471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gSdqZyMN/qA57u0AZakL5zHE5rHAQPvR1lJKkRz1QYQ=;
	b=LpnyCEOCNh5AU+4CEQnDT5rxB+ELD30GViTTolzd1ROE/20ndaT9QFYafOqrMJetkVwKGV
	Y/1PrZGkNup5ocbtovf/THHfjo62zd8NzJ1CjWgnDAGxEyIhs7vP2c8GSX/MjOJVDGQnVe
	ur9hbrUSwMMBdonolkD4Kv04+deSUM4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-6gBaz-9TNM-QhyeRq3dEOQ-1; Thu, 03 Apr 2025 05:44:30 -0400
X-MC-Unique: 6gBaz-9TNM-QhyeRq3dEOQ-1
X-Mimecast-MFC-AGG-ID: 6gBaz-9TNM-QhyeRq3dEOQ_1743673469
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391492acb59so449524f8f.3
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 02:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743673469; x=1744278269;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSdqZyMN/qA57u0AZakL5zHE5rHAQPvR1lJKkRz1QYQ=;
        b=ZpbV8FP1GQ3VyhQQOGxDo+HZtG03SIBbA0f47z7ZofKPaMPSEsudeAMyek2QA+vSMN
         0eI0UHisB+VXNIDNMSTaoBrPNmOjtdCcyDk9yNtrrMda+nYi//o/6Co4+d5yxPAnmGv0
         VcUpcpc3RIxxlEs1ikcID8jR697sX3qzXbfm8rgSjEii4q3w3gmoVeDmC4WWewFSs5Qw
         boS2u0YQJADgLJDx3t+e/1xuAQYvHrNi6Im1TE8IAdzhs/QHEv7hiTT8R/ioDWxYRkHf
         6JOqBPif2yn0fEjTijVICT4VkzSX1JkWc4zcQgm/w3qOvjOKws7ZY6HrOGafSptr81N4
         hz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxDfPoN5/txPC2OWeZZ6LqXggagS2aS4X2qAe4PNNQ3Q8W/G5sKiNbMRPXdlyQeFwPAqsI4V3JCGiKpaVNJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPMw1YTKyVAD7g0IgSL5SP0RgzmDP/XxJrpHx9YCcSF1yi7bYH
	Ar8QgVjw9IkUFEkEJzH4kNCK3RKI77OfAdMpgQkh61XshMn64AlvIsDHJtqI1zCGqQOtGrHKcH8
	pvJXI1G3wdYzzcf1swEipf1Cl5vfipBrAgULAFLOtwaDsImD5QDX82wO10p7UjL7b
X-Gm-Gg: ASbGncsGpANORJs1BVW2yCkY58I08m4a69HjX7L8WHw4zvQ8eify3UF5dVrY4Oep3oW
	ESmSgvcbmF9da2xIjwIZ2KEeVyurPpkalgFHhcGbpxnHBF4U08TdWOIrd+YNV34ccY8S9eNsXvg
	krAzCnNVFt1UoY1I3DeWuer4s1o1fRJRpVq+tVXCt1Gd6GcMokLoJ35Yv1M+d2FGld36yJm117a
	m0YKC7n8N3VvcjX2eGeDKnlfrCAlLHZjAQ38MKmp8FKbPIwvCCzCTiSetdhINfKH/LEXysy2F44
	1gzXYi6ezgw37ZLxKod0ASFA/WUDK9BPJjJvgJKSFLBE
X-Received: by 2002:a5d:6dab:0:b0:391:4889:5045 with SMTP id ffacd0b85a97d-39c12114fccmr17337050f8f.36.1743673468935;
        Thu, 03 Apr 2025 02:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/7cEdSHfURTDRVGlG5T0lSpAh1Bd8WT5kQ0J3SBrbGbJ5bEbAFPspWelmdDFLWhEf9/DFjg==
X-Received: by 2002:a5d:6dab:0:b0:391:4889:5045 with SMTP id ffacd0b85a97d-39c12114fccmr17337011f8f.36.1743673468511;
        Thu, 03 Apr 2025 02:44:28 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-76.web.vodafone.de. [109.42.51.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226e9asm1320216f8f.94.2025.04.03.02.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 02:44:28 -0700 (PDT)
Message-ID: <9daf03e4-4526-428c-b584-ede6cb77cada@redhat.com>
Date: Thu, 3 Apr 2025 11:44:15 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
 Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
References: <20250402203621.940090-1-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250402203621.940090-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Fy1EXfkFaif5KMyMDt0DEjuHnSUxC06QRxvJclKenQ_1743673469
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2025 22.36, David Hildenbrand wrote:
> If we finds a vq without a name in our input array in
> virtio_ccw_find_vqs(), we treat it as "non-existing" and set the vq pointer
> to NULL; we will not call virtio_ccw_setup_vq() to allocate/setup a vq.
> 
> Consequently, we create only a queue if it actually exists (name != NULL)
> and assign an incremental queue index to each such existing queue.
> 
> However, in virtio_ccw_register_adapter_ind()->get_airq_indicator() we
> will not ignore these "non-existing queues", but instead assign an airq
> indicator to them.
> 
> Besides never releasing them in virtio_ccw_drop_indicators() (because
> there is no virtqueue), the bigger issue seems to be that there will be a
> disagreement between the device and the Linux guest about the airq
> indicator to be used for notifying a queue, because the indicator bit
> for adapter I/O interrupt is derived from the queue index.
> 
> The virtio spec states under "Setting Up Two-Stage Queue Indicators":
> 
> 	... indicator contains the guest address of an area wherein the
> 	indicators for the devices are contained, starting at bit_nr, one
> 	bit per virtqueue of the device.
> 
> And further in "Notification via Adapter I/O Interrupts":
> 
> 	For notifying the driver of virtqueue buffers, the device sets the
> 	bit in the guest-provided indicator area at the corresponding
> 	offset.
> 
> For example, QEMU uses in virtio_ccw_notify() the queue index (passed as
> "vector") to select the relevant indicator bit. If a queue does not exist,
> it does not have a corresponding indicator bit assigned, because it
> effectively doesn't have a queue index.
> 
> Using a virtio-balloon-ccw device under QEMU with free-page-hinting
> disabled ("free-page-hint=off") but free-page-reporting enabled
> ("free-page-reporting=on") will result in free page reporting
> not working as expected: in the virtio_balloon driver, we'll be stuck
> forever in virtballoon_free_page_report()->wait_event(), because the
> waitqueue will not be woken up as the notification from the device is
> lost: it would use the wrong indicator bit.
> 
> Free page reporting stops working and we get splats (when configured to
> detect hung wqs) like:
> 
>   INFO: task kworker/1:3:463 blocked for more than 61 seconds.
>         Not tainted 6.14.0 #4
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:kworker/1:3 [...]
>   Workqueue: events page_reporting_process
>   Call Trace:
>    [<000002f404e6dfb2>] __schedule+0x402/0x1640
>    [<000002f404e6f22e>] schedule+0x3e/0xe0
>    [<000002f3846a88fa>] virtballoon_free_page_report+0xaa/0x110 [virtio_balloon]
>    [<000002f40435c8a4>] page_reporting_process+0x2e4/0x740
>    [<000002f403fd3ee2>] process_one_work+0x1c2/0x400
>    [<000002f403fd4b96>] worker_thread+0x296/0x420
>    [<000002f403fe10b4>] kthread+0x124/0x290
>    [<000002f403f4e0dc>] __ret_from_fork+0x3c/0x60
>    [<000002f404e77272>] ret_from_fork+0xa/0x38
> 
> There was recently a discussion [1] whether the "holes" should be
> treated differently again, effectively assigning also non-existing
> queues a queue index: that should also fix the issue, but requires other
> workarounds to not break existing setups.
> 
> Let's fix it without affecting existing setups for now by properly ignoring
> the non-existing queues, so the indicator bits will match the queue
> indexes.
> 
> [1] https://lore.kernel.org/all/cover.1720611677.git.mst@redhat.com/
> 
> Fixes: a229989d975e ("virtio: don't allocate vqs when names[i] = NULL")
> Reported-by: Chandra Merla <cmerla@redhat.com>
> Cc: <Stable@vger.kernel.org>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   drivers/s390/virtio/virtio_ccw.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Thanks for tackling this, David!

I tested the patch and the problems are gone now, indeed!

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>

