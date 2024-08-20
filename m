Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81A18DF79
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152468; cv=none; b=frdxt/0dpRIInWBnv8BgsdBN7qkYZt1jaMwZU8e1AS5XkRmWttjw+awhEUQad4+9Fzg2d7+obyRvQe5SdWny7qX51VbBEMPtSQ43RdQ5YOYergtWQaV65hdGfOkm5I+mAG3yQT/rC6sz13ymgfBEcLp+vrf6aTyVwL2OB4BAyww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152468; c=relaxed/simple;
	bh=BTT1Q6GxIm9St48gKvu8Ozg5Txh7Do+nIOAs2Z9Upuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUhx0pjzzQWVVvxd1IHZY2QAJyl/k5b1bNX/InkWysMGmqH+eS7vCsmCR2vFkn2gKig7ZXiTPo+7XxSdP+ARjqc5Tu8Kjg2uFmunNP3VNrQ5viXNs70V5dmUy2Qpyug2u+ftS7cWApbXNOwM/NwY8GInutaFE+QWw4tZ8hvBM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alU1ouL2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alU1ouL2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724152465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTT1Q6GxIm9St48gKvu8Ozg5Txh7Do+nIOAs2Z9Upuo=;
	b=alU1ouL2HHmGo3pefUWlvcuSlN+U89VeS9UoAoPY+0hYmXk/V8aW1Q1q5zLriPPNOdeKua
	7alqhC/zsuaqAZ3weGB+OkMdEaadEyqE43mkgXYP8y1dCbjKv1ss+pmFU4PjfVH5CKiKhg
	ymAK35zpPs93e7U8KZJzSgqb3qf7MCs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-xuFW0ppGPL2X_Wg2HeLFEA-1; Tue, 20 Aug 2024 07:14:24 -0400
X-MC-Unique: xuFW0ppGPL2X_Wg2HeLFEA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52eff9a3109so591934e87.1
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 04:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152463; x=1724757263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1Q7acyOuQZwg2/89j6b8m+Ec7sRWq6gAjTgotRXIu4=;
        b=s8d6/0xlGMHToQ6FN/2YIIWsjFxe/67CGUrPMv3UVwVFZemIrgxXe89jXItqzMsJRG
         pGkns9cnRjRpCj6JWQ1JnCoctu1783jT+tTCKo05IGDtarQaKtyeCENvSauA0YX2G1B1
         yv440AwP9rJoGQivJk2Xw2z2GZs7s4aC/5eE7BFVDJJz9DJWdwkzI72bGcCZdJenpVAT
         fSqyVdO099tfJTwYqlrJbsgZbGJuoD8H0aXhSDmdPb22uYS8YStfCaDM8D51frj7cDmP
         Lq5yM0dgfSstSEHtemgZvBBbbD9AkWnmH+aXM2JuzG77nzqpUPJlP3z5EYCNVAU3zl/P
         HmYw==
X-Forwarded-Encrypted: i=1; AJvYcCXLrQpdsHT7gTMLDEnuo8qMCADt5qmrgumtjFo7Mlq81iF62pIB+JhC87tiPKMwGu0GJlGyx4o0WoU517DlMBCb8rGZYktAKewdVZQ9dk8=
X-Gm-Message-State: AOJu0YwPNQQuiUu9i5ncXc4IUFqC8As6OTeY36dFH3ZZa52Rx3K7aIvM
	0TMltIHQZvgyvZL3Y1ESgbL4Sic/Tp+BhzhbM7Q17nSKUblDLFIhapaLCXxmP0xIT2gR1g8hWV5
	kZBma9k2ti6twCvoCnC9/In7GMuz+4W80lS/2RwsQFrpQUxdKiDnINhnVgjMxAOIq
X-Received: by 2002:a05:6512:3c84:b0:530:baec:3975 with SMTP id 2adb3069b0e04-5331c6904bamr5596039e87.1.1724152462998;
        Tue, 20 Aug 2024 04:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYdlvki0skRqSH7C03GeJxZqEQK+y/koEXnizdbc6P1v4DyVRhp4tYp6FmBEQj38Z0lN9WKg==
X-Received: by 2002:a05:6512:3c84:b0:530:baec:3975 with SMTP id 2adb3069b0e04-5331c6904bamr5596024e87.1.1724152462340;
        Tue, 20 Aug 2024 04:14:22 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935657sm747366866b.138.2024.08.20.04.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:14:22 -0700 (PDT)
Message-ID: <01b1e7d505a2b3e670f1613ce3e6a60efd3449ab.camel@redhat.com>
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alexandre.torgue@foss.st.com, alvaro.karsz@solid-run.com,
 andy@kernel.org,  axboe@kernel.dk, bhelgaas@google.com, brgl@bgdev.pl,
 broonie@kernel.org,  corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, eperezma@redhat.com,  hao.wu@intel.com,
 jasowang@redhat.com, joabreu@synopsys.com, kuba@kernel.org, 
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com, 
 mdf@kernel.org, mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
 richardcochran@gmail.com, trix@redhat.com, virtualization@lists.linux.dev, 
 xuanzhuo@linux.alibaba.com, yilun.xu@intel.com
