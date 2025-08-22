Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED81303C91
	for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871338; cv=none; b=CrlgZOC3Plafl8gdnU4VA7idRO4wnkF9t02BIdSnpvfAwgO/LPSndoQG2ZLLM5Bo4U5dZGjvZZby6IQ7mh/oDmK+lHGAVPL4153ITjaYpnxpIToJvf0TK0LMCJocHalApmBMvhlHnArmPlVb2wCmUkdLncbBwlxRjwhrblxXOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871338; c=relaxed/simple;
	bh=EUugAze3VMED93D4VtFJSu8FPTFEw4CKpNd1sov95Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iF78DgPyjU3k2OifYHUj/XEP5FugJMkYKVPW5yvU1iL/n6wAMRRdEgMuNG2+9UJbsq+Siawdl238gSpc8x9Sxlu4DbI6Ps7t6Qv/dv13hbvVaaWeSz7vfdtr49gfaPZMwsoVykeTy9jc68lfUwKt8Gg2mu+lwdf961RPZo258Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HywI9uFN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HywI9uFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755871335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fENUkrFAFKQ1Z6kTSqloFTTjWbakLg84clSG3sD2bb4=;
	b=HywI9uFN3rITheWoRfEyuK9oNrlJUDH6IqPKfIYJrm2PtNgzgkSZ/SAXifIjX2ghk1crwI
	oq5XbPaKnaG9RrDwvjHjQRWHQ9eHcPPEIhSeSkOHHTU1qcAFoTs/t0dc6UhTLQ/XNXVONA
	nCF8Jb0kCT9aNIEk7PT/EIUoGy8xxck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-wrRDmKrBN9e1jYF8KVVBCg-1; Fri, 22 Aug 2025 10:02:13 -0400
X-MC-Unique: wrRDmKrBN9e1jYF8KVVBCg-1
X-Mimecast-MFC-AGG-ID: wrRDmKrBN9e1jYF8KVVBCg_1755871332
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c68ac7e19dso152077f8f.2
        for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 07:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871332; x=1756476132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fENUkrFAFKQ1Z6kTSqloFTTjWbakLg84clSG3sD2bb4=;
        b=GXBb4AWV7uki+8uYwKSfyrEWgSF1/W4C4nwERyNilDzEtrLk0ky0LoDbffAM2EnDr4
         15A0fIYKyYblm96bDe+wZWj4N6L8bW1XPNw8MAia2rjHh7mZeey/RpMFNMSdx+czlopy
         ElLkwe9yLH7s14G9E2imtDxRcFwLiYDZc3xggim6dvZdvxbW9v0DuN3lXQ9mZDhUVTAN
         3QYV2dyGTGOzKUMYzF6ujVKX57BkuC5GD3eiXkxlK5XfELUUrNz5MKKr5AAsMNHmsxe5
         XbJzS5yosYz81jLKUvPg5JTDkiidS8uTX94feDmIslgMEHGaIW6p06yJjRNd0EKGjJPx
         alYw==
X-Forwarded-Encrypted: i=1; AJvYcCVXslIvZtxanNghE7T1/TtrS44KtHZBCcTH/t8bau5f1Tmwc7zuc3JWXVH+JRG6wzR9U/TO4p25fD9ikIFOjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUV0bWGb6fWIdG71wawrnmTD6SFShOvxbBqbc02RKAOlQ9/rfo
	Lsn9bd4KOAst+Np1I5V6e0+xp1CHIKN1Tc3aR0COr68iJWwGPtd9gRgLMoiMLBHnseHYfoHiVMD
	gqki2AVRI3Y/LpvoyFjfGIj02jERV/gYwbY8woUIfOkwaZCDPLfgaIH/9I8RDwHmZKhfx
X-Gm-Gg: ASbGncu0YWhr2TRaSJfmFLpsMH18PT5IlasfiDD7OwkqNjQ8bDlvpidq/pyN6v0HuGA
	sungeaqrtcGtYz4UKAT53p1nBbJW/G1gKKob9+vwTiwhKUa5fivXvGryHBujyN/ePbztK6JQpgt
	MIZQDh9Xsjcem9NQ2NfsGBYGo0ViijMhLsmaiNHhQiNdEMeKGWHK7Ezp4cAfIfal8J09kU6DNIc
	QS63B8fb4GSDKHE4kCajRTlnLebqkZ2vr2Fv6buH4gtMVMeqF7uKFkCFtxOr9UfkguHoNED5zFG
	KmAhOcXKqo4cUNA1i5tjei8E+T5EaT9A
