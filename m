Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D75FC433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 06:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6B55409BC;
	Tue, 17 May 2022 06:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yGcNBeaqnzaA; Tue, 17 May 2022 06:32:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E6DD408FE;
	Tue, 17 May 2022 06:32:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7F15C0039;
	Tue, 17 May 2022 06:32:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D56DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A07D40BB6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0naOwIEUTlX1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:32:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 777E140BB5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652769134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tyrw7Fs5af1WocF+1NFu5sorailBB9qMhsdDA/eQUgs=;
 b=YUYNagvkuYIXft2zKJ5teBun/WeHFyeZn959jLqOiNgho0o7QZx4cFIFLCqvQlK+nh0McO
 ZfD6Xsb5snIn+u9eVXOb9upXUK9rU2AQFZGuPRuk+C4mTjADlpUrdlHPEbZoyMeBC29AMD
 f1MeFLbIJ+qyCdwk2dTs6EaalmahOZA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-lNtg9ocOMTqtmY5DRTssUA-1; Tue, 17 May 2022 02:32:13 -0400
X-MC-Unique: lNtg9ocOMTqtmY5DRTssUA-1
Received: by mail-lj1-f198.google.com with SMTP id
 e17-20020a2e9851000000b00253bc1c3232so93355ljj.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 23:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tyrw7Fs5af1WocF+1NFu5sorailBB9qMhsdDA/eQUgs=;
 b=6LFUCA3dTEE+gw8o6lHQDqBxksB1IoWEIEPKByD0jfJNuGPEsjUZyYxXFXniFu1BzH
 LP9eyXGKdniQGUUXhHB2+7LT429bxPMmS0iID2Wn16BfwDnQC9FW/BcOzCG1vRJNjTv6
 LMiEg8O81J7HtF0isnN+qxkZH71kkHlKtpZP2TG6j01ZcBY+VFVt7+bghTqafCucT7H2
 SO8dlWT0wW5pLbPZej226U/fwtWPhMIbonRKqy73SVK1rtjnUDJglJCoJ9CGFhGr24k+
 gVizDtUr0KG4RjLqhgCfvxjgIE13Kx1bTKDTgJUtTwLGHeka1mVd8olb17Tp7yvsn41u
 D0Hw==
X-Gm-Message-State: AOAM5316GJANHi4sb7D4LlTMjFzSbPbN8wBOmpqXg40BsxyIC8lmawbA
 wtoQQnCQIbi3WASfGEr7x5fqFjkuDZO3gE50DM4nbuDopeUx04/0hxF/C35kXiO8NE0W0nqn4W2
 xKtvrfpup0jFAZb0j82aEpWfjvVuQZOUQ86a+ZWe6Pd9sDXhpoCf3xO10Og==
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr15703945lfg.98.1652769131488; 
 Mon, 16 May 2022 23:32:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6g8tOmupVRqttN7WDRP44n6fuYeMH5lXesAtmPnbagzn8zytd8vAd7VMUwdVlbWPpI9ns+9bblO+ugjvA7ZM=
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr15703935lfg.98.1652769131310; Mon, 16
 May 2022 23:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220512112347.18717-1-andrew@daynix.com>
In-Reply-To: <20220512112347.18717-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 May 2022 14:32:00 +0800
Message-ID: <CACGkMEvH1yE0CZYdstAK32DkEucejNO+V7PEAZD_641+rp2aKA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] TUN/VirtioNet USO features support.
To: Andrew Melnychenko <andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Dumazet <edumazet@google.com>, Yan Vugenfirer <yan@daynix.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Thu, May 12, 2022 at 7:33 PM Andrew Melnychenko <andrew@daynix.com> wrote:
>
> Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> Technically they enable NETIF_F_GSO_UDP_L4
> (and only if USO4 & USO6 are set simultaneously).
> It allows to transmission of large UDP packets.
>
> Different features USO4 and USO6 are required for qemu where Windows guests can
> enable disable USO receives for IPv4 and IPv6 separately.
> On the other side, Linux can't really differentiate USO4 and USO6, for now.
> For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> In the future, there would be a mechanism to control UDP_L4 GSO separately.
>
> Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
>
> New types for VirtioNet already on mailing:
> https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
>
> Also, there is a known issue with transmitting packages between two guests.

Could you explain this more? It looks like a bug. (Or any pointer to
the discussion)

Thanks

> Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
>
> Andrew (5):
>   uapi/linux/if_tun.h: Added new offload types for USO4/6.
>   driver/net/tun: Added features for USO.
>   uapi/linux/virtio_net.h: Added USO types.
>   linux/virtio_net.h: Support USO offload in vnet header.
>   drivers/net/virtio_net.c: Added USO support.
>
>  drivers/net/tap.c               | 10 ++++++++--
>  drivers/net/tun.c               |  8 +++++++-
>  drivers/net/virtio_net.c        | 19 +++++++++++++++----
>  include/linux/virtio_net.h      |  9 +++++++++
>  include/uapi/linux/if_tun.h     |  2 ++
>  include/uapi/linux/virtio_net.h |  4 ++++
>  6 files changed, 45 insertions(+), 7 deletions(-)
>
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
