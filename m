Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E01EB9ED
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041123; cv=none; b=tGBWgIRrYKhIEsykYQP2q4DWjSq69h6Ij2H5xRTACj+m+tHOP49uJQ/y/n1DRQnZ3+A50tIEUZT3aB0eVvbQGaquYumuPTz8t+O7q6Q79/qxMyUWLydt2SohmKF8g/wcwnOM7MhbwoiNmuxBuZp+VLPjNKzDl4YN90kZNCKVvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041123; c=relaxed/simple;
	bh=0SHhfqD/vA4cGXP3SZz7IhYLrGj9qnR4GeFeMVjfvsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UlfEfu9+ihIDjhBCzqdU1LLnL2Zas/wBHDb+9sCLvORC+0soHrpjSosYmF2WwOo4g2c4rw4XwjCIJ80k74n3uN/+kGnM+aN9Wlut9s8rwELWCjYYtTyhGySmnMipmnIGHHthgDztrPL/WaChwbRlw+P47xNOZlmGQEsV7BiTmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDKSYMxr; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDKSYMxr"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 854B940E5C
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 08:45:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R6SjZT2w4fyO for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Feb 2025 08:45:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5D66240E36
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D66240E36
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HDKSYMxr
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D66240E36
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740041119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QowQNzpCtCsCtxr+X2Hdu42nsXJZ78IqGs75xqGcCm4=;
	b=HDKSYMxrL8zXxl/Ph5nORd77ppKkIQX5WuXnf7idofE1RO7wFTKfRWyK/1qiMNu0M/auzj
	R2SX5X9PMHqYakbhVf2C8AgL3rYTqZfxaEERvQCxgJmyPjsXrsjmjCeTJW2IExefwQYHZi
	L9eEJNrdn+NpxAVhWkWmfqKLNuBNPNA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-qZNbJlTYMJiMlTNhnd5K2g-1; Thu, 20 Feb 2025 03:45:17 -0500
X-MC-Unique: qZNbJlTYMJiMlTNhnd5K2g-1
X-Mimecast-MFC-AGG-ID: qZNbJlTYMJiMlTNhnd5K2g_1740041117
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abb82ed9393so82229066b.3
        for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 00:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041117; x=1740645917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QowQNzpCtCsCtxr+X2Hdu42nsXJZ78IqGs75xqGcCm4=;
        b=jlcLOQ9PTdbW3u+C0sNPWkZsnp8Wk4DEg842RfwCFHuerok4ldKU2oV0fhsIrer4Me
         GZFZ+fAXCq9IRyrBRZHAgqjsQBY0yuFbWwQs9EdQcraJhdNZRlXeMmM+iSncFM/Iznf1
         xaW60OlyXEp/4XSUn7iKtF6WLkvOxD1+KpBS8uiIko79LKTw6WKTrRmbmOIgGBHsvjit
         lZ27w4tJsHdU8XzMIz71GdkvTIGDLxxri7dZBLFVW/BIDEnRLctXzftkdnGHWV5qx3Tw
         7/9igSvbuFu5sCrsyRwWzbbPHcevugta9TqCYJ/z4fB5IS4MdNef8H7YD5Mc9+fQ5PgV
         a8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVERxvWrC2oG/P/wwU0fOxrxwCPqLABC+UA7DKUP4dgQihkV7X+1f2SiDfEGzn5aKYUT24i01t7iYnmZNVrOw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz3CJCYmvDlJ5cME38fI9arO2bP+zjV0FjgPa2PJ1CPiAxHvqv6
	UZ5AhBKUEMxVWZpBD/B48aELAfDIsMZF2QPWod3ocduzdw9kKxyrwZEqQbmcn3QgRdAYIFDysXg
	EPOiD4HEkWPJn+W1BV2vbylaJaVn4GAFRQCLXqbAk+usBDO7G5RKz6v4ZuNEPmZPBQQeg64ZDLm
	DVmmY=
