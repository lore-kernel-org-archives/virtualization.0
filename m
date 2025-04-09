Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3291C3BE0
	for <virtualization@lists.linux.dev>; Wed,  9 Apr 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214551; cv=none; b=hB0m4FSWTOqTB3RUKvSNgGgL9U7ICVPHauTlfu2HXCVwzvuPtQEsGwZa2BYuSCYJfu96bU/b4ruJHGqvD4QuH6OSPM/lvdt17ttWal7W0V0rs0jMCOlQ6coUsUIPWHqv+hbwJmdbqaa0gmmwpfCnXepmBNhI3+KGsaRqvbDS2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214551; c=relaxed/simple;
	bh=iLOOZgcKCxmS9diP1p/CTcxPlq8i83pLfIIeCIiFfHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Trn5uIjyMW8Wz7Kk0JD3Z+KOee6c7soS1YAnlVLbTbZZEvCXu/etijx7f8yndlt2Po+mwsX1tGRh+ZvEWH5oblGCxIo4KCK/HS2pfnbn5sqLZaA2H5sryqkpa11cPzPjFd2wuTldp8qyGQH1cuq1omZ+O3ZUQA4QWk0KRfYN4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8ak22zt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8ak22zt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744214548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7S6RTtnxjFtETXDaFSyTSU/GXOPgC2C8pONoXXV9POg=;
	b=T8ak22zteDeX0KL6DuOYmfE3Ve//Lee06dOqHigpTQs0d8eafksHwovUtHD/+vPWySybqr
	P2vgxPH14f4i6YGhXLzRSwqg6TNR85GFis4FL6aZhJznmaP4FGF9wl97j3P+3Zqv0XTDrX
	qRw5bIBRBYtA7dQ3JoMamTkbixwheM4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-SXNAsfQMNmm0nBfZSEYgdw-1; Wed, 09 Apr 2025 12:02:26 -0400
X-MC-Unique: SXNAsfQMNmm0nBfZSEYgdw-1
X-Mimecast-MFC-AGG-ID: SXNAsfQMNmm0nBfZSEYgdw_1744214546
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso24990185e9.3
        for <virtualization@lists.linux.dev>; Wed, 09 Apr 2025 09:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744214545; x=1744819345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S6RTtnxjFtETXDaFSyTSU/GXOPgC2C8pONoXXV9POg=;
        b=uhE44+nhFZssJU+Yq7yVzt1I/5mqbJ40C9NsxvXYe30mJ8NLohHGva+BGrVJW4kDOU
         kQKa+1ti4yaT/7Bm/wTJdpr7+FZoEWPo24wX0HLhHBekdpe2ODUam5XfkKDpJuXuWkmh
         NI49wI6mtDXoTYorvNEbqW1nhVW2hrGKREbpgrmfmWp5Y1xLxltZj/g5TFGoxJR4K1Tb
         /COupKV1XKoiT6YJOPHYjpn1pCVGCqhxfebZP7g5T1tE/6O55pi4qjalGnDqgFcknLOK
         BB33ZHQ5ZHQUr677znhrrndjO4I76dVCfFA9jtl6F+c90VYbaWuhILxymWSWgOPkUdX8
         sccQ==
X-Gm-Message-State: AOJu0YwF/3QuVn45+QVkxN6SJgyoBVbNvOzSTjIb0IiPsHg5RvW+9xbL
	eHcpxqEqxz2c3j6+GuB+01jN8E/qp57KzVRULrdG1vo4aWkjP099KudFvs9q6n+XVz7xsefV3Cv
	B77IRsVESLtmILIFq3Z01DTRW+p92CeU/YlLBnGAi0BLs0/VgQfkmLncanMs+87KS
X-Gm-Gg: ASbGncvCLVXTD8V4LIkn33oO5oSWXsVRA5mP0M9AvznsG0OLoHdonROCGu/4PC8ylPs
	j4eYQ1X8jGMKnXNkW+3LCn8jwCmwzaXiJSdDa1OILlcZUgzmzLJup6c11NQvK8F8kjQOR69MJ2+
	Q0SK5EPmEmhUgGf+JqtDGev/Tm+tDePgyCQKZu+xXKbKNkGiaBQ+HdNcG90iyUqfTo+QlG6uJxS
	/AtpHxpOVL9muehUE/kxWcr/D8lHoQB3p77i1TImcr003jMDGs0xeUNQepWwbgv4oawTOekkegv
	X7wIXQ==
