Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9F187355
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972393; cv=none; b=VlU552BqP1ztyAWqdhIB9eu0S68RCzpY66TBWyfkGQYk4kAYOqisD8irluWHQvSijo5+mr365rcP97W7zxdlcoIs3ksaq3SPgA4eqieqjgG0g9iIQ5hTYbym9UbY1cT7P5GeSQqnjczCldh2NKPXAl2DeXGwJFnUNxt4kCS/HVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972393; c=relaxed/simple;
	bh=wQKOSCNaLV/LcMBMVuZv0A2kky3q7m8FVa6KFXCvPbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEP8O7elr7/KgMQKU2poipFejqhRGGG+MyC5OeP84NSbNa8XtlKXMcuqdCx2iHOjgDjJiPRKZ4pGlhaoo/zbCnED6zLlvJhIuZmqhfJO9jv42hI89jAAKFz1ODhYYIc+YSPzwouHBlAiC5xc9ZmSj5ovgeAokgh8CYA5qSF2cLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PahomjQu; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PahomjQu"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F49660866
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 06:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XcEjch_-Xmx4 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 06:06:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4170A60865
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4170A60865
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PahomjQu
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4170A60865
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 06:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728972388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tgZ0+UyvmPHPLy5zGIiiGdwLyCG+2QuBi7CujPJYYQ=;
	b=PahomjQuis38Y+f5gIbMKrm2AOhQ2oXgatAixjiQUFjfDShyhBZXt1J7YMqCzuM7aybR4U
	0pv8vDnhrJPRnRIB2klTldwc/xZ8Pft9xqeoOyJCt0zWy6ZB4owPHb3+uyF9/bvDANiG51
	vVsoHxU1l6RrmGVLsYIIClJRniDEe4s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ik1jEJjdPxaSoz4WX6bePQ-1; Tue, 15 Oct 2024 02:06:27 -0400
X-MC-Unique: ik1jEJjdPxaSoz4WX6bePQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a0c259715so142248066b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 23:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728972385; x=1729577185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tgZ0+UyvmPHPLy5zGIiiGdwLyCG+2QuBi7CujPJYYQ=;
        b=shCXzpYhHKP+hRis1xtFzL2R09+xUYBQ+I1+vQmY7vkK4WX0fyQlMfKtx2Y+dpWHTc
         0ZIXqPnPiTDs+EYELvYWBwOe/9fl+dflc89ROpRQZfSyUwUsbtUYWF6VmsSaPg5WE0tP
         o9qdchv1Z1+60yei067kvFKMCKb5fHoIt6hzXtbcOm2eMTqu4svhKNI2R0Dh/ufOdM3r
         /+phMsBQae2O9F2risXofWdQzfAtZAdQuqr4vOrt7ZPB+YYjQOD0Ki7ewj8P9pmEdSuY
         zxcp0RTN+ClnvtUeqw7IAmr/sQ12lrDqZd6F8h+PiHzl785/fEZ1iWgG/LrUVYi+jakl
         p4iw==
X-Forwarded-Encrypted: i=1; AJvYcCVCVdUyRs98/dN4a4es64mu9HVPEJN7RvejZEhO3a9EfDANHHxBebL0u2Fov+x3FUj3gjPUTDav3A9Yz+hAyA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw3nzhA0fWHa/Zz8NXWSbSeGeDhE1zXKgYmSwk9szC9fqndWAHv
	e/6OIPioVnN7Ca3gR9Tllkl/Xbq/5jA3SidAOxvaZL5IQerB4GOuwSFPyfEJAor4Rlkf0itZERN
	OvuEr2X/Zs0ZAhRc7MyPJu+q+fHIWx9ZKtGKIu/7s6Jh1+S/dDsLPUmmOouY/2nA+HO6b2Rywwg
	Jh6+tlyugqo4rSG+fTfJxRAJfe4gl855d0enqY7HVCgDbWf+Z4QWWMMA==
X-Received: by 2002:a17:906:7950:b0:a99:fe8c:5c6b with SMTP id a640c23a62f3a-a99fe8c889dmr675117966b.23.1728972385428;
        Mon, 14 Oct 2024 23:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjvvw7IStFnoxBVeCwZt8MlyalbexQktfbHHkmr3B3xG+RNKs3cQEUat2OoBHLmZKL1xiX4r+R0P/jma7aBqE=
X-Received: by 2002:a17:906:7950:b0:a99:fe8c:5c6b with SMTP id
 a640c23a62f3a-a99fe8c889dmr675115866b.23.1728972385129; Mon, 14 Oct 2024
 23:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-4-lulu@redhat.com>
 <acb5ea13-9695-4158-9152-aff761401be3@oracle.com>
In-Reply-To: <acb5ea13-9695-4158-9152-aff761401be3@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 14:05:47 +0800
Message-ID: <CACLfguVB0Xn2vsj6kJB9ONv1AhpcUteH9PEqDaPX-7JkxxqvKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function vhost_workers_free()
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 05:06, Mike Christie <michael.christie@oracle.com> wrote:
>
> On 10/3/24 8:58 PM, Cindy Lu wrote:
> > +static void vhost_workers_free(struct vhost_dev *dev)
> > +{
> > +     if (enforce_inherit_owner)
> > +             vhost_workers_free_task(dev);
> > +     else
> > +             vhost_workers_free_kthread(dev);
> > +}
>
> With patch 7, userspace could change enforce_inherit_owner after
> we created thread and we would call the wrong function above.
>
enforce_inherit_owner will only change before the owner was set.
the process is like set enforce_inherit_owner---->set owner->
thread/task creating
in in patch 7's code I have add the check for vhost's owner, if the
owner was set, the ioctl
to set enforce_inherit_owner will fail
Thanks
Cindy

