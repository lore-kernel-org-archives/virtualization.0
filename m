Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DB7C6379F
	for <virtualization@archiver.kernel.org>; Fri, 13 Jan 2023 23:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1171417DC;
	Fri, 13 Jan 2023 23:24:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1171417DC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UGm5XVLZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q_Unjw-NV-xx; Fri, 13 Jan 2023 23:24:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D83FF415E2;
	Fri, 13 Jan 2023 23:24:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D83FF415E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92350C0032;
	Fri, 13 Jan 2023 23:24:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E4B9C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 23:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D994C81FB7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 23:24:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D994C81FB7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=UGm5XVLZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3QOH4dsq8oVd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 23:24:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 235A281F02
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 235A281F02
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 23:24:18 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id s3so14741773pfd.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 15:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FNBX4IUuGCsk3iScEzWUZQTuYhBGbsHeymdyFMhVUUo=;
 b=UGm5XVLZ/Pf8mEHaqhlTVc3mvoLqx4t5aN0Wq+EvFeDu4Ou3DksaHCq7Xqnlg+tssg
 4Op9MTtWSCHUqbsMVchfpEiR+Wyy4OuwH2SLwpXFMArzD0NdBM5znXELBDVhrsb4TfZi
 ea1zK0tu8FHtrdqaKd+QsMwx8eFMe7/tZPIsY5C1iedYStuFXaMQQ0D7VXzh0NxRP4KY
 33w0BLROdaySpI6EBCG34nzgD+Ae6gAB1ORh3waKXitbQry6FVCTl8IvP9yml1+Olxt3
 zjKBAE/UzhKowPcL6KkcffuMCK1XdIQH4WSIGJ2uJuVFrc5tbYN7QDEiePkrMAbMivK2
 dJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FNBX4IUuGCsk3iScEzWUZQTuYhBGbsHeymdyFMhVUUo=;
 b=TNFN5hcC8AUur2sDsRGfmtlBncaG42hxiN5aIu5Oqhhu3h1nOc++Xi/xWEHGQxTq5D
 leuGIwjplRW5xgT9kQAvkfe8NXGAOOEqv2GLlfKcXLVkF85C5T56EQHnkrXb3/SXiQ2u
 39QB0cbUgQ0vl/lY855RljCBb1DV8kaVqHu4GWv68k6XwUOtVE0P2RFl5khOLQYYXE/a
 Jz8awGbFWF3RYdTN7tiYzHa2k0jCoNnUVxHCfx2IsbtrAZxpvqmCVbg/uYQqE45YECx7
 Hm19c32W1oOXux4VsKbwUOeDcxHvEFO6ZbsgKVA4WcoaMi6WAgazj7sMiV3VfSk7Apes
 +rjA==
X-Gm-Message-State: AFqh2kqVHzPI+1UukfGmVJb6ncBhBklIfm9SLRdCdcavq3wS0hKtxYCm
 eumjMOgmKBsvL5szSqaDejg=
X-Google-Smtp-Source: AMrXdXuHNLwKi8xWKTozMMZzYnETcsNN3hEIwBwD19VFIxtKaNulpVxuR8G0u7nnncfhnRzChZEApA==
X-Received: by 2002:aa7:9143:0:b0:580:cfbd:3fd3 with SMTP id
 3-20020aa79143000000b00580cfbd3fd3mr76390862pfi.26.1673652257329; 
 Fri, 13 Jan 2023 15:24:17 -0800 (PST)
Received: from [192.168.0.128] ([98.97.117.20])
 by smtp.googlemail.com with ESMTPSA id
 n125-20020a622783000000b00582cb9deb5asm14602446pfn.176.2023.01.13.15.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jan 2023 15:24:16 -0800 (PST)
Message-ID: <92b98f45dcd65facac78133c6250d9d96ea1a25f.camel@gmail.com>
Subject: Re: [PATCH net-next 1/2] virtio_net: Fix short frame length check
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, jasowang@redhat.com, 
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Date: Fri, 13 Jan 2023 15:24:15 -0800
In-Reply-To: <20230113223619.162405-2-parav@nvidia.com>
References: <20230113223619.162405-1-parav@nvidia.com>
 <20230113223619.162405-2-parav@nvidia.com>
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
Cc: edumazet@google.com, pabeni@redhat.com,
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

On Sat, 2023-01-14 at 00:36 +0200, Parav Pandit wrote:
> A smallest Ethernet frame defined by IEEE 802.3 is 60 bytes without any
> preemble and CRC.
> 
> Current code only checks for minimal 14 bytes of Ethernet header length.
> Correct it to consider the minimum Ethernet frame length.
> 
> Fixes: 296f96fcfc16 ("Net driver using virtio")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..d45e140b6852 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1248,7 +1248,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	struct sk_buff *skb;
>  	struct virtio_net_hdr_mrg_rxbuf *hdr;
>  
> -	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> +	if (unlikely(len < vi->hdr_len + ETH_ZLEN)) {
>  		pr_debug("%s: short packet %i\n", dev->name, len);
>  		dev->stats.rx_length_errors++;
>  		if (vi->mergeable_rx_bufs) {

I'm not sure I agree with this change as packets are only 60B if they
have gone across the wire as they are usually padded out on the
transmit side. There may be cases where software routed packets may not
be 60B.

As such rather than changing out ETH_HLEN for ETH_ZLEN I wonder if we
should look at maybe making this a "<=" comparison instead since that
is the only case I can think of where the packet would end up being
entirely empty after eth_type_trans is called and we would be passing
an skb with length 0.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
