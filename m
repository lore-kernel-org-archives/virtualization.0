Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7C1C9B7A
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Nov 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478335; cv=none; b=udeQnU2i6f8sdj8bjlx6PibE2pLYEu77rJGPMyOTHZTkEO8UD12SiTgn/YP+SEf2o4oDJObjq5lfuvd850U7clmTigoZSd1dqdHQry71jp3rQ5y/EKLqrVClsZym2mNXH3ekFQ9sAMpVzq43m9hqbND58Q0DZRkBAFEANTqpkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478335; c=relaxed/simple;
	bh=gkZChpBifbQONEpNaSG/em21DkUChT3FtrPMXFlVTUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2pa6/kJFE+qzVqXQgc7rkdR5HvGby/RnuoLKmHbDJXh/bqhjkV62elMpgEunvmwInUjQ5pshXFYSI/iSlZCrqEXw7cDHPlUlipwrnYbo5DW1qQy2yy6VUAZitfX7adsglBtq5HCDpvRdXi3Js8VFkBW8fbgJfU/l5feytkrkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTHEJP3x; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTHEJP3x"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B3E8606E5
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Nov 2024 16:25:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OEqHGHBRT8Y2 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Nov 2024 16:25:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D93A1606AA
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D93A1606AA
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eTHEJP3x
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D93A1606AA
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Nov 2024 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730478328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMIrTWdcdyPPasEc5VT2OsTwrDq6glQcSSSvGDAi5U4=;
	b=eTHEJP3xkZqHl0UbL1PlHmIEvamNQIz2CjmQh21bqP+xQL/u3zUByE39wc1042NSZ2lGf9
	fAAWl76OOpbyylJx9Vr6kcX0MgyQAyeOVbIyUMoGjcmkEKRzQUl3BiDGiDT8NhhPbiJMcZ
	RvSQQbQUVTy+onEiaDubWWzUviFWk/0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-qDM4z10pOzqMTmCxWS4-xA-1; Fri, 01 Nov 2024 12:25:23 -0400
X-MC-Unique: qDM4z10pOzqMTmCxWS4-xA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4dad0a63bso2585045ab.0
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Nov 2024 09:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730478323; x=1731083123;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMIrTWdcdyPPasEc5VT2OsTwrDq6glQcSSSvGDAi5U4=;
        b=Ekvf0A3RbGF+0BW4kPwBGcjI+a7w7qVLyiozSsLxnHM+5W2+f1/NrnIfrKMYaSdOQE
         SO7K5ngeQEhJD5nMxbaKC2QSasLyD3ZbHQbxv8qp60VqZPcbxeGEvBYpfargyn5dkcjh
         JJgNjsc0kxsZy1QA7n3g8NhQtp4/6PpgJ6VoHzku/f5nwd94owQTO2eeJAc0i6nWoEYq
         trSttom8yFiUPShkUKluEa3xIr/EHjrhZC0fQ2eXqHIrVW7NfUid5BiHK3LzaRRcdufJ
         UwJQqeSH4D1ogq/vLvat+c+7IeL9X9qE832uU2GRiTo+ogy8FP/kuDV8FPGuVMYoXg1Y
         W9+g==
X-Forwarded-Encrypted: i=1; AJvYcCU08lRDqeytY9Q/L4L65ztPSDZgjPAlfA37tVHQyXXDBUdil/OyZeufhv181BySTC9oDvLBbknSNB2MMPtYAw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyJCnKmAuK37eK2yE64XySIUarGH1HTXSRpcS3cNA3CAXqfGJOx
	U1g7bYuHCjaUq8DXmiuUfRCu5fMahUbcbQ/7WY5uVC7WZ73ovcyQp0wpYrVRrw0wcYq6J1Cp0xf
	QLymS0Q/JwOUfNvnT+B2NzIoLj7m0mCBH1eOCkrmrPOhmLFSN2DDmDBwX+w/llmQI4XQphBRM5b
	XtaNQ=
X-Received: by 2002:a92:6b01:0:b0:3a6:b9b2:a9ef with SMTP id e9e14a558f8ab-3a6b9b2ad2dmr2770015ab.5.1730478322557;
        Fri, 01 Nov 2024 09:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFoE1CTGqbUTQQk5azhuf9xHamn9/EOv+IqwxJxuG64bSlJzXae0gsrbmtl0CM+gmq9oLnWw==
