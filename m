Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EADEB64DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 08:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF50D404A9;
	Wed, 12 Jul 2023 08:28:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF50D404A9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf34cqWX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3bBEZHP4OP7g; Wed, 12 Jul 2023 08:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8D4E404BE;
	Wed, 12 Jul 2023 08:28:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8D4E404BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FC9DC0072;
	Wed, 12 Jul 2023 08:28:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE777C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8194A60F3F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:28:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8194A60F3F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf34cqWX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p8ALv0dynPgn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:28:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CE7B60A7D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CE7B60A7D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689150488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ft77lorj+s2P25VAIDS7kNl8SOhboxm+h8Bgo4H0PZo=;
 b=Pf34cqWXaDsHPzQ6ljhVlphEdcnt68AFclWH+VrBAvtW8NMNk6RdMSm6WzDfQBoLiusICE
 WIKAWaKIYJrjqicMQB3rWi7yXSQ0JMyBKwRwFLMQJm3Xkd7jIv4ecZxaXRH7tMKfvVoQpJ
 +K7CeUvzQVDCrn2uq3RMDhtQUgHX3Cg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-XQCsI1ooNnWCF2kyGI0INw-1; Wed, 12 Jul 2023 04:28:07 -0400
X-MC-Unique: XQCsI1ooNnWCF2kyGI0INw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7677e58c1bfso888880685a.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 01:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689150487; x=1691742487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ft77lorj+s2P25VAIDS7kNl8SOhboxm+h8Bgo4H0PZo=;
 b=Mt3F8BWO6VfSXgcJvT4hy7oFn0eia4b+70JdR1imTqFBVqw6TTIkL/rJzz0IU+4qxH
 EzfS1UqK742O8wtM2YN4/BKzuLs7MQHMc+yuvpwCr/Q43pTUSsJcTduguUeU5bztVwnn
 9uz+41Ik2mXVI0Eud9xjG5cDoeBCCoxqpFa9i8oowNmeTU5OGqHkaxnMmV0agcxKgzaD
 IJzXvOrIuANaOOb2XIv46+sb7V5L+o5Ev+qnDUVvm2ovG6RzOLw6YbNX/JQVXe8PNgH/
 UdaNlKb2ACBeKxaQWa3g9QzSs96lSAlihDs8hLa8/OUbCRZ/0CXTwIMumUroOdGzTCNr
 I6WA==
X-Gm-Message-State: ABy/qLb9qkzIUKxndrHPKrtAL9F9cHNg1rXy9PaXvwC3f0MHQHBRHUbR
 zIm/jjPnx4KdLYqDbO9Tg1gV1QxROPdPvOFioUkuByafHXvTAcwQ1hFI5EbvzaJAywDWK5sdAi8
 jBsIIxaGAg/9vwnTwJgGeSBcJf6OOy924PWpF9+yHDw==
X-Received: by 2002:a37:2c81:0:b0:767:29c9:c647 with SMTP id
 s123-20020a372c81000000b0076729c9c647mr15297885qkh.28.1689150486786; 
 Wed, 12 Jul 2023 01:28:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCMxGd3FqAHhYi1J0QB6yKcMGoqDkeMZFSBQlJdK2/+s7Yle4fe+XU3U2z7dv77pMeVxMJ6g==
X-Received: by 2002:a37:2c81:0:b0:767:29c9:c647 with SMTP id
 s123-20020a372c81000000b0076729c9c647mr15297866qkh.28.1689150486449; 
 Wed, 12 Jul 2023 01:28:06 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-6.retail.telecomitalia.it.
 [82.53.134.6]) by smtp.gmail.com with ESMTPSA id
 x21-20020a05620a01f500b007678ee16016sm1975987qkn.45.2023.07.12.01.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 01:28:04 -0700 (PDT)
Date: Wed, 12 Jul 2023 10:28:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
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

