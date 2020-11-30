Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B750C63777
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 15:31:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17672076B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 15:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTRqMtj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17672076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2F0DA22844;
	Mon, 30 Nov 2020 15:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f3l30azt5Nxe; Mon, 30 Nov 2020 15:31:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6FFFB22CCE;
	Mon, 30 Nov 2020 15:31:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F7D6C0859;
	Mon, 30 Nov 2020 15:31:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6311AC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 15:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 219F68723C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 15:31:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dnlos3-An0gp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 15:30:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CDEFF8723A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606750257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mSq1E62E7wz6JRt2Y3RxWKfynONuZ8BYJwR+me11tnw=;
 b=YTRqMtj+8OmEUD/I5PhrvNIiKchnMGUEJggz6r61oBCSZWEyBOYgycUWBqlPaO++bsdYRP
 V0Yz8YI7yn6669kujYa2IZvtVjr32QkufU95iCBuLvS/Dh2R3cOPLva0AcNST+mI+JrSG4
 mLA2WZikuLV+7m6EfT5YMZUH2/gmvmM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-0Up3OvbVMpqnLDZqzojUQg-1; Mon, 30 Nov 2020 10:30:48 -0500
X-MC-Unique: 0Up3OvbVMpqnLDZqzojUQg-1
Received: by mail-wm1-f69.google.com with SMTP id r5so2145637wma.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 07:30:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mSq1E62E7wz6JRt2Y3RxWKfynONuZ8BYJwR+me11tnw=;
 b=dnb7C9B0u3Y+Nwc/HmyhUAYrvUM98IslsGE0cRBvCsX9UiclakPP6UXn17+cE+sXNk
 T1ZMTRtwC+5UGhFTj2SF9nTTHMzew9XsXXkFxGqSUxJKCR4tKdxVv86RBKl+ZJ616HKs
 9EjLqnFCqjspAA/1s4mSuulel+/z82TIdL6wF9Y+uazTCJDJK5wEB3KlfumQgZWw697x
 tl+uRwAMT8GPgbutk8YOuEIcYTUbvJuAmnKMx0DV2BFOpuGwWR0btGLe9ipL0OUvyMP8
 SYF7aNeJetrsLdrOueI3yzEQJINHyENllYzsTRPlEHO0haCWrXARuveh4x1zRlpxTx+i
 SCFw==
X-Gm-Message-State: AOAM533vQdvaIzfaFMJRUy/mkOt/Wardh672b7gjO4iaeRima2g83KsD
 GapRu5T5o2DW5pEUC49TJBeCHyIN1zX4Md+JOgm47sKOA8L+pt+gI+uQzbmc/ob8hoaT65DTlDE
 ZyAAKG1W7+Mk8f70lpr7UpeTG18pHkw2BXaSvA+5vyg==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr30380251wra.247.1606750246557; 
 Mon, 30 Nov 2020 07:30:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLfsWdwn+ngcuaGhodnrBSo95VO8/Fqkp8mEji2+ltAV+F81gZF2wnOT7/jRgqO+l3faOIEw==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr30380223wra.247.1606750246129; 
 Mon, 30 Nov 2020 07:30:46 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id q4sm3852657wmc.2.2020.11.30.07.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 07:30:45 -0800 (PST)
Date: Mon, 30 Nov 2020 10:30:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130102633-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <20201130115106.GC99449@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20201130115106.GC99449@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, lulu@redhat.com,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 30, 2020 at 01:51:06PM +0200, Eli Cohen wrote:
> On Mon, Nov 30, 2020 at 04:33:09AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > > We should not try to use the VF MAC address as that is used by the
> > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > > > generated MAC address.
> > > > > > > 
> > > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > 
> > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > with and without vdpa.
> > > > > 
> > > > > Using a VF you can create quite a few resources, e.g. send queues
> > > > > recieve queues, virtio_net queues etc. So you can possibly create
> > > > > several instances of vdpa net devices and nic net devices.
> > > > > 
> > > > > > Could you include a bit more description on the failure
> > > > > > mode?
> > > > > 
> > > > > Well, using the MAC address of the nic vport is wrong since that is the
> > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > 
> > > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > > > 
> > > 
> > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > 
> > > > > > Is switching to a random mac for such an unusual
> > > > > > configuration really justified?
> > > > > 
> > > > > Since I can't use the NIC's MAC address, I have two options:
> > > > > 1. To get the MAC address as was chosen by the user administering the
> > > > >    NIC. This should invoke the set_config callback. Unfortunately this
> > > > >    is not implemented yet.
> > > > > 
> > > > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > > > >    can always override this random configuration.
> > > > > 
> > > > > > It looks like changing a MAC could break some guests,
> > > > > > can it not?
> > > > > >
> > > > > 
> > > > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > > > from steering point of view. I will post them here once other patches on
> > > > > which they depend will be merged.
> > > > > 
> > > > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > > > 
> > > > Could you be more explicit on the following points:
> > > > - which configuration is broken ATM (as in, two device have identical
> > > >   macs? any other issues)?
> > > 
> > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> > > It's not breaking anything yet is wrong. The random MAC address setting
> > > is required for the steering patches.
> > 
> > Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> > dependency of a new feature.
> > 
> 
> OK, let's leave it for now. I will push along with the steering patches.
> The meaning is the the VDPA net device instance is create with a MAC of
> all zeros which also mean the link is down. You can set a MAC which will
> let the link come up.
> The vdpa driver will not get a callback as I
> stated but since current mode of steering directs all traffic to the
> vdpa instance it will work. In the future this must be fixed.

So at the moment the MAC is in the config space and that is read during
probe.  So I guess userspace will do that before passing device to
guest.

> 
> > > > - why won't device MAC change from guest point of view?
> > > > 
> > > 
> > > It's lack of implementation in qemu as far as I know.
> > 
> > Sorry not sure I understand. What's not implemented in QEMU?
> > 
> 
> vdpa config operation set_config() should be called whenever the MAC is
> changed, e.g. when administrator of the vdpa net device changes the mac.
> This does not happen which is a bug.

I am not sure that's a good interface for that, I think set_config
is for guest writes into config space.
Will let Jason comment once patches are posted.

> > > > 
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > > > > > >  	if (err)
> > > > > > >  		goto err_mtu;
> > > > > > >  
> > > > > > > -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > > > -	if (err)
> > > > > > > -		goto err_mtu;
> > > > > > > -
> > > > > > > +	eth_random_addr(config->mac);
> > > > > > >  	mvdev->vdev.dma_dev = mdev->device;
> > > > > > >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > >  	if (err)
> > > > > > > -- 
> > > > > > > 2.26.2
> > > > > > 
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
