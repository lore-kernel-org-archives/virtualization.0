Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593E2940F
	for <virtualization@lists.linux.dev>; Tue,  7 Jan 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264369; cv=none; b=KEE1yZs/dzHEYwlJw8PCSPhLMvQSv8N0SsMTvapg6joMBV97ZTHZhTHniah77yTOlKYWoSKP74o4htmeUJ8iDIQ+kTrGrxqIVquIX869rzv7SsNemSVewSgQeGxhrpfKOX5gnJH1cbatFcsjnzVYYQ/WMcsjQPJzGiwHTcN/2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264369; c=relaxed/simple;
	bh=FRVjJvG/HbiP4iJ9ShtEBTB73KvSoziGGuOe71w7ujY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j9CrRSNYL8AWX/xJyCi1hIZejoEkcCr7GvkSRvOyN5Ttwa/GyUjzNKre8N3gU3uaAAPLvoXEtBy5nhya08YvcDCZNe76/NgzDC/XGs9lbbzJHJvnbsGOsRy+tSzEQjbh2jUBJzX9sVOwM8izbtCTTrj99cHWRgI5YjaQmwIReFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vrv3c3/k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vrv3c3/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736264365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHSg1y6UnjoLFUKVWKkQCt5FDx941kJIeDF0Ru2YJVU=;
	b=Vrv3c3/kSgLyrjQEKIr3fCuEXMxa33VP28Qct0a5oxR3mWM/lj9tiQjdHLjW7UlGONWXDA
	n7wBd2rmRz0mV/BRp54FRkCaow028K0j7PArjTEi9HueGFMEforMYOR1zY4PsdY7iV4G3q
	kApcxfr1dW9tGJv1OPy4kS3kovI7eQg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-Sbfb5fHDNBa5hKFZVqFmMA-1; Tue, 07 Jan 2025 10:39:25 -0500
X-MC-Unique: Sbfb5fHDNBa5hKFZVqFmMA-1
X-Mimecast-MFC-AGG-ID: Sbfb5fHDNBa5hKFZVqFmMA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8f94518c9so333127936d6.1
        for <virtualization@lists.linux.dev>; Tue, 07 Jan 2025 07:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264364; x=1736869164;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHSg1y6UnjoLFUKVWKkQCt5FDx941kJIeDF0Ru2YJVU=;
        b=Ka/xaS35WEa8pDlXafLVeIiUxxXAAy5YOF8BNaMpyu7tp3rgaOKYJOHDvBBWvWrM+m
         l4BIZ3VDgF3uRRnAS9Nhc4o3Vzx7j6R1fbMWLtPPTMhYMm0x6LDjhhOY2DhUHKIi4q5k
         +Z8zFafg9DF2IPoR3cXWhBi0ExjUDSqwgj1s/cN7UmVkDZkvqp0ESeC6npzosA7bfvDE
         MGR2pKqIiWl9zLkV7ZOYj5Ek2qmW9Snw3RZL8M3mCkNdFu47wETQnu5GZF6RyyU0Qx2v
         JHDSpzJlIXoB/yUspIsDO7FCiY7xx05/LSNSDA4mkiXPTxSycyQvlaIoB+XRPhgcZyHK
         4Xtg==
X-Forwarded-Encrypted: i=1; AJvYcCUzECeRcPrdptwYAvxQT+kC5sxKUetPtWIX8Zxx7RRZWFAKTWCZuzJ5L/gdNY2kUky/pI4U4rr5A94E6GbU4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNmohAOOmfHcEHaR/ezCok/tQgIFt0E39KTvGoeAtKWRzNfmbx
	dD0ug3P8xzBKRiFDwJuISV2nzPfQs1UKHYa9YjPhousVQ5zS8ZjHpKUVbABkemW/2MHbG311Vfb
	6xFm0/YWs+Wnnezyzd4oT8I27tIAPGANCPIJBuhaPK5qRrDMLAssF+3Q0P0ZlnMja
