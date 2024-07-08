Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AD84DF8
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437956; cv=none; b=QL2LqqmEkqQ0krJ4LzDBeEqeBw8CL971D7lEJnvfpiTb/cgGWT3zuBEdxWRVlpQxyWXZUMrQ/wmeXUYRy05dtF3X1mLNFwN0TbXHVyZZXYzEor/edD7VRiKwWFfkYB17fbG/MJ7kV4SvAG0vZuepqZxYXJDe9ktrb8FZdhihwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437956; c=relaxed/simple;
	bh=wSXAufGS33A+g31uLFNE5gMkFnYRYUjMJqfaxxbqvlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dR++ytWT/hlS0O9ncHOkLGGEiLSlZEwgFgde238B2c75jget1BD2iYjQ8GF6KAs3UB1OoIDa+ZQXe+ocyGIgBS9mLzZU4+Wgq+wcHVCER1VjqW0y91WpNV39/sU2Q/LsGffHQwxIPQbb/6Iusc8VkMaFUDiHs2QH7BQN+Xl8OzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIhOiJFl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIhOiJFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720437953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbjlsnNLRZ3Y3h4bS5hjT+as3LF63nqqhBb1T5h2agU=;
	b=bIhOiJFl847cBsln9QgTInA6oDYqXbk8Kx1dRy6YCEZQTqMD6F35mhpxnZUMegEL4iQ59a
	nof2XCROGUVPVjgyWEtkr8Tx/AwOvvHTb3Aw/LBp3E2bSq6cvNG61Go+ii4MaYOfsx+5ZC
	VWuY0R3y44GRslZeim2sGJ/LslbBPrc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-TzmOV-ALN_-_UPKM12Vo4A-1; Mon, 08 Jul 2024 07:25:50 -0400
X-MC-Unique: TzmOV-ALN_-_UPKM12Vo4A-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52ea237ef5aso3594600e87.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 04:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437948; x=1721042748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbjlsnNLRZ3Y3h4bS5hjT+as3LF63nqqhBb1T5h2agU=;
        b=keLsPpck0M8wnw7BCWgZuzAvUuHPfxXc7+AbOSykpXvcBuzWy4HoQqfNQd8kx9F2tU
         gBZpRWrl/r6FS0WszpnS1jKCouYvXAUcImLFAE1WATYfeVQzweBiyBXQkRdghgogK3Gu
         iypZzYlJ11TXwG81+1zu/fdLkJNRA+GUNOYStz7Ip81s5eq1q6D9hKiutCpwbbxVfaUT
         bkX4b/opzQSx76u1HfMEVf4BRckaYEMA82BicRuVwREpiLeVf+IYGZuia7ug0+nHiuMu
         N/H1mVmidK6IbGrv/3kHBquw6FBMA00sDzA84acj7ajdG48vXaf2cmKpRmW4Cm7RUzGU
         OL3A==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+cTWBtnvAuAuIz65YxgQJSJU70K7DZZhb2RULsJMTBl0ukqyL/N0Dkq4qS6NFXNekNI/kajQpP1BmoFf3Aaw+iUVmFPY+YIE6AomRVc=
X-Gm-Message-State: AOJu0Ywcm6Bp9zygClQLfr/UpOlRLeoNjTHwPs406JpUvQUvs+zjT5TE
	aWR/SWYj8anP9r8DsfUwM9c+wJ1jB5+ZjMDegtfzGT1uuxTXsx+84sbRMyy3wwd55cwXZpcf20J
	yL7FXT4je9yhHvykXbBrfsv/acSubCNx4la4/Cex1tt8UL4i3u6OM1y6fkFmGlo6b
X-Received: by 2002:ac2:5dcb:0:b0:52c:dda1:5db1 with SMTP id 2adb3069b0e04-52ea0719788mr6849933e87.67.1720437948515;
        Mon, 08 Jul 2024 04:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4an8RKcAHlkP4SpdhvIfOcH9d3f3yG6Oc24mAEVDoPz82fV114LsKh2i7viRb5K4t/8C0bw==
