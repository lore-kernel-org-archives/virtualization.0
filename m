Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2561409E07
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187138; cv=none; b=nPiipwIZ+C9LBBdx+8WzciZRuAxEwz6C8nV6pduo4ElNgsn5Bf8waD2E4kEJ6KbIzzzOowVhjAoCDTGOvIGv4ouvv8TcdgD96RCJXlUjXOZ5Ly85rEuxahNCYINp6nKsfLM7pZvis1dzlAGih415zyqZGBEn3WLb7m55+XVC3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187138; c=relaxed/simple;
	bh=sQeuR4owy4vX0IS15ajkyCUjrvN0HyfK66H9HDiTaLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OAHZeCWhAQrgd+sKCAWjvL4jSN/ZA/bWEyDS1tv9QoNJHZ9orBGQFZ4PzpNAKKf5/b22ewByhsB9kchuqOmC/dtkgkryvcLulJp09fAoxUFcIIQ0VJBWSh2oqkHttINhcastp8tJd9+S+Y30OkA7apeIW76CMdBwZNWIiqZwWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkyFFrSx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkyFFrSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781187134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tc2CbHnfT965SsW89vV2H3dWMtMCRgjtBX+OD0OWEw=;
	b=QkyFFrSxVLLZUfMe1iF63n+xjF+dMEtSjLH0dHvJa3Ey448hJQHOAmWRlvk7fB90CFFPIh
	/y++fZbuTAlxAA7YBq6DU3gnQhxhwnLwePuyuuUHmzCWrLHJjiWYQLQ8rG+kWjpHn7UOqH
	aNWFndv5rbGHpAD+hEvTjeVOLVs8ym8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-rOCzpevAPQykgK3FIDgc2w-1; Thu, 11 Jun 2026 10:12:12 -0400
X-MC-Unique: rOCzpevAPQykgK3FIDgc2w-1
X-Mimecast-MFC-AGG-ID: rOCzpevAPQykgK3FIDgc2w_1781187131
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45efa2f7009so5334292f8f.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187131; x=1781791931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tc2CbHnfT965SsW89vV2H3dWMtMCRgjtBX+OD0OWEw=;
        b=qGy50QdPG0H7ULcEHVJ5RGeBrM51dN+6fHyg4LedgdOy1palqyHHFm/5iE3m1Mq9gp
         P8+r0rpxGtE1DBk6ZXOMDK+oIGg9Pn/wug+5E8IMlEcQFhDkVevTGr6VarklENmnB+BN
         WqwqrV2p68dOyTVCMxlQpZeUzw4wkVFajWGpYhaW98JGgeh8XCcgKhbeexb8BshQD6KX
         NGldNNvTK5kHmAqXbcPDcZkUXpq2nS40iYcS9SPoR25PspLxdXv/prpTkaC/8oyYXyg4
         B+/2crn4gqH1snYiCibYrf1Ja+ZriAgeScLug0ZHw0Rrfj3le17F11B8Ar9vqrz9ytkG
         Y8kg==
X-Forwarded-Encrypted: i=1; AFNElJ+94pg8oye59DteWcJME3wtcZHCn81lRd6TS3Wvt1LDK+VI1d9NipB70W6xVE+r+1MZduBBhhNibkD/3H4O5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmN3gVg19mimNgohhq9HNNk6GZ5qKJ8Hq5MR5RmV6F9kQqUTDX
	kVkggYjCcA/qssqbTH3Jr9J7b7iv6k0B4Qb9F2kzTsNlzWU9CQF3wIKFzjrYB6wFsjDemk9t2C/
	OTgXTu+AaPG8OgX/Ya5hZVhJeSrSbzIxRfAoSj/jXB0XO3+QP6KHagDkD3APvnqU2k3t4
X-Gm-Gg: Acq92OG8jIS+FGOq0YGQ3WwL1CDeIc2zE7Dg4dV8kzLfD1e8HBEjmWkhOWxereswM+x
	KgV3ugbXgc5rE/Y9uLn4XdS0v1zb6kxsnn7Aanq7/U4GojO53ib6cCHpa+JXKcARbHcuuNOwDLg
	L2SHMU0vQ7iUXdFC3D3wX1YmymfXf7cMGhTR2vvMUGX+kHj5JG+chTCajMARIHOJIrN+OPpfnvP
	T/yqYZk9et/lkMHtTlO3tBeISIytc7gxeivyGp+rMONOKThgnlimEJAHxaB0+DtjMMx0wzfX5Hq
	ZJY8JSHIW2MWslp+pk/CCC23lAXspZOy6Mcs8XOzTuw8u9OWxSdQYyYaYjSgASbSctfVvTIWsEh
	umRslvY+bnriLVuPTOsqRdNC6ISCC18TJ7pwKkpGZygzOGsnYXuRNnQ==
X-Received: by 2002:a05:600c:3511:b0:490:6237:521d with SMTP id 5b1f17b1804b1-490e55d38famr39913545e9.13.1781187131100;
        Thu, 11 Jun 2026 07:12:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3511:b0:490:6237:521d with SMTP id 5b1f17b1804b1-490e55d38famr39912545e9.13.1781187130434;
        Thu, 11 Jun 2026 07:12:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2ca1a43sm73488695e9.8.2026.06.11.07.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:12:09 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:12:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 0/2] Fix lock errors in VDUSE suspend feature
Message-ID: <20260611101154-mutt-send-email-mst@kernel.org>
References: <20260611133806.198402-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611133806.198402-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HwwwFmDPl7WRpVSfnWDLYtetviqw3ArXG_orb8ndgiY_1781187131
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 03:38:04PM +0200, Eugenio Pérez wrote:
> Fix wrong ordering at taking semaphore after spinlock and convert the spinlock
> take and release into guards, so they are not lost after a return.
> 
> This series goes on top of https://lore.kernel.org/lkml/20260610083452.477759-1-eperezma@redhat.com/


And     vduse: Fix error around jumping over a __cleanup() variable
    
does it obliviate that?

> ---
> It would be great if these can be squashed.
> 
> Eugenio Pérez (2):
>   vduse: fix not releasing taken semaphore in vduse_dev_queue_irq_work
>   vduse: not take the device semaphore while holding vq spinlock
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> --
> 2.54.0

