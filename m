Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D636C
	for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655954; cv=none; b=vBV917hEHR/azqg2G/YDtYMIxEZr8an65r9+EBzrFIKXaq5PI8CoEBnTSE8QQ/O2hpvqULU5W5pRvFuYh/Y4G5EOk9AWmP/nAw0Zp50rnwvl6T63rfxSngrX3RT6CQGb0Q3pDbXlQb8RKtfNUULHCIyc1to0H4AxDW6dq47Vykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655954; c=relaxed/simple;
	bh=3l2S1L46U8XsU4sWtbSp+mYEbAJYokaHNWfzbDztxOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jfONtEQE5J5l76BXm9Ff9vXT3y1VcuK4ODZYkwuA7aj/piQcptOlYU5yvDWUDqNILmmmxCzTrZwVyCxVuPso0zvFgtleYKv4sttkdKb/F843ndjp5NFWkT2n/qYOJUZ4mGDfN3treCZAt9tBImg55r4jsvMaWYX2QjM6Djf3DzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHnLcf05; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHnLcf05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744655950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/iXXqChlzjbODZfwDRdIt5xwYfNbSaluxaykDmQl48=;
	b=fHnLcf05tU3GqPKzWKQStsbQ+83HP84zJeR3jay6zEt66O61JqrrxPWh4SNY3KLjZi1Rcy
	+o2C3bpmp2QaX1RWAKdL1GevWHwFa3H7yynBZZEyIaNyCYDumfW3TCZctEhbNGIvAC6Z9/
	h7SpVpdx5ZkIJkPiYTppJu9EzTBvA5A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-3jffVPW6MhKug-z1xQi6rQ-1; Mon, 14 Apr 2025 14:39:09 -0400
X-MC-Unique: 3jffVPW6MhKug-z1xQi6rQ-1
X-Mimecast-MFC-AGG-ID: 3jffVPW6MhKug-z1xQi6rQ_1744655948
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39123912ff0so1855998f8f.2
        for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 11:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744655948; x=1745260748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/iXXqChlzjbODZfwDRdIt5xwYfNbSaluxaykDmQl48=;
        b=jsg27yXuaTonS9BvSFvPkPAk1+e+RHmM04oZj1oE2B//B2QJkbEtgWmrg7iOFlDb+V
         wbU9gE8bDoTEUSmiP7LzgGd6jn0LR9Tq5vIVFK0SUgiCC18h5EgSsLBnOpA0ZLqovt4k
         nk3S08ang6xNplkA6SJ+WBdzlua7aI5gNGQSP/+w+G4wvXW0biJGNVU+HNi5TraL1NhZ
         RxAN0eJ3DZVC05hzxTbkjg258xdnVLTvUV7DpAbGnnStJmzCn0XSSIa8yVtYHPRRNWnb
         uL4icuu0hsIFuDXg1qkQic1NRupoJ4Tw+mA9QY+M7+GgVJGlsjyE62VQfTUfeXOAa5hC
         00AA==
X-Gm-Message-State: AOJu0YyjnsNs5yVZvQGi4U44c3aCrIWgi9blP6aXK0ZHQhmiNr+NkPBg
	Ve05sAuzFojcgFzg8IVpcBRL0GVJsEo+dGfkCEnEdVcSG8Gs/4bgBRF/SdDm4sNZH7LJWPGYEne
	Y6uDPYY1e1OuWmcyjFILXD0gd2EMRRuMSrfy/b3kcOwggnbd68/QzHxjfcDoXYOg1
X-Gm-Gg: ASbGncuUMPdGwvZOajWobwkmsAYyBJB+n0RwZaSpyILpC1GdpQ4wLfpNOSIyyFICkhC
	hn7O9hJAGGpancw1DJGIy24KpMZVOUR3ccC0PPjqIXsir2vNJLJQ0YoT0+ohtiipArtOojbCkch
	FC+YXjXTmhA7kQd6i6YDrsPPyQNtIhg8idN3xjFlwtQqBKw6jPSYHMwcFDSDTsyvsIiQTaWj/sn
	9HG94PukLHEURj3d80GLxvOxHWLa9zz9OHLY68xjlIL4xRQzlvgeUNyq/uord3dpWLAplrQfbB+
	hLqVsA==
X-Received: by 2002:a5d:6da8:0:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39ea51d3527mr9946036f8f.2.1744655948209;
        Mon, 14 Apr 2025 11:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAxTcLnqSrTxH65+u6GiRouP7vWe1kbCg6AHGAsfsrltSDOoWgKmUYeCud8h0C9/BhA/o+Iw==
