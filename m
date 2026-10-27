Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106477;
	b=H71+YzJ2CtTv1CquW1mz8jUineQFyN9ozhBVpr8l/Cflyv3oBE5Vop37tNSDRRRAEWBe
	 7iisc7NaRt+S3i/AjXXS8y7uaO7ppY+zQ4lbvANLkfWLG+oUxVTmp6JcKgJU8ZrF4atKJ
	 T4kdmxZb1TVb8pXgDirpYUvoxApru3JcnLr4z08Y6awF1Bmy1/E2bYFhLmSdqFr1J9EBX
	 f11TijHETw3qxiY+6GpDeP79SkMc1uGrxtSxEoNKe3Gr+AcPXn29zgT9xcBWdEfZ53nPk
	 EkEAlgba5B/XN10Mz8dEVVMwtAP0K5x26CubCv/s7kC9CB3hliBbFP5T7rZsqm2Nvbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106477;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=ATvxORBZny1s5fn8dz62jBylTwd8vo+fNFXQREv2wUs=;
	b=S5Ogb4iZDPhutBFNNmrRfaZ/t8G9NTLZoUeLWj48E6KSqs9/iUSWdKhAFWbRlGF8C8OB
	 GjqOGwnvkGpUQ9ulbrPAPlH6mfYjntU69yHu/MS/EycLQq29SKC7Fsi/u3ucml/qq5ID7
	 RE5a7TUATsqP1MXnPNSnkvuAX6NBGJjawZnOGp2FXUYEujEcoso0pdEQ9yKqRWhO8sU5t
	 sGqOzRxWpVcB4I90P+dVAfBucLR4rVc3KYmpxuQoRGMOPgjrRJ0un6Bof938TiYjOdOTl
	 5pwCUbltwoKKdpfQuFRKpVY5Mv6rIww3x1LN8+UMyBV8Q3SyVo0huKXY4xdCJSfnRQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0w5XfPW;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D25606A31E
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 13:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D25606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0w5XfPW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793106476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATvxORBZny1s5fn8dz62jBylTwd8vo+fNFXQREv2wUs=;
	b=M0w5XfPW+ZmTMhEPb6FCKQ1Q34kjll69ocHvw0cJuJzcvPS/IzctI2GCB05/6zytzd/doz
	6taBV6gtqS4IyEJBDQGZsPTX5m/fLi/gbtkOErtG0U3Nx2BvN9puywL/con4MRCY4wTEbc
	hkcO96m4sItxxnEcvChh6K9HkgQnUEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247--kuBOCE9PhGk1_MZ-NxywQ-1; Tue, 27 Oct 2026 09:07:54 -0400
X-MC-Unique: -kuBOCE9PhGk1_MZ-NxywQ-1
X-Mimecast-MFC-AGG-ID: -kuBOCE9PhGk1_MZ-NxywQ_1793106474
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso29551385e9.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 06:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106474; x=1793711274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATvxORBZny1s5fn8dz62jBylTwd8vo+fNFXQREv2wUs=;
        b=s0VHfJLf55BT1MWT0a4+cwjaGFIMXwTEooaeLgpsw/Jg6fCUlOiWk7r1lMcK5Nsqqi
         37k1Cn7IQ1hPsHQVVBCl0mjYktu/OJqGokLzaInYVyyV8rd0fS37oHRHgElnidB/phrM
         tICJPZR2ZFeKqT2lWfk+upHgk6FQsCyd1MnWJc9KzaFDcxArjWPaPsZ7Vk8gD8RGMHP/
         eSGt3YsPQONVtNYgwCCTxLf5D0J5/6X2KdvWgN4GwxKng03o4zk//wE5oC4TPcRYlhnm
         +/7Y+w7CLU/ZQ6VV5u4HFVBNwD6lWiFHxM9rIweLRpcRjsCC+EEpx6hHEoFVlY77nb5g
         9cXg==
X-Forwarded-Encrypted: i=1; AKwUvBxwK+twLSNyVJPdcghAHiTwmDHVKgjchUbSi6jby1FC7D7lF2G+bEV9qxviE3NkysvBA9xn3WTvrE66VjCMVQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIpzUYH8Dgk1oksq1v+ENv++Bl6fjLpTkcrwuC2FurVNyXapnNJ
	HK58AXnHhpSQptnl+xQmB1E11aU78bZQuUL8nj8Bod5ElKYpGfLAmh3FnpHC/s1gQKuwL2cCqGB
	iEQ+EVSrhiN2E20Npf8V/6FluMI/OyKEpxCaSdZ9WVGuc3Nq7wPnj+q+1gVDDak0Clw3i
