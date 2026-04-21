Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB123BD631
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773726; cv=none; b=ZRVyi3eR8OVFQGFBeRaijWfq4Ml56UhqUAS1LuMXC1bX5NqRRl9IFgb66WS/Xrl39o32dmlobLqbigpMdeQE2jQTQuPPECYFJ6hY05zLpVfLJBH9v7JlzVngb0FXJurUGZFNyo/vLMO+6K7GTm1H8O4AZDe/iocGltUubdf0Ba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773726; c=relaxed/simple;
	bh=oajVY9JAArpj/ZBUxDSQro3U9WeN149W2+2nKR35HBo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dInGt4ORwfjDieBxrqd8kFBmiZAL6svsOSsQcpu1YKuewr6S2s051eT/zCNggCbQnz7/wL9Vb248S8vYhmv9s2BO9m1EfAooz5exDedAEY66aa0ibjM/cbOXCeZRq5vpElD3o1+VuDUqGZkqeVWxpXOWzINxBlMSvNRQdxwM3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Qr+z6TTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qt3GhovC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Qr+z6TTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qt3GhovC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B0CD1D002B6;
	Tue, 21 Apr 2026 08:15:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 21 Apr 2026 08:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776773722;
	 x=1776860122; bh=EdU8gDzvJq6j5wdRtn++CXG1KxAsg6n8fJndI6G2M+w=; b=
	Qr+z6TTttTBBuXUrKDMOhwXQpvcQ26DIG4Er7q3O065XFjW/BAAf5pMjnFeM83am
	++ZiCemWROLRCSBZrh8aBVXtmkgfoZ+1zaQd/SiaI4GHn/4AaLAi+aehCnqJ1QzR
	x+vdV24O0Yv+Ec0HCdpfXKTAP3nqe5r+LY6Eif+wppdFGrThW7CtArqG3JyQ+9UQ
	EzrXZ4HL5LG9kGb8BgkLRd2YzRnGgEhKn07iJ2rljGXUaEgwmcwZkjSwrMbuDyXl
	4plt0k3plC+SYlnCNPgKuSn0Z0HKii+6i8NSL7kSv7o3d47K7BsAG/wd5jr5D5CQ
	G5ox8ya7WsjZ2ypH3/gEKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776773722; x=
	1776860122; bh=EdU8gDzvJq6j5wdRtn++CXG1KxAsg6n8fJndI6G2M+w=; b=q
	t3GhovCXB9+mwOo4dw4JTS0HbZFCDqQemJNwgJVibmudfPQM8C1ZbgVid5lPj9TV
	f9a/Jck2GZl2Y6cL5/4RfCG06l2AauZBppgazdFaH9PRhXyzjVR4FPpciyLoSNWI
	4CRxsHL1kxiCRPYEi92oYmWbbXMLvOGEcp9UwZJBNkgFziwyvt7cNkC1avLtydDG
	bw3nExzmZZpPFk4n1PBgIs33T0bRLa5T+UkslgR5/HQeAEqMEpnyozwabrGfTPsY
	LjibnACNFMo4ZGVojYnYk6oOUUXGVlMpSGNJyjeVV3Yr+c0ezI/KtGT/kqDTeFZO
	ciqtGZe068Z+Py/yZDrIA==
X-ME-Sender: <xms:WmrnaSZrF21TDkBVHN7-eDRnoyu9UOM4yXcm5QuPF5g9wKbN8NMO2Q>
    <xme:WmrnaQOX0xP50W961Usll7qBUbeFM6PZ0cJM4Ub5XZbm70H6W7W5A_moZoqPeF9tW
    vXc6pfOvruYETOb7ijCJeHLV51IQFXNp1_zuLKTbVYjR5-xutWySm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegrmhhitheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkh
    hhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepvhhirhhtuhgr
    lhhiiigrthhiohhnsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhgvrh
    hnvghlsehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthhopehpvghnghdrhigr
    nhhgsehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthhopehkvghrnhgvlhesqh
    huihgtihhntgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WmrnaSsS1xT3_IPu0NIQtf06jt-WZ5PQR-Y5D3m9Mr3IJVpBXrhQeg>
    <xmx:WmrnaRd8cphfsQeI1k43Mwij1mmtO89oeh97HD5uFPBaoXXsdbvVzQ>
    <xmx:WmrnaUYOrkO6hGDr31dZpFiYlMPW543l-uR6Iooz8xIyhWByTcxnuw>
    <xmx:Wmrnabb1Lu8SJNj8RedDq814TzoBNX41Fad05mqAW5VVKz6C7UHDxg>
    <xmx:WmrnaSwWPcKOYsQj2YGZnD9tFVuqiGWogV_wZ6iifxiooR4Ff7vncPbg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6FBFA700065; Tue, 21 Apr 2026 08:15:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AunhbntQmaLB
