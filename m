Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AA1C19F2A
	for <virtualization@archiver.kernel.org>; Wed,  3 Aug 2022 07:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17F7F817AB;
	Wed,  3 Aug 2022 07:24:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17F7F817AB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jWATBpIR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id peVufrZxHgZn; Wed,  3 Aug 2022 07:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ACD878134F;
	Wed,  3 Aug 2022 07:24:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACD878134F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8318AC0032;
	Wed,  3 Aug 2022 07:24:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00C9CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 07:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6E6C410AE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 07:24:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6E6C410AE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=jWATBpIR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NH5kxrk0WVii
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 07:24:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C10DB410A9
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C10DB410A9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 07:24:54 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id BCC186601B45;
 Wed,  3 Aug 2022 08:24:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1659511493;
 bh=gSmhm9TIwih38Vl9DKl93qZxb8KLW+ot4iOOQ1QMDvk=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=jWATBpIRNp/PmHfDO1PLpFcdyBrMoGHff4tvVgOGCmLv+DXVR3fOpniZznliaQW0L
 BdKnjAVBRVo/tUHw5YgAuokJakwdCJtLAY1C0dNtNfmCYSHww1QQ6nf4XK2AXkyUVv
 9t6TRMmYKHyCgz/UEPNLPmJej9BRf4m7+uI5c5GwcI3wMFsj0PF71y9ZEt4ZhCLvw6
 1EnqZg0uahGntvcPbAMpDgH58GtZZdENWqXaNBO5NZyqlG7rfsr57uHMC4coFPjYJ8
 9ytRc29QXDO4XIGPpLWHfK3I4tB1PsJDQr8mefSCMdDBycQyGHW+Wu98VAkF/NyLkW
 PXAm8fxp2uquw==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: driver-api: virtio: virtio on Linux
References: <20220802124222.3563378-1-ricardo.canuelo@collabora.com>
 <YulJQKL22sB31lfU@casper.infradead.org>
In-reply-to: <YulJQKL22sB31lfU@casper.infradead.org>
Date: Wed, 03 Aug 2022 09:24:49 +0200
Message-ID: <87y1w5rdq6.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com,
 kernel@collabora.com, linux-doc@vger.kernel.org
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

Hi Matthew,

On mar, ago 02 2022 at 16:56:48, Matthew Wilcox <willy@infradead.org> wrote:
> You don't need to use :c:func:`foo`.  You can just write foo() and the
> tooling will convert it into :c:func:`foo` for you.

Thanks for the tip. However, I did some tests and the results aren't
quite the same. For functions with kerneldocs that are referenced in the
same document (.. kernel-doc::) the tool does efectively link to the
generated documentation, but for all the other functions using
c:func:`foo` generates a different formatting than `foo`, which does no
formatting at all.

I don't know if the extra semantic info can be used by the tooling in
any other way, in case it doesn't the fancy formatting might not be
worth it in exchange for a noisier source text, but I've seen it been
used in other driver-api docs.

Cheers,
Ricardo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
