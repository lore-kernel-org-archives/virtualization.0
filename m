Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BE3E9C1F
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283052; cv=none; b=T6oC4ilkxXjLnoS8i5OWAAvTkd22cokiPycORRw7OU0WBrncDy2dBvFnONtc8z4EbZ9vRI4SIKropyspgtK7RfRpxVng1qZMinTBOPp9U3k+03e3uafmauBxSzW3U26McfmeH0y3kfZvBrPmdvhiyY2ec+MNT7Jse0gL9+QaSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283052; c=relaxed/simple;
	bh=dVkLI/dcu4rYDpKVXf27xgtVxW4eLo84057u7xqAgTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gNgl5HS3440dbLguRUcJ1S8AO4BlmEAsXG1yTKHw/riO8oVk6PaWPEYgs+PPHg9XwsW/p6XUUuDLzMWuzWDqMbnQrcpfzbhBLqUDREiycIViK4GEIR9ILSOgtwtyw+soIUep9oCcaQlo1L1QjhKuHDZrt/Fm4y4+Tg4HLXfUgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXX7wGfU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXX7wGfU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784283050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs9dewdrHqMzHoHYwCuotrkR4F9NeI4ZAIdhWqpau6M=;
	b=iXX7wGfUJyNIsvLUPK6ftfeA3zu9qVIOznAX4WiLDycij0nhcdyZxvNOwRroluNLq74J74
	PrI8wCtTnAPzecfXEQYsC9sBC006Mh+pM4gfKNGi/npjXBxVOLgiMArBkRF68vRK2wHOkh
	1lh2ycgwwPl5uM8pwbb42J9+JFylrpY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-cQ_ZfvI5NcycKsmvJ8TYOw-1; Fri, 17 Jul 2026 06:10:46 -0400
X-MC-Unique: cQ_ZfvI5NcycKsmvJ8TYOw-1
X-Mimecast-MFC-AGG-ID: cQ_ZfvI5NcycKsmvJ8TYOw_1784283045
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472bdd6f529so4733507f8f.1
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 03:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784283045; x=1784887845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zs9dewdrHqMzHoHYwCuotrkR4F9NeI4ZAIdhWqpau6M=;
        b=Esksujp6UmSZEhgfLyvl07fNJ2ykCEOmLZ29IrMZaRwiK502OwF87WjuG0QGhi3ABm
         QinKTaGLAJxA27kN/y7PzoTui1MmefHE91eG41PADXp2OnNtY86+q9WBEQrkeWxIpIOY
         75JN14LxQ+WMoSXadi/fpGG9Lo+XjlGwdIPppn+ThM9dLy5VJAl9oqgQLtt6e2YjWbxh
         w+XR5+eco3fG+jUcF1GfTuUdTvogJrSOoP+scq0S7+LZKYygqTvojYTbonbjOZMYBSCf
         MIUKDpJRqUI6T+bwujf8VpT/S7y6U571yOyu9xcKGwWcPnV7xlck6pRXW06+nWzbMrZU
         bXow==
X-Forwarded-Encrypted: i=1; AHgh+Rr/+16HsGrQIuhNLJe7UC45miiVDeRJB2Zh1NBxs4f5ccWQ61j6NZWOdaTh+QB8TGe0a946qAf709aNfm9qZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjHBZGCUDRh6WNW5AS/4DiAPIHy+bMcGqCeEtUMojgq34UthM/
	GZMHGtZzLSTRcZOANE/eKUUt1/2HuXHWF/W42fb69ulha7GghmN8HqYNdfTnytaIKbkx44fSVRG
	NBB9+HV6EjFru6Vj5WUKAw+3gTdxzwKNXO6/1FnKux05wL2zJPG0vTNPkmzCHQfhdhrXw
