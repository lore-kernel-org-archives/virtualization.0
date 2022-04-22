Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2132C433F5
	for <virtualization@archiver.kernel.org>; Fri, 22 Apr 2022 21:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51F0A61083;
	Fri, 22 Apr 2022 21:40:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7FPa4n5txBpG; Fri, 22 Apr 2022 21:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E2CB4610B6;
	Fri, 22 Apr 2022 21:40:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABFB1C0032;
	Fri, 22 Apr 2022 21:40:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3DC1C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 21:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A567832B0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 21:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EGntoABglAD8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 21:40:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFB3782EA2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 21:40:27 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id b17so7021686qvp.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 14:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X3jmrp9pTRv13ERfd24S+BNAmPr2s08tVQATG4YHUlI=;
 b=PeMUPreV4X4m1QbrqoSErYIw7TY5RJtJFjtE3UvbI9L1JGck3l52g90PJqKpnjpsmx
 AM8SY/SgMDx4z+tVUcRPKc1qzvY4v7r/lIvCcQA974wNPSyyEPY9V4pQ8VZ1o9QSNdow
 LQOp2w+WFFa7UE6LV3OR1n3ZdzId36u/hsWhXmE+C77KgXOC5wRRAgOIX3wJ/Os5JCCf
 +HrZRIemdwA2FSOI51ix1h6aNF3vgkSEY4XiNiRPsChiM4v9DHPUxbyvPn6PY7U9LIYe
 GrLZ2cjNFpmq0TXgkXgs3AbY7WgVpMjq8yiNFu3pDAqeiZnRi/MGBF27u5WKHrN+qpGo
 ncdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X3jmrp9pTRv13ERfd24S+BNAmPr2s08tVQATG4YHUlI=;
 b=f4bdlFhyW5nV78+6kZDOUrRnNzWDgwha73HcQnK/zf9aaqo+c/P703T9raHbk8mTVo
 22nuBZ1fRo9vAzDMizGs663ahTNVrRtLM3yuKR9ncr/G0ECxPkzmIVEUP7bvoOA039lM
 B6I1aeA3n7SxdttZQXDWtN83zvKiv+iPceHT4zsrv/nwMAXqZI6mlkhahn9uotizEc9J
 BWq6bWgbKNaAV0aF8QKXc95sOg2aUz/MRrSI3XrtTjzEJPXy2ZnzJ5VmWz9kRGWO3yix
 QFgBbrEL0iTTBBTXm5T+Oa00q0iVLpGUEEMRk7g1VrBrPRJaRpCc2Llfmm+pBlvH7kAz
 8DOQ==
X-Gm-Message-State: AOAM532xXeOnUSiQX16yKo3l+4hPN2H9kIzAbxWOWJDMqvCaSOUqn87R
 B3mmQ53gzV91PP6kxLIjTak+cPW33+s=
X-Google-Smtp-Source: ABdhPJwMuVW/Tpk7B7JUs2CYpFwYybYduexOCbsIyQCEIlp4T6J1c4lf4PmKDfhBneJUMuYYjnsFvA==
X-Received: by 2002:a05:6214:19e3:b0:446:4b26:ae10 with SMTP id
 q3-20020a05621419e300b004464b26ae10mr5234135qvc.76.1650663626605; 
 Fri, 22 Apr 2022 14:40:26 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com.
 [209.85.219.171]) by smtp.gmail.com with ESMTPSA id
 n73-20020a37a44c000000b0069ebd4a0affsm1470083qke.24.2022.04.22.14.40.25
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Apr 2022 14:40:26 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id w187so7401208ybe.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 14:40:25 -0700 (PDT)
X-Received: by 2002:a25:b94a:0:b0:644:db14:ff10 with SMTP id
 s10-20020a25b94a000000b00644db14ff10mr6458202ybm.648.1650663625249; Fri, 22
 Apr 2022 14:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220420082758.581245-1-liuhangbin@gmail.com>
 <CA+FuTScyF4BKEcNSCYOv8SBA_EmB806YtKA17jb3F+fymVF-Pg@mail.gmail.com>
 <YmDCHI330AUfcYKa@Laptop-X1>
 <CA+FuTSckEJVUH1Q2vBxGbfPgVteyDVmTfjJC6hBj=qRP+JcAxA@mail.gmail.com>
 <YmIOLBihyeLy+PCS@Laptop-X1>
