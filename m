Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5FD71750
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109704; cv=none; b=UFS3B4ZoHidOC5vvFD8fcIsRi/I3ssVdBTiaMSr77OKLfbXzN+qej2PEnh+o1FVw7OXVh6Fv/KDQMry44DehlYHleBpgHWE3ZTOBJcQNwr/SW7U8Nx9UnouO0BTMdKtM8LZMLFCHmj2qhELDOoAtFLmqa61JIw4pODIIM0/gfE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109704; c=relaxed/simple;
	bh=kkoEmAYe2SZLE+qbTYdKkQHJdK3eWyXaa+xFMCTKA9o=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FoQbTDZ2FFvT2di2tHQY7KSVBdbBVTL05WIyotzRGdVoBjev4+rqB0ofEntb1xwsNQXPRs2HcLYwVIIE6ex37OgFkU3vJgipEDghrzpQ0O/0qTJBBH0WXBerbAcEPSqVLdPFqLEmNvjChHnp90yBZw6zYCFsgalgxlBPaebeVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K066PRga; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K066PRga"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77B02409C1
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7JEEwBCqiVM1 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 10:28:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 454D6409C9
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 454D6409C9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K066PRga
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 454D6409C9
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:28:21 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7b9ad0e84e6so212193685a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 02:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737109700; x=1737714500; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYXgLu2ectYIWcNrQyXJcEHx/eKfm/mDV/W/h+cCuZM=;
        b=K066PRgaotLQHFgIaznxzmQoSYBs7snPLs6wMS0vDOBObCjG6iXylHJk/ftryjQ0Nv
         4suAzamdcF8sVVyUOCLFWwPJeG2eDkLAbph6kxSTiLhMYPyuVMh2yOyxxaEMLxKk9KpA
         1z6s9CU+TgbcvVE3+7LdhCw5hFMwDz+z7ebMiDmLkJLsz3NEHwLezsV+/LXSWJEUo7co
         E2hlwZ0gn3/Y3uH/9P6TuHCTU7c3Sx4ZobwxhQnGQ/1Dun2wfWHNaovTbGZHzzmqGWGs
         O6zTUBUFxd3BfN70mj3Czsn2KijerxElkimlvcVQ8nqDo57jFU8yntKCRks/iJy6ytcF
         XJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737109700; x=1737714500;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYXgLu2ectYIWcNrQyXJcEHx/eKfm/mDV/W/h+cCuZM=;
        b=tyjA9DWOLDCqJJchmE5VesNz+5mLkcJzDI4i2XSSDqjn/eTkCLLK/V117klkCiCbBJ
         L4zDaM2Mfyj6Wrm8fHKS8e+UbAyOO/JHvDoIUh255LMvJrybrLmW5AwIyHdG6rzMN49F
         WXJaBkXGh7pmdAOt5r2NQ6js8TZgRc+nHMfSuVn9i3JRyrzpyasd7YrPHo1UqGZGw/gl
         eMO5BDYbGdHI5lE8mA7Mjf9xfZQHxXHR/RUaTII9yD23ZbIBVtqUS3i+xGfw3LTU+nRH
         79gqaKX9X/O3NLM8U6oSfRPca4AUW2/bAKtMk9P922lgM+Rb6QgDiu6BS8qdE+0D5fQO
         zRhg==
X-Forwarded-Encrypted: i=1; AJvYcCWvLI6zNCR3GwcnTQhWoz9FjXLS5jxiWMOumjmbxhYkEnU3fgxe8HnSjX+zc/berOvVl8AoTFSIsOlSZPqSgw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzcRGpstf1DW5D6M8jYl26PR1dbOJqJFmhp5EVP1YJ33iglnGBV
	pmSiaH3EerA1+rcJOUdkFRE+8Vsoq85AnVlUXtXZ3JZzI6EJ9lFH
X-Gm-Gg: ASbGncvM0738wjpTbCdKUGY27LZfXVcqxDALC4MURUznuIYfkqNZhQmgMzFkvbNofcx
	Grs27Sqqx9aaHASoB3xMPSfaQ7oej5OWhnwbaeQibKvtFIlo5kCkYqUb4V0DWPG4XTyyGm4ppIQ
	p/AYU2CQ3oPEkmqMha++UN+Rc5a5q9v8QndeZX7yUDpHnLS5PgNjkvqk5RFLLlopD328E9ZFnB/
	sh4vtwuzXcvDpwyq9T65gYSMCk3zWJfd6KyzdbG2KGkpCa1H0timC47XWVSvpdTKEJExfGg1ZMG
	yalzbMf7sEiKRQlYacT7Eco6dxFq
