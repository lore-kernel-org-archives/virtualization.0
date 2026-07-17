Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58453F86EB
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305913; cv=none; b=lLmtHjedxsZxmjBdcv9LZTEln48UTZZIKfXZEQJ6MsS7cttH8jEC+Bf6h+QpWQV5qgG4eZN7mYF6Ndyt/gub3hoKdj655aSXrcXxTqthVsysc2YaN2MYYhK3Oezougbn3E6CHt8un/xyyk2XHeoueT5m/RVGtALj+tFcgN8ppeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305913; c=relaxed/simple;
	bh=CBfSqK2AvgdhR+Bzp0CO34iyovUNpliOo+OgVtl30zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vBqPCFNWQG6QpZsTg6dIUr6g0mtomNFpZr8IU7y2Ac8MJmL1ydBYu/iJfrrjEnOf3LD/QuSm1zBHu/kUJOjD+cCdfuU0uaBJz9puclbNxn/GZ1GJX2usAV2o0fPBvcA4l7UQSFOmGhgmI0rrpFxV428/FAsjE0LXQxeKDdgzp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bsn0bczL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bsn0bczL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784305906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0HLfgnrtjxNOO4Lwlf1DY9lZMzmjOSTkB4j+MM+kqU=;
	b=Bsn0bczLdgO6ODU5YGth9ShbPJ3wdpdgDnC1jBL7O3u0AQtABAu140HnkQkgKOUUBfpdqf
	EXFDSvXEcYaXi08BbTS9mF3qo6YTRu9CPpnQvin+0HSc8TM0Qw/d9ySobltthCAgrMmqVx
	aF/Yiec2y5zrkD4bebIk9zTlYL1DP6Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Bm0-IVisMH20hyQMX8NH8A-1; Fri, 17 Jul 2026 12:31:44 -0400
X-MC-Unique: Bm0-IVisMH20hyQMX8NH8A-1
X-Mimecast-MFC-AGG-ID: Bm0-IVisMH20hyQMX8NH8A_1784305904
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4729d2a64efso1080717f8f.0
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 09:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305903; x=1784910703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0HLfgnrtjxNOO4Lwlf1DY9lZMzmjOSTkB4j+MM+kqU=;
        b=NEbJV6/aL5RLclb8odyaUCfQCGBvDaiIZaJmrQQ7wxAUKamUTqWfUm5OCD3aEtU/O5
         aSr9iQJTenhwahXBUnC0dAuP8G+E/bXm7b/oGkw2buS3Q8XiZHr3N968jtrMAd5UytYr
         a96Ss49o7zvjduSrbdNFgHxxqlgUKcoMI8Dka7oM4rxJKM0CQjj77ZEmTzxPTT6FqHTr
         jyUbG6JzibdroxuFmcJ8eoHTpVXEUsZRKI6imW4sAkYlMtBJWcot3tCdVWklfOB5C8J1
         s9yjufH8hmZhd5SNNxRDk89bkKoYpuYY2aq2GEI8k2rnXewU3Iy6tetzoYQ9h8mkz1FD
         vvFw==
X-Forwarded-Encrypted: i=1; AHgh+Ro77I0yIq0JGofGcomaPNK2rHK2SrXWemKkWRpDPWYJhLMhnZWkuHb+RT6/igBXyCvRx+Gk/rVo/w8uTjmfZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc0Qx4hgNzsocCNxwpdM2oy/kKo/yAAr26RjpD0LRRsz2NNjB1
	4gZP0RFhUMeMYKT0FDA5OolmWwUBMx5Xaq7xl6qlnMb/rku5j4iUUNhzD3ILgj3OpcdEiT4IuCl
	PMoAtxNF3PHn/z5OClQtO5rcm0NJh5/eAR1XLBeedRAzYUl8X752PIyp8lOSBtImca/F5
