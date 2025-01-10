Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5C204F66
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508762; cv=none; b=JvFsSb9E4jgHEmxVv6yU5s+QUx4DVbN24OnUEvp9cxY6l92eiluxPN8Z6i/jI614xPD+LJ4QEnwYsp2dltUI2fTlfQ6fnFweJVwMqozysyPXe6iLqmyaSTLhFtqxGFd+bGw5KUS1Y5cT6F7ldbvUwkOF6VYokLHXVCDRyTcFTE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508762; c=relaxed/simple;
	bh=yLRKiodCpUEkNU747JZ4PBw6mzhLuN0TGC+xkk8hayA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XTLdnpfGyxakanOhi2DV2H60CVzk0xTiFCre+fIJD3TBw4KckTyjbJMFXAeyL4gVlavAZGt73V9TiAZmRnn4L+eN0JFmlZUxlEZ7ZoW+PtdvBiMCXuXaPTVsUih4dfJZhZ9DLvAsD2+oUKjroKqYrvRVOdBTrlytaYI1A9EsXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAhZjg02; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAhZjg02"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9A6E40FA4
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 11:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPrtE0yZ1Z_R for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 11:32:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B94B540B35
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B94B540B35
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aAhZjg02
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B94B540B35
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 11:32:39 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-467a3c85e11so11416401cf.2
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736508758; x=1737113558; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj5hzhLDurnV0Uikx72ybZP+UMepormLzXbaIUCT51w=;
        b=aAhZjg027UjMgiajFA3hfsKfrqLAKUHIUS6I0GD7lztC5B25NAF0GYdy8FRNppI6MZ
         KGG+UwFlJPeOo+fYOe/Hr+iHVY2VPI3A6xSShhHQLwgQoRg5I1hyeaOtmt+0Wyv6+Q4l
         oT1jmrNQKI/0/MdlVaUE/ZmbqLZKC6PW+j4ddX7+V99JBoZdFa9jbxLukqw13JdwxPID
         H2bLQLvkVbjvrsDj9aAxrgZ20VHonfIftorvc44Fa+Jq96IkqVfpdb6nv1AYDOx3uqIu
         /MlXfsxMqHYbrpmPe1EU2yQ3K8Tn5EDhAnwg3MrHM8t5xFVvGyd9JoS/yf11QLAcdfhe
         43bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736508758; x=1737113558;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bj5hzhLDurnV0Uikx72ybZP+UMepormLzXbaIUCT51w=;
        b=TvxMOu9EWAEoE2g4CWb2iyqmK79Vbatk43UPsDaQJk1Vp93xs6wgQ3MN3cqrvpdFtW
         UDWbOx6Dbc+50NJdPvNJmPKDzlrw8sLBmpR4zR+qYG1co7ZkOSJFqe27GraAFxIuyLXD
         ZWrf0OokaFzosyE+PWylscyBWP7nzAGD485r22aFbaoRdpLOEMKVVGW5ABGFkAHSvgfv
         WX+sjuRXIPfvi680ogc0Z+smhrbgx1ceelLr3dye7dviuIeU1XhVrrKNfpY5sEmtfZbK
         4ZF97Sg16QTuAGffojmg/3o+7S/WeWJTtockLv/W43wNS3kYPT9xZ/CsKR7fmrdbPed3
         5MCA==
X-Forwarded-Encrypted: i=1; AJvYcCUa6UmolG3dRWZRYCXgjsJU2QqwrZGP+di9+jBu/2oApGlHa7SDVpRf0O1SjmlESrkDo9bCf3ZpWRXR8nm6Jw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw5zBgFE4Enuuyhi/VlhwoQ5iKETCxakwfCWSyJsh7RILmUcBNA
	gz/9g94sY4Qi+dqF6GWWc+KpTEc4ZwyfAmiD/Ib8rLfKK594Y8P0
X-Gm-Gg: ASbGncspNT/WgeaFuoZPdlOiC7vp3zMrI57MWkmnCmvpfKzIsz2eVZDHlC0XbKWRf+q
	yfQ7+q21yk27LYRyv4RlEdegJYBTMnlc0eZU+qMIw7rNh+jG9ynardNbuDui6J504S+rxboN4s5
	1XChNoRYmDVd6eHmFvV4V6QIlZjtfsMEqj20obX0TXaOiJ84lAihOmuyhpORn8o9s8gjfT1FyAB
	bCFBGTFFW4VIPJjZAJzUTyWl1bGzOBt+ge+3UArkOHKTdYlcDuJgcFioDYHrQMaFsUBXxUeNftn
	U++sDi40prtfXah0LHbYLn/E9VJK
