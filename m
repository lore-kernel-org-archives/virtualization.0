Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924362AD21
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509407; cv=none; b=MdZx5BFUd+s0wB8SP8PlmXvTcImDbFx57Rtp0EmSI3xREyAwF2itbJYCDY96i2UJ/KEPLcC5SlYIhK2+pxcNTYn9EHOE9DRsDyghRtvNi4lxZvP+sFChkxV0k/35BvktK0uz2pEy4msVs9s39zu4QNOTccV7UFOzg+Vd6Rbm7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509407; c=relaxed/simple;
	bh=F2V5lIDP4k54VyPQnx3tm95pRjfvhQH0+t+YIFhROXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MZOuaHM7FqieN7usoBGSKrHTCdbOPzbSgWAR/KQAUGBJ2Tnx6kqBHZMMErrfz7H/pyLgJOVZAUPFdLn3FZylloiSG8OXXhFeNZvtor9SeVYdXLjvKrcpTRtvStQttwR9Wxjd73S8gjTRjkrdp/GKB3m9tre0DhoeW5JQiK8nSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrmdHTvr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrmdHTvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731509404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpxWVmY9AA9sdaBT+FLe6ZwkY7JoCZPnsSDxJdlaOIA=;
	b=ZrmdHTvrg5hcohsxIDu0O1w0zhuowxohobfUtK/zYvipcbOlAfu1fXEJlwbFT4GwsMhSuq
	NMj/SbOOVgnWlGXkm9bwQBTxENR526e2az4ot1C/l+SpiQg5C0y7gAdOnLy7GRbMVqgCaI
	mpJQZ27jl/HRv4Fvz9C+Wj040cHY+b4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-1DaM3p6YNt-c-7Jok9BWTA-1; Wed, 13 Nov 2024 09:50:02 -0500
X-MC-Unique: 1DaM3p6YNt-c-7Jok9BWTA-1
X-Mimecast-MFC-AGG-ID: 1DaM3p6YNt-c-7Jok9BWTA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so4000275f8f.3
        for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 06:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509401; x=1732114201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpxWVmY9AA9sdaBT+FLe6ZwkY7JoCZPnsSDxJdlaOIA=;
        b=cn8D0PRd+BzguhrXNt0jgwFIKEvBtn5t8IV08vV/FrRNdwt9zT2l6d6uWP1cDLsYXR
         D2TAm/SNHjz7XLR/o9PpMBdKO36+xWlCBJENPwUdQGr/0JXlEDJBi5beSToOF7Fksemk
         X4C0JaJoCaui3KDl5HDnwl7LGdzdEf+Tzta1tgOzDi/UOVI5Li/q87EulAUgn924VSGP
         XWDNZWqf925jeT7tq5icXfKJWgsoWUaimunkFLWzgphCQsA1vaPexEuya7GNnLEkGf9X
         lLb545qXKJIXrm01t5z0u2mCUmeGFhKb6pJUGmnZnyuqH90XCAiEWOCsTfV1hGSyQxGb
         0Oyg==
X-Gm-Message-State: AOJu0YwCpzjFGNIxqyEBzMspwhfjMnQ1UOIXblEFdyF+CNgEyTLyMgc5
	78rENiMSZOv4ov21vrTBUk+ydzEI2vs+3tNAKOcDVZyACl/jHuWEs9N7rlIaArVEnsXYz+nP02U
	ezBFHBglV44lW8HeJ57zkHOsP08ElJ1m0On9OhT1Y7nWHUyCgVNJpYlKdlDxF4/Gy
X-Received: by 2002:a05:6000:1ac6:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-3820df610a7mr2091465f8f.17.1731509401499;
        Wed, 13 Nov 2024 06:50:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/XkX2Eyjenwpa71zbx3wPsBlk1LKkpMGBXi84BvxwbrswsvZkqwBZ4ckZuWMD7vSuPV2lwA==
X-Received: by 2002:a05:6000:1ac6:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-3820df610a7mr2091441f8f.17.1731509401092;
        Wed, 13 Nov 2024 06:50:01 -0800 (PST)
Received: from redhat.com ([2.55.171.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea647sm18300658f8f.68.2024.11.13.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:50:00 -0800 (PST)
Date: Wed, 13 Nov 2024 09:49:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 2/2] vdpa/mlx5: Fix suboptimal range on iotlb
 iteration
Message-ID: <20241113094920-mutt-send-email-mst@kernel.org>
References: <20241021134040.975221-1-dtatulea@nvidia.com>
 <20241021134040.975221-3-dtatulea@nvidia.com>
 <20241113013149-mutt-send-email-mst@kernel.org>
 <195f8d81-36d8-4730-9911-5797f41c58ad@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <195f8d81-36d8-4730-9911-5797f41c58ad@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5Wk-Aa_QR05JRFRl7djzNLJlitq_O3toBuV5zPV4Vlo_1731509401
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2024 at 03:33:35PM +0100, Dragos Tatulea wrote:
> 
> 
> On 13.11.24 07:32, Michael S. Tsirkin wrote:
> > On Mon, Oct 21, 2024 at 04:40:40PM +0300, Dragos Tatulea wrote:
> >> From: Si-Wei Liu <si-wei.liu@oracle.com>
> >>
> >> The starting iova address to iterate iotlb map entry within a range
> >> was set to an irrelevant value when passing to the itree_next()
> >> iterator, although luckily it doesn't affect the outcome of finding
> >> out the granule of the smallest iotlb map size. Fix the code to make
> >> it consistent with the following for-loop.
> >>
> >> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> > 
> > 
> > But the cover letter says "that's why it does not have a fixes tag".
> > Confused.
> Sorry about that. Patch is fine with fixes tag, I forgot to drop that
> part of the sentence from the cover letter.
> 
> Let me know if I need to resend something.
> 
> Thanks,
> Dragos

But why does it need the fixes tag? That one means "if you have
that hash, you need this patch". Pls do not abuse it for
optimizations.

