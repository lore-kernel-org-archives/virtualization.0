Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF334C25B0C
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 14:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 624A08133C;
	Thu, 11 Aug 2022 14:54:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 624A08133C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DTEX8Uy/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CN1nv0wzOY0o; Thu, 11 Aug 2022 14:54:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF24381337;
	Thu, 11 Aug 2022 14:54:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF24381337
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C80BC0033;
	Thu, 11 Aug 2022 14:54:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50F76C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 14:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 189AE40CB7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 14:54:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 189AE40CB7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=DTEX8Uy/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BV-V4axLzkhD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 14:54:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3DCA40289
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3DCA40289
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 14:54:18 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 58DC46601C3A;
 Thu, 11 Aug 2022 15:54:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1660229656;
 bh=lLmXmVZBOGq4chrF+Bwz2F2fOlRJ18rg5yKltE5Yy9w=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=DTEX8Uy/bGax52/BP3R+ACOjxNwPfDlWS/dgZ4tAKB/zMg94D0CBVkxQGArLW2ntg
 oWPQ+aL2AZynttvYR/ct/GF1b+LmTE7WM5xnWKbuLhNlLadD4LXBS9pBbQl4B2bbym
 Cqw3xS3m1s3yhFgOnP1KY1XP19zKl8yQ3uCqFvJyPRU31j6SovG8Iyxh1svA4tlcVL
 ZmIkSv5X4sL6KeYlI1EgnVo5E9eazw5CCDU+M6bgCRH40NnoANGNYK9vo2cYwIMeYI
 L6Acvrh048ngw2VwHU5yA4u8aXyDI9hWpENF4yv7VQsj0DVdGyHyTgsaAOvWZEHeYc
 XWw/TS/lFT39g==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 2/2] docs: driver-api: virtio: virtio on Linux
References: <20220810094004.1250-1-ricardo.canuelo@collabora.com>
 <20220810094004.1250-3-ricardo.canuelo@collabora.com>
 <20220811092436-mutt-send-email-mst@kernel.org>
In-reply-to: <20220811092436-mutt-send-email-mst@kernel.org>
Date: Thu, 11 Aug 2022 16:54:13 +0200
Message-ID: <87czd6rfu2.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Cc: linux-doc@vger.kernel.org, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, bagasdotme@gmail.com,
 kernel@collabora.com
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

Hi Michael, thanks for reviewing:

On jue, ago 11 2022 at 09:32:05, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> which tree is this for?
>
> Applying: docs: driver-api: virtio: virtio on Linux
> error: sha1 information is lacking or useless (MAINTAINERS).
> error: could not build fake ancestor
> Patch failed at 0001 docs: driver-api: virtio: virtio on Linux

linux-next, as stated in the cover letter:

    Tested on linux-next (next-20220802)

I just verified that the patch also applies to the vhost tree
(linux-next branch). Where did you test it?

>> +		buf = virtqueue_get_buf(dev->vq, &len);
>> +		/* spurious callback? */
>> +		if (!buf)
>> +			return;
>
> most drivers need to do this in a loop, this code is only valid if
> there's just 1 buf in flight - unusual.

That's a driver-specific consideration and this is supposed to be the
simplest possible driver skeleton, but ok.

>> +	static int virtio_dummy_probe(struct virtio_device *vdev)
>> +	{
>> +		struct virtio_dummy_dev *dev = NULL;
>> +
>> +		/* initialize device data */
>> +		dev = kzalloc(sizeof(struct virtio_dummy_dev), GFP_KERNEL);
>
>
> I dislike how we set dev to NULL and immediately to a different value
> just below.

This is a matter of style, I think. There are plenty of examples of this
in the kernel code, but I don't mind changing it.


> what is missing here is registration with Linux core.

Isn't that supposed to be done by module_virtio_driver()?


> depending on device you might need a call to device_ready, too.

I already explained below that this is done by default after probe()
(see virtio_dev_probe()). virtio_device_ready() is supposed to be useful
only if you need to use the vqs in the probe function.

>> +		/*
>> +		 * Disable vq interrupts: equivalent to
>> +		 * vdev->config->reset(vdev)
>> +		 */
>> +		virtio_reset_device(vdev);
>> +
>
> you highly likely need to detach unused buffers from vqs here.

Ack.

> let's be a bit clearer here that they must be enabled before add_buf
> triggers.

Ok.

> maybe clarify that they can still trigger even if enabled.
> if you want to disable reliable you have to reset the device
> or the vq.

I'll check that out, thanks.

Cheers,
Ricardo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
