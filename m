Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF221D541
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y1uSmZOL"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 267F34012B
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 13:41:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 267F34012B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Y1uSmZOL
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swrUZPxSIw7E
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 13:41:42 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D8350400CB
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 13:41:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8350400CB
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-42548f6c552so12148001cf.2
        for <virtualization@lists.linux-foundation.org>; Fri, 08 Dec 2023 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702042900; x=1702647700; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YucZctI9OnES6g1Fy1Wtf0Z1+OcLPgAF9qFfV1szyvI=;
        b=Y1uSmZOLLi8BMub41xI5MjagtJQCquO6JdJb4N/7KyJx80tGYxZfpgO0FxrWl4l7j6
         Q8fLV10FyKsfk1w4PzfOzB4GNb0olbR5owao7w84aiBnihzMK5CRZHDDKmWeOO/y0jfF
         FmSog7TMuDw2zjRrKPIgMXfKSkR50a/FpmJ2CiGZzwZLLbof6c2Rfw6Qy5h2H5r6U8tn
         0JV1X0IhlmnKI/XPu0WHHQ/eouLxUQfLJS+pGWM5171NF0XfkSe3sx1+ESJQzPAtfog2
         MjmlUwtBzubnv4M+ZxM61yuLF2pG0FIl9uxKfQ/2RJDZR2uzUWNeq6gpNegeIDuqzEbZ
         cpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042900; x=1702647700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YucZctI9OnES6g1Fy1Wtf0Z1+OcLPgAF9qFfV1szyvI=;
        b=EHr11wkNClSz7QUmCl20dy84cBjTS5MC+qRghTTW+z3TsYY/SQEQG8zZm77qnL1nrI
         6RmXyozxhafEY0ITUdU81rzFBOkUpWvTk60wo62n5XY4H1nofkok/IEDG0NU/Fe2aqxA
         vF78JY20IkGGtbh3dffpMR74sAXyKOds3G2xnaAaD7vgJPVDC2d1yKLrdZzBgKyKHxbH
         RbYO/AtBmzhXLvBOn8YV6XnXIrCjs/pIu/kii16Utdg4ntyodj0sdJ3mopGK5OyVnFVk
         86TSp8VvquVD4jVBNXzzsOnpHjNotEUBGlIvhQpxzQAhqYrWNjr95DxThaQExntBJWhT
         /+7w==
X-Gm-Message-State: AOJu0Yz9QszlL/QkrArN9GuxZMjSfRTLltEZL+xmXidqsaBsLMImK/Da
	Zm9eCvXznfVFojVMbGH9+IKKjA==
X-Google-Smtp-Source: AGHT+IHjZ5fbgyGNj4pXddo/yd/fsGP0DpJlldXMV869RcUAC8mCOG4RaDWeA5g67kLmuW+2zDsrMw==
X-Received: by 2002:a05:622a:1708:b0:425:4043:1d77 with SMTP id h8-20020a05622a170800b0042540431d77mr105008qtk.74.1702042900661;
        Fri, 08 Dec 2023 05:41:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id cd5-20020a05622a418500b004255fd32eeasm543901qtb.7.2023.12.08.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:41:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rBb6p-00C88X-Fn;
	Fri, 08 Dec 2023 09:41:39 -0400
Date: Fri, 8 Dec 2023 09:41:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joel Granados <j.granados@samsung.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231208134139.GW1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
 <20231207171742.GU1489931@ziepe.ca>
 <c72184d8-693d-43ce-aed9-00a8fc684137@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72184d8-693d-43ce-aed9-00a8fc684137@linux.intel.com>

On Fri, Dec 08, 2023 at 01:47:35PM +0800, Baolu Lu wrote:
> On 12/8/23 1:17 AM, Jason Gunthorpe wrote:
> > On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
> > > > @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
> > > >   	WARN_ON(!list_empty(&fault->deliver));
> > > >   	WARN_ON(!list_empty(&fault->response));
> > > > +	fput(fault->fault_file);
> > > > +	put_unused_fd(fault->fault_fd);
> > > I have resolved this in a naive way by just not calling the
> > > put_unused_fd function.
> > That is correct.
> > 
> > put_unused_fd() should only be called on error paths prior to the
> > syscall return.
> > 
> > The design of a FD must follow this pattern
> > 
> >   syscall():
> >     fdno = get_unused_fd_flags(O_CLOEXEC);
> >     filep = [..]
> >     // syscall MUST succeed after this statement:
> >     fd_install(fdno, filep);
> >     return 0;
> > 
> >    err:
> >      put_unused_fd(fdno)
> >      return -ERRNO
> 
> Yes. Agreed.
> 
> > 
> > Also the refcounting looks a little strange, the filep reference is
> > consumed by fd_install, so what is that fput pairing with in fault_free?
> 
> fput() pairs with get_unused_fd_flags()? fd_install() does not seem to
> increase any reference.

fd_install() transfers the reference to the fd table and that
reference is put back by the close() system call.

Notice that instantly after fd_install() a concurrent user can free
the filep.

Jason