X-Gm-Gg: AfdE7ckWwN+vif6Mjf0pzC2rybKzLPrMKoggtq0sR2Ro56eDtQzqUG2A81uKYJ2vx+f
	QcGvQDSFNQH6b2vGrFh4kGqkExfljOnCSu7tp11qr2wLFGN+hdVb33mEVuNgi6mfrelS7Mdpuz8
	7PzRCC2BQIfQ1f4wtcm/c2YJm9Rv6jXCKu9HaJZ6ugYDnG7w53izJkpPlygS3SOcV9ny8Dz/y9U
	lMjGZZ+m93qsIx5XPIH1CsOblLkmGX+acl4HjqBmfLXUaFrpU93DlTC1mFRiVnSGsoVVjsodtfa
	2rp0yefwlJK8qIQ4zDfVeJQTIMpc9esyVMNzSxnrg43TEFpIqCSPZxKszOkmVLwFKLhzCF/cQna
	JGWFFgV1FuyKEZOeNyBEjFpgq
X-Received: by 2002:a05:6000:2f85:b0:46e:6959:35a7 with SMTP id ffacd0b85a97d-47f623e803emr4407832f8f.22.1784305903404;
        Fri, 17 Jul 2026 09:31:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2f85:b0:46e:6959:35a7 with SMTP id ffacd0b85a97d-47f623e803emr4407792f8f.22.1784305902878;
        Fri, 17 Jul 2026 09:31:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eeece9sm5310864f8f.37.2026.07.17.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:31:42 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:31:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Jia Jia <physicalmtea@gmail.com>, jasowang@redhat.com,
	Linfeng Sun <slf@hdu.edu.cn>, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: Prevent OOM from invalid protection SGL count
Message-ID: <20260717123129-mutt-send-email-mst@kernel.org>
References: <20260717142205.103515-1-physicalmtea@gmail.com>
 <8f5b5350-0be9-4b79-a6c9-069d418dee30@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8f5b5350-0be9-4b79-a6c9-069d418dee30@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Q-WBAj8Gj7JAKpzQNHFaJpZfr1rgI0bAPoXq53QNf0_1784305904
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 17, 2026 at 10:13:36AM -0500, Mike Christie wrote:
> cc'ing Linfeng.
> 
> Linfeng also reported this bug and provided a patch that has your check and
> an extra check to avoid calling into the function in the first place. It's
> been stuck in some other list.
> 
> I think it might be best for Linfeng to re-submit their patch now so it can
> get merged. For that patch, I think there was one outstanding question left
> where Michael had asked if the issue was found with AI so the proper tag
> could be added. I don't think that question was responded to.

Right, was waiting for that.

> 
> On 7/17/26 9:22 AM, Jia Jia wrote:
> > The protection SGL path passes the result of vhost_scsi_calc_sgls()
> > directly to sg_alloc_table_chained(). The helper returns a negative
> > errno when the iterator is invalid or the request exceeds the segment
> > limit. The negative errno is then treated as a very large unsigned count
> > and sends the request into the SGL allocation path with an invalid size.
> > 
> > Repeated malformed T10-PI submissions from a host-side application caused
> > memory usage to rise sharply. MemAvailable fell to about 200 MB, and PSI
> > full avg10 reached about 1.46. The OOM killer terminated several userspace
> > processes before the endpoint cleanup completed. The kernel log included:
> > 
> >      [17036.451028] Out of memory: Killed process 2345 (systemd)
> >      [17036.493325] Out of memory: Killed process 2349 (sd-pam)
> >      [17078.265127] Out of memory: Killed process 1793 (networkd-dispat)
> > 
> > Return the calculation error before setting up the protection SGL. This
> > keeps the protection path consistent with the data SGL path and prevents
> > the invalid count from entering the allocation path.
> > 
> > Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >   drivers/vhost/scsi.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 9a1253b9d..8486652fd 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -972,6 +972,9 @@ vhost_scsi_mapal(struct vhost_scsi *vs, struct vhost_scsi_cmd *cmd,
> >   	if (prot_bytes) {
> >   		sgl_count = vhost_scsi_calc_sgls(prot_iter, prot_bytes,
> >   						 VHOST_SCSI_PREALLOC_PROT_SGLS);
> > +		if (sgl_count < 0)
> > +			return sgl_count;
> > +
> >   		cmd->prot_table.sgl = cmd->prot_sgl;
> >   		ret = sg_alloc_table_chained(&cmd->prot_table, sgl_count,
> >   					     cmd->prot_table.sgl,
> > -- 
> > 2.43.0
> > 

