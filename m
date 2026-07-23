Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272303F1ABB
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851159; cv=none; b=edhIpaT+WaclajV8qIDgmDLDwcMaT2irxV/vv6vbDgojLQ67lmnioQFn1pVLsWVPXzZfZFd06NzUxEWQkCmGd3dUbHkaL55nsgf0EJ8laNYMjmNx4aFeV/+pAjFSonQKIs9U3/2af3QwqYRmginu8oKVJ279ZHElHoQETL9nZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851159; c=relaxed/simple;
	bh=IKxAtZINYxF9GpsCxElzPyG4Yaf1o+nYmZqv96p9RMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NA4ntGZEQJoouWiLHz/IJkYHONQSSqjKRhsRlny1XvLfuUPjCf7muv4tuNAa6xXIsIsud40N8kvHFcjbvS+BOWS9t6S2Y2hbUCStZZpUTiIRhFkoIaOqigbngRULHw4Wvi8FEoGanLGnjUBIbGHLfq/mDTZgfrev3VTszAKL+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQQX0brd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQQX0brd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784851157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEI0aX1+y9xYFrmtNMiKkSHaamceHVFwdAKEA7K4NHg=;
	b=dQQX0brdnrjymm8uglOTyjWzzK15/wcNZ4APVnMT9Bo78YjmdKDDQeNZngU/5YK3Mch1pB
	75qSw1mTvC6Xuyf1SZAcn0psO222xQq0P6eAv44x/NAF3WIk7qDF+jQz/c7FzfYKbDKyWy
	SZmgA8bdNggS4HaW9sv9m2f5ZawM3rI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-sdUydvRNOL62G-sKxc7MhQ-1; Thu, 23 Jul 2026 19:59:13 -0400
X-MC-Unique: sdUydvRNOL62G-sKxc7MhQ-1
X-Mimecast-MFC-AGG-ID: sdUydvRNOL62G-sKxc7MhQ_1784851152
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f5a972b0eso1161535f8f.2
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 16:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784851152; x=1785455952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZEI0aX1+y9xYFrmtNMiKkSHaamceHVFwdAKEA7K4NHg=;
        b=JwlD44qvk0z1KKYjM3D0LrV3AS7hlC4ekFnz9bLTTkQRVZcv2OFv47sCCRovbeI78w
         90Th6nyXZVCdZ/+ryoy3lYuKtQLkSa8vCuPmg8xn98KozL9hsHzYUjFBRHdyvtcWz3ra
         nfYjva5O8aqlGDviS0O7Dbj9wtB6fcWD2U/lqM/8bvQtargWUJnAAwu9L+5LgRBVaA1P
         nI1YhS6AJM9zhZnBm3c9xugy6Kxjl28Q5ZuNtYpnLossMMmpbYb40HZx+uz+9HKanK+h
         2CUR1KJWcLk5o6r3H1PIQ3TEc1MtFucPrMO4WLlNK00IH1sohzMNeT5HjONK397pXymh
         wDLw==
X-Forwarded-Encrypted: i=1; AHgh+Rrad6m5b1WEH1nameDch2lBZwSRuV6Z9w0xSQUC2QzzLBZebG7f8h+vzLDqQQMZ/5QZ75INllo6kZHLFEaKMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybcybJcnvkEKUAt/jH454tC3xsPdUd6pYQ1O1myqaIdBqk9JpX
	hEWE5zKGlAFUBzuuNASkUNzSO5T6Yrddms2bfzDS+EJ0PwNpkMLq7cB5lYybzP9Md0EcDDcq0p7
	QmGQXXlO5xjWIjWOjiSHcyzKI9D48QsFKSjXT0RKkTuDzPwjfIpoxXQ0oOY5iuP/PY/1v