X-Received: by 2002:ac2:5dcb:0:b0:52c:dda1:5db1 with SMTP id 2adb3069b0e04-52ea0719788mr6849913e87.67.1720437947876;
        Mon, 08 Jul 2024 04:25:47 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2519a4sm160086225e9.35.2024.07.08.04.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:25:47 -0700 (PDT)
Date: Mon, 8 Jul 2024 07:25:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Tariq Toukan <tariqt@nvidia.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Message-ID: <20240708072443-mutt-send-email-mst@kernel.org>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
 <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com>
 <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
 <CAJaqyWeHDD0drkAZQqEP_ZfbUPscOmM7T8zXRie5Q14nfAV0sg@mail.gmail.com>
 <c6dc541919a0cc78521364dbf4db32293cf1071e.camel@nvidia.com>
 <20240708071005-mutt-send-email-mst@kernel.org>
 <27ef979aff26d3614091a4b966fc8b1d866e236f.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <27ef979aff26d3614091a4b966fc8b1d866e236f.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 08, 2024 at 11:17:06AM +0000, Dragos Tatulea wrote:
> On Mon, 2024-07-08 at 07:11 -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 08, 2024 at 11:01:39AM +0000, Dragos Tatulea wrote:
> > > On Wed, 2024-07-03 at 18:01 +0200, Eugenio Perez Martin wrote:
> > > > On Wed, Jun 26, 2024 at 11:27 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > > > 
> > > > > On Wed, 2024-06-19 at 17:54 +0200, Eugenio Perez Martin wrote:
> > > > > > On Mon, Jun 17, 2024 at 5:09 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > > > > > 
> > > > > > > Currently, hardware VQs are created right when the vdpa device gets into
> > > > > > > DRIVER_OK state. That is easier because most of the VQ state is known by
> > > > > > > then.
> > > > > > > 
> > > > > > > This patch switches to creating all VQs and their associated resources
> > > > > > > at device creation time. The motivation is to reduce the vdpa device
> > > > > > > live migration downtime by moving the expensive operation of creating
> > > > > > > all the hardware VQs and their associated resources out of downtime on
> > > > > > > the destination VM.
> > > > > > > 
> > > > > > > The VQs are now created in a blank state. The VQ configuration will
> > > > > > > happen later, on DRIVER_OK. Then the configuration will be applied when
> > > > > > > the VQs are moved to the Ready state.
> > > > > > > 
> > > > > > > When .set_vq_ready() is called on a VQ before DRIVER_OK, special care is
> > > > > > > needed: now that the VQ is already created a resume_vq() will be
> > > > > > > triggered too early when no mr has been configured yet. Skip calling
> > > > > > > resume_vq() in this case, let it be handled during DRIVER_OK.
> > > > > > > 
> > > > > > > For virtio-vdpa, the device configuration is done earlier during
> > > > > > > .vdpa_dev_add() by vdpa_register_device(). Avoid calling
> > > > > > > setup_vq_resources() a second time in that case.
> > > > > > > 
> > > > > > 
> > > > > > I guess this happens if virtio_vdpa is already loaded, but I cannot
> > > > > > see how this is different here. Apart from the IOTLB, what else does
> > > > > > it change from the mlx5_vdpa POV?
> > > > > > 
> > > > > I don't understand your question, could you rephrase or provide more context
> > > > > please?
> > > > > 
> > > > 
> > > > My main point is that the vdpa parent driver should not be able to
> > > > tell the difference between vhost_vdpa and virtio_vdpa. The only
> > > > difference I can think of is because of the vhost IOTLB handling.
> > > > 
> > > > Do you also observe this behavior if you add the device with "vdpa
> > > > add" without the virtio_vdpa module loaded, and then modprobe
> > > > virtio_vdpa?
> > > > 
> > > Aah, now I understand what you mean. Indeed in my tests I was loading the
> > > virtio_vdpa module before adding the device. When doing it the other way around
> > > the device doesn't get configured during probe.
> > >  
> > > 
> > > > At least the comment should be something in the line of "If we have
> > > > all the information to initialize the device, pre-warm it here" or
> > > > similar.
> > > Makes sense. I will send a v3 with the commit + comment message update.
> > 
> > 
> > Is commit update the only change then?
> I was planning to drop the paragraph in the commit message (it is confusing) and
> edit the comment below (scroll down to see which).
> 
> Let me know if I should send the v3 or not. I have it prepared.

