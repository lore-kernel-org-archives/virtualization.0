Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCECC77B73
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 11:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC63D81F4F;
	Sun, 23 Apr 2023 11:09:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC63D81F4F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZyAQxig
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1zT0jsrbCxcp; Sun, 23 Apr 2023 11:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3FC8881F2F;
	Sun, 23 Apr 2023 11:09:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FC8881F2F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B120C0037;
	Sun, 23 Apr 2023 11:09:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C35EC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6709040864
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:09:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6709040864
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZyAQxig
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IS6YFPLAwZib
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:09:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94C3640542
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94C3640542
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682248180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qa5an+pMO/z37xFkKNIb5d1qvmQCeDMySUintGMWRFc=;
 b=hZyAQxig93D7opNlNrGlV4Jhqzaygjfsz6q5Xby9xzIz0d10eqjwoyZnkCxeQIwxp4ITrq
 8n1uaorOvEwg7zudRvc+OyZH1WhQDHFaQSwFU4jEbQxHGDMKnQj3hipmbPl/T5GR4msyde
 rjjOq/8imvravYahmDO0o6LzRnZRzfA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-pAwWFr5xPiG4qdoRYwE0Ag-1; Sun, 23 Apr 2023 07:09:39 -0400
X-MC-Unique: pAwWFr5xPiG4qdoRYwE0Ag-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f08901fed3so19880835e9.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 04:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682248178; x=1684840178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qa5an+pMO/z37xFkKNIb5d1qvmQCeDMySUintGMWRFc=;
 b=TWIs7fR8CXeBr0I6EtpfTDGocmHTSJ6MqZ5CHxqtgw6TmrJdCELrn9AL9te2gaVbl6
 /3qSxmSq+SEx1rY+YuD6gFoCIqp969lwM2F5PMDyolN+KsRvQYJ03eGyq/22IkJuQkBb
 MHlx476doBvfAkfde/rcDt65PdTalPIwQ2jJjL8yTIlyuJyr4G/1n4qRh+HBg8NzVs1r
 EDUVJ1Vp69IoqlYJWy826oGAyh87KAjzFs3QPmgEQePncF/hCl0TsyBISKsmqFpWhNUn
 w5FIRXrQWXqhudYeb1OqXzyPlWkisz1nXf7baf2OLuv3oTjr+oMn/2J55wjjWjd1YcIo
 mw2g==
X-Gm-Message-State: AAQBX9fC1Y46OwgGaul9IvuLdtn1AHkw98P21GN2WAOunkCBtO5mbUaK
 OxJI7q7zyyoU88qI3Lf/LmVqPpwOc3KnC4AFveugtLGmjDN3utR9PHu4IWX6uYGDlzcf7E5s8PT
 IC8Btdfwtp7DGBqN/nPiMBkRXhDXvaBx40ug3Fk6IZQ==
X-Received: by 2002:a05:6000:1091:b0:2fb:1d3a:93ff with SMTP id
 y17-20020a056000109100b002fb1d3a93ffmr7134582wrw.61.1682248177956; 
 Sun, 23 Apr 2023 04:09:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350aV4IFxLAe3RJ8HQ8N5xqnVRos1U8Sc00vmSPnpomKazzuEb3lleaW1Py4Fcaqvh482tdyrOA==
X-Received: by 2002:a05:6000:1091:b0:2fb:1d3a:93ff with SMTP id
 y17-20020a056000109100b002fb1d3a93ffmr7134574wrw.61.1682248177654; 
 Sun, 23 Apr 2023 04:09:37 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 bi26-20020a05600c3d9a00b003eddc6aa5fasm9043356wmb.39.2023.04.23.04.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Apr 2023 04:09:37 -0700 (PDT)
Date: Sun, 23 Apr 2023 07:09:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230423070849-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <20230416163751-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F658DCBF66632A74592BD49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723F658DCBF66632A74592BD49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

On Mon, Apr 17, 2023 at 06:43:39AM +0000, Alvaro Karsz wrote:
> > > +static int virtnet_validate_vqs(struct virtnet_info *vi)
> > > +{
> > > +     u32 i, min_size = roundup_pow_of_two(MAX_SKB_FRAGS + 2);
> > 
> > why power of two?
> 
> The ring size is always a power of 2,

Not really, packed rings allow non power of 2.
Linux had a bug that it required power of 2 for packed, but
we are fixing that finally.

> so checking against
> MAX_SKB_FRAGS + 2 or against roundup_pow_of_two will result in the
> same, and I think that printing the warning with the actual min value
> is more helpful.  I can check the condition against MAX_SKB_FRAGS + 2,
> and print the rounded value in case of an error.
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