Date: Tue, 20 Aug 2024 13:14:20 +0200
In-Reply-To: <d35a962d-dc95-4469-867e-95b704cca474@wanadoo.fr>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-10-pstanner@redhat.com>
	 <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
	 <3e4288bb7300f3fd0883ff07b75ae69d0532019b.camel@redhat.com>
	 <d35a962d-dc95-4469-867e-95b704cca474@wanadoo.fr>
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-08-20 at 12:50 +0200, Christophe JAILLET wrote:
> Le 20/08/2024 =C3=A0 10:09, Philipp Stanner a =C3=A9crit=C2=A0:
> > > > @@ -556,33 +556,24 @@ static const struct vdpa_config_ops
> > > > snet_config_ops =3D {
> > > > =C2=A0=C2=A0 static int psnet_open_pf_bar(struct pci_dev *pdev, str=
uct
> > > > psnet
> > > > *psnet)
> > > > =C2=A0=C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0=09char name[50];
> > > > -=09int ret, i, mask =3D 0;
> > > > +=09int i;
> > > > +
> > > > +=09snprintf(name, sizeof(name), "psnet[%s]-bars",
> > > > pci_name(pdev));
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=09/* We don't know which BAR will be used to
> > > > communicate..
> > > > =C2=A0=C2=A0=C2=A0=09 * We will map every bar with len > 0.
> > > > =C2=A0=C2=A0=C2=A0=09 *
> > > > =C2=A0=C2=A0=C2=A0=09 * Later, we will discover the BAR and unmap a=
ll other
> > > > BARs.
> > > > =C2=A0=C2=A0=C2=A0=09 */
> > > > =C2=A0=C2=A0=C2=A0=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > > > -=09=09if (pci_resource_len(pdev, i))
> > > > -=09=09=09mask |=3D (1 << i);
> > > > -=09}
> > > > -
> > > > -=09/* No BAR can be used.. */
> > > > -=09if (!mask) {
> > > > -=09=09SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> > > > -=09=09return -ENODEV;
> > > > -=09}
> > > > -
> > > > -=09snprintf(name, sizeof(name), "psnet[%s]-bars",
> > > > pci_name(pdev));
> > > > -=09ret =3D pcim_iomap_regions(pdev, mask, name);
> > > > -=09if (ret) {
> > > > -=09=09SNET_ERR(pdev, "Failed to request and map PCI
> > > > BARs\n");
> > > > -=09=09return ret;
> > > > -=09}
> > > > +=09=09if (pci_resource_len(pdev, i)) {
> > > > +=09=09=09psnet->bars[i] =3D
> > > > pcim_iomap_region(pdev,
> > > > i, name);
> > >=20
> > > Hi,
> > >=20
> > > Unrelated to the patch, but is is safe to have 'name' be on the
> > > stack?
> > >=20
> > > pcim_iomap_region()
> > > --> __pcim_request_region()
> > > --> __pcim_request_region_range()
> > > --> request_region() or __request_mem_region()
> > > --> __request_region()
> > > --> __request_region_locked()
> > > --> res->name =3D name;
> > >=20
> > > So an address on the stack ends in the 'name' field of a "struct
> > > resource".
> >=20
> > Oh oh...
> >=20
> > >=20
> > > According to a few grep, it looks really unusual.
> > >=20
> > > I don't know if it is used, but it looks strange to me.
> >=20
> >=20
> > I have seen it used in the kernel ringbuffer log when you try to
> > request something that's already owned. I think it's here, right in
> > __request_region_locked():
> >=20
> > /*
> > =C2=A0 * mm/hmm.c reserves physical addresses which then
> > =C2=A0 * become unavailable to other users.=C2=A0 Conflicts are
> > =C2=A0 * not expected.=C2=A0 Warn to aid debugging if encountered.
> > =C2=A0 */
> > if (conflict->desc =3D=3D IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> > =09pr_warn("Unaddressable device %s %pR conflicts with %pR",
> > =09=09conflict->name, conflict, res);
> > }
> >=20
> >=20
> > Assuming I interpret the code correctly:
> > The conflicting resource is found when a new caller (e.g. another
> > driver) tries to get the same region. So conflict->name on the
> > original
> > requester's stack is by now gone and you do get UB.
> >=20
> > Very unlikely UB, since only rarely drivers race for the same
> > resource,
> > but still UB.
> >=20
> > But there's also a few other places. Grep for "conflict->name".
> >=20
> > >=20
> > >=20
> > > If it is an issue, it was apparently already there before this
> > > patch.
> >=20
> > I think this has to be fixed.
> >=20
> > Question would just be whether one wants to fix it locally in this
> > driver, or prevent it from happening globally by making the common
> > infrastructure copy the string.
> >=20
> >=20
> > P.
> >=20
>=20
> Not a perfect script, but the below coccinelle script only find this=20
> place, so I would +1 only fixing things here only.
>=20
> Agree?

Yup, sounds good. Copying the string would cause trouble (GFP flags)
anyways.

I'll provide a fix in v2.

Thanks,
P.

>=20
> CJ
>=20
>=20
>=20
> @@
> identifier name;
> expression x;
> constant N;
> @@
> =09char name[N];
> =09...
> (
> *=09pcim_iomap_region(..., name, ...);
> >=20
> *=09pcim_iomap_regions(..., name, ...);
> >=20
> *=09request_region(..., name, ...);
> >=20
> *=09x =3D pcim_iomap_region(..., name, ...);
> >=20
> *=09x =3D pcim_iomap_regions(..., name, ...);
> >=20
> *=09x =3D request_region(..., name, ...);
> )
>=20
>=20

