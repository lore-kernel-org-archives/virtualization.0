Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8741C5D77
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897451; cv=none; b=pCvKyhXy+IG8wNJtFBCZr1GqhVymLpiug3lYCLVpGKgHnH/jlvt/wXfHqvGw8b/Qjn2afR26HVLSnQfS12CZh/CmJz8nzdJ3zbNVetFMlbmNu/qPSNBtxY+RVW83ofkY37bfk++JTA0cLhv1whCHI39+n/IrbNLK26AbYFDn3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897451; c=relaxed/simple;
	bh=ZLYIvEVdYFtaxQbaBOf6ThGMjn/MwBnMXEGHzdAzS1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=O5cOfu0lkNfM+kQvVK7CQZuGHLiC/7mW7KEb81KpKyR/ogKlo0+Q0lI/roquhj/TulK+4eqAYKKO1y/uCPBq76IWyTsM1PSehod3sFVPUMGPiQxN/lECppQfV72HSA3TF4GFgmcoyv9IGr6SYIV9HzB7sxpSjaags9c1Q1X1dxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJBXES1L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJBXES1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758897448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNHZdA2ynNJGHBH8wutoba5JHt6T91gjLDofejClBRE=;
	b=bJBXES1LIw1pCAGp8bBrtls/UXkazCEVcLoM3PK4wVVC1swlcZY4RyaYCps2CoMQF1Yr2P
	XqHZYJGB3S2X0wCAaBMbZ0knfxFNDQVq57rFVtwASR0A4K4dTQVFSbjbisI4DvoOCCSZvH
	TxWffQs0IbLKy6FsTgLNZf7Im8Jb9V4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-4OUUogzAPzWd1UGrNZOqrQ-1; Fri, 26 Sep 2025 10:37:25 -0400
X-MC-Unique: 4OUUogzAPzWd1UGrNZOqrQ-1
X-Mimecast-MFC-AGG-ID: 4OUUogzAPzWd1UGrNZOqrQ_1758897444
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f3787688b0so1149353f8f.0
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 07:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897444; x=1759502244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNHZdA2ynNJGHBH8wutoba5JHt6T91gjLDofejClBRE=;
        b=F8XwVa+fwRv3RE1B8qfUbaa6RII8pIMaaO8ZgxaTW7jLwNq6C8ITg5pdl7862olD+K
         F2bU324f60Qg8RPr1M5CJK2uV16rXubtgGaToBYgLnW+ByjfBKSTv8ldg5IL613H7Sdi
         9mquhYy95e+lspaWaSbw8Gn8GsPKEvWSrMs3CCKKFXxeNnlartaOlbNiHrAWcsy4BUTh
         7H41h7hBsdQHcxDEFQu8BhEunnqjws/zfKtGYGavXCODOZ7bKyU1jr0zb/RkViyURDmh
         +Jp7GZk874PzSZlxOY5hMa8P1jRnCq6GIx7O1Gn9hkrfwNMjlTUcbH6HfRi+ENJ6TKe9
         +W5A==
X-Forwarded-Encrypted: i=1; AJvYcCW5gkVZTTT5//vlGNKg51tdLPMRlHDKjcW50B/7MR01qCL75EnG5msXv3h9vKwXqH3j+SWb4HLsNxf0lCw1pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrEGgAZgGwHXl3w/jAyBOyKKhrVx9c/saoEWEDweep2IRLIUpE
	EQspJTR0uUnZrS+zzRxN2VhVs/ios5AQ5g+tDKReBfDgxoXY76NrL/lCFkMpdk5nt8ixY4jTYcX
	2pwF9hN7pn9sCSTbNynpkLGvmcmLxYX+o4Ua/SzJN1ZVNsqeg7WVz52a3QvnnE8RInnhN
X-Gm-Gg: ASbGnct1nbGGhhsE68ga9BgJUyRrYOSM9bS1fKogepMzGe9LL6PTTh82HkQm+5yL7Aj
	iBxqJdIEpp+tcAOOM2C18JlK45Sk9AKWl3BFwNQFib+Ei79AO22+xYmLkBUjT9Q+P1WATOgl3cy
	VU4e4TP63G225zDAF15ZodPuJGpcm4WLsvOVQZW25PZHMVk85U06Asi1fY6Qf5gvpNiKe+DgEmF
	+WgVnkf0yVEnewPbc4KWgqJgyBTARskdcSK1ofLj+bfsTULOce1JikGT4l36/2x92mviYoe+6+W
	i58Ug0hh91fvdERfWalf4aSIHJLHvQDyQho=
X-Received: by 2002:a05:6000:1869:b0:3e8:94d3:766b with SMTP id ffacd0b85a97d-40e468e73c8mr6983292f8f.1.1758897444342;
        Fri, 26 Sep 2025 07:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXwmeHtQqcwnjJIme2wTxfCuczMPQ8tCMq+UMmG5Eh2oYtKsbn0VPkmA3WWKpKwuGGfPj1GA==
X-Received: by 2002:a05:6000:1869:b0:3e8:94d3:766b with SMTP id ffacd0b85a97d-40e468e73c8mr6983257f8f.1.1758897443747;
        Fri, 26 Sep 2025 07:37:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf6ecbsm82911155e9.22.2025.09.26.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:37:23 -0700 (PDT)
Date: Fri, 26 Sep 2025 10:37:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 0/6] Add multiple address spaces support to VDUSE
Message-ID: <20250926103421-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250926101432.2251301-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dMRZt3bmDl87uYiohqlJbIbJbJcjV7urf5cq2-MPQkw_1758897444
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 26, 2025 at 12:14:26PM +0200, Eugenio Pérez wrote:
> PATCH v5:
> * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
>   ioctl (Jason).

???

I think copy_to_user returns an unsigned value: the number of bytes copied.


static __always_inline unsigned long __must_check
copy_from_user(void *to, const void __user *from, unsigned long n)
{
        if (!check_copy_size(to, n, false))
                return n;
#ifdef INLINE_COPY_FROM_USER
        return _inline_copy_from_user(to, from, n);
#else
        return _copy_from_user(to, from, n);
#endif
}


so, how does the patch work then?

-- 
MST

