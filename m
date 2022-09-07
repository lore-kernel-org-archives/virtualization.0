Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C010EECAAD3
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 07:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 384AE40337;
	Wed,  7 Sep 2022 07:51:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 384AE40337
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IezB9TYv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BjQTVw-D_i-D; Wed,  7 Sep 2022 07:51:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8670540354;
	Wed,  7 Sep 2022 07:51:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8670540354
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48849C0032;
	Wed,  7 Sep 2022 07:51:50 +0000 (UTC)
Received: from smtp1.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe97:d076])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43214C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 067ED81497
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:51:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 067ED81497
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IezB9TYv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8hOg21DBqV6w
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:51:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5083581422
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5083581422
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662537106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KMdampSVOfSjQJ+eYUB/+euJ05288b13jRxouoL8v4=;
 b=IezB9TYvDSRE7d8eZ3U7LmS9k+++6Su6DYFT/ukOl65iDNDtBdlFUnSmEqGeCU2OSfoU3E
 XCwgT4FDBAG7M6wNdP8Dc8S6vojhoHhhmb43n2RiL5zSxwF8qMrIrWhM9t5yp9lTk10m7n
 jAkW/NjoHwuiehTqKUn8Yzjr8BdJfrk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-335-x4VrG6PUNE6_Qkb-88RQdQ-1; Wed, 07 Sep 2022 03:51:44 -0400
X-MC-Unique: x4VrG6PUNE6_Qkb-88RQdQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 b16-20020a05600c4e1000b003a5a47762c3so7050326wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 00:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=8KMdampSVOfSjQJ+eYUB/+euJ05288b13jRxouoL8v4=;
 b=f4l80VXBsDW64tvRnAgOGvWk6+0PrHAXH2pKMAFiMA5u1qaHgkBOvQl7z064hMT54j
 ef8wLK8RjpAyhkiFvSubPz7SN4u05i1uJhbV5rp8aPaeBIq0HRChAnfMCfRCA6mQp2+6
 8wD82V1O1no0CjlUB4Q2HdFqcaiRNUhU8UPLASl6u2RCsXDdz+9jhZiPlqygN1814vuP
 /6ncgtrp+d81w7qbD6faVC9+Npoz/5BC2/9HfNQBq+RHXv0J+vKSELwPWCHHQi9f53CA
 6GvHdiYz47XLWTOvztblXo1o9ccCiEdLQFYUaPSzGKfLyUTRLePEpem6il4JyxFnj8Yv
 Z+7Q==
X-Gm-Message-State: ACgBeo3gi0blk6X9Lee2VYfiFVIDyDkvhhGYSkbL79ZgcZEGxTp+ahXK
 7dg7pM2Ns2xn4BjwHpli6zRVPmU0P/Wz1k8rh1HYKDWd34g4mPR7MZ3ooeKL8icrJUplSMYuHm/
 xwFBt/hNICc1shOumN3wFbFtryrVBlPHMD5gN14bKig==
X-Received: by 2002:a5d:6f19:0:b0:228:d8e8:3ac8 with SMTP id
 ay25-20020a5d6f19000000b00228d8e83ac8mr1149259wrb.101.1662537103870; 
 Wed, 07 Sep 2022 00:51:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ThqBf88YF8iut0HC9FOIofHwvY/fghW1g6YgYSZwxQVisX9JDtm6hidIgh47utu42naZpeA==
X-Received: by 2002:a5d:6f19:0:b0:228:d8e8:3ac8 with SMTP id
 ay25-20020a5d6f19000000b00228d8e83ac8mr1149243wrb.101.1662537103667; 
 Wed, 07 Sep 2022 00:51:43 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it.
 [87.11.6.69]) by smtp.gmail.com with ESMTPSA id
 d14-20020adff2ce000000b00228d6edade0sm6597943wrp.46.2022.09.07.00.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 00:51:43 -0700 (PDT)
Date: Wed, 7 Sep 2022 09:51:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: vdasa@vmware.com
Subject: Re: [PATCH 0/3] MAINTAINERS: Update entries for some VMware drivers
Message-ID: <20220907075138.ph3bbitnev72rei3@sgarzare-redhat>
References: <20220906172722.19862-1-vdasa@vmware.com>
MIME-Version: 1.0
In-Reply-To: <20220906172722.19862-1-vdasa@vmware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: pv-drivers@vmware.com, doshir@vmware.com, linux-scsi@vger.kernel.org,
 vbhakta@vmware.com, gregkh@linuxfoundation.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bryantan@vmware.com, linux-graphics-maintainer@vmware.com,
 netdev@vger.kernel.org, joe@perches.com, namit@vmware.com, davem@davemloft.net,
 zackr@vmware.com, linux-rdma@vger.kernel.org
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

On Tue, Sep 06, 2022 at 10:27:19AM -0700, vdasa@vmware.com wrote:
>From: Vishnu Dasa <vdasa@vmware.com>
>
>This series updates a few existing maintainer entries for VMware
>supported drivers and adds a new entry for vsock vmci transport
>driver.
>

Since you are updating MAINTAINERS, what about adding 
"include/linux/vmw_vmci*" under "VMWARE VMCI DRIVER"?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
