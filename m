Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031A80C0B
	for <virtualization@lists.linux-foundation.org>; Fri,  9 Feb 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501657; cv=none; b=hQvaAA2xBD5wzKGhjQqOB2lE71okkjZSWkYKSAOtI1dtYjr6k+nRgQH2pxqmDFR7/ZfG9p4IqnU+kbvJRwiylowsntDJgKm4OZec/MbJyQn8W50INLexISAAf02JFVm1GXUzH7XdEJkdaM3Oph3yaROWEkgWFw3+Fk+ApuMep7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501657; c=relaxed/simple;
	bh=QRdZxK7Tu+cNFBLPSs5931EMt7+QiU8yFs+2dn34QJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzUj89QCrQCcFec3zBCF9ueEP5HdVxXE0o0bJWz+aCjvA6/cKEIcHoDIqznR+3buMOaG4veg6sa465y0kDHPm1K28yOf/EMtQF/Sj2Qw7uPgbDcLZD9r+RZEsk7jPp4Pto/hS46b3EVh8lStADzazrQWEqixJcJ6JPVdWTpxEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqUD/e53; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqUD/e53"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B37DF41603
	for <virtualization@lists.linux-foundation.org>; Fri,  9 Feb 2024 18:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WOYmQo25NSXy
	for <virtualization@lists.linux-foundation.org>;
	Fri,  9 Feb 2024 18:00:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C58DF415F2
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C58DF415F2
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GqUD/e53
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C58DF415F2
	for <virtualization@lists.linux-foundation.org>; Fri,  9 Feb 2024 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707501653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ylu12OBeg+Qpx23OaATwkmagVevzhUpZSCqsCihw3M=;
	b=GqUD/e53kiwy30+rjCXKE0BD5EhgAtz7Emwkf2PKZmvqvOnDYoNaqwIaOYYxtWUyvbeR2m
	TVEJg1C2MNn1F3UHj0NHvyligiHVRnhSIsyB/DpzVgC0YgI3RSsASN6cIOpX3ziKgWcEbt
	Wrm3I0uJF8RV9+v1U3kebgd1CnkokdE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-rCs9F3cfNxSSoouy34pqDw-1; Fri, 09 Feb 2024 13:00:50 -0500
X-MC-Unique: rCs9F3cfNxSSoouy34pqDw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363befae30fso9786435ab.1
        for <virtualization@lists.linux-foundation.org>; Fri, 09 Feb 2024 10:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707501649; x=1708106449;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ylu12OBeg+Qpx23OaATwkmagVevzhUpZSCqsCihw3M=;
        b=ZJuLeNvcXZKtVbDjecT9sCbaf2/z8WQmoanC79ljXbal3wWXXE9mUoFwb2xQ9QcWm2
         qjB6McFIBQt0l4d33rhiCJ2K0WssSWxmECwljdK2bRE8F0mJ7kiSACwEgH8GNzqERqRk
         4Ks58pDy5f+4ReoxRFfNkQqHYn2fqv6zvY0IO/peU6ZEQ6lv4IKK1fAoQHz84QUS0KDn
         AZRlF8g1zOCU7CTwY5ih5JkAvq6YKaIFX+iHGGNfW9q77qtVelOjIAcwgipVQa1AAsIM
         +KBjfkVrLHPj5h6ZTFp7hPtFmDCLkkRWI83I410cFhFxrALrySWKFXkW21StlnkN+RUe
         4i4A==
X-Gm-Message-State: AOJu0YzhoNB2Q9btyNQK4UAmTYICtSG0tVQopSvKrNG9tJbPw1H8aPmX
	kBQEydLidwtyl6TnA2PNm7F8LAQDdLPkTvQQfXBdo8mdNeE4NTcq8557oVHg85Zt3KyYdhjKNua
	ekZEWXQLQGpvDvsmdL0BlUrL9S8DKp3sM7Km8hHCRfvwE0jVhmy2shhPlLbyOlKqnFjyZxnn53h
	x2Ecw=
X-Received: by 2002:a92:d6c9:0:b0:363:dec8:fedd with SMTP id z9-20020a92d6c9000000b00363dec8feddmr2458772ilp.12.1707501649236;
        Fri, 09 Feb 2024 10:00:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDO1vhR55/MuZNOdx0iksnkDWQ4ps5M/OOsVIbd4hXwhhNB2M2/k1IJDQuW5bFi6ICBG0vJg==