X-Gm-Gg: AR+sD11Fhf8ZZ8G55q49sN9Q/jQxTjTuc2MDZguS6Y9AOXeQJ4EAYkeRNfdjv3B38sN
	5TQiLxQeFacmriN1NspT/xkNkSQ1tL6MFE6l7M0gn+lYJvrzYBvHCIZM3fUi3oh6GM5li2re1pc
	5qLlRpK3xezb+fKvJwiiUU6dIc0PRWF2gJfpkgnniFCcYKvfwnA+u8pA2Nz3RldkyseYEVxLPKs
	T2JqlrilGf2RoJu4Avn6j1XgvwaXe+0zBxvHogkYjL5Fbqp5G+KSR/boCnSHx0/JvWF44FrqrbL
	aCi744UPs04If2TdgoYUglWiD09XyOICBpERC0ZggwuHvwCJ+oVlPNmrVnHGRT9XcnqEIWyij1A
	oz59KCi1RK8uAAuAbMhVLUQ==
X-Received: by 2002:a5d:5e87:0:b0:47f:6fe0:294a with SMTP id ffacd0b85a97d-47f8d72ba0fmr6123616f8f.23.1784851152381;
        Thu, 23 Jul 2026 16:59:12 -0700 (PDT)
X-Received: by 2002:a5d:5e87:0:b0:47f:6fe0:294a with SMTP id ffacd0b85a97d-47f8d72ba0fmr6123582f8f.23.1784851151888;
        Thu, 23 Jul 2026 16:59:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531afsm19209875f8f.24.2026.07.23.16.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:59:10 -0700 (PDT)
Date: Thu, 23 Jul 2026 19:59:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, huster@cs.uni-goettingen.de,
	mhollick@seemoo.de, jiska.classen@hpi.de
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260723195258-mutt-send-email-mst@kernel.org>
References: <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
 <2026071803-passage-dares-8240@gregkh>
 <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
 <20260718131715-mutt-send-email-mst@kernel.org>
 <f8c50876-e18d-4493-ba91-7a4090b6385a@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f8c50876-e18d-4493-ba91-7a4090b6385a@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vfcclnLjNrbCxMAX_6U08oOvHdKskb3TIfqmV993dlU_1784851152
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Jul 18, 2026 at 10:41:26AM -0700, Carlos Bilbao wrote:
> Hello Michael,
> 
> On 7/18/26 10:21, Michael S. Tsirkin wrote:
> > On Sat, Jul 18, 2026 at 10:07:30AM -0700, Carlos Bilbao wrote:
> > > On 7/17/26 22:29, Greg Kroah-Hartman wrote:
> > > 
> > > > On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
> > > > > Historically, one of the biggest criticisms of coco, especially around
> > > > > device hardening, was that there were too many values that a
> > > > > malicious/buggy device could misreport, making it a losing battle. That is
> > > > > no longer the case with LLMs, and we have the advantage (and challenge) of
> > > > > open-source dev, which allows us to receive many of these fixes "for free".
> > > > > If others want to burn their tokens, let them :)
> > > > I have lots of tokens to burn :)
> > > > 
> > > > So along those lines, any suggestions on how best to fuzz these code
> > > > paths?  Any workloads you all use for testing that I can take advantage
> > > > of?
> > > 
> > > We've the virtio-mem config struct layout and the kernel source, so for
> > > obvious fixes like a NULL check, static analysis is better than fuzzing.
> > > Claude took a few mins to find me two examples:
> > > 
> > > Patch 1: virtio-mem: reject non-power-of-two device_block_size
> > > This one is for virtio_mem_init() to check if
> > > !is_power_of_2(vm->device_block_size)
> > > 
> > > Patch 2: virto-mem: validate region_size and usable_region_size
> > > THis one checks region_size != 0 and vm->usable_reion_size >
> > > vm->region_size.
> > > 
> > > An endless factory of "silly" checks like these are low hanging fruit.
> > At the same time, these checks don't actually help within the coco
> > threat model, do they?
> > 
> > > Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
> > > like a great candidate for those interested in pursuing this direction.
> > > 
> > > 
> > > Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
> > > can't quickly adapt for virtio-mem and other virtio drivers; the JSON
> > > definition to describe device behavior is easily extensible. Their threat
> > > model [2] describes an external attacker, but in the context of coco, the
> > > virtio device itself is the attacker.
> > What we need, however, is to exclude DoS attacks - these are outside the
> > threat model. If people try to address all DoS attacks uncritically we
> > just get a churn of changes which just might introduce issues of their
> > own.
> > 
> > Example:
> > 
> > 	BUG_ON(!is_power_of_2(....));
> > panics, non exploitable.
> > 
> > 	if(!is_power_of_2(....))
> > 		goto error;
> > 
> > can become exploitable if the cleanup is done wrong.
> 
> 
> Yes, you are 100% technically right about the scope of the threat model.
> DoS is out of scope because it is a fundamentally unreachable goal; the
> cloud provider can always just "pull the plug". The dangers of
> "vibe-coding" you point out are real, over-eager LLMs fixing up and down
> will create new vulnerabilities in complex cleanup paths. Also, TBH, I
> sympathize with a maintainer's disinterest in reviewing a million stupid
> checks.
> 
> But, to play devil's advocate: this assumes a missing check
> like is_power_of_2 only ever leads to a benign crash, rather than already
> cascading into an unknown, exploitable state down the line.
> 
> So these checks are not _just_ to prevent DoS!

