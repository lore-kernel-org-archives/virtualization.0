Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29AD433B9
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LQBBy9+B"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 443CB60AB1
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 17:17:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 443CB60AB1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LQBBy9+B
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c25PXlM1N727
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 17:17:45 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E903960A5A
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 17:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E903960A5A
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-42588e94019so11035981cf.0
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Dec 2023 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701969463; x=1702574263; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfZC4BeoCbD48i78H7pAT4Ky0OQzCC++X2uJD5yU/sg=;
        b=LQBBy9+B9RSOgfiTOEixPiHFMuDd5Z4Y/fAaTX92w1YUwoOLL5E+7t2+dbcFKdNClN
         V4dWxJjih+qq4kCeix1nzZ65knL5bcUOeuGvVN+fqStJSKSd+wiqW9a6q3UzmEz9TnOZ
         mqoOQTuMZYp112ehodoat5XxCnvmf2+Y5ClB+Q1RbyaAeS9JrpRe/KC6Rq2ZQnsLj1eB
         6q5QuJhlGCDyHtO63O8bMzAKuiyt11VbOqF/r4G40ps+pc/JQoA4z5EKwe06AQ4IRCfc
         FidA3FMwDlQUYA1kOcgk9y+zubDcl2CHwIXbUnbHGwp3MWAKxDHCgIDPwH/RqyXA9JH/
         tb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969463; x=1702574263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfZC4BeoCbD48i78H7pAT4Ky0OQzCC++X2uJD5yU/sg=;
        b=TY0JsnDypYp7B/9vvXpa00+teO0aowyug0DNUBjeVV6wI8UrXzr6jgWgcUEzBs8yHx
         Fr97mzPhEX+zgjpeob9v1Tg8gZZrefF625RCx1uOnxBVBa3sNWUES4GThGPDCJO4Hk88
         pT8FztXgfg3szmInl4NxUz5+6Pul8fCzK6kDWdKI+3dIMkRKYKsy0EuvgxK97TY9KKcb
         dEkHM9B9+vLTKuFsiFeXAA2nQevrxC+fem2kArIRmV0ATvKWH4hyvALEy9a7M9dQhEy3
         oIRPbKPVbErWPGtQCD196dY+tjUgtFeCUodV042QhBydKbS38ZIzNyzzEJJTFCzVMCMQ
         Dziw==
X-Gm-Message-State: AOJu0YwRiEOYRbam99vAQDMHaU1RGrJzhOBTjeG7dwuHRAiZWtI1HAkf
	Qp7o/6hh6ent6E7r0f6tKwNosw==
X-Google-Smtp-Source: AGHT+IFZla2NtPfquQTzU6hdOuHOkG1umIFAlj7i5uyx6faPcX4R7PtWVD+lIF+qCRz3hijffJ+Kvg==
X-Received: by 2002:ac8:4e83:0:b0:423:e097:3b14 with SMTP id 3-20020ac84e83000000b00423e0973b14mr6734973qtp.10.1701969463718;
        Thu, 07 Dec 2023 09:17:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id n2-20020a0cec42000000b0067a10672b80sm66393qvq.48.2023.12.07.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:17:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rBI0M-00C1FU-8T;
	Thu, 07 Dec 2023 13:17:42 -0400
Date: Thu, 7 Dec 2023 13:17:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231207171742.GU1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207163410.ap3w4faii6wkgwed@localhost>

On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
> > @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
> >  	WARN_ON(!list_empty(&fault->deliver));
> >  	WARN_ON(!list_empty(&fault->response));
> >  
> > +	fput(fault->fault_file);
> > +	put_unused_fd(fault->fault_fd);

> I have resolved this in a naive way by just not calling the
> put_unused_fd function.

That is correct.

put_unused_fd() should only be called on error paths prior to the
syscall return.

The design of a FD must follow this pattern

 syscall():
   fdno = get_unused_fd_flags(O_CLOEXEC);
   filep = [..]
 
   // syscall MUST succeed after this statement:
   fd_install(fdno, filep);
   return 0;

  err:
    put_unused_fd(fdno)
    return -ERRNO

Also the refcounting looks a little strange, the filep reference is
consumed by fd_install, so what is that fput pairing with in fault_free?

Jason
