Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF42C55178
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 07:32:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157B02222A
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 07:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v7jixjnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157B02222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 258D021519;
	Thu,  5 Nov 2020 07:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6HULFkL2RYcY; Thu,  5 Nov 2020 07:32:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0E2A420373;
	Thu,  5 Nov 2020 07:32:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4806C0893;
	Thu,  5 Nov 2020 07:32:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0E9DC0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9570020767
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SZAWwazT+zCc
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:32:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id E3D0020373
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:32:14 +0000 (UTC)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 930A420936;
 Thu,  5 Nov 2020 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604561534;
 bh=95POjnfgmnBfa+PcIUbO71yIixyEwcBCZu8ONi41qSI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=v7jixjnRS8IofHWpcD2+DxxCXJ90U/evKE0DUQul2JT/Y8H+g7nVaRbkifKy48xox
 VDGBlpUHfWervGmkwxAM0ACUtpdpFRRs9k0EqAwpLdfoM3L9+GBIUBILJMUGPAe8zd
 NU6sc18Y6rTq9FYLuezM9oiY3jBE5sPskCQybDUw=
Date: Thu, 5 Nov 2020 08:33:02 +0100
From: gregkh <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH mlx5-next v1 06/11] vdpa/mlx5: Connect mlx5_vdpa to
 auxiliary bus
Message-ID: <20201105073302.GA3415673@kroah.com>
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-7-leon@kernel.org>
 <20201103154525.GO36674@ziepe.ca>
 <CAPcyv4jP9nFAGdvB7agg3x7Y7moHGcxLd5=f5=5CXnJRUf3n9w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jP9nFAGdvB7agg3x7Y7moHGcxLd5=f5=5CXnJRUf3n9w@mail.gmail.com>
Cc: alsa-devel@alsa-project.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Takashi Iwai <tiwai@suse.de>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Patil,
 Kiran" <kiran.patil@intel.com>, Mark Brown <broonie@kernel.org>,
 Parav Pandit <parav@nvidia.com>, David M Ertman <david.m.ertman@intel.com>,
 Roi Dayan <roid@nvidia.com>, virtualization@lists.linux-foundation.org,
 "Saleem, Shiraz" <shiraz.saleem@intel.com>, Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S . Miller" <davem@davemloft.net>
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

On Wed, Nov 04, 2020 at 03:21:23PM -0800, Dan Williams wrote:
> On Tue, Nov 3, 2020 at 7:45 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> [..]
> > > +MODULE_DEVICE_TABLE(auxiliary, mlx5v_id_table);
> > > +
> > > +static struct auxiliary_driver mlx5v_driver = {
> > > +     .name = "vnet",
> > > +     .probe = mlx5v_probe,
> > > +     .remove = mlx5v_remove,
> > > +     .id_table = mlx5v_id_table,
> > > +};
> >
> > It is hard to see from the diff, but when this patch is applied the
> > vdpa module looks like I imagined things would look with the auxiliary
> > bus. It is very similar in structure to a PCI driver with the probe()
> > function cleanly registering with its subsystem. This is what I'd like
> > to see from the new Intel RDMA driver.
> >
> > Greg, I think this patch is the best clean usage example.
> >
> > I've looked over this series and it has the right idea and
> > parts. There is definitely more that can be done to improve mlx5 in
> > this area, but this series is well scoped and cleans a good part of
> > it.
> 
> Greg?
> 
> I know you alluded to going your own way if the auxiliary bus patches
> did not shape up soon, but it seems they have and the stakeholders
> have reached this consensus point.
> 
> Were there any additional changes you wanted to see happen? I'll go
> give the final set another once over, but David has been diligently
> fixing up all the declared major issues so I expect to find at most
> minor incremental fixups.

This is in my to-review pile, along with a load of other stuff at the
moment:
	$ ~/bin/mdfrm -c ~/mail/todo/
	1709 messages in /home/gregkh/mail/todo/

So give me a chance.  There is no rush on my side for this given the
huge delays that have happened here on the authorship side many times in
the past :)

If you can review it, or anyone else, that is always most appreciated.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
