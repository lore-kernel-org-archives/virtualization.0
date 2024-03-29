Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5139FCE
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703634; cv=none; b=EzPKjL0GvR/ueUgsrG5PXNdE+kCZK47P2RemTVmHWNUb51FknTV27l5QLf0xf7rMK7boGKBB2kpx5f8pmGQ+DPHd+SwY8rmLUWnB57mxph8qLNT1hlNz3krQ5HAoHO9IWduoy6DVo/cgl+v//bpgt85SikA1BBHrUDUP6KoWtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703634; c=relaxed/simple;
	bh=akT/+1m979mnMY8W24pHHlJgtSiN7wS1/4jpNy67k+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eXZZTooYCpyQlQjl1RBNJTmgQ/UVuOJ38/lUPDM29S6NffNQIHBlJsDQpbnea4zfVz2ycP+SP1wrrruhTtqjSrPN3oTjc+WS+1CTWxhQiKLPqxMCjxN5BMohn/XDs6o/U61ZQy8kR7EJLcUPS8W9M5hJQ0cj5czbNCys/RRw2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3eaCCQ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3eaCCQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711703631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNcjblgFWtJyfRZQGhShJokchfuADezTJbCospP1zbg=;
	b=a3eaCCQ0bPEcx4QUdT8L8llbMe7iZiGiYEmqnJTVYcuJHNvkrJCt8RK5unQ3psybqDz+JH
	9GY3YTD0soTK2sqq+b5IUU0nbaBWAcR8GgPlvtxKJxvWI0WT+oZdBhLDDxVZrbb4DwrpZf
	+MrCYMsMB5dN+tff8OlA4K37hQKWWLI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-zLR0MQIjOmmObu1EbR1Lzg-1; Fri, 29 Mar 2024 05:13:50 -0400
X-MC-Unique: zLR0MQIjOmmObu1EbR1Lzg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41548a69f1cso5420645e9.1
        for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 02:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703629; x=1712308429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNcjblgFWtJyfRZQGhShJokchfuADezTJbCospP1zbg=;
        b=bM9gSZ2OFep1iM3SwaF/e6old74c5TS7MWr2GqszYzc3caa/B46TW/RrOaBrvTq4Kw
         UtjMm5K0f31OcNdoXaKEUyYKeFwL+y9hY38DIjmzksC4ueg2GypzVriUeZwS6CRESx0a
         JhyKidmG0TcoAmjjG9vHaei20lbmXTR9fQw5F0e8NsM9MEOB/Ry7l1As5HZzqkr4O0If
         HExq4y2HDP5DPi9GQV9Oyv2e++nRBJ0ZlljevI3fih+GnmMYaNAm9HDvweNGqFdMgq9H
         H3NOqQbcXgN7VaYB9L7UjGhXGyIdCsDj376+r5WYub2jmXMZXCB1Epru0hNGEPFyXo3q
         qxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAih9RBr6495+N0GmJNd69pnbMqMJ/IzkMdUNEMZoKBij7y7En9rt69XJuKdJA74E5NzUFVuf2aUwgSKDNNIOXYblrfYUr/WXM104Djvs=
X-Gm-Message-State: AOJu0YxvUmYyX8EcrccW051jnZdVJ87bY7QILOMOKXOBQOUtt+YPqYLE
	3nZ09xtIETsPKZOfFD5b6g7rj109mrVE2qSycyb+oWaJRiO9+moV2CyAuxO+1PH3uDV8i3iwXA6
	BpKVCcCObyd+EDvTF05lYWDfQsRyd/vdyodCEMUIYmq/Q0jcDXaBkeL9Zxj1vV1a6
X-Received: by 2002:a05:600c:1c02:b0:414:7e73:1f8c with SMTP id j2-20020a05600c1c0200b004147e731f8cmr1166587wms.37.1711703628789;
        Fri, 29 Mar 2024 02:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyPL8GxMdOr4ky5DOhJ/P8CJcnmJMjnl87YcfQ0EhBPj83zpwUaDSXxDFy2h/tPN+47fKb+Q==
X-Received: by 2002:a05:600c:1c02:b0:414:7e73:1f8c with SMTP id j2-20020a05600c1c0200b004147e731f8cmr1166566wms.37.1711703628288;
        Fri, 29 Mar 2024 02:13:48 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id he5-20020a05600c540500b00414895d014fsm4767231wmb.41.2024.03.29.02.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:13:47 -0700 (PDT)
Date: Fri, 29 Mar 2024 05:13:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20240329051334-mutt-send-email-mst@kernel.org>
References: <20240320101912.28210-1-w_angrong@163.com>
 <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
 <CACGkMEuM9bdvgH7_v6F=HT-x10+0tCzG56iuU05guwqNN1+qKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuM9bdvgH7_v6F=HT-x10+0tCzG56iuU05guwqNN1+qKQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 29, 2024 at 11:55:50AM +0800, Jason Wang wrote:
> On Wed, Mar 27, 2024 at 5:08 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Mar 21, 2024 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > > From: Rong Wang <w_angrong@163.com>
> > > >
> > > > Once enable iommu domain for one device, the MSI
> > > > translation tables have to be there for software-managed MSI.
> > > > Otherwise, platform with software-managed MSI without an
> > > > irq bypass function, can not get a correct memory write event
> > > > from pcie, will not get irqs.
> > > > The solution is to obtain the MSI phy base address from
> > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > then translation tables will be created while request irq.
> > > >
> > > > Change log
> > > > ----------
> > > >
> > > > v1->v2:
> > > > - add resv iotlb to avoid overlap mapping.
> > > > v2->v3:
> > > > - there is no need to export the iommu symbol anymore.
> > > >
> > > > Signed-off-by: Rong Wang <w_angrong@163.com>
> > >
> > > There's in interest to keep extending vhost iotlb -
> > > we should just switch over to iommufd which supports
> > > this already.
> >
> > IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> > makes vDPA run without a backporting of full IOMMUFD in the production
> > environment. I think it's worth.
> >
> > If you worry about the extension, we can just use the vhost iotlb
> > existing facility to do this.
> >
> > Thanks
> 
> Btw, Wang Rong,
> 
> It looks that Cindy does have the bandwidth in working for IOMMUFD support.

I think you mean she does not.

> Do you have the will to do that?
> 
> Thanks

