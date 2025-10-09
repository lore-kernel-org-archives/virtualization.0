Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA02E8E09
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017050; cv=none; b=Q7/eLdXbrRCFBAw5tqKQcXCurK++MhmLjssFlPSEeFE5I7IiV1Uk3sRf1qtde56S1NATmWjLYR/4BP4NEbIsZcPrd0Kc9EcC+h/E66KCZWRuoazMgQzpDzgyMyRweXfEhHo7SC+OG3Y0bCuml4eSMah3h/WpOUwM/k9wUn5uoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017050; c=relaxed/simple;
	bh=7NdTvvUFK/WVGSYlLXsbwdrwKPNZwb8MV31/iuYNMko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P/uLtIFVufWQExsOAp1jwk/rTm/gNslqIXvw7kgSgxA5L8aPCzcuVPyVe36tSd14efiUNvsppUxMofYLgZ9iu+QwejGPP84KIS72NHIv4+0tpDiez53FfHaDi6pkTFndPccK0LdH4en4I4L331+kIt2J8bzUse5OZ90VEhtQW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXmhDU9I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXmhDU9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760017048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSnlK9qf9+QtrbFfXzTXGo8du1cPFojIdvhyIWDFaG4=;
	b=QXmhDU9Iet5vhAhr2qWm8ezr/UGEp076xcPaTJK3wRz9iGiO0tWUJuTZzA3rnr+Ci2TiEN
	3BECBE4Z26fGVVO8d0TtGQRwztXDCPp7dCWtsLjtlbCkDAJDXrD3BO/HnSBs08Cx2xd2Ak
	IQLUgEWGpwmOhkHUPnNXTbYdWcdkEP8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-xU_VV1h-MfOvs3a4brouRQ-1; Thu, 09 Oct 2025 09:37:27 -0400
X-MC-Unique: xU_VV1h-MfOvs3a4brouRQ-1
X-Mimecast-MFC-AGG-ID: xU_VV1h-MfOvs3a4brouRQ_1760017046
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e1f265b8b5so33446381cf.0
        for <virtualization@lists.linux.dev>; Thu, 09 Oct 2025 06:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017046; x=1760621846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSnlK9qf9+QtrbFfXzTXGo8du1cPFojIdvhyIWDFaG4=;
        b=d/1ABa/TlbUrBDqCnIvaHpMuon8gWQ1DtvDpBPZ73RY77W6wiwr9crj72w1OCKtGfR
         Nw27lpd79ev7uls6wmm9kw890KX5v3lVVX+x2OF2yFdi4m30MPZVfzmA4a0vt8X/70ZJ
         X9Ztg+M5q4A+RDXHcgDsXkWwsboM8hfoKOmdg6I0MH1qbmgAYcFW6BTyXSBMBJSWB1T2
         VUtLiOLHVMOHNzEL/oCdKoxtUWNnRdSb3NQgJ1Pyj06BmAuUZwVLg+jFwDXLaPk8kzvA
         VL9a8DEmIg6b9OYXeuWYFD/ZxBmWWiApRFiTgzvjWIfadE3Gj8vwxS0/UQl+L1aotYGW
         2JbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0WWRil3aClfO9Ch13sIBI1xT4wVv4hxJwrwrRCG3jjAZgHudClxcSmhn9i7XKNfrK/h+u7bxwF/casY7gQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQz7d4AvZCpQjgPdOFqsdDsg3XgY6dZrF9CI/u+hjelCYEjooz
	iySwJLmDSXdG7D5RqwEbSjkQ1Py3OXaBbcCSD1kJfultB4uLooJ32m6X//hHr0qJnRnIRBK91VY
	p9nhPWskduIzw6QY0QLlc5zaS1UB0d+ATC5GM6Q5ZOuzi47MkgOR6PHrzih8lmEKfEnW8
