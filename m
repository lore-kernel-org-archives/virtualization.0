Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27493FE659
	for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535505; cv=none; b=Twok4O5sokPdUuU210UdPgA255CB9U8/e7iNRhkQFvNFxipi7EheCFBqaooR9Bc5qAZ/8RT1Rh9vEvY9WWzcbhaBVF6+Tq3W3GVE1HQPQUnSf30NoPaz41Y85df+6+gMly50h1aM0ZcTPbtdui7JB7hivYc7Hxs6XP1RwD6qkJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535505; c=relaxed/simple;
	bh=WeiO/kvXd28sVryXwcleJRKLGxigXtK192g6LDV52ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQ2iV7holBxusQ8qZtRQOBaQCTmt1kpL7P8zJ0BCPP+P8O+799Up7DqNEZk52hGIbo5ljINs9NF1o7xR3DgbOAwAim3lmKmboTEOX/iRdU46qclumVg5qapEmv1v6Ao48UHuJJuYdlzHGI1QYiJgP32nYMIUBwm4P5QCINeuxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7E8JmA7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7E8JmA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781535502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxLpH9j4tyUwflqQc435PknR0znSRfDU7Gw9S0v0YMQ=;
	b=D7E8JmA7h1zsP3Q3F0RcCQPLIctNe8Vc9femxxPKUMN5A1zktYrcUuljlLNvOMI3MDcF/F
	tIfLaCkCgKLpknwtmnBIJ+AEmfjW1ogajNC3Z7lzwbhVW+98lKvix1FPOkBk703wNSK7Yj
	zlvysSAkjSVhsZklw4rMwvKGlwmLWfw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-_BAas8q1MpeI8JVeulqbkg-1; Mon,
 15 Jun 2026 10:58:18 -0400
X-MC-Unique: _BAas8q1MpeI8JVeulqbkg-1
X-Mimecast-MFC-AGG-ID: _BAas8q1MpeI8JVeulqbkg_1781535495
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63F8E19560A5;
	Mon, 15 Jun 2026 14:58:15 +0000 (UTC)
Received: from localhost (unknown [10.44.34.1])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB60D19541B2;
	Mon, 15 Jun 2026 14:58:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, William Bezenah <wbezenah@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, mjrosato@linux.ibm.com, vneethv@linux.ibm.com,
 oberpar@linux.ibm.com, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device detach
In-Reply-To: <20260615002309.052e0614.pasic@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
 <20260615002309.052e0614.pasic@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 15 Jun 2026 16:58:12 +0200
Message-ID: <875x3jn94r.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: XdUSmRA8d7Y4QmmPXAxCyFTjdyPAVVwHwMd8KPSQws0_1781535495
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On Mon, Jun 15 2026, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 12 Jun 2026 17:54:07 +0200
> William Bezenah <wbezenah@linux.ibm.com> wrote:
>
>> Since commit 8c58a229688c ("s390/cio: Do not unregister the
>> subchannel based on DNV"), subchannel behavior following a device
>> detach has been updated and results in -EINVAL being propagated
>> rather than -ENODEV, originating from ccw_device_start_timeout_key()
>> in cio/device_ops. In the end, the virtio driver has no ability to
>> react to the difference between device and subchannel states here,
>> and during detach, both -ENODEV and -EINVAL indicate the device
>> cannot be used and should not be treated as errors requiring
>> attention. Update error handling in virtio_ccw_del_vq() and
>> virtio_ccw_drop_indicator() to suppress -EINVAL in addition to
>> -ENODEV.
>
> Hi William!
>
> Are you saying that ccw_device_start() started returning -EINVAL
> since 8c58a229688c ("s390/cio: Do not unregister the subchannel based on
> DNV")? Or did I somehow read the paragraph wrong?
>
> The funcition ccw_device_start is documented to return:
>  * Returns:                                                                     
>  *  %0, if the operation was successful;                                        
>  *  -%EBUSY, if the device is busy, or status pending;                          
>  *  -%EACCES, if no path specified in @lpm is operational;                      
>  *  -%ENODEV, if the device is not operational. 
> and the commit message does not say a thing about introducing -EINVAL to
> the mix.

The function may return -EINVAL for non-enabled subchannels
(i.e. pmcw.ena == 0), maybe we get an all-zeroes schib with dnv == 0?
I'd expect it not to be enabled in that case anyway.

