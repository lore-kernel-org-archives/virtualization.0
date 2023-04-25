Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0C6C77B61
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 13:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3201F60741;
	Tue, 25 Apr 2023 13:09:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3201F60741
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aS0ijO97
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YKjlSeOrLNUA; Tue, 25 Apr 2023 13:09:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A979D61410;
	Tue, 25 Apr 2023 13:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A979D61410
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73B5DC0036;
	Tue, 25 Apr 2023 13:09:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AF3DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 13:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58C8040908
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 13:09:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58C8040908
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aS0ijO97
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XiO5GvljNkx5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 13:09:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EF3F40900
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1EF3F40900
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 13:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682428140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+fKc7C0hTjXYruI3suD5rQvaDU7fCvCV7e+LIaqkh9A=;
 b=aS0ijO97T+Nxf3YIKHMA/mn2N7aXzmaojlu5+BGZuhSQK/7Q8BUAN8LH49m/WePiX5/sRX
 8QDUyyoDDV6pmIypV+iHF1/aIHm/epgfE2k9PXxl1rRirRbCni5Z+rtuHmRVWE81ZlH2hr
 BdQHcfTomYqco8vnCYxprPYGISgiJWk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-ZszEpBnGNwOrVfHwWCXKjQ-1; Tue, 25 Apr 2023 09:08:56 -0400
X-MC-Unique: ZszEpBnGNwOrVfHwWCXKjQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2f69e5def13so2086106f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682428135; x=1685020135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fKc7C0hTjXYruI3suD5rQvaDU7fCvCV7e+LIaqkh9A=;
 b=gokKSLKvgB3FPM6K09jG0ykgfEjz3NyzpPIPkd1u6N2/dm8dQrxXBIPmurRHecGblh
 TMlWU5g3yckQEdiBx2BJo0mxd0pdNQ21npaExFwbej9LedfMT2gWDkTwzybio/dZM1aM
 m3hyzyuSeqdN451zvUWZUaXkF6no253XCeiCldk0O/9aSaXFH7p2yGsdok7Prdv1pFVr
 FNnvglgIMcYPi4Ko0iVpAl6tGsJ74AXOu81XZC2Ia2RcmOYNGzRbqdbldVNAYMu4E6zx
 2jP/GXQk6WyPtqO4W87YKVfTrI4tYyWNrD0dVcwpZRPG8+7fWLelkyuMyVXHmMfCGktg
 O14w==
X-Gm-Message-State: AAQBX9cg0a7lQjnxA2cwe9yEqX35o3shWRhafgKB5vGwjlj732ftoKOy
 60whbYjjjdbPdTqtP5F6g3Y+3JEH3IOrmRPQeEOkkj8aSwDIr9AGCLXEWekPFdgRiL0BTCIkN0U
 HwG5hOAMETYEFozBP4tS5171fidvYPHl9cEj2WQEkww==
X-Received: by 2002:a5d:6a85:0:b0:303:a2e4:e652 with SMTP id
 s5-20020a5d6a85000000b00303a2e4e652mr10068937wru.14.1682428135278; 
 Tue, 25 Apr 2023 06:08:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z/5PjVU1BDfVWhe5ZogmeG2QujfzTYbkQm7cIQds9gnOnNL45pBPkNdHk963LSlI0oVKLjJQ==
X-Received: by 2002:a5d:6a85:0:b0:303:a2e4:e652 with SMTP id
 s5-20020a5d6a85000000b00303a2e4e652mr10068917wru.14.1682428134946; 
 Tue, 25 Apr 2023 06:08:54 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 o4-20020a056000010400b002fa67f77c16sm13024173wrx.57.2023.04.25.06.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Apr 2023 06:08:54 -0700 (PDT)
Date: Tue, 25 Apr 2023 09:08:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230425090723-mutt-send-email-mst@kernel.org>
References: <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423065132-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230425041352-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723CE2A9B8BFA7963A66A98D4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230425082150-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723E38859953B6C531D3E5CD4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723E38859953B6C531D3E5CD4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

