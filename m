Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C07146A79
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455781; cv=none; b=qTVMMriY183Ih7QGkLqO6gyJ5IrXJhwH6Qsnk+rG3cyDHBEXVvjwDXfWEVY6iYzl3t1WvOSSgQAawvKL4ZS07wDRMBfzx336bOHa4avSM+wORENeXV44i4jOrTXvp2jZapjaIWK3zEr3I+CC5qUfr4nLtvkBha9VkDsdU1iIF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455781; c=relaxed/simple;
	bh=39Ok3aZtiGyAkg4DskALCfPqlmoQpaapP1QZtS597l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhGbRB3l0Z1YZwF1oHnOtpeV0/NqDwoOO1JBjsIdLA/nN1Y22MX9zfZQQX+phwre4Mp+HmZfrp+tVAHlzXPx27FZ5y2p6tIXvd37KOq3QAa/1MArBjodBKqYkX06eJhWObFrlpVw16AVteEjKYT/RbZ/5kM5mrIwZHH2iTunatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cvYtw7SY; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cvYtw7SY"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8419240598
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 16:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-7Ml2xhVaNX for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 16:22:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 27EF740511
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27EF740511
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=cvYtw7SY
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 27EF740511
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 16:22:57 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-79f0c08aa45so106808785a.0
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Jul 2024 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720455776; x=1721060576; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka0gK+6TRBkr1g04M4X3WeamKoRpIybVWjVNgzYyEOk=;
        b=cvYtw7SY/HIuGpUg4Z0T6bHJtTWNIqBqQYWPdy58w5tX3ISS5NpmLbw3xDjNOKwtCn
         sAmZGz0bzcgCnYqCIKJVvo8WtWk1fG7zXw1xfeUd7vls32p99RyBjNHjYAQboodBWl91
         LbZHVYFGSBZiBuH6ZcEsnPIsIq62CTClN0IWg7RZWvzvEOzfgy5Pq8b/IWJloi4qGzhw
         ptlJxMcGgtQxJLQG1m6rj2eY609y/JICpv/2nphXbC/Cu3W7cdylQP+tn02gIYrZYVo3
         ZWZKRMfh+jaCT/rvJm+RLtdt6qPddpMY3edPFe1lXjCZRSKqe0keEYFHWcu+ffryecZm
         e/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455776; x=1721060576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka0gK+6TRBkr1g04M4X3WeamKoRpIybVWjVNgzYyEOk=;
        b=nQdFkw+89wBuV6YtG/UlJxzvtGx2qwgIQ0xD/ruyKwPUk0NDTOmtgSx3wIunKcI1XU
         UyqJIPsywXjNqd1dmw8lyo4rRn17i3VZox+pPP7auI591eKw198bzg+9LsYZAmeDoIt+
         Kb6KzwmNLKoSM8+wXtDMN5GPvCWe5SiRgM2YC47sNUlSmKnNSml04wU+XlgVlM/R025R
         PtiOXLjar+/P9al1d6cMxqRBFx/zWl43kCgJE1NfMHVcqeemvCDDBHCH3NFmorIn+NNt
         94B0R5I9QP4tafC+y41Kx6xe0h4wRuBpMcNM1yqqNzixNTkfh+B4HI2OxY5SoixXKPed
         J7xA==
X-Forwarded-Encrypted: i=1; AJvYcCU2C6JSyGisSAZC3ML9WGxHOHMo5mhrJc4ek0swBmkHoV0L2c80KF1EEUXkyuYQSgyehsyqCwo9RQxcIdnt3rZ37Q2hdT3jZLMhXiINMfyBoWVduKbix+ptcw==
X-Gm-Message-State: AOJu0YyiqSjlKjhgvksDVp/4D+T/HV55EGnS78iYT+tLGjl+8CWyxOYL
	HLcuLo/zEGZmiWwX1ueLfllZldNT5VslZxREYecYXuSeS2gzB87ETa39I1iC/xE=
X-Google-Smtp-Source: AGHT+IEWk4zyOjmKegu6Ou87+AD0hzX/bn+Dtu9fsIyTz6kLGJ/J3j+Jl6yX9VsoZO3luJTYUeKCCA==
X-Received: by 2002:a05:620a:1b:b0:79f:1731:ae24 with SMTP id af79cd13be357-79f19a65363mr2034085a.32.1720455776575;
        Mon, 08 Jul 2024 09:22:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b4c57sm5520685a.132.2024.07.08.09.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:22:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQr8h-000S83-1x;
	Mon, 08 Jul 2024 13:22:55 -0300
Date: Mon, 8 Jul 2024 13:22:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240708162255.GA14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
 <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
 <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fc7f5bb1-25b7-4a5f-8d6b-1fa17b1af534@linux.intel.com>
 <Zoct3LVVHhDNbPBT@Asurada-Nvidia>
 <BN9PR11MB52760E55FE52C5B670AA75058CDF2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760E55FE52C5B670AA75058CDF2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jul 05, 2024 at 12:49:10AM +0000, Tian, Kevin wrote:

> > > > > > > +enum iommu_fault_type {
> > > > > > > +     IOMMU_FAULT_TYPE_HWPT_IOPF,
> > > > > > > +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> > > > > > > +};
> > > > > > >
> > > > > > >    struct iommu_fault_alloc {
> > > > > > >        __u32 size;
> > > > > > >        __u32 flags;
> > > > > > > +     __u32 type;  /* enum iommu_fault_type */
> > > > > > >        __u32 out_fault_id;
> > > > > > >        __u32 out_fault_fd;
> > > > and need a new reserved field for alignment.
> > 
> > Hmm, what's the reason for enforcing a 64-bit alignment to an
> > all-u32 struct though? I thought we need a reserved field only
> > for padding. The struct iommu_ioas_alloc has three u32 members
> > for example?
> 
> yeah please ignore this comment.

Sometimes I encourage it so that people notice the if the structure is
changed later. Almost all structs here are 8 byte aligned. It is OK
like this too.

Jason
