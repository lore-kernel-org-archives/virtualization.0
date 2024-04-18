Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A552D057
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424255; cv=none; b=gJFJMB8vPXOV9MxEVzOfrTh7DXLyVNQ0EP+nVbecpPLSv84BnZAjLZRty5IryBfo7R80/pUfI7GR1hDSZDiKyC6raZ2aOQ/jFYZPFWnmt7Ue59rl3vAI5cC1zkI6t3krBBFBVCE7OWTA4myvEJG61aX3aCyv6tZ0ZBevYtr6Ry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424255; c=relaxed/simple;
	bh=grRz8MGSynNxFk4jLSZzRqB0D5NlA4y9FMdj0w7qTC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FkB2So/N6Nh/vOwPBhsCe1nqnSNs6OFVb53TK0AOQAPLXV/A3sPSGRRv7Dp5TlCzsHgDeElVs7LOq2pDKBDdzvereY+UFP0EPiGo4nle/GKC7vuJADcM8J6eYih76oG2AYGySbQRv5K76Q/QDQEbAm5w3RDZz0kbr1FELPBdumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIbnTwnd; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIbnTwnd"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3713813F8
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:10:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9FfKT5EIUgaE for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Apr 2024 07:10:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BFA27812C8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFA27812C8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EIbnTwnd
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BFA27812C8
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713424250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXuNqL/ceExdhMKWNZ4A4O9zeEkuVX94IXCtvFH2AcM=;
	b=EIbnTwndkLUsTZwekM3WtVNij6efrbnYKLE/FufJl4+HaOTODk1MiggIqKbt7SQEjl9R7G
	5SDZTquk5I9x0RwUCs9MOwuLHzRfVBH1BIrMY0TMtlhCVYB8d6BDUHLALxNX8ZnGzroH6v
	QmtdCR2IX5armcsUiI7NS5/WMdtm2mI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-8Ihyb9zdMiap-Dm5uwokgQ-1; Thu, 18 Apr 2024 03:10:49 -0400
X-MC-Unique: 8Ihyb9zdMiap-Dm5uwokgQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343c6a990dbso208807f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 00:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713424248; x=1714029048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXuNqL/ceExdhMKWNZ4A4O9zeEkuVX94IXCtvFH2AcM=;
        b=HZNcKLkFNvngNXtaYwMf/JWwtoqNLkrG6fYA86uGGxODC/WnYBEUy0oVurb2pUrP3Y
         N/qJzP3MDHNtKkb51TQSNV+w0/Ohmo5SSXaO27Kb3gaQkNVJ84+5gNUd7PoDYOVxyJP+
         tMUa61yMacBY8CcKd+UIJmWJmds+0ruDUHQmGIEMx4nPN9GoOc8CjKii5BuLzQY6oFjA
         U9zEar4qSOi8vQSHUMPuZt65HT215brQr66K5xVS0NjHRD2UZhFeEWmdJ5NlCOC5aD6o
         G/7i8AhcwMbuG0I1r3MUWRkkHYKqMxRpw3JD895uUrZs41vLCjIvEK9PEy8QbHwCEyMU
         H1rg==
X-Forwarded-Encrypted: i=1; AJvYcCWz4VHlV4mJ73jeAx3mwsh3SNhg0HHluyUT1Z7IUN+Zv7vRqCM7O+VCE/BtwsCa80UuGUr6qCf5YR2i0MBfRXW/YYcA7ALQXAkVCwETgNuA90aPX5x9b1jl9Q==
X-Gm-Message-State: AOJu0YzFt6+r3MWrLSs16ryShBobE71tNN6Kq+9WTOYhkiiIi4hacUSR
	pmTHbsVsTDQOj880FHP1ZbP/9Mky44ole1HP3mUXR0H6M7vc+HFq/V/uvQsAiWWSRKaieV+uqDl
	OsaUA82YhUcFlD3t79kIxOkiBYQtf4pQL91f0xMT4KUkL6zQQwZCwXNjLid88bXQ7/E0Iar2q3Z
	l23Pc=
X-Received: by 2002:a5d:4a8e:0:b0:343:ce15:fd3f with SMTP id o14-20020a5d4a8e000000b00343ce15fd3fmr1130775wrq.29.1713424248076;
        Thu, 18 Apr 2024 00:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNwMqV/DfHKY5Um1gJPK0oQBCHB+7oNlU62eSSvEH7W4fEUcxAc7EoBYl9IV/23pEY3150bg==
X-Received: by 2002:a5d:4a8e:0:b0:343:ce15:fd3f with SMTP id o14-20020a5d4a8e000000b00343ce15fd3fmr1130739wrq.29.1713424247522;
        Thu, 18 Apr 2024 00:10:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1fc:1e9b:54cd:34ea:3dbb:5a75])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b0041624ddff48sm5320517wmb.28.2024.04.18.00.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:10:47 -0700 (PDT)
Date: Thu, 18 Apr 2024 03:10:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, oleg@redhat.com,
	ebiederm@xmission.com, virtualization@lists.linux-foundation.org,
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
Message-ID: <20240418030931-mutt-send-email-mst@kernel.org>
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEszFm3LZ4Xf41nnPHrsk4xzUPW-7HZf0xAgoxW9D2Sm-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEszFm3LZ4Xf41nnPHrsk4xzUPW-7HZf0xAgoxW9D2Sm-Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 09, 2024 at 12:16:36PM +0800, Jason Wang wrote:
> On Sat, Mar 16, 2024 at 8:47 AM Mike Christie
> <michael.christie@oracle.com> wrote:
> >
> > The following patches were made over Linus's tree and also apply over
> > mst's vhost branch. The patches add the ability for vhost_tasks to
> > handle SIGKILL by flushing queued works, stop new works from being
> > queued, and prepare the task for an early exit.
> >
> > This removes the need for the signal/coredump hacks added in:
> >
> > Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> >
> > when the vhost_task patches were initially merged and fix the issue
> > in this thread:
> >
> > https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
> >
> > Long Background:
> >
> > The original vhost worker code didn't support any signals. If the
> > userspace application that owned the worker got a SIGKILL, the app/
> > process would exit dropping all references to the device and then the
> > file operation's release function would be called. From there we would
> > wait on running IO then cleanup the device's memory.
> >
> > When we switched to vhost_tasks being a thread in the owner's process we
> > added some hacks to the signal/coredump code so we could continue to
> > wait on running IO and process it from the vhost_task. The idea was that
> > we would eventually remove the hacks. We recently hit this bug:
> >
> > https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
> >
> > It turns out only vhost-scsi had an issue where it would send a command
> > to the block/LIO layer, wait for a response and then process in the vhost
> > task.
> 
> Vhost-net TX zerocopy code did the same:
> 
> It sends zerocopy packets to the under layer and waits for the
> underlayer. When the DMA is completed, vhost_zerocopy_callback will be
> called to schedule vq work for used ring updating.

Yea. It's still experimental though so I'm not sure how
stressed to be about it. I guess we can ignore it for now -
but yes it was one of the big issues with tx zerocopy
and this patchset opens the path to productizing it.

> > So patches 1-5 prepares vhost-scsi to handle when the vhost_task
> > is killed while we still have commands outstanding. The next patches then
> > prepare and convert the vhost and vhost_task layers to handle SIGKILL
> > by flushing running works, marking the vhost_task as dead so there's
> > no future uses, then exiting.
> 
> Thanks
> 
> >
> >
> >

