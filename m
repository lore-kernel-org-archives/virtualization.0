Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AD1D5AA1
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331057; cv=none; b=hd7Fp5pE2Fir8G4xlAsIIzDetaIyx3iAwKv68NSy0uTMYxApR29NafJmQAzkqnNEsUlx9EbKBZJCe3kMWxzMWPbYjPtCE0/aM6E2xAuF2oqEc1TJTuhOS1taf+hXD3J/XUyZRyDg0KikD+JpgOJHpxphuNyj6cD0hhIDOXXhfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331057; c=relaxed/simple;
	bh=Bch2cKPtXECxyMiRYL7GPnBkHtA896F6VG4XJsI6Bfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GqVrqFGqo5EJaG7ZECF3kLRHq4cql4AgiAQqSa2MZdgGfFWWltvdM52dSaEmkXk6MNddOviWYTltONf3duGA1LbxgEqSuM17/LkgJs+BuA/Gk9n1e9gOzEgKG03zhfKuQnI+v8eoKPSf5kR5LRhtAHv6mVsFqQg8yVQuO+mPz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAgTCwo7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAgTCwo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727331055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RjSVYac32dBYaX9AWPj/48j4zB2h/xloFIfMJMVcpU=;
	b=LAgTCwo7aOxkkyVFaeMvGpUQ+LYuFzg1TbIT3JARW7JRBVGBpFiwSuU9B5v1B6tBlsk5aX
	Wqs2vCPFWtHhBQd8d0wboJyU6yJez3+XSCEqDje8BiL9JX+feWvOfabKPiY/5IIbLFBth8
	RCT7RWL9O4Uxw7fz8taa5MUVFrYNCXU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-1eFFz-H6PE6vXf34p8TniA-1; Thu, 26 Sep 2024 02:10:54 -0400
X-MC-Unique: 1eFFz-H6PE6vXf34p8TniA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c90d24e3so317711f8f.0
        for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 23:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727331052; x=1727935852;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RjSVYac32dBYaX9AWPj/48j4zB2h/xloFIfMJMVcpU=;
        b=Y2P0h1L/C0Bgdx/MQXuWylEbDRNA6mFo7Ax+uBI2HUOIbROlF8liciB3f5o5YBZ2e8
         +9EAith8Utj94d0FafpamytXW/4xtlp8RfFinN+T3EPKhVV08zDqx3AoNr8yWWAusUeg
         01a+zdbEMqzFid6Borf1VRRPQZgWXy5adsA8CQgUJzZDY1O+lZ49+nsB7TJ9RWBIw4Gx
         Cjh4T8A+S85+Kf9VG70pu3K63dzs8vSPH6hHs1bkBVgfAhQcwxNN24f9iBewbdCeLk9D
         TemVqhXbWFO4YPuqpM5QEDxJqu5aJ15AtN/mR3z+KNcFJfnHm2Vo559DXVZWNkFCatq6
         DpLA==
X-Forwarded-Encrypted: i=1; AJvYcCXkwlIxoJoIxZoPJ7TwnaOkBbhDVIbt5HNMDqIcH8Lul/nj/0tfbqfUCM/jBX14Jkai0qRfnOaICZinZbWzMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv4Gmto21iCabuG7eV9BQKelfDu9bBwhwHXPdXx86q2Q8T5X6P
	22hrt9e+L7vImrTya8AnU09OWxYiGIt031bWi97toS9Mw04CerkILKtm9561Wrts27+bWxmg6vZ
	rRnzxoMVfJnqwa5tlzW3TwRdRMuWm5r38ypW2hROCu1e5epEQTHWc2Fa2gYkFvHO9FchdRKz3
X-Received: by 2002:a5d:4a8f:0:b0:37c:cea2:826f with SMTP id ffacd0b85a97d-37ccea28442mr1037790f8f.2.1727331052399;
        Wed, 25 Sep 2024 23:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhm4/4mW6QgX0Wz0mvHjYZuO23RyqB2N7qOdiVsFqaT9GJXEx5cUBcu0ZBP50O/vgHNIYc1Q==
