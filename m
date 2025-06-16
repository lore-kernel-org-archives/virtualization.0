Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB51DA60F
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080035; cv=none; b=uqj6pWyjbhx2akE8lFQ9zX8uo5Dkv5fppYJQgJToFw/OmFaF4BxxTS4PnBTDsqhreOy2BqGBtohLCEEClAyKD6EFni3DJEERMOx9jVlW2vMJ9nPykd9o36zOd6qW/H3ZTjebTunsox9Ptdj0icq7lmgGChf1RThFwS+8xfg6WGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080035; c=relaxed/simple;
	bh=KsZELZeWpT03UnkqhlfBW9r1APWyBQkH9RXynD91+cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnACLZ1UR8/+0vQf7R1NJE1cfFXd2TqJaX2HEB0T4oWZDjINqVz08eZPBCY3f1EhEmBmR1US8FiJs33ujVNtj3A8JQ2M7sGUbAvQo2zQsRtivjfklv54Ba+COhoIGlCScqfCpdKluFKoXR7/54xTCveo1elwCf93Dg2C4J293XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XCsTH8Vb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XCsTH8Vb"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fae04a3795so47947686d6.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750080033; x=1750684833; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsZELZeWpT03UnkqhlfBW9r1APWyBQkH9RXynD91+cs=;
        b=XCsTH8Vbats0KJVFUSQc0pik/RaLoOYVb09XtWQosb+p98oE6cVJ8tsL2g7n/rwHQx
         4BxZcOOl2sRcRFHDjo1PEV9XyLf/5NdMjPn4uzDx81RUGVaX0TO3opPuzyjQNgLa2jjw
         FZ7hkYXc2i/DlTS/oUxi9PQTI7yWeCrDCYdFM3wHmOtsLJdGMnd/kS8s93PwJJhpU67H
         WKNvQYqsBfbS7QTK5hZ+7I+IMCDumuvGgxOAldzATxegdSSaWefELIpQ/4bGhClxaWLe
         hBdZF4Cen+glypTZ+MjNtfdL8mUoEcg4XI3bn7SYYX61EzVH5tdBsa9DBp9sVIWljvyE
         Yvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080033; x=1750684833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsZELZeWpT03UnkqhlfBW9r1APWyBQkH9RXynD91+cs=;
        b=uAvC4uy5o2Z7NkzJqkHO2jhl8XEp2VnvdEvavA/LHaRleNvHt2617r5KdFhuy8Q0vf
         7pDnzFUr76DY/rT3AHHnqJZBHCzcDl5Gbw3Q8Hnr/Y4sZHpkHQdYiFtat0wzsR6BR3Zu
         c/ugPAqP/VX2K1kj0nADwYBTUFLHIEvkHetc4PEsrGCgYeQjhy3iSwtwoB0/vOqFDx3c
         kRyFiuXmtVmBkJzSuU6+NsWOEx5X4LUQK0SpdisfvOrs3xB3YX7BXHXCEWJlLa54tpbC
         PzEDkzFgElzrJG7J63aV3PFUy6w823wG04EQpn8YTd1rV2JiWohRdyBHzXNDAF0nk0rF
         iNCA==
X-Forwarded-Encrypted: i=1; AJvYcCVJDAQmwodScG/WM5BHRcZGCXPoa+RAaO/VBsre4xoWTeRJoY9Rg/HOzC71KJl0RNxTiymAi3hUoEWi0ekZhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTFgdXaeM7oNda7YINuF6mlpZ71oaDeG3Y2UdV1A3JPbzVUtbJ
	SPVuP11UF4p/eP33jUs3Gpqha1cCruLMs9DTbmG3UApQLZHVSXNSj/T5VCZTH750aBo=
X-Gm-Gg: ASbGncuvZ/fbMF90wOr1kjzAUgpKZ0NttOeGENkslQighg+KOXdLyf8y3UWcB/hNvnA
	8fwHN/EoEEsRWfaKAWd7+JdZ/5epX+tO4e7fYrcEBJRfC9kZvJEjOO6Qe5Wimgm4PlRn4w93YWS
	yZy1owndG8ArOuZYQvlF9HhLwzlwtBjXTElnmJ5BBn0IgRTGBzFPit1hbbc4OtNJV+757022gS6
	XPnoeDU516o0FAX8aRJ+zF4hUAuonaVf09NvgCg2dkk6Cc6m2QTI9eHS9BUTTpmGS01qvJqVll0
	ANkBiDxI5lJ3HFKQoB7XjkfbJtmM29pYf1q6xjXfR/YUFfCoVmAMzhEs3Zm4IVl/qd0YvcNHIIW
	Z6p15zNwLsm5Xuzr32+JiIZECfmQ6VLcyg6v2OA==
X-Google-Smtp-Source: AGHT+IE1qGI9XHVDxJuyvFi/df2zVObBdJYoDm6YGOjnmbu+H4OWYnM+uHkjohkUfAcq9uWzh1e/Fw==
X-Received: by 2002:ad4:5c6b:0:b0:6fa:c99a:b5e1 with SMTP id 6a1803df08f44-6fb47725fb8mr166833186d6.17.1750080032894;
        Mon, 16 Jun 2025 06:20:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c84148sm50822446d6.109.2025.06.16.06.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:20:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uR9lH-00000005gVt-3sIA;
	Mon, 16 Jun 2025 10:20:31 -0300
Date: Mon, 16 Jun 2025 10:20:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alyssa Ross <hi@alyssa.is>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, x86@kernel.org,
	Spectrum OS Development <devel@spectrum-os.org>
Subject: Re: Virtio-IOMMU interrupt remapping design
Message-ID: <20250616132031.GB1354058@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>

On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:

> Is a paravirtualized IOMMU with interrupt remapping something that makes
> sense?

IMHO linking interrupt remapping to the iommu is a poor design,
interrupt routing belongs in the irq subsystem, not in the iommu.

The fact AMD and Intel both coupled their interrupt routing to their
iommu hardware is just a weird design decision. ARM didn't do this,
for instance.

So I would not try to do this at all, you should have a
para-virtualized IRQ interface, not an extension to virtio-iommu
adding interrupt handling. :\

AFAIK hyperv shows how to build something like this.

Jason
