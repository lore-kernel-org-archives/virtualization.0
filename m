Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1038F44
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712722879; cv=none; b=iLwPvHtd5CiKf8i9OrYjZZAOBxbc3ZNrb0IlRWwfyqFtFQja8G2o1kFZUg54EovJFg7flg93/aEco78V56TimuhLV/wlRcAytj415lZeepHbZJflgiPoCjx9vQzMfZlYco6U0cJqsRXPqZIJqb148ECAEm6gISWfg1JuLxnggBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712722879; c=relaxed/simple;
	bh=2/hF3zY1yMLODkDaisVP5DXX1EBiu4O90JyHxGnDlaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TqOy/xStc9lB4wz+son0NYnBXmycCAIY2JSkeFPNGYc5ouDDDvwIV1sIg/GrvJ7sj+qVuBPZfT1OEFRp9pcx23XR/z6mkq+IOaqBDSUbPFAgKtl8cDh/5wmF46s/KO/6Ceirn4ZPFw7OpZpr6sJTRPvsaD0WjAQyV+PJK6QB3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPkTs51B; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPkTs51B"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B092D401D8
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 04:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QppyC47yjiwe for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Apr 2024 04:21:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C77E140138
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C77E140138
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OPkTs51B
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C77E140138
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 04:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712722875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6kg0Aaz2KXvd4oQozTSa6OQkaOTff0pnRUImrqo+Xo=;
	b=OPkTs51BpMqV+DThkBVgEA9qtbZS4n07PRgLelhBgxvoWDO21TSeMBnEDRII7o3Py4LDGd
	9NXrVh6UYAvnv3XxkW78KMPE+GdYt8/MJSe4otJZwJK0zQr/9Jnzpe8iAo7pCxhqFXSlnD
	KOiNZ31pdfOiD0EypqqCYKG8ex89hh4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-M5jEK38uPCm8dHY10Y8hSw-1; Wed, 10 Apr 2024 00:21:13 -0400
X-MC-Unique: M5jEK38uPCm8dHY10Y8hSw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343e46df264so2669738f8f.1
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Apr 2024 21:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712722870; x=1713327670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6kg0Aaz2KXvd4oQozTSa6OQkaOTff0pnRUImrqo+Xo=;
        b=TuyXRH2q2qwOEUMBmYWJU2IpD4c7qZYKfUBYylnDN+qFimK/OatmG4kEZ5a6q3F2sG
         c2k1bdOsfeQPxvwHTq1QZW/Cjtpwg+peNx3C26gxJ5kbbclgVjdrD0Gf87gCccCo7GxE
         lq7mFAFtBVmG35WEQBqYn/CYT4OpD5DeMBld+0O5cit2o/dxl4RMoTQCQhxXMjcdj+kg
         pAiXWjwlnc7Zai/dFIaD1IM3mC/qG3UqM9mwvVVoon0iMb+x7X+ZkF2gRCdy66Xbyw0m
         WwgaK2EP6GgK5hou7uCBBkYE5CoBFyez8FgVoSa2Gk8KV8HrV6QR+HkkYX7+JlCmyTbT
         +1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUZjThuawCPlF0m4PpwSInST+y+Ovyd65+ypkrZxX+ymYt7H8Xh5WUOLdA+ukx/FK1IIEEao4jm0nF+lpFA8EwXK8IgE1petvqbfjlNhvMYo5klbtAtBNtHUw==
X-Gm-Message-State: AOJu0Yw8R0TBEMygAIkKoX/AM9o2GNC5/6iini4sqsyrDnX4F1l8+afu
	/tDs4J7ckaAx60C2qJ8f0yN4FQM1R1H4xOs+gk1ACBbnC5JWiBeidD8GpEOvX07pt3DVouQzEzU
	stl5Smv3/SvI9YYRWOHwo1C9Yk48vq5RTq6EhtQtY+KpAS7l6C+lZ+tzdp0F0742ZtwFMIN+GuL
	KOoz4=
X-Received: by 2002:a05:600c:a4b:b0:414:726:87d9 with SMTP id c11-20020a05600c0a4b00b00414072687d9mr1474353wmq.12.1712722870440;
        Tue, 09 Apr 2024 21:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExvrkEWuTXZGzPcZRa+eKl7WQpOIY+ynvxKeNOeIEoRuT4cypblPDgVnOQ0Mf28CwwcIO3BQ==
