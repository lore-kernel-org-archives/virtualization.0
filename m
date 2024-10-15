Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C21D14FF
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987576; cv=none; b=qrqPAC+RfLhUPNQx4DcPoCdkRhLdW+QLFXXojgFUUfAvHJB94f3NhlfLrQJIEVpY/mVsZbyeoLckCXajCplZ7GSl/CRrgXMcZOvz9Mx7qoOECVoyRNg6QT4yUVvlputkdo+CaPxOyWWlzQaAxeOh2rCsDDWGwvI6igi/6xS+yA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987576; c=relaxed/simple;
	bh=UtNejxWTGys9rDt1pROLsuGxzh/JYXHbYWC1bkRqFBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kNiMuTwD6MrK5HB1ix+Ex45zqSXFTA538Bt0hfCeKuRUOM8C8wAzWHhkJjSbJZwrXkmivOTpmjtzpxi5p48/9HenGTENQ76OuLBeU6vFOc/61m7z21CXqRYUGfYkXFd0a/Txwr4B+GwitIaS2/1fZiF42PUxP+4Sz06s4FEe7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RL1iabjE; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL1iabjE"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E7D34042D
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 10:19:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7C7yohaAWO5y for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 10:19:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7D5B440147
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D5B440147
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RL1iabjE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7D5B440147
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728987571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yL03YOPM9cVhg3T+Qftkg8/CQZZbBVIoxOh8LNZ0CNY=;
	b=RL1iabjEWGsviJh/lgJeoOeS14UYFfl4t3zPM7yHqF7jRcVMbpnFldn0rc4y/zFL3wiuA9
	S6+tkNjlUH3iVsdIy16E6McSa7dtCG60Ebz2PSaJ0FZEJYEs+oYf/E9vfVt13tXradEoQL
	91o4ttZQ9lmTnskmC4h51THB36VSP9w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-S4VJjMlvM02nInezqliE0g-1; Tue, 15 Oct 2024 06:19:29 -0400
X-MC-Unique: S4VJjMlvM02nInezqliE0g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99cb787d2cso226336766b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 03:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728987568; x=1729592368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL03YOPM9cVhg3T+Qftkg8/CQZZbBVIoxOh8LNZ0CNY=;
        b=IE79z/JbN/pCPgv8eG/+dK+7oWzqYQqY+rIHGBMnDIPcUExIyXEpwG4tqYB/VonYqU
         4hnF8kPXwyw4Fo+2urtCbvHUqANiaj4wcCJivl0CjT15shLI00Nj4UZu2gn+f+mtBYag
         ZqPP5I2Twf0d3xf2oU3iPmhpqg6N3oyIgUxSiJ9lK5wCfp80Lm+jndL8aqZ6yNEKs+Lx
         jAQ2tDiLVWBOHqqqFqwVzuQGtegj3ASPvp/eC3ma33lgZqF7W0vZBVCFPAUhM2ZM+IAl
         wLBt6ZhKaTLpvpQNsOfDU+5n8o0AP4K+QqZFVMUxOefe3GhBR3S7VrJswDFCg4Fuxi90
         uW5g==
X-Forwarded-Encrypted: i=1; AJvYcCXRrusZ10cRCs4cXPspk5P33zc7bM9OOAT1oIVonIKnhe/AtxM6O78Bot7+cxYfFyMI8Y0MUKzi6R7q/JYrDQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyZufwwcWgRxx/DmEGDCG+h9EUHQ99KulJqpOsf3m3ECpA69jyM
	vkvMyt62ybacGhbRakhm8HrlNUEOGzaYeEFCHTZWgtsXy/fiqOcpn1gevl6T8ncJd6Rtb84rAGD
	SqgUrG+AOdxxKfzi30wsEeHXJpj9i9fEmDo1cheS4upTaA9CNppHybAT4hxxa1coDIDvSrPzeHf
	TrsvQ=
X-Received: by 2002:a17:907:3cb:b0:a9a:f82:7712 with SMTP id a640c23a62f3a-a9a0f8277a0mr373405966b.52.1728987568227;
        Tue, 15 Oct 2024 03:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCt73pi+kBQa8sFo8lywX0rXLgjhAffY6kTOniri1Q1voIZU61MMns3Q+EQxXd6h1IBekPBA==
X-Received: by 2002:a17:907:3cb:b0:a9a:f82:7712 with SMTP id a640c23a62f3a-a9a0f8277a0mr373404366b.52.1728987567756;
        Tue, 15 Oct 2024 03:19:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:171:1a30:7155:8c78:3ad8:e1c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298169a8sm53853266b.134.2024.10.15.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:19:27 -0700 (PDT)
Date: Tue, 15 Oct 2024 06:19:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
Message-ID: <20241015061702-mutt-send-email-mst@kernel.org>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-8-lulu@redhat.com>
 <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2024 at 03:56:33PM -0500, Mike Christie wrote:
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
> >  	struct eventfd_ctx *ctx;
> >  	u64 p;
> > -	long r;
> > +	long r = 0;
> >  	int i, fd;
> > +	bool inherit_owner;
> > +
> > +	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
> 
> Maybe instead of a modparam and this ioctl we just want a new ioctl:
> 
> /*
>  * This will setup the owner based on the calling thread instead of
>  * using kthread.
>  */
> #define VHOST_INHERIT_OWNER _IO(VHOST_VIRTIO, 0x83)

I feel this is not good because it is insecure -
process should not normally have a say in whether
namespaces work correctly.
So we want the system admin to be able to block the
old mode.

> It would initially be used by vhost-scsi when worker_per_virtqueue=true
> since that is a new use case and there will be no regressions.
> 
> For the other cases we default to VHOST_SET_OWNER. Other QEMU cases or
> tool XYZ can use the new ioctl when they are ready.

I do not like it that we switched default now we apparently will be
switching it back. Will break some userspace whatever we do.

-- 
MST

