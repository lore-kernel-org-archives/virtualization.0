Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE461FF5
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234977; cv=none; b=cceeZfzVEpvPPCOsivDLkJ35WuuUo4/f3do9SxRJ4TK3Y/iwTfD+RbtdEkVgLYyFxy4LzGggNyFo5AXm+ADDwynh5AQpJ1yU0ZIhFJHFXEXZrthrOd7rV/yTmS8L5MQqloAqqkxu1Fyn5xac3uXRDnEuFLoSMplDuxlERQqgrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234977; c=relaxed/simple;
	bh=7aWqsFR7ZQCT9meW0j5CXwRYKeyO1FoqnRXFE++se6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ykv5/Ji+FOmTqBjSiG2ykQ8tNrKqaGeVn23ojulhtCqyCNzpm6eIlNZCpTdFkLqKYXOQ8AEsV8jq2DkTwXA3uvifCxyY/VzQj0Kthco4JDomLPeGkyIH2MDrYY4pdqiKElmqBmMAUKYHtWVbPt2Jxw0MtAxMJ2eg5J1j/OORYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cc4bYZoS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cc4bYZoS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuOSI71O0Ga0zcFKHuvG40R1IcdvB2iMWNepLtRuOYU=;
	b=cc4bYZoStBYfOyB3P/6KaBddOK4eIPhIDp1GmhpSGmWNioaGzVwKEf8idqdh6152CdG1J/
	jZi8x85EwjJlWesbO8MYaZnUoAZqMcN9rf1XfKhUamgy+xBM97Vrj8TKYoE4t5bzxSnFuo
	DIg9AHD4RYdV0LzgZ2GhNVWhedEeE5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-vC-F6_N9PbGSKQ6VZV60aA-1; Mon, 24 Jun 2024 09:16:13 -0400
X-MC-Unique: vC-F6_N9PbGSKQ6VZV60aA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4217f941ca8so27011115e9.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234972; x=1719839772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuOSI71O0Ga0zcFKHuvG40R1IcdvB2iMWNepLtRuOYU=;
        b=OSKsu/AINz/yN8Ec83yZoWAo4hKEgkEY/VRr3krTpt46pZRpRddZXlj3iIEexxdMp6
         pN9ztGqSsM7u3W+wAmEXm2MbQ6sCMICCtFx2IvL3S27EmIMfnxlxTa6V0BS1AtC+DuSB
         TXtOw2oKrDYHQg9i3y+qCbMhYArlKIc+BiTU0M0tp4arwEoDSSwP7L/jvpi38PTGSRXS
         qthhC5rqogvTzDJy6u+93o+dF+wHMVnz6UN7uhPs/0hBdDadmlV+hrZgMpmgO5WcPt8g
         M4Jiq3g0Hp+LAv//qRpZcWfbZTcGh/wlG1h2Ktf693EHRElwjsyO1nsOjIKjxZQOhN57
         8tjA==
X-Gm-Message-State: AOJu0YxSq5bygL1Hv4XK+F3E33vUSXkuMwMf8jZPbNzYeHKLJ+pZaXA9
	Io2eZxxS+9zSb6mwknFSaJIYLuHt/wtQ9oYRxv98rk+BQpC2dp+z6XkCp6YuicWAckAy01N4T5W
	bxewaJT50pMq7XBg803FwA4dKvoDD8go6pgWxv41p9QUBzd9Ae4lqgrunEKN7oqvy
X-Received: by 2002:a05:600c:35c1:b0:424:8e53:5441 with SMTP id 5b1f17b1804b1-4248e53554amr26246385e9.20.1719234972279;
        Mon, 24 Jun 2024 06:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS7O7HUUCilFU+eu+qkspYyHEV2hR05CXlnrKrhKJUTpSvaybrupIo9eVbI024h0QexvtYKw==
X-Received: by 2002:a05:600c:35c1:b0:424:8e53:5441 with SMTP id 5b1f17b1804b1-4248e53554amr26246065e9.20.1719234971528;
        Mon, 24 Jun 2024 06:16:11 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a9f11sm132467395e9.18.2024.06.24.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:16:10 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:16:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <20240624091517-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624070412-mutt-send-email-mst@kernel.org>
 <ZnlwADYkOQs9JClX@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnlwADYkOQs9JClX@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 03:09:20PM +0200, Jiri Pirko wrote:
> Mon, Jun 24, 2024 at 01:07:23PM CEST, mst@redhat.com wrote:
> >On Mon, Jun 24, 2024 at 11:04:43AM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Currently the admin queue command execution is serialized by a lock.
> >> This patchsets lifts this limitation allowing to execute admin queue
> >> commands in parallel. To do that, admin queue processing needs to be
> >> converted from polling to interrupt based completion.
> >> 
> >> Patches #1-#6 are preparations, making things a bit smoother as well.
> >> Patch #7 implements interrupt based completion for admin queue.
> >> Patch #8 finally removes the admin queue serialization lock.
> >
> >Okay ... I assume this is infrastructure for some other need?
> >I'll review, but I'd like to see this actually used.
> 
> No other need. The currently, admin queue cmds are serialized. Note that
> admin queue is currently created for PF. If you have for example
> multiple VFs in legacy mode reading and writing pci bar, that virtio
> vfio driver translates it into admin queue commands. So for example
> probe on multiple VFs gets serialized. This patchset makes it possible
> to run in parallel.


Well probe is mostly serialized but I think I get what you mean -
I am guessing you mean something else like legacy access commands.
> 
> >
> >
> >> Jiri Pirko (8):
> >>   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
> >>   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
> >>   virtio: push out code to vp_avq_index()
> >>   virtio: create admin queues alongside other virtqueues
> >>   virtio_pci_modern: create admin queue of queried size
> >>   virtio_pci_modern: pass cmd as an identification token
> >>   virtio_pci_modern: use completion instead of busy loop to wait on
> >>     admin cmd result
> >>   virtio_pci_modern: remove admin queue serialization lock
> >> 
> >>  drivers/virtio/virtio.c            |  28 +----
> >>  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
> >>  drivers/virtio/virtio_pci_common.h |   9 +-
> >>  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
> >>  include/linux/virtio.h             |   2 +
> >>  include/linux/virtio_config.h      |   2 -
> >>  6 files changed, 150 insertions(+), 160 deletions(-)
> >> 
> >> -- 
> >> 2.45.1
> >