X-Received: by 2002:a92:6b01:0:b0:3a6:b9b2:a9ef with SMTP id e9e14a558f8ab-3a6b9b2ad2dmr2769855ab.5.1730478322078;
        Fri, 01 Nov 2024 09:25:22 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048882cbsm793995173.13.2024.11.01.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 09:25:21 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:25:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Feng Liu <feliu@nvidia.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, Leon Romanovsky <leonro@nvidia.com>, Maor
 Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH vfio 0/7] Enhances the vfio-virtio driver to support
 live migration
Message-ID: <20241101102518.1bf2c6e6.alex.williamson@redhat.com>
In-Reply-To: <CY8PR12MB719511470E1E0BAD06CFFBD2DC552@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241027100751.219214-1-yishaih@nvidia.com>
	<20241028101348.37727579.alex.williamson@redhat.com>
	<20241028162354.GS6956@nvidia.com>
	<20241028105404.4858dcc2.alex.williamson@redhat.com>
	<CY8PR12MB7195FCA5172D7829B1ABC773DC4A2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20241029142826.1b148685.alex.williamson@redhat.com>
	<CY8PR12MB719511470E1E0BAD06CFFBD2DC552@CY8PR12MB7195.namprd12.prod.outlook.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 15:04:51 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, October 30, 2024 1:58 AM
> > 
> > On Mon, 28 Oct 2024 17:46:57 +0000
> > Parav Pandit <parav@nvidia.com> wrote:
> >   
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Monday, October 28, 2024 10:24 PM
> > > >
> > > > On Mon, 28 Oct 2024 13:23:54 -0300
> > > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >  
> > > > > On Mon, Oct 28, 2024 at 10:13:48AM -0600, Alex Williamson wrote:
> > > > >  
> > > > > > If the virtio spec doesn't support partial contexts, what makes
> > > > > > it beneficial here?  
> > > > >
> > > > > It stil lets the receiver 'warm up', like allocating memory and
> > > > > approximately sizing things.
> > > > >  
> > > > > > If it is beneficial, why is it beneficial to send initial data
> > > > > > more than once?  
> > > > >
> > > > > I guess because it is allowed to change and the benefit is highest
> > > > > when the pre copy data closely matches the final data..  
> > > >
> > > > It would be useful to see actual data here.  For instance, what is
> > > > the latency advantage to allocating anything in the warm-up and
> > > > what's the probability that allocation is simply refreshed versus starting  
> > over?  
> > > >  
> > >
> > > Allocating everything during the warm-up phase, compared to no
> > > allocation, reduced the total VM downtime from 439 ms to 128 ms. This
> > > was tested using two PCI VF hardware devices per VM.
> > >
> > > The benefit comes from the device state staying mostly the same.
> > >
> > > We tested with different configurations from 1 to 4 devices per VM,
> > > varied with vcpus and memory. Also, more detailed test results are
> > > captured in Figure-2 on page 6 at [1].  
> > 
> > Those numbers seems to correspond to column 1 of Figure 2 in the
> > referenced document, but that's looking only at downtime.    
> Yes.
> What do you mean by only looking at the downtime?

It's just a prelude to my interpretation that the paper is focusing
mostly on the benefits to downtime and downplaying the apparent longer
overall migration time while rationalizing the effect on RAM migration
downtime.

> The intention was to measure the downtime in various configurations.
> Do you mean, we should have looked at migration bandwidth, migration amount of data, migration time too?
> If so, yes, some of them were not considered as the focus was on two things:
> a. total VM downtime
> b. total migration time
> 
> But with recent tests, we looked at more things. Explained more below.

Good.  Yes, there should be a more holistic approach, improving the
thing we intend to improve without degrading other aspects.
 
