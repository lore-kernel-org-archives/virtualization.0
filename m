Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0435DC433FE
	for <virtualization@archiver.kernel.org>; Tue, 19 Apr 2022 14:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64B2441962;
	Tue, 19 Apr 2022 14:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0DdHE4rT6Wa1; Tue, 19 Apr 2022 14:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A00EE4194A;
	Tue, 19 Apr 2022 14:26:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BA22C002F;
	Tue, 19 Apr 2022 14:26:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B604C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 14:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ABC740102
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 14:26:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SiL0o33AFF0Z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 14:26:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99FC3400E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650378378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8s+pPGRz1Zr2HimXdsiESRrW1tRMdv6YKimHzq2vGb8=;
 b=G/s+A9SzgB0iY5K/FSB0Q53ahcjCpJUWfzUHjaooZejLSrADLS/7McLYXJpktQoS3A2+HS
 JBOu7Lq3ykUf3321+fnjZvxWSM/BEWzAfdwiIdsUNb93g+bGanvoC1O0x0bb1KD+0E96Ng
 R+TsHIfg46YlpBoPV3r8VW8IlL6nw1M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-e6D3-aeZNYKFTO8GJwWAoQ-1; Tue, 19 Apr 2022 10:26:15 -0400
X-MC-Unique: e6D3-aeZNYKFTO8GJwWAoQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 p21-20020a1c5455000000b0038ff4f1014fso6488345wmi.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 07:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8s+pPGRz1Zr2HimXdsiESRrW1tRMdv6YKimHzq2vGb8=;
 b=IdkF3kFO0rHDO91+e1PBdG8gr//bs/mMDdVE04N9tOprBqM11AbbL2KQAb1P6kZMG0
 P8tilY2d4qFtUJ0ke26bpL+Xei67mIMTfgYxMXdoR+UkKVW4wy9pLW/+WFbRfH9PJnlo
 sDvMxCavWEr/tXoD9EvOgVc13aLBnlixjpbbSKKYhSXl8JwMQSs4c+IHtS96kUaxhUVC
 FWD5ui78I6tHiS8jUYQudi/7OEbmOzYjcm8Q05meCg3WmjGUWW78NT31HizB/ifZ1llV
 HMiQxjS5SDw8+owo2o7gX10L3LKuupUr+FRE+0cSALe/nzrzO1cLgUQO3dKauizSepoD
 GxaA==
X-Gm-Message-State: AOAM531KAJ16xJtlxP1cTS/XZRoQjUj6oLXJfV9KfuplfzdPmQDjuQ48
 Z7XcHm+cgvqUjIuzRIZWVe0sJGDxROxDjWA1f2t6cGYGc/us/cmjQPfkjszaVMAdWdZixfXOrPX
 GVTjbKSwojeFzFcP9k1l05ogMpc6Xe7XQKZtjm3n/cw==
X-Received: by 2002:a5d:584c:0:b0:20a:821a:b393 with SMTP id
 i12-20020a5d584c000000b0020a821ab393mr12389243wrf.141.1650378374117; 
 Tue, 19 Apr 2022 07:26:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqeCv7YzF+w0wTnLztCkQOTZj9S/cIJHLdA9pOMdkh9Lf6AZp3WzsHpWOUjonfL25Rwue5jw==
X-Received: by 2002:a5d:584c:0:b0:20a:821a:b393 with SMTP id
 i12-20020a5d584c000000b0020a821ab393mr12389217wrf.141.1650378373868; 
 Tue, 19 Apr 2022 07:26:13 -0700 (PDT)
Received: from redhat.com ([2.53.17.80]) by smtp.gmail.com with ESMTPSA id
 i6-20020a0560001ac600b0020a93f75030sm5602953wry.48.2022.04.19.07.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 07:26:13 -0700 (PDT)
Date: Tue, 19 Apr 2022 10:26:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net 1/2] net/af_packet: adjust network header position
 for VLAN tagged packets
Message-ID: <20220419101325-mutt-send-email-mst@kernel.org>
References: <20220418044339.127545-1-liuhangbin@gmail.com>
 <20220418044339.127545-2-liuhangbin@gmail.com>
 <CA+FuTScQ=tP=cr5f2S97Z7ex1HMX5R-C0W6JE2Bx5UWgiGknZA@mail.gmail.com>
 <Yl4mU0XLmPukG0WO@Laptop-X1>
 <CA+FuTSfBU7ck91ayf_t9=7eRGJZHuWSeXzX2SxFAQMPSitY9SA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSfBU7ck91ayf_t9=7eRGJZHuWSeXzX2SxFAQMPSitY9SA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Balazs Nemeth <bnemeth@redhat.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Flavio Leitner <fbl@redhat.com>, Mike Pattrick <mpattric@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
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

On Tue, Apr 19, 2022 at 09:56:02AM -0400, Willem de Bruijn wrote:
> > >
> > > We should also maintain feature consistency between packet_snd,
> > > tpacket_snd and to the limitations of its feature set to
> > > packet_sendmsg_spkt. The no_fcs is already lacking in tpacket_snd as
> > > far as I can tell. But packet_sendmsg_spkt also sets it and calls
> > > packet_parse_headers.
> >
> > Yes, I think we could fix the tpacket_snd() in another patch.
> >
> > There are also some duplicated codes in these *_snd functions.
> > I think we can move them out to one single function.
> 
> Please don't refactor this code. It will complicate future backports
> of stable fixes.

Hmm I don't know offhand which duplication this refers to specifically
so maybe it's not worth addressing specifically but generally not
cleaning up code just because of backports seems wrong ...

> > > Because this patch touches many other packets besides the ones
> > > intended, I am a bit concerned about unintended consequences. Perhaps
> >
> > Yes, makes sense.
> >
> > > stretching the definition of the flags to include VLAN is acceptable
> > > (unlike outright tunnels), but even then I would suggest for net-next.
> >
> > As I asked, I'm not familiar with virtio code. Do you think if I should
> > add a new VIRTIO_NET_HDR_GSO_VLAN flag? It's only a L2 flag without any L3
> > info. If I add something like VIRTIO_NET_HDR_GSO_VLAN_TCPV4/TCPV6/UDP. That
> > would add more combinations. Which doesn't like a good idea.
> 
> I would prefer a new flag to denote this type, so that we can be
> strict and only change the datapath for packets that have this flag
> set (and thus express the intent).
> 
> But the VIRTIO_NET_HDR types are defined in the virtio spec. The
> maintainers should probably chime in.

Yes, it's a UAPI extension, not to be done lightly. In this case IIUC
gso_type in the header is only u8 - 8 bits and 5 of these are already
used.  So I don't think the virtio TC will be all that happy to burn up
a bit unless a clear benefit can be demonstrated. 

I agree with the net-next proposal, I think it's more a feature than a
bugfix. In particular I think a Fixes tag can also be dropped in that
IIUC GSO for vlan packets didn't work even before that commit - right?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
