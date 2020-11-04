Return-Path: <SRS0=FRCo=EK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60FDC388F7
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 23:21:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624D9206F9
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 23:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nbBwJZMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624D9206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F07D485C9A;
	Wed,  4 Nov 2020 23:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPw5rgzCMXMq; Wed,  4 Nov 2020 23:21:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 68EE485CB4;
	Wed,  4 Nov 2020 23:21:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48980C0889;
	Wed,  4 Nov 2020 23:21:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A90A4C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 23:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 77E56203A4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 23:21:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qb13lQCfrVjY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 23:21:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 3DFAD2014B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 23:21:36 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id k3so249903ejj.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Nov 2020 15:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IkxbaeAsRvfPNMaiW0gFtiCQOBmoS4GNd3nY4Wwz8Hk=;
 b=nbBwJZMY+xrKg6w6NoyyZ8wH6PRrpWDJMwjQmqe2WQUKuJO5hUA4CVT37Q2bT3zk6M
 XXGYTpqF1YDiy5XaStqn2/wwlKmEE4KiWnngd9Hg4pwEnL3nDkVgzYAWjotLvVSgC8RI
 OHRURM5VZ+ERQIF6Zw6htdalcHKNqqZ5XS6xWz/S3YRSMU2iC+YP3iut1T2hy68jS+YE
 L1nTzHri580AMi64MfXaRmO1YeFLTfHm4V1xZh5k6V5MQdopCu5nARpraa1dfQ7trQzf
 +6RvDh4gvwQHvyG3b9jdZ9wWt+STGKccdgYSKelxfhKJOayGBw+tSbjtTiFw+2KIRg8M
 qiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IkxbaeAsRvfPNMaiW0gFtiCQOBmoS4GNd3nY4Wwz8Hk=;
 b=J34nl2gCzTVC8LxZjwxhRTfkYJiQlRnM/UTQ896PWSTMWCzCiGezB4WKeHd7JAlp2L
 PzWdnx8NicOL/N9civfpHuym/raF+Xegu2w/mJcOOW1zyZgB3wVMnbnVEXh+vu6BadnX
 pjo8gcreFKmrWe0lYiBSl/91wEiYb7i9M8swhZJx7BfyZbbFHUHaqfRzEPiQ5BePxi7o
 Po2gwEXwfGrPrQzbkkebgDl1rULZRtXDwotcLophXIgmCRNDRbuYqJv66E2wvktPt63r
 EtdKP1AuwgCJJqz+ZwhfuQ+s/QII6ylAIHese68UMapXvYDFgYp5vFrgTxwrDPUr2QSF
 h6oA==
X-Gm-Message-State: AOAM530sEc2aAIWRXWqENY6Cm3R00TbKCdwO4ELPSevZnF/hnbLKSjJ0
 m687Sipx+Kuv0ija2ub8YgCy9KVuJG707XaeNHqhWw==
X-Google-Smtp-Source: ABdhPJxvb/hNG9Gu9hrl82xWn1tmJIgoueWGEVMCGBlWcYM3JxH/JkmRoeh47/b7BtcC3eHP9KumYl6m1HGAoVQj2Mk=
X-Received: by 2002:a17:906:d92c:: with SMTP id
 rn12mr427071ejb.472.1604532094560; 
 Wed, 04 Nov 2020 15:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-7-leon@kernel.org>
 <20201103154525.GO36674@ziepe.ca>
In-Reply-To: <20201103154525.GO36674@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Nov 2020 15:21:23 -0800
Message-ID: <CAPcyv4jP9nFAGdvB7agg3x7Y7moHGcxLd5=f5=5CXnJRUf3n9w@mail.gmail.com>
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

On Tue, Nov 3, 2020 at 7:45 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
[..]
> > +MODULE_DEVICE_TABLE(auxiliary, mlx5v_id_table);
> > +
> > +static struct auxiliary_driver mlx5v_driver = {
> > +     .name = "vnet",
> > +     .probe = mlx5v_probe,
> > +     .remove = mlx5v_remove,
> > +     .id_table = mlx5v_id_table,
> > +};
>
> It is hard to see from the diff, but when this patch is applied the
> vdpa module looks like I imagined things would look with the auxiliary
> bus. It is very similar in structure to a PCI driver with the probe()
> function cleanly registering with its subsystem. This is what I'd like
> to see from the new Intel RDMA driver.
>
> Greg, I think this patch is the best clean usage example.
>
> I've looked over this series and it has the right idea and
> parts. There is definitely more that can be done to improve mlx5 in
> this area, but this series is well scoped and cleans a good part of
> it.

Greg?

I know you alluded to going your own way if the auxiliary bus patches
did not shape up soon, but it seems they have and the stakeholders
have reached this consensus point.

Were there any additional changes you wanted to see happen? I'll go
give the final set another once over, but David has been diligently
fixing up all the declared major issues so I expect to find at most
minor incremental fixups.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
