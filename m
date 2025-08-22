Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE90286D4C
	for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867846; cv=none; b=PPyqCuCqQ07FXmCTbiwz72s3WMDwxrReKwvZUZxfdWnYY8SpzULPWjsiXeMAJkyVl4U78jRfKOPQb5IahkqKh+jiYjEbkc2YelWHTkgaru3DXKXFQjvknfz3p3eo+enN+AQUgY+RPq7vXY603MVfpyI0lH+BO81ht1CCoi5hlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867846; c=relaxed/simple;
	bh=n922tzKEixyTFAkTAqnzJwmbXE0RKvWKZfpZ/AspRKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j7g3h38eGqnrdpzDmEbbuFt7KhsgArluDQErzpkNjIt+0f+tdTlt1DFQvKQgiMFNObHYJTQ60yprDSLDB4pJw7p5aYOhf2ZHWtL97bWgsradyYVCA2+MiK6hw9ADrWMObytSUMxcOhYae4yI19bftbaSvj11pgUAcjtJsxXvMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDQbHX/8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDQbHX/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755867843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HQb772XW6mDHLLr/wV9DU+xM69+Gf7mm1yUdHyKM7eE=;
	b=JDQbHX/8DQU3GzCITTQ+M6W/djzb+ObKmvm+ulLWE2mV3W6/UtH8DrOfV0m7wqeivNvdrh
	+IjiKDsOp0MGeAolUwRih9HKMr9UAM4+2YqNbF7Q05K6MhcCM8l4mtglTGVwCoOnlpb46y
	lEogEUYbzOfDzG/2WRVnWCPrgkWGK8M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-SREp4YT4M-C7nYz0Hp-giQ-1; Fri, 22 Aug 2025 09:04:01 -0400
X-MC-Unique: SREp4YT4M-C7nYz0Hp-giQ-1
X-Mimecast-MFC-AGG-ID: SREp4YT4M-C7nYz0Hp-giQ_1755867840
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9d41b88ffso1219254f8f.0
        for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 06:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867840; x=1756472640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQb772XW6mDHLLr/wV9DU+xM69+Gf7mm1yUdHyKM7eE=;
        b=BTx40b519rRMZ47WVkbqw+0vtSZCxOeGXTw9tJaJkyicfG3HMzfSGBS0H5jEdxFxdC
         EkacjKDBa1Lbv5/uLEZ5d61Klf+YM1WWWZaU7IP8bi/koPIabrD5JFwVd/z1b9xdLlNB
         FGG5nY9fNVQvJDvIkBU7ZJSj1JqMJMuDofEqlAw5JGjq8z/gSkd9C/U6TuWyzWjxvRgP
         N004imls5AbezQkbo9SziUP1l8UubJDcADWh6w4Mf8sb0QeGVlgOwJShme38QcIAunPG
         dvZ2LvN0Vlku1pRpaf+HLP0vqR5/MHGqWsWXfXWe7Hd8q8hN+JkR3y+3u4BLMcw/wtpc
         JGuQ==
X-Gm-Message-State: AOJu0Yxeto2Lwu7zdVoWVEb3cGewSSVnmNosnAZDBQA3JCPejK3j/ExZ
	KSxDzHE9yH4D8M9GeI1NQjKDPOwFBsiLv7mgsO91UEahB8XUz8+SXGr7q5nuy7JqX0RBOlB0XFC
	r9bxiBmL8l8ebk6ulEerGiimOcpKE08GtlxsutnpGRIToHO6akZg3p4JKhY69SEjyidUE
X-Gm-Gg: ASbGncvJCv7FbYG2sywUtEww9UJ0yNhQbMCyoj/F6KFwx47+6Nx3PyFrZZUhYx66ICD
	nbM1sIaR/twDtjx3aw2rAdVm4zbGbnLzdraV5YVraxQtMgtu0cPysaYueS0Qvtu3qDERLs8ag4j
	i3bRshlT8i0ddEM0lWDPabz7eVaFnzDADzKFrACw2SHQbBMyBcufopNRC2SDC+ow6n/c+Y+ne+v
	jPMghb2+3qlL9CumfKN0EqUthqzvRIZm695j4xdK5z9flw45KnJFEOTwpKQ9ecFSZbmNbsNuxVp
	iiPzUI9hp8bYUnjKtG7Ee2D8aR32X9BU
X-Received: by 2002:a5d:4283:0:b0:3c6:71c4:15b1 with SMTP id ffacd0b85a97d-3c671c41891mr1015393f8f.37.1755867840151;
        Fri, 22 Aug 2025 06:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFhC5B1jD8ZfPwkZJ3jikuS5+ewej/ZadWsC7KMuAIXD26cfW9TJH3ggA76ktwpgn5qb6F8Q==
X-Received: by 2002:a5d:4283:0:b0:3c6:71c4:15b1 with SMTP id ffacd0b85a97d-3c671c41891mr1015358f8f.37.1755867839631;
        Fri, 22 Aug 2025 06:03:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c66f532992sm1535036f8f.38.2025.08.22.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:03:59 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:03:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250822090249-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b1FckMtkRKxrHhLI1rusPwNQJIhvdu0scvoqtKDssyQ_1755867840
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 22, 2025 at 12:22:50PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 22 August 2025 03:52 PM
> > 
> > On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > virtio pci device").
> > >
> > > Virtio drivers and PCI devices have never fully supported true
> > > surprise (aka hot unplug) removal. Drivers historically continued
> > > processing and waiting for pending I/O and even continued synchronous
> > > device reset during surprise removal. Devices have also continued
> > > completing I/Os, doing DMA and allowing device reset after surprise
> > > removal to support such drivers.
> > >
> > > Supporting it correctly would require a new device capability
> > 
> > If a device is removed, it is removed. 
> This is how it was implemented and none of the virtio drivers supported it.
> So vendors had stepped away from such device implementation.
> (not just us).


If the slot does not have a mechanical interlock, I can pull the device
out. It's not up to a device implementation.

-- 
MST

