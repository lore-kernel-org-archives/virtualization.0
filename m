Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642A9C4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 13:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6AB8415F4;
	Mon,  5 Dec 2022 13:06:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6AB8415F4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXYRAYPc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WGVx187j-P1j; Mon,  5 Dec 2022 13:06:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 41E46415FC;
	Mon,  5 Dec 2022 13:06:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41E46415FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18675C0033;
	Mon,  5 Dec 2022 13:06:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14CF8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3E564052B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3E564052B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXYRAYPc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ViSzRpuzclhs
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:06:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46B4F404A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46B4F404A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670245584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fysUMtd7nyS68Uh6akbyo7z/TqrJMUL08Oy/r5zD+R0=;
 b=eXYRAYPcs+N0cnCothl45L4Mfw3hcz7czXPP1bAcyGCxuOzJoiPStjbDKB+pCSWGF+tVux
 duillBH+kWy6CuU8tK0Ampc8dMi6BNCTbHUIvzbQrnzXnnkm+hMyD0T3FkentRBHOppYoM
 ErW/CLgWxyujvg5J575eH/kzyziskX4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-n4wlRpWsO4CX5pNZHwhqMA-1; Mon, 05 Dec 2022 08:06:23 -0500
X-MC-Unique: n4wlRpWsO4CX5pNZHwhqMA-1
Received: by mail-wr1-f71.google.com with SMTP id
 o8-20020adfba08000000b00241e80f08e0so2279185wrg.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 05:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fysUMtd7nyS68Uh6akbyo7z/TqrJMUL08Oy/r5zD+R0=;
 b=nhdb+5YnuTzldkmyRAbQHrb/J4votNKalXDtp2uMH3erJLkf9h/tR8HT2MFAtHDtcX
 mSHOYjIQ731+QrOuVMpJqPyh22oOGxoRy4ORV3LyO2AMI68qOJ0ruO5tNcf2q68anh/I
 /GpCXIbGk890LT20k1kleUSPBWSr3UUneT7eccRXOFzi8Rl8DrfyugJncw+VnKEi7gS5
 AcA0x6JRFa1DUatHok9Ja8H0ljOrogQv16PFaj+SPyExzt9YSX/PTsnG6o6Oj6m8srbb
 4KyOKMn3GHSQbR6E8CpYCFJI5a7iew/1R45x9iYy4PWdLAuyp9euy8OQxsyZedLbrJrW
 DD8A==
X-Gm-Message-State: ANoB5pkethwbyOAN4epGhu13lwl9FhWPzBy8cttLLUwMSTfbtWt0oRh8
 4kXgepZaQV0isGy+ZhKlfHmtRjp6xkrLP771kBqiuGCUkQVF9t9mUQrDB2HlX3KVGwFNaRCXX5B
 LMqjVOycfF2srFHDpkHidS1Wh/Sp0f+dPdXREp86eHw==
X-Received: by 2002:a7b:cb83:0:b0:3cf:96da:3846 with SMTP id
 m3-20020a7bcb83000000b003cf96da3846mr61506318wmi.10.1670245581737; 
 Mon, 05 Dec 2022 05:06:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7RZfPMSS4umpthjPuwuEfbtfp0zUdyrA+FWxPzPvb5YZzdZ87NyoR3TcEQ0+8D1lPGIcScpg==
X-Received: by 2002:a7b:cb83:0:b0:3cf:96da:3846 with SMTP id
 m3-20020a7bcb83000000b003cf96da3846mr61506308wmi.10.1670245581511; 
 Mon, 05 Dec 2022 05:06:21 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b003cf54b77bfesm23862340wmq.28.2022.12.05.05.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 05:06:21 -0800 (PST)
Date: Mon, 5 Dec 2022 14:06:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH v3] net: vmw_vsock: vmci: Check memcpy_from_msg()
Message-ID: <20221205130615.jqnno74hnui6527c@sgarzare-redhat>
References: <20221205094736.k3yuwk7emijpitvw@sgarzare-redhat>
 <20221205115200.2987942-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
In-Reply-To: <20221205115200.2987942-1-artem.chernyshev@red-soft.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, lvc-project@linuxtesting.org,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Bryan Tan <bryantan@vmware.com>, Jakub Kicinski <kuba@kernel.org>
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

On Mon, Dec 05, 2022 at 02:52:00PM +0300, Artem Chernyshev wrote:
>vmci_transport_dgram_enqueue() does not check the return value
>of memcpy_from_msg(). Return with an error if the memcpy fails.
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
>Fixes: 0f7db23a07af ("vmci_transport: switch ->enqeue_dgram, ->enqueue_stream and ->dequeue_stream to msghdr")
>Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
>---
>V1->V2 Fix memory leaking and updates for description
>V2->V3 Return the value of memcpy_from_msg()
>
> net/vmw_vsock/vmci_transport.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
