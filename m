Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB4C11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 08:03:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBC961C82
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 08:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBC961C82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4576B403F8;
	Wed, 30 Jun 2021 08:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0f_DdmwReRe; Wed, 30 Jun 2021 08:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D375B40184;
	Wed, 30 Jun 2021 08:03:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B461DC0010;
	Wed, 30 Jun 2021 08:03:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E504DC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C560A40236
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:03:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9E83WLtdBz9O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:03:31 +0000 (UTC)
X-Greylist: delayed 00:05:04 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 940564023E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:03:30 +0000 (UTC)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MJV9S-1lemPA0khc-00JqE3 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 09:58:24 +0200
Received: by mail-wr1-f54.google.com with SMTP id u8so2399739wrq.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 00:58:24 -0700 (PDT)
X-Gm-Message-State: AOAM531uC7kn6SgdufXYRl9ZQd3Lt9mFH2BE8JidljTWav2ekCV23e5Z
 Ds5EHWLrYDyx5dU8lq+qYodN3AtELxfOaNgN++4=
X-Google-Smtp-Source: ABdhPJw/54Ymafy8iJydjgPOOW+N/LuLT/C7tu8FRFKuPYFqT73YoCsIrQFVMpqbzhM8lXHUuzTJSikU14gArx6gH0Q=
X-Received: by 2002:adf:e107:: with SMTP id t7mr37559025wrz.165.1625039903884; 
 Wed, 30 Jun 2021 00:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato> <05cc9484-f97b-0533-64fe-ff917c6b87ee@intel.com>
 <YNwd/t3DMKSOrTAT@ninjato> <3016ab8b-cbff-1309-6a1f-080703a4130f@intel.com>
In-Reply-To: <3016ab8b-cbff-1309-6a1f-080703a4130f@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jun 2021 09:55:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Ew+RS_1buR+1OneH8XEqVjPOr0FGCF5d6CvFQuJqg6g@mail.gmail.com>
Message-ID: <CAK8P3a0Ew+RS_1buR+1OneH8XEqVjPOr0FGCF5d6CvFQuJqg6g@mail.gmail.com>
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>
X-Provags-ID: V03:K1:2n/ujLWJyooRmOUVbm7l7wtqf6L5RO6VD4eslR5nIoLab6SSG2P
 t5Re+iF8j/W8AEdx6pJg3VXQTY5x308tTuiYyt2zhhKTlwrPmZ3qTFDRvOJVvM31hmwCFsh
 sT9aF6HVA17k9ntUa25fdlAE5ak55pcqHcOLRRwf4Vlt/EmRHEjZmTjcycylbBVeXjz7owJ
 geuXWFRrlSqseBFEBe0Xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:odTpk39PlGs=:FYkvsYR5SjAK8wqLTlmzcY
 lJi/4U3ImnYO8Qkab3uEzMbCr/WKG0eXGlS81ajVHbcNzUW0oEvC1PmcawIiUs8FlOjllFPdf
 VWeFGF83stlRKt1p2RIF1cLf3MWJrrsqwxrEqg4kpgIFCfDd+KSacELlgyRWQcB3gmQtrBSm7
 iFyi8XdqOhE5pWX0VknsMN+AJFi1N55oC/WGfhV9r1s2MZuCcM2q1+oVMQ47My8A3BOBupzt3
 dKDFo2eLH4D7MnHyZE00iqWHzSAilY9eZYuBSvYHkuYAum1OPIpDo78Bbs6NWEv040SpIv8YX
 OPXAPoVex6ZMvoWq4+zVXg/j8nQft4xyQ336EkBQjtVku4VbmFj8b6eXcIylZT/feu8JiUYax
 n4JLA8r8UaKwbDnIVMZcwdv5eGn9vnbsxkILMBgWqWk1Y9DWX5G4M5QswlGTNxV58jbZle1Ml
 lVVA/2I7U5IkFKP7DJ/uuA3AvawraCBipRVE6nr8es9W1LVOYYZF6F/wg/9SCAWxvgKQNGQI2
 y92xpUYtOarP/6G7MAYEgIudSRpM3MV8kKw3512/xku2yKTkmkb98FceasY85KG/LtlhyKInQ
 D8hI2KIj5ac/Job7LiUktnnzJfhGF+olrMgEPXUE9GDr2hOA5U67PJsyW0TOp3//zfroBdOiy
 DGmk=
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, yu1.wang@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 shuo.a.liu@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>
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

On Wed, Jun 30, 2021 at 9:51 AM Jie Deng <jie.deng@intel.com> wrote:
> On 2021/6/30 15:32, Wolfram Sang wrote:
> >>>> +  snprintf(vi->adap.name, sizeof(vi->adap.name), "Virtio I2C Adapter");
> >>> Is there something to add so you can distinguish multiple instances?
> >>> Most people want that.
> >>
> >> I find the I2C core will set a device name "i2c-%d" for this purpose, right?
> >>
> >> I think this name can be used to distinguish the adapter types while
> >> "i2c-%d" can be used to
> >>
> >> distinguish instances. Does it make sense ?
> > That alone does not help. See the 'i2cdetect -l' output of my Renesas
> > board here:
> >
> > i2c-4 i2c             e66d8000.i2c                            I2C adapter
> > i2c-2 i2c             e6510000.i2c                            I2C adapter
> > i2c-7 i2c             e60b0000.i2c                            I2C adapter
> >
> > Notice that the third column carries the base address, so you know which
> > i2c-%d is which physical bus. I don't know if it makes sense in your
> > "virtual" case, but so far it would always print "Virtio I2C Adapter".
> > Maybe it makes sense to add some parent device name, too?
> >
> > And if this is not reasonable, just skip it. As I said, it can be
> > helpful at times, but it is definately not a show stopper.
>
>
> OK. I will add the virtio_device index for this purpose.
> which indicates the unique position on the virtio bus.

Is that position stable across kernel versions? We do have stable naming
for PCI devices and for platform devices that are the parent of a virtio
device, but I would expect the virtio device to be numbered in probe
order instead.

On a related note, we are apparently still missing the bit in the virtio bus
layer that fills in the dev->of_node pointer of the virtio device. Without
this, it is not actually possible to automatically probe i2c devices connected
to a virtio-i2c bus. The same problem came up again with the virtio-gpio
driver that suffers from the same issue.

       Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
