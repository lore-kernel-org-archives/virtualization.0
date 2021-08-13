Return-Path: <SRS0=i+Gq=NE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EDCC4320A
	for <virtualization@archiver.kernel.org>; Fri, 13 Aug 2021 07:27:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D9D610A4
	for <virtualization@archiver.kernel.org>; Fri, 13 Aug 2021 07:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05D9D610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4B374080A;
	Fri, 13 Aug 2021 07:27:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3oxS6-bWO74J; Fri, 13 Aug 2021 07:27:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 059C240808;
	Fri, 13 Aug 2021 07:27:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBC50C001A;
	Fri, 13 Aug 2021 07:27:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3B88C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 07:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAD9560BF0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 07:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XpCBuLrMtOQY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 07:27:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C73C36064F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 07:27:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8FC560F91;
 Fri, 13 Aug 2021 07:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1628839628;
 bh=cqWgiVvN0VhZq4Q+Qyorw5Qi3WgDQ3u3yidJG4DZyvM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G1ht4dmKxC0V4yDLoxhtf7dp2k4NizhLBtVs+MKw0bYAjzZvIuMizpCeP5HDPsQor
 ZsrBQNMMqP54xBGuaoA8s5NUS5mQMBuXwJU60d1/qE5bIyhtU0CrePWhl/QzKMxxVf
 grU3fK/RmN6tqm45e//7lkSmiZud9DgbfEkJve50=
Date: Fri, 13 Aug 2021 09:27:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v6 1/2] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YRYeyeZ/22rR26u7@kroah.com>
References: <20210812094532.145497-1-xianting.tian@linux.alibaba.com>
 <20210812094532.145497-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210812094532.145497-2-xianting.tian@linux.alibaba.com>
Cc: arnd@arndb.de, amit@kernel.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, osandov@fb.com
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

On Thu, Aug 12, 2021 at 05:45:31PM +0800, Xianting Tian wrote:
> As well known, hvc backend can register its opertions to hvc backend.
> the opertions contain put_chars(), get_chars() and so on.
> 
> Some hvc backend may do dma in its opertions. eg, put_chars() of
> virtio-console. But in the code of hvc framework, it may pass DMA
> incapable memory to put_chars() under a specific configuration, which
> is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
> 1, c[] is on stack,
>    hvc_console_print():
> 	char c[N_OUTBUF] __ALIGNED__;
> 	cons_ops[index]->put_chars(vtermnos[index], c, i);
> 2, ch is on stack,
>    static void hvc_poll_put_char(,,char ch)
>    {
> 	struct tty_struct *tty = driver->ttys[0];
> 	struct hvc_struct *hp = tty->driver_data;
> 	int n;
> 
> 	do {
> 		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
> 	} while (n <= 0);
>    }
> 
> Commit c4baad5029 is just the fix to avoid DMA from stack memory, which
> is passed to virtio-console by hvc framework in above code. But I think
> the fix is aggressive, it directly uses kmemdup() to alloc new buffer
> from kmalloc area and do memcpy no matter the memory is in kmalloc area
> or not. But most importantly, it should better be fixed in the hvc
> framework, by changing it to never pass stack memory to the put_chars()
> function in the first place. Otherwise, we still face the same issue if
> a new hvc backend using dma added in the furture.
> 
> We make 'char c[N_OUTBUF]' part of 'struct hvc_struct', so hp->c is no
> longer the stack memory. we can use it in above two cases.
> 
> Other fix is use L1_CACHE_BYTES as the alignment, use 'sizeof(long)' as
> dma alignment is wrong. And use struct_size() to calculate size of
> hvc_struct.
> 
> Introduce another array(cons_outbuf[]) for the hp->c pointers next to
> the cons_ops[] and vtermnos[] arrays.
> 
> With the patch, we can remove the fix c4baad5029.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> Tested-by: Xianting Tian <xianting.tian@linux.alibaba.com>

As the build shows, you obviously did not test this code :(

Also, no need to add a tested-by line as that should be implicit if you
wrote and signed off on it.

I am going to ask you to get some help from some other developers at
your company, and get them to test and sign off on this series before
sending it out again, as there seems to be a bit of a disconnect as to
what is actually needed to do when sending a patch for us to review.

That is now a requirement for us to be able to take your changes here.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
