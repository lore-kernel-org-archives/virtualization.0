Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15837C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Oct 2022 08:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97A9660C08;
	Tue, 11 Oct 2022 08:46:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 97A9660C08
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=URDhMJ4h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E4s2ExpC3PHb; Tue, 11 Oct 2022 08:46:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 103C760ADA;
	Tue, 11 Oct 2022 08:46:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 103C760ADA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBEEEC0032;
	Tue, 11 Oct 2022 08:46:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11139C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 08:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D85684176F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 08:46:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D85684176F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=URDhMJ4h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hAeW2Gr9IkML
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 08:46:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 963EF41763
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 963EF41763
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 08:46:49 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 21EC46602356;
 Tue, 11 Oct 2022 09:46:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1665478007;
 bh=3KO2HxBlF5JKCuTvKYUlgaA7kmIP/w4NQL7SdgZeWn8=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=URDhMJ4hgoFFH+EH5GWdVkyApc7nk61sGZo2ToDTUxGX1IGyCM3RjUjIh1npMsuox
 CLGgZ8vByqmogluBZXWY3d9QeIBPoGOEqgLBiHMMeEXxpiVCC0fxPYutLp/oCMKZ1l
 EVa01FEe8IVs/LxzXC29hoI4iP/dJhnCElPqDRYlFaOIH34qPp5Boz8osAcsPw0+9r
 ZWwxzMFNHDvIqPWHlt0bzHZg/7I4sQsEP0BwIPAq3+7WZ1ZKw5/IFZdbwxMRMctA+d
 IxBBL2ehoPVuwtym1x7omt34VnP4U0FHOcqWuo2uSoy5EOVePHGnRE8tpJjvSQTTGm
 yGYb4FMTdbnFA==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [RESEND PATCH v5 1/1] docs: driver-api: virtio: virtio on Linux
References: <20221010064359.1324353-1-ricardo.canuelo@collabora.com>
 <20221010064359.1324353-2-ricardo.canuelo@collabora.com>
 <Y0QYTq7KW9C731s0@debian.me>
In-reply-to: <Y0QYTq7KW9C731s0@debian.me>
Date: Tue, 11 Oct 2022 10:46:43 +0200
Message-ID: <87v8oqsq6k.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Cc: corbet@lwn.net, cohuck@redhat.com, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mst@redhat.com,
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

Hi Bagas, thanks for the review, some comments below:

On lun, oct 10 2022 at 20:04:14, Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> What link is for [2]? I think you'll need to spell out the link title.
> Also, the external reference pointers should be parenthesized to indicate
> that these are references:

That's a matter of personal opinion and I disagree with it. There's no
consensus across the kernel docs and I'm using the IEEE style, which is
fairly standard.


>  The :c:type:`vring_virtqueue` struct models a virtqueue, including the
>  ring buffers and management data. Embedded in this struct is the
>
>
> Personally speaking, ReST citations should do the job better (these
> links are external references, right?).

I don't want to use a full ReST code reference for that, as that struct
is not really part of the interface for virtio drivers and its
definition is an implementation detail. But I still want to have it
properly formatted in the html and pdf outputs, that's why I'm using
:c:type: there.


>> +It's at this stage that the virtqueues will be allocated and configured
>> +by calling the appropriate ``virtio_find`` helper function, such as
>> +virtio_find_single_vq() or virtio_find_vqs(), which will end up
>> +calling a transport-specific ``find_vqs`` method.
>> +
>
> Looks like the wording at the beginning confuses me, so better say:
>
> ---- >8 ----
> diff --git a/Documentation/driver-api/virtio/virtio.rst b/Documentation/driver-api/virtio/virtio.rst
> index 07fd2d7c51e689..7947b4ca690efd 100644
> --- a/Documentation/driver-api/virtio/virtio.rst
> +++ b/Documentation/driver-api/virtio/virtio.rst
> @@ -123,10 +123,10 @@ When the device is registered to the virtio bus the kernel will look
>  for a driver in the bus that can handle the device and call that
>  driver's ``probe`` method.

I think this is a matter of style as well, maybe a native speaker can
pitch in about the correctness of it.

Cheers,
Ricardo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
