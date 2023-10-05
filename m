Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DDEE7C4F7
	for <virtualization@archiver.kernel.org>; Thu,  5 Oct 2023 08:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2BDF6F58E;
	Thu,  5 Oct 2023 08:50:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2BDF6F58E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4xlxmplR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NaO574UKseR2; Thu,  5 Oct 2023 08:50:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 11A8960F47;
	Thu,  5 Oct 2023 08:50:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11A8960F47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2B51C0071;
	Thu,  5 Oct 2023 08:50:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E0DBC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 08:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E651F60F07
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 08:50:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E651F60F07
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S3Uoh6W6kt4h
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 08:50:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8CD560F20
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 08:50:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8CD560F20
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=uOgNX4AIC95ru5JSWRIRe9migKJKaA2qFd+sCFdwwS4=; b=4xlxmplRYCRqZYyHp0fVtta/rK
 gorf9RgXPaSK17QGfavJ1lBSl7JT9e47DGdcRtpu17mgAUhA0f5RGzpBPveErz8dAaSbs+PTHslWP
 DwbYiivx97bpSJvcWtwSnS8fC7Osy7CFu/0lPyieWYgd/y8hnedk0p/uYaZiEZPXD1Ta/YbJICLDG
 k23WI6SmCUTIWrILBwvK5D8VLC0QIqh4mZUoSrCYzKXjxKSaua4PFZhoovS2y5kjCbmIMeUA9u+Ak
 wx7uRk7aa5bch6+7pK1qS46pheInL7Jb9UfyaQWpujISBGf/Apg5z1x8mssBS3ja2hzDy0ZDUkTaI
 naRWeAQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qoK3O-001iHp-0H; Thu, 05 Oct 2023 08:49:54 +0000
Date: Thu, 5 Oct 2023 01:49:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <ZR54shUxqgfIjg/p@infradead.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-11-yishaih@nvidia.com>
 <20230922055336-mutt-send-email-mst@kernel.org>
 <c3724e2f-7938-abf7-6aea-02bfb3881151@nvidia.com>
 <20230926072538-mutt-send-email-mst@kernel.org>
 <ZRpjClKM5mwY2NI0@infradead.org>
 <20231002151320.GA650762@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231002151320.GA650762@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 maorg@nvidia.com, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, jiri@nvidia.com, leonro@nvidia.com
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

On Mon, Oct 02, 2023 at 12:13:20PM -0300, Jason Gunthorpe wrote:
> ??? This patch series is an implementation of changes that OASIS
> approved.

I think you are fundamentally missing my point.  This is not about
who publish a spec, but how we struture Linux code.

And the problem is that we trea vfio as a separate thing, and not an
integral part of the driver.  vfio being separate totally makes sense
for the original purpose of vfio, that is a a no-op passthrough of
a device to userspace.

But for all the augmented vfio use cases it doesn't, for them the
augmented vfio functionality is an integral part of the core driver.
That is true for nvme, virtio and I'd argue mlx5 as well.

So we need to stop registering separate pci_drivers for this kind
of functionality, and instead have an interface to the driver to
switch to certain functionalities.

E.g. for this case there should be no new vfio-virtio device, but
instead you should be able to switch the virtio device to an
fake-legacy vfio mode.

Assuming the whole thing actually makes sense, as the use case seems
a bit fishy to start with, but I'll leave that argument to the virtio
maintainers.

Similarly for nvme.  We'll never accept a separate nvme-live migration
vfio driver.  This functionality needs to be part of the nvme driver,
probed there and fully controlled there.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
