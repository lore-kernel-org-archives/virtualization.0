Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E913E046
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236788; cv=none; b=Pv9bHv/Vhrk7o4HSCExYJJkKn6KL1bOG6nEDRUCAE/+UrOXqijr8no8oY/0uDKtg0/Q+YetZPfujdpyGkRQmIY/ki/OfXN/mZiihl8nRK3Hc3/E6EkhgBUfgNJU8WvohlzL9fUPM9bOJy+RZUPJ82MYvVSJQC08rl9IUPLDnH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236788; c=relaxed/simple;
	bh=ixUjHTOyxujGxedfPtBe2qlg+AI6r1KsIt5ozcG0aRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOIfULd7qSFJ0N7GaW0g5er0fdMzaaV1YPpwF461sdvRaeHze4JhsxgwTN09+12oo+P9nAwdQvhG4w2S7AsXWkfnM+BFu/a2c2JyVwThNyVsBRgST/7QU1F5IjaagkuEQBMgsjb/wsplZnCk8XF9Y+5XTVqvC1AEndBEgQZhVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iJyudibd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iJyudibd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso47780875e9.2
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719236784; x=1719841584; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7uYVVgdakP6A3FDP9IvPnpt0kzQvwJdDyw1TWgUlh0o=;
        b=iJyudibdsqDjqAeky4BRmIJUpu1R/tW9e6QgMN3oXMtZTXTbaFc2CO+Uy5oZ4zvG38
         Mg9JU7HD7wCBI5KtWaitv0GrzVtMqmNGvI+gQ7HrCeqN3seGXGDYzrX5VmktpHglQbBV
         3evWpIKGcNcUPbwoJiDBmLkYBDGtHJlgFjjX34Pqy/864g/dgUuVqe1LPZq8uHK+A9Iz
         qm8n2Np+5cW1rO6qCLzNIr0YCnTnrQxdt5uZyPRjGk/afWtMeSpqlfRXmtTQF/Db79fF
         cqIPZPoaI+//YG/sBcvTZ2wd6Tl1wQywRrx52+OQ/db3OHZJfj5FFcz9ktDu/2Rt+QRu
         1YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236784; x=1719841584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uYVVgdakP6A3FDP9IvPnpt0kzQvwJdDyw1TWgUlh0o=;
        b=j1BMR4F5wdQNcz2zbWCjXsrRTb5vILhTMlEX7axbf5KWaNGSljmQRzO5yj4+hfdevQ
         61X8XvYLSuYsn9bbiXl8S12kL41WAqraHmqefRXBv1ZlE+xq153zuHMzJS/GmO5uItWW
         4v0370wSMFt5WVm9ujE+vW7GsZjULJpITW6bkb5fia3YcesqSTbHZk/U5sIvDHaGVzr7
         6k3V4dxY1tCnUKrfdygA8OIcvGb4oPlk0yWLDgV2P5yVn1oLKjF+FK+OI3+jJ9LKMF1J
         1hsa5itpr9k5avXpqFs1GZoJUjBZN7bqBtB2RX7w9CbKvRNEdv4YAbqx8VU1OVwQFP7F
         PbPA==
X-Forwarded-Encrypted: i=1; AJvYcCXX7UGGKGpidmRYpRL7yZqg1/WVoJEzdaUkcPHuHIxIfzU1TRGcSIJNPx8pZxOqTu5Av0K+UfSK1PDfSSVbrkheOMjG1bA5bReGxegtSGk=
X-Gm-Message-State: AOJu0YxcU9eNFGX3b7c6usSG93W7bezLO6lbRxMDii+jcmXjlL81eWe5
	K+7vxOXj4YQka29SnwgOulBAiRYIzvGw56WW7tN/zi99xx0LM1mXkyhXo4V8gC4=
X-Google-Smtp-Source: AGHT+IH0kWDLHZeIInE8mwwWRscNhTV9wH6d3kJt9i1ZBUfNK9+viVsnh/qUaGjqEDNrboipuhP+Ng==
X-Received: by 2002:a7b:c4d0:0:b0:423:4c2:7a38 with SMTP id 5b1f17b1804b1-4248cc340demr40324995e9.20.1719236783638;
        Mon, 24 Jun 2024 06:46:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481910f64sm138771865e9.34.2024.06.24.06.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:46:23 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:46:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <Znl4q_ArglG1aqPv@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624070832-mutt-send-email-mst@kernel.org>

Mon, Jun 24, 2024 at 01:23:01PM CEST, mst@redhat.com wrote:
>On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
>> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> > From: Jiri Pirko <jiri@nvidia.com>
>> > 
>> > Currently the admin queue command execution is serialized by a lock.
>> > This patchsets lifts this limitation allowing to execute admin queue
>> > commands in parallel. To do that, admin queue processing needs to be
>> > converted from polling to interrupt based completion.
>> > 
>> > Patches #1-#6 are preparations, making things a bit smoother as well.
>> > Patch #7 implements interrupt based completion for admin queue.
>> 
>> Hi, Jiri
>> 
>> Before this set, I pushed the cvq irq set [1], and the discussion focused on the
>> fact that the newly added irq vector may cause the IO queue to fall back to
>> shared interrupt mode.
>> But it is true that devices implemented according to the specification should
>> not encounter this problem. So what do you think?

Wait. Please note that admin queue is only created and used by PF virtio
device. And most probably, this is on hypervisor managing the VFs that
are passed to guest VMs. These VFs does not have admin queue.

Therefore, this is hardly comparable to control vq.


>> 
>> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
>
>It's true - this can cause guest to run out of vectors for a variety of
>reasons.
>
>First we have guest irqs - I am guessing avq could use IRQF_SHARED ?

There is no avq in quest, under normal circumstances. Unless for some
reason somebody passes trough virtio PF into guest.


>I am not sure why we don't allow IRQF_SHARED for the config
>interrupt though. So I think addressing this part can be deferred.
>
>Second, we might not have enough msix vectors on the device. Here sharing
>with e.g. cvq and further with config interrupt would make sense.

For cvq irq vector, I believe that sharing with config irq makes sense.
Even for admin queue maybe. But again, admin queue is on PF. I don't
think this is a real concern.


>
>Jiri do you think you can help Heng Qi hammer out a solution for cvq?
>I feel this will work will then benefit in a similar way,
>and having us poll aggressively for cvq but not admin commands
>does not make much sense, right?
>
>> > Patch #8 finally removes the admin queue serialization lock.
>> > 
>> > Jiri Pirko (8):
>> >   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
>> >   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
>> >   virtio: push out code to vp_avq_index()
>> >   virtio: create admin queues alongside other virtqueues
>> >   virtio_pci_modern: create admin queue of queried size
>> >   virtio_pci_modern: pass cmd as an identification token
>> >   virtio_pci_modern: use completion instead of busy loop to wait on
>> >     admin cmd result
>> >   virtio_pci_modern: remove admin queue serialization lock
>> > 
>> >  drivers/virtio/virtio.c            |  28 +----
>> >  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
>> >  drivers/virtio/virtio_pci_common.h |   9 +-
>> >  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
>> >  include/linux/virtio.h             |   2 +
>> >  include/linux/virtio_config.h      |   2 -
>> >  6 files changed, 150 insertions(+), 160 deletions(-)
>> > 
>> > -- 
>> > 2.45.1
>> > 
>> > 
>
