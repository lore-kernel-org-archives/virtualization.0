Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BB1FC7CA
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167035; cv=none; b=YkM/IRYLjDxEc2RIz3MysrCyqAHuIIDT9hy1660WQ7Ec7vlFUo0W+AIMW/0lqToqtAdI0hQT0YghOIdvHeqh/y8K9bRglu27/eo+TxKS68kAW0mIkWFdJ0K48bTAwYouzvUrn/fd/ieDo2q4MIi7hfokGFBiZd7DyXo/N3PifeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167035; c=relaxed/simple;
	bh=Vxv0VBbtdbVDbDGLcORTnzoIpxIDB3hFqwWMEq+B6MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kpa/Y0pNibb9xpGfeku5QOMKq+v8KIm1nbtLNXqc/Sr98FISFEF2IdIpKg6bKior2ZiEkLu/u2D5DjKQRRRU3kqr5uMGq9DIT2wGwZ724lIQte4D60VmvmEYZ6bqiKRZmzGtC0O/uCS+j+oYWMjZ+IjmqXK6ICVxU3Jrpo0NiuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvCLzCeH; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvCLzCeH"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BADF81CE3
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:30:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWiUgtKSZWVI for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 09:30:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9FAFD81114
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FAFD81114
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PvCLzCeH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9FAFD81114
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BZqtssEKSX9U+sm7giaUTnUcD9w0nxNJyaKF0Dg8jk=;
	b=PvCLzCeHuUCvP0N0rFR/FYC974jDYCEemPRgiFa8hx5w/BvUmD8yoVnUlFq4AIMF6TCHGq
	lY9r+rkL1qqF41FyTi9sSTswBMmXAY0umzX74hQviZMcQM/Qv8tYOkQ+Zp8gAyC0vyIabx
	dCEI7G1viJX5sZO+rGD6QpcURsKvEAM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-CsgGD-S2MtuIgWkGG8_4kg-1; Wed, 05 Mar 2025 04:30:24 -0500
X-MC-Unique: CsgGD-S2MtuIgWkGG8_4kg-1
X-Mimecast-MFC-AGG-ID: CsgGD-S2MtuIgWkGG8_4kg_1741167024
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e546b0ce50so3467880a12.1
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 01:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167023; x=1741771823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BZqtssEKSX9U+sm7giaUTnUcD9w0nxNJyaKF0Dg8jk=;
        b=BGlVpx6HB9OVTC0MObmiQdqXo1HljNAlO9iFGptEck9EPgJhWaAN6i+NlkT6PiJZgo
         /WDqgDnch2kEewHtnBIn6YfutObGv1K+2CJ9pg9mPduPP6IMI4KglH7VEXxKs28YYNGF
         dv2Rkjr94onur/YhiQuxAcgxh3XSsjCaP+E0G5+OG4TJP61E38+xx1lz2A7+wPZv0ZsW
         Q0qz+eucLTjmnDbLFMnM0OhditwKyYbl3azB9HJkmljcpyfZ9amRsECJcdjbTn3EkFp4
         uxXDz7i76o6M7jXPYYdkijxhiKPAw84jvFFBjv5fKdcwWwLTRgo22I8DBUQYGYaSWsqh
         rPVw==
X-Forwarded-Encrypted: i=1; AJvYcCV2CQ9UyECdsnRFn3CT59VhPNZ5wdHwfZyDRI8XwsMJThJHgZnVDiiNe7N5GjG+qSq4+r4yxKy6uFuwUV0vBg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxe/aewanJXRuFprdi7tKeBF4ppPWf1ruhV8huUuFVk9Y4TEvHT
	91G6rPQj7if8tteg6WVGBiWP0gzge9+YV+o4su8R4RIjqT3xtrIzEMR116NoqyD+OSKbvn9MqN2
	q6qQlSuzo3oGOouxBl+P/WbRyhHJ/AIuuJd37IiRnGfxwziqCZCs21KfXw49Hiu66qAjx3+Z/24
	ilPOI=
X-Gm-Gg: ASbGncsbuygC+4K6RMfuZdep/bAXiR73e4vMsxNsQR69MdkdI37PtflIFL4kYYbhc5u
	EGd7WYXyg8lHTFrBGLD25y/4ANcxw7KDfN0O6X1t6wUIwG/z2vquEUUGj7H2XWzUQQuVxqmEDh/
	EzGWKkLXLbh+mLCebyMfMoBh8D5eeY/pakphIiMchLq0cNtFdVxTmd35+i+oo45S9T5w4kaRILc
	tbzQOIzT1n714xIZqbi3/EL6+Pab6eueqUIWMUn2Nq8BZoth6/J96tbP8SEruQprROHIc+NmdwX
	auSiyGuDQ7vvFSHYurI4ePBDDQwFKSihAnrwZL1RlKuUI6ruSbtJ1NyRQvASnEDv
X-Received: by 2002:a17:907:9494:b0:ac1:da76:3633 with SMTP id a640c23a62f3a-ac20d84412emr257569666b.4.1741167023615;
        Wed, 05 Mar 2025 01:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXk7a1z+Ze1GZvne805ygS+jajQyu0NiMIy6MNpjgAxqXVnbiuz0kcZ2+UtS+U3NrxoZnl1w==
X-Received: by 2002:a17:907:9494:b0:ac1:da76:3633 with SMTP id a640c23a62f3a-ac20d84412emr257565066b.4.1741167023076;
        Wed, 05 Mar 2025 01:30:23 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac20225a3a5sm182343166b.177.2025.03.05.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:30:22 -0800 (PST)
Date: Wed, 5 Mar 2025 10:30:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
 <20250305022248-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250305022248-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TyWbg9xwAXkrSKgVUfFqmUcD30iGIDmMxkGubo02F3M_1741167024
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
>On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
>> I think it might be a lot of complexity to bring into the picture from
>> netdev, and I'm not sure there is a big win since the vsock device could
>> also have a vsock->net itself? I think the complexity will come from the
>> address translation, which I don't think netdev buys us because there
>> would still be all of the work work to support vsock in netfilter?
>
>Ugh.
>
>Guys, let's remember what vsock is.
>
>It's a replacement for the serial device with an interface
>that's easier for userspace to consume, as you get
>the demultiplexing by the port number.
>
>The whole point of vsock is that people do not want
>any firewalling, filtering, or management on it.
>
>It needs to work with no configuration even if networking is
>misconfigured or blocked.

I agree with Michael here.

It's been 5 years and my memory is bad, but using netdev seemed like a 
mess, especially because in vsock we don't have anything related to 
IP/Ethernet/ARP, etc.

I see vsock more as AF_UNIX than netdev.

I put in CC Jakub who was covering network namespace, maybe he has some 
advice for us regarding this. Context [1].

Thanks,
Stefano

[1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com/

