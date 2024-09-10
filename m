Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4917E00F
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954126; cv=none; b=KtbDGVez2QAMA25CIFZzlgKLmgWUwmPjbbwpZxcwhQJ/dqrfLmAAVOCvq5U5be3K27/Z3dk9Jqq2JXD1kkbDIbrHJfmsi4So8SswFVLL5nG4stC9hybmh4DV7ZUpZ5kAv76qyCySmzRoUaPTQF+dHk7dKE5sYdNocdRkBSAd0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954126; c=relaxed/simple;
	bh=868wQv69+C1rc2cl0jagbErfwedCUJFcxF801bTgrYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Rl5mee8rbgjgvdalgKyoyRZWsK8qeaHddpuz4x4GSTnPgRpd7K7l3ayFv8APq8fEEqf4mj+XGiJ8vqZWlMbF7adRufqHnWVqis5y80CFyjIW9iaK2Q4HiRGeGoQsSErKy5HeOhXv3nH/4IqYCZuiHf515wtbAaYRcL38voaZ4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YumLigCr; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YumLigCr"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFA0D40172
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 07:42:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEPDFyyn68n6 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Sep 2024 07:42:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E270040179
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E270040179
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YumLigCr
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E270040179
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 07:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725954122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YjmwAz5ahZsSyMH7sv/F6TU19phROj9JmvsK6FuhNcU=;
	b=YumLigCrdY9AJG5k5gasI6sHXmY9OFZ3C8ktGBYxV6WSw3aqWOaBlhzGOQR/fou5Zer6Nf
	EWNINJW1mtqQP+AAlZregwXllnhyHhQw/SLuNB3+Gw1LJQMRRCJBoNy8rlsso0UMNmpx6Q
	ob8qTY5pitnw7AZrcRjPVUo6eoYsdMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-M-Pd8TgWM7CKK80G-BNOzw-1; Tue, 10 Sep 2024 03:41:58 -0400
X-MC-Unique: M-Pd8TgWM7CKK80G-BNOzw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b9617ab0so2218785f8f.3
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 00:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954117; x=1726558917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjmwAz5ahZsSyMH7sv/F6TU19phROj9JmvsK6FuhNcU=;
        b=b7Lc7DDniCSr3syYzDo/lFvYNk3u7GrgnE3krkKJ40bntMomUG/FPOwgzk+kWqdKYi
         GaDfeakdgy4lutRvKPERFrOtOj6nKSMioZ7rXF9CvVuMimpbS3Hfmq6G0aa6t+GguMUX
         BOw+u1PsT0ybQLF6p4jKkloAJoqNWjiwPY7TqPcn4HxJ7qOjvBGOpwuiEyQ8ttF/3fQN
         TEMPp4fpuYZq2Og2Dl7Zg1v2FMrDTej4eZ9rgaHA17CxKsDEC8YL4lMrlLyymjEULjCj
         P2e34GH0RSJ7zlG3w/ggwClhAO6YBD8/mlf7Mab65MKOVjaN8VhqnfT9h8txBqWiW8nM
         hkIg==
X-Forwarded-Encrypted: i=1; AJvYcCXph2O8fCpua90+avrXRSokGcrjm5C3VGeBMp7Pu4TVf/AUWAdMTGI9zrzm11hUdTwdyHH/TVfDneNRY0pZqg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzeWSob7Ij63STPz/NHzHbBVTRlbD44Cq0+3T9fkErYJpIY0KIo
	orXoZEbI8Js6fTDdCd3OktGg9WeY+dFi711yzGjvWiqQOtnE+vIungaiWwLWEjqSAlZKL0V+Zu4
	oEKAsQFWgIFWpOEbXgZsoFuCAzjQY1w0VGZw88lvcYnB61Q0+2/eViLHM3jY09VaiKezMd5e7zl
	ipBk0=
X-Received: by 2002:adf:f687:0:b0:374:cb17:c62f with SMTP id ffacd0b85a97d-37892685e58mr6075126f8f.11.1725954117109;
        Tue, 10 Sep 2024 00:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjs08g7NP4XaP5B2YK7CxhhOiPcTLvIVgpASYWgufgd1/GjiAqX7+X6E9+SleKBdH7ZBVQNQ==
X-Received: by 2002:adf:f687:0:b0:374:cb17:c62f with SMTP id ffacd0b85a97d-37892685e58mr6075095f8f.11.1725954116265;
        Tue, 10 Sep 2024 00:41:56 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de02esm8080786f8f.109.2024.09.10.00.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:41:55 -0700 (PDT)
Date: Tue, 10 Sep 2024 03:41:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
Message-ID: <20240910032825-mutt-send-email-mst@kernel.org>
References: <20240909020138.1245873-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240909020138.1245873-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> vhost removed the support for the kthread API. However, there are
> still situations where there is a request to use kthread.
> In this PATCH, the support of kthread is added back. Additionally,
> a module_param is added to enforce which mode we are using, and
> a new UAPI is introduced to allow the userspace app to set the
> mode they want to use.
> 
> Tested the user application with QEMU.

Cindy, the APIs do not make sense, security does not make sense,
and you are not describing the issue and the fix.


The name should reflect what this does from userspace POV, not from
kernel API POV.  kthread and task mode is not something that any users
have any business even to consider.


To help you out, some ideas:

I think the issue is something like "vhost is now a child of the
owner thread. While this makes sense from containerization
POV, some old userspace is confused, as previously vhost not
and so was allowed to steal cpu resources from outside the container."

Now, what can be done? Given we already released a secure kernel,
I am not inclined to revert it back to be insecure by default.
But I'm fine with a modparam to allow userspace to get insecure
behaviour.


Now, a modparam is annoying in that it affects all userspace,
and people might be running a mix of old and new userspace.
So if we do that, we also want a flag that will get
safe behaviour even if unsafe one is allowed.


Is this clear enough, or do I need to elaborate more?

Thanks!

> Cindy Lu (7):
>   vhost: Add a new module_param for enable kthread
>   vhost: Add kthread support in function vhost_worker_queue()
>   vhost: Add kthread support in function vhost_workers_free()
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add kthread support in function vhost_worker_create
>   vhost: Add new UAPI to support change to task mode
> 
>  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++++--
>  drivers/vhost/vhost.h      |   1 +
>  include/uapi/linux/vhost.h |   2 +
>  3 files changed, 240 insertions(+), 9 deletions(-)
> 
> -- 
> 2.45.0