X-Received: by 2002:a05:6000:2204:b0:3b7:9233:ebb with SMTP id ffacd0b85a97d-3c5da83c50emr2191683f8f.6.1755871332083;
        Fri, 22 Aug 2025 07:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERxH7i9dCeBAL+SRO1DoCOF9nmq3u+cQ+qcL77Cd+BYpM2PRfxMKBLB/pOJbmzBNJzoU/GTQ==
X-Received: by 2002:a05:6000:2204:b0:3b7:9233:ebb with SMTP id ffacd0b85a97d-3c5da83c50emr2191645f8f.6.1755871331485;
        Fri, 22 Aug 2025 07:02:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c60b40dcf8sm2551505f8f.41.2025.08.22.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:02:10 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:02:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250822095948-mutt-send-email-mst@kernel.org>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kwdyFOyG6wI5jw-lBMQoWtK-8-kivXXkXGfPf_MD5No_1755871332
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 22, 2025 at 01:53:02PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 22 August 2025 06:35 PM
> > 
> > On Fri, Aug 22, 2025 at 12:24:06PM +0000, Parav Pandit wrote:
> > >
> > > > From: Li,Rongqing <lirongqing@baidu.com>
> > > > Sent: 22 August 2025 03:57 PM
> > > >
> > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > > removal of virtio pci device").
> > > > >
> > > > > Virtio drivers and PCI devices have never fully supported true
> > > > > surprise (aka hot
> > > > > unplug) removal. Drivers historically continued processing and
> > > > > waiting for pending I/O and even continued synchronous device
> > > > > reset during surprise removal. Devices have also continued
> > > > > completing I/Os, doing DMA and allowing device reset after surprise
> > removal to support such drivers.
> > > > >
> > > > > Supporting it correctly would require a new device capability and
> > > > > driver negotiation in the virtio specification to safely stop I/O
> > > > > and free queue
> > > > memory.
> > > > > Failure to do so either breaks all the existing drivers with call
> > > > > trace listed in the commit or crashes the host on continuing the DMA.
> > > > > Hence, until such specification and devices are invented, restore
> > > > > the previous behavior of treating surprise removal as graceful
> > > > > removal to avoid regressions and maintain system stability same as
> > > > > before the commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > > removal of virtio pci
> > > > device").
> > > > >
> > > > > As explained above, previous analysis of solving this only in
> > > > > driver was incomplete and non-reliable at [1] and at [2]; Hence
> > > > > reverting commit
> > > > > 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> > > > > device") is still the best stand to restore failures of virtio net
> > > > > and block
> > > > devices.
> > > > >
> > > > > [1]
> > > > >
> > > > https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6
> > > > C6
> > > > > 38 DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> > > > > [2]
> > > > > https://lore.kernel.org/virtualization/20250602024358.57114-1-para
> > > > > v@nv
> > > > > idia.c
> > > > > om/
> > > > >
> > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > virtio pci device")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: lirongqing@baidu.com
> > > > > Closes:
> > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9
> > > > > b474
> > > > > 1@b
> > > > > aidu.com/
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > >
> > > >
> > > >
> > > > Tested-by: Li RongQing <lirongqing@baidu.com>
> > > >
> > > > Thanks
> > > >
> > > > -Li
> > > >
> > > Multiple users are blocked to have this fix in stable kernel.
> > 
> > what are these users doing that is blocked by this fix?
> > 
> Not sure I understand the question. Let me try to answer.
> They are unable to dynamically add/remove the virtio net, block, fs devices in their systems.
> Users have their networking applications running over NS network and database and file system through these devices.
> Some of them keep reverting the patch. Some are unable to.
> They are in search of stable kernel.
> 
> Did I understand your question?
> 

Not really, sorry.

Does the system or does it not have a mechanical interlock?

If it does, how does a user run into surprise removal issues without
the ability to remove the device?

If it does not, and a user pull out the working device, how does your
patch help?

-- 
MST

