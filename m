Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B721DF243
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134453; cv=none; b=fXr1up3KTfdHwVjvA7H5ujw6BBsa1/U0qpA4MX70/GqDWUE6LFb5e5Sk5O2nXOm7KhzwytA6LwNhnBixEpNsskX6SqTSrFr4oT9dC3G7clDXouHFjYuZuy9OR1Xkgk4rAgWOCUbS6GJ2qTaoSKkVRmaDbXlV1beF+k7rjcrm/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134453; c=relaxed/simple;
	bh=045AGb8JuNqOjsQOzN8aZyC+lESpHF0mytQYlaut7Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7GaUxUxCAh2MMcsvFRUdiQoyQpoA0jqZVpoq6PPVLfdVMPfYLGnSmtK5yUI8xnMwgIrqog4QxGF71Uv5KcMW3nNdpmJvKSHiUKUzO3BYp7NLVd7EasGLbImqiL/IXP9LFcICrgo7NL+U/ukyDFLyT7yNULPoBkBUCbgL+0SvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpfpRXM+; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpfpRXM+"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D75BA40282
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 16:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8uR-OoU1yJaE for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Oct 2024 16:54:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ED6C9403D7
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED6C9403D7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fpfpRXM+
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED6C9403D7
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730134448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccBdl674U7Jv+vtXlnAHZ7z0c85T85M1xUuXFrqnPmQ=;
	b=fpfpRXM+L3em8RweMRy1xrv0ejMc3qb8qK8bL5ecXSLckx+PNNPVYnH4jDKkWOuLmmpuFf
	40Slrr/nZSlc7gyif/pTw+csFm22OpPy8aXUwGxt2CMoGXKGEAF3HVFgKV3b2gXlz6jRA1
	Guhq461V0REjllSI4TqR1iFbONYfJFE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-x14E3E89MESmJlXTbtYlCA-1; Mon, 28 Oct 2024 12:54:07 -0400
X-MC-Unique: x14E3E89MESmJlXTbtYlCA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a39c1b88abso6971795ab.1
        for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 09:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730134446; x=1730739246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccBdl674U7Jv+vtXlnAHZ7z0c85T85M1xUuXFrqnPmQ=;
        b=vzEgpWV5gu5Ooij056j+XhpuFI5xHoJDucUBv1YvoB8AvqidiY8MwJt8ngo8wbutjj
         hwYf2mR39OcjRvxoy6sb1rqCOiFHfHcwhCHO57MZtRmXotLvnGc7ZK74nAtBj7/X5Jjx
         G2VlYa2PSZezNs/kS5pmuYK2B6prbGgRhuobyk1qvWZL5X+u5veW1gQhHCf3XDnNqg8H
         3h/dUbx5yYe/WvP14XWKYAtEYTHa8/ki37W50JbMGxJMQzYbnrSlXNlCK9j1t+sAfFBB
         sIkpoBUfjzQx8VlMGWFqgPblzxhAdSY1LCIPxpFjpAElAUapf3f76xN4u73mLXIPLYMm
         il4g==
X-Forwarded-Encrypted: i=1; AJvYcCWGWSf0LGB2oKN71e3j6lH0vkTaZhlv8dI5g7HCCSDvs0A1jalfFg8KDeAEQzv72rpjLN3iq2pghjq9gwR+zQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxv3ujF4SmHpBvhZ7vBMw5v8UrSWUD3YSrC3cPTToLcSydDWMpH
	N7OHMKo52YiRwOMCAcqGp07hImOufEvPvLuqx1nb/sOMAPcC7eEAuPLHZHM4ScxUI5kv8OwqPWx
	Cu2qDFla7Xg2EJ8kW1bU13P1kU9YTN2uWqxumYQSRRfLOwrXXOSMQq0ECHbiUTroAiXx9okCR4r
	I3nOE=
X-Received: by 2002:a05:6e02:1caf:b0:3a0:4bd3:6cd with SMTP id e9e14a558f8ab-3a4ed1ba8e2mr23283685ab.0.1730134446400;
        Mon, 28 Oct 2024 09:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGZCi7fJ/OejaB2WuuWKlBM5pd//oi671GvJLr0HBWjjOLQbzaoYpAgGbyvQmX+EVgQIK5/Q==
X-Received: by 2002:a05:6e02:1caf:b0:3a0:4bd3:6cd with SMTP id e9e14a558f8ab-3a4ed1ba8e2mr23283495ab.0.1730134446003;
        Mon, 28 Oct 2024 09:54:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc72751e90sm1783197173.96.2024.10.28.09.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:54:05 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:54:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 parav@nvidia.com, feliu@nvidia.com, kevin.tian@intel.com,
 joao.m.martins@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH vfio 0/7] Enhances the vfio-virtio driver to support
 live migration
Message-ID: <20241028105404.4858dcc2.alex.williamson@redhat.com>
In-Reply-To: <20241028162354.GS6956@nvidia.com>
References: <20241027100751.219214-1-yishaih@nvidia.com>
	<20241028101348.37727579.alex.williamson@redhat.com>
	<20241028162354.GS6956@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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

On Mon, 28 Oct 2024 13:23:54 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Oct 28, 2024 at 10:13:48AM -0600, Alex Williamson wrote:
> 
> > If the virtio spec doesn't support partial contexts, what makes it
> > beneficial here?    
> 
> It stil lets the receiver 'warm up', like allocating memory and
> approximately sizing things.
> 
> > If it is beneficial, why is it beneficial to send initial data more than
> > once?    
> 
> I guess because it is allowed to change and the benefit is highest
> when the pre copy data closely matches the final data..

It would be useful to see actual data here.  For instance, what is the
latency advantage to allocating anything in the warm-up and what's the
probability that allocation is simply refreshed versus starting over?

Re-sending the initial data up to some arbitrary cap sounds more like
we're making a policy decision in the driver to consume more migration
bandwidth for some unknown latency trade-off at stop-copy.  I wonder if
that advantage disappears if the pre-copy data is at all stale relative
to the current device state.  Thanks,

Alex

