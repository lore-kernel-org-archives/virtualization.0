Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427A5C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 23:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5E83417CA;
	Thu, 24 Feb 2022 23:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ezbv10izRYKX; Thu, 24 Feb 2022 23:52:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3D32A417C8;
	Thu, 24 Feb 2022 23:52:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 187ABC0021;
	Thu, 24 Feb 2022 23:52:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69467C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 23:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 548B14016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 23:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-tDq-_aZkTm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 23:52:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAA6F4010C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 23:52:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4D79BB828B7;
 Thu, 24 Feb 2022 23:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD98FC340E9;
 Thu, 24 Feb 2022 23:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645746728;
 bh=zVAGv3GzIY0CmGHccO6MTpPuZ0cGji1luXzfksNlM2M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=kCSNhdmjCNFp4p3nEZo05DvtkYaTYatl89i6A6bnh2GoE1LafejZW2+LdT+xyn9p9
 vFysfr3uU3CN1goYGDWRGNKLLknLWL4gwXq4LwSu/xs2AfSKORCBht3dm2YESZuJkC
 QTihOOdWAM03oTBu5HCC9wQYShduFbcLphU9XZZOZ2w+HR8xeoLGBBRX0Da60zkFuO
 Gw55uOtn72xOyN5dsOgPR66lVXrDqagidhgfw1lK88dhzevhVz/lXIRWDLrY+G2rDT
 B2vC1ShfZifdcQml58IDHz2aBNdppV0ayqFTRcbx14EaEZyzuuUqWcpsrE30jKvDVw
 +pVWnNSGt5bFQ==
Date: Thu, 24 Feb 2022 17:52:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 05/11] pci: use helper for safer setting of
 driver_override
Message-ID: <20220224235206.GA302751@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f7347531-8aa4-c011-d405-dea93e29779f@canonical.com>
Cc: linux-hyperv@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Fabio Estevam <festevam@gmail.com>,
 linux-clk@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Abel Vesa <abel.vesa@nxp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andy Gross <agross@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-arm-msm@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Sven Schnelle <svens@linux.ibm.com>, Shawn Guo <shawnguo@kernel.org>
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

On Thu, Feb 24, 2022 at 08:49:15AM +0100, Krzysztof Kozlowski wrote:
> On 23/02/2022 22:51, Bjorn Helgaas wrote:
> > In subject, to match drivers/pci/ convention, do something like:
> > 
> >   PCI: Use driver_set_override() instead of open-coding
> > 
> > On Wed, Feb 23, 2022 at 08:13:04PM +0100, Krzysztof Kozlowski wrote:
> >> Use a helper for seting driver_override to reduce amount of duplicated
> >> code.
> >> @@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
> >>  				     const char *buf, size_t count)
> >>  {
> >>  	struct pci_dev *pdev = to_pci_dev(dev);
> >> -	char *driver_override, *old, *cp;
> >> +	int ret;
> >>  
> >>  	/* We need to keep extra room for a newline */
> >>  	if (count >= (PAGE_SIZE - 1))
> >>  		return -EINVAL;
> > 
> > This check makes no sense in the new function.  Michael alluded to
> > this as well.
> 
> I am not sure if I got your comment properly. You mean here:
> 1. Move this check to driver_set_override()?
> 2. Remove the check entirely?

I was mistaken about the purpose of the comment and the check.  I
thought it had to do with *this* function, and this function doesn't
add a newline, and there's no obvious connection with PAGE_SIZE.

But looking closer, I think the "extra room for a newline" is really
to make sure that *driver_override_show()* can add a newline and have
it still fit within the PAGE_SIZE sysfs limit.

Most driver_override_*() functions have the same comment, so maybe
this was obvious to everybody except me :)  I do see that spi.c adds
"when displaying value" at the end, which helps a lot.

Sorry for the wild goose chase.

> >> -	driver_override = kstrndup(buf, count, GFP_KERNEL);
> >> -	if (!driver_override)
> >> -		return -ENOMEM;
> >> -
> >> -	cp = strchr(driver_override, '\n');
> >> -	if (cp)
> >> -		*cp = '\0';
> >> -
> >> -	device_lock(dev);
> >> -	old = pdev->driver_override;
> >> -	if (strlen(driver_override)) {
> >> -		pdev->driver_override = driver_override;
> >> -	} else {
> >> -		kfree(driver_override);
> >> -		pdev->driver_override = NULL;
> >> -	}
> >> -	device_unlock(dev);
> >> -
> >> -	kfree(old);
> >> +	ret = driver_set_override(dev, &pdev->driver_override, buf);
> >> +	if (ret)
> >> +		return ret;
> >>  
> >>  	return count;
> >>  }
> >> -- 
> >> 2.32.0
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
