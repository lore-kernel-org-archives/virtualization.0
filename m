Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9E5C77B73
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 11:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5268C60A79;
	Sun, 23 Apr 2023 11:08:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5268C60A79
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5SAWhtt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-RbXmq3jdQF; Sun, 23 Apr 2023 11:08:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E851B60A47;
	Sun, 23 Apr 2023 11:08:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E851B60A47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0E1BC0037;
	Sun, 23 Apr 2023 11:08:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46B78C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21931811AA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:08:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21931811AA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5SAWhtt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uNWaLUI2G20V
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:08:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E8D280FAB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E8D280FAB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682248112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJ86ZVDYRM9CotkEiqPEtZYHk4qaL2Mn/oKfEYumLFI=;
 b=f5SAWhttc4AiAw759Ji7WL4BpPSZ7VbyQfikV3oYvT3O1euRyjVpZReRgpa5K2vIyk9h17
 9m5KIC4UOF7qCzjE/eqXcC6EJJzeTQlddoL0JJGQ5s+iBSwaRUCciYRtojIvHw+4cgDErv
 f8BZoIrYHwUM6SKFAdEDa2isDKQ3SGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-x51ucjMSPdq8NDhJfIXDoQ-1; Sun, 23 Apr 2023 07:08:31 -0400
X-MC-Unique: x51ucjMSPdq8NDhJfIXDoQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f08900db79so11202515e9.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 04:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682248110; x=1684840110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJ86ZVDYRM9CotkEiqPEtZYHk4qaL2Mn/oKfEYumLFI=;
 b=Cag5d87bbfng5YwePxdha968jczh3aNQLpIc6XWavGt/WWS1mnQUnbJg7LB5QZk+FQ
 AAU93pr+yYVADHA9/9edJSk/ZTZCXntdD1JXnZ1PPUpJfUnwR2jHzZ1V2a3XCPyZBVEI
 tD2XGnh8XWwQLppoomSfdRVPPf2x1dK5GAzvFiyfoZzjHlWE15ytdudH5PDuO9W+pcEN
 0drPhoJA41zDZhg7UMGS4UTwIALrBR4lFThz1FUTHNq1H4jFBCuxAUBhM1vSgCsvkzAN
 STiSySuO9u9ZkuJ5vNDt2klMjCY8wem6i2cAIQhCzQTyRPLuQMaikoOtK9mZLiIlxdl4
 zvtQ==
X-Gm-Message-State: AAQBX9cbXdTbezIOTs0JCE/pcJOTK1Vh3hBg6+5qP8g4woarVtQsWmg9
 iwmeYxt5FPW6AK6l90VBCQtnXylW8Qqg3Mq23yqn9nbQVwLWZB+RU0QUgHywz2QIqMejtPMVwq3
 igOIgjTn5yQ59o2r54ebKFD1eEQTUprH1sAZAxr+sdQ==
X-Received: by 2002:a7b:c393:0:b0:3f1:6458:99a7 with SMTP id
 s19-20020a7bc393000000b003f1645899a7mr5314658wmj.38.1682248109913; 
 Sun, 23 Apr 2023 04:08:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z/eTtNo8BI6gHMtlywU6k2jFJAtKMz2XjK/PppbaZmNDeKGTzU6hmsHxo9LguBSKtEf649Aw==
X-Received: by 2002:a7b:c393:0:b0:3f1:6458:99a7 with SMTP id
 s19-20020a7bc393000000b003f1645899a7mr5314651wmj.38.1682248109608; 
 Sun, 23 Apr 2023 04:08:29 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 k36-20020a05600c1ca400b003f1733feb3dsm12878417wms.0.2023.04.23.04.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Apr 2023 04:08:29 -0700 (PDT)
Date: Sun, 23 Apr 2023 07:08:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230423070705-mutt-send-email-mst@kernel.org>
References: <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB472392318BC9A36CBA7AF19AD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB472392318BC9A36CBA7AF19AD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
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

On Sun, Apr 23, 2023 at 08:01:35AM +0000, Alvaro Karsz wrote:
> We could add a new virtio_config_ops: peek_vqs.
> We can call it during virtnet_validate, and then fixup the features in case of small vrings.
> 
> If peek_vqs is not implemented by the transport, we can just fail probe later in case of small vrings.
> 

Nope, we can't. Driver is not supposed to discover vqs before
FEATURES_OK, the vq size might depend on features.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
