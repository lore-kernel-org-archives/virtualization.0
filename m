Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051FA331EDD
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395290; cv=none; b=WDQ7pDKRk1ZgOazQE3vkx2CgZ1xkZlyTqGKr2ju3nzXvFlHEbEJHuSRfOcqFmWJUIegFNA2Pc1mtt0K6AxHI41Cv0CUzdpT3VF+uzzR2s2PR8btM9rwQ9BM0GoQjNllOqwEi3HS671Fa4djlY00QvXuMdDqgD/WDQ9FtuBWBCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395290; c=relaxed/simple;
	bh=RPyyj2ZwL934neIFjFiEega1Hsw3vi8T+eaL8Ksji5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KjfrnWA3WzA7C3bzv6jwHklnWcVgw0y8vPIIPQoqvUcY/kAiwgnKAyV/bPECNlG/LvBWMy9RFpaVD7Vr/yBPICuYfEQtl9i8GiU3VBsNjKUB3Y92fd/zqqUHMG21amB0fSiKiBX8u3tDo7Div5MX1CQc3L1nEaIGNxujjy0ntAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHVq2md/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHVq2md/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784395287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhTRQ5Df2kHb9ziDbG6P62pb0TyzB0oRg1TJubTYfds=;
	b=UHVq2md/YWjvGdAxwG58S4aBc4vq81UiQPuHJJhIwEpFDPy3ZrhXxmmVvidYrDJxl+YJAl
	hC2RB5bzN5DnyE/aouBIN7SsY44N4kuQib/g/OvBc8UhuN2MNhs8Ma1Z0gqIn41wgqvEjG
	+lOMJXAhecly2+RJmBGLi/hfg05mmC8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-th4I__LENiCeqE7qrFImlQ-1; Sat, 18 Jul 2026 13:21:26 -0400
X-MC-Unique: th4I__LENiCeqE7qrFImlQ-1
X-Mimecast-MFC-AGG-ID: th4I__LENiCeqE7qrFImlQ_1784395285
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-472a798fc7cso4219894f8f.1
        for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 10:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784395285; x=1785000085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PhTRQ5Df2kHb9ziDbG6P62pb0TyzB0oRg1TJubTYfds=;
        b=joOZYvjk0J6CwXM2eU9LO+//w9EnVxlFKvmcO/Ttxw+Afny/hQxPha1PaX6jtg/BX7
         22DITFkc9sgF0u93hh0flrrhgozr/QZrqfwwTLX1fheD1Oh4s+OnBArH9Nb+JgP+Erj1
         tqef6DeeUzVVvNuiBOK9Fqs5TbXrxuH/4rcRq8SpvcnjURpr+GLXjEuVzmLW9X7vDYi4
         bKG6RUMNqayTX3AwbebZDUD18n4LhfSgGzouM/LNVGC0iPzrMJLHkTGr172j4zVdbgJL
         QaIsV3/cHI3FbH8Xv9i/Tx2KsYjqD+F6TiLJdSdfodEUx7lejh1L551TsW634Aj8JVbf
         kBYA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7xzCv+38pltcQG1HMXmv0192eoNjqauAxzDcTQYK9dG2plgko46k5AXZFPGW3NpEKXzllQKLwfwRYq78TGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3m0r6ltYw6+hOU6ZVh180Gj1hwOltYj4L4Nj3p9l7Nu96YiSE
	ihtWbG+gIq5kYmOo8Tr90Vg8gVQ36kVemSyTNCflh6h1JL43Ax6tWx42EQ6di/MMevDvjuGws8t
	op74tQNNbLGwk1K52pDEkfqiaomzL8wV3/6uQmHYio+4hj1ojrQ9ga1C3S2LsCp/uAXFO
X-Gm-Gg: AfdE7clAZTCeyPi7p1kmjHqA0zsmlHzc96972nki0P9Lb7qWu9P3QEK0e0Ltv50Rjc1
	5ACHnaTBTUj7np4AWTegyaEqaQck7oSVBz07jNE0T0WQirG5Ohq6hDPLufIQ+bJWxRMsCpup+O+
	XPfQjX8jl1D9htwq5ZU9DSpLe6Wsf/Gcumob1zo96rN6LaIY4JFernPka+hichO7VCl90MQHWWC
	eRI3pA9ZrQLp/JQ0kzyKBL+PE9SgWJFv3gUUDCBxIJ274JkCp8ZhPbjz1Mgn5W1FE0Vqb3T5jIf
	sBgCqGsP5K/2zkkpX3SMCHHNxDBLxAddvApzkl/5RND0TgFm+8UHnLqxZyQUhoSA9kwTNjgOR2m
	ZjLyBGecz295/aPShEa/JQAJD/7bK9Oo=
X-Received: by 2002:a05:600c:1f94:b0:495:3da3:beb with SMTP id 5b1f17b1804b1-4954a3dc491mr80087695e9.10.1784395284891;
        Sat, 18 Jul 2026 10:21:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1f94:b0:495:3da3:beb with SMTP id 5b1f17b1804b1-4954a3dc491mr80087355e9.10.1784395284397;
        Sat, 18 Jul 2026 10:21:24 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7f55sm12590903f8f.18.2026.07.18.10.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 10:21:23 -0700 (PDT)