X-Received: by 2002:a5d:6da8:0:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39ea51d3527mr9946011f8f.2.1744655947712;
        Mon, 14 Apr 2025 11:39:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445788sm11861921f8f.93.2025.04.14.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:39:06 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, jasowang@redhat.com,
	michael.christie@oracle.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com, joao.m.martins@oracle.com,
	joe.jin@oracle.com, si-wei.liu@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] vhost: add WARNING if log_num is more than limit
Message-ID: <20250414143039-mutt-send-email-mst@kernel.org>
References: <20250403063028.16045-1-dongli.zhang@oracle.com>
 <20250403063028.16045-10-dongli.zhang@oracle.com>
 <20250414123119-mutt-send-email-mst@kernel.org>
 <e00d882e-9ce7-48b0-bc2f-bf937ff6b9c3@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e00d882e-9ce7-48b0-bc2f-bf937ff6b9c3@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3KT23GilWOB5jDktU2LoDOh4glR8oXlD7KfD2uFoGgk_1744655948
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 14, 2025 at 09:52:04AM -0700, Dongli Zhang wrote:
> Hi Michael,
> 
> On 4/14/25 9:32 AM, Michael S. Tsirkin wrote:
> > On Wed, Apr 02, 2025 at 11:29:54PM -0700, Dongli Zhang wrote:
> >> Since long time ago, the only user of vq->log is vhost-net. The concern is
> >> to add support for more devices (i.e. vhost-scsi or vsock) may reveals
> >> unknown issue in the vhost API. Add a WARNING.
> >>
> >> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> > 
> > 
> > Userspace can trigger this I think, this is a problem since
> > people run with reboot on warn.
> 
> I think it will be a severe kernel bug (page fault) if userspace can trigger this.
> 
> If (*log_num >= vq->dev->iov_limit), the next line will lead to an out-of-bound
> memory access:
> 
>     log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
> 
> I could not propose a case to trigger the WARNING from userspace. Would you mind
> helping explain if that can happen?

Oh I see. the commit log made me think this is an actual issue,
not a debugging aid just in case.


> > Pls grammar issues in comments... I don't think so.
> 
> I did an analysis of code and so far I could not identify any case to trigger
> (*log_num >= vq->dev->iov_limit).
> 
> The objective of the patch is to add a WARNING to double confirm the case won't
> happen.
> 
> Regarding "I don't think so", would you mean we don't need this patch/WARNING
> because the code is robust enough?
> 
> Thank you very much!
> 
> Dongli Zhang


Let me clarify the comment is misleading.
All it has to say is:

	/* Let's make sure we are not out of bounds. */
	BUG_ON(*log_num >= vq->dev->iov_limit);

at the same time, this is unnecessary pointer chasing
on critical path, and I don't much like it that we are
making an assumption about array size here.

If you strongly want to do it, you must document it near
get_indirect: 
@log - array of size at least vq->dev->iov_limit


> > 
> >> ---
> >>  drivers/vhost/vhost.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index 494b3da5423a..b7d51d569646 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -2559,6 +2559,15 @@ static int get_indirect(struct vhost_virtqueue *vq,
> >>  		if (access == VHOST_ACCESS_WO) {
> >>  			*in_num += ret;
> >>  			if (unlikely(log && ret)) {
> >> +				/*
> >> +				 * Since long time ago, the only user of
> >> +				 * vq->log is vhost-net. The concern is to
> >> +				 * add support for more devices (i.e.
> >> +				 * vhost-scsi or vsock) may reveals unknown
> >> +				 * issue in the vhost API. Add a WARNING.
> >> +				 */
> >> +				WARN_ON_ONCE(*log_num >= vq->dev->iov_limit);
> >> +
> >>  				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
> >>  				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
> >>  				++*log_num;
> >> @@ -2679,6 +2688,15 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> >>  			 * increment that count. */
> >>  			*in_num += ret;
> >>  			if (unlikely(log && ret)) {
> >> +				/*
> >> +				 * Since long time ago, the only user of
> >> +				 * vq->log is vhost-net. The concern is to
> >> +				 * add support for more devices (i.e.
> >> +				 * vhost-scsi or vsock) may reveals unknown
> >> +				 * issue in the vhost API. Add a WARNING.
> >> +				 */
> >> +				WARN_ON_ONCE(*log_num >= vq->dev->iov_limit);
> >> +
> >>  				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
> >>  				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
> >>  				++*log_num;
> >> -- 
> >> 2.39.3
> > 

