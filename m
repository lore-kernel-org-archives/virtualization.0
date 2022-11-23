Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBC9C4332F
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 10:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE5A141A12;
	Wed, 23 Nov 2022 10:47:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE5A141A12
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=q/nDEY+p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UeZbeICnFgmq; Wed, 23 Nov 2022 10:47:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2AD8241A00;
	Wed, 23 Nov 2022 10:47:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AD8241A00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07034C0033;
	Wed, 23 Nov 2022 10:47:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2BBBC0033
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 10:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6641E41B40
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 10:47:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6641E41B40
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TKsqHGxegjU4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 10:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 298A341638
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 298A341638
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 10:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
 :Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=nQtGQehakneKZBpsBxZeyjy0kWuOhOjsIX5klxvVHU4=; b=q/nDEY+pJAX/ZCqerGGmz/q4Kr
 Aa9vDq+Y9RVvWQDRh091xegZF+RPVQZ9uODXuhI6fVnfjD7nvpvrtGmjl//iVUxlLtaCm0/gAJsbU
 gPSAWuaXbK/M3bxuHMtvuh8TII4SE4pejSVYAKmIyjYNNZlqEJ2sjy2GXG1kemam2DxPFWgyAqrOl
 XV8WHFVwX/mpWRIjC9mGWogfqMg+dMLKSITIydVM/MdEC0llFbW1M4Xv925Yuab+otoFqD9DaUpuI
 6xFfCrEv7esd2Z6QQI19WJl1MuH41dORAuB93n0HDiGyEK02z4d7FcrbCDdyb1oHLKYOVuY8WzfiH
 NUwWb6gA==;
Received: from [54.239.6.187] (helo=[192.168.3.58])
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oxnHL-003l2N-FN; Wed, 23 Nov 2022 10:46:56 +0000
Message-ID: <639e5da00eff26d9fe4be8bed8bc3c91ee3b72a3.camel@infradead.org>
Subject: Re: [PATCH] virtio: console: remove check for cpkt value when
 nominating console port
From: Amit Shah <amit@infradead.org>
To: Andy Bui <andy.bui2001@gmail.com>
Date: Wed, 23 Nov 2022 11:46:54 +0100
In-Reply-To: <Y3MD2vRn+8r+wp61@DESKTOP-UNJJAT8.localdomain>
References: <20221112124522.3981-1-andy.bui2001@gmail.com>
 <f638782743aa6d848af36cba36e9e039e2087d2b.camel@infradead.org>
 <Y3MD2vRn+8r+wp61@DESKTOP-UNJJAT8.localdomain>
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org, amit@kernel.org
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

On Tue, 2022-11-15 at 14:13 +1100, Andy Bui wrote:
> On Mon, Nov 14, 2022 at 09:43:48AM -0800, Amit Shah wrote:
> > 
> > On Sat, 2022-11-12 at 23:45 +1100, Andy Bui wrote:
> > > The virtIO spec does not specify a need for a value when nominating a
> > > port as a console port, yet the virtio_console driver requires the value
> > > to be 1.
> > > 
> > > Besides being a check that's not specified by the virtIO spec, I don't
> > > see anywhere else in the kernel the value is used when the corresponding
> > > event is VIRTIO_CONSOLE_CONSOLE_PORT. As an example QEMU also currently
> > > only passes in value=1 when nominating a console port.
> > 
> > The original virtio-console driver just had the one port, and it was,
> > as the name suggests, was a console port.  When we converted this
> > console driver to a generic serial driver, the first port was kept as
> > the console port to not break old drivers or hypervisors.  I'm afraid
> > we'll have to keep this bit of backward compatibility forever.
> > 
> 
> I think I might be misunderstanding the exact usage of the cpkt value.
> Is error'ing and not continuing with the console port nomination the intended
> behaviour when value != 1? I'm guessing that there are some hypervisors out
> there that set value to something not 1 and we don't want those ports to be
> the console ports?

I've not looked at the code in quite a bit - please bear with me as I
refresh my memory.

I think the backward compat concern I have here is that a really old
hypervisor - one that doesn't do virtio-serial-ports yet, will not have
any other messages sent from the host, but the original console setup
messages.

The is_serial_port() check looks for whether hvc is initialized.  It's
possible hvc may not have been initialized when some control message
comes in.

> If this is correct I think a warning should be emitted here? Not setting the
> value to 1 can exhibit undefined behaviour (at least when interpreting the
> virtIO spec) and it would help hypervisor developers.

Did you actually run into some issue here?

		Amit
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
