Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604013B992C
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278756; cv=none; b=WHC+D10m51EBNWs1LQyOLyg6QLb+wNE9tL9o30juAkQajcmMZKZ3O6BwZotsa2v13SXMnl5VAuefimdZkNAR+b9wAYCfHpFMdioZ2n0+XMTlEHhK7nKvZyKNhePpgmRaM1mS1qSbOmbciAvlwxxX19SMWExEBJcpCKoKosxbrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278756; c=relaxed/simple;
	bh=nBFwTaHCoZrvhKEnFDKk/c/uDF8TWWjhz8/V3OQzmEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XNwXGrDAGDl3aBUjQSvge6dUXGd+bFLKdYXp73VfLePdpbbjlvDwSFnFkWMFVkGmi0HA0kVtb4R+LN9GMvRZiP6bf9TwbwrOHZ1zh6AOustqoyjWYzLqiqSyELoKTwk+g1hbuwIHmcQ46DkFIljtRpjsNkdv7k1Tjw5My8uLIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCzwnzDV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCzwnzDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791278753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NjoHxY7Tm9jzAn4TDRkj16R8xEG3syAc3zsRYffO2PQ=;
	b=jCzwnzDVOGpNlJGeZv+ppSDOL3lgJOEgfo99co0wmECTGTvejJNFGmOsxyLJr84im0i8nd
	ic/wjzMuhmy7sN189pk1gRA3PET3QoQeqEojDdkNGiUGW6yQU0p3SanQQroYb5DThuRnIZ
	aI4PdSkpwEiMeNCyAP5TFeRjO9bLOFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-M075sRLWPXmurRftAXrMhw-1; Tue, 06 Oct 2026 05:25:52 -0400
X-MC-Unique: M075sRLWPXmurRftAXrMhw-1
X-Mimecast-MFC-AGG-ID: M075sRLWPXmurRftAXrMhw_1791278751
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e6b5c5f44so43972895e9.2
        for <virtualization@lists.linux.dev>; Tue, 06 Oct 2026 02:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791278751; x=1791883551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjoHxY7Tm9jzAn4TDRkj16R8xEG3syAc3zsRYffO2PQ=;
        b=bwDihOnAJsWEAhIaUqmCpVI/mBlww/qiA8AeZvUDv+hKQ+Ub5w5AUNnm/mnOhRjCqQ
         ma5LMi7DJ+UmXHV+G24sOK2RSFbeteEY2xCzbYlWPQo9XrCxtU9mlrrAzy7kF81xBKQO
         4Nl0c5UogcgookfAEfnGxrHeD2SJSOiHKJ+/bPIbCs0RlKzzyfxkj5nOPAUNgbirYu2G
         AjS5fShK6QcT1judYa1kCRggR+BOwpQpWlEX8id4EEIhTG/yfDKyu0CIhI4Q7iQCZIba
         xWrK/cghp3+2ZmRPf5G7FacNhDueXHM6Rwbh/BPemqv/Fhm2TbaRZry8JOcTsCNrPq3t
         eYNw==
X-Forwarded-Encrypted: i=1; AKwUvByFS+bfgmq7EDPgWmh90NAxBVovqoedjbNThb8YwgwbIHCiqQXnP2GIyNpfEYpqMG58zu87js4m12QjScFVwQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lI6rg5Im6sOoJZGTfMjqb53/EEqx5SeQKCLyFurQvTxvke5BPi
	xQGc6ajSDldavXF5gMo6B56M8X8qIum7ynjH9QGCWs+KpMcMdm43fEFeMS+ASyMogS0lHkc+sCC
	4eE/epIiVNV/a/1Wi6bhqotHibikpyBitIj/cOgVYxl1Q+T8oqlnXgts8G4HdxMrYFYERSgNt+N
	IW
