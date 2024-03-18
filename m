Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF323748
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748256; cv=none; b=E6crk0F5em03tHaCDfH5PNQmEdWLg2hPwCaQ2n7c9TZPXTzsFoCP7Lqx7bU/QKB9NpXDbSr7LyB6WRA/x7FMt6ZdLUTpE/wmpQUR300nPRIVWT+QV1/xjub2lyvYNw0ogb5XtxWrbuLNPpXTXzXa/rT4xwhLSN2gQapaGm5Mi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748256; c=relaxed/simple;
	bh=bElOvLFlA2lRQnpxtaLmrESGqRhuJI/dzvLGPlMWjgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kEOoJxlNePsT0Odum97U85LkCQkC5mxv3D5qiDDo3IrEIPY56YZt0dO+yHTkGDK6pmk6izt4cdfzuJDpR45PUd9lhARCKikEOFebr7zTtnyHhcA1hAmrtOgB6cehSZr1tm+LDGS97mYb4Z6SmIymsUicQ/CvGjXDyaHyk2UwIdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TS+xE6sf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TS+xE6sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710748254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M61ri+LtQ+sPozYEZ1McUz+TEhyS+suTMSA9oAYcUks=;
	b=TS+xE6sfDwATF+zc4bCqH6xk7gLpQOxoWkA/HiYDB0W/D525IFg6TDEO3BWs+IIqbaCyXm
	Qn8A+qaPrPubSH9R9C7gXl7by1oSk4Or/WUWZc3ZfoQgld4XJ5tlhDZ24mi8wONvWYTQsZ
	+FKZHuylE8VqIpr7M7ejGl9mvIZCVN4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-b2aeheR3OGmD8CmdvgIECA-1; Mon, 18 Mar 2024 03:50:50 -0400
X-MC-Unique: b2aeheR3OGmD8CmdvgIECA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6e6838d04b3so1736190a34.2
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 00:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748250; x=1711353050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M61ri+LtQ+sPozYEZ1McUz+TEhyS+suTMSA9oAYcUks=;
        b=n3fc3voAGz0KNpr0ChvfkOgz/fbYGw+AqKxnrNfo/mSTVe966HDEMiXSeHlwveZ8cx
         iAw6ZY7QydiC0J8x3RqyOF5mw0tS7Tu4cJ6auQpVD3UQ6Qrs1kjS9s3kctUowu/o2Fg0
         2s4a1zRGh1R7SjGHSzUM1WGPpKxeeNIx+s6BQZBZL3fNvCopPsg265K/l8L/iD2yDh1l
         gvRRsG5pqiuBKtC38QQea4D4PnzKrfJ5TZ5um7cTDAs/bNMRHCh6YbO5YAAZPUwZm+7b
         IPeQDcdA3i1O06w6QJv0OxmWyaTFIodeam17YNSgnEd2RyOue1vWxyS1tm/GKP7Fg3iY
         99cQ==
X-Gm-Message-State: AOJu0YztbnwZI1HLfCObGzGM7ZVteSG+DWc1z9yXlofA5fKGZDHTo6eH
	0pu/yL7fWgBiMXeIn0+veoQWFvCWQEL62cXAiSOS46qLN5q44N598amXtpwaSIhTK0PjVNxrQ7h
	v17paLcFibroB6d69c946KC9EImH7EmsWlUh88kLzjIAvQEGqE4qkCyZWh+4DOln/
X-Received: by 2002:a9d:6e8e:0:b0:6e4:9456:6b04 with SMTP id a14-20020a9d6e8e000000b006e494566b04mr12857358otr.5.1710748249607;
        Mon, 18 Mar 2024 00:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE083dlEzBLt+Sky3z69bRCGJ12X1u/z5aEMtKwBNnHV8LauRWAFwR09RP3WUCW/rBcAqaHMg==
X-Received: by 2002:a9d:6e8e:0:b0:6e4:9456:6b04 with SMTP id a14-20020a9d6e8e000000b006e494566b04mr12857341otr.5.1710748249106;
        Mon, 18 Mar 2024 00:50:49 -0700 (PDT)
Received: from redhat.com ([2.52.5.113])
        by smtp.gmail.com with ESMTPSA id g9-20020a056830084900b006e682c00e59sm843274ott.57.2024.03.18.00.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 00:50:48 -0700 (PDT)
Date: Mon, 18 Mar 2024 03:50:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240318034710-mutt-send-email-mst@kernel.org>
References: <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
 <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
 <20240314085630-mutt-send-email-mst@kernel.org>
 <63002c24-8117-458f-84c7-fa4f7acd8cc6@redhat.com>
 <20240315065318-mutt-send-email-mst@kernel.org>
 <66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com>
 <20240317124214-mutt-send-email-mst@kernel.org>
 <589d980f-2e4d-47b4-9dc7-8c64dbe271ce@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <589d980f-2e4d-47b4-9dc7-8c64dbe271ce@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2024 at 09:41:45AM +1000, Gavin Shan wrote:
