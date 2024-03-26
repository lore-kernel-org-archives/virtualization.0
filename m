Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225D313E03C
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494903; cv=none; b=EpV6kjdF7J3DTtU9YjAVwOpUNhce4nruN13xmVSWWtBOx5SEYbtz+7d47xr1MmwBFS+MIBNe9bgR/Vt+jhGQeG6AI6W2Hh6sDYIkwjmSb67i6tdITLpcMYneGdwyJQEggx1iK7Jb9uwZ4TCGu+VjH1S3OSNqXuqwTanrgvKGPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494903; c=relaxed/simple;
	bh=gSKaYFfv4cMNoB/Xn0Tfp61c93C2qN7CcfMYY8i+xOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usNJ2V1ULRN5NenDOxImnwcnzRQW1VbUlJd5R3ULKgVuGw6jgupF/9o6oPSwGjUlK0NYZgvDZ/DdA6bqdDDjcdmf14qINk3L96QzzagxSzB63UAcXh7u0gLuhpLgS6Z0YDkILiIWn9ccU+voqGaRxGQjUw4grvLFU66JkXgryhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SezgEI9o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SezgEI9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711494899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mQCN5HobjN2Q/dtCo4+7FNCVXz9DGDP5AkWFtGzZjc=;
	b=SezgEI9otM7MOqkq3QMijSGK9QdaTG3NiqSUoaudrF8U3o2/tea33GLGONoM4ugfqsbZ8K
	YNoaZJBfhf9CNEOXH7IwCQ3iFJnEfdxdTzjsAyTusGky49HRnkVQfGMgVWYuELffgeW6oA
	70rVd1fYPPtA1WlFBHk6b9j+Ut+7DgM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-SoPIaiO8O8mw0grVfkltiQ-1; Tue, 26 Mar 2024 19:14:58 -0400
X-MC-Unique: SoPIaiO8O8mw0grVfkltiQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29dfc072e95so4535599a91.3
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 16:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494897; x=1712099697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mQCN5HobjN2Q/dtCo4+7FNCVXz9DGDP5AkWFtGzZjc=;
        b=ESJwDexfP4gEpz4fM9C+jd+m+x2rQYZ4Oj3G8rVgW0g5RYyrlCrNUD1P4NmVrFMeCl
         UOZKjUrTzAyD35AGwimHvFAR4Uc896WckDLTmvNPlB8EgJxXlCSwi/xBVZJMg5aAaurl
         brXoWRNnE8ixVDTSPXPz6L0OsXmPleuL7t19ZHn3upIC0Djh5YIy6+zSH+xLbO9l7AcJ
         xupvOkNZMPKXsnc/Ee/x3zXoL7IS3jUPUknNEi+n6q6Z0Q8RRSS8IrBNiJ+Kj2w7p4TZ
         p4c2gnB1Gr8gBOaf7qoWQ/lEIxAn2+Nwt83Xhy3P7/69FIIHPuGWoytl0Y6eApZjoNI6
         fhNA==
X-Forwarded-Encrypted: i=1; AJvYcCXK1byo96mq412YFEQBoHKYHtBhWfNe9o81AhBpdT7Q9oHBJ7DAZtjGeM/rhVHO5+7kFWXpNdYIyh1vx9d2V2+Qo+h7h2M4z4ApgEet90U=
X-Gm-Message-State: AOJu0YxtakkSLlWSy91KFWLCUczrTBSThGw22rWvCopOSY6UuTTYEGVS
	j8p6fhTTlkf5rbhpHwCHD+K3dQ1LfmOxqRN5PCQYmhoOALvi0EKJUTwMo/uo4rRmImTyzaKfvnz
	IaQju1wQpC/ctstYCz3AFM4srxTuV/6SHujRF2XP07kf2fz4uVEDUZzBtdS1Gzpe5
X-Received: by 2002:a17:90a:9606:b0:2a0:50ce:aa95 with SMTP id v6-20020a17090a960600b002a050ceaa95mr8314396pjo.21.1711494897369;
        Tue, 26 Mar 2024 16:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaigOMr/7CiLFK70hJIs+MvOMb27KbuLh6qIXIIew+T0XDmdil0bNWD2Rq0OI35ubw/SLB0g==
X-Received: by 2002:a17:90a:9606:b0:2a0:50ce:aa95 with SMTP id v6-20020a17090a960600b002a050ceaa95mr8314380pjo.21.1711494897036;
        Tue, 26 Mar 2024 16:14:57 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090abb0e00b0029c49ed3974sm154556pjr.37.2024.03.26.16.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 16:14:54 -0700 (PDT)
Message-ID: <6bdf2884-852e-42d3-9e67-c9d5aa7d932a@redhat.com>
Date: Wed, 27 Mar 2024 09:14:47 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
To: Will Deacon <will@kernel.org>, Keir Fraser <keirf@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
References: <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
 <20240326033809-mutt-send-email-mst@kernel.org> <ZgKXr8IQ51xBECuP@google.com>
 <20240326114313.GA9482@willie-the-truck>
 <20240326154628.GA9613@willie-the-truck>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240326154628.GA9613@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/27/24 01:46, Will Deacon wrote:
> On Tue, Mar 26, 2024 at 11:43:13AM +0000, Will Deacon wrote:
> 
> Ok, long shot after eyeballing the vhost code, but does the diff below
> help at all? It looks like vhost_vq_avail_empty() can advance the value
> saved in 'vq->avail_idx' but without the read barrier, possibly confusing
> vhost_get_vq_desc() in polling mode.
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..87bff710331a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2801,6 +2801,7 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>                  return false;
>          vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>   
> +       smp_rmb();
>          return vq->avail_idx == vq->last_avail_idx;
>   }
>   EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
> 

Thanks, Will. I already noticed smp_rmb() has been missed in vhost_vq_avail_empty().
The issue still exists after smp_rmb() is added here. However, I'm inspired by your
suggestion and recheck the code again. It seems another smp_rmb() has been missed
in vhost_enable_notify().

With smp_rmb() added to vhost_vq_avail_empty() and vhost_enable_notify(), I'm unable
to hit the issue. I will try for more times to make sure the issue is really resolved.
After that, I will post formal patches for review.

Thanks,
Gavin

