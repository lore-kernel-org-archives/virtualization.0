Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5658AD24
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476102; cv=none; b=BZ0W3iK8Y+RlW9wb896LC9FRKP3W2Q58IWwybnShj+Qs1+qFwvMBHOQ4HO4VRPQk6BF4lPOftagCI9TQUCutGXyW2lUtdL4WQRd8gwSxayOcR0Lvv4g2g+8rEbwYdVaNSYF0zKYlP00+/TyXERVTqQuaXxEN7F08FO+TBJqfZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476102; c=relaxed/simple;
	bh=IXR7S6Gc+F3sudLsZ8LWQ+6UJawqmAovn5NH00L+sI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qQQpsGETKJatxsH7xGS1OOejh2NQUnJbBDf4xPx6pA5t3dJDfrTNxADAaPRNeQQ3g8MfAb5dXhr6AWXKF7ao5NXLqDdbNPH/B/XcqzXe6uhZgvCgjJOnZopA78R/t2LmYWGv518+DXdQK+YurQXoXPNK17Juk8KZzmf08JPaRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7pdPEal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7pdPEal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716476099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/IspulZ7ogp/9/Ev8vDQ4CFOVYGCYWHCfNnAnEppwY=;
	b=C7pdPEalU/POUZLOd81MGyp+EFCxmZ2hN8TdKNdIjmQL3HANam0tHKMcu2KaFY0CHfBsIf
	nwBEUQdZVvbxeEy53/J1ECUKGxDWkhQlNOcOgbtcYUMJDrLAbtG87fDoxXuIyndiQqAUuB
	vnpHjV4X3UOXLbfz+Y9fWFb1+Rvt9w8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-mvBcUUS6MUiuVfTnvOgFyA-1; Thu, 23 May 2024 10:54:58 -0400
X-MC-Unique: mvBcUUS6MUiuVfTnvOgFyA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e1f38cb631so13061581fa.1
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 07:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476096; x=1717080896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/IspulZ7ogp/9/Ev8vDQ4CFOVYGCYWHCfNnAnEppwY=;
        b=jnCRyJhfaRSVlzfgNGGY3ObPh0lQGGOUb5hEFZNwfPMOYM5h7Ul4XPlPfrpoQAX1G3
         eAl0WuMOE4IApSBigiJlumFe5BHctBgotPuvImaxOi+Miz76+fA5Wd8LnBOlxoErzRmR
         rg/6+TutjOQZrUixgmsoDvepVxl5fRVqM/G+s0R0pxGnOSxbCwiEamKQNI+pyIlXGKad
         S+lvdh6xl5KAPmjQ0PJtWukUorZHK4vTboyYn+/sGgSiIKidF8A4fZo+pQtlteciXN0I
         G/m46IYR3/k1E17NkJvC/3/CoaRxin87QKfV2VITzF8/haghRBp1sRqRts4olNn8AW+V
         7ufA==
X-Forwarded-Encrypted: i=1; AJvYcCWo+Lyn3jvn/bCsxUOup2dFdY5olLg6m5TMQTRa48jhRTvEQ4dkzav6NHosi38jHiuebXORNrEbAIH8+dgTgOQKDZhDT8lGyFL5o6iTx1A=
X-Gm-Message-State: AOJu0YxJJVk7sLtEOKOZvGv2z/8UIYC0KypMV3yx8jRbVcXrU375qlXl
	wMMuvJS9shvzHjrBPBfvzEsmOo0ysH9slWi259zJGEuoPeUyUSIICz9IlT4EaWXZQxkRtx0bgr0
	g6rR08ohWd3ji9bMLfhnj0HZgQLjbwX+swnEMN3RDsOZKk+mG5EBeFTk5ND+q/04xIk1ittsX
X-Received: by 2002:a2e:9042:0:b0:2e5:4e76:42df with SMTP id 38308e7fff4ca-2e94953fb10mr43723581fa.33.1716476096208;
        Thu, 23 May 2024 07:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC0bLoBdXb54NPxLQ4coOeZyHZBFadFkv6sukQZSvxP4AKs7iWObQtZZHt9eGMKoAkua8+hQ==
X-Received: by 2002:a2e:9042:0:b0:2e5:4e76:42df with SMTP id 38308e7fff4ca-2e94953fb10mr43723241fa.33.1716476095561;
        Thu, 23 May 2024 07:54:55 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cdeacb2casm1095429066b.67.2024.05.23.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:54:55 -0700 (PDT)
Date: Thu, 23 May 2024 10:54:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 0/5] vsock/virtio: Add support for multi-devices
Message-ID: <20240523104010-mutt-send-email-mst@kernel.org>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2024 at 10:46:02PM +0800, Xuewei Niu wrote:
>  include/linux/virtio_vsock.h            |   2 +-
>  include/net/af_vsock.h                  |  25 ++-
>  include/uapi/linux/virtio_vsock.h       |   1 +
>  include/uapi/linux/vm_sockets.h         |  14 ++
>  net/vmw_vsock/af_vsock.c                | 116 +++++++++--
>  net/vmw_vsock/virtio_transport.c        | 255 ++++++++++++++++++------
>  net/vmw_vsock/virtio_transport_common.c |  16 +-
>  net/vmw_vsock/vsock_loopback.c          |   4 +-
>  8 files changed, 352 insertions(+), 81 deletions(-)

As any change to virtio device/driver interface, this has to
go through the virtio TC. Please subscribe at
virtio-comment+subscribe@lists.linux.dev and then
contact the TC at virtio-comment@lists.linux.dev

You will likely eventually need to write a spec draft document, too.

-- 
MST

