Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A81F9D6
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4nlJEgg"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C04E83B47
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 08:29:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C04E83B47
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4nlJEgg
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5-ZdfeNC22fN
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Dec 2023 08:29:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BA0683DE2
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 08:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BA0683DE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703233749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1/Sz19OR6XWaD99Hs0XiYIWs6pPYgQ5leaKhAq6DJY=;
	b=b4nlJEggy78sDx6v1o9eyjy8xlaWS3GpPlvTg0nEjetA01XPv53lY2aQLc+KemGseARCeQ
	Ten+JzlHR7XyR8WP3+MU5ov8MFPXbzOdKvHd8o4sO+zp2WsLoRzlh3VHMv9qj4Wa7iHeyQ
	5h0hiRf89qFS83zAk2rvWn/G9You0aY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-ojMeT4xpN8OHDL7szJOYPQ-1; Fri, 22 Dec 2023 03:29:07 -0500
X-MC-Unique: ojMeT4xpN8OHDL7szJOYPQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33697cbd035so134145f8f.2
        for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 00:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703233746; x=1703838546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1/Sz19OR6XWaD99Hs0XiYIWs6pPYgQ5leaKhAq6DJY=;
        b=Hoct97ciiiN5ua5F3Kvd/EbLUxf7kIzTbKUP1jsXS3gGweHkr3f4bjJ07JtuS9aojQ
         LRoL8GQB+Au/KvD/m8ACC/2HW35gUzwoYoqavrxd9YA3MbYXEm9cqHiR8/zLjO24RSrT
         eSgqT5kFkOwoDs9r9NJOhY1bQSkoIWyXGYrI5+MzzFGkbGIr3gH7AGe25So5SuWT2FMh
         vEqzqBXH88Gb1cBI9ODV1Iz8xx+jvQGgEWztRiLUUzk1MLdKdmS1j2Um4tFCxhfDMPfX
         xqjL5s9zJu0ZGe9/7PYwIt+I8EkBS5pNtEVHElfH9Tj+HjEGernd9s+uimVnyjzMY/Dr
         O4LA==
X-Gm-Message-State: AOJu0Ywt3GYT/L1eiWjFhr1LhzAOh2MskYJZKRv9dD/J2x5PSBXM5qSw
	paMtkbDLy/7JXPcbSzE5fqqowqB9IK+92Q4s2X/Y6Hec34Q71L7NEG6rcohhbu0hzm+tPWKc2PO
	X66qzGCFQ9IYd5ts4sp8SJ10BmeRhE6rEpsLlX84MnssQw1yCeQ==
X-Received: by 2002:a05:600c:5248:b0:40d:494a:cb9 with SMTP id fc8-20020a05600c524800b0040d494a0cb9mr60316wmb.62.1703233746651;
        Fri, 22 Dec 2023 00:29:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQLIJ3jovK0TTr+qKYudLCC16A8aoY3e2L7y+gdkeb2YLR6dNadO38fME4r6D9zWksyIN5kQ==
X-Received: by 2002:a05:600c:5248:b0:40d:494a:cb9 with SMTP id fc8-20020a05600c524800b0040d494a0cb9mr60308wmb.62.1703233746369;
        Fri, 22 Dec 2023 00:29:06 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id m17-20020adffe51000000b003364a0e6983sm3731542wrs.62.2023.12.22.00.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:29:05 -0800 (PST)
Date: Fri, 22 Dec 2023 03:29:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Parav Pandit <parav@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add
 VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
Message-ID: <20231222032713-mutt-send-email-mst@kernel.org>
References: <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
 <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
 <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
 <CACGkMEuM7bXxsxHUs_SodiDQ2+akrLqqzWZBJSZEcnMASUkb+g@mail.gmail.com>
 <CAJaqyWeBVVcTZEzZK=63Ymk85wnRFd+_wK56UfEHNXBH-qy1Zg@mail.gmail.com>
 <70adc734331c1289dceb3bcdc991f3da7e4db2f0.camel@nvidia.com>
 <CAJaqyWeUHiZXMFkNBpinCsJAXojtPkGz+SjzUNDPx5W=qqON1w@mail.gmail.com>
 <c03eb2bb3ad76e28be2bb9b9e4dee4c3bc062ea7.camel@nvidia.com>
 <CAJaqyWevZX5TKpaLiJwu2nD7PHFsHg+TEZ=iPdWvrH4jyPV+cA@mail.gmail.com>
 <17abeefd02c843cddf64efbeadde49ad15c365a1.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <17abeefd02c843cddf64efbeadde49ad15c365a1.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 03:07:22PM +0000, Dragos Tatulea wrote:
> > > > In that case you're right, we don't need feature flags. But I think it
> > > > would be great to also move the error return in case userspace tries
> > > > to modify vq parameters out of suspend state.
> > > > 
> > > On the driver side or on the core side?
> > > 
> > 
> > Core side.
> > 
> Checking my understanding: instead of the feature flags there would be a check
> (for .set_vq_addr and .set_vq_state) to return an error if they are called under
> DRIVER_OK and not suspended state?

Yea this looks much saner, if we start adding feature flags for
each OPERATION_X_LEGAL_IN_STATE_Y then we will end up with N^2
feature bits which is not reasonable.

-- 
MST

