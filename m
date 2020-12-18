Return-Path: <SRS0=st/B=FW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0619FC4361B
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 23:20:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7580223BA7
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 23:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7580223BA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C45987AB3;
	Fri, 18 Dec 2020 23:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YLskauIdNopy; Fri, 18 Dec 2020 23:20:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7870A87AB1;
	Fri, 18 Dec 2020 23:20:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 679A4C1786;
	Fri, 18 Dec 2020 23:20:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCA77C0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 23:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB2FB87C5A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 23:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BD+pipRTx6pU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 23:20:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from plasma4.jpberlin.de (plasma4.jpberlin.de [80.241.57.33])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0BF3687030
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 23:20:40 +0000 (UTC)
Received: from spamfilter01.heinlein-hosting.de
 (spamfilter01.heinlein-hosting.de [80.241.56.115])
 by plasma.jpberlin.de (Postfix) with ESMTP id 69AB4AAC9A;
 Sat, 19 Dec 2020 00:20:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
 by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de
 [80.241.56.115]) (amavisd-new, port 10030)
 with ESMTP id gb9lsDoZ1lJr; Sat, 19 Dec 2020 00:20:34 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (Client CN "*.opensynergy.com",
 Issuer "Starfield Secure Certificate Authority - G2" (not verified))
 (Authenticated sender: opensynergy@jpberlin.de)
 by plasma.jpberlin.de (Postfix) with ESMTPSA id 19E0AAA9F0;
 Sat, 19 Dec 2020 00:20:34 +0100 (CET)
Subject: Re: [PATCH RESEND v2] virtio-input: add multi-touch support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20201208210150.20001-1-vasyl.vavrychuk@opensynergy.com>
 <X8/4kRLsr8755i01@google.com>
From: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Message-ID: <c1f764da-9923-9073-0001-757587f53853@opensynergy.com>
Date: Sat, 19 Dec 2020 01:20:30 +0200
MIME-Version: 1.0
In-Reply-To: <X8/4kRLsr8755i01@google.com>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.00 / 15.00 / 15.00
X-Rspamd-Queue-Id: 69AB4AAC9A
X-Rspamd-UID: 2b4d75
Cc: "Michael S.
 Tsirkin" <mst@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Mathias Crombez <mathias.crombez@faurecia.com>, linux-input@vger.kernel.org
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

Hi, Dmitry,

Thanks for you suggestion. I have sent v3 version of the patch where I 
have applied it.

Kind regards,
Vasyl

On 09.12.20 00:05, Dmitry Torokhov wrote:
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Hi Vasyl,
> 
> On Tue, Dec 08, 2020 at 11:01:50PM +0200, Vasyl Vavrychuk wrote:
>> From: Mathias Crombez <mathias.crombez@faurecia.com>
>>
>> Without multi-touch slots allocated, ABS_MT_SLOT events will be lost by
>> input_handle_abs_event.
>>
>> Signed-off-by: Mathias Crombez <mathias.crombez@faurecia.com>
>> Signed-off-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
>> Tested-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
>> ---
>> v2: fix patch corrupted by corporate email server
>>
>>   drivers/virtio/Kconfig        | 11 +++++++++++
>>   drivers/virtio/virtio_input.c |  8 ++++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 7b41130d3f35..2cfd5b01d96d 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -111,6 +111,17 @@ config VIRTIO_INPUT
>>
>>         If unsure, say M.
>>
>> +config VIRTIO_INPUT_MULTITOUCH_SLOTS
>> +     depends on VIRTIO_INPUT
>> +     int "Number of multitouch slots"
>> +     range 0 64
>> +     default 10
>> +     help
>> +      Define the number of multitouch slots used. Default to 10.
>> +      This parameter is unused if there is no multitouch capability.
> 
> I believe the number of slots should be communicated to the guest by
> the host, similarly to how the rest of input device capabilities is
> transferred, instead of having static compile-time option.
> 
>> +
>> +      0 will disable the feature.
>> +
>>   config VIRTIO_MMIO
>>        tristate "Platform bus driver for memory mapped virtio devices"
>>        depends on HAS_IOMEM && HAS_DMA
>> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
>> index f1f6208edcf5..13f3d90e6c30 100644
>> --- a/drivers/virtio/virtio_input.c
>> +++ b/drivers/virtio/virtio_input.c
>> @@ -7,6 +7,7 @@
>>
>>   #include <uapi/linux/virtio_ids.h>
>>   #include <uapi/linux/virtio_input.h>
>> +#include <linux/input/mt.h>
>>
>>   struct virtio_input {
>>        struct virtio_device       *vdev;
>> @@ -205,6 +206,7 @@ static int virtinput_probe(struct virtio_device *vdev)
>>        unsigned long flags;
>>        size_t size;
>>        int abs, err;
>> +     bool is_mt = false;
>>
>>        if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>>                return -ENODEV;
>> @@ -287,9 +289,15 @@ static int virtinput_probe(struct virtio_device *vdev)
>>                for (abs = 0; abs < ABS_CNT; abs++) {
>>                        if (!test_bit(abs, vi->idev->absbit))
>>                                continue;
>> +                     if (input_is_mt_value(abs))
>> +                             is_mt = true;
>>                        virtinput_cfg_abs(vi, abs);
>>                }
>>        }
>> +     if (is_mt)
>> +             input_mt_init_slots(vi->idev,
>> +                                 CONFIG_VIRTIO_INPUT_MULTITOUCH_SLOTS,
>> +                                 INPUT_MT_DIRECT);
> 
> Here errors need to be handled.
> 
>>
>>        virtio_device_ready(vdev);
>>        vi->ready = true;
>> --
>> 2.23.0
>>
> 
> Thanks.
> 
> --
> Dmitry
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