X-Received: by 2002:a92:d6c9:0:b0:363:dec8:fedd with SMTP id z9-20020a92d6c9000000b00363dec8feddmr2458749ilp.12.1707501648980;
        Fri, 09 Feb 2024 10:00:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqTJ/AvYob1YGJIkPFFnbJSol62E5jK8DLlHBvkHgShAo6XP0ctsRuUoesVlHBjb6e4e0aleLFOqwvNApbP7bEkl55EiBjbpWCd+hpcV9lQoQnJ84HC9cx74g/N0/GjpjaNjz3uNAGUHah07yVF3y5X9//E65OBmk0/fTxkznB9KJC8x0A4z/XArB1QQvXa2r0QnAWci5TI3lS3Etr+3VRzwBNL8bNUbhX2l2vd5CHFykn+xLxcYY3srpcvzslAjWTfa/1R0jhGdGZfKOFp/cZku8AijaF+QWImVPUnlqkFT0ZvTa7YqV3xJmeR/n5z1SUBuPdiPPyI1Q6dqRjfkqQg2vAPURr+mKZvlbjAXD0r1rwntYjy+RZOh8cpcI5o0gH3Gpo6aT8J8P6WmIpmBJSE2iRxWHiQGIg9+V6QALh9JiT726dFcVG2t/S06EL/l8bP67i6WRGXZQGrFnp6CIbi64bgeyVkq4Go+U9pi6WEpQD9lLaGugXmvrjT1ndcwWM3UEhrw7TU6VCWJythFdKMhxVomh/tPHyeOn/1EdyKqnXInkRYsv8MlI77/qpepBaEMwDAHA8C288wh6wIi6aAlDaosIBqSfmo97WvVKfrmgLFShUYpqsjWM9NovkKVKW+kHVRLGZ7Shvlv6duNG0fpOpnmTuv3Gat/fFDmzfg6IvCAHESrzoJWxUecrejb0J58G15ceEp2mP9nTyvI2j711FTLKYdLyYWjRB33Fv77lPo6u56A45ZtK4QrFKCIYWXZJfzyKDqhzjoeevuoVYrZQTVCGMYJlxAVGQGpOiUdTGEjKMFEAs
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id z9-20020a023449000000b00473535d00absm108437jaz.16.2024.02.09.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:00:47 -0800 (PST)
Date: Fri, 9 Feb 2024 11:00:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "clg@redhat.com" <clg@redhat.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>, "K V P,
 Satyanarayana" <satyanarayana.k.v.p@intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "brett.creeley@amd.com" <brett.creeley@amd.com>,
 "horms@kernel.org" <horms@kernel.org>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Alistair Popple <apopple@nvidia.com>, John
 Hubbard <jhubbard@nvidia.com>, Dan Williams <danw@nvidia.com>, "Anuj
 Aggarwal (SW-GPU)" <anuaggarwal@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v17 3/3] vfio/nvgrace-gpu: Add vfio pci variant module
 for grace hopper
Message-ID: <20240209110044.0cb6707d.alex.williamson@redhat.com>
In-Reply-To: <20240209171903.GQ10476@nvidia.com>
References: <20240205230123.18981-1-ankita@nvidia.com>
	<20240205230123.18981-4-ankita@nvidia.com>
	<BN9PR11MB527666B48A975B7F4304837C8C442@BN9PR11MB5276.namprd11.prod.outlook.com>
	<SA1PR12MB71996EBCA4142458E8BEE367B04B2@SA1PR12MB7199.namprd12.prod.outlook.com>
	<20240209085531.73f25a98.alex.williamson@redhat.com>
	<20240209171903.GQ10476@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 13:19:03 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Feb 09, 2024 at 08:55:31AM -0700, Alex Williamson wrote:
> > I think Kevin's point is also relative to this latter scenario, in the
> > L1 instance of the nvgrace-gpu driver the mmap of the usemem BAR is
> > cachable, but in the L2 instance of the driver where we only use the
> > vfio-pci-core ops nothing maintains that cachable mapping.  Is that a
> > problem?  An uncached mapping on top of a cachable mapping is often
> > prone to problems.    
> 
> On these CPUs the ARM architecture won't permit it, the L0 level
> blocks uncachable using FWB and page table attributes. The VM, no
> matter what it does, cannot make the cachable memory uncachable.

Great, thanks,

Alex

