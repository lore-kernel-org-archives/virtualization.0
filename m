Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39156C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 18:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACCF660BCC;
	Mon, 14 Nov 2022 18:28:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACCF660BCC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Ur1pdSXL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O5AFH-ScB-SX; Mon, 14 Nov 2022 18:28:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BC4C5605DB;
	Mon, 14 Nov 2022 18:28:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC4C5605DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A36FC0033;
	Mon, 14 Nov 2022 18:28:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99615C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 18:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D0EC4008D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 18:28:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D0EC4008D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=Ur1pdSXL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oo2g0XJIeL3E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 18:28:11 +0000 (UTC)
X-Greylist: delayed 00:44:14 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B6F640291
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B6F640291
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
 :Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=mzPCCQJtYzDTTMafDwLKyznTDOv16t2FgFyWI0Y9X+w=; b=Ur1pdSXLoFKZ7NR2dqC2IYlf0G
 6WYvoxcbi1Vo1gvCQT3zcdML/CG7zpwc7N1j9P+HwbIx+hWjZ2RAEFSfxZRNEb0+lpP/FnuDxsYJZ
 fdAEjuBYEkRt5AoSb0NH88ryVPff3+GYUQc0qvX3beTwT1SNcBGDzYKUIdIsgH6t+sE1uDs5RntSl
 f+nvwxeiYduUph5HRdfq+tyXnrEYghA+SzYyx+/GS/J3OTkGGbR0L/Zs4w6CrxvT8xEBJjBOUQrIl
 eQJuR6SeOjqL/bPsHS9TtplYxTOVWzUtoVxiwi1fVeehQyaN7a1OeIzlx5387hc7dh+tp289WxyOt
 TVJmEf/Q==;
Received: from 54-240-196-186.amazon.com ([54.240.196.186]
 helo=uf7e2438656a15b.ant.amazon.com)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oudUs-000qTF-LG; Mon, 14 Nov 2022 17:43:51 +0000
Message-ID: <f638782743aa6d848af36cba36e9e039e2087d2b.camel@infradead.org>
Subject: Re: [PATCH] virtio: console: remove check for cpkt value when
 nominating console port
From: Amit Shah <amit@infradead.org>
To: Andy Bui <andy.bui2001@gmail.com>, amit@kernel.org
Date: Mon, 14 Nov 2022 09:43:48 -0800
In-Reply-To: <20221112124522.3981-1-andy.bui2001@gmail.com>
References: <20221112124522.3981-1-andy.bui2001@gmail.com>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org
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


On Sat, 2022-11-12 at 23:45 +1100, Andy Bui wrote:
> The virtIO spec does not specify a need for a value when nominating a
> port as a console port, yet the virtio_console driver requires the value
> to be 1.
> 
> Besides being a check that's not specified by the virtIO spec, I don't
> see anywhere else in the kernel the value is used when the corresponding
> event is VIRTIO_CONSOLE_CONSOLE_PORT. As an example QEMU also currently
> only passes in value=1 when nominating a console port.

The original virtio-console driver just had the one port, and it was,
as the name suggests, was a console port.  When we converted this
console driver to a generic serial driver, the first port was kept as
the console port to not break old drivers or hypervisors.  I'm afraid
we'll have to keep this bit of backward compatibility forever.


		Amit

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
