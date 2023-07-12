Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01585EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 13:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E91082044;
	Wed, 12 Jul 2023 13:41:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E91082044
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ne4U33O6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J8GQRWrEOb4U; Wed, 12 Jul 2023 13:41:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 650338227C;
	Wed, 12 Jul 2023 13:41:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 650338227C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E3ACC0071;
	Wed, 12 Jul 2023 13:41:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6888C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 13:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9118C60A7D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 13:41:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9118C60A7D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ne4U33O6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yodz_ZUYJhgY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 13:41:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E25560A5E
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E25560A5E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jBtAqtTkPe7xSA8gIcOGPofAG5Ec6Godi3McG+Bj7TI=; b=ne4U33O6PpFN0GLvSBzWvdpMwS
 fqEB0JUvUajrnCGj0wimrRumDWvNjBni3q3H/klPnnmG4JXWtZNh2Y/Kr8ARlu6T6RA0Yo9YtWZmW
 VN5KR+qLiAlYcoVi3lgrmu+MPFVYCx1sUWGRxy9IytLpG/Q9I0LQkmPi6tAvlA5H9U2CkWaHcwM8f
 9xwHpByfBwJrELoXbx8GycAAGgOUrENgCNm4c5QZcx25O/liCF+a+4efNKt/9ndN5qMe8sUd9Pzr8
 9wCz4R6K1OrD+MGsu5s+hBG08OoMrhLMZrhPUZ2QGHJiE6d75hsds9crd8et3iAvcoi5+iwwNPmoT
 fWOo5qDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qJa4q-0005Yd-38; Wed, 12 Jul 2023 13:40:20 +0000
Date: Wed, 12 Jul 2023 06:40:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <ZK6tRDwxgbyYfv2v@infradead.org>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
 <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
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

On Wed, Jul 12, 2023 at 10:28:00AM +0200, Stefano Garzarella wrote:
> The problem is that the SCSI stack does not send this command, so we
> should do it in the driver. In fact we do it for
> VIRTIO_SCSI_EVT_RESET_RESCAN (hotplug), but not for
> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug).

No, you should absolutely no do it in the driver.  The fact that
virtio-scsi even tries to do some of its own LUN scanning is
problematic and should have never happened.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
