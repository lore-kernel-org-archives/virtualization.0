Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4630C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:29:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AC4207F7
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evpn9qO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AC4207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 43DD187042;
	Tue, 29 Sep 2020 07:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T4iitrNDKzoS; Tue, 29 Sep 2020 07:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A6218705B;
	Tue, 29 Sep 2020 07:29:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 357C6C0890;
	Tue, 29 Sep 2020 07:29:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD984C016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ADB92866E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xGA4k0mgesFr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:29:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
 [209.85.217.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2E33F84E8F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:29:42 +0000 (UTC)
Received: by mail-vs1-f67.google.com with SMTP id 5so2364758vsu.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RRExsVyVMwBvTMnZrDTLbfks0apPzLNJ5QKUNQU00UE=;
 b=Evpn9qO/frrfNUxv6L3B0DSPIIPy1ZctcHXUS0ssjSBetN9s1PZNFIY/O5IANEUOys
 RPNm8keLlt8p6mcKiL0GVrjdJ93kKWiKuymB8TzMAsnUOh5kJTsZ8oi9+Ymw3lJaXYXB
 R5rnGpDZHiiGQPoFKAtQKgrT6zG5LUVCXjU4YssTHdK4TympEIf57A1MDUlAFyWaHd9I
 TLLCDVaAeQefqd79ETKBH6RqrdDuaIZvaG8d3h/rgMXLCDtcQ9OKw5kVzgi51x6HK3vW
 WzOlhdSYvYiL1Mn8ARuJPoKNZ3cajn61IrupDxSuKJ1lC1h4bIToQEZgxP8MZGAEyVgs
 q72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RRExsVyVMwBvTMnZrDTLbfks0apPzLNJ5QKUNQU00UE=;
 b=L44Su14PNIjKA8DE94KvDBzumusQz2vW+NztwjfgM68W7xqMyNoY6+EyXZl5yWDVy+
 M/fbHB5vQTO9XQ4AvQVUOG8qjy3SoypUYZTFTpHPkvWO46GaJ5zEG3D3iUyJQwAJmA5X
 81TIXHAjQlVXpqakPrkOppTtBVnrP5gfQnHJXWybeTWKMXb4nKotEAZmRAbgncdVM3R1
 zPdr5erz5aoxk5PuSs0Rf+qn3MOPmZVb5JElOvkTk1AUekNoivM0yAY/IP3aZrWFD6E6
 x4mH7hhq7my08fsOxJmLh8isd9qk6eSwL4xNM3qnCohLtYqzrAaCJtSYl69TXaa73+9W
 BshQ==
X-Gm-Message-State: AOAM532Sle4Ha6swhhveKLw54FYlTKtR6yQ25jVfrSB6/Rq6LOrbaCFi
 sttjvFmEFWBSWagzXwxKTZr+t7OeYCKauQ==
X-Google-Smtp-Source: ABdhPJzcs+Q/mSvARSTHoHZP+33EQm62DlNVkMawiZ4tXk7XGCDZkDo0Bcumfb8mArwmATWuWjGWMw==
X-Received: by 2002:a67:60c6:: with SMTP id u189mr2171326vsb.35.1601364580418; 
 Tue, 29 Sep 2020 00:29:40 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com.
 [209.85.217.47])
 by smtp.gmail.com with ESMTPSA id s18sm1408986vkd.51.2020.09.29.00.29.39
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 00:29:39 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id e2so2358847vsr.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:29:39 -0700 (PDT)
X-Received: by 2002:a67:e83:: with SMTP id 125mr2091259vso.22.1601364578963;
 Tue, 29 Sep 2020 00:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200929015806.19171-1-xiangxia.m.yue@gmail.com>
 <20200929022246-mutt-send-email-mst@kernel.org>
 <CAMDZJNWM7eBkrYk9nkEvPyHW7=kt_hTHGQCDB1CPRz=EV6vJcQ@mail.gmail.com>
 <20200929031754-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200929031754-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 29 Sep 2020 09:29:02 +0200
X-Gmail-Original-Message-ID: <CA+FuTScinzrURHx_jQge9jN0mJU7oM2d9AJ9ckkXm3SxBHGNvQ@mail.gmail.com>
Message-ID: <CA+FuTScinzrURHx_jQge9jN0mJU7oM2d9AJ9ckkXm3SxBHGNvQ@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: don't disable guest csum when disable
 LRO
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org
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

On Tue, Sep 29, 2020 at 9:23 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 29, 2020 at 02:59:03PM +0800, Tonghao Zhang wrote:
> > On Tue, Sep 29, 2020 at 2:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 09:58:06AM +0800, xiangxia.m.yue@gmail.com wrote:
> > > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > >
> > > > Open vSwitch and Linux bridge will disable LRO of the interface
> > > > when this interface added to them. Now when disable the LRO, the
> > > > virtio-net csum is disable too. That drops the forwarding performance.
> > > >
> > > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > Cc: Willem de Bruijn <willemb@google.com>
> > > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > > ---
> > > > v2:
> > > > * change the fix-tag
> > > > ---
> > > >  drivers/net/virtio_net.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 7145c83c6c8c..21b71148c532 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -63,6 +63,11 @@ static const unsigned long guest_offloads[] = {
> > > >       VIRTIO_NET_F_GUEST_CSUM
> > > >  };
> > > >
> > > > +#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > > > +                             (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> > > > +                             (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > > > +                             (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > > > +
> > >
> > > I think I'd rather we open-coded this, the macro is only
> > > used in one place ...
> > Yes, in this patch, it is used only in one place. But in next patch
> > [1], we use it twice and that make the code look a bit nicer.
> > Would we open-coded this in this patch ?
> >
> > [1] - http://patchwork.ozlabs.org/project/netdev/patch/20200928033915.82810-2-xiangxia.m.yue@gmail.com/
>
> OK then maybe keep this in a series like you did with v1.

If this is a fix it has to target net, unlike the other patch.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
