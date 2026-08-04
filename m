Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517213EE1FE
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813581; cv=none; b=nCJWMK5aqQBr7pmPwLrrNYmDbfkvTm21Li0QECoCYw6qj1z5eS6cg4CFpbov6FZNmPpIHYf/nFv8b7p8opUSqC9SlkvBA424n5k8wBwqVHKtlHdp0zCyyimu9QGEl52+ugWTcVo9nkBbBZLCCOgB2CWGMF6/xyOM5pPcvWSc+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813581; c=relaxed/simple;
	bh=qJNK0mMXv0heRTimXOWusPvPz53Xv2iOqzKHV8MyWU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MnlC1apkl9+p7lpv0JpsdcWqwqG5vePKwkXu8f/9UdTkr5ydVxbviBbymIqyUumD2H/+E4vR9wapzyeAwm2vXEmC9ZRdLaeRF6v0w8HOP1Kq80aRxDI9H26poMAdUQ1VSz3T4E/zvTpVfuGVQAo2PwfOmId9qMmJktkXHmF0fx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQpU6kMh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQpU6kMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785813579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMqUxTeod+qMIzPox6QOe/9dnA8UJsfNkNiAFu3uAdY=;
	b=RQpU6kMhxOnbwPPkgdeMjkpiMH3q+GPNzhfsSR+GJ22p/NeNdYLzwXPAwt0TKAcEepAHyb
	lL7LfUAT5py9B+P9uAO/N/VTscVwV3kRI1BUMyRtgxH80Pj9cy0L8yGMQK0LkQt5VWF3vi
	xufzzJRf3jXLxPmCE0S91wP5oLOK+gw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-aDUfamKfNaeIhIUQUw5o2g-1; Mon, 03 Aug 2026 23:19:35 -0400
X-MC-Unique: aDUfamKfNaeIhIUQUw5o2g-1
X-Mimecast-MFC-AGG-ID: aDUfamKfNaeIhIUQUw5o2g_1785813575
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-698c15b962cso4611625a12.2
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 20:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813575; x=1786418375;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMqUxTeod+qMIzPox6QOe/9dnA8UJsfNkNiAFu3uAdY=;
        b=kofD2eC2QMP3NYpQzZezGcbPV7PUo8IJs+YdF9/rCaC/uPidxJGd7DrB/QBHkvfimE
         qJcfJPyph5QfBcU65FTLheDo2SFaOX8bxt9h+MRclp0p/FSuQez1Ab1J00DwyqFHXc9M
         pM1tU2Tnk5IA5po0gcx8PUr0N/czazzD7ca6JJflF7hlaTJrXsE3gMDkIUBqfxxI/z1X
         jdJCG0/eDYLKpUx/zw4oKbuuZ735FK5u5g7o7mj2Otjof9pb1ltoOQ45tMiXD0ICsBWc
         Hk6ZczWaOm9xLeClJOv9ftUjhIzmrEj5uAeavEiYuV5uaRkci1NCyJ9NPAXbOGOkekyA
         JLTA==
X-Forwarded-Encrypted: i=1; AHgh+RoNtESSwpk68/Fn3PhqcL2a441LfjY/zaIq1F8R3zxpsI4ZZkaslyCURKVux9ZgQJfWDD+LjR/UIKLjk+TdGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ/cYflRWGTkof2YFHj9JjezmUkZ88DgV1MFhrjB/2SDgK2lpw
	GO7Pl1I767kwFv4LnnJypWws5oya2t0a5ZE6RyQDMWDuU+kEhZuE4DN1TpFNRPz71/imbZe5onG
	n2C75AeZwv1so62UmjNZhnobhAplH3fBfbiSUhlMJjrl/zmMbzpcoOjOk7nI0guX9rOVw
X-Gm-Gg: AR+sD12Fya95Xxg0xzYZn6v/AeHjkYOYYxq501/oUcinOFTGlt+g9FTQm1HwHgwka/g
	g+iOJX4hJj8i7FHeFI7v0IT3eQg0RO3bmGcyj1HPBWBdu1OKOKMwnXzHkUqPzFvojbNWiBqt7Ki
	Pvg3qQwlbXMLGlNz6+QciAm3Pb+a5H1WOjf9YZYROPDUzHCb1o091Dv+kkk7UgSRltK6MdltkcT
	kvYR1IoDZNB0g7GfpLtrp5fpDj0eoKxvAUfWhK7CkBnH91VenS/A98Ej4ol7PlDjvZO8fviONRz
	MyBLzhtk1FvVch07lcPCWttBHqfWNAUBeD6rhtuGG3UIk9Fsw2suH69CNpvtnBX9w4cF
X-Received: by 2002:a05:6402:4487:b0:6a0:f1d5:deba with SMTP id 4fb4d7f45d1cf-6a0f1d5e1f7mr6584345a12.12.1785813574698;
        Mon, 03 Aug 2026 20:19:34 -0700 (PDT)
X-Received: by 2002:a05:6402:4487:b0:6a0:f1d5:deba with SMTP id 4fb4d7f45d1cf-6a0f1d5e1f7mr6584323a12.12.1785813574339;
        Mon, 03 Aug 2026 20:19:34 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a0d0a70ae5sm2965304a12.14.2026.08.03.20.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:19:33 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:19:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vhost/vsock: fix device IOTLB feature lifecycle
Message-ID: <20260803231911-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260731103414.1746316-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b8deC2TTI9BFkl5KB13PI5EcObbS0P5y0LbqpeANHNk_1785813575
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 06:34:12PM +0800, Jia Jia wrote:
> As suggested, split the changes into two patches.
> 
> Patch 1 detaches and frees the device IOTLB when ACCESS_PLATFORM is
> cleared. The device and virtqueue IOTLB pointers, metadata caches, and
> acked features are updated while all virtqueue mutexes are held. It also
> drops old IOTLB miss messages and wakes readers.
> 
> Patch 2 keeps the current IOTLB when ACCESS_PLATFORM remains enabled,
> so a runtime logging update does not discard valid translations.

pls do not post v2 as reply to v1. confuses tools. thanks!
> Changes since v1:
> - discard the existing IOTLB instead of returning -EBUSY
> - serialize the switch against all virtqueues
> - clear old IOTLB messages and wake readers
> - move the existing-IOTLB preservation change to a separate patch
> 
> Jia Jia (2):
>   vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
>   vhost/vsock: keep IOTLB across feature updates
> 
>  drivers/vhost/vsock.c | 46 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> -- 
> 2.34.1

