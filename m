Return-Path: <SRS0=Pjyk=MI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B4C07E95
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 13:10:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDA6613F5
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 13:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDA6613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B38CD424A8;
	Fri, 16 Jul 2021 13:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W5w2bvk2XOE5; Fri, 16 Jul 2021 13:10:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F9D94249F;
	Fri, 16 Jul 2021 13:10:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05E6BC0010;
	Fri, 16 Jul 2021 13:10:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E2CBC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 13:10:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5919D40EDE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 13:10:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3C-HcrW3SQ5q
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 13:10:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABCEC401D6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626441040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfHUY15Uy1dIWD5x+FWk01V2UPIrzIHLqJFcxENTfHs=;
 b=LiA8O86DiMjg39p5DtkOfM5NdZZWeUnsxjsn86/9FSP53rMMu3H0+roFUy1RXc37aaIMJp
 OvmyOlfwcnKe/DCIZ47qVtvZ7jyo7ud+6NDg7InPq/MgA4FZHed6XfsJIwDAdM7wTv33qi
 NJBKMdThfwdpzotsdv8f3s/1o5mNWj8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-HSptT96RP8-Vnj-8cYqJuQ-1; Fri, 16 Jul 2021 09:10:38 -0400
X-MC-Unique: HSptT96RP8-Vnj-8cYqJuQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 h22-20020a7bc9360000b0290215b0f3da63so1234931wml.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 06:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mfHUY15Uy1dIWD5x+FWk01V2UPIrzIHLqJFcxENTfHs=;
 b=gcxm99YR99ggfzjhhe7DVhN76ltmrihp58Qg9iM5loQeMJH9q44nICkpL2+Vg9xaja
 tzw/S5eXcDKJ2MO5ccL6XHnQh2ljTvPIurPV09L0cdcuc0vOg2rn0sbNfsJ4wrKFgVmS
 sqrYswAh682hvW8cavgvXHGk7K5a9Q5e8Juuf3/eQppEUITJzTRjfXTph5+jWbCtQtAV
 TETCTAGeEbovyf3nbdEvtWjagxhZECl0CpwcAT+CbMWTpfjQVvGGaC+ENgsh1c4gcIOr
 M2j5BJReFNLfD538vtVITjw7SbyJxqoIM4Ee80RmX1oYKDpfGLa80CUB9HRkHBo5uhhM
 4uUg==
X-Gm-Message-State: AOAM5333qR7d9xG87EUhqgMWVnHANGHO1iAEhxLfcis+G2BvNHv3iLRP
 n+6LMK+Op56JjNrKutR9jpyMqUMduQJa8VhmSwlm5RQVuPfjc12ybADlrfhrkuI7XOEfrUGyhU5
 rvpQc4JSATU4ngPQpBhxfg9Uit4HaYuqfXFZi6Gxpag==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr12176230wrv.75.1626441037718; 
 Fri, 16 Jul 2021 06:10:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQow3phVBvU1Ndrlr2yK7XIXEgJZXo6n2/PrXt/Z+O6qejNxABtVTM2Ro0p1O0JTSxEdpmTA==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr12176214wrv.75.1626441037529; 
 Fri, 16 Jul 2021 06:10:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c621f.dip0.t-ipconnect.de. [91.12.98.31])
 by smtp.gmail.com with ESMTPSA id
 m18sm7776641wmq.45.2021.07.16.06.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 06:10:37 -0700 (PDT)
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
From: David Hildenbrand <david@redhat.com>
To: tianxianting <xianting.tian@linux.alibaba.com>,
 Xianting Tian <xianting_tian@126.com>, mst@redhat.com, jasowang@redhat.com
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
 <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
 <95d7f688-79fc-05dc-87ca-da46e0179f0e@redhat.com>
Organization: Red Hat
Message-ID: <58096b5a-8acb-a88f-c2c6-cd6e3201407f@redhat.com>
Date: Fri, 16 Jul 2021 15:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <95d7f688-79fc-05dc-87ca-da46e0179f0e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On 16.07.21 14:53, David Hildenbrand wrote:
> On 16.07.21 14:46, tianxianting wrote:
>> Do you interest in this patch? just little improvment:)
> 
> I am, especially when I'm cc'ed and aware of it ;)
> 

Sorry, just found it in my gmail spam folder ... WTH. Why does the 
original one get filtered but not your ping ...

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
