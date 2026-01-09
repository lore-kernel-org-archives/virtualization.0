Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665636405F
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977958; cv=pass; b=VC8Z3opnarZDix6ZFhXfBjOPX+a9a1Xqujn7lz7NCj7uliCvKi8Tu1UzQT+T2mnCLbQ4n0NcWzaEBxLZPldiUEc3FaW0rMmDmUYOeSnZmbpZ8n6j13zIs+cfn/Sy8ktqa270d/6lKwsJAk4VyZE5+uCmttoISvlPFceXMavrUms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977958; c=relaxed/simple;
	bh=P9BwpCbBtXcN+Id5YsqJ5AvEB0fHhzdsu7AhWCTSAU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia+h6NoWXC4vnSezr/OhMQw6TsRvMEyYLzJ2jZvLLvXB5b9PvoECb0wI8ttcCCeaHzF8ICZfiXxGj79fmV8vZS2p2GQYOiz/FjS6pDkbpaCIFek8QjnmeBwifl13FQHYDq6zr5ZqAqO63uOi2udu8VLZd6nZdBPBg9aZU5b/bHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=T9roGmbt; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=EwhT3F08; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="T9roGmbt";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="EwhT3F08"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4cpg.prod.antispam.mailspamprotection.com; s=arckey; t=1767977957;
	 b=P/vJRp/dTUmx9NfO0eH85jZUjKXRqi1OOGcNc5fD96Xhu4RZlzx0YIevngl16pzK7A1bcOyen1
	  Mwr172i2KVNt4Wbl4ec7Y7ZNocZnDjm1zrgnuPGmSdAyxTHuQt+Q3nXkNXjjrMkm7ksElyxlB5
	  bsoRIRuBDVW04D+ZnSyJE6KL0JW71DYgnFbgOJ4r3FP4mn/qHpaGC6meBkn+3NHUX3n7uM/Q7T
	  KEA+C2572CABLkyzxq/GscskfxYlCPSeRr18JXFBeNLMHqd7cNeIys4Ug0dnIvTWULj1nnbPpl
	  jk1bbykZoPsbkRVxpPu2JaFaXYLJEbu3dcMr/lSjYAnDmg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4cpg.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4cpg.prod.antispam.mailspamprotection.com; s=arckey; t=1767977957;
	bh=P9BwpCbBtXcN+Id5YsqJ5AvEB0fHhzdsu7AhWCTSAU0=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=EVjNMQa3U59Q7zf5WceRE9eIlzEYgbvLeFTyqaQwz1imBu23AqW+VSH1zAmXYPr6pWvvp6I7wV
	  R94uavKhUfVMbBXS9EiT6xtMxkxumdtT4NHxhwf4iZRSI5m+Md2uoi71VMG1JVtBuPr6jRLr7d
	  CYTaABqFxi8wFYXeatrGMzqHSnQi97uQqSdP1RksrN4OO69e5m/gb8mw2vHMr5SCKG1NiN4eLb
	  HLlUPSXInPBP/i4tlZ/0OZwlQn6m7Zz5nNAkeuCXd5TGzJTJeKMpuhxkby4YP4wM9/yrlKl8MR
	  tyJWo5+NMpf6K7pqc+2C8yKE2jqK95gL2b1Dc/I8PIeftg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=iilUOcUAV6K9c1W7Y3wKJUT6c/z6NQwvvlB/VuRuS+A=; b=T9roGmbtCVlzmXPmfFW/62fIov
	pzqOOCchcwTv5RBe6/MnqbXeok4qRVQ4B3ZkRDAdEkmarp+roaN1o4WUx/lPL/HCnsY6oYAFeBGTH
	jh5RGXWWJPWQNc+16BlYNtm4xFBeh7ZtLEjuS33nYFWRA/acVHEHOo5IhvzIg8ijgEpo=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4cpg.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1veFpK-00000001MV3-2AMv
	for virtualization@lists.linux.dev;
	Fri, 09 Jan 2026 16:59:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=iilUOcUAV6K9c1W7Y3wKJUT6c/z6NQwvvlB/VuRuS+A=; b=EwhT3F08izkQkqjBGa+uBapVfX
	9220mY0rvmZNZHSxYoJiyUwkyxme7S3EquaRB23JSzeKvuMmwx1ImHZY7WAqOwoHaZk4+Xm2WrxjV
	83fpiJWdoFE4iO6LOK89gnrn/vme/WkCk9qLCAF3zQxyCWcSWLHONsy9FHBR+vkJCYqs=;
Received: from [95.248.141.113] (port=63988 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1veFp5-00000000DCa-2iWV;
	Fri, 09 Jan 2026 16:58:51 +0000
Date: Fri, 9 Jan 2026 17:58:49 +0100
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
Message-ID: <aWEzyc-gt4lEDJIR@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aU6lCL_vrF93lpYa@bywater>
 <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
 <aV6sHofXnZuu84OV@bywater>
 <aV7lplXiOehmw2iR@bywater>
 <CAHYGQ0yQ=20eFJN-_=_+uqyk=nRyotQLgf01B-Rb8NVk9N4DpQ@mail.gmail.com>
 <CAHYGQ0waHHLOOjX6cSkSHkNRGYDqsCccKUa5E2DGZwR9DtjMUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHYGQ0waHHLOOjX6cSkSHkNRGYDqsCccKUa5E2DGZwR9DtjMUA@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: c8e8ccca3bb4a1154d9d2e3f44ee7bae
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1veFpK-00000001MV3-2AMv-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4cpg.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Matias,

On Thu, Jan 08, 2026 at 09:21:38PM +0100, Matias Ezequiel Vara Larsen wrote:
> On Thu, Jan 8, 2026 at 12:21 AM Matias Ezequiel Vara Larsen
> <mvaralar@redhat.com> wrote:
> >
> > Thanks Francesco! right, I made a mistake. process_rx_queue() is only
> > invoking signal_used_queue() when req_rx_buf is true, i.e., the device
> > has actually added something to the used ring. I'll fix that.
> >
> Feel free to test the updated commit. I just fixed a few bugs. So far
> my tests seem correct.

I stressed this during the night without any issue. So I'd say it is now
working.

> 
> Matias
> 
> 

Thank you!

Francesco