X-Gm-Gg: ASbGnctc6jLs4Bg/OE7AVKAI9DXaZ+VyrD/k7HBbr/niTXQRbnZTMbfb2ysyy58Ys2q
	STDixQjq9WfT8BOraiek/JNzr4wCB9kzx74DCFudHoc5gW/Y6xqRHrUyrKPCtD2JAEYytk49TpO
	7+rc9M/UWgZa8NgwAKt5/K+FghryB+TyzkSg6TkSRHDMXknUlTK4F3vfaQB7IYyJ3/QXB2yi7Vv
	8SIbVHsDs7yAoJUcGHaHgKwk6XWMFaT30tYVPG4SrUhEKKodemuw5DTMWtQIl31uUDdyA==
X-Received: by 2002:a17:906:f5a2:b0:ab7:e3cb:ca81 with SMTP id a640c23a62f3a-abbcce2dce7mr658328966b.30.1740041116661;
        Thu, 20 Feb 2025 00:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3dogKAU3XJfB97xx6QDkV7Yj2gPqLTO6qgUQYyB3pQmxLIK3jEJkScPsnctuvKKAeoojJDg==
X-Received: by 2002:a17:906:f5a2:b0:ab7:e3cb:ca81 with SMTP id a640c23a62f3a-abbcce2dce7mr658325866b.30.1740041116195;
        Thu, 20 Feb 2025 00:45:16 -0800 (PST)
Received: from redhat.com ([2.55.163.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9bc1c667sm731938266b.131.2025.02.20.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:45:15 -0800 (PST)
Date: Thu, 20 Feb 2025 03:45:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
Message-ID: <20250220034042-mutt-send-email-mst@kernel.org>
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
 <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iRTUgUbeKXoDQhisBkJT-6ypVVgcFjeEo-kaZcDBiJg_1740041117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2025 at 08:58:38AM +0100, Paolo Abeni wrote:
> Hi,
> 
> On 2/15/25 7:04 AM, Akihiko Odaki wrote:
> > tun simply advances iov_iter when it needs to pad virtio header,
> > which leaves the garbage in the buffer as is. This will become
> > especially problematic when tun starts to allow enabling the hash
> > reporting feature; even if the feature is enabled, the packet may lack a
> > hash value and may contain a hole in the virtio header because the
> > packet arrived before the feature gets enabled or does not contain the
> > header fields to be hashed. If the hole is not filled with zero, it is
> > impossible to tell if the packet lacks a hash value.
> 
> Should virtio starting sending packets only after feature negotiation?
> In other words, can the above happen without another bug somewhere else?


Not if this is connected with a guest with the standard virtio driver, no.
The issue is that tun has no concept of feature negotiation,
and we don't know who uses the vnet header feature, or why.

> I guess the following question is mostly for Jason and Michael: could be
> possible (/would it make any sense) to use a virtio_net_hdr `flags` bit
> to explicitly signal the hash fields presence? i.e. making the actual
> virtio_net_hdr size 'dynamic'.

But it is dynamic - that is why we have TUNSETVNETHDRSZ.



> > In theory, a user of tun can fill the buffer with zero before calling
> > read() to avoid such a problem, but leaving the garbage in the buffer is
> > awkward anyway so replace advancing the iterator with writing zeros.
> > 
> > A user might have initialized the buffer to some non-zero value,
> > expecting tun to skip writing it. As this was never a documented
> > feature, this seems unlikely.
> > 
> > The overhead of filling the hole in the header is negligible when the
> > header size is specified according to the specification as doing so will
> > not make another cache line dirty under a reasonable assumption. Below
> > is a proof of this statement:
> > 
> > The first 10 bytes of the header is always written and tun also writes
> > the packet itself immediately after the 
> > packet unless the packet is
> 
>  ^^^^^ this possibly should be 'virtio header'. Otherwise the sentence
> is hard to follow for me.
> 
> > empty. This makes a hole between these writes whose size is: sz - 10
> > where sz is the specified header size.
> > 
> > Therefore, we will never make another cache line dirty when:
> > sz < L1_CACHE_BYTES + 10
> > where L1_CACHE_BYTES is the cache line size. Assuming
> > L1_CACHE_BYTES >= 16, this inequation holds when: sz < 26.
> > 
> > sz <= 20 according to the current specification so we even have a
> > margin of 5 bytes in case that the header size grows in a future version
> > of the specification.
> 
> FTR, the upcoming GSO over UDP tunnel support will add other 4 bytes to
> the header. but that will still fit the given boundary.
> 
> /P