> On 3/18/24 02:50, Michael S. Tsirkin wrote:
> > On Fri, Mar 15, 2024 at 09:24:36PM +1000, Gavin Shan wrote:
> > > 
> > > On 3/15/24 21:05, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 15, 2024 at 08:45:10PM +1000, Gavin Shan wrote:
> > > > > > > Yes, I guess smp_wmb() ('dmb') is buggy on NVidia's grace-hopper platform. I tried
> > > > > to reproduce it with my own driver where one thread writes to the shared buffer
> > > > > and another thread reads from the buffer. I don't hit the out-of-order issue so
> > > > > far.
> > > > 
> > > > Make sure the 2 areas you are accessing are in different cache lines.
> > > > 
> > > 
> > > Yes, I already put those 2 areas to separate cache lines.
> > > 
> > > > 
> > > > > My driver may be not correct somewhere and I will update if I can reproduce
> > > > > the issue with my driver in the future.
> > > > 
> > > > Then maybe your change is just making virtio slower and masks the bug
> > > > that is actually elsewhere?
> > > > 
> > > > You don't really need a driver. Here's a simple test: without barriers
> > > > assertion will fail. With barriers it will not.
> > > > (Warning: didn't bother testing too much, could be buggy.
> > > > 
> > > > ---
> > > > 
> > > > #include <pthread.h>
> > > > #include <stdio.h>
> > > > #include <stdlib.h>
> > > > #include <assert.h>
> > > > 
> > > > #define FIRST values[0]
> > > > #define SECOND values[64]
> > > > 
> > > > volatile int values[100] = {};
> > > > 
> > > > void* writer_thread(void* arg) {
> > > > 	while (1) {
> > > > 	FIRST++;
> > > > 	// NEED smp_wmb here
> > >          __asm__ volatile("dmb ishst" : : : "memory");
> > > > 	SECOND++;
> > > > 	}
> > > > }
> > > > 
> > > > void* reader_thread(void* arg) {
> > > >       while (1) {
> > > > 	int first = FIRST;
> > > > 	// NEED smp_rmb here
> > >          __asm__ volatile("dmb ishld" : : : "memory");
> > > > 	int second = SECOND;
> > > > 	assert(first - second == 1 || first - second == 0);
> > > >       }
> > > > }
> > > > 
> > > > int main() {
> > > >       pthread_t writer, reader;
> > > > 
> > > >       pthread_create(&writer, NULL, writer_thread, NULL);
> > > >       pthread_create(&reader, NULL, reader_thread, NULL);
> > > > 
> > > >       pthread_join(writer, NULL);
> > > >       pthread_join(reader, NULL);
> > > > 
> > > >       return 0;
> > > > }
> > > > 
> > > 
> > > Had a quick test on NVidia's grace-hopper and Ampere's CPUs. I hit
> > > the assert on both of them. After replacing 'dmb' with 'dsb', I can
> > > hit assert on both of them too. I need to look at the code closely.
> > > 
> > > [root@virt-mtcollins-02 test]# ./a
> > > a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
> > > Aborted (core dumped)
> > > 
> > > [root@nvidia-grace-hopper-05 test]# ./a
> > > a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
> > > Aborted (core dumped)
> > > 
> > > Thanks,
> > > Gavin
> > 
> > 
> > Actually this test is broken. No need for ordering it's a simple race.
> > The following works on x86 though (x86 does not need barriers
> > though).
> > 
> > 
> > #include <pthread.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <assert.h>
> > 
> > #if 0
> > #define x86_rmb()  asm volatile("lfence":::"memory")
> > #define x86_mb()  asm volatile("mfence":::"memory")
> > #define x86_smb()  asm volatile("sfence":::"memory")
> > #else
> > #define x86_rmb()  asm volatile("":::"memory")
> > #define x86_mb()  asm volatile("":::"memory")
> > #define x86_smb()  asm volatile("":::"memory")
> > #endif
> > 
> > #define FIRST values[0]
> > #define SECOND values[640]
> > #define FLAG values[1280]
> > 
> > volatile unsigned values[2000] = {};
> > 
> > void* writer_thread(void* arg) {
> > 	while (1) {
> > 	/* Now synchronize with reader */
> > 	while(FLAG);
> > 	FIRST++;
> > 	x86_smb();
> > 	SECOND++;
> > 	x86_smb();
> > 	FLAG = 1;
> > 	}
> > }
> > 
> > void* reader_thread(void* arg) {
> >      while (1) {
> > 	/* Now synchronize with writer */
> > 	while(!FLAG);
> > 	x86_rmb();
> > 	unsigned first = FIRST;
> > 	x86_rmb();
> > 	unsigned second = SECOND;
> > 	assert(first - second == 1 || first - second == 0);
> > 	FLAG = 0;
> > 
> > 	if (!(first %1000000))
> > 		printf("%d\n", first);
> >     }
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
> I tried it on host and VM of NVidia's grace-hopper. Without the barriers, I
> can hit assert. With the barriers, it's working fine without hitting the
> assert.
> 
> I also had some code to mimic virtio vring last weekend, and it's just
> working well. Back to our original issue, __smb_wmb() is issued by guest
> while __smb_rmb() is executed on host. The VM and host are running at
> different exception level: EL2 vs EL1. I'm not sure it's the cause. I
> need to modify my code so that __smb_wmb() and __smb_rmb() can be executed
> from guest and host.

It is thinkably possible that on grace-hopper barriers work
differently somehow. We need to find out more though.
Anyone from Nvidia can chime in?

-- 
MST

