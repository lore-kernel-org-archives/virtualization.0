Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B18189BB9
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973850; cv=none; b=Ov/h+9AMVdY3EHCTMDzpYzOpPoCq3sAzxJrqtlM3uUNjSVRncyNDdn9S9oLb0MvMeSbKJo3r3bcFb2RvJHatO2i2Kqt+E+N0ILMMMCIJEKcHtlkZ+iNtOOYWeg9E2ZQqmGE3iHAaszDFq0EiKXc65oRLywgafEB6aoy0GBJhySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973850; c=relaxed/simple;
	bh=iqlpTDPssRh6Y5WPFC5t5f0ps5krq1Lvxz7uGIT8PhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfrPajioBNMjMXB4vsdUfFIlXFxMO+4GCcgvW4nVmNsTop8OjFf2FN2G+J0MgKA4kAXyQmdWaCZTo6ef8AkHVrqQ6ZiXVgnfmqRnfchhlC2FQDcnO08s/v126UoNUf+EojIlFq7D3dDk+2MaJ87X5GiNkLAd+wS65axFZ428XgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqLD8sD6; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqLD8sD6"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 222D740388
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 06:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEjllzcDS5P6 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 06:30:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 45031401E4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45031401E4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqLD8sD6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45031401E4
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 06:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728973846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jk67ZnwvaT69MO8EEaBF6QRTqEmY3du7hpoOAZQd7w=;
	b=OqLD8sD6youaW5feD4TXcce7cZqPvhjIWocpGYsuavdCVjLiVZcndy8jRS6XsHH12n7DV3
	q9E8fTysZCvAZ/RQBSpVq/vMK5gYtNGPDhB2COJfQqkr5F7YwcF9LN2iLGwK94DJ+QBdBk
	mq3ucGI8QLmMJiIE+kHV6uq9JhVFSTQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-zwVqKG7qOcO3lBbYq-aWtQ-1; Tue, 15 Oct 2024 02:30:45 -0400
X-MC-Unique: zwVqKG7qOcO3lBbYq-aWtQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a93d0b27d37so428227066b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 23:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728973843; x=1729578643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jk67ZnwvaT69MO8EEaBF6QRTqEmY3du7hpoOAZQd7w=;
        b=Xik+my6AxhWf/P6rf8uEhGwNwSnAKm9HtPJUAg5FMXPzjIplptfm230+WP1Qd9ygeJ
         +UuEbtDLS+aJDkFt2Pvv9pfOHHmtlqAA2lLr8f0YPX3DNFpXZd+6P4XM8Ev/h3XF7jY/
         B/TZtC6qbJLxzk1R/KAc972/i0ImDG7MxbAJKwi1La3o8VAFjirLACfxNC95omcJ2Sms
         +JKBR8INW+ob7ETlhmENyx5Uz1X7qNLXe0OH2Av/Q1aU8z9jhprZrvT03Q4KAUYGO8Lp
         VEPHjIipdGByVFYD43sNomjCD99diEHqcqGpqKqjfpgGlzuSnM1GN+2ra/tJXUFfE3XN
         ih8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUD3RtXY+arzv7mMQlS9njyct4xRpF9MFLLd08huRoqLEIk1eKmFxjDQ22VgIoRnche5Sb5I2teIlrCMKpogg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxKOng6AhBbESF8AwYhiHrwBrzdHZfTn1cs5J+dGCf23/u9bx4J
	nGvclk5fNmI3RvQIcjzg5/nkw+Lj+BAnOMg6sGij/PSHYBMU7XFiGsOLP70CRU4lEu5k7JwwO8Z
	ufiQdnLzV+sTKLkXWEvtkxelwYXtsQE3EaYKHQY0PUej5euxYrr9YeEoZHgwG9TjArHwv7Nogoj
	s6n06A4jJbcE09C6V559WCmUJU1HDRD+Ocze2m1CDEh7T88fn8hOO3Rn37XDR1oSbo
X-Received: by 2002:a17:907:9288:b0:a9a:1585:dd6a with SMTP id a640c23a62f3a-a9a1585f6fcmr421157266b.36.1728973842907;
        Mon, 14 Oct 2024 23:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFFo6nEJ0i0crMHfbmLP0cYzCRHBgpqF2T2KbCZnHB1yGriJU9Zde0i+L/LSzxF6W7K8keK7004Y2J29YQRKw=
X-Received: by 2002:a17:907:9288:b0:a9a:1585:dd6a with SMTP id
 a640c23a62f3a-a9a1585f6fcmr421155366b.36.1728973842562; Mon, 14 Oct 2024
 23:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-7-lulu@redhat.com>
 <a317b7f1-b593-4cf0-a58a-8f375ad64f72@oracle.com>
In-Reply-To: <a317b7f1-b593-4cf0-a58a-8f375ad64f72@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 14:30:05 +0800
Message-ID: <CACLfguWkYC-60RsxtLjkMcML9WR0ix8ieZH0T8nEZKK_29kisw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vhost: Add kthread support in function vhost_worker_create
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 05:02, Mike Christie <michael.christie@oracle.com> wrote:
>
> On 10/3/24 8:58 PM, Cindy Lu wrote:
> > +static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> > +{
> > +     if (enforce_inherit_owner)
> > +             return vhost_worker_create_task(dev);
> > +     else
> > +             return vhost_worker_create_kthread(dev);
> > +}
>
> The reason we are in this whole mess is because for vhost-scsi
> we wanted to create multiple worker threads as the single thread
> became a bottleneck. We couldn't use kthreads because they were
> not accounted for under thread that created it and we could
> exceed the NPROC_LIMIT.
>
> So with the above code, we could hit that problem again if userspace
> did the VHOST_NEW_WORKER ioctl and enforce_inherit_owner=false.
>
> You would want a check for enforce_inherit_owner in vhost_worker_ioctl.
>
sure, will add this check
Thanks
cindy