X-Gm-Gg: ASbGncvHssTDEu1kQiP7MsAtd4J1V28JME33NsYr0Jo69X4TBlTYkpLZifEX9z3Mt9/
	vcmfLV9UX8nJEJshYoJSN9DyvFO54cf3g/U+A1EWzDEb45ow7APiPRWD8gFjvcjQtemhoy0P9mn
	4TC3kivjx8nMS+ZFQ6QCPEwur/FE2RP4oB4dwppnvgPaJ4R4O7pTlhevi2ilw0C9IoIAX3gkM/6
	I8ti6wXYOP7VBpG4cs79Gyg7fv3n2BxOWqCor1Aa6n//x4irL9BUDVdyFpYkzZeaEf2k9j4R+bH
	jHPBkPi9XfHrcdzRCbjdSwwB
X-Received: by 2002:a05:6214:33c4:b0:6dd:d3b:de4e with SMTP id 6a1803df08f44-6dd2339a922mr1051439416d6.36.1736264362699;
        Tue, 07 Jan 2025 07:39:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4W8jiXvb2g7SfEbTpg7s86WYmhnjTSw6XGGd3uv3PzoxZkmqTCVHHTeUleWDp0snzmmaxAg==
X-Received: by 2002:a05:6214:33c4:b0:6dd:d3b:de4e with SMTP id 6a1803df08f44-6dd2339a922mr1051439056d6.36.1736264362302;
        Tue, 07 Jan 2025 07:39:22 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181a7c13sm182664036d6.77.2025.01.07.07.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:39:21 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a04eb7d4-4817-41db-bc74-a9fb63f33c5c@redhat.com>
Date: Tue, 7 Jan 2025 10:39:00 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] sched/isolation: document HK_TYPE housekeeping
 option
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Kashyap Desai
 <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth patil <chandrakanth.patil@broadcom.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 Don Brace <don.brace@microchip.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Waiman Long <llong@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Frederic Weisbecker <frederic@kernel.org>,
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, virtualization@lists.linux.dev
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-2-5d355fbb1e14@kernel.org>
In-Reply-To: <20241217-isolcpus-io-queues-v4-2-5d355fbb1e14@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ziWBjwqAzLUiHSWiu8FbDjl3udC7tUnNTAxp3nGz1Ow_1736264364
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/17/24 1:29 PM, Daniel Wagner wrote:
> The enum is a public API which can be used all over the kernel. This
> warrants a bit of documentation.
>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   include/linux/sched/isolation.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 2b461129d1fad0fd0ef1ad759fe44695dc635e8c..6649c3a48e0ea0a88c84bf5f2a74bff039fadaf2 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -6,6 +6,19 @@
>   #include <linux/init.h>
>   #include <linux/tick.h>
>   
> +/**
> + * enum hk_type - housekeeping cpu mask types
> + * @HK_TYPE_TIMER:	housekeeping cpu mask for timers
> + * @HK_TYPE_RCU:	housekeeping cpu mask for RCU
> + * @HK_TYPE_MISC:	housekeeping cpu mask for miscalleanous resources
> + * @HK_TYPE_SCHED:	housekeeping cpu mask for scheduling
> + * @HK_TYPE_TICK:	housekeeping cpu maks for timer tick
> + * @HK_TYPE_DOMAIN:	housekeeping cpu mask for general SMP balancing
> + *			and scheduling algoririthms
> + * @HK_TYPE_WQ:		housekeeping cpu mask for worksqueues
> + * @HK_TYPE_MANAGED_IRQ: housekeeping cpu mask for managed IRQs
> + * @HK_TYPE_KTHREAD:	housekeeping cpu mask for kthreads
> + */
>   enum hk_type {
>   	HK_TYPE_TIMER,
>   	HK_TYPE_RCU,
>
The various housekeeping types are in the process of being consolidated 
as most of them cannot be set independently. See commit 6010d245ddc9 
("sched/isolation: Consolidate housekeeping cpumasks that are always 
identical") in linux-next or tip. So this patch will have conflict.

Cheers,
Longman


