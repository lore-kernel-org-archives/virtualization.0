Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8196EC32796
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 09:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09EE780F16;
	Wed, 24 Aug 2022 09:43:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09EE780F16
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=dMe2Wb8z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXz_YepqfsYK; Wed, 24 Aug 2022 09:43:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A72A8139B;
	Wed, 24 Aug 2022 09:43:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A72A8139B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F319C0032;
	Wed, 24 Aug 2022 09:43:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30093C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2C0E8139B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:43:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2C0E8139B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JQP3eJU7Cll6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:43:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD1EC81397
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD1EC81397
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:43:28 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id q63so311419pga.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=XWeclXyitpRwhvwK4pjPy6mQN7N6nAEKqi+NnMqcPrg=;
 b=dMe2Wb8z4CxtBWJ/5vvEnv2watWjknN3QIo5LYDWlYQYMn3QJbOD7LbPe6yYbcEK2z
 1gRuGDaJaOgd4Ga1nnGpihxAJl3ig4fEfD/VjDlPAd/l7KZDanQRH4OllgnVd/1ffPOg
 ND7I/qmzy+n7hevHMaUd/sTkgZq/nezKDkVprCDSGmqIww/vtEiQPTXaipzAmPjiiFR1
 uw7IqGO9OwvI3ZSHa/Qgal/Y3EEmZTVqYUYVBQKjzSXmyng3yOiFkMDpeBncb0+iLasw
 7PpAYeTvnR1pzKxCGh56Ec8aGMgAvoXut9+wY5id1JcURDAwLVDy38PdgnRODr2ZFjci
 5ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=XWeclXyitpRwhvwK4pjPy6mQN7N6nAEKqi+NnMqcPrg=;
 b=fP48HQgAgeOwqxyBhLxZOhYymTr80XklZakbnUyy4oZ3TzNK/MQ+aLFC6glOG0MX0T
 09RWoYAvDBnBgFuytSLHyPN3/55pvTV2npk53VxW3iakJXF/s8r5IM6WDgz5k8Z0dh1y
 T94CBBDnVb2qLMa8jovXVSAn7QBb/T5jSLt6K4pCl+slNRT9veYfErhQN5ws8rn00Qc+
 eSf6KgCIbJL/piFZoijTHi2Vjdn4IRc3YoG4YK4KSwJhoeLhnzgaR5HXo01F+IeoqNwR
 /q9GR099pKOWTuNcELCL2ykN5mf0yJCChX25VeoBHyKNH44kaA8IzgmlVHRFavLkpW83
 +Lxw==
X-Gm-Message-State: ACgBeo3xk70ceLHUWKXgk5uufTPngccPPXwUy/Q8QdNu3VILCATg2ra/
 GXY+2jmeMibH0Ld/+TLOHlQg8Utv1HdDykQqPPhJkA==
X-Google-Smtp-Source: AA6agR4bEnrQMis06dgNydG28g7G7UYGlg1MWcW+7Y18aeEK5tgOzvE1xmHD5ycbY98e7Nry4ocYNTlBs8OaqNSsYok=
X-Received: by 2002:a63:6804:0:b0:422:1689:ed05 with SMTP id
 d4-20020a636804000000b004221689ed05mr23148290pgc.289.1661334208119; Wed, 24
 Aug 2022 02:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
 <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
 <2ff3d36b-f044-71cc-8001-d7f4073282c1@suse.de>
In-Reply-To: <2ff3d36b-f044-71cc-8001-d7f4073282c1@suse.de>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 24 Aug 2022 12:42:52 +0300
Message-ID: <CAJs=3_AUiaDtyRTMcDd_DGuiKZVKuMUSZRUosQa7wU=5UZwtqw@mail.gmail.com>
Subject: Re: Virtio-net - add timeouts to control commands
To: Hannes Reinecke <hare@suse.de>
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Hi Hannes,

> a) let the device do the timeout: pass in a timeout value with the
> command, and allow the device to return an ETIMEDOUT error when the
> timeout expires. Then it's up to the device to do the necessary timeout
> handling; the server won't be involved at all (except for handling an
> ETIMEDOUT error)


This won't work if the device crashes.

>
> b) implement an 'abort' command. With that the server controls the
> timeout, and is allowed to send an 'abort' command when the timeout
> expires. That requires the device to be able to abort commands (which
> not all devices are able to), but avoids having to implement a timeout
> handling in the device.


I actually thought about this idea.
This may work, but you'll still have a few moments when the server
assumes that the command failed, and the network device assumes that
it succeeded.
So the server may still receive packets in an unexpected queue.


>
> I am very much in favour of having timeouts for virtio commands; we've
> had several massive customer escalations which could have been solved if
> we were able to set the command timeout in the VM.
> As this was for virtio-scsi/virtio-block I would advocate to have a
> generic virtio command timeout, not a protocol-specific one.

This may be difficult to implement.
Especially when multiple commands may be queued at the same time, and
the device can handle the commands in any order.
We'll need to add identifiers for every command.

I'm actually referring here to the Linux kernel implementation of
virtnet control commands, in which the server spins for a response.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
