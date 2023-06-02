Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090FEC77B7A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 11:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7900B42732;
	Fri,  2 Jun 2023 11:30:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7900B42732
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NQ8VKrQ7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b_tfFw8fsUk0; Fri,  2 Jun 2023 11:30:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C5C0442696;
	Fri,  2 Jun 2023 11:30:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5C0442696
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 989BEC0037;
	Fri,  2 Jun 2023 11:30:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 772C6C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51A2C84448
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51A2C84448
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NQ8VKrQ7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vUDwXPc3fjld
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:30:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A7F184442
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A7F184442
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685705439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F00vpVMdWa9TR3+Nam4tbq5OQWssX8hYIk9OI5cMqFY=;
 b=NQ8VKrQ7SJtR4wo8UZYL/+D7ikqSD7BuQr3TdDmSHCiBCoGOpMfoZGTsnjegtgUVxpcYYb
 a/vP5qQKEnmyBgYnM0JNB3QZZGvVh/0j9nY9nsimK7qLu1KcNhfznp2dhnaNVbPtv0T0jT
 Gmb6DS2fHnn0Mu8aRDfpOWQHH+gAhRE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-czLmDdSTMWWpBN60Eor54w-1; Fri, 02 Jun 2023 07:30:38 -0400
X-MC-Unique: czLmDdSTMWWpBN60Eor54w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30c3ad3238bso912905f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 04:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685705437; x=1688297437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F00vpVMdWa9TR3+Nam4tbq5OQWssX8hYIk9OI5cMqFY=;
 b=POZjM23JXe9zbPz2e4ukZWFg55ODn8J6mro6Z8eKV9kS8HOPM0R+aj2uYUVqCgEXaq
 DGrGHSOYJnPb04CHcsvPZvYIUQU98/cVSZkM5zgP7oZGwMr1iz12Dm7kWGYhsmAx7eNh
 QLk4bOqN018KAhggD6tCazFAve7bW19DVvUOvRcUmaAY3/7Xfy/fMo8u3pqoWxodijmm
 erjrYGvKYlmzX2oy8PCvGwFFY/9gOMxPHBSESzO7bQigFwsC3jlOSjvNcVmb8XzFajRu
 Vwcb0tJj2Bz3vs3DBmVIhUfEfHetTIjhKM5Y4juOrf86+jGQqk5sbfE4ECGCSrQh6lXZ
 yWiA==
X-Gm-Message-State: AC+VfDwFLgux6CRdAOcMwpiF8eTQWI9NrahP1F8OreHJmCEQFKHynvaG
 X5lrF8bldcf742mU9zK9gUR+Tg1Y+AUYrVcHvhrzUUmxAFOSKI9lvqoTXFMf7h+R4VIkadhJSoR
 muB03i1zZAvL/XQqWp7rLRdskVbRZdlnVM0F4zTM4RA==
X-Received: by 2002:a05:6000:1141:b0:307:7f38:37f with SMTP id
 d1-20020a056000114100b003077f38037fmr3299570wrx.66.1685705437012; 
 Fri, 02 Jun 2023 04:30:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51q8bGzTk7RTQC1JX4flfHvzngWe3LU5wYEXOankGsD1jwSofiDuWc4F6Hnz+ZttjZWbaCmQ==
X-Received: by 2002:a05:6000:1141:b0:307:7f38:37f with SMTP id
 d1-20020a056000114100b003077f38037fmr3299553wrx.66.1685705436723; 
 Fri, 02 Jun 2023 04:30:36 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 z9-20020a5d4c89000000b002fe96f0b3acsm1439241wrs.63.2023.06.02.04.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:30:36 -0700 (PDT)
Date: Fri, 2 Jun 2023 07:30:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [RFC PATCH net 2/3] virtio-net: allow usage of vrings smaller
 than MAX_SKB_FRAGS + 2
Message-ID: <20230602072957-mutt-send-email-mst@kernel.org>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
 <20230430131518.2708471-3-alvaro.karsz@solid-run.com>
 <20230430093009-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723043772ACAF516D6BFA79D4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230501061401-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723AA2ABCE91928BE735DEBD46E9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723AA2ABCE91928BE735DEBD46E9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

On Mon, May 01, 2023 at 11:59:42AM +0000, Alvaro Karsz wrote:
> > First up to 4k should not be a problem. Even jumbo frames e.g. 9k
> > is highly likely to succeed. And a probe time which is often boot
> > even 64k isn't a problem ...
> > 
> > Hmm. We could allocate large buffers at probe time. Reuse them and
> > copy data over.
> > 
> > IOW reusing  GOOD_COPY_LEN flow for this case.  Not yet sure how I feel
> > about this. OTOH it removes the need for the whole feature blocking
> > approach, does it not?
> > WDYT?
> > 
> 
> It could work..
> 
> In order to remove completely the feature blocking approach, we'll need to let the control commands fail (as you mentioned in the other patch).
> I'm not sure I like it, it means many warnings from virtnet..
> And it means accepting features that we know for sure that are not going to work.
>

Well they will work yes? just with an extra copy.

-- 
MST 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
