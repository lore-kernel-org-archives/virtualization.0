Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F83C77B7F
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 07:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D8034208D;
	Wed, 17 May 2023 07:45:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D8034208D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eK1QcMtO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HKKuAexjUV2Z; Wed, 17 May 2023 07:45:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A0F914205B;
	Wed, 17 May 2023 07:45:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0F914205B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AD64C0036;
	Wed, 17 May 2023 07:45:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A4A4C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F7924205B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:45:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F7924205B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kitCNgGgTtGY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:45:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1E0F41F48
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1E0F41F48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:45:09 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5307502146aso257083a12.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684309509; x=1686901509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CCBuutMUthJUkRrQzXH4Xqy8Klmtx8q2e1YC7kem8c0=;
 b=eK1QcMtOsl5ToHovu5tsM7JExtjBJ86QgIclyJ8n81kuf+2FCQA+0rZcuiWzlXxeFM
 h1aTmPWyYzmJ6skW6nJyTbLu0WDaO5cDGPo1JTbCFDPIDBuhJsY0J8RMpwu3ewF7lQPx
 lXQoTf9ld9pMEIsNpWgkPmTtCUjKfuYdd1cV9Dzd8d7n9bLNChVQbi13ZUJ4425pp8ET
 L1xi9TMe/nIFjFnfzP8s6b2Vvu5f2axKoHJg4LRzq2i9O6q1ABti3rcTF0725ZRJFHKb
 iCj3ub0vJWtfptJ+jJ9kodq9Hqd7HGUi7ca3KF5SubUmGBwObiaV2vWebNGWfUV4/Yuu
 r1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684309509; x=1686901509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CCBuutMUthJUkRrQzXH4Xqy8Klmtx8q2e1YC7kem8c0=;
 b=T/F9IC2kJdh2bOCCnppy8z8+01V7hBSFf8VDAYc84pu77O2L1e/NcACswumOkQ3CZ1
 e4eOqMvmP52wEETA6QqDC7kSqADYrypyz2AMqjmg3ocF4dPgSXv5Q7GaaRg1rl92mywQ
 19M+7LHoZtdv7fYVuc/0moqdBHLVUo2JRN3qe69k5a8aK4xa98NPJO8vG/Uq5+RbTKIU
 Cb2xkrbR2pXmP9z92c+Ua8JnwR7BteI7din1zJcZeLBpinXCoeHq2fpeTToMGsEnqoDl
 OkzaOYAby0iYI/FcypCqgU3YxM4vCfq4NISSbGc9T8ud/fmTL6nzvEWbAHffmHv51/MZ
 tlsA==
X-Gm-Message-State: AC+VfDxvv5jRYmcYyqryt+Un9J3LQTgGB8BRbjUTQzkbmAh+qia4pTUd
 PSTLRks5IA786MSwmqgv55kAxQ==
X-Google-Smtp-Source: ACHHUZ59o1PVcTyaXxyJ82AFrbJ53xaFnzi9MfcVaV6F1bFEMs+c14sYqVIUt5CSyciEEGyXPKHfuQ==
X-Received: by 2002:a17:903:2451:b0:1ab:142a:3dd7 with SMTP id
 l17-20020a170903245100b001ab142a3dd7mr48163501pls.68.1684309508941; 
 Wed, 17 May 2023 00:45:08 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.13])
 by smtp.gmail.com with ESMTPSA id
 bi2-20020a170902bf0200b001a6b2813c13sm16878970plb.172.2023.05.17.00.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 00:45:08 -0700 (PDT)
Message-ID: <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
Date: Wed, 17 May 2023 15:43:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
In-Reply-To: <ZGSEq197W8VvOWCc@infradead.org>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
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
From: zhenwei pi via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: zhenwei pi <pizhenwei@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 5/17/23 15:39, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 10:54:23AM +0800, zhenwei pi wrote:
>> All the vring based virtqueue methods could be abstratct in theory,
>> MST suggested that add/get bufs and kick functions are quite perfmance
>> sensitive, so export these functions from virtio_ring.ko, drivers
>> still call them in a fast path.
> 
> Who is going to use this?  And why do you think every virtio users
> would want to pay for indirect calls just for your shiny new feature?
> 
> This seems like an amazingly bad idea to me.

Hi,

I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio 
transport, as mentioned in cover letter of this series:
3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html

Jason and Stefan pointed out that a non-vring based virtqueue has a
chance to overwrite virtqueue instead of using vring virtqueue.

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
