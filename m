Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7A1CFB6
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297514; cv=none; b=QQg2/UCeySjAni8c7Xp7Bot7/rdnrTIAS/WKF/bVdiAjlwjJ27wwBkT4b985wzxNrL7eAJKUojV2T36kpFJtdhr4+iZWrWwSMEPlQdVyM4nhsS6WVLE0Z8mevM5/khTqJw5RyKCi8AiCVlvBgTTEg7y0MCLjTcT7ND/TRcZSghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297514; c=relaxed/simple;
	bh=otHtmgrEX+XYnTVDWkzIW0qSUtdpdaIIpOkm0JPbKKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttwCDAzdTxvCB+vHbzcLEssYDtEpQyVHint6JT4ARO6+EnwjnmLAJQsD0dsiU5GLnzHAoT0A/NXI5wpRc3dKezk0BQEs18qZ7Vz1MK0kFVRwgFXtDZtueQ1cj7oTYcCN7nbJbsn55w48RB2r8LKEz8b/PR1dfzJm5BE8XrmOQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IAkz1Y1h; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IAkz1Y1h"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ccc40e72eso3397925e87.3
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719297509; x=1719902309; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DurggKVnn5Yq7lIEFNHBeOsXcGZGmbCS8XJmhPPDmOA=;
        b=IAkz1Y1hyOONo7wfbJDHcWNilpeiCvMzB4OiIQuESWL/1a96T3aJLJkVsx4uxFUEMB
         VXB6/5XpvqkvfoOaf/7GZzXcbiCDlk4EcgFLfr9EjiDRDfDHzvP3V76FPPQ43HlsRhh5
         YzAgiXGZOBn3nQH8lkqbPwZw9RcQvyb4lX8P8DwhSTXTJ7fmcvrrkODBl8NmcVYkh+uv
         5q1ZquuDEOp5ccPhaqAd7ENnKkOl2miQfX5sLaTKd2bJPaECc0GvcmHQAYU1xIQQymv/
         72PVCpNvUzL3v8f3dCEvqty61hJlWYBfaZP1jITt7psTo9XIe0PIhYeW842glmJukQOk
         JzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719297509; x=1719902309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DurggKVnn5Yq7lIEFNHBeOsXcGZGmbCS8XJmhPPDmOA=;
        b=CyAK4C3QNfEcNBQK2gT0iKDy6HrOJ1HtxSdnyrWftDo70JPSjm4QEtFJgjBZnBJ6UT
         giql4x05myxpYz6LwSlZpd0hPefTdPV9Eql86Qaj1Q20esZHvaxcV/JEaX2nH4RlPEHt
         NTLdVzN3uII0PPiG1fn9LNYhEO/RlKmTdpj/dX989uHMkPSjQlG5LFY1mYe4ta50bu17
         fJjCUSS9/UDxmj4b67Zino19T02+VrTMVz5HsgX5BHt18wK5W5GdxeeJwPpehYS84g7E
         bAENnp5CpBD7qBeqlCV6GHKgBv9+3zk/RdgZtPvPDSi6aPYtfCwj9A6LhAQhlrfRyf6A
         rnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYHPI/98+xqK4VgS1u8g2OleruweYst1QpLWLE0k6msOjD92pr2qZyrvr23sNPvYaS81rgqbJlDSHEP/PQ7Fl3fNgVtglLl0BiYxhhqzc=
X-Gm-Message-State: AOJu0YxzDqzDEfZPOybgQEdMyILRjmsoyFtTb/vnXzZILv49DwXrAT63
	fd6l5Y5ruxN1hosrTo0HPtiKkbCSHB6ir4iz1zQSpTyKSeiq/MG2e82wJZeblu0=
X-Google-Smtp-Source: AGHT+IGjZuqFTiKAVFawGcXCre7BewDVADijOHhcRbuJcKe86mecMlSqOe1manylF9ie7G/XoJQftw==
X-Received: by 2002:a05:6512:1cb:b0:52c:dd59:6784 with SMTP id 2adb3069b0e04-52ce183c00bmr5132379e87.40.1719297508598;
        Mon, 24 Jun 2024 23:38:28 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208dcesm197022475e9.31.2024.06.24.23.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 23:38:28 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:38:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <Znpl3lrArGU8EdFQ@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
 <20240624095239-mutt-send-email-mst@kernel.org>
 <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
 <20240624111347-mutt-send-email-mst@kernel.org>
 <1719281486.8829272-20-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719281486.8829272-20-hengqi@linux.alibaba.com>

