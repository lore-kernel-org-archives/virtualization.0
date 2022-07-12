Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9163AC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 04:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16D3160B61;
	Tue, 12 Jul 2022 04:55:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16D3160B61
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZC5JfO8S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vrnl2j-CT3Ha; Tue, 12 Jul 2022 04:54:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C8C2C60B38;
	Tue, 12 Jul 2022 04:54:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8C2C60B38
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB8A7C0035;
	Tue, 12 Jul 2022 04:54:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E2E7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 04:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 428694026F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 04:54:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 428694026F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZC5JfO8S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Xni8G_jy6kv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 04:54:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FAE84011A
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FAE84011A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 04:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3VYduSz+eQuQXPuuoUvjegjrhY0HYGxE10ZrlJdoSFg=; b=ZC5JfO8S822g7pSSUkJxqafRAw
 OfjsRSFZmjTenePEGneBb6GMOM7c/+cyj6xa8jaAHtEu4ItbbJqIO4bheuPT9NU1KFfie+krVOpXf
 AqamETeiZVONwoLSVXgnbNlerkszkZE4UR2sBNmqUdwt/AQOp8+PHh2ZYEWUQYf8X3DyFfkPZ4++3
 Ol7YRbM9YffhRhXYa0W4aTjpoZNqJQsfq9CKR2zJABl/qR7aBU9K3Rrrk2bib2ljbUpnH2GRLZyHk
 iBAcIpODDDyWZ65SCYyaL/rZBPYNfJJ3MPQPruHwPe7zdRZADIDlMcjK/mxWBfNeoRWu2JsnsYEvT
 5idH4x7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oB7v3-007Y5W-ET; Tue, 12 Jul 2022 04:54:45 +0000
Date: Mon, 11 Jul 2022 21:54:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v10 0/8] Use copy_process in vhost layer
Message-ID: <Ysz+lXEkjlBXBC65@infradead.org>
References: <20220620011357.10646-1-michael.christie@oracle.com>
 <319f1e21-6cf4-4502-ebc8-c808560fb48d@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <319f1e21-6cf4-4502-ebc8-c808560fb48d@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: brauner@kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com
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

On Mon, Jul 11, 2022 at 11:44:14PM -0500, Mike Christie wrote:
> Eric and Christian, Ping?
> 
> If you guys don't like these patches anymore what about something
> simple like just exporting some helpers to update and check a task's
> nproc limit. Something like this:

I'm not Eric or Christian and don't really feel qualified on the
technical aspects here, but please drop the pointless externs while
you're at it :)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
