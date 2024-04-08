Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E47175B
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580655; cv=none; b=l8UqoSW4m1qWgZuDdnX4Bg0J07Lx7qcoNezFJ97qU7uXbDo66EKYgE2c71RFdMx/gj87DqKh+IsYvPZbrX9X0ih3Mp88Su5cDPGw1TfN+TU9rnGt/MC2SuDua48Bw5kk5NAd7tZZVy8i0z9sZhFvR+oUHuECmHlhfy+qZHq8vTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580655; c=relaxed/simple;
	bh=t6rY2U7J7pGdzJQQnj7Amc0EfelzVuwnd+M+I4FgGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T+5qD7U1dNXCVeVNg5KGQyLbEkhew6HgTjZbbZcz3nH5GQO7k7T9dKhtK8viU6eDlzVQ26klJZnfcEMtx9aCCH4mXJ9uytRc+lHYv2Z619ydPm18HPhNix+8MUHD4Q73aAf13izEdAARU3/3vGb08cPppFlW23/HG2j3TA2aing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+DC7l/N; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+DC7l/N"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99FB140739
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 12:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5TArNM_T3ywQ for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 12:50:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5C54B406EC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C54B406EC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R+DC7l/N
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C54B406EC
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712580650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgyAj+d0mXsaKlJNf1FRqd+kTl9TVEHoCjOdqUp78UU=;
	b=R+DC7l/NYZ1KfxScqgW79hT/wr9eUs1l+TEschtQLoqUb9y2Xr9o1R3KUCYqnxz7DjBcnw
	i38HpBqXzA3sp5DjvLvQtpWzd27maNGAf6dlJ8R74y3cg1vhbXYdrobQz6O9QIxIrEF3UM
	kEwKDHIfBFnm1YwNSqsbF08fA+ca/34=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-aTddPVjgOdGUZQDFccO8WA-1; Mon, 08 Apr 2024 08:50:49 -0400
X-MC-Unique: aTddPVjgOdGUZQDFccO8WA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d87f6e0fd7so14355161fa.3
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 05:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580648; x=1713185448;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgyAj+d0mXsaKlJNf1FRqd+kTl9TVEHoCjOdqUp78UU=;
        b=d3VuFuTJbG7KleNCtd+CW7AaJ9CqWY3ZXA2uCCNg+Mlv3qjk9sDiT2XDIdfDL40TYp
         Uho90Zc8bs8Gg3pXbyGyQLYfFfC/Bw1EzX3JkJjf7BwlCpkkiXrokXc5/JJ+9a/jqNa8
         Eo8DYMKX2H+l0X+Wmmya1UhjYjG8lUTMd6CBE3SukIsZNsUEjH/UJo2MhkteDk7sNgBG
         4prSMHn/Nq6VbHvTMr5aGc6HeRBDn3bbYdkOA4Kr6NETjQjORmW3KVn+IPBFHRyHoOlX
         z9ltnK58rfIYXZt/C3mQlVhJc5NUcvkASL1H/1/2uAAuDzJ2/QF20HHA/AtPATO9JuxB
         C9tA==
X-Forwarded-Encrypted: i=1; AJvYcCXvxCbbunHxcEyCPlN6Dtctv3GnKgS36o7AvgQBhIm1ayr1KYMHQ1efs524Wnr93T+Fm30qIJoT77zs3gU4LhQWjURBKMleoiM6jD8z0LqNyp/eyTfs5323xQ==
X-Gm-Message-State: AOJu0YxyS5IwPWIXADYjEB0j8XMIcxXGr2hnJrd+a9Xqh95zPLSq+LVG
	ggqO6XGMVR5U4lDeSzpO9CUoNFd0/8uxXqZvQ0sOD5AB3ISYH3vpYn6nTb6pw9N6v/GjQZt0DGg
	Lf54hX2PR/YDTwL1x4YNzjuRpoZj3GMalyfuvIU7YAvXsJjMsqKKvxUI6HGI49MWKX4hycBDCug
	n97A4=
