Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E62D3A69
	for <virtualization@lists.linux.dev>; Sat, 11 Jul 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785144; cv=none; b=FFj9FRYAcVCMsDT78RvJSIAVTGT/819NsmpgibvgIUAV+q681aD//1uRUyVvMSLn3fhEybZynve4yehIMQ9HcxW6ZvYA10T/Y5T29RP092H2jD4FQ5tpk291Q7ndl/V3RzXMkM0vG12L6jMQ1qXdfRgqcEJKey/GigKsgLZ01zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785144; c=relaxed/simple;
	bh=lCnQkqEcnAuVhVKI8VK8T1Nky8MXYsIIAssTgtxhdA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=asnpuNIXt/RYQNUSkov8lZCyPKHKCVGhWrXVrPDkzyjIwACU5sCp/UMXz5WoejCVgVhkHIzsrbl+k4yKSJUsv6a8YcQZz764BmYiMTJvP5Pw7b4g8bId7+kuOsrR8l1uzMTHKIN2SZR2IwTuIC3m02qxktBjQdOlPqKXz/WOnCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HT35FGNM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT35FGNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783785141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GQsJAkqOxpmPMDLvAmr6k9Ihtgwa7qxpwDTrH4YfZ0=;
	b=HT35FGNMhLLxx2tRhBsITrCo5/zjuED4XwrVet8L6a3Y3ZDOY0OFqiggik1f9eO6JK9ufH
	IDz5gfHF4WBSa9Xfm/QHxLXy32+k52pWK7Wkl1aJ1lKTAD05B8KKGAJc6JNgkAlq54L/Rv
	l7y0kPe6Hpl7FOvXdDFzdLvirYpEjUo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-AlYoGKuOO_OLp5OcSVRbNA-1; Sat, 11 Jul 2026 11:52:20 -0400
X-MC-Unique: AlYoGKuOO_OLp5OcSVRbNA-1
X-Mimecast-MFC-AGG-ID: AlYoGKuOO_OLp5OcSVRbNA_1783785139
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bdf90adaso14168675e9.2
        for <virtualization@lists.linux.dev>; Sat, 11 Jul 2026 08:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785139; x=1784389939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8GQsJAkqOxpmPMDLvAmr6k9Ihtgwa7qxpwDTrH4YfZ0=;
        b=c0VeSSHYs5ypNvb1JfGIZdtwUisM2caU6KXp1m0sXED7pUzWfHdLRBoFRCFTYFJ5C4
         hKl3Q9ff3M6eorvjGuLZC59h9nfepDw3vPEGVxfDna1tkZyQlvOac8OyIyoJnwedR+yw
         vUyrijumVKyGEkSZ1vqBNFTbj3RuyEYGVKYyf9V14bntrpWOa4FjWcv5075sR3zmV2en
         klkQrzAr8GPoJBCZx2nshCq0WM4gDolIDRqhUhS8ESqSVUVzpskSvHI8AexqaI7X04LB
         7dCamuyrwTEESUt3jTRvInlAI6X4rg1wltoczceEPJgdPmE1Pac6V5moKJBzxnmsXcAs
         FWbg==
X-Forwarded-Encrypted: i=1; AHgh+Rp335uz2C9ygy2A420GclKxIU9BWxuEE1BIwe2I5eVjy49H/sILOCXD8vcrioq0IFc9yZUyzbSYSb29bpqdMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye4BDa1i734/I/Nxvz6sc1os1BuZNxF88JK2EXXzQyLWyYKo7x
	F9+A5+MAC7pBB/xVaBPoelVp3B3YlE1UqDg1onhpV6RzCwwitvzV2iqzc+hLDakPhRw/48I1yXl
	ZUtiV1tNJNc/eVLEm0CFr7b8l63DVVcIXEtE6oTH+BHpQ7DIdoNro7P8Sn7/WYvOljPGS
X-Gm-Gg: AfdE7ckl0Oz9JrMqMlm0tMu2VqjTJPERu515xxY7XX1VwBo9JbFii1iLNPa9bAUnpF7
	2sEvY6moph48tHygcRiZJbScGVJSq8gKB1iNNv/U2s7TBu+HwacZRz7DzXZj7XIKIp9O+tefbqZ
	d/bLDVyQ+UziVVQlMayiq1fq7zOURZYjjg9S/qDywpAWnCZw2I74SgX1T/3k40VlCO2+64AGQq8
	8iFq+x9b98bbo8qNTrXk2uzfXBcWtwEA90itYnrW1Eqlx3WUhH5P1ecz5XJ7V7kMfBDguhcUi3k
	qnhLXjHtdgLjOdgIX3d8FkX0PKOJv6yheesbIb9/O2+ityStx6DcswroafZECa6cxS4hFSxJA6Q
	u8c+cLhFLOUkaxNzDt5AoY/Gk/03+fnYy7/6ggawoVw==
X-Received: by 2002:a05:600c:310f:b0:493:d115:d835 with SMTP id 5b1f17b1804b1-493f87d5800mr26790725e9.8.1783785138877;
        Sat, 11 Jul 2026 08:52:18 -0700 (PDT)
X-Received: by 2002:a05:600c:310f:b0:493:d115:d835 with SMTP id 5b1f17b1804b1-493f87d5800mr26790445e9.8.1783785138430;
        Sat, 11 Jul 2026 08:52:18 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f373csm375363835e9.14.2026.07.11.08.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:52:17 -0700 (PDT)
Date: Sat, 11 Jul 2026 11:52:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virtio_net: validate device stats reply records before
 use
Message-ID: <20260711114248-mutt-send-email-mst@kernel.org>
References: <20260711150754.2918392-1-michael.bommarito@gmail.com>
 <20260711111503-mutt-send-email-mst@kernel.org>
 <CAJJ9bXwUtQ3pHqZ=AMuwaNLs16pmujiMdeBQtB5kFc6JjM-Pug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJJ9bXwUtQ3pHqZ=AMuwaNLs16pmujiMdeBQtB5kFc6JjM-Pug@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e5BzgyuHWq7IFsdPEfMz-brtwzlUzK17saWVs73RV2s_1783785139
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Jul 11, 2026 at 11:29:56AM -0400, Michael Bommarito wrote:
> On Sat, Jul 11, 2026 at 11:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > Why does it "matter most", or at all, there?
> > Host can always deny guest service. In fact, this is how cloud vendors
> > charge their clients, by denying service to whoever did not pay them.
> ...
> > I'm all for making things easier to debug even when the device is buggy.
> > But I'm not inclined to add tons of hard to maintain code to
> > that end, and I would be worried broken hosts will come to
> > rely on drivers working around them.
> 
> I am always confused by the CoCo threat model to be honest,

Confidential computing? It's vague at points, given the term covers a
lot of different hardware. But one thing is clear - it's about
confidentiality.  DoS by host is empathically outside the threat model.
On any virtualization platform I know without exception,
host can just exit the VM, done, service denied.

> since it
> seems like some people care a lot about maximalist reliance on the
> contract and other people are more practical about how many other
> vectors exist anyway.

I don't really know what "vectors" or "the contract" are here.

Making a guest recover from a misbehaving device has as much a chance
to reduce security as increase it. So the only benefit is
robustness for users/developers, not security. And that
has to be weighted against the maintainance cost of the change.
This one is too costly, I judge.

>  No hard feelings if you want to NACK, but at
> least it's documented publicly now for people to consider.
> 
> Thanks,
> Mike

