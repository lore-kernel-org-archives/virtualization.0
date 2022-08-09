Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235CCC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 13:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DDCE40895;
	Tue,  9 Aug 2022 13:05:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DDCE40895
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fScbxKCc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AYOQTSAXlGuv; Tue,  9 Aug 2022 13:05:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E61940643;
	Tue,  9 Aug 2022 13:05:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E61940643
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4403C0032;
	Tue,  9 Aug 2022 13:05:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 064E8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 13:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5B0560E3A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 13:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5B0560E3A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=fScbxKCc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5oNTfl9xpZZR
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 13:05:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B92D760E27
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B92D760E27
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 13:05:37 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id C0F396601B74;
 Tue,  9 Aug 2022 14:05:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1660050336;
 bh=HK0BOWSTH7SArfF741Tlu+HbhbXeozeCNYG03+glmmU=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=fScbxKCc1KL844qndBP7YKjxm2MyYvv4p1ENKlEFsYgibKoP5FdrWUZ1HOe2ULfMc
 bm0lGej1HKfeWw9oMPAUDw5U02WMLZ593MEawdxKk2i9Lqg352mzzsanPJr1jwDuPs
 BjFfrTst7zQdWrQuGJwq7BnvXulcqpCFTRKlC+d2A4bPQapMVtJqGFskAaqE4WLESA
 Pd8T1Gu3Cel52/dp/X6YncX5cNP6yAmmwJgCskZVs2f6cXXSQX0AXht6dp0aTpqchD
 le/O4t9SlZYKNTog2O4VdYjNFM2nx8iZvvW4za5SARLfCGn6vqaDVYRm/FZ02cF2H0
 EMNWd7ISfAOdA==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Cornelia Huck <cohuck@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] docs: driver-api: virtio: virtio on Linux
References: <20220804105914.3707389-1-ricardo.canuelo@collabora.com>
 <20220804105914.3707389-3-ricardo.canuelo@collabora.com>
 <87bksuetk5.fsf@redhat.com>
In-reply-to: <87bksuetk5.fsf@redhat.com>
Date: Tue, 09 Aug 2022 15:05:32 +0200
Message-ID: <87iln1r2hv.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
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

Hi Cornelia,

Thanks for the insightful comments and ideas. Answers below:

On lun, ago 08 2022 at 15:47:06, Cornelia Huck <cohuck@redhat.com> wrote:
> Hm... so I'm not quite happy with those two paragraphs, but I'm not sure
> how to make it better.
>
> - While the origins of virtio are hypervisor implementations, the
>   standard is describing the mechanisms of device <-> driver
>   communication, regardless whether the device is a hardware entity or
>   something emulated by a hypervisor.
> - I'm not quite sure what you are referring to with "real host
>   devices". We can have e.g. a real disk that is handed to a guest via
>   virtio-blk as a whole, or we can have some kind of file that is
>   exposed via virtio-blk. Other device types can also be completely
>   emulated.
> - The OS picks the driver depending on what device is discovers; virtio
>   device drivers are not any different from other device drivers in that
>   regard.
>
> So I think the key pieces of virtio are the following:
>
> - it is an open standard
> - it describes a protocol, which can be used to implement a lot of
>   different device types
> - those devices are exposed to the operating system via standard
>   mechanisms such as PCI
> - virtio devices can be implemented in various ways, such as in
>   hypervisors (more common) or as a real hardware device
>
> For the remainder of this document, it is probably fine to focus on the
> hypervisor use case.

How about this as an introduction?

    Virtio is an open standard that defines a protocol to communicate
    drivers and devices of different types, see Chapter 5 ("Device
    Types") of the virtio spec `[1]`_. Originally developed as a
    standard for paravirtualized devices implemented by a hypervisor, it
    can be used to interface any compliant device (real or emulated)
    with a driver.

    For illustrative purposes, this document will focus on the common
    case of a Linux kernel running in a virtual machine and using
    paravirtualized devices provided by the hypervisor, which exposes
    them as virtio devices via standard mechanisms such as PCI.

> s/in/on/ ?
> s/RedHat/Red Hat/ :)

Got it.

> See my comments above, virtio devices can also be fully emulated or real
> hardware devices.
>
> [...]
>
> I think we should not make any statement regarding frequency of new
> additions; sometimes, there's a flurry of activity, sometimes, there's
> nothing for ages :)

Ok, I'll simplify the intro to this:

    This document serves as a basic guideline for driver programmers
    that need to hack a new virtio driver or understand the essentials
    of the existing ones. See :ref:`Virtio on Linux <virtio>` for a
    general overview of virtio.

> s/should/needs to/ ?

Ack.

> s/defined/added/ ?

Ack.

> Maybe "Device ids need to be at least reserved in the virtio spec before
> being added to that file." ?

Sure, I'll add all of these to the next version.

Cheers,
Ricardo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
