Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26C4C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 09:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BC0A60E2A;
	Wed, 24 Aug 2022 09:07:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BC0A60E2A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ba6iy+YF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wkzyui3_x5p0; Wed, 24 Aug 2022 09:07:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B6A6460AE1;
	Wed, 24 Aug 2022 09:07:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6A6460AE1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EBBFC0032;
	Wed, 24 Aug 2022 09:07:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33FCBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AAA4404C7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:07:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AAA4404C7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ba6iy+YF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wgl4LeHJ5ZNE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:07:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3268940160
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3268940160
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661332032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/JzssnGttwpqrEOC5Mfeay20ERodByCgjFHjKANeqxY=;
 b=Ba6iy+YFtNt8rvj6KZoD5U34vHGEc7Rjqm0KbFtsJ/ISt/nrpjAe96evl43kbe/0maYhC1
 jcwBEeQBkdAraXITXjU91KyZi9P4W9ft3elOxJ72qDUp57I9d/HpotcsvruO4kXvqNAr16
 T8UFvVJUNofLkDzvqJ1VeYCKImC1xFs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-IYpqrp1GN3KJ_dCyZJ4DOw-1; Wed, 24 Aug 2022 05:07:11 -0400
X-MC-Unique: IYpqrp1GN3KJ_dCyZJ4DOw-1
Received: by mail-lj1-f199.google.com with SMTP id
 f10-20020a2ea0ca000000b00261cd1f1f60so1388546ljm.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 02:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=/JzssnGttwpqrEOC5Mfeay20ERodByCgjFHjKANeqxY=;
 b=behWkBiiLi6wGcSS0TsUzHHRmORzfHrnD+39lZT5+hGYoIcqzUO71xheNaSk+szdbB
 scrZTqh8KjowOVdzpvqgtTVFeBPFsRz1ME5YSTfewWiajJhG4b/2YrbX/2NoZSEiCDX5
 3D+yF2YtdK8SLwOaMLeEy2zQDTzvpuGX4nv2YY8Iw4aOPlxwBOLJFOyaRpvKLFYXqvKL
 Sq56ecomDNEycxOEycCFBxGAthyha3DdwIl4+vxQRdY4fsmyeEtGitfH9nhQK6FFrJOp
 LiFNml8coOck7TEPOarop7cpZHQrjdKxvL0OOQSf6kt2E6gwNBRkf/X7o/gbJQfvM0ZY
 af/w==
X-Gm-Message-State: ACgBeo32WCNj0yMRqaqtnjSKiWg/MZ2e1voGuZ2AEiUz/wPhnWQO3cOS
 g7XICovBWOSNhablDWZfcwHCJHf4ov3bACNQ88/GysalnPSuCq4Fd83jViROXWDGlnLMIhAWJbO
 zX7t+dnufoS1W50veYOlaKtgwRbKQI+baUH5Un9BYpcMRJp634X63EnlDHg==
X-Received: by 2002:a05:6512:15a4:b0:492:e3b4:7a with SMTP id
 bp36-20020a05651215a400b00492e3b4007amr4621397lfb.411.1661332030220; 
 Wed, 24 Aug 2022 02:07:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7aWppEC53s/J1GO+6qRIH/FrMV8a6GO7Q5oI+7QRXdLjNfyqZClZVZMw9pkMmK0Te4V8ErkagX4D21d44uoRE=
X-Received: by 2002:a05:6512:15a4:b0:492:e3b4:7a with SMTP id
 bp36-20020a05651215a400b00492e3b4007amr4621391lfb.411.1661332029956; Wed, 24
 Aug 2022 02:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
In-Reply-To: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Aug 2022 17:06:58 +0800
Message-ID: <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
Subject: Re: Virtio-net - add timeouts to control commands
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Wed, Aug 24, 2022 at 3:52 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> I think that we should add a timeout to the control virtqueue commands.
> If the hypervisor crashes while handling a control command, the guest
> will spin forever.
> This may not be necessary for a virtual environment, when both the
> hypervisor and the guest OS run in the same bare metal, but this
> is needed for a physical network device compatible with VirtIO.
>
> (In these cases, the network device acts as the hypervisor, and the
> server acts as
> the guest OS).
>
> The network device may fail to answer a control command, or may crash, leading
> to a stall in the server.
>
> My idea is to add a big enough timeout, to allow the slow devices to
> complete the command.
>
> I wrote a simple patch that returns false from virtnet_send_command in
> case of timeouts.
>
> The timeout approach introduces some serious problems in cases when
> the network device does answer the control command, but after the
> timeout.
>
> * The device will think that the command succeeded, while the server won't.
>    This may be serious with the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command.
>    The server may receive packets in an unexpected queue.
>
> * virtqueue_get_buf will return the previous response for the next
> control command.
>
> Addressing this case by adding a timeout  to the spec won't be easy,
> since the network device and the server have different clocks, and the
> server won't know when exactly the network device noticed the kick.
>
> So maybe we should call virtnet_remove if we reach a timeout.

Or reset but can we simply use interrupt instead of the busy waiting?

Thanks

>
> Or maybe we can just assume that the network device crashed after a
> long timeout, and nothing should be done.
>
> What do you guys think?
>
> Alvaro
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