Date: Tue, 21 Apr 2026 14:14:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peng Yang" <peng.yang@oss.qualcomm.com>, "Amit Shah" <amit@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: kernel@quicinc.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
Message-Id: <9e5be98b-3035-4e61-8325-52ed8fcf65fa@app.fastmail.com>
In-Reply-To: <d6908885-7f87-442c-86de-3a08eadf417f@oss.qualcomm.com>
References: 
 <20260420-add_timeout_to___send_to_port-v1-1-6c32d33bf4f2@oss.qualcomm.com>
 <37b513d6-770b-4442-b3b3-93b2801f3c71@app.fastmail.com>
 <d6908885-7f87-442c-86de-3a08eadf417f@oss.qualcomm.com>
Subject: Re: [PATCH] virtio_console: add timeout to __send_to_port() spin loop
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 21, 2026, at 11:18, Peng Yang wrote:
> On 4/21/2026 3:38 PM, Arnd Bergmann wrote:
>> 
>> Which host implementation do you use? The way the virtio_console
>> driver works really assumes that virtqueue_kick() consumes the
>> buffer synchronously. Even though that is not how virtio is
>> specified, this does tend to work. ;-)
>> 
> We are using crosvm as the host VMM with its virtio-console backend,
> running on Android. The trigger is Android host reboot/shutdown: when
> Android initiates a reboot, the crosvm process exits and tears down
> the virtio-console backend. At that point, the TX virtqueue is no
> longer being drained by the host and will never be consumed again.

I see, so the normal behavior is likely just fine, but the error
handling is what goes wrong. Maybe there is a way for the guest
to detect the device being turn down already so it does not
actually have to wait any more?

> The crash dump from the actual failure confirms the exact deadlock
> scenario:
>
> Core 3 holds outvq_lock and spins forever in virtqueue_get_buf waiting
> for the host to consume the buffer:
>
> virtqueue_get_buf
> __send_to_port
> put_chars
> hvc_push
> hvc_write
> n_tty_write
>   <- writev() syscall

This current loop here is

        while (!virtqueue_get_buf(out_vq, &len)
                && !virtqueue_is_broken(out_vq))
                cpu_relax();

which looks like the virtqueue_is_broken() check is meant to
catch this exact case. Do you know why this does not break
out of the loop after crosvm tears down the virtio-console
device?

> Core 0 has a watchdog bark ISR fire and attempts printk, holds the
> console lock, but spins on _raw_spin_lock_irqsave waiting to acquire
> outvq_lock:
>
> queued_spin_lock_slowpath
> _raw_spin_lock_irqsave
> __send_to_port
> put_chars
> hvc_console_print
> console_flush_all
> console_unlock
> vprintk_emit
>   <- printk (watchdog bark handler)

My first thought here was that __send_to_port() should perhaps
release the lock during the while() loop, which should avoid
blocking the other threads on the spin_lock_irqsave() but
would not avoid blocking on the loop.

> The 200 ms timeout is intended as a minimal, targeted workaround to prevent
> the watchdog bite in our specific scenario. We are open to suggestions on a
> better long-term approach.

Not sure how to do it, but I think finding a way to call
virtio_break_device() at the point the host device goes away is
the best solution here. Ideally there would just be a notification
from the host, but since __send_to_port() may be called with
interrupts disabled and may be running on the only CPU, that
would still be unreliable.

Maybe there is a way for virtio_console to read a status
register in the virtio config that tells it whether the
host has turned it off? I was thinking vdev->config->get_status(vdev)
but that seems to only get updated by the guest.

      Arnd
