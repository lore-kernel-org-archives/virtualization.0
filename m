Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1A6E602
	for <virtualization@lists.linux-foundation.org>; Thu, 22 Feb 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633900; cv=none; b=Q8WWwY7hAFT8PI/M3XHQHSRXoeSXlOjFHSGCRs+iYAn+d2KCSxbe/l4DvE/8nto1pv/pmpjUNnhxGweKUb606ini54MazXC12wcQzcNeu3lM7eDFGJz7qCU2lLuB59Iupp2UmdgYqBpSBg3TwGDSRvez3qASUQek4dvpVG9uwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633900; c=relaxed/simple;
	bh=frCw0vw8Hnz0wsAVXoXZBwpSJ02lJS7FmLNaWilu4gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eqWrSkqie83Nj91Jqv1GI4o3mpBEzOTEJvZPZnS0/gRFh1NLrZ/M6UmOXdJs/AvWOPlhkHhJeRsX7MHGgt1OU6ADa48bd7HYi1YAp8bnsVXCVNoZwKL/st6kF9XRX5hpRU4IPgMs9Cuqc4d453irCbZvDBR4E3jIxLO6qiI44xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0hXCybI; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0hXCybI"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 610BC8201D
	for <virtualization@lists.linux-foundation.org>; Thu, 22 Feb 2024 20:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n0j09nsdu1UZ
	for <virtualization@lists.linux-foundation.org>;
	Thu, 22 Feb 2024 20:31:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2C9EC81FF5
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C9EC81FF5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0hXCybI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C9EC81FF5
	for <virtualization@lists.linux-foundation.org>; Thu, 22 Feb 2024 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708633894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ml62MscfXMtib2J91KWEJozUo6pIGfLxBFp+YKWAR2g=;
	b=M0hXCybIr9+UYyuHYWGuXrEvGRc/ujldFcdsPMFEKI4ALXBDqdGKkpJnXM/+NyZY1yD6Ul
	TAvp5NWSHr2dXMo2Lw2pjBImCIsslTuXvxsUkhzKru+DiVfP0tCbdR5/woe7Ija4Yu0UUj
	cI1d4SUGSM8tHoeEZPNjt5qrcd6ZFNE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-Xlx_wRS9OZC9fLa-1aebWw-1; Thu, 22 Feb 2024 15:31:32 -0500
X-MC-Unique: Xlx_wRS9OZC9fLa-1aebWw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e53200380so642615e9.3
        for <virtualization@lists.linux-foundation.org>; Thu, 22 Feb 2024 12:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633891; x=1709238691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml62MscfXMtib2J91KWEJozUo6pIGfLxBFp+YKWAR2g=;
        b=e/pH9GYuByEZNDGJ1QuNAFKvjaUAO8PKq58T7uDbM+GJB7vF63/PayOhGP4xAkWKlA
         HdF5A6zMo2mGfVigNtYByoe9Yz5XeDmiOioMljap6Trr6lWfyW2R0w1G/E7NThnXm4T1
         QLzPT9CEnLD3BwGZozWSE1753Ky2GyGxN+scChuYEKKxGwA350NLPVe1DtDq/iBMgnc5
         PG0tHPfW/9luwSqmbKPaSV/fS/vc6mKeojT4sT01jUvG0f34f98CWlIQG9mDgrzRMLc+
         uwsuxXNwQ2zTpGIfbJAjMKcC+NL6BhR1TJZdQlAkiVS593WGCKsIhMEU9ydQqXuRp+bR
         MZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCXe20i79G5VQMRTub6vKEgf1wqXImBOskBszPM9PijavQsYeQrhEaGCQLqVcY7+cHDwILH5hhY2r5qmSPC2eo+yXUvz9DkolTIe+mv4a65ah6DnwTRNPgfv/A==
X-Gm-Message-State: AOJu0YwvmX0pc2vw76XTnJHX3YsiWJgrUb7hbZV1lCFPXssCaF5Zspbn
	DijTuWwjm8A4NOTc6+aSLRQuNthxjcERF5XvJR3Rndy7yj4hXjXbSD1EFDvc7rAFXHeGdoZXV9F
	T70nulZ6zbtMwU1wsIrJLF2VSXcfPG1L2refBUbm8p0c02IZJ266HZo6Tf3/kOSFid2wdfQRjao
	VDoW4=
