Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616B4D8DA
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975161; cv=none; b=KLAddd8kfTMV/Dg5Dt2PDo1iGCCqO+WzrtdjOOvoEwdBWbB9Cc0iCB9OQdY8w7EDFrrNMTKmExId+J4WmueWgpnPPkC8m1oF2vedWJWCLHqeT3L+RjhMy9cOpayRkzT5vQbNLyQwKGauPlcKb+t4PWKYF6xnZgyP/TYbALnF2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975161; c=relaxed/simple;
	bh=IxKtbfbDWpfY+XrFnqwdLbGcdWrAl8fFCrbgJ+zlr4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iUtI+grSkSOiR8bMun+Ag5g6PstFpAcEE3p5LGDPPOptF2xAMApkrtuNUBUwFgMk7ruMkNaye7MpMH19FzGl7XHNNKv2DuXVrTws6Z+DARtz3FzHLZCtKJfVJlLjtjISgqZUdsF/1j6EJCsTUDVD80EMVR6Zr8WlzFiL7ty7+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzwtgVVO; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzwtgVVO"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 720A1405E8
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 06:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2swPld5X1Ens for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 06:52:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8B3AE40015
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B3AE40015
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SzwtgVVO
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8B3AE40015
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 06:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728975156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Us05G9Xv9FB2BCQGyCCUClyEftS92UVQm4omwqD/MU=;
	b=SzwtgVVOKIBqbiMcmv9BucE7ZVgjq+a1j6LDT3t3FBCfyuKSIwbf5sli4HZ3OR9/p4EILB
	ujTzN/wHlrHqSIlx0pcUg6FaZ0WxPI4u/Y/GPUHGQRFGjS3tY5Nq7ZQRxjlw1wRXd0mz8s
	Se0FGLefOi6ofaqA911K/D89yVPuufU=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-lFFKKQ9yMpe_jOjHslyQhA-1; Tue, 15 Oct 2024 02:52:35 -0400
X-MC-Unique: lFFKKQ9yMpe_jOjHslyQhA-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-50d5352c757so317498e0c.2
        for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 23:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975154; x=1729579954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Us05G9Xv9FB2BCQGyCCUClyEftS92UVQm4omwqD/MU=;
        b=S8XB37kNad8n7p9xwdtW3Z3+SU7nX4czhHvIgWh09W7lh5HG6N6vz1G7PH23QBAzj/
         mHTfpAHGOIT9wv8AIBkV44XubcZF2reWzS/sj6KEr+TRu3uZeOgxRThSXC6ZS9O3G5C2
         KGWUF8rix8Ds5znsjYolbDl6MhKILGUDh+hu7nfWbsoOdOiF+mdTgzLZwo8ON3RR/BO7
         cCQtGvYSWhpJSWTjmwA1C/o3/+5ltPEjjifVk67YHiJ5xytEWS4ldD60LMxXmlEb27iu
         RCGtI9KSJn2qJvIj3029r26rvmR3/xPvw1E1GD5TpiFjgr+cwbZVbKZ4OQrUIx/JFQMZ
         zORw==
X-Forwarded-Encrypted: i=1; AJvYcCXKiYqWI79kMd/4U4XoI4fzVGiw1t+Qb0iNdrxH+RgfI0sJ5eo1arJI1Yamhwec3jm1K+GDS+YervEysGenqw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywg7ueJN2iJhUJCKIzBN5K8X8KJceyHrXRN6YPZQcSWxeWXgFz9
	pPNdMFftVcXQB08rUdfzouNSdi0+prYVOEfAJqeSTG+Mb4iQLLWmK2z4ZCjSeteqWNMKD6VYNJB
	kI/bFVsi6cRnSoF6bFzAhKQ2eyJpAUsLBa9Q+JGFA+crUVbI6lsHZ1jz/omCUV5vssA88TZeh7V
	yPpIs=
X-Received: by 2002:a05:6122:181a:b0:50d:35d9:ad55 with SMTP id 71dfb90a1353d-50d35d9afafmr7906039e0c.13.1728975154660;
        Mon, 14 Oct 2024 23:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKE3sM82gE1lH2AbmVMOwgCoWkTjZKZlxe3981Acz9icXIZwSdhkC3L7BLm0xRKplh8L48RQ==
X-Received: by 2002:a05:6122:181a:b0:50d:35d9:ad55 with SMTP id 71dfb90a1353d-50d35d9afafmr7906028e0c.13.1728975154145;
        Mon, 14 Oct 2024 23:52:34 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290fa5bsm3300536d6.12.2024.10.14.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:52:33 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:52:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, jasowang@redhat.com, 
	mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function
 vhost_workers_free()
Message-ID: <lpwqg4j2nnh3xgg64vrlk635vcmu2bxrq37sapwp3yl2pdp5rz@lg3wgfop6rkx>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-4-lulu@redhat.com>
 <acb5ea13-9695-4158-9152-aff761401be3@oracle.com>
 <CACLfguVB0Xn2vsj6kJB9ONv1AhpcUteH9PEqDaPX-7JkxxqvKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACLfguVB0Xn2vsj6kJB9ONv1AhpcUteH9PEqDaPX-7JkxxqvKQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Oct 15, 2024 at 02:05:47PM +0800, Cindy Lu wrote:
>On Tue, 15 Oct 2024 at 05:06, Mike Christie <michael.christie@oracle.com> wrote:
>>
>> On 10/3/24 8:58 PM, Cindy Lu wrote:
>> > +static void vhost_workers_free(struct vhost_dev *dev)
>> > +{
>> > +     if (enforce_inherit_owner)
>> > +             vhost_workers_free_task(dev);
>> > +     else
>> > +             vhost_workers_free_kthread(dev);
>> > +}
>>
>> With patch 7, userspace could change enforce_inherit_owner after
>> we created thread and we would call the wrong function above.
>>
>enforce_inherit_owner will only change before the owner was set.

As I pointed out in patch 7, enforce_inherit_owner seems to be shared 
among all vhost devices, so what happens if for example a user sets it 
to /dev/vhost-net, while /dev/vhost-vsock is already initialized and 
therefore already has an owner?

Thanks,
Stefano

>the process is like set enforce_inherit_owner---->set owner->
>thread/task creating
>in in patch 7's code I have add the check for vhost's owner, if the
>owner was set, the ioctl
>to set enforce_inherit_owner will fail
>Thanks
>Cindy
>
>

