Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C00C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 08:39:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA52A2075A
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 08:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USPhHzIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA52A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2FBEE203F4;
	Tue, 29 Sep 2020 08:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9RbpQiqYafq; Tue, 29 Sep 2020 08:39:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 02A7A203B0;
	Tue, 29 Sep 2020 08:39:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC07EC0889;
	Tue, 29 Sep 2020 08:39:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE53C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 08:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5C427870B9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 08:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zy6v3IRv7yhh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 08:39:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
 [209.85.222.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9BA47870B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 08:39:38 +0000 (UTC)
Received: by mail-ua1-f68.google.com with SMTP id v5so3156958uau.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZUBddKNPgJHj5qtM1eGlZtL03dAbKbibCL5xODrGyaI=;
 b=USPhHzIjFDsnuU065wTU/l9LlzFcP7JbECKZOgZ8uevFoDWkcCmhvUCQtncBtDiZhX
 BTsLIM+2+6uuLMmsZ9Xxi+ejCd3JFxklq/sxNcpfZ4h/0ZIGSXXllM4cHsK5M4Vnka/b
 7vl08mbeq3BJ50eQ34tEPZ9Kp2pOII2XF3NPu6gEDocyAqclrk2zfoOanadon5vDGQh4
 a/VOpYWZj02gZpTZok3Nfl20b+lW951WcyoUP/9hMem6Yu4T0lr1e79v7mszd/Rnwp3m
 SI1o8fpqZzfF0OGz031Trek8UWTz60t3QVXqoOSxpl7fh+E+s5Xj++emQ054GaCjSMr3
 NrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZUBddKNPgJHj5qtM1eGlZtL03dAbKbibCL5xODrGyaI=;
 b=nyl+3GlSzcsW2tZvYLcRxlpwKyrLJBzJxoU7wMTTQKQNQ3PwY5lpataq9kNdlDZPtM
 uRw57hlCqMpYWOOn+XdADG4iqzmrIeEOTJRqjfbGfjDA10UXiniQmGfTEvSQ0fSiCFsl
 9WmvNQytGwnIRAJtM7zTON22CbCTDXluT05blD83lWKCfagsxwNDs6voVMGUK8ObC04X
 kjXO0PUFfUtPooji7bCpnq4GYotySblKAscDcMTpBMbbJiid0V1euCMfXfYRBcA9au0S
 Ly9hJ2c9AG9wX8w6bK+q706TWJRfLRpx10LmX+iGa3k+Jo+kl1ceLbXmI6Q85+p60/EH
 0AfA==
X-Gm-Message-State: AOAM531bKMd87Ee2WKic2x5B0HB4LQf84S/L3qve4dAVsSfkMBeyXSvL
 Tum05gY7Yi31310ow4XJ2u2lcuHyTUTWag==
X-Google-Smtp-Source: ABdhPJx2BhKQ9wLuhK2llwPvd48/FnHAY8B0yuFM2nTcHJCtKiAU/fH1taSJI25XXlXA0eBPWCE2fg==
X-Received: by 2002:ab0:20b6:: with SMTP id y22mr3188612ual.30.1601368776946; 
 Tue, 29 Sep 2020 01:39:36 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com.
 [209.85.221.173])
 by smtp.gmail.com with ESMTPSA id s70sm465192vss.9.2020.09.29.01.39.35
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:39:36 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id q124so2225286vkb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:39:35 -0700 (PDT)
X-Received: by 2002:a1f:1f15:: with SMTP id f21mr1895617vkf.12.1601368775291; 
 Tue, 29 Sep 2020 01:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200929015806.19171-1-xiangxia.m.yue@gmail.com>
 <CA+FuTSebRQ=2VfT0KnM6ChjMg0j3NWJDPwn9S=aQk8tbNrUt6w@mail.gmail.com>
 <CAMDZJNW=hEEcsJy1gUEwrnERRgH3kRBkEuDtcPwPdfXr91eTGg@mail.gmail.com>
In-Reply-To: <CAMDZJNW=hEEcsJy1gUEwrnERRgH3kRBkEuDtcPwPdfXr91eTGg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 29 Sep 2020 10:38:59 +0200
X-Gmail-Original-Message-ID: <CA+FuTSdJ78xSTQJeLOuarSm5sR_MJZ3MFjiA9V6SiMJy81E5dg@mail.gmail.com>
Message-ID: <CA+FuTSdJ78xSTQJeLOuarSm5sR_MJZ3MFjiA9V6SiMJy81E5dg@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: don't disable guest csum when disable
 LRO
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
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

On Tue, Sep 29, 2020 at 9:56 AM Tonghao Zhang <xiangxia.m.yue@gmail.com> wrote:
>
> On Tue, Sep 29, 2020 at 3:32 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 4:00 AM <xiangxia.m.yue@gmail.com> wrote:
> > >
> > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > >
> > > Open vSwitch and Linux bridge will disable LRO of the interface
> > > when this interface added to them. Now when disable the LRO, the
> > > virtio-net csum is disable too. That drops the forwarding performance.
> >
> > I had focused on the code previously.
> >
> > The s/w checksum verification cost is significant in a VM with traffic
> > to local destinations. A bridge does not verify transport layer
> > checksums OTOH?
> Hi Willem.
> No, think about GRO(In the GRO we don't know packets will be forwarded
> to other ports or to local).

I had expected a pure bridging setup that disables LRO to disable GRO as well.

But if not, then, indeed, the checksum needs to be verified before
coalescing. Makes sense.

> The call tree as below:
>    + 5.41% secondary_startup_64
>    - 1.22% ret_from_fork
> ....
>         net_rx_action
>         napi_poll
>         virtnet_poll
>         virtnet_receive
>         napi_gro_receive
>         dev_gro_receive
>         inet_gro_receive
>         tcp4_gro_receive
>         __skb_gro_checksum_complete
>         skb_checksum
>         __skb_checksum
>         csum_partial
>         do_csum
>    - 1.13% do_csum
>
> $ brctl show
> bridge name bridge id STP enabled interfaces
> br0 8000.001122330001 no eth1
> eth2
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
