Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DA1EB64D9
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 14:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55F9F822FC;
	Wed, 12 Jul 2023 14:26:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55F9F822FC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W3r/nmvD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yKGphXQhTwhL; Wed, 12 Jul 2023 14:26:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D500E82315;
	Wed, 12 Jul 2023 14:26:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D500E82315
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC606C0072;
	Wed, 12 Jul 2023 14:26:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C0EBC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 14:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E63E841707
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 14:26:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E63E841707
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W3r/nmvD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LKVQIHzvtg-G
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 14:26:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12622416E5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12622416E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689172013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxadBZ/e9+iHxmAJkMx44y3xAiAtBYZJ7/ie6q6tPng=;
 b=W3r/nmvD0H+4muI1dhNo/vIGgkPsHfAD05/Rrw91173eOfvvpUAgTyc2Idc6wWqZ1xlicE
 I8CKD5u1oiVkmEGJ41ZM7r/kLd1cYcVUj8u54HC1unVUWb2sAv2McJwB/eaHIB3CFqQiRQ
 wXN+WPjm3zLSHqaBWGZRkrgQEy+QcMs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-YohetznSOp-M1eJ9C7lHdQ-1; Wed, 12 Jul 2023 10:26:52 -0400
X-MC-Unique: YohetznSOp-M1eJ9C7lHdQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fbcdca90dcso5868311e87.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689172010; x=1691764010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RxadBZ/e9+iHxmAJkMx44y3xAiAtBYZJ7/ie6q6tPng=;
 b=gSLtoU5Yzw4m67i2kCqROiaIrK7ZxCKHqHvuMXtypHoEDOrdxWg8Sh91xaujZuJBA9
 mr7AzpuQhaUzMA7rpaQUeg2mBgOIdossWJ26JMnNs3Yf9g8pWB07yh5ZmZBo62nCb4Z8
 L/JZ1NrqO3QlwtaIllTPOYqYDJ5ow/ksL9AkA9o1/pBMMgUJDBae5M7BieTVc8qJPf5w
 ZLAj1lL16riyDVewU+ZhsE+TU5w6pydTCTS7Hj6ge57rn714wrSMHt1gLPHmIvJRbghI
 j5zN5aQktw1GtoDCFW30F/DU2wU+k6Xr9k+j/0RC/FeyozbKbDTAMFrTkTXIV+YgQ0f9
 zZlQ==
X-Gm-Message-State: ABy/qLanxkUN9Bf6u7HLOTzhdmBK6i1uqsTFIJoFkqd1/3fxKi3oGMf5
 INx2z2kuUqFgaNwk5CaT6qL4MSe6fOSdceFBd7bcLxO7jnVALGWc3yKqn5FnzrGMvP9TY7IMupz
 brO/gjg+WtqWiG61bql1sFTXPiww2R5ntPHilC8QNQQ==
X-Received: by 2002:a05:6512:1289:b0:4fb:745e:dd01 with SMTP id
 u9-20020a056512128900b004fb745edd01mr19236029lfs.45.1689172010761; 
 Wed, 12 Jul 2023 07:26:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFkNsKPYxzyCKFBFzT2Ba1WmnPb2DW9qQiaMClrU8mrzLR7F2hdclCVyqYRAUgqznT8iViyTw==
X-Received: by 2002:a05:6512:1289:b0:4fb:745e:dd01 with SMTP id
 u9-20020a056512128900b004fb745edd01mr19235999lfs.45.1689172010429; 
 Wed, 12 Jul 2023 07:26:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 v6-20020aa7cd46000000b0051e3385a395sm2904335edw.3.2023.07.12.07.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 07:26:49 -0700 (PDT)
Message-ID: <07672031-3e89-a221-b580-40fed4bce394@redhat.com>
Date: Wed, 12 Jul 2023 16:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
To: Christoph Hellwig <hch@infradead.org>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
 <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
 <ZK6tRDwxgbyYfv2v@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZK6tRDwxgbyYfv2v@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On 7/12/23 15:40, Christoph Hellwig wrote:
>> The problem is that the SCSI stack does not send this command, so we
>> should do it in the driver. In fact we do it for
>> VIRTIO_SCSI_EVT_RESET_RESCAN (hotplug), but not for
>> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug).
>
> No, you should absolutely no do it in the driver.  The fact that
> virtio-scsi even tries to do some of its own LUN scanning is
> problematic and should have never happened.

I agree that it should not do it for hot-unplug.  However, for hot-plug 
the spec says that a hotplug event for LUN 0 represents the addition of 
an entire target, so why is it incorrect to start a REPORT LUNS scan if 
the host doesn't tell you the exact LUN(s) that have been added?

There is a similar case in mpi3mr/mpi3mr_os.c, though it's only scanning 
for newly added devices after a controller reset.

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
