Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774B1C433FE
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 03:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1D144059F;
	Mon, 22 Nov 2021 03:51:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MoIMZYmocRm; Mon, 22 Nov 2021 03:51:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 85DF2404BB;
	Mon, 22 Nov 2021 03:51:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5704EC002E;
	Mon, 22 Nov 2021 03:51:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0729AC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 03:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5D21404BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 03:51:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nNj0EJ7SAaNW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 03:51:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60200404BB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 03:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637553083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ZoTqA9iiFG9nkpS66qOwO3q3VJpM/VpcOc+Jqz0mA0=;
 b=TuahKyIb6Hwj1V+4WiaHUKVf31E3U8MKH1BlKvlKtAf6SGJm2KmMmAKUstlF/F5ncW7OND
 isxvUkR+lBS+b8v9INGcqQy/QTQKChGpHDfHzAl+CbSK8UEj9Le5AA6i5UJC6YdL97zhd9
 Bnt9B3eks5rSiUdMMTWtiwUoNQe6a2k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-ab4KkN-qPX6aXpLJfFcK4w-1; Sun, 21 Nov 2021 22:51:21 -0500
X-MC-Unique: ab4KkN-qPX6aXpLJfFcK4w-1
Received: by mail-lf1-f70.google.com with SMTP id
 c14-20020a056512104e00b004036d17f91bso11118649lfb.17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 19:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ZoTqA9iiFG9nkpS66qOwO3q3VJpM/VpcOc+Jqz0mA0=;
 b=Nq98RsKa5UPROVw9YoAm0E26+7mI+c4OyRDPRGMy/YVpQS0IA94XbtAPMCrsBiK4y5
 t4opfdmkkDBrCfRVZrJwkn0VfI+w6cS/2ZQ+XDChe7NbZScghRmGC2hOph2Y5z0jbANC
 wEV+1602hjvXhT9xMVopoDIRxlk9wWoJpk6srFRnLEii2YFSrQNjGMLaeS/gmKNqD8B7
 z1WwlFGYCDI8hdJfKscXRAgMytuhTDjEoyGSfkYB7q7cc4EW+kHR09yfXCfcdSrzPwIu
 BuancuMqYIpYRzweMEQXl3Be/Krk17IL1vFcjfMFuSgPuXj6m/ITMt6LUdA2pMpKVQrN
 Pqpg==
X-Gm-Message-State: AOAM530wYSyE2KTZROE4qBKVL18413HLzzowqeOXjOC5yLrx/2yuHm8K
 lmt0xiHkvnbXk/mkCZXsTCEl3D/HHbICoKO+jVyN9Sb+Yl/eJ+1bfiJi5h32CaaizRjwKULqi7T
 gpOFcfhwakw7CgJgw3FJ1NCxGHTIO33Pvp/Nl+pyGTXtcZGxiIs7cF7J2Yw==
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr55542518lfv.481.1637553080339; 
 Sun, 21 Nov 2021 19:51:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRhp3qnggyh9IV/j+nxJud16x/I5z46Jl3/q8pwRp7lFSjvOjUZebdYRAYcWh6jwM4VsQB8bwBiyV068HiNRY=
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr55542487lfv.481.1637553080159; 
 Sun, 21 Nov 2021 19:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
In-Reply-To: <20211119160951.5f2294c8.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Nov 2021 11:51:09 +0800
Message-ID: <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To: Halil Pasic <pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Fri, Nov 19, 2021 at 11:10 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 27 Oct 2021 10:21:04 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch validate the used buffer length provided by the device
> > before trying to use it. This is done by record the in buffer length
> > in a new field in desc_state structure during virtqueue_add(), then we
> > can fail the virtqueue_get_buf() when we find the device is trying to
> > give us a used buffer length which is greater than the in buffer
> > length.
> >
> > Since some drivers have already done the validation by themselves,
> > this patch tries to makes the core validation optional. For the driver
> > that doesn't want the validation, it can set the
> > suppress_used_validation to be true (which could be overridden by
> > force_used_validation module parameter). To be more efficient, a
> > dedicate array is used for storing the validate used length, this
> > helps to eliminate the cache stress if validation is done by the
> > driver.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Hi Jason!
>
> Our CI has detected, that virtio-vsock became unusable with this
> patch on s390x. I didn't test on x86 yet. The guest kernel says
> something like:
> vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0
>
> Did you, or anybody else, see something like this on platforms other that
> s390x?

Adding Stefan and Stefano.

I think it should be a common issue, looking at
vhost_vsock_handle_tx_kick(), it did:

len += sizeof(pkt->hdr);
vhost_add_used(vq, head, len);

which looks like a violation of the spec since it's TX.

>
> I had a quick look at this code, and I speculate that it probably
> uncovers a pre-existig bug, rather than introducing a new one.

I agree.

>
> If somebody is already working on this please reach out to me.

AFAIK, no. I think the plan is to fix both the device and drive side
(but I'm not sure we need a new feature for this if we stick to the
validation).

Thanks

>
> Regards,
> Halil
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
