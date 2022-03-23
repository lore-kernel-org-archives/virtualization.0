Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EE1C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 14:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FE6861357;
	Wed, 23 Mar 2022 14:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ncTMr9m_fkV4; Wed, 23 Mar 2022 14:41:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FDB660E6B;
	Wed, 23 Mar 2022 14:41:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BBBFC0012;
	Wed, 23 Mar 2022 14:41:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2182C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 14:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EF2941B75
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 14:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i7vDIIy43ZNo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 14:41:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E60A41B73
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 14:41:08 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id s42so1694452pfg.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=9S4eZd/rXA3n6neAOpli6HJc1yfp+ivfWjQ96On7pkI=;
 b=QhZqkNggS08Iaw6ai+E2dKoy/D9zbMKsZp1q7bLscXQKKNTf2iXab7MnrMd1vBk6Er
 2MWstlzqkm6T21vy6t5M/3ndyjHsZso7L4CrkCYWu2ChTfnRgKwo2TgNg9RMXSEwp9MW
 GMfSOF1OQQWrio3KOet+GLNOTHxytfLoHtF+kYIrYQUtTUhN0AYpaR6IdBrjTJMNr6Xa
 /WpnT6wXbFhnN1OR2SQQcLPAGSXzDTvuuPs7jGWyBMTXLtrvgdhQoUgZl+dNRulOviAQ
 2iKSILaEbeGVSymi+LDckIyJJAyZtHlx8ZIVDLV3O/ut2zEsWbNgJXoV9+kUq9QMDIZ5
 mKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9S4eZd/rXA3n6neAOpli6HJc1yfp+ivfWjQ96On7pkI=;
 b=vdVI3peJM26HYDz+V8JvyvBv3FcFlQjDGWyw8yjmG8+wASHxbvbTf3RWK28uZNX7U9
 G0xVstYbVHC8gQCFu40iyCXvROZC+mlo8kDknNzncM2y/BjIi1H+ziwSoYKr+ePAHPf8
 faLzHaRrM31n5f4jvqrjOPyUSaNEYkq9GkcN0AQ/PH+vg3F+CQ4rHCKFX7/0gPm/kURK
 1KXYjI1jY6TQ8EaJBjATLUG4GX09hPkpbVjOlMMi8VGi7i7J+CubhcjpTrvho5QqRi0M
 jiKG6fxiE4zpCW34Bzy8li8rB2Mi5VZjTyWwIXOovpfeskVpaihF0r9FVEtQqglkPicL
 tYOw==
X-Gm-Message-State: AOAM530xDz20K9i0lbxyn9yQnbrYu/dP0SqRDuUzfCgAUWabH1A64LfK
 R6SGejcf1XnqU9WEQ8hM3Efy6g==
X-Google-Smtp-Source: ABdhPJxs2YxbMDq4cFOUneNrKNpZMka1lWtg2y+oKbcBfOGQcS9WES0IMW0H8pPRUYmVwxqVrEN6wg==
X-Received: by 2002:a63:ae03:0:b0:386:2b5d:dd7d with SMTP id
 q3-20020a63ae03000000b003862b5ddd7dmr196912pgf.332.1648046467709; 
 Wed, 23 Mar 2022 07:41:07 -0700 (PDT)
Received: from [10.255.146.117] ([139.177.225.224])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a056a001a8b00b004fab740dbddsm166340pfv.105.2022.03.23.07.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 07:41:07 -0700 (PDT)
Message-ID: <f0b798fe-d341-775d-c722-1d05b99da0c3@bytedance.com>
Date: Wed, 23 Mar 2022 22:37:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Re: [PATCH v3 0/6] Support akcipher for virtio-crypto
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20220323024912.249789-1-pizhenwei@bytedance.com>
 <20220323083558-mutt-send-email-mst@kernel.org>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220323083558-mutt-send-email-mst@kernel.org>
Cc: herbert@gondor.apana.org.au, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>
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

On 3/23/22 20:36, Michael S. Tsirkin wrote:
> On Wed, Mar 23, 2022 at 10:49:06AM +0800, zhenwei pi wrote:
>> v2 -> v3:
>> - Introduce akcipher types to qapi
>> - Add test/benchmark suite for akcipher class
>> - Seperate 'virtio_crypto: Support virtio crypto asym operation' into:
>>    - crypto: Introduce akcipher crypto class
>>    - virtio-crypto: Introduce RSA algorithm
> 
> Thanks!
> I tagged this but qemu is in freeze. If possible pls ping or
> repost after the release to help make sure I don't lose it.
> 
Hi,

Daniel has started to review this patchset, according to Daniel's 
important suggestion, I'll rework this feature and post the next version 
later.

Thanks a lot!

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