X-Gm-Gg: AYBFou2F5hF/37Sv5Uc3W6KHF9MviLtg7OTv1UNSyIunjayEJKKTrKRwkCHnKEwI82J
	ZER2ER1HwiGNPODKooDeFSnVUeCrzI/DbzD/U2q0JlZEWhdMjiCIuR8vwYoeM7yjAF8jTDvxLua
	bR/1BDm1vPWIppxcWzY7KgRgU+CytDK34GSMwV3YnQVY1xq+znh/A4Js3IpbC4Ph1MbNPrZuVLn
	s1S3rktcIa98AcVSY/BXZL4p8yHOnF0jUG916+Ry3qlPhJFU0Jkmk4Itns4MgwMns/MZ87pPBOs
	fXn489eSEkyGkif+eQjx2+1i7wrVWetNiYuauih+shhv2jE5plY/G+kEktPWckEBNr0=
X-Received: by 2002:a05:600c:6388:b0:4a1:e9c2:6c84 with SMTP id 5b1f17b1804b1-4a35acaed66mr171606635e9.18.1793106473534;
        Tue, 27 Oct 2026 06:07:53 -0700 (PDT)
X-Received: by 2002:a05:600c:6388:b0:4a1:e9c2:6c84 with SMTP id 5b1f17b1804b1-4a35acaed66mr171605725e9.18.1793106472915;
        Tue, 27 Oct 2026 06:07:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm691723785e9.1.2026.10.27.06.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:07:51 -0700 (PDT)
Date: Tue, 27 Oct 2026 09:07:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Jason Wang <jasowangio@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Add devicetree bindings for spi-virtio
Message-ID: <20261027090324-mutt-send-email-mst@kernel.org>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027065001-mutt-send-email-mst@kernel.org>
 <auCb8_ROuyXdTkQ4@bywater>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <auCb8_ROuyXdTkQ4@bywater>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hi6DCcjSz7pCCku05xEW57Ux2DoHVURsonz2V8ZwSH4_1793106474
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 01:46:35PM +0100, Francesco Valla wrote:
> Hello Michael,
> 
> On Tue, Oct 27, 2026 at 06:50:51AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Oct 27, 2026 at 08:26:32AM +0100, Francesco Valla wrote:
> > > When a virtio transport exposes a non-discoverable bus, the devicetree
> > > can be used to declare its child devices (if any) and/or other
> > > properties. To allow for that, the virtio framework searches for a node
> > > with a suitable compatible in virtio_device_of_init() when registering
> > > a device [1]; such compatible takes the form "virtio,deviceXX", where
> > > XX is the hexadecimal representation of the virtio device ID as defined
> > > by the virtio specification.
> > > 
> > > This patchset thus does not introduce a new functionality, but allows
> > > proper validation of nodes tied to spi-virtio devices, aligning SPI to
> > > what is already being done for e.g. I2C and GPIO virtio devices.
> > > It was sent initially as part of a different patchset [2], but since it
> > > complements a functionality that is de-facto already there and is useful
> > > beyond that specific use case it was sent separately (also following the
> > > maintainer's feedback there to separate it from remoteproc-specific
> > > changes).
> > > 
> > > This was tested both with virtio-mmio using qemu-system-aarch64 and with
> > > remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
> > > parts still not not upstreamed - see [2]).
> > > 
> > > I added myself as reviewer for the spi-virtio driver to be CC'd on any
> > > patch involving the new bindings.
> > > 
> > > Thank you!
> > > 
> > > Regards,
> > > Francesco
> > > 
> > > [1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
> > > [2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/
> > > 
> > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > ---
> > 
> > I hope this can be merged through the devicetree maintainers,
> > I have no idea.
> > MAINTAINERS changes needs an ack from existing maintainers, of
> > course.
> > 
> 
> This might prove... difficult. My e-mails to the maintainer (Haixu Cui
> @quicinc.com) continue to be bounced back by the Qualcomm postmaster
> with a RecipientNotFound error. Maybe someone from Qualcomm can give me
> a lead on how to contact them?

Indeed, so it did for me.  Oh that's no good at all.

Mark, what's your take? The maintainer is MIA but we have a volunteer
maintainer here.

As far as I'm concerned

Acked-by: Michael S. Tsirkin <mst@redhat.com>




> > > Changes in v2:
> > > - Expanded the commit message to better explain the functionality and
> > >   the chosen compatible.
> > > - Redundant pieces dropped from bindings.
> > > - Link to v1: https://patch.msgid.link/20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it
> > > 
> > > To: Haixu Cui <quic_haixcui@quicinc.com>
> > > To: Francesco Valla <francesco@valla.it>
> > > To: Mark Brown <broonie@kernel.org>
> > > To: Rob Herring <robh@kernel.org>
> > > To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > > To: Conor Dooley <conor+dt@kernel.org>
> > > Cc: virtualization@lists.linux.dev
> > > Cc: linux-spi@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > 
> > > ---
> > > Francesco Valla (2):
> > >       dt-bindings: spi: add spi-virtio
> > >       MAINTAINERS: add Francesco as spi-virtio reviewer
> > > 
> > >  .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
> > >  MAINTAINERS                                        |  2 +
> > >  2 files changed, 48 insertions(+)
> > > ---
> > > base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> > > change-id: 20260927-spi-virtio-bindings-f4e350b2709a
> > > 
> > > Best regards,
> > > --  
> > > Francesco Valla <francesco@valla.it>
> > 
> 
> Regards,
> Francesco

