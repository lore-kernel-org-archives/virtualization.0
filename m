Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148391DF251
	for <virtualization@lists.linux.dev>; Mon, 20 Jan 2025 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372128; cv=none; b=JQIIToEnIfEy4CLcf4Ndw1Ko3qKEXQPPxcS0dPvHcIOnZSCZ1IdW8dgA/pjo16bPTu7DzyM4ncPWJlzAluRQN80Y/U5ue/g9/QsNGCLj9tjIkgMkGQn1Yi71zAKtqts+blO3Xlj3eGvXsXjA2N0GXdTR/s3tRi1GzK8o3Kym0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372128; c=relaxed/simple;
	bh=2l7A7TeV3X8j9mnivi/jkfDMh4Rz8Q2+Ph6/WqDIvQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QynNK72Qz+HP08jGqLEXciAEFD4r/sbpMMQXha9H2N3PcEUewxtECujbBsxXkxrQ3dy+IOX42ehN2zelpWkRTLyb/UB89v+1Nq6phhSdzUlR3m3Ib0825Fz0pTTvtFmIZmQ9kJdVqeZwQj9vIkrQjy0rCNNTqlifSitMr6Vkkc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hvq4mMBC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hvq4mMBC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737372124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDN8/OU5ZPgRjRU42+KPmnKZnvnXStpzfvzO5vgYb6k=;
	b=Hvq4mMBCrwUfOjpue4Ey/W/7SA0T3BC1rhD4VqP99C48HeBVTfKJEhGsh4ilCu7TY0JkVf
	Ye55nqn7FN49vwK6QIN+OZsUHhaEgjxJKvhKrewfbEqiKn2aCq9AHHJbY9KxfjbHEDHQSi
	cTs2P5xO2h/hWZkkGuCcjwyJjr5iEUE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-dGvaHKPmMqu83kR3GWpsFQ-1; Mon, 20 Jan 2025 06:22:00 -0500
X-MC-Unique: dGvaHKPmMqu83kR3GWpsFQ-1
X-Mimecast-MFC-AGG-ID: dGvaHKPmMqu83kR3GWpsFQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so33712335e9.3
        for <virtualization@lists.linux.dev>; Mon, 20 Jan 2025 03:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372119; x=1737976919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDN8/OU5ZPgRjRU42+KPmnKZnvnXStpzfvzO5vgYb6k=;
        b=eSMHcdA9LETPIMNZYBWORkWS30Fz9s0aB2ND7NwLQaKpnZSmiK/5ns253p8Dg8wQso
         LF1dgIfCD7TMnvx6bYUVJqgJvw68QczXPQuwqhcgrlbpxr9efFD1EhFv82cOl4SXKkB/
         puldFnfr6KWT5a4KfTDHitsOA1T5ttvZkmR99/1MiJKURpsyK8iKmnxhQLJ6e9+juTcq
         hWSgufu+yH5qpfMwNit8ZndR6mIJVzLObq7qGeuil87kWHK2qK5Nlap92rrIHpzvTDvq
         Siuz+TCouu8xu/AbXnjih0WNP2h5V/PPssA/beD6S3Wi80SgSejxBYzJGw5cmB7UuG7m
         q36Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0UG2j4njdnL6fkPzt/WgB2RuSPsb6P74TWn9Q/B4wCAQuruBfJ5YVsx59nwkhu8/9J4aDgNnwA6edoZcZQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEXDNqpRrJTrYnoTNU0OW3rrqW9PscuWsAuFrjO3f7syeZzVla
	2JTG2JdpZcHdb47/CpgWMZf88s/PZJcObktkXdMzVR8hLpQmATTCw0b/+d99U8iUNUe43zdu/c6
	Rj//V2TSbtD2GCs2v8GAGXOV/+OWMzEkBWLJzIyX80gWRIiO658M865MiwdVQnXCD
