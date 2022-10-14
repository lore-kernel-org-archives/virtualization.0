Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98053C433FE
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 14:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1955641D24;
	Fri, 14 Oct 2022 14:02:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1955641D24
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=S9xOMx/O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NxAR72_qhXsK; Fri, 14 Oct 2022 14:02:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 392CA41D1D;
	Fri, 14 Oct 2022 14:02:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 392CA41D1D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 181C8C0033;
	Fri, 14 Oct 2022 14:02:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5274C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 14:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A940D60BCE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 14:02:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A940D60BCE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net
 header.a=rsa-sha256 header.s=20201203 header.b=S9xOMx/O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lmf_Y-CKc60e
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 14:02:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AEC460AF0
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AEC460AF0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 14:02:00 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 6F09E35D;
 Fri, 14 Oct 2022 14:01:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6F09E35D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1665756119; bh=gbZzFGi0DSyuETMCUk6reDBoaJz8+cLXjDxO5eRHjvE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=S9xOMx/OZvcRHXLRWB1Ul+0vAzTIoES49Je91LcmW/7V7XADM88FjzNKdj+1zQzcB
 /vUe2kJ+uiDkm0fF/6p0nZsNNnlSckeKEwJMI1oo1zhluZjZOxpfeXAPNVDg8rLHDS
 T7NvFZZbSAcfEqYQi6ltrM24GmE55c3F76/azxznkBvJj7IajG7WWWlBHlrrVdJehl
 /poKARtHRY0QaqmD9vnJPV60iQWhf6gZ2wjCt+067cYj2eLVlp+SIf8SIbibtYuUSj
 velU80CDYX2N4GZy142jeOWgl0gqVxwVzH0X5TCo/JFQTALaWH6RzQTCDikstqhimK
 PVlZsleK+ZY3g==
From: Jonathan Corbet <corbet@lwn.net>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, jasowang@redhat.com
Subject: Re: [RFC PATCH] virtio: document virtio hardening status and TODO
In-Reply-To: <20221014042037.23639-1-jasowang@redhat.com>
References: <20221014042037.23639-1-jasowang@redhat.com>
Date: Fri, 14 Oct 2022 08:01:58 -0600
Message-ID: <87o7ueh5bd.fsf@meer.lwn.net>
MIME-Version: 1.0
Cc: otubo@redhat.com, liuwe@microsoft.com, linux-doc@vger.kernel.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, mikelley@microsoft.com,
 andavis@redhat.com, stefanha@redhat.com, kkashanjat@microsoft.com,
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

Jason Wang <jasowang@redhat.com> writes:

> This patch summarizes the status of hardening and TODO of hardening
> virtio core and drivers.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  Documentation/security/virtio/core.rst | 49 ++++++++++++++++++++++++++
>  MAINTAINERS                            |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/security/virtio/core.rst

Do you really need to create a new directory for a single file?

Regardless of where it sits, you'll need to add this file to an
index.rst file so that it becomes part of the docs build.

Thanks,

jon
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
