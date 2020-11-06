Return-Path: <SRS0=3a2n=EM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A2C2D0A3
	for <virtualization@archiver.kernel.org>; Fri,  6 Nov 2020 06:56:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF990206F4
	for <virtualization@archiver.kernel.org>; Fri,  6 Nov 2020 06:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuiVH9hQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF990206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D04286788;
	Fri,  6 Nov 2020 06:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fS20-reaUPEe; Fri,  6 Nov 2020 06:56:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3B67D8666C;
	Fri,  6 Nov 2020 06:56:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19D5FC0893;
	Fri,  6 Nov 2020 06:56:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7B5DC0889
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 06:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BC2172E0D9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 06:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uy5ZxKffn3JK
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 06:56:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id D69EA2E0D8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 06:56:33 +0000 (UTC)
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 83A17206F4;
 Fri,  6 Nov 2020 06:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604645793;
 bh=yRhE6XR0cLSyZZkXEIf4EKqkW1OuHyv4bdZKoioXVrw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kuiVH9hQopx87bfdsAx2gbKmFgqYBDw23j1qfXnRfX10trVIjqzi1XQuIsXTGLE9G
 1DTngfIQUa/4q9EbToBgKnayZOqY86jTsC5P77eqHjqujTvlcdN+c69Yid3YbD3VC5
 tWou/zcOf1hZwMT8Gp8NSxGCgRn/4TGKZrD2daKc=
Date: Fri, 6 Nov 2020 08:56:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH mlx5-next v1 05/11] net/mlx5: Register mlx5 devices to
 auxiliary virtual bus
Message-ID: <20201106065629.GD5475@unreal>
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-6-leon@kernel.org>
 <d10e7a08200458c1bddb72fc983a5917daebc8f1.camel@kernel.org>
 <20201105210948.GS2620339@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105210948.GS2620339@nvidia.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kiran.patil@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-rdma@vger.kernel.org, gregkh <gregkh@linuxfoundation.org>,
 ranjani.sridharan@linux.intel.com, Roi Dayan <roid@nvidia.com>,
 virtualization@lists.linux-foundation.org, fred.oh@linux.intel.com,
 tiwai@suse.de, Doug Ledford <dledford@redhat.com>, broonie@kernel.org,
 Parav Pandit <parav@nvidia.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, dan.j.williams@intel.com,
 shiraz.saleem@intel.com, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
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

On Thu, Nov 05, 2020 at 05:09:48PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 12:59:20PM -0800, Saeed Mahameed wrote:
>
> > 2. you can always load a driver without its underlying device existed.
> > for example, you can load a pci device driver/module and it will load
> > and wait for pci devices to pop up, the subsysetem infrastructure will
> > match between drivers and devices and probe them.
>
> Yes, this works fine with this design
>
> > struct aux_driver mlx5_vpda_aux_driver {
> >
> >       .name = "vdpa",
> >        /* match this driver with mlx5_core devices */
> >       .id_table = {"mlx5_core"},
> >       .ops {
> >             /* called before probe on actual aux mlx5_core device */
> >            .is_supported(struct aux_device);
>
> This means module auto loading is impossible, we can't tell to load
> the module until we load the module to call the is_supported code ..

Right, and if we can, it will be violation of everything we know in
driver model, because the call "is_supported" will need to be called
for every registered driver without any relation to existed devices.

And mlx5_rescan_drivers() came as a need to overcome LAG and eswitch
craziness in everything related to their reprobe flows. Once they will
be changed to work like normal drivers, we will be able to simplify it.

So let's talk offline to see how can we improve mlx5_core even more
after this series is merged.

Thanks

>
> Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