X-Google-Smtp-Source: AGHT+IEAeRPcXEPZaY0ZiqE+FHD3WXuaK99GAFn6AMFjwlATA6fP06zaeLna0c3A/VPZLWprZOxVFQ==
X-Received: by 2002:a05:622a:1196:b0:468:fb3c:5e75 with SMTP id d75a77b69052e-46c710e13c5mr151993961cf.38.1736508758327;
        Fri, 10 Jan 2025 03:32:38 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873cd1b0sm8463741cf.49.2025.01.10.03.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:32:37 -0800 (PST)
Date: Fri, 10 Jan 2025 06:32:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com
Message-ID: <678105555a23f_3fe20a29440@willemb.c.googlers.com.notmuch>
In-Reply-To: <3a5001b5-9a07-4dfd-8cec-1e5f7180b88a@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
 <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
 <20250110033306-mutt-send-email-mst@kernel.org>
 <3a5001b5-9a07-4dfd-8cec-1e5f7180b88a@daynix.com>
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> On 2025/01/10 17:33, Michael S. Tsirkin wrote:
> > On Fri, Jan 10, 2025 at 01:38:06PM +0900, Akihiko Odaki wrote:
> >> On 2025/01/09 21:46, Willem de Bruijn wrote:
> >>> Akihiko Odaki wrote:
> >>>> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> >>>>> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> >>>>>> tun used to simply advance iov_iter when it needs to pad virtio header,
> >>>>>> which leaves the garbage in the buffer as is. This is especially
> >>>>>> problematic when tun starts to allow enabling the hash reporting
> >>>>>> feature; even if the feature is enabled, the packet may lack a hash
> >>>>>> value and may contain a hole in the virtio header because the packet
> >>>>>> arrived before the feature gets enabled or does not contain the
> >>>>>> header fields to be hashed. If the hole is not filled with zero, it is
> >>>>>> impossible to tell if the packet lacks a hash value.
> >>>
> >>> Zero is a valid hash value, so cannot be used as an indication that
> >>> hashing is inactive.
> >>
> >> Zeroing will initialize the hash_report field to
> >> VIRTIO_NET_HASH_REPORT_NONE, which tells it does not have a hash value.
> >>
> >>>
> >>>>>> In theory, a user of tun can fill the buffer with zero before calling
> >>>>>> read() to avoid such a problem, but leaving the garbage in the buffer is
> >>>>>> awkward anyway so fill the buffer in tun.
> >>>>>>
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>
> >>>>> But if the user did it, you have just overwritten his value,
> >>>>> did you not?
> >>>>
> >>>> Yes. but that means the user expects some part of buffer is not filled
> >>>> after read() or recvmsg(). I'm a bit worried that not filling the buffer
> >>>> may break assumptions others (especially the filesystem and socket
> >>>> infrastructures in the kernel) may have.
> >>>
> >>> If this is user memory that is ignored by the kernel, just reflected
> >>> back, then there is no need in general to zero it. There are many such
> >>> instances, also in msg_control.
> >>
> >> More specifically, is there any instance of recvmsg() implementation which
> >> returns N and does not fill the complete N bytes of msg_iter?
> > 
> > The one in tun. It was a silly idea but it has been here for years now.
> 
> Except tun. If there is such an example of recvmsg() implementation and 
> it is not accidental and people have agreed to keep it functioning, we 
> can confidently say this construct is safe without fearing pushback from 
> people maintaining filesystem/networking infrastructure. Ultimately I 
> want those people decide if this can be supported for the future or not.

It seems preferable to write a value.

Userspace should have not assumption that whatever it writes there
will be reflected unmodified. That said, that is the tiny risk of
changing this in established code.

If it worked without issue so far, without hashing, then probably the
change should only go to net-next.

As said, there are examples in msg_control. I don't immediately have
an example where this is the case in msg_data today. A search for
iov_iter_advance might show something.
