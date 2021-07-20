Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE124C07E95
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 18:11:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666A661186
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 18:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666A661186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 248698317B;
	Tue, 20 Jul 2021 18:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sJdtqpJh1HeL; Tue, 20 Jul 2021 18:11:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D537D83189;
	Tue, 20 Jul 2021 18:11:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC399C0010;
	Tue, 20 Jul 2021 18:11:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36080C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 18:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15877403C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 18:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZ-vj7fM2NUc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 18:11:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A21B403B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 18:11:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A280F610F7;
 Tue, 20 Jul 2021 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1626804699;
 bh=rIvcPnlk8F/v3noffv3nLg5nIBn+iiWimm3NpnDG1fU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BsOmLpLNkcg+5IcUXmRopcIJAHJ0Na5eiECJ2oyRTOp02vXF+TtI2sRDdp0HaPjVZ
 6rXKYtkIgsSLenrRqiAzJGIxUrgUjxnr6I6dtAhfmuu4d1vAADufNxYBkf3MSvT7wo
 I14Ao87YvNyrjDlWba/lnHEaPyImDNA1zWwdnvBI=
Date: Tue, 20 Jul 2021 20:11:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Message-ID: <YPcR2BHqTEamU3dU@kroah.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
 <YPan14jucU9/u6JL@kroah.com>
 <0DE37084-185C-4144-AF9E-22EC044B0CB5@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0DE37084-185C-4144-AF9E-22EC044B0CB5@vmware.com>
Cc: Pv-drivers <Pv-drivers@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jorgen Hansen <jhansen@vmware.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Tue, Jul 20, 2021 at 06:04:15PM +0000, Vishnu Dasa wrote:
> 
> On Jul 20, 2021, at 3:39 AM, Greg KH <gregkh@linuxfoundation.org<mailto:gregkh@linuxfoundation.org>> wrote:
> 
> Also I would need an ack from Vishnu.
> 
> Acked-by: Vishnu Dasa <vdasa@vmware.com<mailto:dasa@vmware.com>>

A maintainer that sends html email isn't going to work very well :(

Please fix.

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
