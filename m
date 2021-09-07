Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05641C433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 23:04:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9401A60E52
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 23:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9401A60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5657D402B9;
	Tue,  7 Sep 2021 23:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ufHn3Gfo-Jmk; Tue,  7 Sep 2021 23:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C191B40104;
	Tue,  7 Sep 2021 23:04:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCC3C0011;
	Tue,  7 Sep 2021 23:04:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BC77C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 23:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1D7640410
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 23:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZvwhm2TVGfq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 23:04:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F06440401
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 23:04:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 365DD61102;
 Tue,  7 Sep 2021 23:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631055873;
 bh=U4r90XGeMFMBTYQzJqJqJ72n/aEzus0q4Z98AOX2grc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sKXNN3dc3jccHx69/sKD47gbQLIRPr5FvdMGBsnJ/eUfbMNTLqUqNfWSvns+I69ck
 U25GKT7tGRJbAWVj0zvnCcxOB6w4HzBT1Fe6R/PlLWnsRJcpQuvxrlr71Ab0Gl0r/g
 yCUbkzUr9DQXvBlG7STLjsnFeql70rUCYRhVNXo5P9Gd5NRMXopOXF68LZg0JtLbDj
 NWDsTld22BYYdo8O+Vk07IJEW02ZwlwcdChvtN2kzeHNXcIDL0mt9ZFToQ/iPeAFMS
 FGhfCRqW9/t3Jn7umP3x8hpJMQ+gNd+0TD6+cH0YIKQMIROMhf40SlprUdwNv8QkXz
 HpLc51HwA2u3Q==
Date: Wed, 8 Sep 2021 02:04:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: add num_request_queues module parameter
Message-ID: <YTfv/s8v0MsCya5r@unreal>
References: <20210902204622.54354-1-mgurtovoy@nvidia.com>
 <YTR12AHOGs1nhfz1@unreal>
 <b2e60035-2e63-3162-6222-d8c862526a28@gmail.com>
 <YTSZ6CYM6BCsbVmk@unreal>
 <20210905111415-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210905111415-mutt-send-email-mst@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-block@vger.kernel.org,
 kvm@vger.kernel.org, israelr@nvidia.com, nitzanc@nvidia.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 stefanha@redhat.com, oren@nvidia.com
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

On Sun, Sep 05, 2021 at 11:15:16AM -0400, Michael S. Tsirkin wrote:
> On Sun, Sep 05, 2021 at 01:20:24PM +0300, Leon Romanovsky wrote:
> > On Sun, Sep 05, 2021 at 01:49:46AM -0700, Chaitanya Kulkarni wrote:
> > > 
> > > On 9/5/2021 12:46 AM, Leon Romanovsky wrote:
> > > > > +static unsigned int num_request_queues;
> > > > > +module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> > > > > +		0644);
> > > > > +MODULE_PARM_DESC(num_request_queues,
> > > > > +		 "Number of request queues to use for blk device. Should > 0");
> > > > > +
> > > > Won't it limit all virtio block devices to the same limit?
> > > > 
> > > > It is very common to see multiple virtio-blk devices on the same system
> > > > and they probably need different limits.
> > > > 
> > > > Thanks
> > > 
> > > 
> > > Without looking into the code, that can be done adding a configfs
> > > 
> > > interface and overriding a global value (module param) when it is set from
> > > 
> > > configfs.
> > 
> > So why should we do double work instead of providing one working
> > interface from the beginning?
> > 
> > Thanks
> > 
> > > 
> > > 
> 
> The main way to do it is really from the hypervisor. This one
> is a pretty blunt instrument, Max here says it's useful to reduce
> memory usage of the driver. If that's the usecase then a global limit
> seems sufficient.

How memory will you reduce? It is worth to write it in the commit message.

Thanks

> 
> -- 
> MST
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
