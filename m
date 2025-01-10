Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062A2080F5
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498024; cv=none; b=OE0FVFC5DrA80D3L7I3lVjzGKMngB/tC6hQDqtUVO3V9Gw+xHB1yxvu1IvDDq1rsub1WM03Ujp/LUf8F/3T4vOHuDORFumxV4hczXHS+y0tOV6ry4WBic/Xyds52CRCj+TZs4spvV4NDOj4IBpLxet2UMscXxX8IqLRQupFnR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498024; c=relaxed/simple;
	bh=jHWzqnciWVxWixyPQhRuC+28OpV2V/bBQGrWzPx3hbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=auVNq1bOeYYM01KZSzSCrHJ/cWaVw7rMhz62mFne/+nVnhzrU3E6XVbU07t8jTL6C8x6KNE0wviuKQx1DEkYsjaWaoiOHy6wKyPrFwPHnDLX/ghBLPy8AkdTvHQajzaJIcTXKpfcdGD8N16BEXlaRNKoyeoJczikDHO1agVfooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftEv9mTY; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftEv9mTY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F6E660E55
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 08:33:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e5Ni0Q_rDdVj for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 08:33:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 54D4060E56
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54D4060E56
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ftEv9mTY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 54D4060E56
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 08:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v3AxsQKFkY0E+0MZ060gdGU5E31S3yG/jY+mnuNkfgk=;
	b=ftEv9mTYws7LJlI9kXr3WgbR/ZoLzAJhKF4SxzUUXANmsfrmAAa6uCPAatbgLgW8N1YZDB
	xGKpSvFKCvXvwHiophkL8IAyCRe4wtzSzmQ4rWeGUGsEC1uGvAsg6e9ZpZci48vtuhazJT
	7JnD3i7fTJ1cgmJ9+rx1UH8VXWXUXwI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-VcnTfhsaM3CLJi9ERiRxeQ-1; Fri, 10 Jan 2025 03:33:37 -0500
X-MC-Unique: VcnTfhsaM3CLJi9ERiRxeQ-1
X-Mimecast-MFC-AGG-ID: VcnTfhsaM3CLJi9ERiRxeQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dcadffebso886990f8f.0
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 00:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498016; x=1737102816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3AxsQKFkY0E+0MZ060gdGU5E31S3yG/jY+mnuNkfgk=;
        b=ObzrAmIUCDE+uz3/GJ9foV/1mznnd01H6wyJkYz+/JYT793onzjmDCab0NO3m2+Aqm
         ygQz2YBlWzZzOfwnusLiOCQ4I63DSyZSEwCpjxQXaeSNMIiPw/b25WSZ886A1fxBB4ke
         OHzSXCf0poAgX6GGZ8JIhqb0m3UDTZFsHCbOBv6///RyW2Al5Fl+TewYIP/56wjqvqeJ
         AGqz2Hl/68x/VUUZb0xUeFu7SnowmhuPjMJ+uJIdhfg/ReId34xRYwKWKfJktOXVNdUW
         Q2X+Bs/tp2L/hYeq2+kRTcqL9a1QVXvOWlfVpt5inU35FLRjH0sW1++UhUTSuY6URB2d
         oPqg==
X-Forwarded-Encrypted: i=1; AJvYcCWx2Y9Mp0GrwuL698DOl/riDg3xOSDTIrUvp8bOq2YYVN9gOdR/enxJDgw8xKvuecbJZ842bZArgNKzi8CrqQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyE4xhDAzPkscQ4sqUjIBTQim0eb05mmhtlwr9IrhyXjFHLtd11
	1Xi2nXObfT3A/M4d4qeupD6RiiPDT0KO3xPxhVUecI0s4b/JQMB7hDtrLcBAH8tmWRbZL/LQoJe
	l5CrRjSNRwCKAfcZ2GPPtV+IbXNHPoLc9M1pGZ3qmS4v825yftJhpe2ihYiw4SVHGqqjT+cpnYI
	JaeZk=
