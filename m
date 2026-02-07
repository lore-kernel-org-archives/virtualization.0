Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D42222CC
	for <virtualization@lists.linux.dev>; Sat,  7 Feb 2026 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458525; cv=none; b=YOdMBkbFXZiq4GVniqEI3b/HDfn/bNBf7Vi6AbMItmamMAuU/3B8lZmFnw9CVNQswvSzEcs57cwFl5nA4gNGlQkWEcWQ5JRJNfRMEZSUy7UIcWmZBVT/nPWiMO4WM0mxW6/hnoi68fzqAyqYnazBFSh5OXPLfBto+RRyBnAecuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458525; c=relaxed/simple;
	bh=alBBNiHKr5Pm0+hZd8jm5+Fidbd+LvAXEPwf19/p9z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A+P9czqMyShCCOCMb5Zs4uTx9c5Gp8LvGx0Qppfo4v8hdM5PPozE4O2tFJaBskPMQapeUGVVBQm4dhiiuNr67e1L/PiqjjQ87tpkUOR+vcrvAA4CfdWJoWDG7yeAMUBeK/1gFNK88UFWMnSDbvjtyUXlJGY5AdcxqiN5oyJ4g/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdUCdync; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdUCdync"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770458523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UT5bIrKTvZeJXWmYoolrxZm/cNKxL1SPj9tdfZAy9/Y=;
	b=OdUCdyncfK5mzEF2UNEZAMD8QWMRqIns2FdGuQDPUmixjG5kzjkaxQsVelaK0GBhiYJx9I
	XE3aWcDgpQpWoIUn1roRVIlCjUdHIWi7/u7O+51hY1n6u189L6LK6AQmnYfFtysXRYTbIQ
	T2OU9X5CA8T0CN8jRiXZCV7VVM4ETeU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-k00tkJelPAukujICxNUprQ-1; Sat, 07 Feb 2026 05:02:02 -0500
X-MC-Unique: k00tkJelPAukujICxNUprQ-1
X-Mimecast-MFC-AGG-ID: k00tkJelPAukujICxNUprQ_1770458521
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435ab907109so2202537f8f.3
        for <virtualization@lists.linux.dev>; Sat, 07 Feb 2026 02:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770458521; x=1771063321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT5bIrKTvZeJXWmYoolrxZm/cNKxL1SPj9tdfZAy9/Y=;
        b=CoJZmQFPdEJOKVCwPud85JZGATcKl/GznK3dCGwqad40UcqrYnZyMDlu4Yr8vZ2Nhe
         Q01vvm6pvSruzrzLEkOv5f6m6NA/Ahm50CAbt/3WM7YvFhgcHnanIRtQ8M2JgEtTQzU5
         7aIDLDBGuwknhW5dVn1Jj+Ph9OV6xJjV2ktBJpa/jX/+PeE/W5MTrWA02xkUF45TKIyq
         vg5o8KlD6aDbYN9jn3wC19I3vtKH1ki0l/6getuOL/ufCAoT2twt0GmUO58HTRh/NWu2
         msZO1QP9pWRTOSfzikOUM2VnyOfeJ8TJ9kM7NetNe2NyAufaQTUWkGpZQRs067uV/jI1
         1VcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8WmVgTYZLlKO3DbmQovdEBXO54/F3HkBcK69lYcWD5wpenLDKgT61voviNyWy7AxlqMKEcd+VBvyFQAULhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTN/Lhn2cMaNChW/2Y+L0LgikaRwZp9hPNcfYxbF4FJE+hjwRu
	te38Ef5FfYcSyq3PZulKgKRoQ+vNausCx9AB4Ifs3q8Q2Y6I0fEa+FTOi7Ti/ZKrAbIOBlJCYmE
	zELjDWZg9HLjxyRbnLMYCEFVx1BGLef8DCvbPDtwyCRyofok7gXFXFAWrjy7APD+i7vXX
X-Gm-Gg: AZuq6aKgS6CERH72nnt5x7PnxQUfbd+JttAz0cxCfBNmlNMeMMD9SxQ8SS7rG38wu0x
	+OzCkuhRoJqAkz6Bw4ZkDJmTM1ZU+o2Ynet9/s9VNATGZFkvLQd/fAgpMz2skGPhSQ9zFPN6RK8
	Y6g2l2TPzsdFJxVP7UYP2MfWKQ3ADUaK3Ox9e8HOyAbRSVVuad8Z45h1CjMQVdHvtuDuw7qjBQK
	VPIOKlrvAD2Ibpc2k0XetPiIZOvG4vIU4GUATunbdE2OIMG0He4+UR9m7VK9dWUVmfZQzcG7Dho
	GHFLRCXI+AwKRJSFNR7gLUcHyMi62o0on9OElV7JdNFZJN59kOedWQhLaD8TOQb5clsIutZPlxy
	fhjG+NPnOm/NBOCsn5KBefC641jr+R/j06g==
X-Received: by 2002:a5d:5e01:0:b0:432:c37c:d83b with SMTP id ffacd0b85a97d-436296590a0mr8522790f8f.20.1770458520553;
        Sat, 07 Feb 2026 02:02:00 -0800 (PST)
X-Received: by 2002:a5d:5e01:0:b0:432:c37c:d83b with SMTP id ffacd0b85a97d-436296590a0mr8522747f8f.20.1770458520048;
        Sat, 07 Feb 2026 02:02:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2ef1sm12662561f8f.7.2026.02.07.02.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:01:59 -0800 (PST)
Date: Sat, 7 Feb 2026 05:01:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260207045848-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205184328.3b706154@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260205184328.3b706154@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8wKP0-FCEGkbSfVsYh9o7Dh7NiG4F36wuk8GJqqRJYk_1770458521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2026 at 06:43:28PM -0800, Jakub Kicinski wrote:
> On Thu, 5 Feb 2026 16:46:55 -0600 Daniel Jurgens wrote:
> > This series implements ethtool flow rules support for virtio_net using the
> > virtio flow filter (FF) specification. The implementation allows users to
> > configure packet filtering rules through ethtool commands, directing
> > packets to specific receive queues, or dropping them based on various
> > header fields.
> 
> This is a 4th version of this you posted in as many days and it doesn't
> even build. Please slow down. Please wait with v21 until after the merge
> window. We have enough patches to sift thru still for v7.0.

v20 and no end in sight.
Just looking at the amount of pain all this parsing is inflicting
makes me worry. And wait until we need to begin worrying about
maintaining UAPI stability.

It would be much nicer if drivers were out of the business of parsing
fiddly structures.  Isn't there a way for more code in net core
to deal with all this?
-- 
MST

