Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED362E7BD9
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261183; cv=none; b=H1LN95fo7D5yHOcmUQLLqJ/xcRxwMCnhP5nLcSW/jtdT9za7HG6+JnEF3en1jP/rzZvMXboTFGTjIKiHSjktWMIMiJCdvyiPfNDwIeJWvANdrQ/DQp9x9SfoHoLZErg6lR/mktdOu+QqRYV+dTR168uASXToYmWuDE9WiVU7yww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261183; c=relaxed/simple;
	bh=u65Bn7mUeRrJUx2bbJXKRRbhepBmR/uX4W2GEmfYjVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cAfNkwtuIvPwlNA1e5sMPmyX5Ju24nG1RAAExxmYvFRk/70IdebJnQKC9k8Z+E9ZeGGROss+PSueN8NegtwlY/x7uRDPoVUcj78JVPH0njGXCtDLvBCK7P/3KQgisN4TgAN9pZA+FAg+nX1EMlMw22ufLssAeSBH2qS6iuCqlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYEl9nXq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYEl9nXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781261180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LD/2C2qsDL0yxbIAux5qj+n5CJ7v1MBG4itfMov5pQk=;
	b=PYEl9nXqLrxH6Fri7Z3oYUX+hDhqnZHmIt/pJ8BLp1Riw16goOj662Nx05uZSNKC/ON+eJ
	AhYFPgCOM+9A5+zIOpjkX4dv/vopgPKTPqBKqbZ2y71S7D2ywJXVxpr2A2Ntt4f+R61Yn7
	Tqt22v9ooYgg6qsjJkMDGmddJTuMsSc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-VW9XIZcqOTKNMBb31ZqKtQ-1; Fri, 12 Jun 2026 06:46:17 -0400
X-MC-Unique: VW9XIZcqOTKNMBb31ZqKtQ-1
X-Mimecast-MFC-AGG-ID: VW9XIZcqOTKNMBb31ZqKtQ_1781261177
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef616db45so637730f8f.2
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 03:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261176; x=1781865976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD/2C2qsDL0yxbIAux5qj+n5CJ7v1MBG4itfMov5pQk=;
        b=mpIxQ4LW8yQvs97Le2VB0OLBogThzb4POb3mbM+wIFR7sIMvju84M2UDWY9XAGZTrA
         hhmTUGnrN0AomlM45L5OSZVJpMd4+HjIAKVT3CmD+IQpNpMdFjvtaG9HyKQBrQ4p7dgS
         BVynND87EvJ4KVdXASzAhQ0C/cupIQv5xkFf9kf3z5fYBuTn4irhR+5Xxma1emaSb5Qs
         mQeXW/jiiMieJASe1FyldgiNcqTj0HhuI2U8YU4JiuWVg0OaILV8sLKkNdkgk8WK7klv
         4MkHpkcAVcs4R7eouiaFzUQ7FMeZlJsO5Wn7eQL+jYHxtxgDD3bbwYAxjXcX/BwfDqCy
         9g/g==
X-Forwarded-Encrypted: i=1; AFNElJ/VbyU4Gwc8BEA3UvtLj+e3BKdmdiyZ6U3QcvDdg5NHRNaspWColEoO+C8GP2RzbQd8s8DsXmPwp4bZBzqyrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEIstMxPxakAtc05zM5+ZenIBRJD7Yk2hFKKTfeLAfte6vX7Xg
	Y52WuKH0ycWV3EtxMTuAT4ABS+WoW+tu4/bm/ZCoL+KI2rwlZsWUlkBoureiBxW/kJPNeJkfNy6
	Tg8gXCefqTgNnDo3Qt/LQeIr17NPrMLC5Ut8dtPTSDN0JklXJ1F8nFs3grPFsRUplsm9h
X-Gm-Gg: Acq92OHBAncMyS3KKJ9f/yJrftg1OIXHh8UkaMwQvFV6GmgHXHoyGnmFDsEo0dR5lrs
	HH0cTjjaM4IpsB/A1/yWdsri8ysQE5X/vCKdHrrit4QZyXTyTfSGXaVfst9MG7RQQrZMJkPQ++4
	dUZJwjG6WLSE4V5cJlKOvBCzhkUAEVXgQ+UL9phYO+AYk9UmQ0lken6+Fmq1bGKSoJEeMWsDpLX
	saviWZ2ujES2vkviOwmeNFSkeYTBgcEPIuXSeEIZpOEiL/+vabgpMgg8pgjCv1oM+Wibhk3C/PM
	wHHxKMZnICCKN/vLZQjaM9h+tIrtPdmL4yZzIVei9U2WzMTFn8ZOdQUmJaZwpnwHvy33KvNUSfG
	PhjHp1/iH65rvqIDpzClPqZi4WjTZXd1HLs3dQXChy0Tf+1FJFRKDLN1/qReidGUVnmFbVUc=
X-Received: by 2002:a05:600c:3586:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-490ec339ec0mr34621965e9.0.1781261176652;
        Fri, 12 Jun 2026 03:46:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3586:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-490ec339ec0mr34621395e9.0.1781261176179;
        Fri, 12 Jun 2026 03:46:16 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7c8f49sm63830435e9.6.2026.06.12.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:46:15 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:46:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com, 
	leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aivjZya3rcXZa9n9@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-4-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612045216.105796-4-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _rVRSeDvOiFF5Te4VeRrD3gVVfDWp0q5K0Wtcv5zOO8_1781261177
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 04:52:15AM +0000, Raf Dickson wrote:
>virtio and hyperv call sk_acceptq_added() immediately before
>vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
>itself so callers cannot forget it and the accounting is consistent.
>
>Suggested-by: Paolo Abeni <pabeni@redhat.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c                | 1 +
> net/vmw_vsock/hyperv_transport.c        | 1 -
> net/vmw_vsock/virtio_transport_common.c | 1 -
> 3 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

