Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B992E3372
	for <virtualization@lists.linux.dev>; Wed,  2 Apr 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608412; cv=none; b=B9+4BBG3Akb1kIR/hqExKtze3cOLfJQPBewDhv6p8O4squ5vz+Wf4ec+Vm3TQvdJkm+x48TrT6vQYpCGADbu8Z2Y9SZDTbM7t6Q8+lVTwMRzhV/6RcZ8DaYQJhU8XF82zoHf+1qnR+PXirrVWZM7+/31SUpi7L8jbXZzvQwD4sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608412; c=relaxed/simple;
	bh=Pbq1dx/OnJbPO7NellCFhQ39y6lY/rmd0Eej3PvX2s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xxn91TVScYN6TDVy4yHntkOoXQUDXkUx2fs9aLCofk3R72bjXwLJqirLy+hJkQUKpD69wQYmeU6V1epYKu9Vn1yn47zqeDwmc4AsAwJQe1ucODjSHZgNscudnTndTwtpCamogZHxbPOH4ZGdWFtX45WiYbmjJHwkmYxq+bOCnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hqghdk3L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hqghdk3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743608410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6nUx7Vl7EvSuoWp742ECf14m48HpSY6aOAHXmisq0nE=;
	b=Hqghdk3L0WmHFcqIgTcvZIObcQtFIOPDXqyJzhtw4sP+OYgYlcBt65Qcg6f41sPuHUpPzk
	wxTVE+Pebw4w0Ztk97/1ro+7uTpRgJ2x8UoSeHcrvx/qHJBG9FDyr51gjeiXdK6KcJdyLd
	k3kVnXF7ZQ+ujhVgpytXyGvGXkyCRTw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-wFMdoC11O9G1echZi_dmVA-1; Wed, 02 Apr 2025 11:40:08 -0400
X-MC-Unique: wFMdoC11O9G1echZi_dmVA-1
X-Mimecast-MFC-AGG-ID: wFMdoC11O9G1echZi_dmVA_1743608408
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so51944375e9.2
        for <virtualization@lists.linux.dev>; Wed, 02 Apr 2025 08:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743608407; x=1744213207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nUx7Vl7EvSuoWp742ECf14m48HpSY6aOAHXmisq0nE=;
        b=NCBrbtFRnkzSiE/qyUtZo/FEJMnDFIYSAYCPzNpy0k+lc2jSceQzEb3rtlfbDrBv9D
         Fbe3wEY0/S9+k0gWQmIkFvG7NzxYsZXwdJa0ZnBKzu49eLHxGV+XCJS9reeZoJbu/495
         p3uKp/OHK8CjRP2RGwisgRTQfQ/Qgj+wWPr4+I4jeUdbrD05q3nidBukBy1LgsFwHKxi
         LM87aThM93D+k+P9HCEM2VrJxNCoq6C1m6kprfso5/C5Jtwxlb7rGgqLGIhA6hA3oxRV
         DJ2VeKY2REXXjUSGe3rqOXuvDznjiDM3TAyzNczt9uOlPcXQ8dl4GKQxD1v/TPN3L9ST
         /GrA==
X-Forwarded-Encrypted: i=1; AJvYcCUFxIr6JmxM65NZuLhHTxou56Gc/bmTd06KlkRfhYY/lFvOacqCGzT39NeNQY25CEw47j2SJm9969WC/jbINA==@lists.linux.dev
X-Gm-Message-State: AOJu0YynzXD9aIEgotpDlmdSrOOhULxqOGIUUGZOPiuXxc8REg+P8rk1
	qgAzmE68y45AhiYccHxQI4+0yvb7ra+lpimNlK9TVxHL3plhklNHD9IG9ML9pUlRgLGs5up6bCN
	KOglBqQawxHA+L7o2z0YJFvc5dl4/4igjCKGOdabMoycOiaGL41W6Wq4M4XOFKwQRGDu57q/P
X-Gm-Gg: ASbGncv488YxOC0zNzcU9ZXKMcQsO07z7x9flFVUuq/hRzZknOJOS5W5nT9CJtRuJlP
	nC4MxHtryUrpReQfuFVkLJ7RHlkqToaex9oeo+5+h3h3VwroHlcwg+wvJC2YuiQ9HekIU+7kThb
	ZizDNlSMb8Ie5osrcY9JCOQ66pNV1lHRlnK5jO6POkyX+qdEMFggpW2FsJjdBqwCFJLpC0N/99e
	o7sE0aZlF67/s/mPM2oNiOsIis2HVFIz/ufcNZYKQMATTNztr0OWqHACfl3Q5qkHn0T4VPz3htJ
	WsMVWiko4w==
X-Received: by 2002:a05:600c:190b:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-43db61e0327mr166905445e9.4.1743608407271;
        Wed, 02 Apr 2025 08:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnFH42jKvsNA+QiJsZ/dd/OiaMejjhtC78pMe0Jb00FkOJVLLyR+cxJWkaCicl8B+/i2omrA==
X-Received: by 2002:a05:600c:190b:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-43db61e0327mr166905175e9.4.1743608406852;
        Wed, 02 Apr 2025 08:40:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb5fcd489sm24265995e9.11.2025.04.02.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:40:06 -0700 (PDT)
Date: Wed, 2 Apr 2025 11:40:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Subject: Re: [PATCH 1/1] virtio_console: fix missing byte order handling for
 cols and rows
Message-ID: <20250402113755-mutt-send-email-mst@kernel.org>
References: <20250322002954.3129282-1-pasic@linux.ibm.com>
 <20250402172659.59df72d2.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250402172659.59df72d2.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kcdRJ-X90TSvZSzIR1WXX2z32sNVgYJUt08wNJ13GHg_1743608408
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2025 at 05:26:59PM +0200, Halil Pasic wrote:
> On Sat, 22 Mar 2025 01:29:54 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > As per virtio spec the fields cols and rows are specified as little
> > endian. 
> [..]
> 
> @Amit: Any feedback?
> 
> > 
> > Fixes: 8345adbf96fc1 ("virtio: console: Accept console size along with resize control message")
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Cc: stable@vger.kernel.org # v2.6.35+
> > ---
> > 
> > @Michael: I think it would be nice to add a clarification on the byte
> > order to be used for cols and rows when the legacy interface is used to
> > the spec, regardless of what we decide the right byte order is. If
> > it is native endian that shall be stated much like it is stated for
> > virtio_console_control. If it is little endian, I would like to add
> > a sentence that states that unlike for the fields of virtio_console_control
> > the byte order of the fields of struct virtio_console_resize is little
> > endian also when the legacy interface is used.
> 
> @MST: any opinion on that?
> 
> [..]


native endian for legacy. Yes extending the spec to say this is right.

-- 
MST