X-Gm-Gg: ASbGnctELrQ+M/j/5Ywy4gK4YCyDff8MSVmyFc3wFLaWdSmXf5hPjmAJtCBLVaA1Lbx
	30oCrwW7XmS9tYfFRRL8S2BENSqlreUtDLwCfJM733GOUabg8E0L1ukH9p/rnri4ZOdnBO03d8E
	oSBqrmc+pT9Vc73KMqSC2geMHDiMLH94mR7nthG84SHqQyId6oSDdulzqvG1b7qGaL1buKCxLP9
	Nx3I//cKRmZGZKRs7R/4vUg8684L7pFOVkJkO6Dl6muu0DgqXhBbgL4T6QYk3I=
X-Received: by 2002:a05:600c:34c1:b0:438:a432:7c44 with SMTP id 5b1f17b1804b1-438a4327dadmr50197335e9.21.1737372119631;
        Mon, 20 Jan 2025 03:21:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWy0kjOQf8h9QWlTFPhEYVIabNW61BmYVmliYWqqxS4FloxqnHQNyYnxsGGp91Bz44zAL7+w==
X-Received: by 2002:a05:600c:34c1:b0:438:a432:7c44 with SMTP id 5b1f17b1804b1-438a4327dadmr50197075e9.21.1737372119178;
        Mon, 20 Jan 2025 03:21:59 -0800 (PST)