You can do this but pls document that the only change is in commit log.


> > 
> > > > 
> > > > > Thanks,
> > > > > Dragos
> > > > > 
> > > > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 37 ++++++++++++++++++++++++++++++++-----
> > > > > > >  1 file changed, 32 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index 249b5afbe34a..b2836fd3d1dd 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -2444,7 +2444,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > > > >         mvq = &ndev->vqs[idx];
> > > > > > >         if (!ready) {
> > > > > > >                 suspend_vq(ndev, mvq);
> > > > > > > -       } else {
> > > > > > > +       } else if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
> > > > > > >                 if (resume_vq(ndev, mvq))
> > > > > > >                         ready = false;
> > > > > > >         }
> > > > > > > @@ -3078,10 +3078,18 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> > > > > > >                                 goto err_setup;
> > > > > > >                         }
> > > > > > >                         register_link_notifier(ndev);
> > > > > > > -                       err = setup_vq_resources(ndev, true);
> > > > > > > -                       if (err) {
> > > > > > > -                               mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> > > > > > > -                               goto err_driver;
> > > > > > > +                       if (ndev->setup) {
> > > > > > > +                               err = resume_vqs(ndev);
> > > > > > > +                               if (err) {
> > > > > > > +                                       mlx5_vdpa_warn(mvdev, "failed to resume VQs\n");
> > > > > > > +                                       goto err_driver;
> > > > > > > +                               }
> > > > > > > +                       } else {
> > > > > > > +                               err = setup_vq_resources(ndev, true);
> > > > > > > +                               if (err) {
> > > > > > > +                                       mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> > > > > > > +                                       goto err_driver;
> > > > > > > +                               }
> > > > > > >                         }
> > > > > > >                 } else {
> > > > > > >                         mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
> > > > > > > @@ -3142,6 +3150,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
> > > > > > >                 if (mlx5_vdpa_create_dma_mr(mvdev))
> > > > > > >                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
> > > > > > >         }
> > > > > > > +       setup_vq_resources(ndev, false);
> > > > > > >         up_write(&ndev->reslock);
> > > > > > > 
> > > > > > >         return 0;
> > > > > > > @@ -3836,8 +3845,21 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > > > > > >                 goto err_reg;
> > > > > > > 
> > > > > > >         mgtdev->ndev = ndev;
> > > > > > > +
> > > > > > > +       /* For virtio-vdpa, the device was set up during device register. */
> > > > > > > +       if (ndev->setup)
> > > > > > > +               return 0;
> > > > > > > +
> This comment updated to:
> 
> /* The VQs might have been pre-created during device register.
>  * This happens when virtio_vdpa is loaded before the vdpa device is added.
>  */
> 
> 
> > > > > > > +       down_write(&ndev->reslock);
> > > > > > > +       err = setup_vq_resources(ndev, false);
> > > > > > > +       up_write(&ndev->reslock);
> > > > > > > +       if (err)
> > > > > > > +               goto err_setup_vq_res;
> > > > > > > +
> > > > > > >         return 0;
> > > > > > > 
> > > > > > > +err_setup_vq_res:
> > > > > > > +       _vdpa_unregister_device(&mvdev->vdev);
> > > > > > >  err_reg:
> > > > > > >         destroy_workqueue(mvdev->wq);
> > > > > > >  err_res2:
> > > > > > > @@ -3863,6 +3885,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> > > > > > > 
> > > > > > >         unregister_link_notifier(ndev);
> > > > > > >         _vdpa_unregister_device(dev);
> > > > > > > +
> > > > > > > +       down_write(&ndev->reslock);
> > > > > > > +       teardown_vq_resources(ndev);
> > > > > > > +       up_write(&ndev->reslock);
> > > > > > > +
> > > > > > >         wq = mvdev->wq;
> > > > > > >         mvdev->wq = NULL;
> > > > > > >         destroy_workqueue(wq);
> > > > > > > 
> > > > > > > --
> > > > > > > 2.45.1
> > > > > > > 
> > > > > > 
> > > > > 
> > > > 
> > > 
> > 
> Thanks,
> Dragos
> 

