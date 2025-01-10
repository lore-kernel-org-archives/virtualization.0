Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDD2063C3
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479653; cv=none; b=gJAP4cxXu6l1OdgYQuA/CsAf7J5Zhpo2NWZJgID2KRzLMGVnnyFUgTTljMPf5a0d0mcPp8KkdV60Osy07xc1G5xbq/Kc+SrJUKpDsNFr1rQlP24onZ7rjfCj766hsQag4Jq83ml0/9f9eRVCzhCR53deiJEnJI+V8xXMO/y86qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479653; c=relaxed/simple;
	bh=7uR8vN0M0CFh5qpZV7D1vSWR3xVu4IYzXqUeioDmijc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kf64vkM3r7s5dSiaRd77m8IAGm+GS7G2wlE0KL+Ttm6Mn1pj4SntgFk72nsUKoK8ypLgcpl+kMtUCh2T/GVmZR2gk7hkTEDCdWvq60tAcHtnDz+9HMr2+XBk/AFVN89ArL9xy+jKcW4wUg/iBqndUY6cpgRnRWQeqgXO8X21fVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nb4QVI9m; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nb4QVI9m"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7ED1460796
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ClBX5QDqSxiX for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 03:27:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ABE136070E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABE136070E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nb4QVI9m
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ABE136070E
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736479650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uR8vN0M0CFh5qpZV7D1vSWR3xVu4IYzXqUeioDmijc=;
	b=Nb4QVI9mHzICmqRIZVeZFZY9R5ZTx8hooto6Moan0/cZia3CmRd0TIKaW8gNrAtJBp9Dce
	DfCqWnBkBXKRVFWyvxY+Fpxrtc204L4k/EXG/Wt1cUGoccyQpkRthZObV0BTh+UZVmegpm
	FW3LYu5c7nRSJyIj1E8dkq2cEQNGdi4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-gJv4Wk1bNZmhkjsodGGJAA-1; Thu, 09 Jan 2025 22:27:27 -0500
X-MC-Unique: gJv4Wk1bNZmhkjsodGGJAA-1
X-Mimecast-MFC-AGG-ID: gJv4Wk1bNZmhkjsodGGJAA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef35de8901so2863434a91.3
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 19:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736479646; x=1737084446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uR8vN0M0CFh5qpZV7D1vSWR3xVu4IYzXqUeioDmijc=;
        b=m9lR5ssF7Tedk7G7nbj9tV8jlK/YZCDL7PoejevtObQ9VCM9clMjK3M1NVa5KtZ9XA
         fYQqe6+ET93s2hbJXzdikY+y//+JBC/JxjBlfqpIOG4TH0NXY9UnIrp7I/OjWo/ZdLKi
         iQl1rE1IfE7pcx0vz7fboV0G4d/tnhs79hi0XcNkAlynwnyhsfX/MlBJBEwI6U8e5UND
         /Fc6LT+WsxNgDhU3L86KhkkU0NsTCHvia87qIzcl7iG7RpPiB8TJvl8lkg7xcVa0FXX+
         p5G342YDhSY1pYPXNFslk1W4wyCuIo0wr879DqFdlzV4uIJC49B55fFaebBu/IusOPl0
         eGAg==
X-Forwarded-Encrypted: i=1; AJvYcCUkM+z4BGTL1mmW6edmz7iDDk9iXxFYCJPyRZRmgrHEPFr8H83tK9ooybhZZohfZ/IWgPV3Nmjdk2vQWppXIg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyJbPf1U4Lvhg3CRbQGjZv5FLEEwKnfUvpEtPrQW2gU+u7COezT
	NQdK6k3JMvDFpEOI6cQVtD3bvanUc6Cwl1ZwnIzVVI6mTq1Bt5dDOF+FBqJpy5suVQP7J9F+6lf
	sqCeIcmqLGxnZGVYYE/kQ2BCguFMMuNWmwUxpkHkHT5upWUpGMEfn1ne0CFB0+gOgGTuRujsMJJ
	NJuK++WoAhlcboy1ufTbTiOjA3SbYZjOVL9Q8kaKmwx0e49imsjz3MUg==
X-Gm-Gg: ASbGncvz8ka7pxZJpOVmp1apOyDo4B6am10p0lxsIPv4XCdQrULoUCuIl4a+2sZ9aAH
	y2SBdE8O6YHQe2Izk+FwvpQ6kVHwogIH/hvg3Ra8=
X-Received: by 2002:a17:90b:2f0e:b0:2ea:59e3:2d2e with SMTP id 98e67ed59e1d1-2f548eb9e0emr14161346a91.10.1736479645908;
        Thu, 09 Jan 2025 19:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr6qt6YqI8gxH2NjDJ69HLIEFDu0/JDwyZCE+11GxsqEEXtLHHfTQDNxjuhLS8NYQPmojHsZtINe9boq5qSYU=
X-Received: by 2002:a17:90b:2f0e:b0:2ea:59e3:2d2e with SMTP id
 98e67ed59e1d1-2f548eb9e0emr14161300a91.10.1736479645509; Thu, 09 Jan 2025
 19:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com> <20250109-tun-v2-3-388d7d5a287a@daynix.com>
In-Reply-To: <20250109-tun-v2-3-388d7d5a287a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Jan 2025 11:27:13 +0800
X-Gm-Features: AbW1kvZyiy6igQIYtcT2bEIGGuMlsgd6CYsI8IZapQaNgu__KkmEtAKFahTJbko
Message-ID: <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wwVzkxeo21e29YTDEsbF84Kfxv6GnEFl8yZGmkj4JY8_1736479646
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 2:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> The specification says the device MUST set num_buffers to 1 if
> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.

Have we agreed on how to fix the spec or not?

As I replied in the spec patch, if we just remove this "MUST", it
looks like we are all fine?

Thanks

