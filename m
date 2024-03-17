Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CC1CF89
	for <virtualization@lists.linux.dev>; Sun, 17 Mar 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710694253; cv=none; b=UKOJJagjUM3Sk2TsSsQt4ZuaCD+aSYs7R4OJiaen+9axevrgEupW9dqbwwgV8M/RonCvHfwW/pf4uePxVA0osYROnhD9D2J3NhkStYoHT/xOwUSSXbxn3q77LbBgvnthmMLxf6LRBxlijNkq8mueaW3/8ulF/6+7MHl3g0wRspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710694253; c=relaxed/simple;
	bh=+69dr8c+5NtNEp3QMh1SBqo5IoYW8Yi5KCnmfdRbgf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hkBbeMR9tbRcQAM2C5BrfztUNyS11CZDz4Qumy2EYs0jhQ6ZWTzp8qwCx1phETLni9D6iHyycGq3FpVGA+sQqkpzkb3J9KgWCiVBvV45iLBebGNpPR6AcOYSqVVfHKyCSIZDNxzrkJunY1T/zso2kAamsyeGMh8xt+rgcO7Bm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJNpOK7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJNpOK7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710694250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGvhd+CS6miBdqthamxj1yw7gllwSdC3ScsQwTgOyD8=;
	b=hJNpOK7QlVpg69PAFlf1t15E0Ky5WJ55sXmJO4usTHwyv3kLvTUB/ScVmY5Efc1bw4T0Nm
	Z3zM+WfvH/9R2rWkkErQ37Td+YOQcIjBftz8uwO5Vsg+9yj7XNHxX7K7rRJrsIhTmXoUAx
	hRqWcWCpqEPxV0AEzsrRRlQcH4nthkE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-RBiS_HnOM9uRmUBClWy28g-1; Sun, 17 Mar 2024 12:50:47 -0400
X-MC-Unique: RBiS_HnOM9uRmUBClWy28g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-568b9d23697so1069888a12.0
        for <virtualization@lists.linux.dev>; Sun, 17 Mar 2024 09:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710694246; x=1711299046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGvhd+CS6miBdqthamxj1yw7gllwSdC3ScsQwTgOyD8=;
        b=D7irLnFbRiki0huE5f/bXFLiVfuEHStCr+6jBgYBqiboBYx6K5qfRZV7DMrRdNYrXq
         PJSIEvoJz1XPsuWeppq/ra0LCCzXzESkG9gultOBG1F9UpDdUEGz6HD6bmQXPdBX+vq5
         Po4Mraw68vwDDzDN6FLYT3NeLT+XQp5MMGkBJAUlLmgqf8h3TaALU5YWkk1zLY2yJAQU
         xnga5lMbli+yfCsFlSHbQtnLou3DKIFMca/f3leOYHduDSb5kjUuaHj90sIJpgFrhB6c
         oR9JjtuXCJVCj/swohU6HiEUrm492SoKNfVTV+OJLBV5bj/q/quAU755UzFt4XiP3aCH
         Ek8Q==
X-Gm-Message-State: AOJu0YwBO222c/iyP6cIOYy4fdteFMoneYN8CjFDwvdLAtDi73GJ51Rd
	uLufjNzDrURLSHNreOlv5xaNq75rgztAoVks6Ocs7AdjNT0GDWRoxudW5Y/5KPYYJ7fswdn7G0b
	ogsj8uGpETnRug8ehmm6bO9vsUpJs3wL7seV9AdG7DiZR5r3T7pwwYoNY5L6dtZuZ
X-Received: by 2002:a05:6402:538f:b0:568:b815:caa0 with SMTP id ew15-20020a056402538f00b00568b815caa0mr4116082edb.39.1710694245820;
        Sun, 17 Mar 2024 09:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Nit2FP2MKnbmfP4dsvWppBfe7t0ROYKCk6hvOVVepgry4K32jKa9tHwjSAngIboUrm7XDw==
X-Received: by 2002:a05:6402:538f:b0:568:b815:caa0 with SMTP id ew15-20020a056402538f00b00568b815caa0mr4116069edb.39.1710694245384;
        Sun, 17 Mar 2024 09:50:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f9:4d09:1b04:6193:3a0b:7c1])
        by smtp.gmail.com with ESMTPSA id b70-20020a509f4c000000b00567c34d8a82sm3950966edf.85.2024.03.17.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 09:50:44 -0700 (PDT)
