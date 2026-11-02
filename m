Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622668;
	b=4WUFFrSO+tN3S/h/tqzPS5PLyU9rVsJ78Fpy9EfFg8sIgXM2z8sqlyv5fh5/a21/9mGp
	 yf1iXFrwEE2ZdeEdJ5tSOCpMTD9G0y2Bf/TJb+moI+DNDMPgEn/FDQx2hByJYDpVHA35S
	 v+G9BlnNvH9X4MUT5KchremNvzCmeOsW7IUbBxCVJulFHqse0A2AoS1ubvE/kUAVjt2HC
	 IE3aRPwT0X+RvK9isHIY4md5GG67f1PyKuEtztX51zNLmqg09M+8lX+LtasHLSZdhfMP3
	 PrYdftWP484mWipmiBMYbhyTdDZqxJdsDJsOt/U2aKLzWlu3Ln6dmKBR/liyHxNBhDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622668;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=atoeJGeqv0Z1R919+9aEtspWeeQpp92iU9wLTusAw7c=;
	b=ycBrP1cBrM8XtbE9OFsTKL2I1SB7BIOzAHaJfOdKlw9GkSDiNmAYc1oyAYzLuNd04P2i
	 g3521ZHoWBwwGEjPX/AGPHlRJxqk2YsG2leOrlDfb995V9gJ/3vTKK0c5WHB/RcpsWve6
	 LOg51/k8zf/U/ImEjxpqId541RA7hRqTt0oJJqOwuA8B4QKpue4fQ1hHvQIIn+P2TCdH7
	 YMGlHoasKN/cpoIeGBPfGnX35J+2AInK+fBMoamyDRU0Jv7BJv8O1f/djmWQSComxR4ih
	 26rDpeAAX/nX20lBj9y4TVEDorjNne7ns6ymwi0WlN95DitktzobnCBAwE9uoVWgVYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="RJAvCw/J";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED045606A330
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 12:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED045606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJAvCw/J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793622661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atoeJGeqv0Z1R919+9aEtspWeeQpp92iU9wLTusAw7c=;
	b=RJAvCw/J8Iuc7tuxnPSAF7mv0oY4W9ZcIfLGfVzWgZ2SohV9fTRtJ803hKC5nF7fNcp9SC
	gaZk5XuCHJmUxp2eanxEYDYdOspIDphuvKuf+nXcE4gbodB4zxGOHZsA/FXwBD6gz9S/Ej
	M7rBvIq382LQFLFuUPq3yksys7na0iI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-Ao8UKmvBN1CVgkJSxKKEYg-1; Mon, 02 Nov 2026 07:30:59 -0500
X-MC-Unique: Ao8UKmvBN1CVgkJSxKKEYg-1
X-Mimecast-MFC-AGG-ID: Ao8UKmvBN1CVgkJSxKKEYg_1793622659
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6acb986a43bso3260965a12.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 04:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622659; x=1794227459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=atoeJGeqv0Z1R919+9aEtspWeeQpp92iU9wLTusAw7c=;
        b=CNkRlXd0nFTRaLHwKrUSJqY8xY7tFLs1JowMYSo7BYQY+qRQso9s3O3aqaoDrSdmZF
         oJ+2bT2TM16rHazWrxADWSh/czOBRlW4FAaMp7MOX9onGKUex2ukQYnkQKJgxVOIKNqm
         Sn9Ibq03+zo2SjfJABT+tSUJ2Ft1ZaEA88dt8Kpy6SnysAk7bIJF0cQUiVCHblkDK/c4
         tiJprzVV0nn1EXLbbQWB1YIPNVPTyEgOxRQ+DiqSt3wSPibd007EVFhX7e3POYPFHd9B
         LJ5yDb3IusmY4O+el5aHcfL6+bB51R9HTqGNgD80vpz8QQP2s+3pMic40v2dwnqsRrb+
         tVzw==
