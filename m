Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D92C636D6
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 02:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E246B400BB;
	Tue, 21 Feb 2023 02:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E246B400BB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E9/L8ciE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U7EmVgvfiX1z; Tue, 21 Feb 2023 02:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26306400CC;
	Tue, 21 Feb 2023 02:24:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26306400CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E83F8C0032;
	Tue, 21 Feb 2023 02:24:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4390C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 02:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EF4660FBE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 02:24:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EF4660FBE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E9/L8ciE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xNCsXmSxzvm3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 02:24:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9495260757
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9495260757
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 02:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676946275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmnW0xbZ3rF2sCVOX2Raqo1dYUIAYEbjFfdF3vPFdKA=;
 b=E9/L8ciE/6FTk5eIWLl+SqFBBgNfFUuNT3DLPGP0DopY/S6k74YjV9iDMvtxwXfUSEEF/h
 95vdiGYNm6wHyLVJZJTTkIITDixPn4xo8n7nnLI9pYj5IGHhTJ2T0/C9Aknj4ZJ1/JqePT
 VTPCdHEnW/oswRB6itsj7v58ht6RGMw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-IxzvKreLMMqAF1qxDo1ckg-1; Mon, 20 Feb 2023 21:24:34 -0500
X-MC-Unique: IxzvKreLMMqAF1qxDo1ckg-1
Received: by mail-ot1-f69.google.com with SMTP id
 y13-20020a056830108d00b00690e6d4743aso1636420oto.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 18:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YmnW0xbZ3rF2sCVOX2Raqo1dYUIAYEbjFfdF3vPFdKA=;
 b=l6mFMekrNJbjI26phtYT+v2fdSEN2E8uZIFtPqUhl8PBRPJ873wQZhmvW9xb3atNwG
 To+sr1dnMwkaxvsX5qraPgm31MM/SVTyfjkChZKpAWHTIERsZlGQcGvdPbLyFFvOfQuF
 +dIGkFzQwVEDkXZ+VA38CI8GmsZ1y9hnEiAPUK8073tCGzwZZhxjCZ9X42TVwC9xoqSZ
 /dmrZy7+XwojjbBMqd2XdXa1ejhANl38DTjiTtYiYuglDg9wO+5IT3OeAEh3eILltqb+
 HTH6uDsSAOmaBjH35smPhxO+RZmzijVd1x7MrYHG2q8gyyzhWgagI7yn0d2L4bm6SRgG
 8KOA==
X-Gm-Message-State: AO0yUKUhqWRgaIM7f3qC2rn/dug0vJnFHdsmFW1ze5ybaW/zu+6LetUT
 SEMtWaHRnxv+xxGRt0ytvF6mXGViMjutbCoYR341oXfsnetaL2nHfGPYX7VT0KfnKFuIbX7RINE
 f5kXrEdzYugPAw071vZXi6BK418C5LhQ+oDRRi/QJdP39doUj3fmZPb5V/A==
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr1156469oib.217.1676946273117; 
 Mon, 20 Feb 2023 18:24:33 -0800 (PST)
X-Google-Smtp-Source: AK7set+6NywEB1zq22G+QoHE8VrrKOnb9qGD7CaXNuTq8DRiBe+W6i7pFDEr1e9G9QtWCZKIHMIcpO0oaN2ttymqKXQ=
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr1156463oib.217.1676946272832; Mon, 20
 Feb 2023 18:24:32 -0800 (PST)
MIME-Version: 1.0
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
 <Y+94418p73aUQyIn@nanopsycho> <20230217083915-mutt-send-email-mst@kernel.org>
 <Y/MwtAGru3yAY7r3@nanopsycho> <20230220074947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230220074947-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Feb 2023 10:24:21 +0800
