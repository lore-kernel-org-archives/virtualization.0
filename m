Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9716BC433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 16:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 173C181407;
	Wed,  5 Oct 2022 16:54:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 173C181407
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WXnjHuWJBqnF; Wed,  5 Oct 2022 16:54:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 015CD8140B;
	Wed,  5 Oct 2022 16:54:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 015CD8140B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2B2CC0033;
	Wed,  5 Oct 2022 16:54:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBDDCC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 16:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B8E858140B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 16:54:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8E858140B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G0iqiZ2fBcUG
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 16:54:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E08281407
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E08281407
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 16:54:19 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id f193so15760865pgc.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Oct 2022 09:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=GFGmeXwzImdz1h+PmMN1s24FBEmejNYEC+q1xWfXEck=;
 b=EyG6rsATbD7C887QZxyz9MgUhhEsQKIqdL5F4hwzYjNetmhCs9bVaVk9q73t6IB8g6
 twbOpXuEJgxQzLF7K+408sbpmxYhGaDXOIyMNyebYX0UCJ+B6e8fy4h+09i0//toBEiT
 Fvw/dYZjiqMfvYTOUG229pIOqYBk20Pi8cyk2kW5M2Td7WwgOuHcmrEjWHQFYBpyW0pa
 vptqAFaxobi6nzp/+odzvD0MHjGJH1qAKLFMTj1/LPbOut4DNcwospGKB9AzduC5a3B9
 djSBJiL88JEDNYGHxJQi+UJgjf6X91xjQWfzrtA3e9VkFIGC5KyicaSI2UzMBXoxyi5a
 Umbg==
X-Gm-Message-State: ACrzQf0C3gT1GhGLWUJ2VjyLDiTSCD6HS1JjrzkqpUDAZOuKNBY619ni
 0FCGQDWdK9hJGwOT5cYAoUM=
X-Google-Smtp-Source: AMsMyM5oX6qSPQ4HG3bu8E8hjU3lPQSUd8WrMcNcjR4MljBf6naYCl5wsAAwQMON9m5RMKfn4/SRMQ==
X-Received: by 2002:a62:2985:0:b0:544:77d4:f43b with SMTP id
 p127-20020a622985000000b0054477d4f43bmr726456pfp.9.1664988858370; 
 Wed, 05 Oct 2022 09:54:18 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a170902da9000b00176c6738d13sm10795484plx.169.2022.10.05.09.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Oct 2022 09:54:17 -0700 (PDT)
Message-ID: <e0ea0b0a-5077-de37-046f-62902aca93b6@acm.org>
Date: Wed, 5 Oct 2022 09:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
 <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
Cc: vincent.fu@samsung.com, hoeppner@linux.ibm.com, vincent.whitchurch@axis.com,
 baolin.wang@linux.alibaba.com, mst@redhat.com,
 linux-remoteproc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, bhelgaas@google.com,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
 agordeev@linux.ibm.com, jinpu.wang@ionos.com, hch@lst.de, alyssa@rosenzweig.io,
 vigneshr@ti.com, linux-s390@vger.kernel.org, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, richard@nod.at, vaibhavgupta40@gmail.com,
 joel@jms.id.au, shinichiro.kawasaki@wdc.com, idryomov@gmail.com,
 jejb@linux.ibm.com, asahi@lists.linux.dev, ohad@wizery.com,
 haris.iqbal@ionos.com, gor@linux.ibm.com, sven@svenpeter.dev,
 hca@linux.ibm.com, john.garry@huawei.com, josef@toxicpanda.com,
 efremov@linux.com, ming.lei@redhat.com, linux-block@vger.kernel.org,
 nbd@other.debian.org, christophe.jaillet@wanadoo.fr, sth@linux.ibm.com,
 stefanha@redhat.com, kbusch@kernel.org, ceph-devel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 axboe@kernel.dk, martin.petersen@oracle.com, wsa+renesas@sang-engineering.com,
 johannes.thumshirn@wdc.com, andersson@kernel.org, marcan@marcan.st,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dongsheng.yang@easystack.cn, christoph.boehmwalder@linbit.com,
 mcgrof@kernel.org, svens@linux.ibm.com, pbonzini@redhat.com
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

On 10/5/22 02:47, Ulf Hansson wrote:
> On Wed, 5 Oct 2022 at 07:11, Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
>> On 10/5/22 12:22, Chaitanya Kulkarni wrote:
>>> +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
>>> +             const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
>>> +             unsigned int queue_depth, unsigned int cmd_size, int numa_node,
>>> +             unsigned int timeout, unsigned int flags, void *driver_data)
>>
>> That is an awful lot of arguments... I would be tempted to say pack all
>> these into a struct but then that would kind of negate this patchset goal.
>> Using a function with that many arguments will be error prone, and hard to
>> review... Not a fan.
> 
> I completely agree.
> 
> But there is also another problem going down this route. If/when we
> realize that there is another parameter needed in the blk_mq_tag_set.
> Today that's quite easy to add (assuming the parameter can be
> optional), without changing the blk_mq_init_tag_set() interface.

Hi Chaitanya,

Please consider to drop the entire patch series. In addition to the 
disadvantages mentioned above I'd like to mention the following 
disadvantages:
* Replacing named member assignments with positional arguments in a
   function call makes code harder to read and harder to verify.
* This patch series makes tree-wide changes without improving the code
   in a substantial way.

Thanks,

Bart.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
