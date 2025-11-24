Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA01302CDE
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989405; cv=none; b=i1U7+fa4RwLXwD6hISy3KCzmCOhFgakV/ScnTMJC+Kpo468ZHgDi5IqXmHYx6dDITOtJa7dD+vOQCD5FS4/pfEzM4e4orNmrLHutrqI+T2GNMtNk90Qru0mX3bcGkd8IE+r6t+3MICVsWlHRdv4KVOGXvpkT+Fd3q2OIBZWS7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989405; c=relaxed/simple;
	bh=/PVux6/qhCM5j7QxIjZ3C4HJECU8mM2bPzRAiDoZo58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gwUgaRn5X/0gfTTAqN4mchctJRJ/wt0dcMjDO9XAvYRkgNjsuqJtx77jGOBhVzQZkdeekYlxe4eW/DokobpdUCAvo2Rx6fOfULPkef6wgR6iHNyiqbX86V8sKR0TJsRJ9czIcD5M7RAKT5RVXzUbQsnKMM51J4bgLBkYy+2k84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtCQSumo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtCQSumo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763989391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6hJnZw3kn5s0TB1aRyIXGCws54UxhojaW//4vyMORM=;
	b=BtCQSumoN69RMi9bPvpu1jLsrV1YntqhtGALWDv6slk6x5zwe8sEK06A5DDX9Sm0B7tbNv
	7OFBY7v/nBLJgYD4FKsrAfoaR0bFJHpkRd/WuM0dJeicKifIliCLlpzQpiK2/ve2tOs6Rs
	twzF4S6xrY7XLF+Eojq0fgJIbRhHS1Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-XgqYWlonPhSE1kDXJPGv8Q-1; Mon, 24 Nov 2025 08:02:47 -0500
X-MC-Unique: XgqYWlonPhSE1kDXJPGv8Q-1
X-Mimecast-MFC-AGG-ID: XgqYWlonPhSE1kDXJPGv8Q_1763989360
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b763b24f278so321717866b.3
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 05:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763989358; x=1764594158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6hJnZw3kn5s0TB1aRyIXGCws54UxhojaW//4vyMORM=;
        b=F7yjudq7HSR5qnDZA+U3lB1lZBgoqjiBGD8xhMBJkPPSK1bpo7qPEti5SCIFRXqVyz
         2NtL77hVT25EOWOTzYWL8TOq6Bj+lFu/+03dRyBmPz0JO49/qW6toogjQDs1dp1nYHeG
         6HSZPoHIZAL5ybj4Sxm4RjGUIL8tPlzLCoWLKD6PCV4qfQjOXfSbxUsl+NFHNkmjqLYk
         /NjmHG0SKOkPlbmKG6is+Kc5ywdPZDc6OdLTOJErXUvbAPtxkt3Ce9Cb+HXxe0Kea+tO
         HVA5/n5I6wh0KtXcct8tcwC1VG6MIMWBpggjTeMo5mNga479xOKSkzOdmKb1ykXS6EPz
         1hHg==
X-Forwarded-Encrypted: i=1; AJvYcCXzgqGPnIDj3NuJu7CeuHgOefXci0WI9lY/MwH9ejm5iUml9j+LRMwUG0rHmWFGZ2iVaQazRDmVFTYqVMF/Dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyDbNjip1Is/lXZ3uKW8FXFSRVHP/TOtDQTOLGM3uzpheeyYI3
	mBRTOpyxcAy/SaXWsFcDHTuJigCKYMizgCb52GhV1jUPz4gVSKWLzdIHvgsDrgpydsaiQT3SHy9
	GKuwu9f2r2Ux4iCa7ajqf/kzFpSywYZDDRebfHmEEC1OG0/4Woiqe3fIwpiuaTvDKC56JcKBCrm
	af
