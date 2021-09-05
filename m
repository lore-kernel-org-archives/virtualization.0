Return-Path: <SRS0=SKE2=N3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC2AC433F5
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 10:19:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017B960FBF
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 10:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 017B960FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C207D400E4;
	Sun,  5 Sep 2021 10:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKhIdeLmUJdp; Sun,  5 Sep 2021 10:19:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 361F5400C9;
	Sun,  5 Sep 2021 10:19:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0960FC0010;
	Sun,  5 Sep 2021 10:19:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0C33C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 10:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C93880D15
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 10:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63uN8FpJ_TeY
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 10:19:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E34B80D02
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 10:19:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFD6460F6D;
 Sun,  5 Sep 2021 10:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630837162;
 bh=/Jh57FDF7CrbtrzmZhhQAoJJIYs9XIm6zMIp6uc03I4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LGOkSlYsfjfYCzvNWDsAXLFUTw4MXHcAbPPJaSS6T+C/zPFCmoGDJH4FSADcHgtN2
 jdLnZ1ZQmAUbB7IzaPrncqKD63Rzdy38Otwwlll5450iVoie0mONxCasnXVvqAbPZJ
 6wUvZCNOruamFIzSxZ8w6SMJtUM0HWNW6NjlfcDSuJAYryyutEq9sKZ6lVpeqQ5jTM
 0the62IXiYWnm7XKKsPeZIUoDH+JYhVig8h+MotCgRGTE01Fh/gAcGXTEMCURvgyCE
 Am+FNJdz/WZd6CZaDXhs7Rx+995i+f5hVXxDDNkKJaviTTGvUdrPQg9kuMn0wY+XDa
 Cpgts6xLPHsCA==
Date: Sun, 5 Sep 2021 13:19:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: add num_request_queues module parameter
Message-ID: <YTSZpm1GZGT4BUDR@unreal>
References: <20210902204622.54354-1-mgurtovoy@nvidia.com>
 <YTR12AHOGs1nhfz1@unreal>
 <b2e60035-2e63-3162-6222-d8c862526a28@gmail.com>
 <e4455133-ac9f-44d0-a07d-be55b336ebcc@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e4455133-ac9f-44d0-a07d-be55b336ebcc@nvidia.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 mst@redhat.com, israelr@nvidia.com, nitzanc@nvidia.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, stefanha@redhat.com,
 oren@nvidia.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Sep 05, 2021 at 12:19:09PM +0300, Max Gurtovoy wrote:
> =

> On 9/5/2021 11:49 AM, Chaitanya Kulkarni wrote:
> > =

> > On 9/5/2021 12:46 AM, Leon Romanovsky wrote:
> > > > +static unsigned int num_request_queues;
> > > > +module_param_cb(num_request_queues, &queue_count_ops,
> > > > &num_request_queues,
> > > > +=A0=A0=A0=A0=A0=A0=A0 0644);
> > > > +MODULE_PARM_DESC(num_request_queues,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 "Number of request queues to use for blk =
device.
> > > > Should > 0");
> > > > +
> > > Won't it limit all virtio block devices to the same limit?
> > > =

> > > It is very common to see multiple virtio-blk devices on the same syst=
em
> > > and they probably need different limits.
> > > =

> > > Thanks
> > =

> > =

> > Without looking into the code, that can be done adding a configfs
> > =

> > interface and overriding a global value (module param) when it is set
> > from
> > =

> > configfs.
> > =

> > =

> You have many ways to overcome this issue.
> =

> For example:
> =

> # ls -l /sys/block/vda/mq/
> drwxr-xr-x 18 root root 0 Sep=A0 5 12:14 0
> drwxr-xr-x 18 root root 0 Sep=A0 5 12:14 1
> drwxr-xr-x 18 root root 0 Sep=A0 5 12:14 2
> drwxr-xr-x 18 root root 0 Sep=A0 5 12:14 3
> =

> # echo virtio0 > /sys/bus/virtio/drivers/virtio_blk/unbind
> =

> # echo 8 > /sys/module/virtio_blk/parameters/num_request_queues

This is global to all virtio-blk devices.

> =

> # echo virtio0 > /sys/bus/virtio/drivers/virtio_blk/bind
> =

> # ls -l /sys/block/vda/mq/
> drwxr-xr-x 10 root root 0 Sep=A0 5 12:17 0
> drwxr-xr-x 10 root root 0 Sep=A0 5 12:17 1
> drwxr-xr-x 10 root root 0 Sep=A0 5 12:17 2
> drwxr-xr-x 10 root root 0 Sep=A0 5 12:17 3
> drwxr-xr-x 10 root root 0 Sep=A0 5 12:17 4
> drwxr-xr-x 10 root root 0 Sep=A0 5 12:17 5
> drwxr-xr-x 10 root root 0 Sep=A0 5 12:17 6
> drwxr-xr-x 10 root root 0 Sep=A0 5 12:17 7
> =

> -Max.
> =

> =

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