In-Reply-To: <YmIOLBihyeLy+PCS@Laptop-X1>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 22 Apr 2022 17:39:48 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfzcAUXrxzbLd-MPctTyLu8USJQ4gvsqPBfLpA+svYMYA@mail.gmail.com>
Message-ID: <CA+FuTSfzcAUXrxzbLd-MPctTyLu8USJQ4gvsqPBfLpA+svYMYA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/af_packet: add VLAN support for AF_PACKET
 SOCK_RAW GSO
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, virtualization@lists.linux-foundation.org,
 Balazs Nemeth <bnemeth@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mike Pattrick <mpattric@redhat.com>,
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

On Thu, Apr 21, 2022 at 10:10 PM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> Hi Willem,
> On Thu, Apr 21, 2022 at 10:15:16AM -0400, Willem de Bruijn wrote:
> > Your approach does sound simpler than the above. Thanks for looking
> > into that alternative, though.
>
> Sorry I have to bring this topic back. I just remembered that
> tpacket_snd() already called skb_probe_transport_header() before calling
> virtio_net_hdr_* functions. e.g.
>
> - tpacket_snd()
>   - tpacket_fill_skb()
>     - packet_parse_headers()
>       - skb_probe_transport_header()
>   - if (po->has_vnet_hdr)
>     - virtio_net_hdr_to_skb()
>     - virtio_net_hdr_set_proto()
>
> While for packet_snd()
>
> - packet_snd()
>   - if (has_vnet_hdr)
>     - virtio_net_hdr_to_skb()
>     - virtio_net_hdr_set_proto()
>   - packet_parse_headers()
>     - skb_probe_transport_header()
>
> If we split skb_probe_transport_header() from packet_parse_headers() and
> move it before calling virtio_net_hdr_* function in packet_snd(). Should
> we do the same for tpacket_snd(), i.e. move skb_probe_transport_header()
> after the virtio_net_hdr_* function?

That sounds like the inverse: "move after" instead of "move before"?

But I thought the plan was to go back to your last patch which brings
packet_snd in line with tpacket_snd by moving packet_parse_headers in
its entirety before virtio_net_hdr_*?

> I think it really doesn't matter whether calls skb_probe_transport_header()
> before or after virtio_net_hdr_* functions if we could set the skb->protocol
> and network header correctly. Because
>
> - skb_probe_transport_header()
>   - skb_flow_dissect_flow_keys_basic()
>     - __skb_flow_dissect()
>
> In __skb_flow_dissect()
> ```
>  * @data: raw buffer pointer to the packet, if NULL use skb->data
>  * @proto: protocol for which to get the flow, if @data is NULL use skb->protocol
>  * @nhoff: network header offset, if @data is NULL use skb_network_offset(skb)
>  * @hlen: packet header length, if @data is NULL use skb_headlen(skb)
> ```
>
> So when data is NULL, we need to make sure the protocol, network header offset,
> packet header length are correct.
>
> Before this patch, the VLAN packet network header offset is incorrect when calls
> skb_probe_transport_header(). After the fix, this issue should be gone
> and we can call skb_probe_transport_header() safely.
>
> So my conclusion is. There is no need to split packet_parse_headers(). Move
> packet_parse_headers() before calling virtio_net_hdr_* function in packet_snd()
> should be safe.

Ack. Sorry if my last response was not entirely clear on this point.

> Please pardon me if I didn't make something clear.
> Let's me know what do you think.
>
> Thanks
> Hangbin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