Date: Sat, 18 Jul 2026 13:21:20 -0400
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
Message-ID: <20260718131715-mutt-send-email-mst@kernel.org>
References: <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
 <2026071803-passage-dares-8240@gregkh>
 <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g72r8ZV_tQ1rh_6faarNxVEumMXArsP31Hswio9bnls_1784395285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Jul 18, 2026 at 10:07:30AM -0700, Carlos Bilbao wrote:
> On 7/17/26 22:29, Greg Kroah-Hartman wrote:
> 
> > On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
> > > Historically, one of the biggest criticisms of coco, especially around
> > > device hardening, was that there were too many values that a
> > > malicious/buggy device could misreport, making it a losing battle. That is
> > > no longer the case with LLMs, and we have the advantage (and challenge) of
> > > open-source dev, which allows us to receive many of these fixes "for free".
> > > If others want to burn their tokens, let them :)
> > I have lots of tokens to burn :)
> > 
> > So along those lines, any suggestions on how best to fuzz these code
> > paths?  Any workloads you all use for testing that I can take advantage
> > of?
> 
> 
> We've the virtio-mem config struct layout and the kernel source, so for
> obvious fixes like a NULL check, static analysis is better than fuzzing.
> Claude took a few mins to find me two examples:
> 
> Patch 1: virtio-mem: reject non-power-of-two device_block_size
> This one is for virtio_mem_init() to check if
> !is_power_of_2(vm->device_block_size)
> 
> Patch 2: virto-mem: validate region_size and usable_region_size
> THis one checks region_size != 0 and vm->usable_reion_size >
> vm->region_size.
> 
> An endless factory of "silly" checks like these are low hanging fruit.

At the same time, these checks don't actually help within the coco
threat model, do they?

> Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
> like a great candidate for those interested in pursuing this direction.
> 
> 
> Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
> can't quickly adapt for virtio-mem and other virtio drivers; the JSON
> definition to describe device behavior is easily extensible. Their threat
> model [2] describes an external attacker, but in the context of coco, the
> virtio device itself is the attacker.

What we need, however, is to exclude DoS attacks - these are outside the
threat model. If people try to address all DoS attacks uncritically we
just get a churn of changes which just might introduce issues of their
own.

Example:

	BUG_ON(!is_power_of_2(....));
panics, non exploitable.

	if(!is_power_of_2(....))
		goto error;

can become exploitable if the cleanup is done wrong.
		


> Here's a vibe coded PR of what I mean:
> 
> https://github.com/seemoo-lab/VirtFuzz/pull/7
> 
> CCed the creators/authors, thanks for open sourcing this!
> 
> Thanks,
> Carlos
> 
> [1] https://github.com/seemoo-lab/VirtFuzz
> 
> On 7/17/26 22:29, Greg Kroah-Hartman wrote:
> 
> > On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
> > > Historically, one of the biggest criticisms of coco, especially around
> > > device hardening, was that there were too many values that a
> > > malicious/buggy device could misreport, making it a losing battle. That is
> > > no longer the case with LLMs, and we have the advantage (and challenge) of
> > > open-source dev, which allows us to receive many of these fixes "for free".
> > > If others want to burn their tokens, let them :)
> > I have lots of tokens to burn :)
> > 
> > So along those lines, any suggestions on how best to fuzz these code
> > paths?  Any workloads you all use for testing that I can take advantage
> > of?
> 
> 
> We've the virto-mem config struct layout and the kernel source, so for
> obvious fixes like a NULL check, static analysis is better than fuzzing.
> Claude took a few mins to find me two examples:
> 
> Patch 1: virtio-mem: reject non-power-of-two device_block_size
> This one is for virtio_mem_init() to check if
> !is_power_of_2(vm->device_block_size)
> 
> Patch 2: virto-mem: validate region_size and usable_region_size
> THis one checks region_size != 0 and vm->usable_reion_size >
> vm->region_size.
> 
> An endless factory of "silly" checks like these are low hanging fruit.
> 
> Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
> like a great candidate for those interested in pursuing this direction.
> 
> 
> Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
> can't quickly adapt for virtio-mem and other virtio drivers; the JSON
> definition to describe device behavior is easily extensible. Their threat
> model [2] describes an external attacker, but in the context of coco, the
> virtio device itself is the attacker. Here's a vibe coded PR of what I mean:
> 
> https://github.com/seemoo-lab/VirtFuzz/pull/7
> 
> CCed the creators/authors, thanks for open sourcing this!
> 
> Thanks,
> Carlos
> 
> [1] https://github.com/seemoo-lab/VirtFuzz
> [2] https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ
> 
> 
> > thanks,
> > 
> > greg k-h
> 
> [2] https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ
> 
> 
> > 
> > thanks,
> > 
> > greg k-h