On Tue, Jul 11, 2023 at 01:41:31PM -0400, Stefan Hajnoczi wrote:
>On Tue, 11 Jul 2023 at 13:06, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> CCing `./scripts/get_maintainer.pl -f drivers/scsi/virtio_scsi.c`,
>> since I found a few things in the virtio-scsi driver...
>>
>> FYI we have seen that Linux has problems with a QEMU patch for the
>> virtio-scsi device (details at the bottom of this email in the revert
>> commit message and BZ).
>>
>>
>> This is what I found when I looked at the Linux code:
>>
>> In scsi_report_sense() in linux/drivers/scsi/scsi_error.c linux calls
>> scsi_report_lun_change() that set `sdev_target->expecting_lun_change =
>> 1` when we receive a UNIT ATTENTION with REPORT LUNS CHANGED
>> (sshdr->asc == 0x3f && sshdr->ascq == 0x0e).
>>
>> When `sdev_target->expecting_lun_change = 1` is set and we call
>> scsi_check_sense(), for example to check the next UNIT ATTENTION, it
>> will return NEEDS_RETRY, that I think will cause the issues we are
>> seeing.
>>
>> `sdev_target->expecting_lun_change` is reset only in
>> scsi_decide_disposition() when `REPORT_LUNS` command returns with
>> SAM_STAT_GOOD.
>> That command is issued in scsi_report_lun_scan() called by
>> __scsi_scan_target(), called for example by scsi_scan_target(),
>> scsi_scan_host(), etc.
>>
>> So, checking QEMU, we send VIRTIO_SCSI_EVT_RESET_RESCAN during hotplug
>> and VIRTIO_SCSI_EVT_RESET_REMOVED during hotunplug. In both cases now we
>> send also the UNIT ATTENTION.
>>
>> In the virtio-scsi driver, when we receive VIRTIO_SCSI_EVT_RESET_RESCAN
>> (hotplug) we call scsi_scan_target() or scsi_add_device(). Both of them
>> will call __scsi_scan_target() at some points, sending `REPORT_LUNS`
>> command to the device. This does not happen for
>> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug). Indeed if I remove the
>> UNIT ATTENTION from the hotunplug in QEMU, everything works well.
>>
>> So, I tried to add a scan also for VIRTIO_SCSI_EVT_RESET_REMOVED:
>>
>> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
>> index bd5633667d01..c57658a63097 100644
>> --- a/drivers/scsi/virtio_scsi.c
>> +++ b/drivers/scsi/virtio_scsi.c
>> @@ -291,6 +291,7 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
>>                  }
>>                  break;
>>          case VIRTIO_SCSI_EVT_RESET_REMOVED:
>> +               scsi_scan_host(shost);
>>                  sdev = scsi_device_lookup(shost, 0, target, lun);
>>                  if (sdev) {
>>                          scsi_remove_device(sdev);
>>
>> This somehow helps, now linux only breaks if the plug/unplug frequency
>> is really high. If I put a 5 second sleep between plug/unplug events, it
>> doesn't break (at least for the duration of my test which has been
>> running for about 30 minutes, before it used to break after about a
>> minute).
>>
>> Another thing I noticed is that in QEMU maybe we should set the UNIT
>> ATTENTION first and then send the event on the virtqueue, because the
>> scan should happen after the unit attention, but I don't know if in any
>> case the unit attention is processed before the virtqueue.
>>
>> I mean something like this:
>>
>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>> index 45b95ea070..13db40f4f3 100644
>> --- a/hw/scsi/virtio-scsi.c
>> +++ b/hw/scsi/virtio-scsi.c
>> @@ -1079,8 +1079,8 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>           };
>>
>>           virtio_scsi_acquire(s);
>> -        virtio_scsi_push_event(s, &info);
>>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>> +        virtio_scsi_push_event(s, &info);
>>           virtio_scsi_release(s);
>>       }
>>   }
>> @@ -1111,8 +1111,8 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>
>>       if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
>>           virtio_scsi_acquire(s);
>> -        virtio_scsi_push_event(s, &info);
>>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>> +        virtio_scsi_push_event(s, &info);
>>           virtio_scsi_release(s);
>>       }
>>   }
>
>That is racy. It's up to the guest whether the event virtqueue or the
>UNIT ATTENTION will be processed first.

Yep, agree. I wrote above that UA could be processed in a different
order. It was just another potential problem.

>
>If the device wants to ensure ordering then it must withhold the event
>until the driver has responded to the UNIT ATTENTION. That may not be
>a good idea though.
>
>I'd like to understand the root cause before choosing a solution.

This last patch is not the solution.

I think the root cause is in the Linux driver and SCSI subsystem.
When the SCSI code receive an UA with REPORTED LUN CHANGED, it seems
it expects that `REPORT_LUNS` command is issued (I tried to describe it
in the first part).

The problem is that the SCSI stack does not send this command, so we
should do it in the driver. In fact we do it for
VIRTIO_SCSI_EVT_RESET_RESCAN (hotplug), but not for
VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug).

I think that's where the problem is, but I don't know if that's what the
specification expects, I haven't found much information on that :-(

>
>> At this point I think the problem is on the handling of the
>> VIRTIO_SCSI_EVT_RESET_REMOVED event in the virtio-scsi driver, where
>> somehow we have to redo the bus scan, but scsi_scan_host() doesn't seem
>> to be enough when the event rate is very high.
>
>Why is it necessary to rescan the whole bus instead of removing just
>the device that has been unplugged?

I hope I covered in the previous answer.

>
>> I don't know if along with this fix, we also need to limit the rate in
>> QEMU somehow.
>
>Why is a high rate problematic?

Could be related on the race that you mention before (also without that
untested diff there should be the race)

>
>> Sorry for the length of this email, but I'm not familiar with SCSI and
>> wanted some suggestions on how to proceed.
>>
>> Paolo, Stefan, Linux SCSI maintainers, any suggestion?
>
>I don't know the Linux SCSI code well enough to say, sorry. I think we
>need input from someone familiar with the code.

Thank you very much for the suggestions!
I will try to ping the SCSI maintainers.

>
>However, QEMU is not at liberty to make changes that break existing
>guests. So even if it turns out the specs allow something or there is
>an existing bug in virtio_scsi.ko, we still can't break existing
>guests.

Yes, I can see that. We need to revert or somehow fix the device in
QEMU.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
