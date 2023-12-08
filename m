Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D61B27C
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlculCWy"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29B6781E6B
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 11:35:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29B6781E6B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlculCWy
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Pxw-4Guu5X5
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 11:35:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 689CD8187F
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 11:35:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 689CD8187F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702035341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56LbxjAYxWjvG44Vq3GcHH61dclQGaGcbqQRT67zl+k=;
	b=MlculCWyMVXemfKf27DvP/Pc4105SQsOrzLpUcszZG3whP95aa4fB36yKfqbVKpG6Eq6DI
	0oUjEEGF4VQR2xbnq/hN91MYVIbP5DycOodHCRqYFO/5DM7eRl8qUdBx4gdXX4mnTXF/Ps
	5Wt5ahGd8M+WONd9fYxoW+yClWPVWcs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-ErNhTIuUMiawao47mzafCQ-1; Fri, 08 Dec 2023 06:35:39 -0500
X-MC-Unique: ErNhTIuUMiawao47mzafCQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1d72320a33so125353966b.2
        for <virtualization@lists.linux-foundation.org>; Fri, 08 Dec 2023 03:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702035338; x=1702640138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56LbxjAYxWjvG44Vq3GcHH61dclQGaGcbqQRT67zl+k=;
        b=An9l7xaCAY4K0OnzLEx1UxfzFzw/adycjGb6Mc2J66PaJbMX27ASKbsOShR0VZUXJb
         u56Amz1nEBItrPKZJPqZD7FvwmSs2gg4U+rCY31FsK8Z6dK2xADRNnwdPu3zIhZFsjDt
         IX3+6T4QxYrB+xdoZrVVquxxRqlg3W4CYOzMxEib5utD1+acHcfldm0rUImXYeUWcS7m
         unGNXM34XggCe0xC+foaP9/LVTuVXXPR3+K1J7KczW3sIIIKpyZjfOxASnQqcSfGOdoM
         yyta53o7JE4mYY3Adf1c90ngVO9/p4qITJfg6HPDBzau2uO0gRiaAy1g2qNNvwnQfBoT
         YasA==
X-Gm-Message-State: AOJu0YymlLrOaxcFxL+a7gFtdPKwAhChUyHkqpGk1ByhH+fnh1r+7895
	fxhFHOnFwSMNY1CVNE+yWnzfHcbBJe+bbQ2YWr0ELEcd1kTKMi1KCHXnRnL9KmaV92Ks90JMJO4
	4o//aASpxZrZ+VFyU6OVnAy227DEx3+8+Gy02aloMDQ==
X-Received: by 2002:a17:906:189:b0:a02:a2cc:66b8 with SMTP id 9-20020a170906018900b00a02a2cc66b8mr2833875ejb.14.1702035338427;
        Fri, 08 Dec 2023 03:35:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIwMj2tOIobb8zgpJMmlUrCA0d6r8aJyQc86j4Rx04MnRIR+/iDl1ClyT7OuhvjQNv/lzFpQ==
X-Received: by 2002:a17:906:189:b0:a02:a2cc:66b8 with SMTP id 9-20020a170906018900b00a02a2cc66b8mr2833871ejb.14.1702035338098;
        Fri, 08 Dec 2023 03:35:38 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:7466:b10d:58c8:869f:7e91])
        by smtp.gmail.com with ESMTPSA id cw15-20020a170907160f00b00a1937153bddsm898831ejd.20.2023.12.08.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 03:35:37 -0800 (PST)
Date: Fri, 8 Dec 2023 06:35:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jason Wang <jasowang@redhat.com>,
	Wu Zongyong <wuzongyong@linux.alibaba.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vdpa: Fix an error handling path in eni_vdpa_probe()
Message-ID: <20231208063520-mutt-send-email-mst@kernel.org>
References: <a7b0ef1eabd081f1c7c894e9b11de01678e85dee.1666293559.git.christophe.jaillet@wanadoo.fr>
 <72a89724-9dad-499a-a0ed-ad9d046d235d@wanadoo.fr>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <72a89724-9dad-499a-a0ed-ad9d046d235d@wanadoo.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 07, 2023 at 10:13:51PM +0100, Christophe JAILLET wrote:
> Le 20/10/2022 à 21:21, Christophe JAILLET a écrit :
> > After a successful vp_legacy_probe() call, vp_legacy_remove() should be
> > called in the error handling path, as already done in the remove function.
> > 
> > Add the missing call.
> > 
> > Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >   drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> > index 5a09a09cca70..cce3d1837104 100644
> > --- a/drivers/vdpa/alibaba/eni_vdpa.c
> > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > @@ -497,7 +497,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   	if (!eni_vdpa->vring) {
> >   		ret = -ENOMEM;
> >   		ENI_ERR(pdev, "failed to allocate virtqueues\n");
> > -		goto err;
> > +		goto err_remove_vp_legacy;
> >   	}
> >   	for (i = 0; i < eni_vdpa->queues; i++) {
> > @@ -509,11 +509,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   	ret = vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
> >   	if (ret) {
> >   		ENI_ERR(pdev, "failed to register to vdpa bus\n");
> > -		goto err;
> > +		goto err_remove_vp_legacy;
> >   	}
> >   	return 0;
> > +err_remove_vp_legacy:
> > +	vp_legacy_remove(&eni_vdpa->ldev);
> >   err:
> >   	put_device(&eni_vdpa->vdpa.dev);
> >   	return ret;
> 
> Polite reminder on a (very) old patch.
> 
> CJ


Tagged now, thanks!

