Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF82321B8
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AqvDQqBS"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B5CB606EB
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 17:39:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B5CB606EB
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=AqvDQqBS
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwOnj7lrNuj6
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 17:39:28 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 75E4660608
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 17:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75E4660608
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-589d6647c6cso498710eaf.2
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 09:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699465167; x=1700069967; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fez7d2oD0jqA877WtYGemcz1mIG1xNotv9HuUKl17lg=;
        b=AqvDQqBSff8gsI6ZYStIRTvdDn0v/BoAvKFoeq3Fs4Q9mc9GLo7rvy5udJ6nu5u+1s
         01IVjf8t/R375i3bMOHXe6GplZ678L+sI2AAvhBNzD/uX6WVXQaae8cymKdLIG38ebuV
         PfxXwg07r5IkBArbUAyI6PNjj1wIfyXYpAsi3rE4DYrEgJHebuA1NsZV2JCvFrOhCjfF
         CMqCtjFjMQDRfwPyFZHTFPMVNWXqrILOoC70Z71x0+bTGQMgeNnsoRSJQV3c8vdLyYDy
         o6AVoApln9ik1v/bd1Xhqpta2nfLJ2F78mwHjO+DtEdmUoL4gFSyRZFbtn/YfwZtZgMR
         4kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699465167; x=1700069967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fez7d2oD0jqA877WtYGemcz1mIG1xNotv9HuUKl17lg=;
        b=FKqmLEecR5rBjt4C6w7tyr5bAxY4dj2TG0VJGectVMHWP+8No+521tqG8eXHuVw2bI
         hENlBuvvqbdYelW3nTaIGcGMM4CQdGKxVGE/u+rKMIYxDXnvk7nDpBmRRUhuyep4qQJ+
         OhgsBo9rCcK9hxLqg+3+QLLHn9cJokKWABmsTespJOekwQDZP8gKzCcM/Ds2Q7eiocWN
         21Ro/AARZwA2YFSVGuec12/QOjKXdTjNTCC7FE1fLHVygiOmGMf6PNt5piwG+k9RNgVp
         uM546bxiulq2mjk+n6xmNMiGNNNTe1PuA0SA++sOmt/y3jsFfM+u+eaCPD1hV88mma7e
         PjdQ==
X-Gm-Message-State: AOJu0YxKfvAuX1hDSfxgFA0LH7ErD6d9jWCJhKQIOBRoo69EElVAU95K
	S4+5qtz3xM1bgsh0qhCVvLyl1A==
X-Google-Smtp-Source: AGHT+IFej9NZgQ/+2LjPp+xoxu9RiYGW6gMR81sDvfm8bHBPH21cB7z0X7CwypR1KBJQgpyCkOlg8g==
X-Received: by 2002:a4a:e282:0:b0:57b:de27:28ed with SMTP id k2-20020a4ae282000000b0057bde2728edmr1987087oot.6.1699465167350;
        Wed, 08 Nov 2023 09:39:27 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id v15-20020a4aad8f000000b005737ca61829sm940312oom.13.2023.11.08.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:39:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0mWS-001gwa-G6;
	Wed, 08 Nov 2023 13:39:24 -0400
Date: Wed, 8 Nov 2023 13:39:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231108173924.GF4634@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231107175405.GD4634@ziepe.ca>
 <BN9PR11MB52764A460BEDD56A56290BA48CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764A460BEDD56A56290BA48CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Nov 08, 2023 at 08:53:00AM +0000, Tian, Kevin wrote:

> > There are many events related to object in guest memory or controlled
> > by the guest, eg C_BAD_CD and C_BAD_STE. These should be relayed or
> > the emulation is not working well.
> 
> so that's the category of unrecoverable faults?

I haven't looked exhaustively but I do have the impression that the
only recoverable fault is the 'page not present' one.

> btw I can understand C_BAD_CD given it's walked by the physical SMMU
> in nested configuration. But presumably STE is created by the smmu
> driver itself then why would there be an error to be relayed for
> guest STE?

If the guest programs a bad STE it should still generate a C_BAD_STE
even if the mediation SW could theoretically sanitize it (but sanitize
it to what? BLOCKED?). Since we have to forward things like C_BAD_CD
and others we may as well just drop an invalid STE and forward the
event like real HW.

> > > but I didn't get the last piece. If those domains are created by kernel
> > > drivers why would they require a uAPI for userspace to specify fault
> > > capable?
> > 
> > Not to userspace, but a kapi to request a fault capable domain and to
> > supply the fault handler. Eg:
> > 
> >  iommu_domain_alloc_faultable(dev, handler);
> 
> Does it affect SVA too?

Inside the driver the SVA should be constructed out of the same fault
handling infrastructure, but a SVA domain allocation should have a
different allocation function.

Jason