X-Gm-Gg: AfdE7cl/TDlBLVF239Lx4oPHQ5/0a2KmSDITbjVQ66XGYkayVDG5yIULLvFTsdxHlUj
	GG5Jw6xrnkwUJk1l5ob3vZ2FX7ye706ECz978gAbpx0xOgCdJm5EaOCgtm4om6vS/+0IpriILx4
	07KwqvlKzxEshemOmC9v1Lh8K4zrmwYgZY2G2gQC38iExZM48TP7VM2hrJtb4YZQ2pB61KjiVFj
	jbdi9OOpMg6HctaZvFxa8Q3zCuYuDxspMb3uRRnjf57hZ9b5iCIwMz4Er9oyf2tQ32n/pbHJ68N
	CL1ugn8Kve02+AGeSJGKBB4Oc0kly5migv+WFUuJCoS8kxEhaxYapLhuVvDc1LCDXLpgxW5FLwC
	FXJ9UZBWnp7Y6zxzWxcHimpP3
X-Received: by 2002:a05:6000:4a1e:b0:46b:7f57:7109 with SMTP id ffacd0b85a97d-47f6230c3d9mr2604635f8f.20.1784283045130;
        Fri, 17 Jul 2026 03:10:45 -0700 (PDT)
X-Received: by 2002:a05:6000:4a1e:b0:46b:7f57:7109 with SMTP id ffacd0b85a97d-47f6230c3d9mr2604578f8f.20.1784283044462;
        Fri, 17 Jul 2026 03:10:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm2880522f8f.5.2026.07.17.03.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:10:43 -0700 (PDT)
Date: Fri, 17 Jul 2026 06:10:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260717060822-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-2-harimishal1@gmail.com>
 <20260715164139.40957-1-harimishal1@gmail.com>
 <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
 <2026071635-relive-flogging-2a81@gregkh>
 <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
 <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026071746-deviation-clad-1712@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7T-zn5sWCVt3XgeFk0t0PUl-5b0Il4877IZi26HLR3M_1784283045
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> > > On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > > >>> Or do we just always trust virtio mem devices explicitly?
> > > >>
> > > >> It's hard for me to understand where we draw the line, really.
> > > >>
> > > >> But maybe MST can clarify what we care about in virtio world where the
> > > >> hypervisor is fully in charge of the device,
> > > > 
> > > > Generally:
> > > > - The guest is expected to whitelist drivers (most drivers have not
> > > >   been audited).
> > > 
> > > But even if you audited your driver, who makes sure that we consider all ways
> > > where the device could mess with us?
> > 
> > A lot of this is up to a correct setup. For example, make sure all
> > filesystems are encrypted and refuse to mount unencrypted ones.
> > 
> > > Something feels off here.
> > > 
> > > Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> > > to be corrected.
> > 
> > Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
> > 	It is important to note
> > 	that this doesn’t imply that the host or VMM are intentionally
> > 	malicious, but that there exists a security value in having a small CoCo
> > 	VM TCB.
> > 
> > and
> > 
> > 	While traditionally the host has unlimited access to guest data and can
> > 	leverage this access to attack the guest, the CoCo systems mitigate such
> > 	attacks by adding security features like guest data confidentiality and
> > 	integrity protection.
> > 
> > 
> > now, when we are talking about "mitigation" it is indeed becoming a bit
> > murky.
> > 
> > 
> > For me, a rule of thumb I came up with is that if the validation happens
> > to also be helful for users e.g. to work around buggy devices,
> > or maybe because we feel failing gracefully is nice because this
> > will allow to later make use of this config and old drivers will
> > fail but at least not panic, then it is good to include.
> 
> Why not do what USB does?  Don't trust the device until AFTER probe()
> succeeds?  All of the needed checking should happen before then, as that
> is a "slow path" so lots of validation and the like can happen at that
> point.
> 
> After that, during the normal data paths, after the driver is bound,
> trust it all you want as attempting to validate every single packet is
> just going to be impossible.
> 
> thanks,
> 
> greg k-h

People do expect that data path validation at this point.

-- 
MST