X-Gm-Gg: AYBFou3HcFBhN1Xq7Pwd6G4WeFXakzmkAV/CS4UvhZHkyoYWedMAvYkPuelTxLm1NCP
	iLfeF869AGzU7Db8/Kj/ZWhyymYNKGrTl1grAzGtJC8B1To22OVAiBLAryGkGHjvUfuVBvNTrjF
	AAg+OQuhnqnmZ3Mc3mvbOjcsz0ZZRoJVQ4PWE9wIXfKZ+oW+FCDmwvmh8Oqd5w4P/bvHQbCMwx5
	zEZx3cnw7DO9ck/tGAxY30BgYOgDm0PdHwXoH5XAEKx14GEVp/dAsqm+AqHu3Oe2MZN557XKT6N
	IebyG725YhuQkgRWHrkBItHgok2G/O4NJ3ffr9Q7JEM36V2BNDi9wA51N9Zo+T/wM+P7mGQ=
X-Received: by 2002:a05:600d:82c2:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-4a17b54978cmr17121785e9.16.1791278750650;
        Tue, 06 Oct 2026 02:25:50 -0700 (PDT)
X-Received: by 2002:a05:600d:82c2:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-4a17b54978cmr17121435e9.16.1791278750157;
        Tue, 06 Oct 2026 02:25:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c62eda863sm8233454f8f.43.2026.10.06.02.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:25:49 -0700 (PDT)
Date: Tue, 6 Oct 2026 05:25:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Jason Wang <jasowangio@gmail.com>, linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [BUG] scsi: short virtio-scsi VPD response exposes stale heap
 data
Message-ID: <20261006052300-mutt-send-email-mst@kernel.org>
References: <20261006091138.827988-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261006091138.827988-1-tjdqudcks0424@naver.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6NCdFZYSC3MWey08ty5ogdqC4X5tY-79EPt0oevdtuc_1791278751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2026 at 06:11:36PM +0900, sungbyeongchan wrote:
> Hello,
> 
> I found a stale heap information disclosure in the SCSI VPD cache path
> when a virtio-scsi backend completes a short data-in response as
> successful.
> 
> The backend first declares a 256-byte VPD page, then writes only the
> four-byte VPD header.  virtscsi_vq_done() obtains the used length from
> virtqueue_get_buf(), but that length is not propagated to
> virtscsi_complete_cmd().  With good status and resid=0, the SCSI core
> accepts the device-declared page size.  scsi_get_vpd_buf() allocates the
> cache with kmalloc(), and the mode-0444 vpd_pg80 sysfs attribute later
> copies the unwritten tail to an unprivileged reader.
> 
> I reproduced this twice on commit
> ff47652a4b66c067c765a7ad464d930b5a9367cc with a local
> vhost-user-scsi backend.  In both runs, uid 65534 read 252 stale bytes
> from a reused same-size heap object after the four valid VPD bytes.  A
> normal full response returned only its valid data.  Reporting the short
> transfer through resid prevented the stale marker from being returned.
> 
> The demonstrated impact is a bounded guest-kernel heap disclosure to an
> unprivileged sysfs reader.  I did not demonstrate arbitrary read/write,
> code execution, host compromise, guest escape, or privilege escalation.
> 
> As a minimal disclosure mitigation I tested changing the cached VPD
> allocation to kzalloc().  The malicious fixed A/B returned a zero tail,
> and the normal VPD control was unchanged.  This mitigation prevents the
> disclosure but does not make virtio-scsi reject every inconsistent
> used-length/residual pair; maintainers may prefer to propagate and
> validate the actual transfer length instead.
> 
> I performed a best-effort public duplicate search through 2026-10-06
> and found no exact public report for this short virtio-scsi VPD response
> and sysfs disclosure path.
> 
> This report was prepared with AI assistance and is being treated as
> public under Documentation/process/security-bugs.rst.  A tested source
> reproducer, backend, logs, configuration, and proposed mitigation are
> available to the maintainers on request; the reproducer is intentionally
> not attached to this public report.
> 
> Assisted-by: LLM
> 
> Regards,
> sungbyeongchan

So a broken device makes guest kernel leak some uninitialized heap
data to guest userspace? Is that a fair summary?

-- 
MST

