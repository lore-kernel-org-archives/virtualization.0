Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182D12288F7
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112360; cv=pass; b=MYcRDqHba/+/jBPOVkxBnygXGPqh9G1kKg9uJE/owuEdyZt2f3DKi6RfVW3o2YZKONugT8ngTY/CXjRNqtTG5YEkesCeupxs8B83tIYXPMeUTUJyFhk49KWlqfhQGVcCZHRGy6I9tqbcQ7UkTbF6TNZTA9ga/M2TnUe/O7QFSG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112360; c=relaxed/simple;
	bh=njSEgaJpM7aFcob4ZfKjZckAVbtjUFV47r+aCCHO3Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbT/3gxMRF7ZBYSyQYw5Mw0ZHSVBiFJ5f1FTFQ8O7xmBEDNY/1uf7LXX6Nl8fblE/WfiZTlGhh74qJKY+XUw4BBagZNvJgXxJityNf5UrKyVun+zIJA1+oIZ3OlhIdC8OMQ7SsUWZQanbPMMTRaXAbc+7ziwA3biGIzRswK2GV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Y3yee0c2; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=ltYQMkvq; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Y3yee0c2";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="ltYQMkvq"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-sc6w.prod.antispam.mailspamprotection.com; s=arckey; t=1767112358;
	 b=2rgx+E/C8s5yTbcnFxK4JF1fC10NdKfoITUFEpBqjPT0pjq8iizHEU0tJexeMbplf8gcH00AQJ
	  vA2mO44iMuP/yN+5f+Dc4MLCVrrOpZY1/DbIM9F4gGffdhVTKnO0YmgWrAU+5C0BKknj9R+kiS
	  V/BjRNysoyRrFNXghAZdvTS5AJw1Aj5J8/eVcjqlg8QAHonYREuIdAy5v91MJPnbIucvcDO8Bv
	  1ht6FaPtS4wOw1LPaA4WC2uO0Iie52Z13PE4SJta5thfosNHdYcqa2NVIFA1dRSWEvXQPYXDLa
	  HhYBAIhZAWQwQjOQmBlUugAA8xSfeCUAQjJqmoytwJadUA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-sc6w.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-sc6w.prod.antispam.mailspamprotection.com; s=arckey; t=1767112358;
	bh=njSEgaJpM7aFcob4ZfKjZckAVbtjUFV47r+aCCHO3Hw=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=Spwyvp4oRmPZRBD2MaekFLYvuJ169YOXXK3iwQgsr8Dmhm46kHnCZ3/EO/zJJQC402UK+g53fL
	  zgqg6dp5OVPQNAS0XSOTm+aZB0BcSX268Dy372SJ8cxImbEl249GbWaTOfK4uaSK1q4oAWxT7p
	  GcYfX2CBGikoiglsKpPbUR1fN2ApUObd2mcJ1Ei0feyEEI1t/erFPVgjpghWEX2jsLiXkSv3y3
	  27vBN+TnI1UFJUbeCX/aGj0dscQ3jucaDCqld8DZ8Pjg5pM7u2d5WB6HSksFHoz2ebKlNrLm0m
	  XbOrL0U7NdFJJWQ1YywQgh60N/qvkS97aKKKXIeR4Us7rw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=JeAM4nWTpcUtADM4VJ4nzpi2Ew5kVIMLOrtrf3VwIPA=; b=Y3yee0c21ZE22g/Q+AQuMcwI9F
	4UDXJw7owMP4ETyEggzQwD1WfIcJg08/TRifTOi+RoAUZRdMtsy5RAwUnZfgmA/DOw0DKyGHJZSFA
	GWl5jqyydzYZwqU307rox+wt4zdenWsyQ2yU00ixpfZ6PKtVOfpX6TA8C/PeGzrMv0/g=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-2fc8.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vaKHh-00000001Cxd-0Ill
	for virtualization@lists.linux.dev;
	Mon, 29 Dec 2025 20:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=JeAM4nWTpcUtADM4VJ4nzpi2Ew5kVIMLOrtrf3VwIPA=; b=ltYQMkvqxx4tzd/ntoKjZwrW6h
	iOE+bIqwyF4FcX5vW029HCyMEpSkQXRShlZDXfgUcw8X0qjDOArQ7C8epVKOgIP1IkBDWzTPRCqEc
	4YZoO1kxwsEzDeH1kcvg2pkWJVeVfeNrdYpyUIxHVxRDY/IW0sNB98KLdCLMuIeoDsyo=;
Received: from [95.248.141.113] (port=62969 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vaKHQ-00000000BS5-1TCH;
	Mon, 29 Dec 2025 20:55:52 +0000
Date: Mon, 29 Dec 2025 21:55:50 +0100
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
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
Message-ID: <aVLq1ibPcPHk-7Qv@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aVLOPMmpvArnVAHZ@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVLOPMmpvArnVAHZ@fedora>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: f756753f238d09354efc727cc5ca1870
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vaKHh-00000001Cxd-0Ill-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-sc6w.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Matias,

On Mon, Dec 29, 2025 at 07:53:48PM +0100, Matias Ezequiel Vara Larsen wrote:
> > While stress testing this, I noticed that flooding the virtio-can
> > interface with packets leads to an hang of the interface itself.
> > I am seeing this issuing, at host side:
> > 
> > 	while true; do cansend can0 123#00; done
> > 
> > with:
> > 
> >  - QEMU: the tip of the master branch plus [2]
> >  - vhost-device: the tip of the main branch
> > 
> > and the following QEMU invocation:
> > 
> > qemu-system-x86_64 -serial mon:stdio \
> >     -m 2G -smp 2 \
> >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> >     -append "loglevel=7 console=ttyS0" \
> >     -machine memory-backend=pc.ram \
> >     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
> >     -chardev socket,id=can0,path=/tmp/sock-can0 \
> >     -device vhost-user-can-pci,chardev=can0
> > 
> > 
> > Restarting the interface (i.e.: ip link set down and the up) does not
> > fix the situation.
> > 
> > I'll try to do some more testing during the next days.
> 
> I tried this and I could not reproduce it. [2] requires a minimal change
> to apply, i.e., qdev-properties.h has changed to /core. I'll send a v2
> for that. I used latest vhost-device-can. I run `candump can0` in the
> guest and `while true; do cangen vcan0; done` in the host. Am I missing
> something?

With the plain 'cangen' you are not really flooding the interface, since
you are only sending a random CAN frame every 200ms. The only way I can
reproduce this behaviour in a consistent manner is running from the host:

    while true; do cansend vcan0 134#00; done

which seems to generate the maximum amount of traffic.

This is not of course a realistic bus load, but is leading the system
(at least on my setup) to a corner case somewhere.

> 
> Thanks,
> 
> Matias
> 
> 

Thank you for this effort!

Regards,
Francesco

