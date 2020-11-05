Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174DBC4741F
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 16:56:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E7B206DC
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0zlCIJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E7B206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2E628666F;
	Thu,  5 Nov 2020 16:56:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dy6bZ5yhScxi; Thu,  5 Nov 2020 16:56:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF7CE86665;
	Thu,  5 Nov 2020 16:56:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFD17C0893;
	Thu,  5 Nov 2020 16:56:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E4A8C0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 16:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 95B838666C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 16:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sqwSddECOdyB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 16:56:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0CEB486665
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 16:56:16 +0000 (UTC)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A773C2073A;
 Thu,  5 Nov 2020 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604595375;
 bh=rveaLrZ2VekMaBIfhcAvnGUg2fcFO3veOvwCKc6KlV8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p0zlCIJSZLU+hIGO/1OT9CsKyGQRT9xRqtuEOEJYahXBjO2R63qCOEBzaoC2jvC/W
 b3CyZRYfIxq8nHLYW+R8WfeBMZfDYBVEuMJK7rNNLj7g5UvHMQPmTC8sRuIQAKq6bJ
 KIIuiYd6H/ssEmRFS4YipJuNXx5/cC0UxgvuXAYQ=
Date: Thu, 5 Nov 2020 17:57:01 +0100
From: gregkh <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH mlx5-next v1 06/11] vdpa/mlx5: Connect mlx5_vdpa to
 auxiliary bus
Message-ID: <20201105165701.GA1243785@kroah.com>
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-7-leon@kernel.org>
 <20201103154525.GO36674@ziepe.ca>
 <CAPcyv4jP9nFAGdvB7agg3x7Y7moHGcxLd5=f5=5CXnJRUf3n9w@mail.gmail.com>
 <20201105073302.GA3415673@kroah.com>
 <20201105164738.GD36674@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105164738.GD36674@ziepe.ca>
Cc: alsa-devel@alsa-project.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Takashi Iwai <tiwai@suse.de>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, Doug Ledford <dledford@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "Patil, Kiran" <kiran.patil@intel.com>,
 Mark Brown <broonie@kernel.org>, Parav Pandit <parav@nvidia.com>,
 David M Ertman <david.m.ertman@intel.com>, Roi Dayan <roid@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, "Saleem,
 Shiraz" <shiraz.saleem@intel.com>, Netdev <netdev@vger.kernel.org>,
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

On Thu, Nov 05, 2020 at 12:47:38PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 08:33:02AM +0100, gregkh wrote:
> > > Were there any additional changes you wanted to see happen? I'll go
> > > give the final set another once over, but David has been diligently
> > > fixing up all the declared major issues so I expect to find at most
> > > minor incremental fixups.
> > 
> > This is in my to-review pile, along with a load of other stuff at the
> > moment:
> > 	$ ~/bin/mdfrm -c ~/mail/todo/
> > 	1709 messages in /home/gregkh/mail/todo/
> > 
> > So give me a chance.  There is no rush on my side for this given the
> > huge delays that have happened here on the authorship side many times in
> > the past :)
> 
> On the other hand Leon and his team did invest alot of time and
> effort, very quickly, to build and QA this large mlx5 series here to
> give a better/second example as you requested only a few weeks ago.

Leon and his team have done a great job, and I never said otherwise.

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
