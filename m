Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE47C433FE
	for <virtualization@archiver.kernel.org>; Wed,  2 Nov 2022 09:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3931381771;
	Wed,  2 Nov 2022 09:42:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3931381771
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHr4S3Ho
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bGGJ3nxzbBUk; Wed,  2 Nov 2022 09:42:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BF0BC81AC1;
	Wed,  2 Nov 2022 09:42:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF0BC81AC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91990C0032;
	Wed,  2 Nov 2022 09:42:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EF87C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF63D4098D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:42:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF63D4098D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHr4S3Ho
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgCUxqSQmfFE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:42:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8720A4097A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8720A4097A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667382157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iA0sGfa+ahBDJMGfDHR9LxRbe1IWFp0fRmP5we1ndrY=;
 b=gHr4S3HojpbMRlr7cA+CQCyxyQg9mHVQnX/VzULpnVLky9Uw+5yutyxEqq30Tioc0j9443
 oEgQcgXxRiG6Y0hEJ5Ghg8vqhoTmT2vew9hhhBU8FINkYniA+rCOs9kLFijSpXwBMh28km
 WAd1gOisi9et2+DQIrpHsHFTjPFXQqg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-cPRxVfiOOsSc-JlOZcmzcw-1; Wed, 02 Nov 2022 05:42:34 -0400
X-MC-Unique: cPRxVfiOOsSc-JlOZcmzcw-1
Received: by mail-qt1-f198.google.com with SMTP id
 cp8-20020a05622a420800b003a4f4f7b621so11766647qtb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Nov 2022 02:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iA0sGfa+ahBDJMGfDHR9LxRbe1IWFp0fRmP5we1ndrY=;
 b=XEkIe2vth9shR7f5lToiS9cWKjILP315EieRwED3MTisuiKQi/KSO2tlN9EAUabzr/
 cyEIhtba2NaSD7ymI5vjCdFok1Ta7RU3qYNmF4rbX6h9rUC5WTSIrUk1w/8RwxlkVoYg
 i9NKSWaiZ6bZvM/b0sORjxRtpU2tzQGHQckcWLftbwyZtvagyPnWU3xbgSzqZpPconwN
 tPik4lbsKHVw6pkaMFhdk1OYa/Tj5nBOTQka2xIJpU+SqcqmvjGmZMObprPZcrxphl1H
 AKXorUANb21bxd0gSYv/h7gt/gkkcbDYdsT7LGjvRd8/6BBHmnGJmBzFSqkWU3D6ns7F
 C3Eg==
X-Gm-Message-State: ACrzQf16U31oBVQKwY64CZglJsZA8vj66XfKTFpMOTiXVYbmWzzA72Q7
 fuhiOCn/71IjZsewOBd/rPj8tOdZSz2t8VEyMWo1eFemIUqHvZt6Kq8beUP9zIG2C/I4M4d3R1d
 tICoX+1xOAr80Pa0Yi42uOC7nVn5HCNa5P8cCmxK83Q==
X-Received: by 2002:a0c:e3d3:0:b0:4bb:c033:76fc with SMTP id
 e19-20020a0ce3d3000000b004bbc03376fcmr19147803qvl.117.1667382154197; 
 Wed, 02 Nov 2022 02:42:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4g7XSgjzk5GrqDqTREUMG4zF+wpaO4A5LDwUXjacchdFaECWsUVyjkZbcH8ClLWm8iO8DpNA==
X-Received: by 2002:a0c:e3d3:0:b0:4bb:c033:76fc with SMTP id
 e19-20020a0ce3d3000000b004bbc03376fcmr19147785qvl.117.1667382153979; 
 Wed, 02 Nov 2022 02:42:33 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 bj38-20020a05620a192600b006bb366779a4sm1821377qkb.6.2022.11.02.02.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 02:42:33 -0700 (PDT)
Date: Wed, 2 Nov 2022 10:42:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
Message-ID: <20221102094224.2n2p6cakjtd4n2yf@sgarzare-redhat>
References: <20221101021706.26152-1-decui@microsoft.com>
 <20221101021706.26152-3-decui@microsoft.com>
 <20221102093137.2il5u7opfyddheis@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20221102093137.2il5u7opfyddheis@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.liu@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 edumazet@google.com, kuba@kernel.org, arseny.krasnov@kaspersky.com,
 pabeni@redhat.com, davem@davemloft.net
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Nov 02, 2022 at 10:31:37AM +0100, Stefano Garzarella wrote:
>On Mon, Oct 31, 2022 at 07:17:06PM -0700, Dexuan Cui wrote:
>>Currently vsock_connectible_has_data() may miss a wakeup operation
>>between vsock_connectible_has_data() =3D=3D 0 and the prepare_to_wait().
>>
>>Fix the race by adding the process to the wait queue before checking
>>vsock_connectible_has_data().
>>
>>Fixes: b3f7fd54881b ("af_vsock: separate wait data loop")
>>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>>---
>>
>>Changes in v2 (Thanks Stefano!):
>> Fixed a typo in the commit message.
>> Removed the unnecessary finish_wait() at the end of the loop.
>
>LGTM:
>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>

And I would add

Reported-by: Fr=E9d=E9ric Dalleau <frederic.dalleau@docker.com>

Since Fr=E9d=E9ric posted a similar patch some months ago (I lost it becaus=
e =

netdev and I were not in cc):
https://lore.kernel.org/virtualization/20220824074251.2336997-2-frederic.da=
lleau@docker.com/

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
