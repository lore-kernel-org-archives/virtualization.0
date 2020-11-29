Return-Path: <SRS0=PU37=FD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB4BC3E8C5
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 20:11:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38D320756
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 20:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgqrcyFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38D320756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B10F68723E;
	Sun, 29 Nov 2020 20:11:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gehPgRxnYMHv; Sun, 29 Nov 2020 20:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3FF3187222;
	Sun, 29 Nov 2020 20:11:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 224D5C0859;
	Sun, 29 Nov 2020 20:11:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56596C0052
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 20:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4B871871A5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 20:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g8EXqstdUeC0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 20:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 717CB87199
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 20:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606680711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaOiU6gv3Cl3SmrnFPxyyv/QzuHHKMlBz/t6xjcea8E=;
 b=XgqrcyFlLQ6ZlClbzNxKHUywKY2xwbcJZxvdadNzOtZnF14gToDZL8TYFB/RnamiNSzlMy
 gw83QwbwopH5W5vaH5TdQE9U146BdG4jtu4NeLp5kK7FS3JYVkoyTDQkuRhaaHeXxfhSTX
 xjAyEZElN8/LdfTrSpPIlu7IlcVMSMg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-JvycsjQOMCytwk8g9R6bLA-1; Sun, 29 Nov 2020 15:11:47 -0500
X-MC-Unique: JvycsjQOMCytwk8g9R6bLA-1
Received: by mail-wr1-f71.google.com with SMTP id d1so7131241wrn.23
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 12:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zaOiU6gv3Cl3SmrnFPxyyv/QzuHHKMlBz/t6xjcea8E=;
 b=Our44UnC6iQLS9jOvdBdF+lZeEdg+B3JGJYoFIE+6BwnioSJj16gjiioH3qOyNuV4G
 LqrgmPOanvK7F2tEPsLcJR+C66XQ7BsJn57fr+tSxs4PrfjLb622h14tMZMwL68OSVwD
 4VWL5ONBCh3eX4v6b2fdXhITkOOBlbFKtjBDzrZtxMGOZEL/Ia44P+cl+PaYQoQR3atr
 v48Emv4uz11zXv5V1obnNdEIfmcQmE03BYmCfD/KDYhp1dVje1AB6+c7k9UEVEKjFHbH
 9y0adJl8LczrAqJF7SynKX6FQmwjC0E7nTVb671go26p6IpPqRtySdrUtdFJmp8Mg2fL
 /WyQ==
X-Gm-Message-State: AOAM530U6FvR0qXFFbdnX3vcUhKGiBnnm//LPLAVkwRvLeOP4zPjeGEI
 K9lEMc4lWeSvfGlAUbUiCX1jIemXm07ft+LFqBTj191H+Rux9fSEzbXxYc9zd1S5S0XaqaYvlzk
 syQZ76KWh5YlTGvtUkC3j6ec0C33nOOfLdCZomDPLxQ==
X-Received: by 2002:a05:6000:105:: with SMTP id
 o5mr18151677wrx.164.1606680706163; 
 Sun, 29 Nov 2020 12:11:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPka2aHaDPPX0PTgwDnAG/w5i0WrMz+FyjrUMAbM+Qjqz54JODofUJr+22IVyBqFlX4tuyzw==
X-Received: by 2002:a05:6000:105:: with SMTP id
 o5mr18151664wrx.164.1606680706012; 
 Sun, 29 Nov 2020 12:11:46 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id 34sm24071900wrh.78.2020.11.29.12.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Nov 2020 12:11:45 -0800 (PST)
Date: Sun, 29 Nov 2020 15:11:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20201129151113-mutt-send-email-mst@kernel.org>
References: <20201127183003.2849-1-info@metux.net>
MIME-Version: 1.0
In-Reply-To: <20201127183003.2849-1-info@metux.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, bgolaszewski@baylibre.com,
 linux-riscv@lists.infradead.org, linus.walleij@linaro.org
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

On Fri, Nov 27, 2020 at 07:30:03PM +0100, Enrico Weigelt, metux IT consult wrote:
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index b052355ac7a3..85772c0bcb4b 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -48,5 +48,6 @@
>  #define VIRTIO_ID_FS           26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM         27 /* virtio pmem */
>  #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
> +#define VIRTIO_ID_GPIO           30 /* virtio GPIO */


Pls remember to reserve the ID with the virtio TC
before using it in the driver. Thanks!

>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