X-Received: by 2002:a2e:b0ca:0:b0:2d8:6fc4:d0b5 with SMTP id g10-20020a2eb0ca000000b002d86fc4d0b5mr6644113ljl.8.1712580647635;
        Mon, 08 Apr 2024 05:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlvCW0RSMUg3H9tBOc1SwabjdiTPzS2Fm8vr4WbbbbyDGcjVCN/zOPqhNUznAU5UGSgB/nQg==
X-Received: by 2002:a2e:b0ca:0:b0:2d8:6fc4:d0b5 with SMTP id g10-20020a2eb0ca000000b002d86fc4d0b5mr6644089ljl.8.1712580647022;
        Mon, 08 Apr 2024 05:50:47 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id oz31-20020a170906cd1f00b00a4e8e080869sm4432937ejb.176.2024.04.08.05.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:50:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 08:50:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Add reconnect process for VDUSE
Message-ID: <20240408085008-mutt-send-email-mst@kernel.org>
References: <20240404055635.316259-1-lulu@redhat.com>
 <20240408033804-mutt-send-email-mst@kernel.org>
 <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Apr 08, 2024 at 08:39:21PM +0800, Cindy Lu wrote:
> On Mon, Apr 8, 2024 at 3:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 04, 2024 at 01:56:31PM +0800, Cindy Lu wrote:
> > > Add a document explaining the reconnect process, including what the
> > > Userspace App needs to do and how it works with the kernel.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >
> > > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> > > index bdb880e01132..7faa83462e78 100644
> > > --- a/Documentation/userspace-api/vduse.rst
> > > +++ b/Documentation/userspace-api/vduse.rst
> > > @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
> > >     after the used ring is filled.
> > >
> > >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > > +
> > > +HOW VDUSE devices reconnection works
> > > +------------------------------------
> > > +1. What is reconnection?
> > > +
> > > +   When the userspace application loads, it should establish a connection
> > > +   to the vduse kernel device. Sometimes,the userspace application exists,
> > > +   and we want to support its restart and connect to the kernel device again
> > > +
> > > +2. How can I support reconnection in a userspace application?
> > > +
> > > +2.1 During initialization, the userspace application should first verify the
> > > +    existence of the device "/dev/vduse/vduse_name".
> > > +    If it doesn't exist, it means this is the first-time for connection. goto step 2.2
> > > +    If it exists, it means this is a reconnection, and we should goto step 2.3
> > > +
> > > +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > > +    /dev/vduse/control.
> > > +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
> > > +    the reconnect information. The total memory size is PAGE_SIZE*vq_mumber.
> >
> > Confused. Where is that allocation, in code?
> >
> > Thanks!
> >
> this should allocated in function vduse_create_dev(),

I mean, it's not allocated there ATM right? This is just doc patch
to become part of a larger patchset?

> I will rewrite
> this part  to make it more clearer
> will send a new version soon
> Thanks
> cindy
> 
> > > +2.3 Check if the information is suitable for reconnect
> > > +    If this is reconnection :
> > > +    Before attempting to reconnect, The userspace application needs to use the
> > > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEATURES...)
> > > +    to get the information from kernel.
> > > +    Please review the information and confirm if it is suitable to reconnect.
> > > +
> > > +2.4 Userspace application needs to mmap the memory to userspace
> > > +    The userspace application requires mapping one page for every vq. These pages
> > > +    should be used to save vq-related information during system running. Additionally,
> > > +    the application must define its own structure to store information for reconnection.
> > > +
> > > +2.5 Completed the initialization and running the application.
> > > +    While the application is running, it is important to store relevant information
> > > +    about reconnections in mapped pages. When calling the ioctl VDUSE_VQ_GET_INFO to
> > > +    get vq information, it's necessary to check whether it's a reconnection. If it is
> > > +    a reconnection, the vq-related information must be get from the mapped pages.
> > > +
> > > +2.6 When the Userspace application exits, it is necessary to unmap all the
> > > +    pages for reconnection
> > > --
> > > 2.43.0
> >