X-Gm-Gg: ASbGncsANmn7LER2WOQJ6rC7fPN2VRBk1ybHjZK3mQjcUttOUpv14dTgsBTn3sXg3dP
	JBmbo6Arsauv4QFwZQr9xOhMrHW+IFcF/UDq/aR4P5h4WEOTlvXa7zozpEaGVfResGiJupFppfE
	vdheA9aj8z0t3Som1XTwRcDW3QnmXpY+pafG4U2a1z+SDUSKmi/GaDPNk0LA15PsdYsaF3c8sOv
	hPtJnxw/Epy5Bq8qeUUGHp9OwZPUfDmbsPcpOlFT4Lqys8CEbhR
X-Received: by 2002:a05:6000:704:b0:386:3272:ee68 with SMTP id ffacd0b85a97d-38a8730af1emr7361839f8f.28.1736498016252;
        Fri, 10 Jan 2025 00:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDkmvAzVbQy4Z1oN4ubuGOtq8JEjPwlHX/LMcj/lU9WejRkYESinAg0MOkridrYlqI4G3XFw==
X-Received: by 2002:a05:6000:704:b0:386:3272:ee68 with SMTP id ffacd0b85a97d-38a8730af1emr7361814f8f.28.1736498015919;
        Fri, 10 Jan 2025 00:33:35 -0800 (PST)
Received: from redhat.com ([2a06:c701:740d:3500:7f3a:4e66:9c0d:1416])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b82ddsm3883422f8f.71.2025.01.10.00.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:33:35 -0800 (PST)
Date: Fri, 10 Jan 2025 03:33:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20250110033306-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
 <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YtNFWCd7ogM6273R4_lhMl6fUAwNnsHUY_TCN5k9X98_1736498016
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2025 at 01:38:06PM +0900, Akihiko Odaki wrote:
> On 2025/01/09 21:46, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> > > On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> > > > On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> > > > > tun used to simply advance iov_iter when it needs to pad virtio header,
> > > > > which leaves the garbage in the buffer as is. This is especially
> > > > > problematic when tun starts to allow enabling the hash reporting
> > > > > feature; even if the feature is enabled, the packet may lack a hash
> > > > > value and may contain a hole in the virtio header because the packet
> > > > > arrived before the feature gets enabled or does not contain the
> > > > > header fields to be hashed. If the hole is not filled with zero, it is
> > > > > impossible to tell if the packet lacks a hash value.
> > 
> > Zero is a valid hash value, so cannot be used as an indication that
> > hashing is inactive.
> 
> Zeroing will initialize the hash_report field to
> VIRTIO_NET_HASH_REPORT_NONE, which tells it does not have a hash value.
> 
> > 
> > > > > In theory, a user of tun can fill the buffer with zero before calling
> > > > > read() to avoid such a problem, but leaving the garbage in the buffer is
> > > > > awkward anyway so fill the buffer in tun.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > 
> > > > But if the user did it, you have just overwritten his value,
> > > > did you not?
> > > 
> > > Yes. but that means the user expects some part of buffer is not filled
> > > after read() or recvmsg(). I'm a bit worried that not filling the buffer
> > > may break assumptions others (especially the filesystem and socket
> > > infrastructures in the kernel) may have.
> > 
> > If this is user memory that is ignored by the kernel, just reflected
> > back, then there is no need in general to zero it. There are many such
> > instances, also in msg_control.
> 
> More specifically, is there any instance of recvmsg() implementation which
> returns N and does not fill the complete N bytes of msg_iter?

The one in tun. It was a silly idea but it has been here for years now.


> > 
> > If not zeroing leads to ambiguity with the new feature, that would be
> > a reason to add it -- it is always safe to do so.
> > > If we are really confident that it will not cause problems, this
> > > behavior can be opt-in based on a flag or we can just write some
> > > documentation warning userspace programmers to initialize the buffer.