I don't get it. It's normally for bug reporters to show the problem
is real. How about analysing what's going on eh?
The situation where a misbehaving hypervisor crashes guest
and this is reported as a "security problem" is unsustainable.

> 
> Anyhow, this is the exact justification for VirtFuzz. If your main concern
> is that adding validation checks might introduce subtle exploit paths in
> the error-cleanup code, VirtFuzz and tools like that, can fuzz those new
> paths exhaustively. It gives the automated safety net needed to scale coco
> device with as little regressions as possible.

Sorry I'm pretty sceptic how far this will get us, supposedly
all virtio drivers have been fuzzed by now.

Are we gonnu be inserting specilation barriers around all these
"security checks", as one example?

If there's something that never happens, I'm okay with just BUG_ON
instead of carefully propagating errors all around the place.

> 
> > 		
> > 
> > 
> > >   Here's a vibe coded PR of what I mean:
> > > 
> > > https://github.com/seemoo-lab/VirtFuzz/pull/7
> > > 
> > > CCed the creators/authors, thanks for open sourcing this!
> > > 
> > > Thanks,
> > > Carlos
> > > 
> > > [1] https://github.com/seemoo-lab/VirtFuzz
> > > 
> > > On 7/17/26 22:29, Greg Kroah-Hartman wrote:
> > > 
> > > > On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
> > > > > Historically, one of the biggest criticisms of coco, especially around
> > > > > device hardening, was that there were too many values that a
> > > > > malicious/buggy device could misreport, making it a losing battle. That is
> > > > > no longer the case with LLMs, and we have the advantage (and challenge) of
> > > > > open-source dev, which allows us to receive many of these fixes "for free".
> > > > > If others want to burn their tokens, let them :)
> > > > I have lots of tokens to burn :)
> > > > 
> > > > So along those lines, any suggestions on how best to fuzz these code
> > > > paths?  Any workloads you all use for testing that I can take advantage
> > > > of?
> > > 
> > > We've the virto-mem config struct layout and the kernel source, so for
> > > obvious fixes like a NULL check, static analysis is better than fuzzing.
> > > Claude took a few mins to find me two examples:
> > > 
> > > Patch 1: virtio-mem: reject non-power-of-two device_block_size
> > > This one is for virtio_mem_init() to check if
> > > !is_power_of_2(vm->device_block_size)
> > > 
> > > Patch 2: virto-mem: validate region_size and usable_region_size
> > > THis one checks region_size != 0 and vm->usable_reion_size >
> > > vm->region_size.
> > > 
> > > An endless factory of "silly" checks like these are low hanging fruit.
> > > 
> > > Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
> > > like a great candidate for those interested in pursuing this direction.
> > > 
> > > 
> > > Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
> > > can't quickly adapt for virtio-mem and other virtio drivers; the JSON
> > > definition to describe device behavior is easily extensible. Their threat
> > > model [2] describes an external attacker, but in the context of coco, the
> > > virtio device itself is the attacker. Here's a vibe coded PR of what I mean:
> > > 
> > > https://github.com/seemoo-lab/VirtFuzz/pull/7
> > > 
> > > CCed the creators/authors, thanks for open sourcing this!
> > > 
> > > Thanks,
> > > Carlos
> > > 
> > > [1] https://github.com/seemoo-lab/VirtFuzz
> > > [2] https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ
> > > 
> > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > [2] https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ
> > > 
> > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> 
> 
> Thanks,
> 
> Carlos

