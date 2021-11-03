Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2633DC433EF
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 14:42:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DCC60F39
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 14:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4DCC60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F1914010E;
	Wed,  3 Nov 2021 14:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id buyXIy0q8Xlj; Wed,  3 Nov 2021 14:42:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA74B400A4;
	Wed,  3 Nov 2021 14:42:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1852C0019;
	Wed,  3 Nov 2021 14:42:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1A7C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 14:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F063560838
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 14:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CPIBaKZ87FcW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 14:42:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89BE6605D0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1635950565;
 x=1667486565; h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=h8J2kmEgurblPdeLMlFL+uqxgtxQUO5ic+miy3dskg8=;
 b=LxcH72WaA7E8gWym0jeTGyVTCBX59DxrL25Pk+nbvU4DE9v7JO0fCMfd
 LPFeem6y4H/9l+kAtB3NIYIG+RBnmF8vXI1paesKGuFuw1NSgrZCjwj2Z
 mELUtFIelLAoEIDtJabA9BRsBxnKmAd0f7AiXNYh+TFzQ9qrLMLjM1+2i
 f8qPAthfb34+DnHz0kQotgZ4rPjzXRwF0TeUejtuG3zHUV07Ab7+p31fR
 JkJmx1FVPwtuGc3BEPP1KEA3bQPHlKSTyXToxbZE/Gin3F+GDxBQJ/cyb
 h0Z4FaPCdbKtJkr9pNz45sa81BuKg1UOX+11HH36ai/IBVvx73rsWhitb g==;
Date: Wed, 3 Nov 2021 15:42:41 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211103144241.GA27285@axis.com>
References: <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
 <20211020064128.y2bjsbdmpojn7pjo@vireshk-i7>
 <01d9c992-28cc-6644-1e82-929fc46f91b4@intel.com>
 <20211020105554.GB9985@axis.com>
 <20211020110316.4x7tnxonswjuuoiw@vireshk-i7>
 <df7e6127-05fb-6aad-3896-fc810f213a54@intel.com>
 <20211029122450.GB24060@axis.com>
 <8592a48d-0131-86bf-586a-d33e7989e523@intel.com>
 <MWHPR11MB0030C3489F38FF2AAF7C3D0A908C9@MWHPR11MB0030.namprd11.prod.outlook.com>
 <20211103063745.utpphthou4angs4s@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211103063745.utpphthou4angs4s@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Wolfram Sang <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Chen,
 Conghui" <conghui.chen@intel.com>
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

On Wed, Nov 03, 2021 at 07:37:45AM +0100, Viresh Kumar wrote:
> On 03-11-21, 06:18, Chen, Conghui wrote:
> > >>> Over the long term, I think the backend should provide that timeout
> > >>> value and guarantee that its processing time should not exceed that
> > >>> value.
> > >> If you mean that the spec should be changed to allow the virtio driver
> > >> to be able to program a certain timeout for I2C transactions in the
> > >> virtio device, yes, that does sound reasonable.
> > >
> > >
> > >Due to changes in my work, I will pass my virtio-i2c maintenance to Conghui.
> > >
> > >She may work on this in the future.
> > >
> > 
> > I'll try to update the spec first.
> 
> I don't think the spec should be changed for timeout. Timeout-interval
> here isn't the property of just the host firmware/kernel, but the
> entire setup plays a role here.
> 
> Host have its own timeframe to take care of things (I think HZ should
> really be enough for that, since kernel can manage it for busses
> normally with just that). Then comes the virtualization, context
> switches, guest OS, backend, etc, which add to this delay. All this is
> not part of the virtio protocol and so shouldn't be made part of it.

The suggested timeout is not meant to take into account the overhead of
virtualization, but to be used by the virtio device as a timeout for the
transaction on the I2C bus (presumably by programming this value to the
physical I2C controller, if one exists).

Assume that userspace (or an I2C client driver) asks for a timeout of 20
ms for a particular transfer because it, say, knows that the particular
connected I2C peripheral either responds within 10 ms to a particular
register read or never responds, so it doesn't want to waste time
waiting unnecessarily long for the transfer to complete.

If the virtio device end does not have any information on what timeout
is required (as in the current spec), it must assume some high value
which will never cause I2C transactions to spuriously timeout, say 10
seconds.  

Even if the virtio driver is fixed to copy and hold all buffers to avoid
memory corruption and to time out and return to the caller after the
requested 20 ms, the next I2C transfer can not be issued until 10
seconds have passed, since the virtio device end will still be waiting
for the hardcoded 10 second timeout and may not respond to new requests
until that transfer has timed out.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
