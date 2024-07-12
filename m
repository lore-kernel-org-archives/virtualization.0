Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3416F904
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789243; cv=none; b=kv30CkdNNoPRTV4D2tVj8cELUXYfwd4rRffw0VcqvsmQ9ISHsZaE3b08BM8I4VLp2dR/jcG1zGRBz9wNslonztp7bltzK9FGPD2vYNagyg6SiALI7bkxdeXebkFawW1DeS+D0Rynnr/smMhrqXWkt0Opqk9VO1M/KHdXt7t2M4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789243; c=relaxed/simple;
	bh=4vaan9lVCWHn6tCkQmfCAQNwBS43BDI/yL/E404vsrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1DntB7PJZk1gvuxTh5AVNHHLIZZ+O/7F+7rDNDuoac9/ZZ6yZi9gCIgnt7SwW0x0eSXmEfZOFq3S3GZnEBzuhxf5MJ5b6kwStcBs6Uz7OqM8cYaBa5u4xeQHPT4xzfHw7vk9xu2HXjoKR+TjZaEymaPKekKwJ5Es/VtJwhnNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AY1p1ZV1; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AY1p1ZV1"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42F3C607B4
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJyw4lLo4OJL for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Jul 2024 13:00:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2a; helo=mail-yb1-xb2a.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9907B6071E
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9907B6071E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=AY1p1ZV1
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9907B6071E
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:00:40 +0000 (UTC)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-e036d1ce4f7so1664068276.0
        for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720789239; x=1721394039; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/w0zwGhNPKt9SyZTMl06PaCMjOKZYwYdrSeXLeSiM4=;
        b=AY1p1ZV1csuCF44fg7cJ4v8D+b2nZoR9eZWltDRdmnFoLXsaUBAVl/BKW01qogIuXb
         1QXc4owXNzw9+AvZMDbl40KyjuE4YcANLoAu0jvTiE195RzQBvROF1ehquo8D4GBsW71
         8bsknjPZy1BPojyZ5VL+7fl+JV/DxhzfwcAeaH7rM9TBriVKyiAAC71qQ8uyUIQLn5t/
         BwGylz/BhRTomXGec868KAV5aGxsPFrGiCdepAU6xyGWwLsSMQvtzGx3R9gj35QOEK/7
         d86KTrqrufvLDmNZaG6ZBoIS3g3p0stTx3Io160ErC+Aqw5zR1aqzqFIFb4e61jqNnkt
         S4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720789239; x=1721394039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/w0zwGhNPKt9SyZTMl06PaCMjOKZYwYdrSeXLeSiM4=;
        b=Q5zXdJc78Z1Y7YE4B1FQ3j92aHgI/sg8NFzTARvBUoro7c71fdaS8r1F8zg6OYnTQc
         BsTDd4QoQGiF2ri9v9YKxOWUanMHWC8Pn06+JWIXX82sbseZljToIRJeMqvnM1avaZSV
         NhiWhAO9FV1Ps5NuyPmN5dIaLy4FNXbJcTgAjXkWPQ+AnogSfmg5TgtYDdoD3pbjtnbp
         Oy+gmn4wQCmdz9nJuP9BgYBzt6dBU43L4phb0G5ZUCWgjUepPXMk+/Hb3uEx+ywdhVQ0
         wtjpCxK8CNz6lgj79mds475mIDcR3yUtvYo4tQNsx/PqP4yKsjZ+X5J4a5xcuoQQyP5t
         MSFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV9CEK8I2ykVKsauOhAIJGWazDxKLGmi2t7b+9tPfcjuIGCWQYZh43dRRZDvMELmyhdl+O5zknQuT9mBiQ+19ZLMgqYl8AwRvVLnHDIW8tME8Qu/0iWPkQlA==
X-Gm-Message-State: AOJu0YxQqSutbi9a/kdEpTpxBh9UTK2Z2wJ6+8kpPLAuH8QywijsB4GA
	Gg8aW6ZBzts+OVLGScnlZObXsjw19UqXOAv9nEBQGEdorKCTRrrpusIJn1RFzAI=
X-Google-Smtp-Source: AGHT+IGrtfbkVyeqhWaqWAqPeH9PGe1fIAllaalk3hPaJxwrAsvjR5TxMPnud6p1klxpbKWWS6qKSA==
X-Received: by 2002:a25:69ca:0:b0:dff:2b97:b06b with SMTP id 3f1490d57ef6-e058a4eb6c3mr1874869276.18.1720789238613;
        Fri, 12 Jul 2024 06:00:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bd25d2sm40132481cf.61.2024.07.12.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:00:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFt7-000J4s-JG;
	Fri, 12 Jul 2024 10:00:37 -0300
Date: Fri, 12 Jul 2024 10:00:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240712130037.GA14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <20240708162957.GB14050@ziepe.ca>
 <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>
 <20240709170038.GG14050@ziepe.ca>
 <Zo10duoguPCADKSY@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo10duoguPCADKSY@Asurada-Nvidia>

On Tue, Jul 09, 2024 at 10:33:42AM -0700, Nicolin Chen wrote:

> > We are potentially talking about 5-10 physical smmus and 2-3 FDs per
> > physical? Does that scare anyone?
> 
> I think we can share the same FD by adding a viommu_id somewhere
> to indicate what the data/event belongs to. Yet, it seemed that
> you had a counter-argument that a shared FD (queue) might have a
> security concern as well?
> https://lore.kernel.org/linux-iommu/20240522232833.GH20229@nvidia.com/

That was for the physical HW queue not so much the FD.

We need to be mindful that these events can't DOS the hypervisor, that
constrains how we track pending events in the kernel, not how they get
marshaled to FDs to deliver to user space.

Thinking more, it makes sense that a FD would tie 1:1 with a queue in
the VM.

That way backpressure on a queue will not cause head of line blocking
to other queues because they multiplex onto a single FD.

Jason
