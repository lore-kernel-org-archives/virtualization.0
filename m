Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A9214817
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408541; cv=none; b=aHr8gscXfkX0mIIRssiHjO6DUogV5t7WGKC74AxTWZMaw3Uhv5z/+n4MTpvTcHkDjuWjJEUFAiBH3TorWUQyIuH4mqWFpbOlpHhkIViARbiUYTrZgVRKBn8OuqPdK8/SKF/f4wtdqPPhpIZosnCYyNjyIApBVZB1ssimlrwp8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408541; c=relaxed/simple;
	bh=KH8ZKM1it3Yxv/77thTE6axCBv3gF2iIm/JJRIvqYLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hQuX4UoWDM/xIm1LMa0bUoijjzkdajBWJBUSkLmOhSkIzCKQIvGvh6tvDXrBcRjlOSyUR4FhpRxXvhCWqJHUj5EL6Nb9DCjXMfYIegv6A2TR3OYWQ+t1O2os4hQy92CyS7OJqIBNGi0wQm2LD3rv+Tf85OUm8Ckw1C24FLj5qiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AX8a3cju; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AX8a3cju"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C2FE40ABF
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:42:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7jaseAzMohf6 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 07:42:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0B5BF405A1
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B5BF405A1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AX8a3cju
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B5BF405A1
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736408537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJ0jS+8S8ofkxwCu6uaTJBXu7c3fil4zQKkE3+oBAKQ=;
	b=AX8a3cjui0Qu0PBYhhBqWNC7DhUWrGiVYahwuLzUui6MAAJ6mTbeD+COY9+Cfme1Cn/8h1
	NOw39oaI9syK2YD8NDjmaJF84MGApsNJ3CY6nmhO4Dp4t2M5vvn1nLXczxYgOR7autxlz4
	pPU0STE9VvCwFBZJZFkaYtSSzMiblQw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-vyiycbQxMteJ8mDYIqr_aQ-1; Thu, 09 Jan 2025 02:42:14 -0500
X-MC-Unique: vyiycbQxMteJ8mDYIqr_aQ-1
X-Mimecast-MFC-AGG-ID: vyiycbQxMteJ8mDYIqr_aQ
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d09962822bso555692a12.1
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 23:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736408533; x=1737013333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ0jS+8S8ofkxwCu6uaTJBXu7c3fil4zQKkE3+oBAKQ=;
        b=vF9/41kgabOhCi15UTfDQD8doQEF5BYVfhwRL7Up9FpuxVMNAECjqaBAuOW9CsaJIN
         ZgnXvrtlzD8DATIMkZLnzTvD6e3YUkm+lk70fxRdb9KvSCPSEKKaAPNyK9Lz6j/jW25Q
         hlurwDUx7hvwl1eCsV1qRwnC5Fu2teO8eHU02MyhRpCiLESXNdXKdivAJ5SpGl0MA+1T
         nFnBkHJDnAhS/+dZ+YurrIx2hffCzXa8/0oiS5myZSfzRqDHMpFYTGvBYAZHvEkeRA4p
         zyMen6rEInIMHULgdi5EkwyyKg12e7w8Fw1BwfpoEBReYxxSObreWxrlR0k/VlguXsHg
         ae5w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ90K3QAZ6Zu7nSqZYsA9YEYd4knRD/+/5Lf/bCNqWWWxMhcdtqrU6IgrfSBGpbPpc/tdPPbmoH8osUxhE9w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyZ2UudFErKvJ8H3StY5Se7okbvbVkDat6Xj+C3xnqc+cHTbceQ
	0djhrppCWtUopeYEQHU4Z1r70CLyHSj6ziudFZD8twmzGPBP42Lo8pYcC9nsN8v3wjt9S/A1FI9
	hJTPWLFqtts+jJLQukU2IMB+GyL5VHG1MYiD2omdgpVgptnI7G5xEouMzcyJc11/W+lArejhLDt
	/T704=
X-Gm-Gg: ASbGncv51vNqFh0SQ/rxQHGBB73zuB5NzSxPLCXJTsDp3tGmKy+s/k7A70I+2sTZeay
	7TUC9zeKNVsi6Zh/5Et+hMMM7lZy1S2fSTQMzqjjH0zEf4VtMF18RUDDS5maE8Qvm68YPm+Ds5P
	PwQO6/G/4tNvbXIBVmctEC2yWd3AW9/b+DFlYvRaISK32/JXNCpiEuN4fQ6caJynCS1tZK2LXKr
	8LNTq2GV2RiJsSkaiwzrs9O4pWbvGseXRJJbcq2T7WDSY8YAYI=
X-Received: by 2002:a05:6402:35c3:b0:5d0:bdc1:75df with SMTP id 4fb4d7f45d1cf-5d972e645dfmr5337198a12.24.1736408533414;
        Wed, 08 Jan 2025 23:42:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN7MJKvcDkD/Px6nKcdgXtLTm3nqt5X4JuwtNE4wiW6ylzro51CFyZ0ACP+YhNMw81jHMbWQ==
X-Received: by 2002:a05:6402:35c3:b0:5d0:bdc1:75df with SMTP id 4fb4d7f45d1cf-5d972e645dfmr5337166a12.24.1736408532973;
        Wed, 08 Jan 2025 23:42:12 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c496sm326964a12.16.2025.01.08.23.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:42:11 -0800 (PST)
Date: Thu, 9 Jan 2025 02:42:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Message-ID: <20250109024107-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250109023056-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yTJ-e1QxdDSiQIN-U2z1LF5cUrbuKoiW3tFmFbUwK2s_1736408534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2025 at 02:31:37AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> > tun used to simply advance iov_iter when it needs to pad virtio header,
> > which leaves the garbage in the buffer as is. This is especially
> > problematic when tun starts to allow enabling the hash reporting
> > feature; even if the feature is enabled, the packet may lack a hash
> > value and may contain a hole in the virtio header because the packet
> > arrived before the feature gets enabled or does not contain the
> > header fields to be hashed. If the hole is not filled with zero, it is
> > impossible to tell if the packet lacks a hash value.
> > 
> > In theory, a user of tun can fill the buffer with zero before calling
> > read() to avoid such a problem, but leaving the garbage in the buffer is
> > awkward anyway so fill the buffer in tun.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> But if the user did it, you have just overwritten his value,
> did you not?


To clearify, I mean if user pre-filled buffer with 1, you have now
regressed it. Patch 3 fixes it back, but - not pretty.

> > ---
> >  drivers/net/tun_vnet.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> > index fe842df9e9ef..ffb2186facd3 100644
> > --- a/drivers/net/tun_vnet.c
> > +++ b/drivers/net/tun_vnet.c
> > @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> >  	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
> >  		return -EFAULT;
> >  
> > -	iov_iter_advance(iter, sz - sizeof(*hdr));
> > +	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> > +		return -EFAULT;
> >  
> >  	return 0;
> >  }
> > 
> > -- 
> > 2.47.1

