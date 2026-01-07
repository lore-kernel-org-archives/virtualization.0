Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DE76026
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812158; cv=pass; b=OrvMUGrvKAEgV0oKjDxipekdTY6Xv492sSoywBPEAJdeIc31xiA9if0a3SK5z5gDHOS9LC97buTWpEGfEopHlXR/uecSHOGvxRVU6nWDSzgEPuEjYal1jx1CmEpLSVzXadc53y0zZCT8GiEzFHCmOPxWcHblm07sUq+rQfnEzFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812158; c=relaxed/simple;
	bh=p3m1YQ/9P5vNTomEXOUxwQentxiVuYEKEgDewVGrR0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7p/fzEcIdA6+DfrYO4X6cCUvb1utiFbSTYJX7QTnbPpfWCPJGEsiyAmXyqZTmYjJAZr0o7I51s+xb7JdHrUCPblz0rOjL0mAkLYbvZJaLGhzjmvduDFdr3HBymJUMLi5Xqk6x5NEl56PKtwzAOKCEGwXaMMSeLNzD1RzlNFMs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=m+apLgfg; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=CrVlLEfJ; arc=pass smtp.client-ip=185.56.87.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="m+apLgfg";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="CrVlLEfJ"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-15n0.prod.antispam.mailspamprotection.com; s=arckey; t=1767812155;
	 b=ninNJ6NlhSNor0XErxbiGkWZfSncI9Av5Uop9/e6THmNHwLB7heCrOGcgB1TGDPGP5VaDKcofm
	  M61WXH3dGwGTwvi1pRTBpb6vGYt2afUnM3jSxTVkOJusHIA5/ss5Q1o220FY4jknWZQlVsmn0k
	  LsuCBgu5GEHW6Xmc7HIQze13prr91IZ/pXza1LPsHgnWx5PZ97kurFGQQzKTe/LqXO0xGQ5/vd
	  uY5QlUbuyzYxIi/hnbtK6bjmsfDqJqnYU1WMlpbjO6xd0YyCPAAtZ9WL/QDzt2COt3qhQDHzlD
	  O+wuOAHxP4Y7J44f2spV6OPC3IBydULAU/UJiQwdFe0gOA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-15n0.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-15n0.prod.antispam.mailspamprotection.com; s=arckey; t=1767812155;
	bh=p3m1YQ/9P5vNTomEXOUxwQentxiVuYEKEgDewVGrR0I=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=oe4mikrniemXn5haHaFwxeOa6Clfqfn6z3TrU9NvJnsWDkTV6SiUq5cXFvDPzbzwaMG91LJbDI
	  k0XnCNwl2aAjd2coawQUVfB2JtOkYZys4rQRyLP/GtJQonom5+RqEhLvs5EX/UI0nZESg6/eGC
	  CDtZSNBmk9/5YC8YgGHzlqog1l9Q9o7z+oDjUlCRwf9HD8oox8bNy87ehJ4wSMtoV1SP6uwwHh
	  ObidAOX9x7VQjmAgJW9mWM956bsbKw0S3wzBNe+/7+9lrgRCofdhRkI47HJISCqWswVs96t2gQ
	  wn0IrLcoqin6MOAbMvTzGGyP5z65CenuW1lsYTKdo863pQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=iUMyPLpJ71jeIRwYpzO9IcEWcMDLagnGl8XB+6L+pRY=; b=m+apLgfgSvYIMcXv5xI7HoT7SJ
	/XzLVP5m5eACA7gpqee/a945SEG0gZzWasxu9k0wQ86q9hOShIOjI8trhpALsVHgJsE2j3ILcgJ8Q
	KtD/St0yXZ/5s4sFu8Xo24wvyIQQA1Aw7gX0i9vP7fB6vcs3VMkARGke9PRKx8zATqJk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-15n0.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdYh7-00000001sWb-0eD7
	for virtualization@lists.linux.dev;
	Wed, 07 Jan 2026 18:55:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=iUMyPLpJ71jeIRwYpzO9IcEWcMDLagnGl8XB+6L+pRY=; b=CrVlLEfJDO/RE8P7SNCAUqguH4
	SPG4x3JfwN5mPy+ARPsEDM8o24G8SS3JYDYBMyEK2nYpfpx5YW5xEZtSiNcwPj18Cm69rXmhz2iOG
	ehHIZTc785TKpKLFtklMGSTnm8Q02Jaihyi2ahkQAHcA/huI/IktkpxDEA2rg+nwVIrI=;
Received: from [95.248.141.113] (port=62266 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdYgq-00000000AfQ-1T6g;
	Wed, 07 Jan 2026 18:55:28 +0000
Date: Wed, 7 Jan 2026 19:55:26 +0100
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
Message-ID: <aV6sHofXnZuu84OV@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aU6lCL_vrF93lpYa@bywater>
 <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 1701ceb4260c0ca71e1f0d282223ff90
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vdYh7-00000001sWb-0eD7-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-15n0.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Matias,

On Wed, Jan 07, 2026 at 05:14:25PM +0100, Matias Ezequiel Vara Larsen wrote:
> On Fri, Dec 26, 2025 at 4:09 PM Francesco Valla <francesco@valla.it> wrote:
> >
> > Hi,
> >
> > On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> > > While stress testing this, I noticed that flooding the virtio-can
> > > interface with packets leads to an hang of the interface itself.
> > > I am seeing this issuing, at host side:
> > >
> > >       while true; do cansend can0 123#00; done
> > >
> > > with:
> > >
> > >  - QEMU: the tip of the master branch plus [2]
> > >  - vhost-device: the tip of the main branch
> > >
> > > and the following QEMU invocation:
> > >
> > > qemu-system-x86_64 -serial mon:stdio \
> > >     -m 2G -smp 2 \
> > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > >     -append "loglevel=7 console=ttyS0" \
> > >     -machine memory-backend=pc.ram \
> > >     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
> > >     -chardev socket,id=can0,path=/tmp/sock-can0 \
> > >     -device vhost-user-can-pci,chardev=can0
> > >
> > >
> > > Restarting the interface (i.e.: ip link set down and the up) does not
> > > fix the situation.
> > >
> > > I'll try to do some more testing during the next days.
> >
> > After a deep dive, I _think_ the problem actually lies in vhost-device,
> > since it is not there (or al least, it seems so) using an alternative
> > implementation that uses the qemu socketcan support [0] (implementation
> > which builds on top of the work done by Harald and Mikhail):
> >
> > qemu-system-x86_64 -serial mon:stdio \
> >     -m 2G -smp 2 -enable-kvm \
> >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> >     -append "loglevel=7 console=ttyS0" \
> >     -object can-bus,id=canbus0 -object can-host-socketcan,id=canhost0,if=vcan0,canbus=canbus0 \
> >     -device virtio-can-pci,canbus=canbus0
> >
> > Unfortunately, my Rust knoweledge is not sufficient to understand the
> > vhost-device implementation [1]; the issue seems to be related to the
> > host->guest vring becoming empty and not refilling anymore.
> >
> 
> Can you try with
> https://github.com/MatiasVara/vhost-device/commits/fix-for-923/?

I'll stress test it during the night, but this seems to fix it. Before
it was reproducible in a consistent manner after mere seconds, while i
now in a bunch of runs I never reproduced it.

I also agree with your analysis on the commit.

> 
> Thanks, Matias
> 
> 

Thank you!

Francesco

