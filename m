Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C29DC433FE
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 13:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C611A83FA5;
	Fri, 14 Oct 2022 13:40:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C611A83FA5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MWTxrli7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ofwCRB_ARV9; Fri, 14 Oct 2022 13:40:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7C28083FA3;
	Fri, 14 Oct 2022 13:40:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C28083FA3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C1E1C0033;
	Fri, 14 Oct 2022 13:40:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0611EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 13:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3B3E400F2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 13:40:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3B3E400F2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MWTxrli7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q82CGM586k-r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 13:40:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97C3D41190
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97C3D41190
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665754814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97+yCsen+aZv3dzNcLFg5QyETWduzN4OK7Pj/5FTDqQ=;
 b=MWTxrli7/H07BBFXzfLebWGld62zCVqxiPfy9wgHV6YBf2bXQETJwaO8828gAQMtK2B1pI
 l7IiCMDkm/EUzb2XhAD598Rw1IwYpH8PBxcldCFU05YW2w8XDbfBPZxjqXD4HNvgEQo9xC
 cQOiSwg5Izyf04vI3ibdyHuxOUjefcM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-442-UL-_t68jP2q-znrYA414iQ-1; Fri, 14 Oct 2022 09:40:13 -0400
X-MC-Unique: UL-_t68jP2q-znrYA414iQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 f26-20020a7bcc1a000000b003c03db14864so2197862wmh.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=97+yCsen+aZv3dzNcLFg5QyETWduzN4OK7Pj/5FTDqQ=;
 b=dI+z7/g6tIB0l6XdT4zAhPgYkp/1tbOT70lGfRYXTYHZIrXhx2vSMBAcnAAQzRLNoJ
 RJmX+YPT5EZrJMp+20iJIhF+CqMe1Jztn5zHsrYLQWaQoElQLbJbInGocKwRR0EpGaFK
 7xdS6zQiZQNHWy8rFqHUfLJc8L8qzw0JCNxWANiAhL7IHbaiDdKPzqap3O9btXf/pqnj
 9s0vjeyEsQeOr9QRG3DWRrnm0qdTRuv6cxSy4v8cza3ReoqXrubrh1oJncbG1RfqxnUM
 WxhkmaSa7yMtRddo1t0aE+/N4jw0GD7Dyx3ezbSBsCervKVQuL7Iv3XS8OWaGo8EbnJO
 KKXg==
X-Gm-Message-State: ACrzQf1oJqPv/kEQNhnkfP37ugVGohu31cA8itpnSf2er5FZcO0qsJnk
 z5g7LN+UKS0OrMmVcenpIliNfNU4IQm+J4qk0KkhWrE6qR7LjqqfNTQdc6EqpWhYEfOq6XLOQtj
 pfThnsCXZw6m/v1ik5OUAHE71zhXPp8PfY7popImKnA==
X-Received: by 2002:a05:6000:15ce:b0:230:a14d:997b with SMTP id
 y14-20020a05600015ce00b00230a14d997bmr3546838wry.370.1665754812067; 
 Fri, 14 Oct 2022 06:40:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6P6KNGcmsIuEbmbLRw+AXx56k/GSatUv1GMsMmCBlacBtge5+MvT1KtuL8koG3QcJLq4g9eA==
X-Received: by 2002:a05:6000:15ce:b0:230:a14d:997b with SMTP id
 y14-20020a05600015ce00b00230a14d997bmr3546814wry.370.1665754811770; 
 Fri, 14 Oct 2022 06:40:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8f00:9219:ab4c:826e:9646?
 (p200300cbc7048f009219ab4c826e9646.dip0.t-ipconnect.de.
 [2003:cb:c704:8f00:9219:ab4c:826e:9646])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a7bcd83000000b003b492753826sm2038178wmj.43.2022.10.14.06.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Oct 2022 06:40:11 -0700 (PDT)
Message-ID: <7e6f2d09-e5cf-7f8d-965d-a39bfb0ea286@redhat.com>
Date: Fri, 14 Oct 2022 15:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 Nadav Amit <nadav.amit@gmail.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
 <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
 <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
 <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
 <1118F098-972A-4F58-8EE1-270A06E4F9D1@gmail.com>
 <7ba328e5-3bc8-cb22-f00c-eddb8aea9a06@virtuozzo.com>
 <063efd58-8373-90ea-7c5e-9d0e9161d2ba@redhat.com>
 <04e5a2e4-052d-0f80-d642-4e104307f38b@virtuozzo.com>
 <72e535ce-80eb-a02f-970c-6a9c80da0a24@redhat.com>
 <5b1e0a13-8018-630d-d512-c3033db2f2e3@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <5b1e0a13-8018-630d-d512-c3033db2f2e3@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Linux MM <linux-mm@kvack.org>, kernel@openvz.org,
 Andrew Morton <akpm@linux-foundation.org>
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

>>>
>>> Other problem is that there are drivers that do not use
>>> adjust_managed_page_count().
>>
>> Which ones? Do we care?
> 
> VMWare and Virtio balloon drivers. I recently proposed to unify them and
> the objection was that it would break existing users - which is valid so
> we must care i guess.

I'm confused, I think we care about actual adjustment of the total pages 
available here, that we want to notify the system about. These 
approaches (vmware, virtio-balloon with deflate-on-oom) don't adjust 
totalpages, because the assumption is that we can get back the inflated 
memory any time we really need it automatically.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
