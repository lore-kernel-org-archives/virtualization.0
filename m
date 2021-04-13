Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBEFC433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D04613AB
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D04613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E95F843F6;
	Tue, 13 Apr 2021 14:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpziNG0QwZri; Tue, 13 Apr 2021 14:02:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CBB2843FA;
	Tue, 13 Apr 2021 14:02:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E06E3C000B;
	Tue, 13 Apr 2021 14:02:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9725CC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77709843FA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rTC9GXEcBSPa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:01:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8004843F6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:01:53 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id x4so19580876edd.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AFGnHKnHgizV+FsCV7toD3pQlz9ndhsRkbd9JHKTvd8=;
 b=gbYaC/RA4eUmT+VPtdGwg6SqqhZkkjrsBnbBOkqmZdFA1AVHvUBovodg7KbKHULUl+
 6heoWEPdrPOmEwLaUlmmZS3giIHFbQujJt/WaF+yl+YsNUYfyw1lc5j2TY2nb/xBL6I7
 fAaOaj19dn65sTejbQwBQJ/vqZp265XS5Ka1viuZ6TVSqEX3HDSx7F7kOvJefhTy50pM
 JJUoCrn+0+Rdf7Vzs9t07nxbtgaH8CKgw8BnMEifBXQRxGBKG9k1jNYd/6tJPMLaSmSx
 0iMZqngixmxWLGeBYhMbggLjjym2d/JyJlsRqHv2VjlFj86mRWs0UdiRw3z9uN3F+Dr4
 nC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AFGnHKnHgizV+FsCV7toD3pQlz9ndhsRkbd9JHKTvd8=;
 b=sopgJ12DBX1NqqffTQ++/EnxsCpEzM1s4GJARHI7WNIpgeyKcH919Yb+cqGDvDRKVK
 R+Krs8Z1EG0OGSyGyJc8uhV49jkk/Bi/Zhk4N5fWSAxqaCWExEXOTLjv2FV0LGQykf76
 I7z5j9L1R7Wd7DWoSGvEmB6JMo2JHRaAjxDW3NwAg39OLh3oZVAQyFViLISuMCZwUl8y
 Yc1FJmDUwyRQPEVB18eozTaEYQ779A3Vn0TqxhiOpw+UW8xuI9T39mZP+7HPYJdJs6bf
 0LiSiuX9emJVyM2nM+eSh2cJhuLj5l9CZwtYxPCH13CvMyIIADaCXoQK7zdZj4beDnIe
 P5TQ==
X-Gm-Message-State: AOAM531DB29lnXbHub3S3AyVgcDD5qtckTcDboOAM2e5s9kTIkvl3W2j
 KcRWu3+SJhuENbB1DgGdc19vLQD7OpgJ5w==
X-Google-Smtp-Source: ABdhPJyodEV+omPiiaDzSIcOwcIT5P4BJRbRXkZJYeGGA2LV4Dz1W/YcWxek4QXKmH8oGIXLamK+jQ==
X-Received: by 2002:a05:6402:22f9:: with SMTP id
 dn25mr20389729edb.171.1618322511419; 
 Tue, 13 Apr 2021 07:01:51 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com.
 [209.85.221.44])
 by smtp.gmail.com with ESMTPSA id v5sm9735029edx.87.2021.04.13.07.01.49
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 07:01:50 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id w4so12850425wrt.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:01:49 -0700 (PDT)
X-Received: by 2002:a5d:43c1:: with SMTP id v1mr12067069wrr.419.1618322509572; 
 Tue, 13 Apr 2021 07:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-2-mst@redhat.com>
In-Reply-To: <20210413054733.36363-2-mst@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Apr 2021 10:01:11 -0400
X-Gmail-Original-Message-ID: <CA+FuTSe_SjUY4JxR6G9b8a0nx-MfQOkLdHJSzmjpuRG4BvsVPw@mail.gmail.com>
Message-ID: <CA+FuTSe_SjUY4JxR6G9b8a0nx-MfQOkLdHJSzmjpuRG4BvsVPw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/4] virtio: fix up virtio_disable_cb
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

On Tue, Apr 13, 2021 at 1:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtio_disable_cb is currently a nop for split ring with event index.
> This is because it used to be always called from a callback when we know
> device won't trigger more events until we update the index.  However,
> now that we run with interrupts enabled a lot we also poll without a
> callback so that is different: disabling callbacks will help reduce the
> number of spurious interrupts.

The device may poll for transmit completions as a result of an interrupt
from virtnet_poll_tx.

As well as asynchronously to this transmit interrupt, from start_xmit or
from virtnet_poll_cleantx as a result of a receive interrupt.

As of napi-tx, transmit interrupts are left enabled to operate in standard
napi mode. While previously they would be left disabled for most of the
time, enabling only when the queue as low on descriptors.

(in practice, for the at the time common case of split ring with event index,
little changed, as that mode does not actually enable/disable the interrupt,
but looks at the consumer index in the ring to decide whether to interrupt)

Combined, this may cause the following:

1. device sends a packet and fires transmit interrupt
2. driver cleans interrupts using virtnet_poll_cleantx
3. driver handles transmit interrupt using vring_interrupt,
    detects that the vring is empty: !more_used(vq),
    and records a spurious interrupt.

I don't quite follow how suppressing interrupt suppression, i.e.,
skipping disable_cb, helps avoid this.

I'm probably missing something. Is this solving a subtly different
problem from the one as I understand it?

> Further, if using event index with a packed ring, and if being called
> from a callback, we actually do disable interrupts which is unnecessary.
>
> Fix both issues by tracking whenever we get a callback. If that is
> the case disabling interrupts with event index can be a nop.
> If not the case disable interrupts. Note: with a split ring
> there's no explicit "no interrupts" value. For now we write
> a fixed value so our chance of triggering an interupt
> is 1/ring size. It's probably better to write something
> related to the last used index there to reduce the chance
> even further. For now I'm keeping it simple.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
