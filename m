Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21438F65C
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278782; cv=none; b=Ss0xjggsL35fyDl+dBWPPmFM+kwIMezysquvz4svwCsyL7J5oIs2KXl42vjitEgHu0UOC/1brZE6xSbeC8Djneha0BUaITiMz+m9/X9XpJ501jin+Sshux/leeX1FBk1ZdhVIA5r+f0++X7r73Ew7uNsWW+/xRkrPeSCgg0zQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278782; c=relaxed/simple;
	bh=jwvQtyZYjoqO+V+d2Y/ZZu9UhfvlBMCF8Zdzofz59KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=htT2wXi4v4UgZ2gBgzj3LaFKQL6mTUXtw9hrI0alEmVIT6htMidS6aMwcN4/vZV1BDMBxJ529sveAttuCccQafu3h8IakEPc5XFcjjg4WjCUIRR5pl+S/0U76csa2buKYHfAhbWUr28385uCxLFbSJL69s+JAbEZQH8OhXKmKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyMiL2Y/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyMiL2Y/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784278779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ws+LHWZPq7yqDvagxdcCS+KQIuEQm0ppuCBvjQYIJlY=;
	b=EyMiL2Y/arLkBy7dJlI0i7hjz0cdOHlGPiHY5LyIBOVycNsiacoV4UnbtfvE30xOvg/JdH
	ACgKgbOXZBFDJrUcNkI9IWewmb3iW6/XmXXuNI7pfHX+cwdut3kzdD9jk+flSrkH8GLWaR
	CC5d0Yue1XwJJfel8dHakIBFoW16OyQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-aeFBitpANWGACfa18Djw2w-1; Fri, 17 Jul 2026 04:59:38 -0400
X-MC-Unique: aeFBitpANWGACfa18Djw2w-1
X-Mimecast-MFC-AGG-ID: aeFBitpANWGACfa18Djw2w_1784278777
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4953c5d6d87so29303335e9.3
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 01:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784278777; x=1784883577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ws+LHWZPq7yqDvagxdcCS+KQIuEQm0ppuCBvjQYIJlY=;
        b=H7erQnHRWa1H6psQDYJ1qXzRp0lD975EzSJPZJqaO0eWws4uePJLjJ6KwfX+6tZgIw
         4//d8N0siAb6Ml8NR8iVVxkqtmbinvUAovCEhor825UuJjMSWpeA7YYskE5TxZ1U0qsL
         8Mwddtxml1bnhGcN51t7kgUlN6f+jblK+ElWY4EsrIeBnmmHQsBFKo/O9t3fmQQjyIjS
         ACV5WdS/7B+hg3uDzARfoQT9jRPPvQy0ktMbOYoav/6E78ExNbEEEU8jHcWB+ocAR9uU
         rfn8YeSijyLyUh7/rOvAHzc7xpCNHBGugSXsorDMTS0Ln5ReP/OrxkjbslwuN/TR9Qdv
         ygAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRwFFvHNvpjuijpshA5JjXNVhoESs6S55oVmo8p07BcdeNImM8C8SmYSRTWirByS53sSEEQy5vz+HirJP4zA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVPZVek1LdDlDC3eHWKn7CG2dkFKmGlRA/1jWrDH1bLoNdS3/B
	7Vb4WNw9OVUmovKtgr61D6nyMCb6GIk35265wUUhev7Ntd9iQK+sMorG2tHejT2SIaoe/u0tgLv
	4gKGebp4nDqm7Ie7RVq9XIMJ7YZ7wFqTs0QdT4o/SFDfgcNU0pBGtX8gIMoHse7DKh+uV
X-Gm-Gg: AfdE7cnDIeLAvIQvnomaTusT51RRh+DurQHkL/rS+psIbfvqb7jjK6Ac01OBu3YWOeg
	BFEUigeeIjjGCtNoTlbeeHWWL5PvWUA+dJik3GBwDIS1+FKBUXN2vEeyIlN0Fp4+nYxI+DW/QlR
	xp5OMKMRiuDpCDb0fJlYmZtsEnrPa/b+KFyvek9C0wOjttx87+JYvzAYc2YdXWpFzz1YeB+MFI9
	7LTz5Uod5gBY3N9hImpymJ6ZozRQ7qaugC0zjz65obw1OZMWEgbp9AMpvjL3xjRUducMXyZLSgc
	MscLBP4aDYpkKjz1IfzfS2ytfy1QkiQC3WMdi49naIFgAnHVJPp3vJG6HOa9dE9MmACAsY5oN0L
	eH0xXzuSG05ZTu7vJPR0L09s1
X-Received: by 2002:a05:600c:1f8c:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-4954a3e6e29mr17609225e9.5.1784278776648;
        Fri, 17 Jul 2026 01:59:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8c:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-4954a3e6e29mr17608835e9.5.1784278775975;
        Fri, 17 Jul 2026 01:59:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954966a033sm28237155e9.0.2026.07.17.01.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:59:35 -0700 (PDT)
Date: Fri, 17 Jul 2026 04:59:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260717044019-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-2-harimishal1@gmail.com>
 <20260715164139.40957-1-harimishal1@gmail.com>
 <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
 <2026071635-relive-flogging-2a81@gregkh>
 <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
 <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jxE2nFsqKTyHRkaqs3lVqKf81Aq05z11s3YeKBuCDg4_1784278777
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> >>> Or do we just always trust virtio mem devices explicitly?
> >>
> >> It's hard for me to understand where we draw the line, really.
> >>
> >> But maybe MST can clarify what we care about in virtio world where the
> >> hypervisor is fully in charge of the device,
> > 
> > Generally:
> > - The guest is expected to whitelist drivers (most drivers have not
> >   been audited).
> 
> But even if you audited your driver, who makes sure that we consider all ways
> where the device could mess with us?

A lot of this is up to a correct setup. For example, make sure all
filesystems are encrypted and refuse to mount unencrypted ones.

> Something feels off here.
> 
> Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> to be corrected.

Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
	It is important to note
	that this doesn’t imply that the host or VMM are intentionally
	malicious, but that there exists a security value in having a small CoCo
	VM TCB.

and

	While traditionally the host has unlimited access to guest data and can
	leverage this access to attack the guest, the CoCo systems mitigate such
	attacks by adding security features like guest data confidentiality and
	integrity protection.


now, when we are talking about "mitigation" it is indeed becoming a bit
murky.


For me, a rule of thumb I came up with is that if the validation happens
to also be helful for users e.g. to work around buggy devices,
or maybe because we feel failing gracefully is nice because this
will allow to later make use of this config and old drivers will
fail but at least not panic, then it is good to include.


> -- 
> Cheers,
> 
> David

