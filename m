Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82D13D531
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054308; cv=none; b=jvoUJ0oosdySi6PPogba519YyCsOLL4zUF2xpj8N/uhDo6zaM6ILCxkeJPmgHMbqqE89mapVZ9odWAuzDnzgcpEl8MNb6GQPTINFQdjomjAZrFqAAPLhePucGkqoEiZplzy1dJNefHW5IpP0YBBhLZaJ7c3NfSh9VQJH98MeV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054308; c=relaxed/simple;
	bh=2tudeH4asXQXZSaak3ZzzRDXUzzwEGH9p0h3Dri/+Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rwagKUlnd4H9qkW89fvfPy4h1JmawJSilfO7jAYKYfhdyhJEaMQzkiN+FzRTXaDSSuZvPxbEC8rrw0XF6OFLAS0cMycSdaH1qozvPnkdlXTx9AKcEAP69jPH/+GO93gOPH9wzy+LFF6Su9/tX6DQx8sS2SsLJsEtaCjWDgvhnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7XgPkFM; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7XgPkFM"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05C148112C
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:38:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oPwJzLu9M63D for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 14:38:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 00A7181119
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00A7181119
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P7XgPkFM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 00A7181119
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721054304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JqnhsUJX2tl6nAh5V2Gectwmc33hA1nj9475HkyrKUs=;
	b=P7XgPkFMFq+H6F8SsORFMFMbWDtyQqCVzysv9yvZtrm8KZec6hlFE8mURlMInAzJsTLX+m
	UY4Da+6VzoLxojzf3qNaA/G0ISnstBW50Ac2Em3jnIKT9lpSBsfk/ZHaLUhMHSWaaSVD63
	tQc3OqEtKJqa8tjMzk4TwvTQFwp+874=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-el7QyalGMAaPAd9yoWBHwg-1; Mon, 15 Jul 2024 10:38:23 -0400
X-MC-Unique: el7QyalGMAaPAd9yoWBHwg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3678ff75122so3123783f8f.0
        for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 07:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054302; x=1721659102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqnhsUJX2tl6nAh5V2Gectwmc33hA1nj9475HkyrKUs=;
        b=XHR+IBg6WflXzModA/BSu5HC/tVeL4zN741SMo3TxMqdmB/4ODrBBk+VNMmMjnSK1I
         NWGAze5X1/jNUrVvex0zJx4H9ufhrbq3fdZWybWfy+qzLDFlG85C8JOI674+fxxMAeA0
         sYrSjT6SQF+AoIeEhl0nwpHikQ4DaWNoI8wSabMPC6Ajvz8p1yPGHj//caukJMjPeeck
         OVxkN6dEIxYHioEFlwAJeXOaVDPtlmvyM8fvug5oOJDnm2xx7aaeFBUDe0dUnkVU+URd
         qkSkXH8IvdvtuuIYjdrbeQDnwhwYmyM3TgD7futhV8i9NT1VYUtd/wcxSgjN55VevlwR
         OKPA==
X-Gm-Message-State: AOJu0Yy1u9V53qjBBWFKHn4JguDMMvd8mgexrlFaHRRSfM8wJ0IQ39fV
	3tKureRcstZQURsPIEM+RvnUIpiS+rnqy+FYE2AO4Zvx79iJ8wpKA5+TNTz99CLGVVZNKXC8XSr
	oMCq6DtnBl08VJvx3ii2W9qpkZqAi1QoKtMfthYKzGjsrky6XN3IyJYRSqw76XmxOciJF89ziVd
	to6eQ=
X-Received: by 2002:adf:8bd6:0:b0:364:8e3f:89f8 with SMTP id ffacd0b85a97d-367ceadb06amr12929791f8f.67.1721054302155;
        Mon, 15 Jul 2024 07:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEkTfPqTxDGRze09YdNkKZnLzIuew1RR5dRU6IAqmRqu1plKwM3L5a7zPdQxNzmrWp4dCkqg==
X-Received: by 2002:adf:8bd6:0:b0:364:8e3f:89f8 with SMTP id ffacd0b85a97d-367ceadb06amr12929759f8f.67.1721054301584;
        Mon, 15 Jul 2024 07:38:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:243:da88:7ff9:68fc:2f43:bcdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccacdsm6593721f8f.62.2024.07.15.07.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:38:20 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:38:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
Message-ID: <20240715103021-mutt-send-email-mst@kernel.org>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
 <20240715050637-mutt-send-email-mst@kernel.org>
 <d414f28e-8887-418f-963a-bb986dbdcaea@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d414f28e-8887-418f-963a-bb986dbdcaea@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2024 at 10:29:26AM -0400, Steven Sistare wrote:
> On 7/15/2024 5:07 AM, Michael S. Tsirkin wrote:
> > On Fri, Jul 12, 2024 at 06:18:49AM -0700, Steve Sistare wrote:
> > > Add an ioctl to transfer file descriptor ownership and pinned memory
> > > accounting from one process to another.
> > > 
> > > This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER,
> > > as that would unpin all physical pages, requiring them to be repinned in
> > > the new process.  That would cost multiple seconds for large memories, and
> > > be incurred during a virtual machine's pause time during live update.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > Please, we just need to switch to use iommufd for pinning.
> > Piling up all these hacks gets us nowhere.
> 
> I am working on iommufd kernel interfaces and QEMU changes.  But who is working
> on iommufd support for vdpa? If no one, or not for years, then adding these
> small interfaces to vdpa plugs a signficant gap in live update coverage.
> 
> FWIW, the iommufd interfaces for live update will look much the same: change owner
> and pinned memory accounting, and update virtual addresses.  So adding that to vdpa
> will not make it look like an odd duck.
> 
> - Steve

I think that no one is working on it - Cindy posted some rfcs in January
("vhost-vdpa: add support for iommufd").  Feel free to pick that up.
What you described is just more of a reason not to duplicate this code.
And it's always the same: a small extension here, a small extension there.
If you can make do with existing kernel interfaces, fine,
one can argue that userspace code is useful to support existing kernels.

-- 
MST

