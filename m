Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A1BCDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 08:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C209B60DE5;
	Wed, 18 Oct 2023 08:10:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C209B60DE5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dyfTjQVi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPCqq_gzlqkN; Wed, 18 Oct 2023 08:10:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 598F760D9D;
	Wed, 18 Oct 2023 08:10:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 598F760D9D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38B65C0039;
	Wed, 18 Oct 2023 08:10:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EAE0C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DD37404D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:10:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DD37404D3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dyfTjQVi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kGk6xWYZPlyO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:10:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50FEF4036E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50FEF4036E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697616611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=37/kJ7xBvGvJcqALMsAiYLG6+205Ian/eThnUNlAZmo=;
 b=dyfTjQVibapKHC6k/mtHmW9a/QKh8TW4P/xOgUXjKVBC5SlpP5hn7nr2+MDzq/xJBhwus0
 CD38TtlrriuGdeNXghPLb7/TdvCaRk5vwWTAZ3R9fD8i/pJvfrwxEPLktbJgp3RXgjUDLk
 HZfX4Oyluj+pxxos27akuG2/smxmoMU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-OaeoQ3VhN8mKxsArOV9RZQ-1; Wed, 18 Oct 2023 04:10:05 -0400
X-MC-Unique: OaeoQ3VhN8mKxsArOV9RZQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso493625866b.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697616604; x=1698221404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37/kJ7xBvGvJcqALMsAiYLG6+205Ian/eThnUNlAZmo=;
 b=Xr8ZbipxCOcz7Dh2BV4+2zktDYCWjMK8ylLZhWryi6duPuHKOGncDiuF6eU/0wJb/6
 6KLYmaiC9x16xyu6rjRTV6CqzRSLhY9M5kn/ANw9Izwl3wFfHKyV7gzMBrECEI36Vs8P
 NCyyM6yPs2w+WBQeXrNp255ufzFZSqGsgLEnriHKwZidzsesg2BHtjvMwOdWb8mcuEpw
 57RviUcdQvlytT3i2te8r1NYemzSRnWZWkysZfqUocxxYu3MN0KKWLnCgxQAScT4/k3h
 5dgH5LYGBzJkLITnRox1WZqHMAZs7vdCxqFkBzK4RXm8KNVRPkcNL0NRsfEHtvUFe/sz
 bzHA==
X-Gm-Message-State: AOJu0YzpUFBGxbpPu4qhdniJrNABbXyxKz2amsv7V8G1Cae7YfNBc4hN
 OxacuV2AgpnUsr/VNFFVvr4Pz1QqiGSir8ga/wVa3dIgD94eb3Q5ZLAbbM09y2F8KYM4ly36DOU
 mScbZeT/yXuSfvKhHv2wNkYvDr2k/eRTyOU5O//VLVg==
X-Received: by 2002:a17:906:ee81:b0:9be:481c:60bf with SMTP id
 wt1-20020a170906ee8100b009be481c60bfmr3207757ejb.55.1697616604093; 
 Wed, 18 Oct 2023 01:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo/uNRLOrJZqZfYt3SG8LZALHlWpLFAe29ra7F9UnNNgD7+57SContltcsRq/ZecphhcN7iQ==
X-Received: by 2002:a17:906:ee81:b0:9be:481c:60bf with SMTP id
 wt1-20020a170906ee8100b009be481c60bfmr3207746ejb.55.1697616603792; 
 Wed, 18 Oct 2023 01:10:03 -0700 (PDT)
Received: from redhat.com ([193.142.201.34]) by smtp.gmail.com with ESMTPSA id
 f17-20020a1709062c5100b009aa292a2df2sm1118534ejh.217.2023.10.18.01.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:10:03 -0700 (PDT)
Date: Wed, 18 Oct 2023 04:09:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Message-ID: <20231018040907-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> Hi Michael,
> 
> Do you think it's appropriate to push the first two patches of this patch set to
> linux 6.6?
> 
> Thanks.


I see this is with the eye towards merging this gradually. However,
I want the patchset to be ready first, right now it's not -
with build failures and new warnings on some systems.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
