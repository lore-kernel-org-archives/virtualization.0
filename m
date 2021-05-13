Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E7C433B4
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 20:44:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CFD6143D
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 20:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CFD6143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF2104031B;
	Thu, 13 May 2021 20:44:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6G7enNCU_L55; Thu, 13 May 2021 20:44:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 514F4402EE;
	Thu, 13 May 2021 20:44:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 178A0C000D;
	Thu, 13 May 2021 20:44:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD62DC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 20:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 968DD6060C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 20:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jpht5VffQkuu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 20:43:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6531D605DD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 20:43:58 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id c20so6284308ejm.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zsi1VS1/M5Q4gHLg9ba2wD4/Zt4MEUxOebW8zMEgFb8=;
 b=o6CmiB2EKAmYIWJvXeSOnrp0mEYkKXWDYisDmuTXFnFKVW4P7SmWp98YmjZZQ8s5vf
 B86DUjzYxVkGaiR4+5WEwdC1xamBzEEpPQA19HHsPVWzZ5G7eX43w4tMyiPfn+sKc07h
 ejU1ZP37ip8XzGNSzrBYoFqhP+ScCX3Ca+zu/Inz0toFv1zTGktFcaH3TJd9g43pipOn
 grx6nIPteA+3NqiMB7uksSQuq7AKrfCEbBEZQ7035/3XDguTAJZlyqcmc7S9dXrUy+jn
 eDI98aGEqHNHj0UD77DQeNg65Wz5/Vs+SpuxBd6HnqoEJnXoyUqeAuaYIoB+Y/uu8krz
 v4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zsi1VS1/M5Q4gHLg9ba2wD4/Zt4MEUxOebW8zMEgFb8=;
 b=OQqiXyhNdnUWvGO3T9iNjkuWC5sgyNOSb6Xyobn0zbe9JlfEEi7OdW11XCgRs3F07v
 Y2KkLmmrBr0K9u8bYsOYHmGwef5Uy3WC7FBh+dRcsq59AjUfYCkCFN2hIqa1eAJuK8vb
 /53MgU8ITvU0yrDGxFCUG+dxC2fYzgqKAGN7tmebtuWUWjaNZ1+x5q35+7KYEQJY847W
 JgLajYN6Wrz3MsxxsC7n/ItYGJgD9a9lm8EZEkRxz7UXRgN1YXVXqj6XyJCYEobUIKaU
 iRUnMdFX5PhkWiofN1kPsjcvLxgz9UKlXY+pmzVHTkjCww3GjjQeA5JTKLzcvpsBsneZ
 JNgQ==
X-Gm-Message-State: AOAM532/zsT8dvb0ivk6LtZFioUXanM8L3qAkAkFrkWwmjTkFO2L2l4Y
 Yl8Y6oLLwaDBbLcIFyMfeQQ/HYhaHiKxfA==
X-Google-Smtp-Source: ABdhPJz2W0BQJ/4wleWKAI9zbDGGEyA9c40PFYlcRdSa/kFfd+Nq46DkJ+UWnbMUrcxYk7rm49/PBw==
X-Received: by 2002:a17:906:e2d9:: with SMTP id
 gr25mr2957262ejb.373.1620938635699; 
 Thu, 13 May 2021 13:43:55 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com.
 [209.85.221.49])
 by smtp.gmail.com with ESMTPSA id k9sm2543502eje.102.2021.05.13.13.43.54
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 13:43:54 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id r12so2480332wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:43:54 -0700 (PDT)
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr52466335wri.327.1620938634068; 
 Thu, 13 May 2021 13:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com>
 <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
 <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
 <89759261-3a72-df6c-7a81-b7a48abfad44@redhat.com>
 <CAOEp5Ocm9Q69Fv=oeyCs01F9J4nCTPiOPpw9_BRZ0WnF+LtEFQ@mail.gmail.com>
 <CACGkMEsZBCzV+d_eLj1aYT+pkS5m1QAy7q8rUkNsdV0C8aL8tQ@mail.gmail.com>
 <CAOEp5OeSankfA6urXLW_fquSMrZ+WYXDtKNacort1UwR=WgxqA@mail.gmail.com>
 <CACGkMEt3bZrdqbWtWjSkXvv5v8iCHiN8hkD3T602RZnb6nPd9A@mail.gmail.com>
 <CAOEp5Odw=eaQWZCXr+U8PipPtO1Avjw-t3gEdKyvNYxuNa5TfQ@mail.gmail.com>
 <CACGkMEuqXaJxGqC+CLoq7k4XDu+W3E3Kk3WvG-D6tnn2K4ZPNA@mail.gmail.com>
 <CAOEp5OfB62SQzxMj_GkVD4EM=Z+xf43TPoTZwMbPPa3BsX2ooA@mail.gmail.com>
 <CACGkMEu4NdyMoFKbyUGG1aGX+K=ShMZuVuMKYPauEBYz5pxYzA@mail.gmail.com>
 <CAOEp5Oe7FQQFbO7KDiyBPs1=ox+6rOimOwounTHBuVki2Y3DAg@mail.gmail.com>
In-Reply-To: <CAOEp5Oe7FQQFbO7KDiyBPs1=ox+6rOimOwounTHBuVki2Y3DAg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 13 May 2021 16:43:16 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfr4gLwx0PaRCB1K=TUE_yawpnWx05U9yO0eQ1B+Pa+bg@mail.gmail.com>
Message-ID: <CA+FuTSfr4gLwx0PaRCB1K=TUE_yawpnWx05U9yO0eQ1B+Pa+bg@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 davem <davem@davemloft.net>
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

> > > > > So the question is what to do now:
> > > > > A)
> > > > > Finalize patches for guest TX and respective QEMU patches
> > > > > Prepare RFC patches for guest RX, get ack on them
> > > > > Change the spec
> > > > > Finalize patches for guest RX according to the spec
> > > > >
> > > > > B)
> > > > > Reject the patches for guest TX
> > > > > Prepare RFC patches for everything, get ack on them
> > > > > Change the spec
> > > > > Finalize patches for everything according to the spec
> > > > >
> > > > > I'm for A) of course :)
> > > >
> > > > I'm for B :)
> > > >
> > > > The reasons are:
> > > >
> > > > 1) keep the assumption of tun_set_offload() to simply the logic and
> > > > compatibility
> > > > 2) it's hard or tricky to touch guest TX path only (e.g the
> > > > virtio_net_hdr_from_skb() is called in both RX and TX)
> > >
> > > I suspect there is _some_ misunderstanding here.
> > > I did not touch virtio_net_hdr_from_skb at all.
> > >
> >
> > Typo, actually I meant virtio_net_hdr_to_skb().
> OK.
> 2) tun_get_user() which is guest TX - this is covered
> 3) tap_get_user() which is guest TX - this is covered
> 4) {t}packet_send() which is userspace TX - this is OK, the userspace
> does not have this feature, it will never use USO

What do you mean exactly? I can certainly imagine packet socket users
that could benefit from using udp gso.

When adding support for a new GSO type in virtio_net_hdr, it ideally
is supported by all users of that interface. Alternatively, if some
users do not support the flag, a call that sets the flag has to
(continue to) fail hard, so that we can enable it at a later time.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
