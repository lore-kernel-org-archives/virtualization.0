Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497A4C433EF
	for <virtualization@archiver.kernel.org>; Wed,  1 Jun 2022 01:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C68EF417BF;
	Wed,  1 Jun 2022 01:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3kdMDvg8WeY7; Wed,  1 Jun 2022 01:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 147314171C;
	Wed,  1 Jun 2022 01:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E763FC0032;
	Wed,  1 Jun 2022 01:40:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A368C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 01:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04A1A417BD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 01:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8rwoF2eAqsB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 01:40:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1ABA4171C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 01:40:49 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id a10so571213pju.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 18:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=jFvwYwPJCY6k0di+i6nL1/XGJtBAlgbdq8lOQ9mtj3Q=;
 b=imgRJrFZSHLe6lO2zmh5r0EUVQKmP5XUldXw07mbKIhXPvCYkq3hRTr6NDY/S/9Xuq
 +CHuquruv+4BXW/Oxm0lr6vXR5mOMwblPj4a9FEb0E5xzqanj0y/1TZLXuGphHrYu4Fp
 t5Rfn8wSPc3UPIkR+FM3fo5SJxUDLo+U93YEWTSeP3uyz457NYmf86aIcdBtQoSy5eUI
 pC6H9k5onjbkwC73/18YNImeZDfeT3O9BP+l+bVE0PhdhBusx8crbLVx9sErEnUDvi1z
 qel24NElsXerHeDYi5jNW4LYdLtiJrkVwjgp/dfWterqvC8bX5nawa4aLQ0M8dFJ5aKf
 aiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jFvwYwPJCY6k0di+i6nL1/XGJtBAlgbdq8lOQ9mtj3Q=;
 b=0nAcwTgCcTib77w1k60n4DM6DgEghXzuICbSZpfiFA4CtGLUAh1dclWOrsBtCfY9c9
 +iO177T8W/0/a2hEkN0enb/av/gTfe7gTyjxiRv/VuCfct+nJPgL/yhKA6M6BG/SpJs0
 iFL1IqC0qHTmh/UW6UqaAEaYLx7tQkfmiG36i8yMqsVsdke7XkqsH+9B0iBSDx/iq+AO
 8/4OnchtcyTGaXe+JrRKyv5MLQO+l3L7A3U1WumIUIia91UkGkXGKht9Gw8nfhSkVeGr
 +u/D1d2nMpVkROCzpeU164WhZWaKQcCnmRURIhtsV/82S97DJIW7KU85Gukyq41Ce5Xk
 /gPQ==
X-Gm-Message-State: AOAM532zUMWqatAVMNCJxhlaGeWZUO2sAWxq/N2ET/XmB/gZnYs2htzC
 D0IFXH4L/lYrITkDl+48cUIU7w==
X-Google-Smtp-Source: ABdhPJxL9+zVLo1Fe4n5GfInEgl1mETUHn6X4Lrss5tFCnux/FCRgTY28hJgW0D1nHV7FYQXjlwMuA==
X-Received: by 2002:a17:90a:df91:b0:1e3:4dc8:46e7 with SMTP id
 p17-20020a17090adf9100b001e34dc846e7mr3726446pjv.106.1654047648994; 
 Tue, 31 May 2022 18:40:48 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.233])
 by smtp.gmail.com with ESMTPSA id
 ru12-20020a17090b2bcc00b001cb6527ca39sm2639407pjb.0.2022.05.31.18.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 May 2022 18:40:48 -0700 (PDT)
Message-ID: <f59a879a-3526-4da3-7546-3e719f070504@bytedance.com>
Date: Wed, 1 Jun 2022 09:36:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: RE: RE: [PATCH v8 1/1] crypto: Introduce RSA algorithm
Content-Language: en-US
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "mst@redhat.com" <mst@redhat.com>
References: <20220527084734.2649594-1-pizhenwei@bytedance.com>
 <20220527084734.2649594-2-pizhenwei@bytedance.com>
 <848d579e2c504ba493cd57510a7ff3b0@huawei.com>
 <b2ee77ae-2044-32b4-20c5-43fa78e8213c@bytedance.com>
 <39f884dbc25d4b0cbec510ab090e6778@huawei.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <39f884dbc25d4b0cbec510ab090e6778@huawei.com>
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On 5/31/22 20:08, Gonglei (Arei) wrote:
> 
> 
>> -----Original Message-----
>> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
>> Sent: Tuesday, May 31, 2022 9:48 AM
>> To: Gonglei (Arei) <arei.gonglei@huawei.com>
>> Cc: qemu-devel@nongnu.org; mst@redhat.com;
>> virtualization@lists.linux-foundation.org; helei.sig11@bytedance.com;
>> berrange@redhat.com
>> Subject: Re: RE: [PATCH v8 1/1] crypto: Introduce RSA algorithm
>>
>> On 5/30/22 21:31, Gonglei (Arei) wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
>>>> Sent: Friday, May 27, 2022 4:48 PM
>>>> To: mst@redhat.com; Gonglei (Arei) <arei.gonglei@huawei.com>
>>>> Cc: qemu-devel@nongnu.org; virtualization@lists.linux-foundation.org;
>>>> helei.sig11@bytedance.com; berrange@redhat.com; zhenwei pi
>>>> <pizhenwei@bytedance.com>
>>>> Subject: [PATCH v8 1/1] crypto: Introduce RSA algorithm
>>>>
>>>>
>>> Skip...
>>>

> 
> OK. For the patch:
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> 
> 
> Regards,
> -Gonglei
>      
> 

Hi, Michael & Lei,

The other patches of this series has been already merged into QEMU, this 
patch is the last one. With this patch, we can test virtio-crypto 
akcipher end-to-end.

Thanks a lot!

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
