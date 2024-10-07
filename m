Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8A189BAA
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308273; cv=none; b=K0NA6dbuP27B+YVHGWSQxaNCyT4KTOykBKM3II8BPzqFJzb8KBDKlRS0N+wkgsD/FYOj0jA8b95X+qfUHEbLPtaaC9/N4LzJeatEZx8FSVbGQqZaF1TBlXTZuEwj0qTxL756noYPbOnvQzvROkPU/KX2z+aMfqs/XDZkymL46I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308273; c=relaxed/simple;
	bh=hB2s2lfcHmnZyQnBQtcYGPUu92PIitX04lRdk6K+6i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pbDItAQwPvqE5RggW/hUOm6q+na66OEOSnbL/5035tQqHKv04YJKxE4LBr6rabsORImY5NXyNfiiUWgJi8OZ9I019hX0QFfiWtVFOymUzi56H6qtfqi9Ip9dlz4Ptr86XWgHw0TFiPrKAtuc6VC8n3zQvjPdJvY2WOppCRSh3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvYcFzx9; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvYcFzx9"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E547A60616
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 13:37:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kYm0qQmsgRmp for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Oct 2024 13:37:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 193CD60609
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 193CD60609
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YvYcFzx9
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 193CD60609
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728308269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u55VIzbnsDYZ6+urjTeBn/sPe+UeOPYjNBp44UJwta4=;
	b=YvYcFzx9rNXsonIE5/Mf3mPHhQZ/iEAaFtruB0XVcCKuLNEVsbN4li14cL4f3minWhaOAL
	i+5FlqPIffQQDEiEsmpYaDmb3VoH/R4Qx72uzNNH4V0w1Q3dmi1DHjCwYZy8dpZTvEOh3G
	F92XsWVBvelwVvKkcYZ7Xew0bGXsb44=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-ls7qrORaORmPuSLld9yOMg-1; Mon, 07 Oct 2024 09:37:48 -0400
X-MC-Unique: ls7qrORaORmPuSLld9yOMg-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a969fabfso56033635ab.0
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 06:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308268; x=1728913068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u55VIzbnsDYZ6+urjTeBn/sPe+UeOPYjNBp44UJwta4=;
        b=VF5Fiy2Buo5dJmL5/iplaMOB/xOWq+pzHMkvrO5amPMVwpOHvZNpUvyF8BPRjei+rK
         SvVqWrVrmoAqlVIJli0HqD3qchk47kYq/FBMCxA1GEQJdYiexudAdMNc5VURAZ43o6BQ
         kgxuwPEd7alh255JJRnCl6pe3rHrEFqLCzOV3v3nf9SMx3sCVK6giy7RdknYio9vv9yp
         9S94Zivi1zu2KwcWVAXnkbF+zztAj8xkRYwMyYXwNGTYLD3ET2xTuXONbHTnGjHWybeV
         TkdbtQ0S/24AKCnkXEVfRKujnIzES8FA2aJkejQ088BkkTIttKjoY1e3bcq7ivDsVQwq
         5c8A==
X-Forwarded-Encrypted: i=1; AJvYcCWwvP251d38fiqH6wUl5iY0pmVkIwot65t0+W8dAKCjaMRpJ/JPa++c59vxPIeOm3S2ZucVYYF+nlpQfps4Bw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyWRxzTnElTHxXtqtMomafqygZRZcRIGGkPuYeeyKFgJkRRAF92
	ftfBq2cdrWTUYE3xmLuVBhRXD7uAeKumxVoOHI2nRAe4ovBeiJ8oXmo+tXY6ztkg8O8lQ8AX0N1
	Ua+0QUe6DtLiF0JHWIapAHQraD1rmLmDGMjamZ7573ggtxRxUCLMcKuDpturkGdtz8mJUUTaV0x
	FcG0U=
X-Received: by 2002:a92:cd82:0:b0:3a0:9952:5fcb with SMTP id e9e14a558f8ab-3a375bb6652mr104129105ab.17.1728308267901;
        Mon, 07 Oct 2024 06:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY4DVSl0pKaQLg5oB3Cu7qBASwkdVyLfgME8TrpLYdIQrARbPLldNRPAtt7pwFAXQQCbp5QA==
X-Received: by 2002:a92:cd82:0:b0:3a0:9952:5fcb with SMTP id e9e14a558f8ab-3a375bb6652mr104128765ab.17.1728308267474;
        Mon, 07 Oct 2024 06:37:47 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db8479ff8fsm566559173.2.2024.10.07.06.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:37:47 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:37:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
Message-ID: <trrpnhe3qahveeizjlwfp33thudcw5jcmh3uunllucgur4txub@gm2k3p4sx6in>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241004015937.2286459-8-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Oct 04, 2024 at 09:58:21AM GMT, Cindy Lu wrote:
>Add a new UAPI to support setting the vhost device to
>use task mode. The user space application needs to use
>VHOST_SET_INHERIT_FROM_OWNER to set the mode.
>This setting must be set before VHOST_SET_OWNER is set.

Why?

>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 18 +++++++++++++++++-
> include/uapi/linux/vhost.h |  2 ++
> 2 files changed, 19 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 08c9e77916ca..0e5c81026acd 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> {
> 	struct eventfd_ctx *ctx;
> 	u64 p;
>-	long r;
>+	long r = 0;
> 	int i, fd;
>+	bool inherit_owner;
              ^
              This can be moved ...
>+
>+	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {

                 ^
                 ... here.

>+		/* Is there an owner already? */

This comment is superfluous, I would instead explain why there has to be 
an owner, what problem would we have if not?

>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp,
>+				   sizeof(inherit_owner))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		enforce_inherit_owner = inherit_owner;

mmmm, I'm confused.

IIUC with this change, an user, for example, can call 
VHOST_SET_INHERIT_FROM_OWNER on /dev/vhost-vsock and change the 
behaviour of /dev/vhost-net.

Is that really what we want?

Maybe it's better if the module parameter controls the default of any 
device, but the ioctl changes the behavior only for that device.

>+		goto done;
>+	}
>
> 	/* If you are not the owner, you can become one */
> 	if (ioctl == VHOST_SET_OWNER) {
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..1e192038633d 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,6 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+

Please, add documentation here.

>+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
                                        ^
                                        Please, add a tab like we did
                                        for all previous definitions.

Thanks,
Stefano

