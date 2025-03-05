Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC50204698
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166602; cv=none; b=b0koWBEStU1Ssn/f8/YgCKV7lvX07b1+8JFr75Yi2W2U4GJ4O11d1q1XBjW5ozh2xYXm4kkbRdgQtVgJukVwhYRdXBW/yUYku6oVhKwKFJRbAGO6n5N1UIzkbJxdBcel0bnd1c4IxbyHXi98QSYFu7joe8VZHGv6dQmCT2yGOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166602; c=relaxed/simple;
	bh=+QfPm6bqrG0OcdOxhTC1BYzGGpBGfOp64hZJsZUGa8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UKT3h6DW4NbD6GI339egTgKjSDeGHWDdqHD1Lphw3bhevpetaDkacQWmV7TmePahA9/xUUbBELupNzJDgCm8QzrpQQNMhMIouprsYj8zWvJnLnP6BYyzJb9vp9uMf1OL4tuvSSwQH6I1PTwewzDh275QZ9j4o5rmI7fRZyfZA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6hwbWbJ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6hwbWbJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCC3083AFD
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:23:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id us4wHu5BFce6 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 09:23:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D1B2083AF7
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1B2083AF7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H6hwbWbJ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D1B2083AF7
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741166597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Fz/47DT/bcZQibct8BTl8FGEvkFXwI/p/JU2LZO+88=;
	b=H6hwbWbJvRc76HNKQr1ncFfLpM5roA6dEbbpRKWURLBSpKbzmqw3SLtXU96DX24QKcZ/UI
	S6I2+iyPatIuPtlA6XD1T3bcVeEP7BV3P667UPleGxaqk1M9HXAbti1hR2jDEhlKvhKHGh
	IMZ0jQ1GJbQb7399rZmvqvxFdX1t6R8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-JMn3FVtJMLKc0i-c5twyCg-1; Wed, 05 Mar 2025 04:23:16 -0500
X-MC-Unique: JMn3FVtJMLKc0i-c5twyCg-1
X-Mimecast-MFC-AGG-ID: JMn3FVtJMLKc0i-c5twyCg_1741166595
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e4987b2107so7183646a12.0
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 01:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741166595; x=1741771395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fz/47DT/bcZQibct8BTl8FGEvkFXwI/p/JU2LZO+88=;
        b=DMdK554IQJ9MQo+yuAXq5uuH4ocgMoeNrNTC7L4AtJp3SOYf4Gp7lIYUQdKdejZ1vm
         TKCABLSCkJCa+Is59yjpyQkvaaYdmm48hShSe/PjNXraSPJiWxd8vdypThnZAdYDDnYs
         T/mz43Gdtp7NoZ9+CsIyWOnF764Kbx91VBs/cNdheM8RPynbT9hogDrkhwustB7mih82
         7emJWrrnCdTwTCHGeWyFFQ5SCwG7No4sLZAxjjzBRNbCe2mCrQaevh3B97IQNrMUXFTl
         rLsgqv9Im2+glVx/O2r4/JcsnXBHbBH01PFkNGEJBhUl8fnV8uvP3ZmZXx2dLscUQ4m4
         Fqkw==
X-Forwarded-Encrypted: i=1; AJvYcCVmaRxBX46yfImkoy/tQ18mYa03qFX68aXMZU897tVX7P4IXp5ZafqXqkroT7iPsKnQSYBJgUYYcELRCpqr1A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyiBd9V60U18NYmPCmk7Hv8AM4Jfzfo6kBNiG5HP0A5QA1YJCz7
	z8Mnr5i8HTuE0WW3bhGxDA8DfJgRAbo6UtyefBUdJeTc6Xce/MM9wy5mrSqHX+U6r2WDO/tyqlN
	x/M/eIJ9IlO68bCigftRBP9sRWU+OVL5LwD9lcZ5JdjUAZjrvSbQskwtQL2pArJdWPNLFbXjTP6
	idepo=
X-Gm-Gg: ASbGncuzGHa1im0pmuMXrCg05r8SNH76SfS3N9ZlnJ90rTXgPlE1X4lXg8z/X9cKwae
	1ydThUQWcoKFJ7yP0V+dE76tk2cjTIaEWsdFn51y9n9ve4s06oiRn57p+8EX9wOM7P8oW6EJ+XE
	/ObCuv49AVBXJiyjNurn7x3Q8vSS2iptJoQaqHwzeVwEvfjbztqyusaQHXYNtBZ6UODLAOzKEAU
	DBI6aQj8aEkWqHMITbMPvKDrdnhYW0VOHv8+1+e+S540Q3829IorQTFQgO2DraeWHXo6PhfqudT
	AEtlbEUXdFs6ZJcJLtMwqxOh7h83cRnTbq04I5Z/bUdTDcuploGlrXlIOBL1Ay3d
X-Received: by 2002:a05:6402:5214:b0:5dc:8ed9:6bc3 with SMTP id 4fb4d7f45d1cf-5e59f467cd0mr2334227a12.26.1741166594693;
        Wed, 05 Mar 2025 01:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrT/jfbwSVjoA3FYJOR2RrQw1bBL1x20n/7XdsK3C0UVX0BQZe2DpbudtEjt/UHC5wEkkQDw==
X-Received: by 2002:a05:6402:5214:b0:5dc:8ed9:6bc3 with SMTP id 4fb4d7f45d1cf-5e59f467cd0mr2334183a12.26.1741166593907;
        Wed, 05 Mar 2025 01:23:13 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa46sm9297702a12.1.2025.03.05.01.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:23:13 -0800 (PST)
Date: Wed, 5 Mar 2025 10:23:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250305022900-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nWZsxzvlJ7YB39dqCiHlpW35PanSQy9peTDies6IDQ4_1741166595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 16, 2020 at 06:24:26PM +0100, Stefano Garzarella wrote:
> > This patch adds a check of the "net" assigned to a socket during
> > the vsock_find_bound_socket() and vsock_find_connected_socket()
> > to support network namespace, allowing to share the same address
> > (cid, port) across different network namespaces.
> >
> > This patch adds 'netns' module param to enable this new feature
> > (disabled by default), because it changes vsock's behavior with
> > network namespaces and could break existing applications.
> > G2H transports will use the default network namepsace (init_net).
> > H2G transports can use different network namespace for different
> > VMs.
>
>
> I'm not sure I understand the usecase. Can you explain a bit more,
> please?

It's been five years, but I'm trying!
We are tracking this RFE here [1].

I also add Jakub in the thread with who I discussed last year a possible 
restart of this effort, he could add more use cases.

The problem with vsock, host-side, currently is that if you launch a VM 
with a virtio-vsock device (using vhost) inside a container (e.g., 
Kata), so inside a network namespace, it is reachable from any other 
container, whereas they would like some isolation. Also the CID is 
shared among all, while they would like to reuse the same CID in 
different namespaces.

This has been partially solved with vhost-user-vsock, but it is 
inconvenient to use sometimes because of the hybrid-vsock problem 
(host-side vsock is remapped to AF_UNIX).

Something from the cover letter of the series [2]:

  As we partially discussed in the multi-transport proposal, it could
  be nice to support network namespace in vsock to reach the following
  goals:
  - isolate host applications from guest applications using the same ports
    with CID_ANY
  - assign the same CID of VMs running in different network namespaces
  - partition VMs between VMMs or at finer granularity

Thanks,
Stefano

[1] https://gitlab.com/vsock/vsock/-/issues/2
[2] https://lore.kernel.org/virtualization/20200116172428.311437-1-sgarzare@redhat.com/

