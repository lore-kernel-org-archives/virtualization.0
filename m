Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092916C451
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728959795; cv=none; b=p4QKzliq/XPBII2qlxTpmh+svopfKN6O7Em7JZCu3zDx3VaxF9/tzBXMtlEB9DCZBCcfINozxuEX1Os24J8qdNJ2f4CViQvN6qYwgpar7BYKqM6lRB1Jr2lQDjA6OmRyHSrvC5PDsr4RMz26tiJ9fQvIeqz5PWkXXQylvuQ5WHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728959795; c=relaxed/simple;
	bh=ZyfwRkmYYo9902jpV4Xf4OPH2JQu291dWhcwEhB7NEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvcBPsreKEKnpaKY8xydMJxecG+Lxk/pvbuCEW84lJMAeqT0H9S+fJ5XSjwJiElKlR002FyxelTCxh8jNDT0gaTmK+tOo8c2WutHGQK/9Zk98WIZbISfTryHhERjlcicG0M9Ch+vYrOaK0Jxnnm//8R+78EOzzlCL7bYtA4IQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLpuAbmT; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLpuAbmT"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3AD0404AA
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 02:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omepQU7Du1jx for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 02:36:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5DBB4403F1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DBB4403F1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLpuAbmT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5DBB4403F1
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 02:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728959789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RepCkNLxrfOjiYjrBfat8VzhDr4hw0yzZI+H/gu/KcU=;
	b=RLpuAbmTsEAv7Mh9L32P/rFxh9s5MglD5LAtejbRlPzeoJHEf85ifJ/a/euWeFk5++wea5
	Aj54oPILuAMvGr4s9Lj4Qt2vlTvwVeuqT9Z43Tnglr1Q06qMEYG9TCL4uNKMZ8B7NOoLEw
	qO7QDW6J9kR8rCbO4lD+QM+zeLw8ZWs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-IenFiUS6PbyI7RsLtEMUFw-1; Mon, 14 Oct 2024 22:36:28 -0400
X-MC-Unique: IenFiUS6PbyI7RsLtEMUFw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a157d028aso107855666b.2
        for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 19:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728959787; x=1729564587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RepCkNLxrfOjiYjrBfat8VzhDr4hw0yzZI+H/gu/KcU=;
        b=LIQwGxhYgBrx4RRltgaabhcJgzVzA/POC07Ohh6XCxE+ohGoeTRbrwf4SspQscJkZz
         RiIts8QWTUurrxEHm3/53qijH7EzlsSPVDORPZjOpq8hMPBM8jCtD3Z31yyDIqTnc1tE
         t52KsdOF0eD4aSs4QF4vsGOtQkHdKGkPfnl7pf1EfCQL/0fhARe/9DV5GzrgC7hmrkeQ
         6WeKKJKkeQXZixK4pG3OgWq6PZoqYsTHz+F4eiJB7Z59U3e7B2p4uIOOgJ9CC5Q+fODX
         QOBL0uXmRixBlDQVH7zK0ZeLYNiQQUq7MxxQN75ExpMyNRpYpCG5GwHRKLIPcYb2xrDS
         gRRg==
X-Forwarded-Encrypted: i=1; AJvYcCWy1bcIit2e/oAW8UAwtMmF/6L87oQ9y4VWozpv4sKeeWM3ybgO+2capxyn78i9S/1uCt1y67Vm+AEwLbErmA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzsFg0kl6RMLkM3Kyh+MZB9x0bhjRtkwDJhjx6CpjJWqKeUuAMS
	AcVWFMVL6lMkWnAcUJK0oeYBoUqAdlGWv/KK8axjk4EHbu2SyAKPqn5pWIcC4lDUtZEzozMpahk
	JFBUGZeBmpPUZz+F17TAJhmZkWKDsUbnm1ZTYpa0PREWb81m/gFHxs2VsAbuVZOOVVDwf6scgiI
	WAL4roCBZinPZXaj4T8RV7ng8lkaL2VixjjNkumioXCiLI92jozPlw3g==
X-Received: by 2002:a17:907:9452:b0:a99:379b:6b2c with SMTP id a640c23a62f3a-a99e3e3f8f9mr877404166b.42.1728959786825;
        Mon, 14 Oct 2024 19:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3XUGqLtf9WJVjnzTsPPwGijvC7KeImWI4dUv0/+mGZC7jS/6KZV4iT1QqrnGvBrVPKfLNnYQZSrHnSrEUZEA=
X-Received: by 2002:a17:907:9452:b0:a99:379b:6b2c with SMTP id
 a640c23a62f3a-a99e3e3f8f9mr877402866b.42.1728959786432; Mon, 14 Oct 2024
 19:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-8-lulu@redhat.com>
 <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com>
In-Reply-To: <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 10:35:49 +0800
Message-ID: <CACLfguXbMFZbGN+U1couZaJC7Sh3Qpg903W-DmFJjUtyECwT9Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 04:56, Mike Christie <michael.christie@oracle.com> wrote:
>
> On 10/3/24 8:58 PM, Cindy Lu wrote:
> > Add a new UAPI to support setting the vhost device to
> > use task mode. The user space application needs to use
> > VHOST_SET_INHERIT_FROM_OWNER to set the mode.
> > This setting must be set before VHOST_SET_OWNER is set.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 18 +++++++++++++++++-
> >  include/uapi/linux/vhost.h |  2 ++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 08c9e77916ca..0e5c81026acd 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >  {
> >       struct eventfd_ctx *ctx;
> >       u64 p;
> > -     long r;
> > +     long r = 0;
> >       int i, fd;
> > +     bool inherit_owner;
> > +
> > +     if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
>
> Maybe instead of a modparam and this ioctl we just want a new ioctl:
>
> /*
>  * This will setup the owner based on the calling thread instead of
>  * using kthread.
>  */
> #define VHOST_INHERIT_OWNER _IO(VHOST_VIRTIO, 0x83)
>
> It would initially be used by vhost-scsi when worker_per_virtqueue=true
> since that is a new use case and there will be no regressions.
>
> For the other cases we default to VHOST_SET_OWNER. Other QEMU cases or
> tool XYZ can use the new ioctl when they are ready.
>
If I understand correctly, this means the default vhost function is
using kthread?
Thanks
Cindy

