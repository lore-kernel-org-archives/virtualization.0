Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF8205E2E
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479676; cv=none; b=YixhXCzUdrebTSqp9Cn7Y+v5xJvHDrwn6CyG4oIKXkWHT6m2boqMXJded5CaSEFWb8YssXM9UUgZ4HV4znFPP3yZ8+8anl47VeFx/b5vodKyhSpkIDegS/khXRI/v31sTSO/Rcd/rDW/xDhM/yUroaX92B1wYfa/dWYVDLL3lc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479676; c=relaxed/simple;
	bh=bvWTIT+RRjRSbxQiao2G4A++ngFStBHKJpnvXhynHk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gABhidL6bFtKcySDrbgyTMnF3Ff5Q7mx9Dr4vPMYGq4zCw8To4BDte2Z73rip2Nme+kg1DmCmlWHjZfQQR7IiTBitgFvj+m6GOezZxHL+EvNAy+29XghxX/X7AhUt0JKtvyyib0B54LQJZLlMPLf3ypD4RjH4wWEq0l9GA/qHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC20kvAB; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC20kvAB"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AA7760796
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:27:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NCp1LFY3RT58 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 03:27:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 848246070E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 848246070E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PC20kvAB
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 848246070E
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736479671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iajL1yDgIUIr5hibojx7mafI5SxR1wepNTMSNzOVtuU=;
	b=PC20kvABsfvfy6Z/+muDX++E9b5N9/eSCbhahHRjoP9miPSAKLG4GFtkR57RMk43jNfWWT
	GmYvdo51Hj7YPd/Ya5SvNMrNJlnohyESVcOzL9rgibiLZMReJKqoiz5R0wA83FQyxciYE3
	MUF+0TDS2mgByOh8EW/5A45JP/fkpCg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-iDEbaBpoPLyKyQzPnaHRKg-1; Thu, 09 Jan 2025 22:27:49 -0500
X-MC-Unique: iDEbaBpoPLyKyQzPnaHRKg-1
X-Mimecast-MFC-AGG-ID: iDEbaBpoPLyKyQzPnaHRKg
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso3014811a91.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 19:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736479668; x=1737084468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iajL1yDgIUIr5hibojx7mafI5SxR1wepNTMSNzOVtuU=;
        b=ls6TTZGiSQCbVXwjF0WSmrXDQR3KOkCMDMMUu4xEiz5z3YVoVvNDYrW1mvot5ry9pJ
         9llB7UpqCeSgL+32J5cI3KF+JB/qXsmQ8VvLJYDYqOTAwqBmfj9XUgxQYc72SHHJtre0
         EL9pzVi5W0RwHdLVR99dzMpUZKas+f/k8q39P5WsLhDsobCQPTjUJB+CVuoJ+sXdy3vM
         W5U9Mn3u9884OLlFez5nwFbSsz+xfEt/OrpYgVE9SgF6Czhn6C/rMK54cTVtT0+jjQas
         f6SLEpknZiRzvNOz6nTLJ5EoP2lirWpzEOb8AdaCjOUFZt1FDEiYRzDLFCQVL08rMuIw
         e1tA==
X-Forwarded-Encrypted: i=1; AJvYcCXB4s5TuA2/EgfQZeA7ozgByX3KWWF7p9NB+tEtUW2b5rnHiCmFzluXLM3xpQurEsbaJn/AHbrIZi+jMRqSeA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwB2IEIjfMjvC1se1nwUSC8DD+29RI5IVmuKpqwXngXw9Zel3Ws
	GfnKFGbnjFRUxW0kZ2/fIjEZ9GvF/1h6TXhPhOSNhgUzb/Qe3ZdTCdGyOnphT+CxHp9kyiQQJ9M
	f2ScD0yoqWRSG64U9GMm5eBvuALWMIHiJl1P8ds3RsStP/R4GPv2T16vuX6lY3xEPjTMgUAwWw3
	/yi43v+S8dZZKwg0qB+U3CLdoucEvDWUE8gvndD3/r4KwZcvjhxZZrbg==
X-Gm-Gg: ASbGncsf0HUNhyY08Vs3dD+VGhEDh4dOCunYKkE5XpkgcvDYK7Q22iMttiB6DgtQCW+
	OuKPp4WLd5ec3970IFVOD5Gb0tob1FY8kiuNZxMA=
X-Received: by 2002:a17:90b:2f4e:b0:2ee:f550:3848 with SMTP id 98e67ed59e1d1-2f548e98ea9mr13264771a91.5.1736479668662;
        Thu, 09 Jan 2025 19:27:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM0zVlBA7j66fikaniieFtidBDy2a+ngdaxzHXHvpNz92dgP0y0YBOPXi63aR37F36fwt1W0RporavDwFYaFI=
X-Received: by 2002:a17:90b:2f4e:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-2f548e98ea9mr13264741a91.5.1736479668256; Thu, 09 Jan 2025
 19:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com> <20250109-tun-v2-2-388d7d5a287a@daynix.com>
In-Reply-To: <20250109-tun-v2-2-388d7d5a287a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Jan 2025 11:27:23 +0800
X-Gm-Features: AbW1kvblvM77hJwOCPbcZnQaLsOAKege2X0nqRs93PNDqFsP8xaZKCI_l-JSk84
Message-ID: <CACGkMEs73Pms5FB3ouzrLsDjAsQ4OhMMDVD2LnO6kVHCsN0A0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
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
X-Mimecast-MFC-PROC-ID: 9zcy7KU0iv0N2DEZz8LmY1ibSQXECXDrp33vwQfjvGE_1736479669
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 2:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> tun used to simply advance iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This is especially
> problematic when tun starts to allow enabling the hash reporting
> feature; even if the feature is enabled, the packet may lack a hash
> value and may contain a hole in the virtio header because the packet
> arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.

I'm not sure I will get here, could we do this in the series of hash report=
ing?

>
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tun_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> index fe842df9e9ef..ffb2186facd3 100644
> --- a/drivers/net/tun_vnet.c
> +++ b/drivers/net/tun_vnet.c
> @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>         if (copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof(*hdr))
>                 return -EFAULT;
>
> -       iov_iter_advance(iter, sz - sizeof(*hdr));
> +       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*hdr)=
)
> +               return -EFAULT;
>
>         return 0;

There're various callers of iov_iter_advance(), do we need to fix them all?

Thanks

>  }

>
> --
> 2.47.1
>

