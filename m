Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13116C19F2A
	for <virtualization@archiver.kernel.org>; Sun,  7 Aug 2022 13:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BA7A400B9;
	Sun,  7 Aug 2022 13:14:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BA7A400B9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GoYHbnsC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Erf7rsgp8xHk; Sun,  7 Aug 2022 13:14:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CAD2400EF;
	Sun,  7 Aug 2022 13:14:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CAD2400EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8150C0032;
	Sun,  7 Aug 2022 13:14:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E36B0C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4D8A60AE4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:14:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4D8A60AE4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GoYHbnsC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j4FY-uwx4c-y
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:14:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39B6D60AC1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39B6D60AC1
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659878092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xE1ql9r1WlnpphQLIhOk9A5gTFrWDcEvErV3HfUz44Q=;
 b=GoYHbnsC85pX43NXb6iH/rxLeJG0PycIu4I4Mzrzc/I99vvmNYcyLbl2Wmlo68yEK6BvSs
 pnmWlcu8jRl4cx2U7Tzlr4WzYTxdhoZrq3DpPVP1t1Ftue72DAUKGPJSWpDwuCUPnv50gn
 nj3u7jE0LK05DRfpPtYhy8hIGSEU7i0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486--TYLrriFMiWRk7j7yMaJeQ-1; Sun, 07 Aug 2022 09:14:51 -0400
X-MC-Unique: -TYLrriFMiWRk7j7yMaJeQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 j22-20020a05600c485600b003a50fa6981bso5104569wmo.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 Aug 2022 06:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=xE1ql9r1WlnpphQLIhOk9A5gTFrWDcEvErV3HfUz44Q=;
 b=ZV1UoqaGAcJVPED8Wb8hnI2/be706IWSETiYRDLwXS1A3My6SBpSyfg7avjXYoeYjm
 L73E/deutx12AXQPWUV6vbVm3DpnrwnS6TbCw9kSu1utxRbmhwW1bizRgh9prw1xqYm5
 UVD1skm5Ltn5ZXagTaW+fH9iB5GVDoPEycUm3Q6jXSkKV6zZrei5Q2POxCpKajvkqVbY
 oboO8L9UUb3qABdenVwroeH8iCkNzIYc0rEi1q3aMFEFlqQRPKy9Dvt0LRH2w2baMnRt
 zcyTRZZ1cG4uzDrGgXTDYP71eDX9pMMZwwqKEwhWWqAA5jrMsHFBi1mkKTc0mRyHHUp2
 PwrQ==
X-Gm-Message-State: ACgBeo0hfcuiL0JfdPEbSvPeRawcBe+shtQR7s2El/a6RjClSsGqHdpY
 Bo4iehHQhuKeU6Thyk8Ure58LSDQ90OoHM5l/ZIDre8Pso72cNKar5Fo2HalZxy7HnZa1Cw0KHQ
 lpIMTDW4Q5wnYCEFZMbchZa7R4ne4HVeODRAxYgHsSQ==
X-Received: by 2002:a7b:cb55:0:b0:3a5:41a:829c with SMTP id
 v21-20020a7bcb55000000b003a5041a829cmr12476228wmj.153.1659878090317; 
 Sun, 07 Aug 2022 06:14:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7XPmSXHx0uphBUati04hlAT8Kv454CdlO9eCJMcNZrnnQufGNHHbsrZu1If3gI3BrvRzX2yQ==
X-Received: by 2002:a7b:cb55:0:b0:3a5:41a:829c with SMTP id
 v21-20020a7bcb55000000b003a5041a829cmr12476216wmj.153.1659878090075; 
 Sun, 07 Aug 2022 06:14:50 -0700 (PDT)
Received: from redhat.com ([2.52.21.123]) by smtp.gmail.com with ESMTPSA id
 ba5-20020a0560001c0500b0021efc75914esm9570153wrb.79.2022.08.07.06.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Aug 2022 06:14:49 -0700 (PDT)
Date: Sun, 7 Aug 2022 09:14:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220807042408-mutt-send-email-mst@kernel.org>
References: <20220805181105.GA29848@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20220805181105.GA29848@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiyong@google.com, kvm@vger.kernel.org, kernel-team@android.com,
 maz@kernel.org, keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, torvalds@linux-foundation.org
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

Will, thanks very much for the analysis and the writeup!

On Fri, Aug 05, 2022 at 07:11:06PM +0100, Will Deacon wrote:
> So how should we fix this? One possibility is for us to hack crosvm to
> clear the VIRTIO_F_ACCESS_PLATFORM flag when setting the vhost features,
> but others here have reasonably pointed out that they didn't expect a
> kernel change to break userspace. On the flip side, the offending commit
> in the kernel isn't exactly new (it's from the end of 2020!) and so it's
> likely that others (e.g. QEMU) are using this feature.

Exactly, that's the problem.

vhost is reusing the virtio bits and it's only natural that
what you are doing would happen.

To be precise, this is what we expected people to do (and what QEMU does):


#define QEMU_VHOST_FEATURES ((1 << VIRTIO_F_VERSION_1) |
			     (1 << VIRTIO_NET_F_RX_MRG) | .... )

VHOST_GET_FEATURES(... &host_features);
host_features &= QEMU_VHOST_FEATURES
VHOST_SET_FEATURES(host_features & guest_features)


Here QEMU_VHOST_FEATURES are the bits userspace knows about.

Our assumption was that whatever userspace enables, it
knows what the effect on vhost is going to be.

But yes, I understand absolutely how someone would instead just use the
guest features. It is unfortunate that we did not catch this in time.


In hindsight, we should have just created vhost level macros
instead of reusing virtio ones. Would address the concern
about naming: PLATFORM_ACCESS makes sense for the
guest since there it means "whatever access rules platform has",
but for vhost a better name would be VHOST_F_IOTLB.
We should have also taken greater pains to document what
we expect userspace to do. I remember now how I thought about something
like this but after coding this up in QEMU I forgot to document this :(
Also, I suspect given the history the GET/SET features ioctl and burned
wrt extending it and we have to use a new when we add new features.
All this we can do going forward.


But what can we do about the specific issue?
I am not 100% sure since as Will points out, QEMU and other
userspace already rely on the current behaviour.

Looking at QEMU specifically, it always sends some translations at
startup, this in order to handle device rings.

So, *maybe* we can get away with assuming that if no IOTLB ioctl was
ever invoked then this userspace does not know about IOTLB and
translation should ignore IOTLB completely.

I am a bit nervous about breaking some *other* userspace which actually
wants device to be blocked from accessing memory until IOTLB
has been setup. If we get it wrong we are making guest
and possibly even host vulnerable.
And of course just revering is not an option either since there
are now whole stacks depending on the feature.

Will I'd like your input on whether you feel a hack in the kernel
is justified here.

Also yes, I think it's a good idea to change crosvm anyway.  While the
work around I describe might make sense upstream I don't think it's a
reasonable thing to do in stable kernels.
I think I'll prepare a patch documenting the legal vhost features
as a 1st step even though crosvm is rust so it's not importing
the header directly, right?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
