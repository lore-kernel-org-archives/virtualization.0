Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE44C4741F
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 07:49:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3846121D46
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 07:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sDW2kw2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3846121D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BAD4B87051;
	Thu,  5 Nov 2020 07:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3TAEmIH9VDOX; Thu,  5 Nov 2020 07:49:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 49F168704C;
	Thu,  5 Nov 2020 07:49:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40479C088B;
	Thu,  5 Nov 2020 07:49:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83194C0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7180987051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:49:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NG3lEK7hRaDY
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:49:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 99EC48704C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:49:24 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id k3so1199191ejj.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Nov 2020 23:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HiHN7cEc9FvAFXuwqXLWF0XbMGI5NJnlheI3AC/p0Rk=;
 b=sDW2kw2WIZtOBBqP3OLvBf0PZR4l//kVfPnpgjZLMq0vnE4tjG4Ig8z5tff+gOMOP0
 snGDBlsMM8PeDWRiOvFXKxwsoy/1Xtb6Xcc7mo4BQMPh/IrM38WXigtT7wQwr6ggUOjR
 dnfFwV5wvxh5jl5IGJroHGHpfEDC4ES+wgWgBUaJCOqtZ8QG5P0CUCQzNp78U2eeV7O5
 yCCmjn+yqQ4xcVOlwAcacEw2ny9JMCkuwMdXa4VYdR8fSYj/JM2Oeviqgge95DNvbHBt
 rfnzbtVc3h3BTVvE+MV5I+onfG+QEpeqBoYtXw43J1bzbdBKp+zHOxdL3J2AqKAJxUFO
 MhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HiHN7cEc9FvAFXuwqXLWF0XbMGI5NJnlheI3AC/p0Rk=;
 b=mzJhyqRHrC2aRHC7poVJSRsDJ+nEhuRGgzkhzrnR/SBXLqU2Eb6Y+B48yih0h9k2y3
 s4veRJC2289Wu7itLPtaJow3sPLGtmu8YL/4Cdt9BxsYVOpBkIXvKSGgHtKVnVuN8s/6
 IXR2Kqv4rr/hzVgIfwzackv3l+X7Imm9++9ZQThOhohORk8uat+GfCzPznG7XzDs2Rjf
 hGjW4BrySnVEwkyBVyKrI5JYJhTarU5UUrasOMWEEG8KH/+vMDcrXC4FTuJ6nTGmlPSR
 9LIZkcObQcBIhVZAj1RQbW0Yfx5CfR+OPMdqX0KuTXDUw5NKOoGbxci6R7G9GLR2UITB
 4d5g==
X-Gm-Message-State: AOAM530uwbLW6qv5+IFfm4KO33c3EfXnkOS6ZEZwTXBQRUD67FqR9FVM
 zLslt+0rBs0kEWjprMDtDlJGims1Temw92IHOmfekw==
X-Google-Smtp-Source: ABdhPJzMyeNcHa42GSktT9mkjMahMnmlITf9LkRgdVukR/ujD9xIfq3TSrJb0lT83dAIiwc3ssEcu4HrZhS0QU6AnNw=
X-Received: by 2002:a17:906:4306:: with SMTP id
 j6mr1091381ejm.523.1604562563054; 
 Wed, 04 Nov 2020 23:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-7-leon@kernel.org>
 <20201103154525.GO36674@ziepe.ca>
 <CAPcyv4jP9nFAGdvB7agg3x7Y7moHGcxLd5=f5=5CXnJRUf3n9w@mail.gmail.com>
 <20201105073302.GA3415673@kroah.com>
In-Reply-To: <20201105073302.GA3415673@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Nov 2020 23:49:11 -0800
Message-ID: <CAPcyv4iJZNsf9fnx2BkyCG9ECm85mFshaoxaZ3=kzMz-2-hCQQ@mail.gmail.com>
Subject: Re: [PATCH mlx5-next v1 06/11] vdpa/mlx5: Connect mlx5_vdpa to
 auxiliary bus
To: gregkh <gregkh@linuxfoundation.org>
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

On Wed, Nov 4, 2020 at 11:32 PM gregkh <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 04, 2020 at 03:21:23PM -0800, Dan Williams wrote:
> > On Tue, Nov 3, 2020 at 7:45 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > [..]
> > > > +MODULE_DEVICE_TABLE(auxiliary, mlx5v_id_table);
> > > > +
> > > > +static struct auxiliary_driver mlx5v_driver = {
> > > > +     .name = "vnet",
> > > > +     .probe = mlx5v_probe,
> > > > +     .remove = mlx5v_remove,
> > > > +     .id_table = mlx5v_id_table,
> > > > +};
> > >
> > > It is hard to see from the diff, but when this patch is applied the
> > > vdpa module looks like I imagined things would look with the auxiliary
> > > bus. It is very similar in structure to a PCI driver with the probe()
> > > function cleanly registering with its subsystem. This is what I'd like
> > > to see from the new Intel RDMA driver.
> > >
> > > Greg, I think this patch is the best clean usage example.
> > >
> > > I've looked over this series and it has the right idea and
> > > parts. There is definitely more that can be done to improve mlx5 in
> > > this area, but this series is well scoped and cleans a good part of
> > > it.
> >
> > Greg?
> >
> > I know you alluded to going your own way if the auxiliary bus patches
> > did not shape up soon, but it seems they have and the stakeholders
> > have reached this consensus point.
> >
> > Were there any additional changes you wanted to see happen? I'll go
> > give the final set another once over, but David has been diligently
> > fixing up all the declared major issues so I expect to find at most
> > minor incremental fixups.
>
> This is in my to-review pile, along with a load of other stuff at the
> moment:
>         $ ~/bin/mdfrm -c ~/mail/todo/
>         1709 messages in /home/gregkh/mail/todo/
>
> So give me a chance.  There is no rush on my side for this given the
> huge delays that have happened here on the authorship side many times in
> the past :)

Sure, I was more looking to confirm that it's worth continuing to
polish this set given your mention of possibly going a different
direction.

> If you can review it, or anyone else, that is always most appreciated.

Thanks, will do.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