Received: from redhat.com ([2a02:14f:176:7d07:198a:d25:1f09:1ff9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041f603sm134587725e9.21.2025.01.20.03.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:21:57 -0800 (PST)
Date: Mon, 20 Jan 2025 06:21:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Philipp Stanner <phasta@kernel.org>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vdpa: solidrun: Replace deprecated PCI functions
Message-ID: <20250120062144-mutt-send-email-mst@kernel.org>
References: <20241219094428.21511-2-phasta@kernel.org>
 <enuhuc7tjc5ez33c23lgzyy2nhiy54lykshlk5xurl4r6ilnsd@qnhrvku4xpxa>
 <e28c7cb2437d2dee73447db2db1d80646803e63a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e28c7cb2437d2dee73447db2db1d80646803e63a.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qDrRb3xMHb6_KOB_obdix0wekYg81mU6AXqjkuTG_pk_1737372120
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 20, 2025 at 10:13:03AM +0100, Philipp Stanner wrote:
> On Thu, 2024-12-19 at 10:51 +0100, Stefano Garzarella wrote:
> > On Thu, Dec 19, 2024 at 10:44:29AM +0100, Philipp Stanner wrote:
> > > From: Philipp Stanner <pstanner@redhat.com>
> > > 
> > > The PCI functions
> > > 
> > > 	pcim_iomap_regions()
> > > 	pcim_iounmap_regions()
> > > 	pcim_iomap_table()
> > > 
> > > have been deprecated by the PCI subsystem.
> > > 
> > > Replace these functions with their successors pcim_iomap_region()
> > > and
> > > pcim_iounmap_region().
> > > 
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > ---
> > > Changes in v4:
> > >  - snet_open_vf_bar(): use distinct temporary variable to ensure
> > >    snet->bar is never an ERR_PTR. (Stefano)
> > 
> > Thanks for that!
> > 
> > I don't have a device to test, but it LGTM:
> > 
> > Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Hi all,
> 
> can someone please finally merge this?
> 
> Thanks,
> Philipp
> 
> 
> > 
> > 
> > > 
> > > Changes in v3:
> > >  - Move __iomem *io declaration into the loop. (Stefano)
> > > 
> > > Changes in v2:
> > >  - Fix build warning because of dead variable.
> > >  - Make "bars_found" a boolean, since only true or false are
> > > relevant.
> > > ---
> > > drivers/vdpa/solidrun/snet_main.c | 57 +++++++++++++++-------------
> > > ---
> > > 1 file changed, 28 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > > b/drivers/vdpa/solidrun/snet_main.c
> > > index c8b74980dbd1..55ec51c17ab3 100644
> > > --- a/drivers/vdpa/solidrun/snet_main.c
> > > +++ b/drivers/vdpa/solidrun/snet_main.c
> > > @@ -556,58 +556,60 @@ static const struct vdpa_config_ops
> > > snet_config_ops = {
> > > static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > > *psnet)
> > > {
> > > 	char *name;
> > > -	int ret, i, mask = 0;
> > > +	unsigned short i;
> > > +	bool bars_found = false;
> > > +
> > > +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > > bars", pci_name(pdev));
> > > +	if (!name)
> > > +		return -ENOMEM;
> > > +
> > > 	/* We don't know which BAR will be used to communicate..
> > > 	 * We will map every bar with len > 0.
> > > 	 *
> > > 	 * Later, we will discover the BAR and unmap all other
> > > BARs.
> > > 	 */
> > > 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > > -		if (pci_resource_len(pdev, i))
> > > -			mask |= (1 << i);
> > > +		void __iomem *io;
> > > +
> > > +		if (pci_resource_len(pdev, i) == 0)
> > > +			continue;
> > > +
> > > +		io = pcim_iomap_region(pdev, i, name);
> > > +		if (IS_ERR(io)) {
> > > +			SNET_ERR(pdev, "Failed to request and map
> > > PCI BARs\n");
> > > +			return PTR_ERR(io);
> > > +		}
> > > +
> > > +		psnet->bars[i] = io;
> > > +		bars_found = true;
> > > 	}
> > > 
> > > 	/* No BAR can be used.. */
> > > -	if (!mask) {
> > > +	if (!bars_found) {
> > > 		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> > > 		return -ENODEV;
> > > 	}
> > > 
> > > -	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > > bars", pci_name(pdev));
> > > -	if (!name)
> > > -		return -ENOMEM;
> > > -
> > > -	ret = pcim_iomap_regions(pdev, mask, name);
> > > -	if (ret) {
> > > -		SNET_ERR(pdev, "Failed to request and map PCI
> > > BARs\n");
> > > -		return ret;
> > > -	}
> > > -
> > > -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > > -		if (mask & (1 << i))
> > > -			psnet->bars[i] =
> > > pcim_iomap_table(pdev)[i];
> > > -	}
> > > -
> > > 	return 0;
> > > }
> > > 
> > > static int snet_open_vf_bar(struct pci_dev *pdev, struct snet
> > > *snet)
> > > {
> > > 	char *name;
> > > -	int ret;
> > > +	void __iomem *io;
> > > 
> > > 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-
> > > bars", pci_name(pdev));
> > > 	if (!name)
> > > 		return -ENOMEM;
> > > 
> > > 	/* Request and map BAR */
> > > -	ret = pcim_iomap_regions(pdev, BIT(snet->psnet-
> > > >cfg.vf_bar), name);
> > > -	if (ret) {
> > > +	io = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar,
> > > name);
> > > +	if (IS_ERR(io)) {
> > > 		SNET_ERR(pdev, "Failed to request and map PCI BAR
> > > for a VF\n");
> > > -		return ret;
> > > +		return PTR_ERR(io);
> > > 	}
> > > 
> > > -	snet->bar = pcim_iomap_table(pdev)[snet->psnet-
> > > >cfg.vf_bar];
> > > +	snet->bar = io;
> > > 
> > > 	return 0;
> > > }
> > > @@ -656,15 +658,12 @@ static int psnet_detect_bar(struct psnet
> > > *psnet, u32 off)
> > > 
> > > static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct
> > > psnet *psnet)
> > > {
> > > -	int i, mask = 0;
> > > +	unsigned short i;
> > > 
> > > 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > > 		if (psnet->bars[i] && i != psnet->barno)
> > > -			mask |= (1 << i);
> > > +			pcim_iounmap_region(pdev, i);
> > > 	}
> > > -
> > > -	if (mask)
> > > -		pcim_iounmap_regions(pdev, mask);
> > > }
> > > 
> > > /* Read SNET config from PCI BAR */
> > > -- 
> > > 2.47.1
> > > 
> > > 
> > 

it's in my tree and linux-next

