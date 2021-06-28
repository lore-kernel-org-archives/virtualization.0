Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE23C2B9F4
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 09:09:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D000A6144D
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 09:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D000A6144D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94FB4831F2;
	Mon, 28 Jun 2021 09:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aBNGm6L5PTeJ; Mon, 28 Jun 2021 09:09:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 23B3D83192;
	Mon, 28 Jun 2021 09:09:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7F9EC001A;
	Mon, 28 Jun 2021 09:09:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B348C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 09:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2849040381
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 09:09:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yVAJ1o7hTATX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 09:09:19 +0000 (UTC)
X-Greylist: delayed 00:05:04 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6536640377
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 09:09:19 +0000 (UTC)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MrQN5-1lUFwJ2RM7-00oXKh for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 11:04:12 +0200
Received: by mail-wr1-f51.google.com with SMTP id j1so20252442wrn.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 02:04:12 -0700 (PDT)
X-Gm-Message-State: AOAM5333U0rY1nJA9mECcz9krbB8pkUHKedfYfN2mPAcBW/Kk0Xv13ja
 VYapU8EBrJWjkiH7n2FCSBM3ScKQ5ZU6anv3z8Y=
X-Google-Smtp-Source: ABdhPJyRl7QSXH5sB8nExkanlgljChSQUCIUP+JWsaWbuQfEbjisBPDii/DpjNvzI3LCvLAYvpEUSYGhq9xCpMZ1Phw=
X-Received: by 2002:adf:e107:: with SMTP id t7mr25246408wrz.165.1624871051873; 
 Mon, 28 Jun 2021 02:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
In-Reply-To: <YNmK0MP5ffQpiipt@ninjato>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 Jun 2021 11:01:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
Message-ID: <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>, 
 Linux I2C <linux-i2c@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 conghui.chen@intel.com, Arnd Bergmann <arnd@arndb.de>, kblaiech@mellanox.com, 
 jarkko.nikula@linux.intel.com, 
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Mike Rapoport <rppt@kernel.org>, 
 loic.poulain@linaro.org, Tali Perry <tali.perry1@gmail.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Bjorn Andersson <bjorn.andersson@linaro.org>, yu1.wang@intel.com,
 shuo.a.liu@intel.com, 
 Viresh Kumar <viresh.kumar@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Provags-ID: V03:K1:p7YbbMVPDasxsn9JFFbf7qSeuND5I6Jf6tySskPYhbzmSuoZ8/l
 dbAa/f7ofGlBrAuWaNmUWZQZvVI8Ga0K62SYLw1FvtAx6UNIBt7I66zykpgWUlItoIt+NU7
 o2/rY6es09WODRO20lh3uIh/0+84bOQT/SDZy2beh4X64JfApP8dfBI57OB1B2pMNyeSwYi
 VrWYNXcHeUim5WSkw9ssg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DSQ8cgOzY0g=:dr0N765NEr4YheVxsoOrA8
 N6my/TpkN2eEVTuUf4r4IDaDqbn8fvk2+Y07M4n1loQnshe9Kflc8//rFbR0Jx6M5/bCYUJ5J
 7ZEQtrbXtoavDLfLaaHMotkIAaKS/Q8RY+pYvTjwJpwYo83wO8kv/clgdblybyph/NvrTw9bb
 YPZq/sDTtqV4dAxqIxjJxZVVcOiDDL4/kIeA4yCkWDl0w75Br9LUk5vevjnTz3GX6FG7eam4m
 Jqj+FpWmWMBwIiQmWtjuUpYjajdctQRmuvXh1rCElg/2Tv+8RWtJ0Yo/Q4cKyJPVmJZOuH1BK
 qu9gFA6lJuiJcOt491NR1WfI0g0uPE6N6c4RoQn7s1A/Aj58t5MNOtrUZ53mdrP+mYdJ5Hr8Z
 em1NVOnJ/QINoxnaOuqFTvnmaINuizpQwKKWTCBOzPwBf08T33CdRsy/SFnnrdjBIsYL2ug/E
 1TFj6a2sCJMhUzL2RIM1vE/gOM4lSy+GJCrk4DcRolbDpC0B8djjypXu/2euMyUTb3t9CjqeK
 dATMxLK3HVVz1SGvuGEJU8=
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

On Mon, Jun 28, 2021 at 10:39 AM Wolfram Sang <wsa@kernel.org> wrote:
>
> sorry for the long delay. I am not familiar with VFIO, so I had to dive
> into the topic a little first. I am still not seeing through it
> completely, so I have very high-level questions first.

You probably know this already, but just in case for clarification
these are two different things:

VFIO: kernel feature to make raw (usually PCI) devices available
           to user space drivers and virtual machines from a kernel
           running on bare metal.

virtio: transport protocol for implementing arbitrary paravirtualized
          drivers in (usually) a virtual machine guest without giving the
          guest access to hardware registers.

Both can be used for letting a KVM guest talk to the outside world,
but usually you have one or the other, not both.

> > The device specification can be found on
> > https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.
>
> I think we need to start here:
>
> ===
>
> If ``length of \field{read_buf}''=0 and ``length of \field{write_buf}''>0,
> the request is called write request.
>
> If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''=0,
> the request is called read request.
>
> If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''>0,
> the request is called write-read request. It means an I2C write segment followed
> by a read segment. Usually, the write segment provides the number of an I2C
> controlled device register to be read.
>
> ===
>
> I2C transactions can have an arbitrary number of messages which can
> arbitrarily be read or write. As I understand the above, only one read,
> write or read-write transaction is supported. If that is the case, it
> would be not very much I2C but more SMBus. If my assumptions are true,
> we first need to decide if you want to go the I2C way or SMBus subset.

This has come up in previous reviews already. I think it comes down
to the requirement that the virtio i2c protocol should allow passthrough
access to any client devices connected to a physical i2c bus on the host,
and this should ideally be independent of whether the host driver
exposes I2C_RDWR or I2C_SMBUS ioctl interface, or both.

This can be done either by having both interface types in the transport,
or picking one of the two, and translating to the host interface type
in software.

As far as I understand me (please clarify), implementing only the smbus
subset would mean that we cannot communicate with all client devices,
while implementing both would add more complexity than the lower-level
protocol.

> ===
>
> The case when ``length of \field{write_buf}''=0, and at the same time,
> ``length of \field{read_buf}''=0 doesn't make any sense.
>
> ===
>
> Oh, it does. That's a legal transfer, both in SMBus and I2C. It is used
> to e.g. discover devices. I think it should be supported, even though
> not all bus master drivers on the host can support it. Is it possible?
>
> Also, as I read it, a whole bus is para-virtualized to the guest, or?
> Wouldn't it be better to allow just specific devices on a bus? Again, I
> am kinda new to this, so I may have overlooked things.

Do you mean just allowing a single device per bus (as opposed to
having multiple devices as on a real bus), or just allowing
a particular set of client devices that can be identified using
virtio specific configuration (as opposed to relying on device
tree or similar for probing). Both of these are valid questions that
have been discussed before, but that could be revisited.

          Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
