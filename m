Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488D239562
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752973; cv=pass; b=AKX6NBs9laJSZJW3mX63Mq/O+cGVnr/mmnAE3qnnmA2QpS7OJG1trc1PI0Tqgukc0VfjeUaxFeRbgc39pL5mlYdDfJyI8IgPtE9ubGrJBccOOhE8wkPqGGOXDNi00PgO+5o7Hn7TYQMly+CvAL4IgXhHQUc9tmRsgEXSigovN0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752973; c=relaxed/simple;
	bh=QzvbJ8y7akSoxlfvziTyU2H26u+gdjsVcxPDRT0Vekc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxM0AcR4JmmzMiTz95/EQCkwxhOCQEmkIdgdR8h3QjPEVz6tYVqU2jKlhrQOkVhmXrI6Xm13PWTMSVIabfwitoYRCO2vkZ8ht1/ctc+BXGSKQfng2SmVSwaEmzMavyVgxYxblgVRuPRMsbajq9VCmabXmavgdok7psLv4WQYiWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=zv94NXit; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=ahoIrKkh; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="zv94NXit";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="ahoIrKkh"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-6n59.prod.antispam.mailspamprotection.com; s=arckey; t=1767752971;
	 b=yS1pCr2LE/9hGpp4Z2j/lAFLUXAzvZ9JfzfafYCPlxOkwCAsAv/+ijlCXNsxwAbXSkurFkVDDB
	  2jGZjha0vg6IO94nF/7ZdaQXWt/7czEEAG8l0PBndCzr5QTpkNZrssPOdRBAP57Fth3MBFuR4G
	  bmHhnKBXJa2SyNH4i5J1iFY6876xgJur8hwq9Bnat8H3G8+OR5XQF8KjCJJKTsl4jvk51b1aMj
	  nkuNJcogVzYTkhAqHql5A/kcbIPLqFVeFfPiGdLmPfMy/XBC1ylpUD4cSXbEqupKySmIbjcxaP
	  1rubrP4LY39S6wT/4N1A7kqxiQMfZo0yH+cAOqVcF5NftA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-6n59.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-6n59.prod.antispam.mailspamprotection.com; s=arckey; t=1767752971;
	bh=QzvbJ8y7akSoxlfvziTyU2H26u+gdjsVcxPDRT0Vekc=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=jhap3ID3Mgg7BzQ20DMt2QRMn/xrEDrVmytDT0WJyc4wIQWN4RYM4lW5JmJ+PQ7Rm4a2yb339l
	  WwDSiur7ExgKz+SvYHCnvPLu0Cazk3wy5iw9hjlGpvsjOlVtpXdOMn2V0NOS557Ug8ePSaaAIl
	  vi+3eiW0nBIKJ5+Ay3s8p1lVQxTcUTQRklueFwP/7uLS5g5XuRa7AJ19b6fNeo1P+E4GTFqIQt
	  PqkOFPvjGCOPI46bvM0M9/2wEm+1fKkmIatCaQIMplnoLY9jCofy6Fy278pM2443NsoFPTD/Sz
	  dLeDe5w3R5j52WgNA3jdIu0cF5VGYWBhmGMkC1Pr0J1LIg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=Uf1wXDnZEtrch6jvGDnIRLXBqVcbuiKUoyldZJS9XMk=; b=zv94NXitnutF9pzApggX5Ngfm3
	7FCQKXCg4mfiFh5aOdcU7XGXkKeskLe9PrEHYm3IbvtgH/J7iIUmnIHJOxIu4MJTGgBHun0YcBfC7
	maDfYK35bTVbyO19WkD7EQX5am4nEilD/4rOba2CDQgbKXcwj65YFiUED0mECOb2Fu8g=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-cn9l.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdDqP-0000000ESIS-1pWr
	for virtualization@lists.linux.dev;
	Tue, 06 Jan 2026 20:40:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=Uf1wXDnZEtrch6jvGDnIRLXBqVcbuiKUoyldZJS9XMk=; b=ahoIrKkh5XvAojUYOjlLBHZJj9
	UwKnqiO5GWH0DmIGfHnZl6KzZzoKrvt0mxu34JRXe6dsQqeEckobi6Zf7Org+dq3JRjDFBxmAxZ+8
	9ZuhEFYl5boFi+ck9u6H3Ria/w1QvyyF2vQlHE5D94dXsDeQSF7O3d3f4XicSpNaj9Yo=;
Received: from [95.248.141.113] (port=63004 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdDq5-00000000DxZ-2mvq;
	Tue, 06 Jan 2026 20:39:37 +0000
Date: Tue, 6 Jan 2026 21:39:35 +0100
From: Francesco Valla <francesco@valla.it>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aV1zB_fYQE_OBZm2@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aVLOPMmpvArnVAHZ@fedora>
 <aVLq1ibPcPHk-7Qv@bywater>
 <e5bc1353-ed3e-478b-a26e-0bb9a50b3863@oss.qualcomm.com>
 <4cf222cb-e6e3-4d09-a7d8-bc64b8e148bd@hartkopp.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cf222cb-e6e3-4d09-a7d8-bc64b8e148bd@hartkopp.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: bb0fe65a68a252b19295f508ad6f37d7
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vdDqP-0000000ESIS-1pWr-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-6n59.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello Harald, Oliver,

On Tue, Jan 06, 2026 at 08:43:42PM +0100, Oliver Hartkopp wrote:
> 
> 
> On 06.01.26 17:50, Harald Mommer wrote:
> > > With the plain 'cangen' you are not really flooding the interface, since
> > > you are only sending a random CAN frame every 200ms. The only way I can
> > > reproduce this behaviour in a consistent manner is running from the host:
> > > 
> > >      while true; do cansend vcan0 134#00; done
> > > 
> > > which seems to generate the maximum amount of traffic.
> > > 
> > > This is not of course a realistic bus load, but is leading the system
> > > (at least on my setup) to a corner case somewhere.
> > 
> > I have no idea how long the shell needs for a loop, always used cangen -g 0 to stress the setup which is most probably faster than the shell interpreter, and sometimes did this for both directions (RX and TX).
> > 
> > Full load is a realistic setup. And even if it was not, if something stopped working or worse crashes torturing the setup this was a problem.
> > 
> 
> Yes. cangen -g 0 -i <interface> creates full load - even on real CAN
> interfaces. You can also generate fixed content if you want to omit the
> generation of randomized content. 'cangen -?' prints a help text.
> 

I agree with both of you - I was simply arguing that a plain 'cangen'
with no parameters is not really loading the interface.

For some reason, I was only able to trigger the unwanted behavior with
cansend in a while loop and not with cangen -g 0, even with fixed ID and
payload. However, I suspect the issue is a matter of timing and
coincidences rather than load level.

> Best regards,
> Oliver
> 

Regards,
Francesco

