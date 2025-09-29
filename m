Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E931DE8AD
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132596; cv=none; b=uIQlqxUJDBfi43RSyL3JYFTdsdu16xql8OzAqrlzJC8FVKgpnLriZ5lIiLKjoYhkdddi9+QJ9nCt0WakjTQAxweoLYHBROfUutHOfUaU4/iPJYcUIg2CqRM4HRKLKgYSoZLxTcNo1hHAVKtNuI+pkE5ADMAJO7BkKoQSZ15XueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132596; c=relaxed/simple;
	bh=sWOVusL7EvxSTeXMYcYJrEbLpqwpAufzB9zqoLkNFt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RAB0rMe1GN+OESZnPJhl+o6e1wO9N5eA0w/DBKySXXjZjR6knKirhLfiVE/sbiXkuLVAcFSrJvnQGHcg9BY2OY/RtgXlpbuuXQ9lA68uajyD1ATYww4QaRXODWYFD2cY9snzM34MZdxltBfkbtFZRaorHwc+1lxax8Ahxti/zGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgKlXG9c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgKlXG9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759132593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfcWpYXomlJbET3NgLmWYr8bB6pAdVPNYM0EnAdbrUo=;
	b=RgKlXG9cXDxd2w2Dy9Hl5GKXbuGQFjYY4u/N4Xr7YZ6R5ZyYNPrNCnOAevA4f7URzsunHz
	TcoDxVHiC2QSuLTUBLkAIv33H3Zy3zQ+BKu7wSstfNcZftbRNVH0ZaMxNpdxoVt3dSnLA4
	xtGvOlLEuI+WnOWtUyF/EKCkIbp//AQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-AhhJnlLEMDu9KutfTPRUNw-1; Mon, 29 Sep 2025 03:56:32 -0400
X-MC-Unique: AhhJnlLEMDu9KutfTPRUNw-1
X-Mimecast-MFC-AGG-ID: AhhJnlLEMDu9KutfTPRUNw_1759132591
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso2833828f8f.1
        for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 00:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132591; x=1759737391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfcWpYXomlJbET3NgLmWYr8bB6pAdVPNYM0EnAdbrUo=;
        b=QhIODUsdThWpSZ4BO9HRmbrhFqbLUirO09zNESl4CSHH5K/qNFNfiBigfoUAh/LrlT
         nmQvQ0K3kEzfkIZ0oa9JeFImtyrADuQs8GI1zLgaj16JlHIDsgV/gMgItoVoKko07qf7
         znyhZIAfWVaI9UJ9y4WYxUmUaROUQpDN29KUNNv1ITWOMz3CaU11gtA4NAqe+I1tXMZh
         gx/1eZL92ph4+f9nwyaIunQ2/aS4ii7ZA+UGQbZy4WHzhwXpN8w1519N5E5/EpXtZgmo
         UfAp74kYZge+CIq0LNR4/dH41fmzA8pOfOD6yfxIHNORjuleLLQFGIM9d9/D0pTNNz2h
         XvNg==
X-Forwarded-Encrypted: i=1; AJvYcCV+ufw1eFMm3Gp0HtuEgBqdiU/BfC23qw+dWYW9vK9AQAETRjsAi6T+9omQDxKE/lk/+51zzn7AYaqEiJsggQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyA6BawJE/VazaTW+gQ5YQgGBrJE98KiLI4L3rw0XxJsTwDMtbV
	+dTSviY5WHTHLbedmkVuGnMOpequhFWPAhzLCtoLo2kfRdRqHi43W1/fjbmJhXmggpMvg31T/Jl
	CMzr35Xm/CfNKRn5nRtKN6FEA69xpjFse9i+3MHG7A0JqTFKUoOClweFOPfIssGFjR+uU
X-Gm-Gg: ASbGncvGhxPL5Q2flTF39FuLkmVhIX7suGwyv1/cPRkUuYEwa6tsKgDm8xujBUrcLdq
	YEFxllw2QIRxy+5RXBl0DqEeIxFfFD1coIllV/L5FTzPHBM+9429afjIvYB4k2uo1x5BGwblvgi
	+2W+NC1TBW1HvuO2n/NpIqKCbmsfAxprBK0B5/I1t19Xmc0ulLeLACxMKeYt4OhJabKrd9gmu4Z
	nov5n3rE0GNqPGYYWJ0Sa5aJGcA+wMJWZ+CKepVVFIyJIMf3C5SIn2+feASy+3eWVPia2yjI9iP
	SSd7CCr5AtIaNfpZ0dLo+kbiCQz8XscbQA==
X-Received: by 2002:a05:6000:2486:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-40e42502e25mr13992518f8f.2.1759132591250;
        Mon, 29 Sep 2025 00:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3u7Fng3Kymf2Ta2mHeAgLg78qvIklkkslGuwqTeY5v8ysKjPMZWXtHZMLOHDUtDUaPaKw8A==
X-Received: by 2002:a05:6000:2486:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-40e42502e25mr13992495f8f.2.1759132590868;
        Mon, 29 Sep 2025 00:56:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm216565635e9.1.2025.09.29.00.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:56:30 -0700 (PDT)
Date: Mon, 29 Sep 2025 03:56:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 0/6] Add multiple address spaces support to VDUSE
Message-ID: <20250929035620-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926103421-mutt-send-email-mst@kernel.org>
 <CAJaqyWfeiAiNOBtGoEYK7PLncXLMO+wZ=Gse+=X0FO65qQO4LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfeiAiNOBtGoEYK7PLncXLMO+wZ=Gse+=X0FO65qQO4LQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t5QQHbyqvE33-2_wP0JNKcC94cF5TBMHX1Duthg9EX0_1759132591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Sep 29, 2025 at 07:41:13AM +0200, Eugenio Perez Martin wrote:
> On Fri, Sep 26, 2025 at 4:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Sep 26, 2025 at 12:14:26PM +0200, Eugenio Pérez wrote:
> > > PATCH v5:
> > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
> > >   ioctl (Jason).
> >
> > ???
> >
> > I think copy_to_user returns an unsigned value: the number of bytes copied.
> >
> >
> > static __always_inline unsigned long __must_check
> > copy_from_user(void *to, const void __user *from, unsigned long n)
> > {
> >         if (!check_copy_size(to, n, false))
> >                 return n;
> > #ifdef INLINE_COPY_FROM_USER
> >         return _inline_copy_from_user(to, from, n);
> > #else
> >         return _copy_from_user(to, from, n);
> > #endif
> > }
> >
> >
> > so, how does the patch work then?
> >
> 
> copy_from_user returns the number of bytes that could not be copied.
> For example when the object size in the kernel is less than n bytes
> long, check_copy_size returns false and copy_from_user returns n, the
> amount of size requested to copy.

oh, right. thanks!