> > To me that chart
> > seems to show a step function where there's ~400ms of downtime per
> > device, which suggests we're serializing device resume in the stop-copy
> > phase on the target without pre-copy.
> >  
> Yes. even without serialization, when there is single device, same bottleneck can be observed.
> And your orthogonal suggestion of using parallelism is very useful.
> The paper captures this aspect in text on page 7 after the Table 2.
> 
> > Figure 3 appears to look at total VM migration time, where pre-copy tends to
> > show marginal improvements in smaller configurations, but up to 60% worse
> > overall migration time as the vCPU, device, and VM memory size increase.
> > The paper comes to the conclusion:
> > 
> > 	It can be concluded that either of increasing the VM memory or
> > 	device configuration has equal effect on the VM total migration
> > 	time, but no effect on the VM downtime due to pre-copy
> > 	enablement.
> > 
> > Noting specifically "downtime" here ignores that the overall migration time
> > actually got worse with pre-copy.
> > 
> > Between columns 10 & 11 the device count is doubled.  With pre-copy
> > enabled, the migration time increases by 135% while with pre-copy disabled
> > we only only see a 113% increase.  Between columns 11 & 12 the VM
> > memory is further doubled.  This results in another 33% increase in
> > migration time with pre-copy enabled and only a 3% increase with pre-copy
> > disabled.  For the most part this entire figure shows that overall migration
> > time with pre-copy enabled is either on par with or worse than the same
> > with pre-copy disabled.
> >  
> I will answer this part in more detail towards the end of the email.
>  
> > We then move on to Tables 1 & 2, which are again back to specifically
> > showing timing of operations related to downtime rather than overall
> > migration time.   
> Yes, because the objective was to analyze the effects and improvements on downtime of various configurations of device, VM, pre-copy.
> 
> > The notable thing here seems to be that we've amortized
> > the 300ms per device load time across the pre-copy phase, leaving only 11ms
> > per device contributing to downtime.
> >   
> Correct.
> 
> > However, the paper also goes into this tangent:
> > 
> > 	Our observations indicate that enabling device-level pre-copy
> > 	results in more pre-copy operations of the system RAM and
> > 	device state. This leads to a 50% reduction in memory (RAM)
> > 	copy time in the device pre-copy method in the micro-benchmark
> > 	results, saving 100 milliseconds of downtime.
> > 
> > I'd argue that this is an anti-feature.  A less generous interpretation is that
> > pre-copy extended the migration time, likely resulting in more RAM transfer
> > during pre-copy, potentially to the point that the VM undershot its
> > prescribed downtime.    
> VM downtime was close to the configured downtime, on slightly higher side.
> 
> > Further analysis should also look at the total data
> > transferred for the migration and adherence to the configured VM
> > downtime, rather than just the absolute downtime.
> >  
> We did look the device side total data transferred to see how many iterations of pre-copy done.
> 
> > At the end of the paper, I think we come to the same conclusion shown in
> > Figure 1, where device load seems to be serialized and therefore significantly
> > limits scalability.  That could be parallelized, but even 300-400ms for loading
> > all devices is still too much contribution to downtime.  I'd therefore agree
> > that pre-loading the device during pre-copy improves the scaling by an order
> > of magnitude,   
> Yep.
> > but it doesn't solve the scaling problem.    
> Yes, your suggestion is very valid.
> Parallel operation from the qemu would make the downtime even smaller.
> The paper also highlighted this in page 7 after Table-2.
> 
> > Also, it should not
> > come with the cost of drawing out pre-copy and thus the overall migration
> > time to this extent.    
> Right. You pointed out rightly.
> So we did several more tests in last 2 days for insights you provided.
> And found an interesting outcome.
> 
> In 30+ samples, we collected for each, 
> (a) pre-copy enabled and
> (b) pre-copy disabled.
> 
> This was done for column 10 and 11.
> 
> The VM total migration time varied in range of 13 seconds to 60 seconds.
> Most noticeably with pre-copy off also it varied in such large range.
> 
> In the paper it was pure co-incidence that every time pre-copy=on had
> higher migration time compared to pre-copy=on. This led us to

Assuming typo here, =on vs =off.

> misguide that pre-copy influenced the higher migration time.
> 
> After some reason, we found the QEMU anomaly which was fixed/overcome
> by the knob " avail-switchover-bandwidth". Basically the bandwidth
> calculation was not accurate, due to which the migration time
> fluctuated a lot. This problem and solution are described in [2].
> 
> Following the solution_2, 
> We ran exact same tests of column 10 and 11, with "
> avail-switchover-bandwidth" configured. With that for both the modes
> pre-copy=on and off the total migration time stayed constant to 14-15
> seconds.
> 
> And this conclusion aligns with your analysis that "pre-copy should
> not extent the migration time to this much". Great finding, proving
> that figure_3 was incomplete in the paper.

Great!  So with this the difference in downtime related to RAM
migration in the trailing tables of the paper becomes negligible?  Is
this using the originally proposed algorithm of migrating device data
up to 128 consecutive times or is it using rate-limiting of device data
in pre-copy?  Any notable differences between those algorithms?

> > The reduction in downtime related to RAM copy time
> > should be evidence that the pre-copy behavior here has exceeded its
> > scope and is interfering with the balance between pre- and post-
> > copy elsewhere.  
> As I explained above, pre-copy did its job, it didn't interfere. It
> was just not enough and right samples to analyze back then. Now it is
> resolved. Thanks a lot for the direction.

Glad we could arrive at a better understanding overall.  Thanks,

Alex

