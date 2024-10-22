Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D71A08C5
	for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606321; cv=none; b=p8YBsMV4hiW1MsPYhl+d71j7KhRjmDuRTPXGFCAkDfucbs43j5cYEt7R3ai2Frvn3VBNKqZpOlqHdNeUv9aUGudlIhOeyVlQ95Z/ltG9fZwIsVzd9PimaKaB1yTjxsFZ/6wOYdLQmdC5pTW3wb5+R/dGuKL9FASmW42ZxMgDVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606321; c=relaxed/simple;
	bh=BFTMl93wn0yvR1WfKRCvWyDSqDubERJmJh1AZ0eZ+zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrokawGdu5up11FnXd3iPzWYkD3mQjIavtNsw/VYrSMA8t++YuNXhncNUfj8C1Lthj62GoQ39NoRiqOHBXaXwx74gghwPIt/2cw870a/NZG9PyrN2HWaImAu21wAzz1xfnKDtAaGbEdcApnBE0HoDgoT8xNTTpNrh7KOacIy/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NR0jndWD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NR0jndWD"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbc28f8e1bso41795506d6.0
        for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729606317; x=1730211117; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qhll7IfNOfUrslv0JS+DDYY0+c54jassaWQ2ezcVZM=;
        b=NR0jndWDB1kXNRyFx6faaEiin/kjAHt4xHJSjXPhsrKxHw989qIi6QyjT2sdilGKf6
         lhowwzlTvRdAQsNPrJuayoXT8Zf1fo/QYkiTgNHRrevILLVEu0GBHeZO9oAmaZm8a1Q8
         nE8vEj0vDfjvay/Zs8zFUZwQR7+6kzk3BeUaW35lEx/JZQxhJeclYhqSpN1TYrR+28Bb
         Zxc8D7GLJSmS1g4n8tIUHvVMxDU45sH3y4TsWWp5vyy18QwyrfPc+mzUsNbwuMx/0QA7
         w6GsyaR21+Ersn+b+0Vd8t+FNH35JsCx35TJ9v3sNHR2Fs6YLy8YDH07YbDtGpApOdxU
         Nu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729606317; x=1730211117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qhll7IfNOfUrslv0JS+DDYY0+c54jassaWQ2ezcVZM=;
        b=PoFAu+2wsNefewFcpEf+9HYvwLqvJJovzxTpRGjwTtQ0/zPfutHRSAxheJrjiyeS0f
         CfEDD9O8Wvax5QRX5DWm7IEjzjYjdFfll7e/lymek5zsnQP/Lhbl+v9dJb5WPzKPDKNc
         F9vUqd3IKhqu1NdqOCdq/5zx75ERN1tI/akI+0sofCGDrVUgKUli3bF7ea0iVzRt0p+O
         fwoNkpTvAiMI2aeIiQ087It+mDkqZEbjvKXLxfbtT55BRffKfthUNRwedhrnoiAWrjFp
         hoRhIg6h/wRldC6jrXRs8N3RxJbrRVfoYkPCVHNQLtIgrvW4lbkJtPsmrrV4iQ8RF6OV
         xOYg==
X-Forwarded-Encrypted: i=1; AJvYcCV42DcEGKBWiQfJ2P/1rxs8OYa6wXiRm5d2oc7HrZYS+CDO/0ZJGA1Rvt/zR6AuUh+76mfiCEpL4W/y0dKlzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3khWTcm94flbMJcvtgxsQ76SxZkWFBlaBHtfigQdfj5ldsEst
	ACcQUWVL+54L/q//MANxBpqjMJlpECtOrRX8zvBiqOujNkPg3vxldblRPCRvUio=
X-Google-Smtp-Source: AGHT+IHbw1D8MQDNK0PT64hixmIdaE3j5oH9Y2hxuMJ4+N0WrOEaNeUQS0eLymZXwzrOWOPN26VX2Q==
X-Received: by 2002:a05:6214:440b:b0:6cc:2cc0:ccda with SMTP id 6a1803df08f44-6cde11459a2mr205071776d6.0.1729606317290;
        Tue, 22 Oct 2024 07:11:57 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e4470sm29298036d6.125.2024.10.22.07.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:11:56 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:11:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: John Groves <John@groves.net>, David Hildenbrand <david@redhat.com>,
	linux-mm <linux-mm@kvack.org>,
	linux-cxl <linux-cxl@vger.kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	virtualization <virtualization@lists.linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	qemu-devel <qemu-devel@nongnu.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Linuxarm <linuxarm@huawei.com>,
	"Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
	John Groves <jgroves@micron.com>, Fan Ni <fan.ni@samsung.com>,
	Navneet Singh <navneet.singh@intel.com>,
	=?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <ZxeyrvjaN3peNXhr@PC2K9PVX.TheFacebook.com>
References: <20240815172223.00001ca7@Huawei.com>
 <sjz2xzwkgkq6bun5lssqbsimbggczarotpjdhcsq3itoq5h7jc@x5ormqciwofo>
 <20240819164024.00005a0a@Huawei.com>
 <A4E80580-437F-46D8-A58B-D2F3851D67BD>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A4E80580-437F-46D8-A58B-D2F3851D67BD>

On Tue, Sep 17, 2024 at 07:37:21PM +0000, Jonathan Cameron wrote:
> > * Said mechanism should not be explicitly CXL-specific.
> 
> Somewhat agreed, but I don't want to invent a new spec just to avoid explicit
> ties to CXL. I'm not against using CXL to present HBM / ACPI Specific Purpose
> memory for example to a VM. It will trivially work if that is what a user
> wants to do and also illustrates that this stuff doesn't necessarily just
> apply to capacity on a memory pool - it might just be 'weird' memory on the host.
> 

I suspect if you took all the DCD components of the current CXL device
and repackaged it into a device called "DefinitelyNotACXLDCDDevice", that
the CXL device inherited, this whole discussion goes away.

Patches welcome? :]

> > * Finding a tagged capacity devdax device in a VM should work the same as it
> >   does running on bare metal.
> 
> Absolutely - that's a requirement.
> 
> > * The file-backed (and devdax-backed) devdax abstraction is needed in qemu.
> 
> Maybe. I'm not convinced the abstraction is needed at that particular level.
> 
> > * Beyond that, I'm not yet sure what the lookup mechanism should be. Extra
> >   points for being easy to implement in both physical and virtual systems.
> 
> For physical systems we aren't going to get agreement :(  For the systems
> I have visibility of there will be some diversity in hardware, but the
> presentation to userspace and up consistency should be doable.
> 
> Jonathan
> 
> >
> > Thanks for teeing this up!
> > John
> >
> >
> > [1] https://github.com/cxl-micron-reskit/famfs/blob/master/README.md
> >
> 
> 