X-Gm-Gg: ASbGncuJ3WRGhFhj9Uzfu0hPO/qVMrP7lgFVYcDbOpfsrry2jiT/woeu7JCJ2T/ojKE
	x+pq+GPjUSxoeA9Z/gw4OxVKq6uXAXjqOcH+c3euMGKesaG8dAl79bakohobF5mpPfy3NIoFQdm
	HAKuHgxurHJsrbOOUONpvHFNMVT3MV5PkT/v/9gRLgha0yeEg1LigDr4xBUR4FjLgEJxUxBjnES
	89hz3rABHUdPrFnldJ29aaVaCHQF/iaPcvTSrFx6/i2DGlSMNBo8kISPirIY2UGtEtlRHHlxNef
	+BgAP+3w57ECbi2f/QScmQKswS7hI137lHA=
X-Received: by 2002:a05:622a:552:b0:4d3:1b4f:dda1 with SMTP id d75a77b69052e-4e6ead5b74fmr99238191cf.61.1760017046389;
        Thu, 09 Oct 2025 06:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkkkln0wvJVfA+/SQdl7KyNaqeghASgRMRgQSZA/6yVrMeWhD/2djQvFf88sK4uQV3LAnLRw==
X-Received: by 2002:a05:622a:552:b0:4d3:1b4f:dda1 with SMTP id d75a77b69052e-4e6ead5b74fmr99237541cf.61.1760017045789;
        Thu, 09 Oct 2025 06:37:25 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2369b3fsm191330185a.51.2025.10.09.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:37:25 -0700 (PDT)
Date: Thu, 9 Oct 2025 09:37:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] virtio: dwords->qwords
Message-ID: <20251009093127-mutt-send-email-mst@kernel.org>
References: <cover.1760008797.git.mst@redhat.com>
 <350d0abfaa2dcdb44678098f9119ba41166f375f.1760008798.git.mst@redhat.com>
 <26d7d26e-dd45-47bb-885b-45c6d44900bb@lunn.ch>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <26d7d26e-dd45-47bb-885b-45c6d44900bb@lunn.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ksHA3-Y600fzu9vfGuaOySH1jmJAziUDpNgRAN1JHPM_1760017046
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2025 at 02:31:04PM +0200, Andrew Lunn wrote:
> On Thu, Oct 09, 2025 at 07:24:08AM -0400, Michael S. Tsirkin wrote:
> > A "word" is 16 bit. 64 bit integers like virtio uses are not dwords,
> > they are actually qwords.
> 
> I'm having trouble with this....
> 
> This bit makes sense. 4x 16bits = 64 bits.
> 
> > -static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
> > +static const u64 vhost_net_features[VIRTIO_FEATURES_QWORDS] = {
> 
> If this was u16, and VIRTIO_FEATURES_QWORDS was 4, which the Q would
> imply, than i would agree with what you are saying. But this is a u64
> type.  It is already a QWORD, and this is an array of two of them.

I don't get what you are saying here.
It's an array of qwords and VIRTIO_FEATURES_QWORDS tells you
how many QWORDS are needed to fit all of them.

This is how C arrays are declared.


> I think the real issue here is not D vs Q, but WORD. We have a default
> meaning of a u16 for a word, especially in C. But that is not the
> actual definition of a word a computer scientist would use. Wikipedia
> has:
> 
>   In computing, a word is any processor design's natural unit of
>   data. A word is a fixed-sized datum handled as a unit by the
>   instruction set or the hardware of the processor.
> 
> A word can be any size. In this context, virtio is not referring to
> the instruction set, but a protocol. Are all fields in this protocol
> u64? Hence word is u64? And this is an array of two words? That would
> make DWORD correct, it is two words.
> 
> If you want to change anything here, i would actually change WORD to
> something else, maybe FIELD?
> 
> And i could be wrong here, i've not looked at the actual protocol, so
> i've no idea if all fields in the protocol are u64. There are
> protocols like this, IPv6 uses u32, not octets, and the length field
> in the headers refer to the number of u32s in the header.
> 
> 	Andrew


Virtio uses "dword" to mean "32 bits" in several places:



device-types/i2c/description.tex:The \field{padding} is used to pad to full dword.

pads to 32 bit


transport-pci.tex:        u8 padding[2];  /* Pad to full dword. */

same




Under pci, the meaning is also generally as I use it here.
E.g.:

Documentation/PCI/pci.rst:You can use `pci_(read|write)_config_(byte|word|dword)` to access the config






-- 
MST

