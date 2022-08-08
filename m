Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED915C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 12:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 606F982437;
	Mon,  8 Aug 2022 12:52:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 606F982437
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=IeNqOcVR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F7eYEDKjIemN; Mon,  8 Aug 2022 12:52:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC65E82410;
	Mon,  8 Aug 2022 12:52:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC65E82410
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1BFDC0033;
	Mon,  8 Aug 2022 12:52:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8208C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D6B040162
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:52:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D6B040162
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=IeNqOcVR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EvcdpnxD3g5y
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:52:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47FC240121
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47FC240121
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:52:11 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 4422C6601AD1;
 Mon,  8 Aug 2022 13:52:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1659963129;
 bh=0scMnYGjSdIjHvwIvP9ms+F7OaWUBOHZH1L24VZ3GPU=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=IeNqOcVR7Bg41U3OJ8l4ZlFTADjgVye6xxaiLWWAiYnHqyszB1Zs3dfa61gmq6yos
 Byl9K1SAJRU/6+LMvAD1tPi3uDA44vwCPegwCjTheetwV9rqSkUxJ0U16yKkrvaAp7
 nfgA4Vl3XPApq4om4suibqMlttqEgSIbXWvjbNKrKmrODfttot6Xd3D28j5svdGs2F
 Hgv4sO1cdKv2r0UFTyt4Ed29Kbz1IFCK2W8QEo+0QVajbQ0TJKMKLApuoYPKW6b+gm
 7HxBg8eEuICcaY+ths5749UVAOa6+vgmWmw5mEvFncafLF3+VFjz3AJIGv2RyzwUO1
 DWGlgQ5y0duUA==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Cornelia Huck <cohuck@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio: kerneldocs fixes and enhancements
References: <20220804105914.3707389-1-ricardo.canuelo@collabora.com>
 <20220804105914.3707389-2-ricardo.canuelo@collabora.com>
 <87edxrdjao.fsf@redhat.com>
In-reply-to: <87edxrdjao.fsf@redhat.com>
Date: Mon, 08 Aug 2022 14:52:05 +0200
Message-ID: <87leryrj7u.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Cc: mst@redhat.com, kernel@collabora.com, bagasdotme@gmail.com,
 virtualization@lists.linux-foundation.org
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

Hi Cornelia, thanks for the review:

On lun, ago 08 2022 at 14:14:07, Cornelia Huck <cohuck@redhat.com> wrote:
> Isn't that "kerneldoc"? But maybe I'm a bit behind on the current
> terminology.

Ugh what a silly slip. You're totally right, I got kerneldocs and
htmldocs mixed in my head after so many "make htmldocs" tests.

> This is being ignored, however. Append "(ignored)"?

Ack.

> As you're touching this anyway: maybe s/device/virtio device/ ?
> ...
> Same here.

Sure, no problem. I'll prepare v3 with the fixes.

Cheers,
Ricardo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