X-Google-Smtp-Source: AGHT+IFObFBUXDtDYfekB0QfBszL3tBkMMYxZKYT1erZOVR7bhzQHoC9ZWEDJqk6RDdXdB+0ChWnqw==
X-Received: by 2002:a05:620a:4502:b0:7a9:c129:5da7 with SMTP id af79cd13be357-7be6320be98mr319611385a.29.1737109699851;
        Fri, 17 Jan 2025 02:28:19 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614743easm101344385a.24.2025.01.17.02.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:28:19 -0800 (PST)
Date: Fri, 17 Jan 2025 05:28:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
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
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <678a30c2df05f_3ef8eb29481@willemb.c.googlers.com.notmuch>
In-Reply-To: <678a1fd7d7c85_3e503c29449@willemb.c.googlers.com.notmuch>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-4-c6b2871e97f7@daynix.com>
 <678a1fd7d7c85_3e503c29449@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v3 4/9] tun: Decouple vnet from tun_struct
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Akihiko Odaki wrote:
> > Decouple vnet-related functions from tun_struct so that we can reuse
> > them for tap in the future.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  drivers/net/tun.c | 53 +++++++++++++++++++++++++++--------------------------
> >  1 file changed, 27 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index ec56ac865848..add09dfdada5 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -298,16 +298,16 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
> >  	return tfile->napi_frags_enabled;
> >  }
> >  
> > -static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
> > +static inline bool tun_legacy_is_little_endian(unsigned int flags)
> >  {
> >  	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> > -		 (tun->flags & TUN_VNET_BE)) &&
> > +		 (flags & TUN_VNET_BE)) &&
> >  		virtio_legacy_is_little_endian();
> >  }
> >  
> > -static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
> > +static long tun_get_vnet_be(unsigned int flags, int __user *argp)
> >  {
> > -	int be = !!(tun->flags & TUN_VNET_BE);
> > +	int be = !!(flags & TUN_VNET_BE);
> >  
> >  	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
> >  		return -EINVAL;
> > @@ -318,7 +318,7 @@ static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
> >  	return 0;
> >  }
> >  
> > -static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
> > +static long tun_set_vnet_be(unsigned int *flags, int __user *argp)
> >  {
> >  	int be;
> >  
> > @@ -329,27 +329,26 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
> >  		return -EFAULT;
> >  
> >  	if (be)
> > -		tun->flags |= TUN_VNET_BE;
> > +		*flags |= TUN_VNET_BE;
> >  	else
> > -		tun->flags &= ~TUN_VNET_BE;
> > +		*flags &= ~TUN_VNET_BE;
> >  
> >  	return 0;
> >  }
> >  
> > -static inline bool tun_is_little_endian(struct tun_struct *tun)
> > +static inline bool tun_is_little_endian(unsigned int flags)
> >  {
> > -	return tun->flags & TUN_VNET_LE ||
> > -		tun_legacy_is_little_endian(tun);
> > +	return flags & TUN_VNET_LE || tun_legacy_is_little_endian(flags);
> >  }
> >  
> > -static inline u16 tun16_to_cpu(struct tun_struct *tun, __virtio16 val)
> > +static inline u16 tun16_to_cpu(unsigned int flags, __virtio16 val)
> >  {
> > -	return __virtio16_to_cpu(tun_is_little_endian(tun), val);
> > +	return __virtio16_to_cpu(tun_is_little_endian(flags), val);
> >  }
> >  
> > -static inline __virtio16 cpu_to_tun16(struct tun_struct *tun, u16 val)
> > +static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
> >  {
> > -	return __cpu_to_virtio16(tun_is_little_endian(tun), val);
> > +	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
> >  }
> >  
> >  static inline u32 tun_hashfn(u32 rxhash)
> > @@ -1764,6 +1763,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> >  
> >  	if (tun->flags & IFF_VNET_HDR) {
> >  		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> > +		int flags = tun->flags;
> 
> Here and elsewhere: instead of passing around and repeatedly parsing
> flags, have a variable is_little_endian (or is_le)?

I guess this will not work everywhere, because endianness is not a
boolean flag.. Code checks both TUN_VNET_LE and TUN_VNET_BE.
