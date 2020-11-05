Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08FBC55179
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 16:47:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131392080D
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T/9h4B64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131392080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 872A985725;
	Thu,  5 Nov 2020 16:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tm18RM8qBXhq; Thu,  5 Nov 2020 16:47:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F1A6984E8C;
	Thu,  5 Nov 2020 16:47:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2531C0893;
	Thu,  5 Nov 2020 16:47:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5134C0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 16:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9A98F84FA5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 16:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TgTlr6QVHCIf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 16:47:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CEF3F84E8C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 16:47:40 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id l2so1782391qkf.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Nov 2020 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zhqw6nXW7an1sciymnqR0tpduOyD+zat59s5GBmVtbM=;
 b=T/9h4B64oiALMfc42uebDeGSEyGeD0JwaqBLLTEWSdW7X4iF0nNQTGD8ItXWOPi1xM
 DOvW9K/135GnWww5roe4BdwNCigRiUCwRDf4zxYgylBvKtGQ0y4XU2iCE2XUZ07ICn3L
 rTXg0XPkpw/UUFWbC8Cig/5dZdORb0CzNbOAohUH2HvpxEPnNWIhHQhklANJ/hAkg8H3
 MKb/DtGr/YW1Na1efMq3URRzjr/gbNFdmBokrf0ljC1HCRvWFNeTvkJMTB7Vdi6j+NUo
 8K7nKdD6xanzOWR6UK32MPYw28AHa+zQYvDZXAfI7cRkoGcIsjwKs0OHgVNNYy/123gh
 Xm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zhqw6nXW7an1sciymnqR0tpduOyD+zat59s5GBmVtbM=;
 b=h1Xl0E2ZpWADFCNELYRxwBZAqWIKUpMGz+q1TinoJ84JBtamVV/LDiD3bKYpcKGJR4
 xAoLAGhUzq/Hj+30O/2tle2YZh1vbeplkVkNpHnm9eyRZ+KdorGav1wNhNPz7NJmqURN
 0mWiMc3J1RWspkx3iVVlkI2NNa4NQk2vidK0KsLAYUukJCayvDn1NpMc+LRqey1J0E8h
 AbxzFrFQw5xg4BiaIyVLuxWAsMYs/XD+OmcQkSORNjqfeeS5LYCqGPZVBZVp4aF26QJk
 RNEEIVJ/BNrCdp2njKYLeNTtQVJJfIHvM4wNdyOeeKbj2fPI799Kj7m/+1T7thlcsjLt
 aDeg==
X-Gm-Message-State: AOAM533MzAsWDf9AvIbk7pt/e9r1knMLqLUk710GU+rhgoENphebYagg
 jJ81TkNK67CeXLG+RUv1Dp2dpA==
X-Google-Smtp-Source: ABdhPJwzljYxFoBvKq1VFYeruz7gb+7H6oGN3WPy1j1HdsQNZAjc4YfzOlkNglv0PQR1cXTjqGzkUA==
X-Received: by 2002:a05:620a:697:: with SMTP id
 f23mr2825760qkh.374.1604594859867; 
 Thu, 05 Nov 2020 08:47:39 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id g20sm1208553qtq.51.2020.11.05.08.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 08:47:39 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kaiQE-0007e8-Gm; Thu, 05 Nov 2020 12:47:38 -0400
Date: Thu, 5 Nov 2020 12:47:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: gregkh <gregkh@linuxfoundation.org>
Subject: Re: [PATCH mlx5-next v1 06/11] vdpa/mlx5: Connect mlx5_vdpa to
 auxiliary bus
Message-ID: <20201105164738.GD36674@ziepe.ca>
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-7-leon@kernel.org>
 <20201103154525.GO36674@ziepe.ca>
 <CAPcyv4jP9nFAGdvB7agg3x7Y7moHGcxLd5=f5=5CXnJRUf3n9w@mail.gmail.com>
 <20201105073302.GA3415673@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105073302.GA3415673@kroah.com>
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

On Thu, Nov 05, 2020 at 08:33:02AM +0100, gregkh wrote:
> > Were there any additional changes you wanted to see happen? I'll go
> > give the final set another once over, but David has been diligently
> > fixing up all the declared major issues so I expect to find at most
> > minor incremental fixups.
> 
> This is in my to-review pile, along with a load of other stuff at the
> moment:
> 	$ ~/bin/mdfrm -c ~/mail/todo/
> 	1709 messages in /home/gregkh/mail/todo/
> 
> So give me a chance.  There is no rush on my side for this given the
> huge delays that have happened here on the authorship side many times in
> the past :)

On the other hand Leon and his team did invest alot of time and
effort, very quickly, to build and QA this large mlx5 series here to
give a better/second example as you requested only a few weeks ago.

> If you can review it, or anyone else, that is always most appreciated.

Dan, Leon, Myself and others have looked at the auxiliary bus patch a
more than a few times now. Leon in particular went over it very
carefully and a number of bugs were fixed while he developed this
series.

There seems to be nothing fundamentally wrong with it, so long as
people are fine with the colour of the shed...

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
