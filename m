Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287C5C433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 13:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF44D849D4;
	Wed, 23 Mar 2022 13:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LEyY6A4sIrDN; Wed, 23 Mar 2022 13:43:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 805B484746;
	Wed, 23 Mar 2022 13:43:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53C45C001A;
	Wed, 23 Mar 2022 13:43:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25F2FC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15604849B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:43:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1oE6ycQL6W6g
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:43:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7153484746
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648043003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJHOsMD+p/TxrB7WMAz/bVsoyRgqHIkadq0oUUT9qqg=;
 b=guhqm6v26Z5AVpVYv02xLTClscv1t7+17sqda1y8ocDTtWoFukdkM8NOS1g2BcnmHSzHLd
 tkrGAFlB+bSW7G7t5g9SE/DEfR7Pda9t8BPG1Usm8NDO+Hiwgmuq8d4dCu8BqcOPVv7uqF
 t6vk6hl9QcnYkRn6BKMKcrcs4vOHouI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-P9pfZu4JP_-48KEpn4XkBA-1; Wed, 23 Mar 2022 09:43:22 -0400
X-MC-Unique: P9pfZu4JP_-48KEpn4XkBA-1
Received: by mail-qv1-f72.google.com with SMTP id
 d11-20020a0cffab000000b00440f965f77cso1237935qvv.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 06:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IJHOsMD+p/TxrB7WMAz/bVsoyRgqHIkadq0oUUT9qqg=;
 b=rTvNOmbwBEhnbemeFcudsMZ75MPIEctsywcArpMd9JPD8tAWz3/K0VVjsK9LIM06y2
 Lh6Oox09R251VA8ys4et02GEeZ1SgiDWXDG3PztE8crZA/gLeU2XYFnzvEiTJvE+9OMd
 vJbFLLvnEo70FK0SHTbRafknVQFiYJIFY1zw5SGEV+3oQTGwCXm3wS9FtnyTIMPyZOql
 0zEP3bQlL11tepzeodwWaXULTsYELLGkrBiCuFo41UsHe3S1bpHrSvm2MopBmEedDkQ8
 +XIvff0phJX103CAj/AuXYoCMz3HklPotmrmgcPUFXa8gbItNer2GwU1YwR53xQBsrDT
 srCg==
X-Gm-Message-State: AOAM531WmC38VciTKjnsKPj2UHr6FxUHyFO59Ge/b02sSlNXFk0lWbg/
 7l1BMqvEto4UDgBdokyyRnmipQUfkXbatNT4gFI2eR5mpmmquwpdJeQZqzAarVvQX0P04cFUVo4
 WSXCfwvtvVOkMeScdzHHGOnYorPsEdZsndPGo1jqCvQ==
X-Received: by 2002:a05:622a:1111:b0:2e1:e831:2ee2 with SMTP id
 e17-20020a05622a111100b002e1e8312ee2mr23861906qty.264.1648043000029; 
 Wed, 23 Mar 2022 06:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn19Zj7+5jT24adJG336cYAb3ONCKQCObx38/CuWziIHD5QGZCRUCxyzDDeqQ7YzreKx5W0Q==
X-Received: by 2002:a05:622a:1111:b0:2e1:e831:2ee2 with SMTP id
 e17-20020a05622a111100b002e1e8312ee2mr23861884qty.264.1648042999740; 
 Wed, 23 Mar 2022 06:43:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 20-20020ac84e94000000b002e1d5505fb6sm54700qtp.63.2022.03.23.06.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 06:43:19 -0700 (PDT)
Date: Wed, 23 Mar 2022 14:43:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net v2 0/3] vsock/virtio: enable VQs early on probe and
 finish the setup before using them
Message-ID: <20220323134313.rmx24o3534rmgp3u@sgarzare-redhat>
References: <20220323084954.11769-1-sgarzare@redhat.com>
 <20220323092118-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220323092118-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Asias He <asias@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Mar 23, 2022 at 09:22:02AM -0400, Michael S. Tsirkin wrote:
>On Wed, Mar 23, 2022 at 09:49:51AM +0100, Stefano Garzarella wrote:
>> The first patch fixes a virtio-spec violation. The other two patches
>> complete the driver configuration before using the VQs in the probe.
>>
>> The patch order should simplify backporting in stable branches.
>
>Ok but I think the order is wrong. It should be 2-3-1,
>otherwise bisect can pick just 1 and it will have
>the issues previous reviw pointed out.

Right, I prioritized simplifying the backport, but obviously 
bisectability is priority!

I'll send v3 changing the order in 2-3-1

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
