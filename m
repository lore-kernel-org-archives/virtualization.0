Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5E1AADF
	for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501889; cv=none; b=aa5y3c7VKYeWCu0B8VeMPi8maQ9QRsLcfAQf64aA05sEsaAdKx5HuDNS7Ac3FtWH6axnmD12k8gTHGmuyEWnq9TbJft9J1QnpGQ/2S7xrs2rLwJMZwEgHo6zQ+/3Jy7+gWimipQDiU9i2rOX0W+yLFVm0nqP6bHLl+RzylF81nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501889; c=relaxed/simple;
	bh=Fw3gXm5GXjZxZ4JPw0DW5hTXqGv9wxu9zz3x6N9pKEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxcK6xszGJexCmoYpOKxgSjBgyBCqGbPRy0Y1AtOEM1OasEoqvqYmx7cKkW62j3X8QWBzjv5FLmMQ7Qf/OZ9EbWn0Mt+sRV7cTXGvwAdlMog1eMNE5FbsHvc4Ffm8E3EN0IiEhSFHWp4NQKJ5iN5Q4qcu4J7ji3Um2XfZtGLc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqE8+0Fn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqE8+0Fn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710501886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5BzWgrmdgiGxq+PlZflG+BHDXAH3VOatC+yV3V4Mnk=;
	b=LqE8+0FnLPIGae3x7zI0v1EJ5WswsvKPs2OGxi806Lqlja5I/TrEOdP5rXS+ZDGSFqeXRD
	XM/Bc3vhXSwEDLjnfv6aDH1epGTCt3zkQcl5w2Ay3d3to982743x8KuRlLTHy//BSbQ8U/
	7glDbPOhGBkEq4Ri8hA6DbIpr0HEuTs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-9KkpW20WNUa4njpO2YHn2Q-1; Fri, 15 Mar 2024 07:24:45 -0400
X-MC-Unique: 9KkpW20WNUa4njpO2YHn2Q-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e68be494d2so1359438b3a.2
        for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 04:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501884; x=1711106684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5BzWgrmdgiGxq+PlZflG+BHDXAH3VOatC+yV3V4Mnk=;
        b=psb/kURrhVEBNGRbZQR6Zf1i738inc0wgquhWgu3LjjkHOf9QcdG2cwLmGFi8vnba1
         RIIXTVMQeYUEO7l5clPIW15qNPOvFBZEP+CcAfq1af1tsk1nhD45ASTBziBaNwRdZeVV
         6DR25bXLSO+jG87VgdI4NM8Nw1ICNnS4woKXAwkE5OFN5/4yufu5OFANR8T2GheieVlf
         /7oJ7QVJSgNy6slQlc897OY2C7CdJyVgYT2YNdCSrCjauIGmnP+eLi7ClVWvjPGWVj8i
         jKswyNOtXRdHvLIqp0MVrqKuf/SrboW29hAKiHECfNqpepNi7o7xO33QGH8ob0SFHpVD
         LwbQ==
X-Gm-Message-State: AOJu0YzeImALVTJuadaG+wJUhSttbghE3xUh1Xp2nCMb3BjiHPJQYlYz
	MbfL0OTVIwvNmCERNWGTamOndgYPWTbbgwa2ClU8X23qHtHrTOvKBo/l74bWP26R41YOcEuQCjM
	wy9WkIdajQbb0thBk0jQjjXFZQ9u+QP5r4xdvN2KaEoeVRhe2OSD08oEhDEDfOa6t
X-Received: by 2002:a05:6a00:b96:b0:6e3:b1b3:139f with SMTP id g22-20020a056a000b9600b006e3b1b3139fmr3397438pfj.17.1710501883981;
        Fri, 15 Mar 2024 04:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv6UByGgC+juEfECmFf0FkqYVVrr5jER7l/udV8Oy/Bm8qarOlLsSpAREhnDHVoTzcBzZzsg==
X-Received: by 2002:a05:6a00:b96:b0:6e3:b1b3:139f with SMTP id g22-20020a056a000b9600b006e3b1b3139fmr3397425pfj.17.1710501883695;
        Fri, 15 Mar 2024 04:24:43 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id kt2-20020a056a004ba200b006e6233563cesm3131483pfb.218.2024.03.15.04.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 04:24:43 -0700 (PDT)
Message-ID: <66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com>
Date: Fri, 15 Mar 2024 21:24:36 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
 shan.gavin@gmail.com, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
 <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
 <20240314085630-mutt-send-email-mst@kernel.org>
 <63002c24-8117-458f-84c7-fa4f7acd8cc6@redhat.com>
 <20240315065318-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240315065318-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/15/24 21:05, Michael S. Tsirkin wrote:
> On Fri, Mar 15, 2024 at 08:45:10PM +1000, Gavin Shan wrote:
>>>> Yes, I guess smp_wmb() ('dmb') is buggy on NVidia's grace-hopper platform. I tried
>> to reproduce it with my own driver where one thread writes to the shared buffer
>> and another thread reads from the buffer. I don't hit the out-of-order issue so
>> far.
> 
> Make sure the 2 areas you are accessing are in different cache lines.
> 

Yes, I already put those 2 areas to separate cache lines.

> 
>> My driver may be not correct somewhere and I will update if I can reproduce
>> the issue with my driver in the future.
> 
> Then maybe your change is just making virtio slower and masks the bug
> that is actually elsewhere?
> 
> You don't really need a driver. Here's a simple test: without barriers
> assertion will fail. With barriers it will not.
> (Warning: didn't bother testing too much, could be buggy.
> 
> ---
> 
> #include <pthread.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <assert.h>
> 
> #define FIRST values[0]
> #define SECOND values[64]
> 
> volatile int values[100] = {};
> 
> void* writer_thread(void* arg) {
> 	while (1) {
> 	FIRST++;
> 	// NEED smp_wmb here
         __asm__ volatile("dmb ishst" : : : "memory");
> 	SECOND++;
> 	}
> }
> 
> void* reader_thread(void* arg) {
>      while (1) {
> 	int first = FIRST;
> 	// NEED smp_rmb here
         __asm__ volatile("dmb ishld" : : : "memory");
> 	int second = SECOND;
> 	assert(first - second == 1 || first - second == 0);
>      }
> }
> 
> int main() {
>      pthread_t writer, reader;
> 
>      pthread_create(&writer, NULL, writer_thread, NULL);
>      pthread_create(&reader, NULL, reader_thread, NULL);
> 
>      pthread_join(writer, NULL);
>      pthread_join(reader, NULL);
> 
>      return 0;
> }
> 

Had a quick test on NVidia's grace-hopper and Ampere's CPUs. I hit
the assert on both of them. After replacing 'dmb' with 'dsb', I can
hit assert on both of them too. I need to look at the code closely.

[root@virt-mtcollins-02 test]# ./a
a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
Aborted (core dumped)

[root@nvidia-grace-hopper-05 test]# ./a
a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
Aborted (core dumped)

Thanks,
Gavin