X-Received: by 2002:a5d:4a8f:0:b0:37c:cea2:826f with SMTP id ffacd0b85a97d-37ccea28442mr1037770f8f.2.1727331051885;
        Wed, 25 Sep 2024 23:10:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:1ead:3828:4c0c:a50:df14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31f35bsm5543737f8f.96.2024.09.25.23.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:10:51 -0700 (PDT)
Date: Thu, 26 Sep 2024 02:10:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Jianguo Sun (QUIC)" <quic_jianguos@quicinc.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"Anant Goel (QUIC)" <quic_anantg@quicinc.com>
Subject: Re: [PATCH 1/2] Virtio: Add CONFIG_VIRTIO_MMIO_POLL_RESET
Message-ID: <20240926020950-mutt-send-email-mst@kernel.org>
References: <20240922123435.17946-1-quic_jianguos@quicinc.com>
 <CACGkMEv1ndVVwVrD1J_ghHpyZB0=3sLdSrXxchZ2QoQzMJihdA@mail.gmail.com>
 <DM5PR02MB3638C8F46A0F3088DE06402EF06A2@DM5PR02MB3638.namprd02.prod.outlook.com>
 <CACGkMEuLdxbRxZYqKW1akHJ_Jjse4OatLEVmH4QFsM_K+iAr_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuLdxbRxZYqKW1akHJ_Jjse4OatLEVmH4QFsM_K+iAr_w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Sep 26, 2024 at 11:50:32AM +0800, Jason Wang wrote:
> On Thu, Sep 26, 2024 at 11:31 AM Jianguo Sun (QUIC)
> <quic_jianguos@quicinc.com> wrote:
> >
> > Hi @Jason
> >
> > Both hypervisor and backend device may need to support virtio-mmio device reset
> 
> Then you need to patch the virtio spec first. Or it is already
> supported by the spec?
> 
> > Adding CONFIG_VIRTIO_MMIO_POLL_RESET is for the system that has such support.
> 
> And we will probably have a feature or transport bit/flag for this.
> 
> Thanks

feature bits can't affect reset.
I don't know what a transport bit/flag is, in the context of MMIO.

We can just make it a recommendation.


> >
> > A config option (feature bit) is a better approach.
> > Thanks for the review.
> >
> > BR
> > Jianguo
> >
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, September 24, 2024 3:39 PM
> > To: Jianguo Sun (QUIC) <quic_jianguos@quicinc.com>
> > Cc: mst@redhat.com; xuanzhuo@linux.alibaba.com; eperezma@redhat.com; virtualization@lists.linux.dev; Anant Goel (QUIC) <quic_anantg@quicinc.com>
> > Subject: Re: [PATCH 1/2] Virtio: Add CONFIG_VIRTIO_MMIO_POLL_RESET
> >
> > On Sun, Sep 22, 2024 at 8:35 PM Jianguo Sun <quic_jianguos@quicinc.com> wrote:
> > >
> > > Add CONFIG_VIRTIO_MMIO_POLL_RESET to as an option to enable
> > > synchronous reset for the MMIO based transport for virtio.
> > >
> > > Change-Id: Ifa7e29b4c0cfa26922535f921c6ab69eacdc4cfc
> > > Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> > > Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
> >
> > Any reason this is not a feature but a config option?
> >
> > > ---
> > >  drivers/virtio/Kconfig | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig index
> > > 42a48ac763ee..fb17b1078d53 100644
> > > --- a/drivers/virtio/Kconfig
> > > +++ b/drivers/virtio/Kconfig
> > > @@ -188,4 +188,12 @@ config VIRTIO_DEBUG
> > >
> > >           If unsure, say N.
> > >
> > > +config VIRTIO_MMIO_POLL_RESET
> > > +       bool "Virti-mmio device synchronous reset support"
> > > +       depends on VIRTIO_MMIO
> > > +       help
> > > +         Say y here to enable synchronous reset for the MMIO transport based
> > > +         virtio device. After writing 0 to device_status, the driver must
> > > +         wait for a read of device_status to return 0 before reinitializing
> > > +         the device.
> > >  endif # VIRTIO_MENU
> > > --
> > > 2.17.1
> > >
> >
> > Thanks
> >