Tue, Jun 25, 2024 at 04:11:26AM CEST, hengqi@linux.alibaba.com wrote:
>On Mon, 24 Jun 2024 11:16:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> On Mon, Jun 24, 2024 at 04:51:37PM +0200, Jiri Pirko wrote:
>> > Mon, Jun 24, 2024 at 03:55:53PM CEST, mst@redhat.com wrote:
>> > >On Mon, Jun 24, 2024 at 03:46:19PM +0200, Jiri Pirko wrote:
>> > >> Mon, Jun 24, 2024 at 01:23:01PM CEST, mst@redhat.com wrote:
>> > >> >On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
>> > >> >> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> > >> >> > From: Jiri Pirko <jiri@nvidia.com>
>> > >> >> > 
>> > >> >> > Currently the admin queue command execution is serialized by a lock.
>> > >> >> > This patchsets lifts this limitation allowing to execute admin queue
>> > >> >> > commands in parallel. To do that, admin queue processing needs to be
>> > >> >> > converted from polling to interrupt based completion.
>> > >> >> > 
>> > >> >> > Patches #1-#6 are preparations, making things a bit smoother as well.
>> > >> >> > Patch #7 implements interrupt based completion for admin queue.
>> > >> >> 
>> > >> >> Hi, Jiri
>> > >> >> 
>> > >> >> Before this set, I pushed the cvq irq set [1], and the discussion focused on the
>> > >> >> fact that the newly added irq vector may cause the IO queue to fall back to
>> > >> >> shared interrupt mode.
>> > >> >> But it is true that devices implemented according to the specification should
>> > >> >> not encounter this problem. So what do you think?
>> > >> 
>> > >> Wait. Please note that admin queue is only created and used by PF virtio
>> > >> device. And most probably, this is on hypervisor managing the VFs that
>> > >> are passed to guest VMs. These VFs does not have admin queue.
>> > >> 
>> > >> Therefore, this is hardly comparable to control vq.
>> > >
>> > >
>> > >Well Parav recently posted patches adding admin queue
>> > >to VFs, with new "self" group type.
>> > 
>> > Right, but even so, when device implementation decides to implement and
>> > enable admin queue, it should also make sure to provide correct amount
>> > of vectors. My point is, there should not be any breakage in user
>> > expectation, or am I missing something?
>> 
>> 
>> Hmm, I think you are right that cvq is an existing capability
>> and adminq is newer.
>
>admin vq has been supported in the kernel for more than half a year, and if at

On PF only, so far.

>this point you think that the device must provide interrupt vectors for it, then
>I think this is also true for cvq.

I'm working on a fallback where admin queue and cvq would share config
vector. Lets see.

>
>> 
>> Gimme a couple of days to think all this over, hopefully we'll also see
>> a new version of the cvq patch, making it easier to see whether they
>> interact and if so, how.
>> 
>> 
>> 
>> > 
>> > >
>> > >
>> > >> 
>> > >> >> 
>> > >> >> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
>> > >> >
>> > >> >It's true - this can cause guest to run out of vectors for a variety of
>> > >> >reasons.
>> > >> >
>> > >> >First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
>> > >> 
>> > >> There is no avq in quest, under normal circumstances. Unless for some
>> > >> reason somebody passes trough virtio PF into guest.
>> > >
>> > >
>> > >At the moment, but this will change soon.
>> > >
>> > >
>> > >> 
>> > >> >I am not sure why we don't allow IRQF_SHARED for the config
>> > >> >interrupt though. So I think addressing this part can be deferred.
>> > >> >
>> > >> >Second, we might not have enough msix vectors on the device. Here sharing
>> > >> >with e.g. cvq and further with config interrupt would make sense.
>> > >> 
>> > >> For cvq irq vector, I believe that sharing with config irq makes sense.
>> > >> Even for admin queue maybe. But again, admin queue is on PF. I don't
>> > >> think this is a real concern.
>> > >> 
>> > >> 
>> > >> >
>> > >> >Jiri do you think you can help Heng Qi hammer out a solution for cvq?
>> > >> >I feel this will work will then benefit in a similar way,
>> > >> >and having us poll aggressively for cvq but not admin commands
>> > >> >does not make much sense, right?
>> > >> >
>> > >> >> > Patch #8 finally removes the admin queue serialization lock.
>> > >> >> > 
>> > >> >> > Jiri Pirko (8):
>> > >> >> >   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
>> > >> >> >   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
>> > >> >> >   virtio: push out code to vp_avq_index()
>> > >> >> >   virtio: create admin queues alongside other virtqueues
>> > >> >> >   virtio_pci_modern: create admin queue of queried size
>> > >> >> >   virtio_pci_modern: pass cmd as an identification token
>> > >> >> >   virtio_pci_modern: use completion instead of busy loop to wait on
>> > >> >> >     admin cmd result
>> > >> >> >   virtio_pci_modern: remove admin queue serialization lock
>> > >> >> > 
>> > >> >> >  drivers/virtio/virtio.c            |  28 +----
>> > >> >> >  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
>> > >> >> >  drivers/virtio/virtio_pci_common.h |   9 +-
>> > >> >> >  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
>> > >> >> >  include/linux/virtio.h             |   2 +
>> > >> >> >  include/linux/virtio_config.h      |   2 -
>> > >> >> >  6 files changed, 150 insertions(+), 160 deletions(-)
>> > >> >> > 
>> > >> >> > -- 
>> > >> >> > 2.45.1
>> > >> >> > 
>> > >> >> > 
>> > >> >
>> > >
>> 