X-Gm-Gg: ASbGnct8RFF8Xcw0qCkq0sOqV67wKdYZU2vnVi4KxeHLhwMx/0c5LEHBEjMsWE3BT3/
	9g9HDNg+fmG2e/BcahawzTHke6YIccK42iRt46brQKjZqtQZ/15iWaEopv/bgVsY3YIORmm+BBn
	ccNSJBHDtCnblBqEoWhVHod3S9Z+DNC6QfIXMLKnBibG/EHgnF0Ty1osDUQyM1TCMssCSFMhzcy
	AjOCvAO414ibdpZzKGgAuYet2N1LMg2BBBqttaSb0g3VZmPozvVzWgMm0VahTCV0vTw2mHTMyPn
	8pAdt7qnHC5tjuPKym+tgHBB0d380kJgDPXjcKasgYnc4WdrvlIzpOhkPqKdsKRhT3IQn/VZmFK
	UMyxGgeCXWK+iQxqMeiQPstIn/8eKv/1UFEu08BWVYeGXDdzTmGangyOhKWfJNg==
X-Received: by 2002:a17:907:d93:b0:b73:806c:bab2 with SMTP id a640c23a62f3a-b76716d9e43mr1032887066b.33.1763989358021;
        Mon, 24 Nov 2025 05:02:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6ykVWPpSwinXanlRQWJeJ0XHFosSyO4ErfL2/mdTAE1Kjbm2jyYgIoPoi+6fsdx/pUINlNw==
X-Received: by 2002:a17:907:d93:b0:b73:806c:bab2 with SMTP id a640c23a62f3a-b76716d9e43mr1032879766b.33.1763989357321;
        Mon, 24 Nov 2025 05:02:37 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76a6bcfad2sm303348166b.68.2025.11.24.05.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 05:02:36 -0800 (PST)
Date: Mon, 24 Nov 2025 14:02:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 05/13] vsock: add netns support to virtio
 transports
Message-ID: <fa5j32kwvwitddkhbuenwqygtue3j2i4kquzl4lsnlp42y244z@zijsgsjjvido>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-5-55cbc80249a7@meta.com>
 <v6dpp4j4pjnrsa5amw7uubbqtpnxb4odpjhyjksr4mqes2qbzg@3bsjx5ofbwl4>
 <aSC3lwPvj0G6L8Sh@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aSC3lwPvj0G6L8Sh@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vyr95wSFzDeLji1xscqkCXDMNmnFxI87Ilr8c0vdBVo_1763989360
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Nov 21, 2025 at 11:03:51AM -0800, Bobby Eshleman wrote:
>On Fri, Nov 21, 2025 at 03:39:25PM +0100, Stefano Garzarella wrote:
>> On Thu, Nov 20, 2025 at 09:44:37PM -0800, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > Add netns support to loopback and vhost. Keep netns disabled for
>> > virtio-vsock, but add necessary changes to comply with common API
>> > updates.
>> >
>> > This is the patch in the series when vhost-vsock namespaces actually
>> > come online.  Hence, vhost_transport_supports_local_mode() is switched
>> > to return true.
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > Changes in v11:
>> > - reorder with the skb ownership patch for loopback (Stefano)
>> > - toggle vhost_transport_supports_local_mode() to true
>> >
>> > Changes in v10:
>> > - Splitting patches complicates the series with meaningless placeholder
>> >  values that eventually get replaced anyway, so to avoid that this
>> >  patch combines into one. Links to previous patches here:
>> >  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-3-852787a37bed@meta.com/
>> >  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-6-852787a37bed@meta.com/
>> >  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-7-852787a37bed@meta.com/
>> > - remove placeholder values (Stefano)
>> > - update comment describe net/net_mode for
>> >  virtio_transport_reset_no_sock()
>> > ---
>> > drivers/vhost/vsock.c                   | 47 ++++++++++++++++++------
>> > include/linux/virtio_vsock.h            |  8 +++--
>> > net/vmw_vsock/virtio_transport.c        | 10 ++++--
>> > net/vmw_vsock/virtio_transport_common.c | 63 ++++++++++++++++++++++++---------
>> > net/vmw_vsock/vsock_loopback.c          |  8 +++--
>> > 5 files changed, 103 insertions(+), 33 deletions(-)
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>If we move the supports_local_mode() changes into this patch (for virtio
>and loopback, as I bring up in other discussion), should I drop this
>trailer or carry it forward?

I'll take a second look in any case, so maybe better to remove it if the 
patch will change.

Thanks for asking!
Stefano

