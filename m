Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9C3C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 13:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A99381FF9;
	Wed, 21 Dec 2022 13:02:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A99381FF9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FaTz93ze
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5WImosOjl67g; Wed, 21 Dec 2022 13:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C383D81F2E;
	Wed, 21 Dec 2022 13:02:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C383D81F2E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 933CEC007D;
	Wed, 21 Dec 2022 13:02:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB026C007C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D93E81F37
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:02:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D93E81F37
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Undde1y7hg1O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:02:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB3BC81F2E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB3BC81F2E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671627722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=852DXzEOwNu2hlEhdNit1/MeucSNEq0R96SaREh4kyg=;
 b=FaTz93zeftGEWA1433FeRgPK9SO7vrx9t0JRG9mucOzRPK8zq1HRk67/dFB44xANmh6d1C
 Yjkz1eiO5lENy3hU91/frehWfV4ecu/jZZvHyPWxrK233h0DlJEhG3bFjhvupixuxftimg
 oQ6OJuVVnuaMYnboGtZ9xdLKiVMGHXo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-214-YqZ9-OBPPj-F02rQkkI9hg-1; Wed, 21 Dec 2022 08:01:58 -0500
X-MC-Unique: YqZ9-OBPPj-F02rQkkI9hg-1
Received: by mail-wm1-f69.google.com with SMTP id
 t24-20020a1c7718000000b003d1fd0b866fso667437wmi.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 05:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=852DXzEOwNu2hlEhdNit1/MeucSNEq0R96SaREh4kyg=;
 b=HHgVSFTIpEb6AIt9XHY+hi+8mtMQFYnfWLWBNah3Y2+DYUPbsF73+csZzkrVLrChO+
 Ep0oYOIwcfBuc2u4YV72H/3r4C0K9/6jAYhdW4IfuzdbZH/gCR9ks1RmZmpuDnBbobOD
 iWH31FsQCjbmbMAWfckbIYHe0o3eQ+JBWClGqp0CUIwauR7sFVziSeIK1lFeHqHg+wxB
 j3qThfzRZ0wnMXSmQxPQxHb4vQgsHLIHQB66RdzcMhX9fPqWI2oRPrbonX2Ai9PHb9Rw
 6kSfnBSaLCtPVzFkrZBZcb2L+HuhRzoVy+qyezom6U0RZ20PaYRYFfgFhV3q8riaiTyh
 uxgQ==
X-Gm-Message-State: AFqh2kr9dfcFJzz9iPyM9P3mmMRw5wNlGFR/vWRK6V80HRfvXCOFBrTT
 1iYzCBjkA6se+/5Sy73azUH595HBGFu4Wb6jg+LwEtmhhncTG8Ga46o6OhGkkRin5Lwjyb5JbUO
 qo4sxpQOh35LuTPd5JuWex74dQfi/5vrcns5yZ3jW0Q==
X-Received: by 2002:a5d:624d:0:b0:242:4d70:7882 with SMTP id
 m13-20020a5d624d000000b002424d707882mr1176213wrv.15.1671627717204; 
 Wed, 21 Dec 2022 05:01:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu3XJelFbQ4KH+zuEovnB6boe7747MwowEHosMNJ0THlvllnIdgYSkeLe4VLs3EJjdf2C7jcQ==
X-Received: by 2002:a5d:624d:0:b0:242:4d70:7882 with SMTP id
 m13-20020a5d624d000000b002424d707882mr1176194wrv.15.1671627716932; 
 Wed, 21 Dec 2022 05:01:56 -0800 (PST)
Received: from redhat.com ([2.52.8.61]) by smtp.gmail.com with ESMTPSA id
 d4-20020adfe884000000b00228cbac7a25sm15210244wrm.64.2022.12.21.05.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 05:01:56 -0800 (PST)
Date: Wed, 21 Dec 2022 08:01:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio_net: send notification coalescing command only if
 value changed
Message-ID: <20221221075855-mutt-send-email-mst@kernel.org>
References: <20221221120618.652074-1-alvaro.karsz@solid-run.com>
 <20221221073256-mutt-send-email-mst@kernel.org>
 <CAJs=3_CVUydOpH=a-RJLWUQ0_1EbkwKtGD2F3Xvw=dR5QFXP5g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_CVUydOpH=a-RJLWUQ0_1EbkwKtGD2F3Xvw=dR5QFXP5g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Dec 21, 2022 at 02:44:21PM +0200, Alvaro Karsz wrote:
> > Why do we bother? Resending needs more code and helps
> > reliability ...
> 
> It just seems unnecessary.
> If a user changes just one parameter:
> $ ethtool -C <iface> tx-usecs 30
> It will trigger 2 commands, including
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, even though no rx parameter changed.
> 
> If we'll add more ethtool coalescing parameters, changing one of the
> new parameter will trigger meaningless
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> commands.
> 
> Alvaro

We'll always just do 2 commands, right?
I don't think we should bother at this point.
It might not be completely redundant.
E.g. if a card lost the config resending it might help fix things.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
