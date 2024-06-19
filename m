Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F514900C
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802688; cv=none; b=oPcOZa83ZzCEVJnwyXOy/H4gO/WTJBtx3UVp5Ny2k/Gh9Wr6d/f1sdEEerGKdN77D8v0xNEbIIMvW4K0L8gFXiXbNfGfKxt/EL0ce++e/ZWylgQ7W6TZYANsaCfcykuoXSFNtdYXwOdZx7nEhphhBvsib87ix/DwhTuZMf5qgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802688; c=relaxed/simple;
	bh=6MMx9/E3X3W91ugE851hUdJfDhuyenBEGy36UVjDJ3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWT6maJVG87w9GHm/uJKz++xrr6ENg5nDmQQbdGNATEtUeBAA9naifZxvwmy2FPz/NVs2zYmch4rMJxqANFxccrfO3VWD56xzz15KnduiFinGsOWiSFxzVqEMgqz622WuBNAzC6O6lvSpbERdTz2PRap3HVy5i51KbB27OEtmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cs+G8YAl; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs+G8YAl"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA760409A5
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 13:11:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9LMmIIBN4MjA for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jun 2024 13:11:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6CD5740966
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CD5740966
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cs+G8YAl
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6CD5740966
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718802684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNygLwLxnRl00trKraz6/piCD3IZTxeSu/NBGyrNrIo=;
	b=cs+G8YAlwetba2zRsMsZn8NoKNO0bHgv2HpOR5gJpC9yb96cX8h61ljcd5yj8SwyUcnseY
	4W5Gipd4jUSJzFJIvbsFJ44bW9TlT9/bnD8WSWDb/TCF7jp6APPDyIYFBMRIp6hCnNR4qu
	IHjcaeGqrFr+vGU6kNbKYLwvZBCSifc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-tETeq7NBP0CZ72Uf9QNV0Q-1; Wed, 19 Jun 2024 09:11:22 -0400
X-MC-Unique: tETeq7NBP0CZ72Uf9QNV0Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6ef6ac6e0aso342043166b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 06:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802681; x=1719407481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNygLwLxnRl00trKraz6/piCD3IZTxeSu/NBGyrNrIo=;
        b=n7K+uPnA8s00tjeJ30wblkummyWCc7o3x9BnAsUxnQqIEt1A1sR0AvSrHwS05fVBpG
         ttYdWjYGv/tctdcsLP5Zs4aohD32kQVUrjagT1nP+kFSV6Ab5j6Wp2j/Di92+jVGoq9m
         8ZGhaZAuhYyEmprIl9AoMNjfenf8mZV6XQhd63T+HDMzNH/qc/Lrkib+S8yPLhZAqxe0
         RpnE9uoEFEF114chBGJed/ARs/KC87v5yEveul79u/QtgSCil/di3Mv9W4c+DBFBdwnd
         4BjayLjQP1LmVVzLZrLSino52oAkMeNTeJ4jeq7q2RxfUI8N9o4ygh2X0zsebpHtetOz
         zbyw==
X-Forwarded-Encrypted: i=1; AJvYcCUfhS6k6SGtLBJoIstP3OYl/dcKOimcegigY7lbyfPkzbGPmIZ6Flr45xIbwr9yn18g7NCPCnfH0HfvMApHRm7k/HmxVm5vBP6/OtU/0lB//kWGkiDAddWYTQ==
X-Gm-Message-State: AOJu0Yzy0yOf556UMt8YD3gh4G97MVtvLC+LAMBmbZn67dmYC7ugrThZ
	doSu/rTTe/RQyZFjGAmUv3sWvvj1Cc2zdI8ZIC4JLl7AoVzIle0JrLr0gE1o10fgc5hquijO7qE
	x0kGTwjltxdGx8iejlGnrueMpaZPf2UKjVwuj6PKBDu8mqyGalAurWp3vyR+OZrDfneTGRxmZim
	JOR8wU3t5OSTL/AVhKBqXhb8i08OQkRxheyG1GkiTh2EMfQLzBDEoT3A==
X-Received: by 2002:a17:906:31cc:b0:a6e:fb9b:676c with SMTP id a640c23a62f3a-a6fab7dcf3dmr132239366b.68.1718802681423;
        Wed, 19 Jun 2024 06:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEEmubgGou+QZ+1kvAFjWIGTzn5KXKVv/pMwHZqrSCREnG5fUXo5Bg5YKnt2dpd+aruHL5m4QRsXhSoeJdF9M=
X-Received: by 2002:a17:906:31cc:b0:a6e:fb9b:676c with SMTP id
 a640c23a62f3a-a6fab7dcf3dmr132238166b.68.1718802680997; Wed, 19 Jun 2024
 06:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion> <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion> <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAz8xchRroVOyCY@nanopsycho.orion> <20240617094314-mutt-send-email-mst@kernel.org>
 <20240617082002.3daaf9d4@kernel.org> <20240617121929-mutt-send-email-mst@kernel.org>
 <20240617094421.4ae387d7@kernel.org> <20240618063613-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240618063613-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 19 Jun 2024 21:10:41 +0800
Message-ID: <CACLfguWhi9P2ZJwRYiqUDUeCdihQtFFth9OZugXgiisSMaVzqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>, 
	Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 6:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 17, 2024 at 09:44:21AM -0700, Jakub Kicinski wrote:
> > On Mon, 17 Jun 2024 12:20:19 -0400 Michael S. Tsirkin wrote:
> > > > But the virtio spec doesn't allow setting the MAC...
> > > > I'm probably just lost in the conversation but there's hypervisor s=
ide
> > > > and there is user/VM side, each of them already has an interface to=
 set
> > > > the MAC. The MAC doesn't matter, but I want to make sure my mental =
model
> > > > matches reality in case we start duplicating too much..
> > >
> > > An obvious part of provisioning is specifying the config space
> > > of the device.
> >
> > Agreed, that part is obvious.
> > Please go ahead, I don't really care and you clearly don't have time
> > to explain.
>
> Thanks!
> Just in case Cindy who is working on it is also confused,
> here is what I meant:
>
> - an interface to provision a device, including its config
>   space, makes sense to me
> - default mac address is part of config space, and would thus be covered
> - note how this is different from ability to tweak the mac of an existing
>   device
>
Thanks Micheal, I will continue working in this
thanks
cindy
>
> --
> MST
>