Message-ID: <CACGkMEunrAtqRk-F56q8UBCLj61O0jsiJdKPJKt_EtuWJaMQCA@mail.gmail.com>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jiri Pirko <jiri@resnulli.us>, Vitaly Mireyno <vmireyno@marvell.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Mon, Feb 20, 2023 at 8:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Feb 20, 2023 at 09:35:00AM +0100, Jiri Pirko wrote:
> > Fri, Feb 17, 2023 at 02:47:36PM CET, mst@redhat.com wrote:
> > >On Fri, Feb 17, 2023 at 01:53:55PM +0100, Jiri Pirko wrote:
> > >> Fri, Feb 17, 2023 at 01:22:01PM CET, mst@redhat.com wrote:
> > >> >On Fri, Feb 17, 2023 at 01:15:47PM +0100, Jiri Pirko wrote:
> > >> >> From: Jiri Pirko <jiri@nvidia.com>
> > >> >>
> > >> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> > >> >>
> > >> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> > >> >> set implicates that the driver provides the exact size of the header.
> > >> >>
> > >> >> The driver already complies to fill the correct value. Introduce the
> > >> >> feature and advertise it.
> > >> >>
> > >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> > >> >
> > >> >Could you add a bit of motivation just for the record?
> > >> >Does this improve performance for some card? By how much?
> > >> >Expected to help some future card?
> > >>
> > >> I can get that info, but isn't that rather something to be appended to
> > >> the virtio-spec patch? I mean, the feature is there, this is just
> > >> implementing it in one driver.
> > >
> > >It is more like using it in the driver.  It's not like we have to use
> > >everything - it could be useful for e.g. dpdk but not linux.
> > >Implementing it in the Linux driver has support costs - for example what
> > >if there's a bug and sometimes the length is incorrect?
> > >We'll be breaking things.
> >
> > I understand. To my understanding this feature just fixes the original
> > ambiguity in the virtio spec.
> >
> > Quoting the original virtio spec:
> > "hdr_len is a hint to the device as to how much of the header needs to
> >  be kept to copy into each packet"
> >
> > "a hint" might not be clear for the reader what does it mean, if it is
> > "maybe like that" of "exactly like that". This feature just makes it
> > crystal clear.
> >
> > If you look at the tap implementation, it uses hdr_len to alloc
> > skb linear part. No hint, it counts with the provided value.
> > So if the driver is currently not precise, it breaks tap.
>
> Well that's only for gso though right?
> And making it bigger than necessary works fine ...

It should work otherwise it's a bug after this commit:

commit 96f8d9ecf227638c89f98ccdcdd50b569891976c
Author: Jason Wang <jasowang@redhat.com>
Date:   Wed Nov 13 14:00:39 2013 +0800

    tuntap: limit head length of skb allocated

Thanks

>
> > I will add this to the patch description and send v2.
> >
>
> I feel this does not answer the question yet, or maybe I am being dense.
> My point was not about making hdr_len precise.  My point was that we are
> making a change here for no apparent reason. I am guessing you are not
> doing it for fun - so why? Is there a device with this feature bit
> you are aware of?
>
>
>
> >
> > >
> > >The patch was submitted by Marvell but they never bothered with
> > >using it in Linux. I guess they are using it for something else?
> > >CC Vitaly who put this in.
> > >
> > >>
> > >> >
> > >> >thanks!
> > >> >
> > >> >
> > >> >> ---
> > >> >>  drivers/net/virtio_net.c        | 6 ++++--
> > >> >>  include/uapi/linux/virtio_net.h | 1 +
> > >> >>  2 files changed, 5 insertions(+), 2 deletions(-)
> > >> >>
> > >> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > >> >> index fb5e68ed3ec2..e85b03988733 100644
> > >> >> --- a/drivers/net/virtio_net.c
> > >> >> +++ b/drivers/net/virtio_net.c
> > >> >> @@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
> > >> >>         VIRTIO_NET_F_GUEST_UFO,
> > >> >>         VIRTIO_NET_F_GUEST_CSUM,
> > >> >>         VIRTIO_NET_F_GUEST_USO4,
> > >> >> -       VIRTIO_NET_F_GUEST_USO6
> > >> >> +       VIRTIO_NET_F_GUEST_USO6,
> > >> >> +       VIRTIO_NET_F_GUEST_HDRLEN
> > >> >>  };
> > >> >>
> > >> >>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > >> >> @@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
> > >> >>         VIRTIO_NET_F_CTRL_MAC_ADDR, \
> > >> >>         VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> > >> >>         VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> > >> >> -       VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
> > >> >> +       VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
> > >> >> +       VIRTIO_NET_F_GUEST_HDRLEN
> > >> >>
> > >> >>  static unsigned int features[] = {
> > >> >>         VIRTNET_FEATURES,
> > >> >> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > >> >> index b4062bed186a..12c1c9699935 100644
> > >> >> --- a/include/uapi/linux/virtio_net.h
> > >> >> +++ b/include/uapi/linux/virtio_net.h
> > >> >> @@ -61,6 +61,7 @@
> > >> >>  #define VIRTIO_NET_F_GUEST_USO6        55      /* Guest can handle USOv6 in. */
> > >> >>  #define VIRTIO_NET_F_HOST_USO  56      /* Host can handle USO in. */
> > >> >>  #define VIRTIO_NET_F_HASH_REPORT  57   /* Supports hash report */
> > >> >> +#define VIRTIO_NET_F_GUEST_HDRLEN  59  /* Guest provides the exact hdr_len value. */
> > >> >>  #define VIRTIO_NET_F_RSS         60    /* Supports RSS RX steering */
> > >> >>  #define VIRTIO_NET_F_RSC_EXT     61    /* extended coalescing info */
> > >> >>  #define VIRTIO_NET_F_STANDBY     62    /* Act as standby for another device
> > >> >> --
> > >> >> 2.39.0
> > >> >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
