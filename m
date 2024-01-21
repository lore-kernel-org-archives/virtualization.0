Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512E381CD
	for <virtualization@lists.linux.dev>; Sun, 21 Jan 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705862683; cv=none; b=VgSyRi8BTMBBT2a9jlacEl0aiUOKYwgqTzsoSeMtfFuVus+7f4bRVKCgI+08gKTLZxHb5p+RDNBOFFAxnCrBEFWGcDb1lW/tcnTZWnMJ9q5XZHGITsZMhdYKbT/4OJn/rpdGMXwK8V2OZyISSU/H2uY8KYejxfIU5Gu3c547FRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705862683; c=relaxed/simple;
	bh=pAwTTU33ri9CTWjjk66csXD8pbCteqoL4Oh7bntQT0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IGYHmSchZv+beLdVd2dYaqpbknqjtWZsiDfv9ROpPp9kFp4n41e7KudsCAJaW26o0Wht61SaII+khssTgvVYC/rd8ciV0gzWhHDm5QDLxhtwYGm/+ERvvJggqOvJ/M/F7O9E9vYpNzoaOCEKWYT8cIb8wN2awZ4aKr6uH80FK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkwIE3fs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkwIE3fs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705862681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guMoP2TLsfEqj1Hggx/w0+mwdRN+95oChUYRB7tzFcY=;
	b=fkwIE3fsYqPUJrAUjl/tXGq68rAl7Is2LgnmQT94mPow7aPsiz9QIDCKW08gu7AoDjNiO5
	WDA+4mrh+nEVrDj0eBzAd8z9x1WqOCXd630FHrNQdBWMb+9fLltDtoNcz5Qzw7OEeMHF1k
	/hHWlipsDOq8Qq4rAFJ47NcjdfJAqc0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-5f0KMLViOH2oz_mIBeB-ng-1; Sun, 21 Jan 2024 13:44:39 -0500
X-MC-Unique: 5f0KMLViOH2oz_mIBeB-ng-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337d92e34d6so1854606f8f.0
        for <virtualization@lists.linux.dev>; Sun, 21 Jan 2024 10:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705862678; x=1706467478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guMoP2TLsfEqj1Hggx/w0+mwdRN+95oChUYRB7tzFcY=;
        b=dQo40AV77n0yeLQ99PrP9Ej3yQqJYmFNMY5Conj0s9guLUF9MwfsR1Vr7NEyRX/7fN
         pWw/CfNR6GXEUHzLXRTWzRHhmNbDiMa4jATSqJA5JpoYFAdmuLAY54E5m2xfRgfdS571
         yvHOXTBauKjvLkRC4BeVaV5TNx8GH37Bjsi1J9OOMVwMDXZVQm58ySsAe3gfCMNMh//3
         NqIE+oATaVGEOnquMj62wF1xN1QBwy2MCDB4yByr3QKKMI6hHRvPQcAXoP63N9lUspu4
         MxvKh2mYbwEdW9DuuK01QePC/DUPgdjGlLi/s5pJmEdfcP/uEAOWrBLhdxy8dWuf1tud
         JZJg==
X-Gm-Message-State: AOJu0YznrLQkygdPqu0idAD1dZT6dGYL9HxjEg6Sydu/fKk84Sy7GNtC
	BKahbzPKMQ0RQ4dLmeD+jGKr4KJRqlsAd+Z4NapPNo0PpYbVRkEluNDo1922mQrueHyo8u+Ncxg
	jc2IHnamm3yv9i7QKDhIShi/z5GZnV3FoXPUCg9zMSMxiD/RsWOhaLjktc+RT08KO
X-Received: by 2002:a05:600c:1c85:b0:40e:4789:7842 with SMTP id k5-20020a05600c1c8500b0040e47897842mr1857740wms.236.1705862678259;
        Sun, 21 Jan 2024 10:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1bzkFTUa/tUGQacRJtg45xo0chZy5yADvcP07PoL9frmkMFBtGIdedbJbDN6aNNam0c94GQ==
X-Received: by 2002:a05:600c:1c85:b0:40e:4789:7842 with SMTP id k5-20020a05600c1c8500b0040e47897842mr1857731wms.236.1705862677920;
        Sun, 21 Jan 2024 10:44:37 -0800 (PST)
Received: from redhat.com ([2.52.14.57])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040e5951f199sm36202366wmq.34.2024.01.21.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 10:44:36 -0800 (PST)
Date: Sun, 21 Jan 2024 13:44:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20240121134311-mutt-send-email-mst@kernel.org>
References: <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
 <20231212111433-mutt-send-email-mst@kernel.org>
 <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
 <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <92916.124010808133201076@us-mta-622.us.mimecast.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 08, 2024 at 02:13:25PM +0100, Tobias Huschle wrote:
> On Thu, Dec 14, 2023 at 02:14:59AM -0500, Michael S. Tsirkin wrote:
> > 
> > Peter, would appreciate feedback on this. When is cond_resched()
> > insufficient to give up the CPU? Should Documentation/kernel-hacking/hacking.rst
> > be updated to require schedule() instead?
> > 
> 
> Happy new year everybody!
> 
> I'd like to bring this thread back to life. To reiterate:
> 
> - The introduction of the EEVDF scheduler revealed a performance
>   regression in a uperf testcase of ~50%.
> - Tracing the scheduler showed that it takes decisions which are
>   in line with its design.
> - The traces showed as well, that a vhost instance might run
>   excessively long on its CPU in some circumstance. Those cause
>   the performance regression as they cause delay times of 100+ms
>   for a kworker which drives the actual network processing.
> - Before EEVDF, the vhost would always be scheduled off its CPU
>   in favor of the kworker, as the kworker was being woken up and
>   the former scheduler was giving more priority to the woken up
>   task. With EEVDF, the kworker, as a long running process, is
>   able to accumulate negative lag, which causes EEVDF to not
>   prefer it on its wake up, leaving the vhost running.
> - If the kworker is not scheduled when being woken up, the vhost
>   continues looping until it is migrated off the CPU.
> - The vhost offers to be scheduled off the CPU by calling 
>   cond_resched(), but, the the need_resched flag is not set,
>   therefore cond_resched() does nothing.
> 
> To solve this, I see the following options 
>   (might not be a complete nor a correct list)
> - Along with the wakeup of the kworker, need_resched needs to
>   be set, such that cond_resched() triggers a reschedule.

Let's try this? Does not look like discussing vhost itself will
draw attention from scheduler guys but posting a scheduling
patch probably will? Can you post a patch?

> - The vhost calls schedule() instead of cond_resched() to give up
>   the CPU. This would of course be a significantly stricter
>   approach and might limit the performance of vhost in other cases.
> - Preventing the kworker from accumulating negative lag as it is
>   mostly not runnable and if it runs, it only runs for a very short
>   time frame. This might clash with the overall concept of EEVDF.
> - On cond_resched(), verify if the consumed runtime of the caller
>   is outweighing the negative lag of another process (e.g. the 
>   kworker) and schedule the other process. Introduces overhead
>   to cond_resched.

Or this last one.


> 
> I would be curious on feedback on those ideas and interested in
> alternative approaches.

