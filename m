Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A89C433F5
	for <virtualization@archiver.kernel.org>; Fri, 25 Feb 2022 17:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8947828F2;
	Fri, 25 Feb 2022 17:13:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0S9_Dgq7otKZ; Fri, 25 Feb 2022 17:13:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8622A82628;
	Fri, 25 Feb 2022 17:13:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A032BC007F;
	Fri, 25 Feb 2022 17:13:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9326C001A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 17:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95E6D401F7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 17:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dQQAl5h30nnc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 17:13:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 149E3401B1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 17:13:43 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4B11261D72;
 Fri, 25 Feb 2022 17:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E452C340E7;
 Fri, 25 Feb 2022 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645809222;
 bh=4sE4Gtevnk8/TCjMANbcRjCHG8DgJ5S+RZAsg3tQewo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=aKNMEZYO9GYS47EsbtSGoBp7jQ6cq+PB2zbte+AwwqqiqpcVRMxGDM0F0Afex5ZJW
 4rYESli2esu86LIUX6eb+GIiQqKG0aJoZCwpzqlHuXkixzO/1AezAk2443Z9c992ps
 XywAbCY1/AWyw1jhDZ3bHZQXnfC+/H1QPWErc949Yi5ixSLpl4/cO2POfTAAfrxKho
 CAVXpDY7lijl79zw4wxpFlP592n7RcY/q2RQ45t4e4X5U4/DfLgdvmThUjLUu/hMNF
 a6Vl3pNKPQMeAYVdX3MJ7TCbUyat1DVH9TvH+imzTBTV3gNbtHMVmiV6Fa05o9r3/n
 oKdbLx9yzFJlA==
Date: Fri, 25 Feb 2022 11:13:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 05/11] pci: use helper for safer setting of
 driver_override
Message-ID: <20220225171341.GA364850@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0aff95ff-5b79-8ae9-48fd-720a9f27cbce@canonical.com>
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

On Fri, Feb 25, 2022 at 10:36:20AM +0100, Krzysztof Kozlowski wrote:
> On 25/02/2022 00:52, Bjorn Helgaas wrote:
> > On Thu, Feb 24, 2022 at 08:49:15AM +0100, Krzysztof Kozlowski wrote:
> >> On 23/02/2022 22:51, Bjorn Helgaas wrote:
> >>> In subject, to match drivers/pci/ convention, do something like:
> >>>
> >>>   PCI: Use driver_set_override() instead of open-coding
> >>>
> >>> On Wed, Feb 23, 2022 at 08:13:04PM +0100, Krzysztof Kozlowski wrote:
> >>>> Use a helper for seting driver_override to reduce amount of duplicated
> >>>> code.
> >>>> @@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
> >>>>  				     const char *buf, size_t count)
> >>>>  {
> >>>>  	struct pci_dev *pdev = to_pci_dev(dev);
> >>>> -	char *driver_override, *old, *cp;
> >>>> +	int ret;
> >>>>  
> >>>>  	/* We need to keep extra room for a newline */
> >>>>  	if (count >= (PAGE_SIZE - 1))
> >>>>  		return -EINVAL;
> >>>
> >>> This check makes no sense in the new function.  Michael alluded to
> >>> this as well.
> >>
> >> I am not sure if I got your comment properly. You mean here:
> >> 1. Move this check to driver_set_override()?
> >> 2. Remove the check entirely?
> > 
> > I was mistaken about the purpose of the comment and the check.  I
> > thought it had to do with *this* function, and this function doesn't
> > add a newline, and there's no obvious connection with PAGE_SIZE.
> > 
> > But looking closer, I think the "extra room for a newline" is really
> > to make sure that *driver_override_show()* can add a newline and have
> > it still fit within the PAGE_SIZE sysfs limit.
> > 
> > Most driver_override_*() functions have the same comment, so maybe
> > this was obvious to everybody except me :)  I do see that spi.c adds
> > "when displaying value" at the end, which helps a lot.
> > 
> > Sorry for the wild goose chase.
> 
> I think I will move this check anyway to driver_set_override() helper,
> because there is no particular benefit to have duplicated all over. The
> helper will receive "count" argument so can perform all checks.

Thanks, I think that would be good!

Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