X-Forwarded-Encrypted: i=1; AKwUvByzc0ytBkoYtNUn00nap2wgSuuhz2nWMI430c+zZ6BTgH4rwXi1/Gvesq8O3vWkbkXteUUQ0pc9vI6VNUMoFQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/QUW5u7RqKV+HXM96gTa42WkfQvpjvkeAACpkIlRhi6Q9MgruU
	Jg0jdhck4aDBnKae/UUrBH0R50eB5SUcnOBp9WQc3BlrZD9EWsuHCIguOkdxQPGGHOUCBWaLqCK
	2TMEQL3dH899y/Sk1h+k8umok4l+5D9EXuBPJlkvhwIHJcIMVqOZhw57aF4aHij8krPw3
X-Gm-Gg: AYBFou1SFLusg7oFM5D+2VCpRY7W0VQQlU+dKwx9s8iAAWTx+QVg5IKz4js4WoI0PO4
	lq920lmQnD9/7e1eu7jqPWJHEC6hVk+j0eJwUzuNLKo3ijUp2KGUhDhSiGywgoeJPvCokqpm3qk
	XVslXRvEIHZPtI0PbEs/BGIq3qH4G5OYudszwAlCgV+UineT9QRBV4I9jrJTMZn5IEbMzava/Gw
	c7vakuDoHV9HM3P+84iVAcx8TlnqzUBhUhHwbHYF1zhIcwRzM2eN5vTC9WFFUqlqk1d7Guy7NRC
	k08YsC5VgfIdR5W3wCdwRDRaHCpvtJnhIxKlUf9i3HB5RsSjp2cEpAxq3kSjtVk9x70A2i9mobU
	0rjVIGXnAFJKlYZP77e8rMFtfT8P4tfzYwOp/mteIDA==
X-Received: by 2002:aa7:c0d7:0:b0:6b3:d0a0:39e5 with SMTP id 4fb4d7f45d1cf-6b4d438bdb7mr5044953a12.9.1793622658350;
        Mon, 02 Nov 2026 04:30:58 -0800 (PST)
X-Received: by 2002:aa7:c0d7:0:b0:6b3:d0a0:39e5 with SMTP id 4fb4d7f45d1cf-6b4d438bdb7mr5044928a12.9.1793622657746;
        Mon, 02 Nov 2026 04:30:57 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b51adb58e0sm1095546a12.12.2026.11.02.04.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:30:57 -0800 (PST)
Date: Mon, 2 Nov 2026 07:30:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Karthikeyan KS <karthiproffesional@gmail.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH RESEND] vhost-scsi: use FOLL_PIN for DMA page pinning
Message-ID: <20261102073033-mutt-send-email-mst@kernel.org>
References: <20261020182640.2048506-1-karthiproffesional@gmail.com>
 <sashiko-outbox-180555@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-180555@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P5ilgWMlxnpzXz35PpGBuk6FwP-zvOXhvzIFCurkNRE_1793622659
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 21, 2026 at 06:27:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] vhost-scsi: page pin leak in vhost_scsi_map_to_sgl() error path


Karthikeyan were you going to address this review?

