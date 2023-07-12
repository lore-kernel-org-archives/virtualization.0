Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22096EB64D9
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 08:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9C4D140374;
	Wed, 12 Jul 2023 08:07:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C4D140374
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RWeuK75N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KjD4IuOE5YqN; Wed, 12 Jul 2023 08:07:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2BC7A40445;
	Wed, 12 Jul 2023 08:07:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BC7A40445
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0004C0071;
	Wed, 12 Jul 2023 08:07:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65B38C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 327FD40374
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:07:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 327FD40374
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ur2dG_wKf9iX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:07:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D7D940142
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D7D940142
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689149222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O59WCKxUbMfNmDOivxXW/OE1WeT+hJiPQK1AgImH5r8=;
 b=RWeuK75NjFPuxrjPXk52kJOIwlZLGHNnas72tUC0Px+SJidvB0a8UrWl52ux5Sq2sX7Xah
 3ukL/OaRk6b3ojS9GYzufwvMOepfGoSwAKuWLfK8g5nY3W0bS9jXjygNKA8PSziKxwFsAS
 64xK3lGnRJ6usM9ymd/PJpt6MVkq2zQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-Gk389YACPhiIAQBcM6y-DQ-1; Wed, 12 Jul 2023 04:07:00 -0400
X-MC-Unique: Gk389YACPhiIAQBcM6y-DQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso417436066b.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 01:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689149219; x=1691741219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O59WCKxUbMfNmDOivxXW/OE1WeT+hJiPQK1AgImH5r8=;
 b=NOy/wNwMYGByjhG6Kcqci0RZYzlrCf46GWYGVXwjaWe1CsEca8UrZhHtsOMUXfxQv7
 cvD70NERRpgkkGXtA/juYgqiPECkoGw3ORGf5uzLeZo2sIXAgVUe8xZAkpEKef1dnBLy
 eN+Tm4tw8S8q1yqLlrYCGKgcCfxuffnQkjpOB4O69XcqNQDsyqePSeOdvDzDNE45H3WE
 Y0nlNC7fh4Xw1iP6lkhWDtFMXAB/S/anuREw5zqLUrQd2s9J36XnIqou0+kRAKFIyFt5
 iK33p0Lh/HQ0zmFrMCI83Xx7+LYSp6z6ZUoCSCXhxqqrMEQWpdn2U0HCDAF+KCQ4k39Q
 hTSw==
X-Gm-Message-State: ABy/qLbU5oRcpDhATshVOaHPaZBwQ3DCbUKZWUPPmQk/bvV33kKYL+cw
 TtHpovUKNJQBlkDp+HMz3D9/QQNtBCMvyi6Akk4htpIJ9LwkXL2J/IXysneHAUD6aEBQTORfgwX
 TXSXVZNRvR2G84xjaZMc8oN+otiwp2+imcoVDt8XCoQ==
X-Received: by 2002:a17:906:74d6:b0:993:e860:f20 with SMTP id
 z22-20020a17090674d600b00993e8600f20mr11896922ejl.19.1689149219500; 
 Wed, 12 Jul 2023 01:06:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGuq7PuqcFm5S8HFkqYTOvb4nN21xQh/cSvepQEY3PNGwe/jmsaBmcKV8FXkw8sNp4Dce30IQ==
X-Received: by 2002:a17:906:74d6:b0:993:e860:f20 with SMTP id
 z22-20020a17090674d600b00993e8600f20mr11896899ejl.19.1689149219068; 
 Wed, 12 Jul 2023 01:06:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 e22-20020a170906249600b00992dcae806bsm2197356ejb.5.2023.07.12.01.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 01:06:57 -0700 (PDT)
Message-ID: <10a3d00f-a3a2-91d1-0f94-9758cdc4b969@redhat.com>
Date: Wed, 12 Jul 2023 10:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
To: Mike Christie <michael.christie@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <765f14c5-a938-ebd9-6383-4fe3d5c812ca@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <765f14c5-a938-ebd9-6383-4fe3d5c812ca@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
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

On 7/11/23 22:21, Mike Christie wrote:
> What was the issue you are seeing?
> 
> Was it something like you get the UA. We retry then on one of the
> retries the sense is not setup correctly, so the scsi error handler
> runs? That fails and the device goes offline?
> 
> If you turn on scsi debugging you would see:
> 
> 
> [  335.445922] sd 0:0:0:0: [sda] tag#15 Add. Sense: Reported luns data has changed
> [  335.445922] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445925] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445929] sd 0:0:0:0: [sda] tag#17 Done: FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> [  335.445932] sd 0:0:0:0: [sda] tag#17 CDB: Write(10) 2a 00 00 db 4f c0 00 00 20 00
> [  335.445934] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445936] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445938] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445940] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445942] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445945] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.451447] scsi host0: scsi_eh_0: waking up 0/2/2
> [  335.451453] scsi host0: Total of 2 commands on 1 devices require eh work
> [  335.451457] sd 0:0:0:0: [sda] tag#16 scsi_eh_0: requesting sense

Does this log come from internal discussions within Oracle?

> I don't know the qemu scsi code well, but I scanned the code for my co-worker
> and my guess was commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2 had a race in it.
> 
> How is locking done? when it is a bus level UA but there are multiple devices
> on the bus?

No locking should be necessary, the code is single threaded.  However, 
what can happen is that two consecutive calls to 
virtio_scsi_handle_cmd_req_prepare use the unit attention ReqOps, and 
then the second virtio_scsi_handle_cmd_req_submit finds no unit 
attention (see the loop in virtio_scsi_handle_cmd_vq).  That can 
definitely explain the log above.

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