Date: Sun, 17 Mar 2024 12:50:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240317124214-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
 <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
 <20240314085630-mutt-send-email-mst@kernel.org>
 <63002c24-8117-458f-84c7-fa4f7acd8cc6@redhat.com>
 <20240315065318-mutt-send-email-mst@kernel.org>
 <66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 09:24:36PM +1000, Gavin Shan wrote:
> 
> On 3/15/24 21:05, Michael S. Tsirkin wrote:
> > On Fri, Mar 15, 2024 at 08:45:10PM +1000, Gavin Shan wrote:
> > > > > Yes, I guess smp_wmb() ('dmb') is buggy on NVidia's grace-hopper platform. I tried
> > > to reproduce it with my own driver where one thread writes to the shared buffer
> > > and another thread reads from the buffer. I don't hit the out-of-order issue so
> > > far.
> > 
> > Make sure the 2 areas you are accessing are in different cache lines.
> > 
> 
> Yes, I already put those 2 areas to separate cache lines.
> 
> > 
> > > My driver may be not correct somewhere and I will update if I can reproduce
> > > the issue with my driver in the future.
> > 
> > Then maybe your change is just making virtio slower and masks the bug
> > that is actually elsewhere?
> > 
> > You don't really need a driver. Here's a simple test: without barriers
> > assertion will fail. With barriers it will not.
> > (Warning: didn't bother testing too much, could be buggy.
> > 
> > ---
> > 
> > #include <pthread.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <assert.h>
> > 
> > #define FIRST values[0]
> > #define SECOND values[64]
> > 
> > volatile int values[100] = {};
> > 
> > void* writer_thread(void* arg) {
> > 	while (1) {
> > 	FIRST++;
> > 	// NEED smp_wmb here
>         __asm__ volatile("dmb ishst" : : : "memory");
> > 	SECOND++;
> > 	}
> > }
> > 
> > void* reader_thread(void* arg) {
> >      while (1) {
> > 	int first = FIRST;
> > 	// NEED smp_rmb here
>         __asm__ volatile("dmb ishld" : : : "memory");
> > 	int second = SECOND;
> > 	assert(first - second == 1 || first - second == 0);
> >      }
> > }
> > 
> > int main() {
> >      pthread_t writer, reader;
> > 
> >      pthread_create(&writer, NULL, writer_thread, NULL);
> >      pthread_create(&reader, NULL, reader_thread, NULL);
> > 
> >      pthread_join(writer, NULL);
> >      pthread_join(reader, NULL);
> > 
> >      return 0;
> > }
> > 
> 
> Had a quick test on NVidia's grace-hopper and Ampere's CPUs. I hit
> the assert on both of them. After replacing 'dmb' with 'dsb', I can
> hit assert on both of them too. I need to look at the code closely.
> 
> [root@virt-mtcollins-02 test]# ./a
> a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
> Aborted (core dumped)
> 
> [root@nvidia-grace-hopper-05 test]# ./a
> a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
> Aborted (core dumped)
> 
> Thanks,
> Gavin


Actually this test is broken. No need for ordering it's a simple race.
The following works on x86 though (x86 does not need barriers
though).


#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#if 0
#define x86_rmb()  asm volatile("lfence":::"memory")
#define x86_mb()  asm volatile("mfence":::"memory")
#define x86_smb()  asm volatile("sfence":::"memory")
#else
#define x86_rmb()  asm volatile("":::"memory")
#define x86_mb()  asm volatile("":::"memory")
#define x86_smb()  asm volatile("":::"memory")
#endif

#define FIRST values[0]
#define SECOND values[640]
#define FLAG values[1280]

volatile unsigned values[2000] = {};

void* writer_thread(void* arg) {
	while (1) {
	/* Now synchronize with reader */
	while(FLAG);
	FIRST++;
	x86_smb();
	SECOND++;
	x86_smb();
	FLAG = 1;
	}
}

void* reader_thread(void* arg) {
    while (1) {
	/* Now synchronize with writer */
	while(!FLAG);
	x86_rmb();
	unsigned first = FIRST;
	x86_rmb();
	unsigned second = SECOND;
	assert(first - second == 1 || first - second == 0);
	FLAG = 0;

	if (!(first %1000000))
		printf("%d\n", first);
   }
}

int main() {
    pthread_t writer, reader;

    pthread_create(&writer, NULL, writer_thread, NULL);
    pthread_create(&reader, NULL, reader_thread, NULL);

    pthread_join(writer, NULL);
    pthread_join(reader, NULL);

    return 0;
}