X-Received: by 2002:a05:600c:1d94:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-43f1ed0b0eamr35743005e9.18.1744214544886;
        Wed, 09 Apr 2025 09:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Bb6EmagTxZr/IPFdSrQ4pZmpEZzF/2D8XI9ZNwOy9pr/mbv5QWqwhjozrawKvYW7bh/KpA==
X-Received: by 2002:a05:600c:1d94:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-43f1ed0b0eamr35740785e9.18.1744214542977;
        Wed, 09 Apr 2025 09:02:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fdfd9sm2035636f8f.92.2025.04.09.09.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:02:22 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:02:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250409115557-mutt-send-email-mst@kernel.org>
References: <20250408145908.51811-1-parav@nvidia.com>
 <20250408155057-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71957D9729A72B8BD76513C0DCB42@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB71957D9729A72B8BD76513C0DCB42@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xAaW_A7Lp-dc59tbBwsfalJHdIhn4Zcma1_oZQ8NGsY_1744214546
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 01:50:18PM +0000, Parav Pandit wrote:
> Hi Michael,
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 9, 2025 1:45 AM
> > 
> > On Tue, Apr 08, 2025 at 05:59:08PM +0300, Parav Pandit wrote:
> > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > virtio pci device").
> > >
> > > The cited commit introduced a fix that marks the device as broken
> > > during surprise removal. However, this approach causes uncompleted I/O
> > > requests on virtio-blk device. The presence of uncompleted I/O
> > > requests prevents the successful removal of virtio-blk devices.
> > >
> > > This fix allows devices that simulate a surprise removal but actually
> > > remove gracefully to continue working as before.
> > >
> > > For surprise removals, a better solution will be preferred in the future.
> > 
> > Sorry I'm not breaking one thing to fix another.
> > Device is gone so no new requests will be completed. Why not complete all
> > unfinished requests, for example?
> > 
> > Come up with a proper fix pls.
> > 
> I would also like to have a proper fix that can be backportable.
> However, an attempt [1] had race.
> To overcome the race, a different approach also tried, however the block layer was stuck even if all requests in virtio-blk driver layer was completed like you suggested.
> 
> It appeared that supporting uncompleted requests won't be so straightforward to backport.
> 
> Hence, the request is to revert and restore the previous behavior.
> This at least improves the case where the OS thinks that surprise removal occurred, but the device eventually completes the IO.
> And hence, virtio block driver successfully unloads.
> And virtio-net also does not experience the mentioned crash.
> 
> [1] https://lore.kernel.org/all/20240217180848.241068-1-parav@nvidia.com/

Parav this is a commit from 2021. I am not reverting it "because it
seems to help". We'll never make progress like this.
You will have to debug and fix it properly. Sorry.

Once we have a fix, we will worry about backports and stuff, this
is how we do kernel development here.


> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@baidu.com/
> > > Reviewed-by: Max Gurtovoy<mgurtovoy@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > 
> > > ---
> > >  drivers/virtio/virtio_pci_common.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c
> > > b/drivers/virtio/virtio_pci_common.c
> > > index d6d79af44569..dba5eb2eaff9 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev
> > *pci_dev)
> > >  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > >  	struct device *dev = get_device(&vp_dev->vdev.dev);
> > >
> > > -	/*
> > > -	 * Device is marked broken on surprise removal so that virtio upper
> > > -	 * layers can abort any ongoing operation.
> > > -	 */
> > > -	if (!pci_device_is_present(pci_dev))
> > > -		virtio_break_device(&vp_dev->vdev);
> > > -
> > >  	pci_disable_sriov(pci_dev);
> > >
> > >  	unregister_virtio_device(&vp_dev->vdev);
> > > --
> > > 2.26.2

