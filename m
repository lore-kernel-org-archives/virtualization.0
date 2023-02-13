Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7B6C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 18:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 340614089E;
	Mon, 13 Feb 2023 18:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 340614089E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xGob6qvp;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=U2axGgm9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwTBg3r4zneO; Mon, 13 Feb 2023 18:53:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96BE64047D;
	Mon, 13 Feb 2023 18:53:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96BE64047D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D78EC0032;
	Mon, 13 Feb 2023 18:53:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89F6BC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 18:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71F3680F92
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 18:53:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71F3680F92
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=xGob6qvp; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=U2axGgm9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V1V7UN_Msd4O
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 18:53:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AF0B80E07
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AF0B80E07
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 18:53:48 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1676314425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XumuzdKDIJOLVLxOQFa7Ls9fvvPzp/W5mMqaQUxDX9U=;
 b=xGob6qvpa705D1lyN8pau6eEY/lV1qg5ggnK9ZzlISZV8ZpYwAYAg1c/FVF97Wla8Io1tg
 2VXfdtHLOdaWDnew1TPKPLs5MlA3wjmsG6esWNVjdA8OXRZAkmEgj3jJjvb20YkKm2HrQ2
 Uc9itVGQBUYfrmtd459gBddWmL75xlWzHoAMVyU70zL2bC6LPiCIqOq7iri7wtkG74iQNW
 DTWaNXRivbVg0QiudwTOLiJxatkUbRXy6JQI2CmbZVn0UsksB9zndbSvgF63/xHGoLa+3N
 COtu5OoV7cqCoWFGAFVg5q2HbFDRG/ebN3sV3+IfOwNSHLh8JZxvyQ0t5zOv6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1676314425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XumuzdKDIJOLVLxOQFa7Ls9fvvPzp/W5mMqaQUxDX9U=;
 b=U2axGgm9NS+lQo3rT9ONaCbWGnPK9Jm7xmja90tV85w8IO8Bh4aVu0JC8SbfYtOkoz4hHe
 lUdRHrOqfgY2kuAw==
To: Yongji Xie <xieyongji@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
In-Reply-To: <CACycT3uY1dfP=5d1go+POh7-J1tUMW+9RXi92KtcFJYMzq-bOQ@mail.gmail.com>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org>
 <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
 <20230127032039-mutt-send-email-mst@kernel.org>
 <CACycT3u=vULuZ9-ZakBjxmbu88iUb+xB2mHJUnHA_8SuUV7H4w@mail.gmail.com>
 <20230213065116-mutt-send-email-mst@kernel.org>
 <CACycT3uY1dfP=5d1go+POh7-J1tUMW+9RXi92KtcFJYMzq-bOQ@mail.gmail.com>
Date: Mon, 13 Feb 2023 19:53:44 +0100
Message-ID: <87a61htn0n.ffs@tglx>
MIME-Version: 1.0
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Feb 13 2023 at 22:50, Yongji Xie wrote:
> On Mon, Feb 13, 2023 at 8:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> I can try to split irq_create_affinity_masks() into a common part and
> an irq specific part, and move the common part to a common dir such as
> /lib and export it. Then we can use the common part to build a new API
> for usage.

  https://lore.kernel.org/all/20221227022905.352674-1-ming.lei@redhat.com/

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
