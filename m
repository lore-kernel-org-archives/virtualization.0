Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0613D608
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234569; cv=none; b=fMU7HA1ydh7iItQbTXD1uu7iMBxPZia5QkBmkf/576JZhbDHoFzR+vDY3AdN/leGWgSa2AFJHdioXPjO6pIGS9vaPeFQ1zP589kA5pEP/PUDBkaTWQb3dHntK4hgeDoVaEQi6xShePyPjMLmOnFvT406jtxcEzLcnIECbXiDfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234569; c=relaxed/simple;
	bh=ssOhj6vZf+YQ8gdu5clm+lJubkiKhUx01PeIFH/EtR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SN20LFtAoV2DCGCJ8aZ6NDA3xfn1j+2/ilWLbNU6LdIuMf5tOLjNXEL+qROAE95BJCWHMqXdniYZeMAQfqLck1wfGZBCh+UzTf3UN719sbwUbmdMvuqN4EMdaxWPYfUyuFyW48zHTpHL/NB86nc/R0w8txfn1etrUGT4YjXIVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aKbDbtc3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aKbDbtc3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421d32fda86so47437855e9.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719234564; x=1719839364; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nuq9YSYgX9pToPQCToJ59GqUJHhlaxUp1EL/kKDsVc=;
        b=aKbDbtc3rLoZINOEp0BWI5wz2yOtJSmAYfo98V5I5h7UU9g5cuk0ajtDMrG4mqLJIM
         AAekpWkt6HVsmB/4v4BsrANvk4EmRoCvS2x6JjeLXI9TTR3N68QT/E9NZbww0mjLmBLR
         3DcBS5JTStONQIRdJpRZwTlM6UViayjxirC2YTVBM5Y56tYeSbyTDsbWUqkvScX+px+o
         jKnbJj6zMIFFOgtrL5W6fgL4bpVzGCMlqWV++TYI8nwnZjuzsLaoEz3wVzvs+w5Lv6b2
         GD5tqfaAumdJujVyTl4oTeksr8EgzSOj1w0brN8/9ZDzjluus7koCgYROl8HfLhEtyVa
         ckHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234564; x=1719839364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nuq9YSYgX9pToPQCToJ59GqUJHhlaxUp1EL/kKDsVc=;
        b=b1P9PyC+V2+YBanNtTfIKqVgVhyaeE5rvB23dVWGaM+Skmfkilodb5m4ryoLue0Z0V
         byYmpXeTDZkKLQ+gcrkpa88dtg3GU9szBBdWT8e9pAVo+J4j6rM7ZZlHpAuIrwzdxRch
         Tdij3I1eedSd55IA8e9uUlTUZiHIPG+dd80uwACwi15y2yP6Kq8/9D7AzUjBe7uIOA6D
         VpdnzcEncCuxXhp0jzi1uGr+jMpqQO9DwxLp+yz5trNT/iz31vYllqgVob+mYu2xVU+f
         W4WwuQ/bvG/LPiGpXdMJqmpOYEobgWxeQ3NIaQ1NKmI7DJXuBTGtJc/jxPO1gj9wH1ZG
         lBvA==
X-Gm-Message-State: AOJu0YwWqD9zJcqWhMFg9YV32T4pc7Al+ZfVl40COk1KCJX2uw/RhBBu
	x/36F5CfxWeC2k5X6R+MZg+ZaJGdl6b3fMNW+RlXe+NSvoL/QxoHih2XL6+g9Uk=
X-Google-Smtp-Source: AGHT+IHLpIFFLGCZmwaZPubv/9XBq4WD6YHxKPbKKJNCavbYgBY2Cu0PkXMypJ70FrSxEBCPne0s5A==
X-Received: by 2002:a05:600c:210b:b0:421:7f07:92cf with SMTP id 5b1f17b1804b1-4248cc5d566mr40133635e9.36.1719234563681;
        Mon, 24 Jun 2024 06:09:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8aa6sm10079340f8f.105.2024.06.24.06.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:09:23 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:09:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <ZnlwADYkOQs9JClX@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624070412-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624070412-mutt-send-email-mst@kernel.org>

Mon, Jun 24, 2024 at 01:07:23PM CEST, mst@redhat.com wrote:
>On Mon, Jun 24, 2024 at 11:04:43AM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Currently the admin queue command execution is serialized by a lock.
>> This patchsets lifts this limitation allowing to execute admin queue
>> commands in parallel. To do that, admin queue processing needs to be
>> converted from polling to interrupt based completion.
>> 
>> Patches #1-#6 are preparations, making things a bit smoother as well.
>> Patch #7 implements interrupt based completion for admin queue.
>> Patch #8 finally removes the admin queue serialization lock.
>
>Okay ... I assume this is infrastructure for some other need?
>I'll review, but I'd like to see this actually used.

No other need. The currently, admin queue cmds are serialized. Note that
admin queue is currently created for PF. If you have for example
multiple VFs in legacy mode reading and writing pci bar, that virtio
vfio driver translates it into admin queue commands. So for example
probe on multiple VFs gets serialized. This patchset makes it possible
to run in parallel.


>
>
>> Jiri Pirko (8):
>>   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
>>   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
>>   virtio: push out code to vp_avq_index()
>>   virtio: create admin queues alongside other virtqueues
>>   virtio_pci_modern: create admin queue of queried size
>>   virtio_pci_modern: pass cmd as an identification token
>>   virtio_pci_modern: use completion instead of busy loop to wait on
>>     admin cmd result
>>   virtio_pci_modern: remove admin queue serialization lock
>> 
>>  drivers/virtio/virtio.c            |  28 +----
>>  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
>>  drivers/virtio/virtio_pci_common.h |   9 +-
>>  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
>>  include/linux/virtio.h             |   2 +
>>  include/linux/virtio_config.h      |   2 -
>>  6 files changed, 150 insertions(+), 160 deletions(-)
>> 
>> -- 
>> 2.45.1
>