> --
> 
> commit 1042924e4de0195bca9a4409c2fafbb0c7c58e45
> Author: Karthikeyan KS <karthiproffesional@gmail.com>
> 
> vhost-scsi: use FOLL_PIN for DMA page pinning
> 
> This commit switches vhost-scsi from iov_iter_get_pages2() (FOLL_GET) to
> iov_iter_extract_pages() (FOLL_PIN) when mapping guest I/O buffers into
> scatterlists, and updates the teardown and error paths to unpin the pages
> with unpin_user_page().
> 
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 885fac5ed042e..8162d83bdfcc9 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> 
> [ ... ]
> 
> > @@ -842,9 +851,9 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
> >  	size_t offset;
> >  	unsigned int n, npages = 0;
> >  
> > -	bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
> > -				VHOST_SCSI_PREALLOC_UPAGES, &offset);
> > -	/* No pages were pinned */
> > +	bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
> > +				VHOST_SCSI_PREALLOC_UPAGES, 0, &offset);
> > +	/* No pages were extracted */
> >  	if (bytes <= 0)
> >  		return bytes < 0 ? bytes : -EFAULT;
> >  
> > @@ -867,7 +876,7 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
> >  		    cmd->tvc_sgl_count > BIO_MAX_VECS) {
> >  			WARN_ONCE(true,
> >  				  "vhost-scsi detected misaligned IO. Performance may be degraded.");
> > -			goto revert_iter_get_pages;
> > +			goto revert_iter_extract_pages;
> >  		}
> >  
> >  		sg_set_page(sg, pages[npages++], n, offset);
> > @@ -879,14 +888,17 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
> >  	*sgl = sg;
> >  	return npages;
> >  
> > -revert_iter_get_pages:
> > -	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
> > +revert_iter_extract_pages:
> > +	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg,
> > +			is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin);
> >  
> >  	iov_iter_revert(iter, bytes);
> >  	while (bytes) {
> >  		n = min_t(unsigned int, PAGE_SIZE, bytes);
> >  
> > -		put_page(pages[npages++]);
> > +		if (is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin)
> > +			unpin_user_page(pages[npages]);
> > +		npages++;
> >  		bytes -= n;
> >  	}
> >  
> 
> [Severity: High]
> Can the cleanup loop at revert_iter_extract_pages in vhost_scsi_map_to_sgl()
> leak a FOLL_PIN page pin on the last page in pages[] when the misaligned-IO
> check triggers on the first iteration with a non-zero offset?
> 
> In vhost_scsi_map_to_sgl(), iov_iter_extract_pages() extracts and pins
> DIV_ROUND_UP(offset + bytes, PAGE_SIZE) pages into pages[], where pages[0]
> only covers min_t(unsigned int, PAGE_SIZE - offset, bytes) bytes starting at
> offset:
> 
> 	while (bytes) {
> 		n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
> 		...
> 		if (!is_prot &&
> 		    (offset & (SECTOR_SIZE - 1) || n & (SECTOR_SIZE - 1)) &&
> 		    cmd->tvc_sgl_count > BIO_MAX_VECS) {
> 			WARN_ONCE(true,
> 				  "vhost-scsi detected misaligned IO. Performance may be degraded.");
> 			goto revert_iter_extract_pages;
> 		}
> 
> 		sg_set_page(sg, pages[npages++], n, offset);
> 		sg = sg_next(sg);
> 		bytes -= n;
> 		offset = 0;
> 	}
> 
> If this check fails on the first page (npages == 0) when offset > 0, it jumps
> to revert_iter_extract_pages before bytes is reduced by PAGE_SIZE - offset
> and before offset is reset to 0.
> 
> At revert_iter_extract_pages, the loop steps by PAGE_SIZE instead of
> PAGE_SIZE - offset:
> 
> 	while (bytes) {
> 		n = min_t(unsigned int, PAGE_SIZE, bytes);
> 
> 		if (is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin)
> 			unpin_user_page(pages[npages]);
> 		npages++;
> 		bytes -= n;
> 	}
> 
> When offset + bytes crosses an extra page boundary (for example, offset = 3840
> and bytes = 512, which pins 2 pages across the boundary while bytes <=
> PAGE_SIZE), the loop only runs DIV_ROUND_UP(bytes, PAGE_SIZE) iterations
> instead of DIV_ROUND_UP(offset + bytes, PAGE_SIZE) iterations, leaving the
> last page in pages[] pinned.
> 
> Should the cleanup loop account for offset on the first iteration (using
> min_t(unsigned int, PAGE_SIZE - offset, bytes) and then setting offset = 0),
> matching the main loop?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261020182640.2048506-1-karthiproffesional@gmail.com?part=1