X-Received: by 2002:a05:600c:3790:b0:40f:cf69:3e1a with SMTP id o16-20020a05600c379000b0040fcf693e1amr15985750wmr.39.1708633891748;
        Thu, 22 Feb 2024 12:31:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3FdHXFce+xg3CWNOl2GOEfrJH/lTzsntzdD95OUI8gjyeZM+JSJT1saB9k7R5eAvOpdv2jQ==
X-Received: by 2002:a05:600c:3790:b0:40f:cf69:3e1a with SMTP id o16-20020a05600c379000b0040fcf693e1amr15985739wmr.39.1708633891400;
        Thu, 22 Feb 2024 12:31:31 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c298100b0041069adbd87sm7218365wmd.21.2024.02.22.12.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:31:30 -0800 (PST)
Date: Thu, 22 Feb 2024 15:31:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Message-ID: <20240222153106-mutt-send-email-mst@kernel.org>
References: <20230922154546.4f7447ce.pasic@linux.ibm.com>
 <ed47fb73ad634ca395bd6c8e979dda8e@huawei.com>
 <20230924193941.6a02237f.pasic@linux.ibm.com>
 <20231101092521-mutt-send-email-mst@kernel.org>
 <5d9ebbdb042845009b47e6a9ee149231@huawei.com>
 <20231102091548-mutt-send-email-mst@kernel.org>
 <6e1792a31c1646f4a301faf1a1b42cc1@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6e1792a31c1646f4a301faf1a1b42cc1@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 02, 2023 at 01:25:31PM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Thursday, November 2, 2023 9:17 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: Halil Pasic <pasic@linux.ibm.com>; Herbert Xu
> > <herbert@gondor.apana.org.au>; Jason Wang <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > linux-crypto@vger.kernel.org; Marc Hartmayer <mhartmay@linux.ibm.com>
> > Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from irq
> > context
> > 
> > On Thu, Nov 02, 2023 at 01:04:07PM +0000, Gonglei (Arei) wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > > Sent: Wednesday, November 1, 2023 9:26 PM
> > > > To: Halil Pasic <pasic@linux.ibm.com>
> > > > Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; Herbert Xu
> > > > <herbert@gondor.apana.org.au>; Jason Wang <jasowang@redhat.com>;
> > > > virtualization@lists.linux-foundation.org;
> > > > linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org; Marc
> > > > Hartmayer <mhartmay@linux.ibm.com>
> > > > Subject: Re: virtcrypto_dataq_callback calls
> > > > crypto_finalize_request() from irq context
> > > >
> > > > On Sun, Sep 24, 2023 at 07:39:41PM +0200, Halil Pasic wrote:
> > > > > On Sun, 24 Sep 2023 11:56:25 +0000 "Gonglei (Arei)"
> > > > > <arei.gonglei@huawei.com> wrote:
> > > > >
> > > > > > Hi Halil,
> > > > > >
> > > > > > Commit 4058cf08945 introduced a check for detecting crypto
> > > > > > completion function called with enable BH, and indeed the
> > > > > > virtio-crypto driver didn't disable BH, which needs a patch to fix it.
> > > > > >
> > > > > > P.S.:
> > > > > > https://lore.kernel.org/lkml/20220221120833.2618733-5-clabbe@bay
> > > > > > libr
> > > > > > e.com/T/
> > > > > >
> > > > > > Regards,
> > > > > > -Gonglei
> > > > >
> > > > > Thanks Gonglei!
> > > > >
> > > > > Thanks! I would be glad to test that fix on s390x. Are you about
> > > > > to send one?
> > > > >
> > > > > Regards,
> > > > > Halil
> > > >
> > > >
> > > > Gonglei did you intend to send a fix?
> > >
> > > Actually I sent a patch a month ago, pls see another thread.
> > >
> > >
> > > Regards,
> > > -Gonglei
> > 
> > And I think there was an issue with that patch that you wanted to fix?
> > config changed callback got fixed but this still didn't.
> > 
> Now my concern is whether or not the judgement (commit 4058cf08945c1) is reasonable.
> 
> Regards,
> -Gonglei

So what is the plan to deal with the issue?

-- 
MST