On Tue, Apr 25, 2023 at 01:02:38PM +0000, Alvaro Karsz wrote:
> > > In the virtnet case, we'll decide which features to block based on the ring size.
> > > 2 < ring < MAX_FRAGS + 2  -> BLOCK GRO + MRG_RXBUF
> > > ring < 2  -> BLOCK GRO + MRG_RXBUF + CTRL_VQ
> > 
> > why MRG_RXBUF? what does it matter?
> > 
> 
> You're right, it should be blocked only when ring < 2.
> Or we should let this pass, and let the device figure out that MRG_RXBUF is meaningless with 1 entry..

yep, later I think.

> > > So we'll need a new virtio callback instead of flags.
> > > Furthermore, other virtio drivers may decide which features to block based on parameters different than ring size (I don't have a good example at the moment).
> > > So maybe we should leave it to the driver to handle (during probe), and offer a virtio core function to re-negotiate the features?
> > >
> > > In the solution I'm working on, I expose a new virtio core function that resets the device and renegotiates the received features.
> > > + A new virtio_config_ops callback peek_vqs_len to peek at the VQ lengths before calling find_vqs. (The callback must be called after the features negotiation)
> > >
> > > So, the flow is something like:
> > >
> > > * Super early in virtnet probe, we peek at the VQ lengths and decide if we are
> > >    using small vrings, if so, we reset and renegotiate the features.
> > 
> > Using which APIs? What does peek_vqs_len do and why does it matter that
> > it is super early?
> > 
> 
> We peek at the lengths using a new virtio_config.h function that calls a transport specific callback.
> We renegotiate calling the new, exported virtio core function.
> 
> peek_vqs_len fills an array of u16 variables with the max length of every VQ.
> 
> The idea here is not to fail probe.
> So we start probe, check if the ring is small, renegotiate the features and then continue with the new features.
> This needs to be super early because otherwise, some virtio_has_feature calls before re-negotiating may be invalid, meaning a lot of reconfigurations.
> 
> > > * We continue normally and create the VQs.
> > > * We check if the created rings are small.
> > >    If they are and some blocked features were negotiated anyway (may occur if
> > >    the re-negotiation fails, or if the transport has no implementation for
> > >    peek_vqs_len), we fail probe.
> > >    If the ring is small and the features are ok, we mark the virtnet device as
> > >    vring_small and fixup some variables.
> > >
> > >
> > > peek_vqs_len is needed because we must know the VQ length before calling init_vqs.
> > >
> > > During virtnet_find_vqs we check the following:
> > > vi->has_cvq
> > > vi->big_packets
> > > vi->mergeable_rx_bufs
> > >
> > > But these will change if the ring is small..
> > >
> > > (Of course, another solution will be to re-negotiate features after init_vqs, but this will make a big mess, tons of things to clean and reconfigure)
> > >
> > >
> > > The 2 < ring < MAX_FRAGS + 2 part is ready, I have tested a few cases and it is working.
> > >
> > > I'm considering splitting the effort into 2 series.
> > > A 2 < ring < MAX_FRAGS + 2  series, and a follow up series with the ring < 2 case.
> > >
> > > I'm also thinking about sending the first series as an RFC soon, so it will be more broadly tested.
> > >
> > > What do you think?
> > 
> > Lots of work spilling over to transports.
> > 
> > And I especially don't like that it slows down boot on good path.
> 
> Yes, but I don't think that this is really significant.
> It's just a call to the transport to get the length of the VQs.

With lots of VQs that is lots of exits.

> If ring is not small, we continue as normal.
> If ring is small, we renegotiate and continue, without failing probe.
> 
> > 
> > I have the following idea:
> > - add a blocked features value in virtio_device
> > - before calling probe, core saves blocked features
> > - if probe fails, checks blocked features.
> >   if any were added, reset, negotiate all features
> >   except blocked ones and do the validate/probe dance again
> > 
> > 
> > This will mean mostly no changes to drivers: just check condition,
> > block feature and fail probe.
> > 
> 
> I like the idea, will try to implement it.
> 
> Thanks,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