X-Received: by 2002:a05:600c:a4b:b0:414:726:87d9 with SMTP id c11-20020a05600c0a4b00b00414072687d9mr1474334wmq.12.1712722869909;
        Tue, 09 Apr 2024 21:21:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f3:2f1f:ea4b:8136:1edb:5ddb])
        by smtp.gmail.com with ESMTPSA id bd12-20020a05600c1f0c00b00416645e7e47sm1024917wmb.13.2024.04.09.21.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:21:07 -0700 (PDT)
Date: Wed, 10 Apr 2024 00:21:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: michael.christie@oracle.com
Cc: Jason Wang <jasowang@redhat.com>, oleg@redhat.com,
	ebiederm@xmission.com, virtualization@lists.linux-foundation.org,
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
Message-ID: <20240410002040-mutt-send-email-mst@kernel.org>
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEszFm3LZ4Xf41nnPHrsk4xzUPW-7HZf0xAgoxW9D2Sm-Q@mail.gmail.com>
 <7044bd8c-99a9-4da8-a5ab-c2c293cdea40@oracle.com>
 <20240409110947-mutt-send-email-mst@kernel.org>
 <f7ec68a6-86de-4f3e-abc0-bc3e87f5f5a9@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f7ec68a6-86de-4f3e-abc0-bc3e87f5f5a9@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2024 at 04:55:25PM -0500, michael.christie@oracle.com wrote:
> On 4/9/24 11:40 AM, Michael S. Tsirkin wrote:
> > On Tue, Apr 09, 2024 at 09:57:00AM -0500, Mike Christie wrote:
> >> On 4/8/24 11:16 PM, Jason Wang wrote:
> >>>> It turns out only vhost-scsi had an issue where it would send a command
> >>>> to the block/LIO layer, wait for a response and then process in the vhost
> >>>> task.
> >>> Vhost-net TX zerocopy code did the same:
> >>>
> >>> It sends zerocopy packets to the under layer and waits for the
> >>> underlayer. When the DMA is completed, vhost_zerocopy_callback will be
> >>> called to schedule vq work for used ring updating.
> >>
> >> I think it might be slightly different and vhost-net is ok.
> >>
> >> Above I meant, vhost-scsi would do the equivalent of:
> >>
> >> vhost_zerocopy_callback ->  vhost_net_ubuf_put
> >>
> >> from vhost_task/thread.
> >>
> >> For vhost-net then, if we get an early exit via a signal the patches will flush
> >> queued works and prevent new ones from being queued. vhost_net_release will run
> >> due to the process/thread exit code releasing it's refcounts on the device.
> >>
> >> vhost_net_release will then do:
> >>
> >> vhost_net_flush -> vhost_net_ubuf_put_and_wait
> >>
> >> and wait for vhost_zerocopy_callback -> vhost_net_ubuf_put calls.
> >>
> >> For vhost-scsi we would hang. We would do our equivalent of vhost_net_ubuf_put
> >> from the vhost task/thread. So, when our release function, vhost_scsi_release,
> >> is called we will also do a similar wait. However, because the task/thread is
> >> killed, we will hang there since the "put" will never be done.
> > 
> > If you can find a way to cancel them instead of flushing out,
> > I think it would be better for net, too.
> 
> I don't think canceling block requests will be possible any time soon.
> It's one of those things that people have wanted for decades but it gets
> messy when you are dealing multiple layers (fs, md/md, request queue,
> device driver, etc) that some don't even use the same struct sometimes
> (bios vs requests) and you don't want to hurt performance.
> 
> So for vhost-scsi we can't cancel running block layer IOs because there
> is no interface for it. We have to sit around and wait for them to
> complete or timeout.
> 
> If you are saying cancel at just the vhost/vhost-net/vhost-scsi layers
> then I can do that. However, I think it might be messier.

I think that'd be kind of pointless ...

> We would clean
> up some of the vhost related resource, then return from the
> file_operations->release functions. Then we would have to have some
> workqueue that just waits for driver specific responses (block layer
> responses for vhost-scsi). When it gets them, then it does "puts" on
> it's structs and eventually they are freed.

