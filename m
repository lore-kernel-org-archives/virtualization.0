Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C82B2D7
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977183; cv=none; b=saXeV4RxuzMkhyDWHQLkFjjMgECJzwHZ1PItNcRZflpHjRwNxCPXLAFoUF+1tRZTYEX8Umbn30cgk0JEFYNfAr36Au7wx+q/JCVVSPw4iffzhhRAN5qqcCNPvCpPLY9PIh9w2ABRAhR90uqxaWnIRK7BN+IBP/3X5Do41apcy90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977183; c=relaxed/simple;
	bh=MK5JK3spo/EOu3EOGiWabvNo20/6TWA7kB8HJQJpF0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1ufWtHnr3/YRrZa2tw83e/GlmbYo/C5bcEwospTjzfRDhHQlu8adWNf7I2fO5l7EzS7dg0SALWup4RO7mEKZ23w//eQBOOTPtNiBuQ4/kkcyEzjA5qau6MfLZU8ECiKTqbYykp01WEIHT+9KtFLnT/nMfjS7giKFBNXloZrWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fWmsDw+0; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fWmsDw+0"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3318dd36a8fso1961090fac.1
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757977180; x=1758581980; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTycPbHlQtDBtjOvMMJ3SZ6uhxSiX0nO4WaEP9DHCc4=;
        b=fWmsDw+0BnE6NlLN4FV5inuTo9wkAiB5/45Sug+E7vC50uID9CJRlfxsXuX6NyVlcV
         CgmEnjLvdbHoyO12fBSpqIA75mTse5vh5Jg2BqKBL5tr4oipCg78Rt7mpCGwiOACqo69
         lBG+Jh/4vjBoS2jc0rU4PG1BUPZVueXkCNJZkFs/0698ObeAdMV9XTnDzjI1SPyVY7ps
         Ko3WUySEuh/Ymkf3iB0qLsW1tfs2bcw8NRm/2Fv59NZd0OJQeNd/FFiqeILwoe3vLuGr
         pNVEsxMT9jC1ZeojWBl+6YfV5+XqDxmjVxzTOoEooX+xh7GiPgfL0jDfG/C6cc3wjoR/
         bncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977180; x=1758581980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTycPbHlQtDBtjOvMMJ3SZ6uhxSiX0nO4WaEP9DHCc4=;
        b=PFyUfPmo2ZsTOpk7evCP46/C2+SJdA2PN0d5zJLeokuOAvOSMRoAtIKa5HhdMZBX8R
         nS9rchNqY1/oWcwqBKMIZBT/6V+RRg/EchDDPhJsyuL9IRcGiRt2A5FvVlXreiu2/VCt
         n+GTHZDRvDM3H64xUgQSxHw2/g0Rl5ltSrnhCcp//NH0+9+d7gveTzQUYkyoZHN+hhfG
         YlNBzC4ZIioLTVneazL3JV1tyhzKM1up9wra93jWvpXzVWCVbOlHNjn18KeI1nE8SmLs
         WXL/SnwmSGU2uLTOZr3Cyb6BdtE+N9wyPuT8UBuuXM+TI9eoc7gBDCS30DXOqEHCpmVk
         sLng==
X-Forwarded-Encrypted: i=1; AJvYcCVMqv4IrY1PBF8BNJV0X0qcL1vyA4rADBV1gEDhu+0B/opPvPpRM5UcM7kOr0snnKEN8v9eV+WNsHNtmTcamw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz6iZLpenw9xn6OlQfR8uVPyXE8wEROgOh1jr5TMywHf6naF6O
	OxW7VGsReltZWNmWzr9clBH/jySSIyUVbjaCIGhENvwsXUP0IbPWpv4C68VAsPhMgT4=
X-Gm-Gg: ASbGnctZbqnkE+YM3pME+VpT9gWUDkVW0lmbSlKYWk1w5w5SknoJ2+w3KaFeJJ0dvox
	XS/GIpe2IRBn9HUuCycw6HUYf6yloexRTxBaM3vJdPGQECsdpJ0DrU2MieBT0EFdfCQhi2gY1LQ
	zcdmCUxPCS83g4P4EEzjDx0QSjqFCgbTsxrxnD94bIEsA8XXHJjILLxpEwpBXzWgse5YnHVFSyd
	c+bFwTiAeqSPrBtsTMJOvNZ7sLkVsAJuvNBlooQgRBhRuB6ZvxFEJEmSmRookJnAi+euO/vi6Lf
	eaKu1zmgs4GIkQ0gMX4S1XKx6g0dFPnsp91qr9amlS4dhiqCUUB1F5KRHVzDQUDe7UIfIYpd825
	eAmzJvFs=
X-Google-Smtp-Source: AGHT+IHaizr3a2V9CFBUtFDTvOTqaJTANyOfH5v0JTyHH5V9DAauzxISXWz+PQumMIbWbikwaEyCPw==
X-Received: by 2002:a05:6870:82aa:b0:301:a704:ef1c with SMTP id 586e51a60fabf-32e56bc4018mr7508892fac.25.1757977180618;
        Mon, 15 Sep 2025 15:59:40 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3317d74fe33sm1565394fac.15.2025.09.15.15.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:59:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyIAd-00000004YkX-1MrY;
	Mon, 15 Sep 2025 19:59:39 -0300
Date: Mon, 15 Sep 2025 19:59:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, robh@kernel.org,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v4 4/4] drivers: iommu: refactor arm_smmu_get_resv_regions
Message-ID: <20250915225939.GN882933@ziepe.ca>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-5-shyamsaini@linux.microsoft.com>
 <20250909155847.GB882933@ziepe.ca>
 <20250915162842.GA23954@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915162842.GA23954@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Sep 15, 2025 at 09:28:42AM -0700, Shyam Saini wrote:
> > I'm comfortable with this side from the iommu perspective once you get
> > agreement on the DT representation.
> 
> We haven’t heard back from the DT folks or Thierry. Do you think we
> should wait a few more days for their feedback, or go ahead and send
> v5 as an RFC instead?

It is about normal to wait about another week and then ping them for
feedback.

Don't send a RFC, you intend your work to be merged.

Jason
