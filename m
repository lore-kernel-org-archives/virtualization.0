Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441F6FCB
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680830; cv=none; b=XowwF90V3esE5hWP2TO10YojekxCvywuoUtW2q8LVGMtbl2g5DeOAJec0DoVT18Jn5BW9wMZNjHzLDK2y555gAQmRJ2y2yIHBjclEH8V9CChjPmqZw8oO7z4h3po7soIFHU0/F0C1xy4o40ouWfKVTR74SGRIzsbZZu0+tHDtxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680830; c=relaxed/simple;
	bh=XdBNBJA2LmVj4DkB6So/8dUd5OMTx0ix8R0A8/fVwqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=luuqiJu4LbQB+uxKCxYhROD0noH/5sR9i4KH/dQKPqX+GA6QHb4xzskvXvmqf+1dFnOj80vpyNai0PGT+MNABKlYxp0BQ+DXT+9WSYEYJchLWifS0uMJRkar3WVq/7302iTc2pTlu1V1q8Q3pWScnot3buwfwtdQKzpy/9yfDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amtjyJGd; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amtjyJGd"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE8E340480
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 16:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 551rW35EocUX for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Apr 2024 16:40:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5D9BF4013B
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D9BF4013B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=amtjyJGd
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5D9BF4013B
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712680825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3cye+TStclceRpw3shWlXaPfSxDv17HoScKnAexvRw=;
	b=amtjyJGdLThYJ5JJBjlmSIlw/Q9CSUpE86vgeCQ3zab0+ntKc0h2+g8gy8Gnd+LoMnlqhN
	Vv6+wTNffcLpEzlYCBhJW9NE6klM/UfQ8x5pnlaf0fbFWfQEMlYyt+AgOslyWfofd3nRYI
	k3ArXzO3Wna79AxP8dyXavwN8vGphe4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-rvIIQLqYOv2W-24g2yF-VQ-1; Tue, 09 Apr 2024 12:40:24 -0400
X-MC-Unique: rvIIQLqYOv2W-24g2yF-VQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56c1b105949so4769870a12.3
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Apr 2024 09:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680823; x=1713285623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3cye+TStclceRpw3shWlXaPfSxDv17HoScKnAexvRw=;
        b=DISXoRpspX/fCGw1sqtsQDMgMnOJ/RsEubi2ASs1T8AeKC5yGkGY6auqbeqMKzCUv4
         HdT9TrnhfHpDS9XYQevoLLZv20OYIuoO9SHBNCnG1LpAess6VZ4iQ9ufANV4ThaAEz6m
         lL6mTi627wUntcM+ApPM9fZ4pCc8rqD4Iv21Mp7AkIICGlwxvGZNuPK/htRO206ReP9a
         fz6YN4Y86xvJMwDCuW594ESSZhEiz+vrM1x2uLrdQsOBeTYqbUe+Hzl7dOQLXCu1+Hyb
         yueUBGXZR+oHnqDOzW9U2TH7WPSIw6m4DRKtMFOw00QFh/CNQy4/tU5PdGsPXf1lflmt
         51wA==
X-Forwarded-Encrypted: i=1; AJvYcCXDd/GicJdT1wQsBmj7hKzzmh1MlBfZGo96irtqb/VV4nKOgHFwZns0HeWdH8nr7AKIOlMmHWxQgBK+0v0DtuX+JIfUZbZ+2KN82I2WuPMO0krywuSQ3ItZ6g==
X-Gm-Message-State: AOJu0YyckPhEKcmLbsTvSFbyD20rqCMMru8jBU/fWl0+vwsxHPkjw+d5
	K34gZvqQCJfENOSWspbkasTInnZDsEVg44O1bTWoOUwQoJrreTmtwFPfl+2dgqXSCppcU4W27Td
	vVzP0uqxVEZVo8bX0rusSWxJ/ciNX1lfx1BKYLTdoIFPfeoPn1NjiL+/XfYdkVZGj1Ikm8IFEEb
	1bujA=
X-Received: by 2002:a50:9ee9:0:b0:56e:418:5559 with SMTP id a96-20020a509ee9000000b0056e04185559mr64591edf.3.1712680822995;
        Tue, 09 Apr 2024 09:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCeuqumWr5bwDKg8xzNxMJ2P6UrB+9YO/H6n9/WMzD6UInJurqqyaJzOCIQLJoMMZBYWsMVA==
X-Received: by 2002:a50:9ee9:0:b0:56e:418:5559 with SMTP id a96-20020a509ee9000000b0056e04185559mr64571edf.3.1712680822397;
        Tue, 09 Apr 2024 09:40:22 -0700 (PDT)
Received: from redhat.com ([2.52.134.26])
        by smtp.gmail.com with ESMTPSA id ay22-20020a056402203600b0056e45917d09sm4126863edb.44.2024.04.09.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:40:21 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:40:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, oleg@redhat.com,
	ebiederm@xmission.com, virtualization@lists.linux-foundation.org,
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
Message-ID: <20240409110947-mutt-send-email-mst@kernel.org>
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEszFm3LZ4Xf41nnPHrsk4xzUPW-7HZf0xAgoxW9D2Sm-Q@mail.gmail.com>
 <7044bd8c-99a9-4da8-a5ab-c2c293cdea40@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7044bd8c-99a9-4da8-a5ab-c2c293cdea40@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2024 at 09:57:00AM -0500, Mike Christie wrote:
> On 4/8/24 11:16 PM, Jason Wang wrote:
> >> It turns out only vhost-scsi had an issue where it would send a command
> >> to the block/LIO layer, wait for a response and then process in the vhost
> >> task.
> > Vhost-net TX zerocopy code did the same:
> > 
> > It sends zerocopy packets to the under layer and waits for the
> > underlayer. When the DMA is completed, vhost_zerocopy_callback will be
> > called to schedule vq work for used ring updating.
> 
> I think it might be slightly different and vhost-net is ok.
> 
> Above I meant, vhost-scsi would do the equivalent of:
> 
> vhost_zerocopy_callback ->  vhost_net_ubuf_put
> 
> from vhost_task/thread.
> 
> For vhost-net then, if we get an early exit via a signal the patches will flush
> queued works and prevent new ones from being queued. vhost_net_release will run
> due to the process/thread exit code releasing it's refcounts on the device.
> 
> vhost_net_release will then do:
> 
> vhost_net_flush -> vhost_net_ubuf_put_and_wait
> 
> and wait for vhost_zerocopy_callback -> vhost_net_ubuf_put calls.
> 
> For vhost-scsi we would hang. We would do our equivalent of vhost_net_ubuf_put
> from the vhost task/thread. So, when our release function, vhost_scsi_release,
> is called we will also do a similar wait. However, because the task/thread is
> killed, we will hang there since the "put" will never be done.

If you can find a way to cancel them instead of flushing out,
I think it would be better for net, too.

-- 
MST

