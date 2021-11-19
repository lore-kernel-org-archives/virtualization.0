Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4391C433F5
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 15:30:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3825561AFB
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 15:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3825561AFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ED273401E9;
	Fri, 19 Nov 2021 15:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ceaWpazMN5Xn; Fri, 19 Nov 2021 15:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5AF7A401E4;
	Fri, 19 Nov 2021 15:30:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BB5AC002E;
	Fri, 19 Nov 2021 15:30:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E06D7C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF5AD410AE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:30:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K9zCAj3KKz3N
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:30:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E3D5410A4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1637335831;
 x=1668871831; h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=J0Q2eQn/3bf2Y/52GQfblqSKUvkUXmIj55C006lwxiI=;
 b=JAVoJWlzLinNsPrm5Iuq3v1fG0JkJw8Z+VxhZdmCpe4V1t5cR4ilU7sV
 5UBUqd7mczfTTYpU+m1um+p5fYegc4AxaBLPYtV9iuR5K/nxsMRAaIQnA
 6ldUOzAKjoqw0qpXxLSCMqmsAYbd5+vTUJBMdMnUC5z1nRaED8h1Xjeg+
 tzc4XN149By1aaboRSlZVNhe76qSHgnOaocp6ziEP7WPSUnOIzmyS/TmR
 j4OvoVEjK7Vo4EbYfkhUyY6wq50GiswBCvkxeqaSt5DJ5rctw0x/ggVN4
 n88GmE84rbl3LkCXQQEIag+eWnxHmdcFUraw+IxMP5O8MFsVsD43/ZhwX w==;
Date: Fri, 19 Nov 2021 16:30:27 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211119153025.GA17236@axis.com>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211111160412.11980-2-vincent.whitchurch@axis.com>
 <20211112023529.2nypmrnm6mufcpjt@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211112023529.2nypmrnm6mufcpjt@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "wsa@kernel.org" <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "conghui.chen@intel.com" <conghui.chen@intel.com>
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

On Fri, Nov 12, 2021 at 03:35:29AM +0100, Viresh Kumar wrote:
> On 11-11-21, 17:04, Vincent Whitchurch wrote:
> >  static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> > @@ -141,7 +140,6 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >  	struct virtio_i2c *vi = i2c_get_adapdata(adap);
> >  	struct virtqueue *vq = vi->vq;
> >  	struct virtio_i2c_req *reqs;
> > -	unsigned long time_left;
> >  	int count;
> >  
> >  	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
> > @@ -164,11 +162,9 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >  	reinit_completion(&vi->completion);
> >  	virtqueue_kick(vq);
> >  
> > -	time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
> > -	if (!time_left)
> > -		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
> > +	wait_for_completion(&vi->completion);
> 
> I thought we decided on making this in insanely high value instead ?

That wasn't my impression from the previous email thread.  Jie was OK
with doing it either way, and only disabling the timeout entirely makes
sense to me given the risk for memory corruption otherwise.

What "insanely high" timeout value do you have in mind and why would it
be acceptable to corrupt kernel memory after that time?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
