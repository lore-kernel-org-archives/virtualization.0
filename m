Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C411CC64EC4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 15:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 46BF14049B;
	Mon,  6 Mar 2023 15:51:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46BF14049B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IDGY3v4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YBFq53cG5VRD; Mon,  6 Mar 2023 15:51:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 491E4400F2;
	Mon,  6 Mar 2023 15:51:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 491E4400F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20DA7C0035;
	Mon,  6 Mar 2023 15:51:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4CE3C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 15:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C99D41527
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 15:51:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C99D41527
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IDGY3v4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b83rn3Rpk1JV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 15:51:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD94C4151F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD94C4151F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678117888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q86XLZ7Q4ZHp1CUGcCN/NjLhC2ggJRWLx1s//bOcLDM=;
 b=IDGY3v4CGTQZ5idFWVW87EHcy0lVva+Ckm1QP33JE4zD1o0xlMWDuXOwOCDMlbt0PLkbsw
 cuVE2g+sX2EJtbLsfVEBTjN60pf/ea00y0B1DV8muqwcvqkb291HZ7z4hWMKGOsuizk4Rt
 32ElIB+cwlfCStYB3uVtvK3uVAFrA3w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-LMmpyLvIN4OT4HaOHagfIw-1; Mon, 06 Mar 2023 10:51:27 -0500
X-MC-Unique: LMmpyLvIN4OT4HaOHagfIw-1
Received: by mail-qt1-f197.google.com with SMTP id
 g13-20020ac8124d000000b003bfba5d76a3so5400281qtj.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 07:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678117887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q86XLZ7Q4ZHp1CUGcCN/NjLhC2ggJRWLx1s//bOcLDM=;
 b=JEiIXEpdOsLcYnSDu382TCf7tJaBU0+emsRuEwfGrtg4uYFkv76yDW0nT7DQ0avKwt
 r5dga2v1lNQOsOICHrQGrHhNQZ5cKxXv9lPCTyEAiyHK/tm/7hkYfGct4Zs+IZfEr6HC
 lJ3gvRXvWEz0Zaxe1UfH/Nwj9pfC01MYESrM8ct2qCexUvMAZJePgsTjKvhuEJhKhGhL
 JLPZDKfiXjJCMELeWRa5MrnnguCkPqaL/iGOD79TPF5665vUOqOsW+rvWQHe7mIndKqp
 LzVYu61bNhLoOQR+s6qZxy0VXu/BcmKHfi7+Pg80H+aV/MbvsJRSEzqhl3+SkhDV4fgs
 U2+Q==
X-Gm-Message-State: AO0yUKXMctJ1ThQrGhrKBL1b+ZrZ1xbdYfoPzGFBkGiaDIcxJ0tgcYtK
 AorcYd3icEbbNJdYgS1/Px8OLFEBu1fyjFNPapfa3CUFmXYBgRVzyxgf6Q2v6SgNjgjRvTv7fyU
 0wG3FFDiN7YJpSwJp0Cc/k60AYmlU+z9mjS8bpX6kTg==
X-Received: by 2002:a05:622a:c:b0:3b9:bc8c:c207 with SMTP id
 x12-20020a05622a000c00b003b9bc8cc207mr26969678qtw.18.1678117886723; 
 Mon, 06 Mar 2023 07:51:26 -0800 (PST)
X-Google-Smtp-Source: AK7set8J+A3R80v+MVqfE2WCygPas52Ry5LmPSFlnPMQvzMyOQV6nh5+6ZCsftO+pkisfBFlvJJ58Q==
X-Received: by 2002:a05:622a:c:b0:3b9:bc8c:c207 with SMTP id
 x12-20020a05622a000c00b003b9bc8cc207mr26969642qtw.18.1678117886394; 
 Mon, 06 Mar 2023 07:51:26 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 q17-20020ac84111000000b003bfa52112f9sm7805681qtl.4.2023.03.06.07.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Mar 2023 07:51:25 -0800 (PST)
Date: Mon, 6 Mar 2023 16:51:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 2/4] virtio/vsock: remove all data from sk_buff
Message-ID: <20230306155121.7xwxzgxtle7qjbnc@sgarzare-redhat>
References: <a7ab414b-5e41-c7b6-250b-e8401f335859@sberdevices.ru>
 <dfadea17-a91e-105f-c213-a73f9731c8bd@sberdevices.ru>
 <20230306120857.6flftb3fftmsceyl@sgarzare-redhat>
 <b18e3b13-3386-e9ee-c817-59588e6d5fb6@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <b18e3b13-3386-e9ee-c817-59588e6d5fb6@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 06, 2023 at 06:31:22PM +0300, Arseniy Krasnov wrote:
>
>
>On 06.03.2023 15:08, Stefano Garzarella wrote:
>> On Sun, Mar 05, 2023 at 11:07:37PM +0300, Arseniy Krasnov wrote:
>>> In case of SOCK_SEQPACKET all sk_buffs are used once - after read some
>>> data from it, it will be removed, so user will never read rest of the
>>> data. Thus we need to update credit parameters of the socket like whole
>>> sk_buff is read - so call 'skb_pull()' for the whole buffer.
>>>
>>> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/virtio_transport_common.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Maybe we could avoid this patch if we directly use pkt_len as I
>> suggested in the previous patch.
>Hm, may be we can avoid calling 'skb_pull()' here if 'virtio_transport_dec_rx_pkt()'
>will use integer argument?

Yep, exactly!

>Just call 'virtio_transport_dec_rx_pkt(skb->len)'. skb

It depends on how we call virtio_transport_inc_rx_pkt(). If we use
hdr->len there I would use the same to avoid confusion. Plus that's the
value the other peer sent us, so definitely the right value to increase
fwd_cnt with. But if skb->len always reflects it, then that's fine.

>is never returned to queue to read it again, so i think may be there is no sense for
>extra call 'skb_pull'?

Right!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
