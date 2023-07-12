Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA6CEB64D9
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 10:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4926460B01;
	Wed, 12 Jul 2023 10:24:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4926460B01
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hil4hFL5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 84wdvk9ae2-g; Wed, 12 Jul 2023 10:24:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9BB8F60ABA;
	Wed, 12 Jul 2023 10:24:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BB8F60ABA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75496C0072;
	Wed, 12 Jul 2023 10:24:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B5E9C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 10:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC34E60AC2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 10:24:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC34E60AC2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z4eHQhZp6-EV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 10:24:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0154160ABA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0154160ABA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 10:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689157451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16LsduwYFZpz+6uAILPKz1Rz7ytcW9Aohn733XoPS64=;
 b=hil4hFL5X8hOj0uw/kKBhNKMmSHPeofpRcBJQpsAs98EasDrdhoaLRRNoimkitY33Ma6mO
 Ldm5zGsCrxWvMIW8FjIaANBV2OBtFq2HICfTI9JyQraFCic8FtY8Y6glJCTMvZFSObpWA6
 wmWFwYAGzx1MP4CxOb0yNBVqfDoQhfw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-lKNK3IbAN7CmTH11FbGFiw-1; Wed, 12 Jul 2023 06:24:10 -0400
X-MC-Unique: lKNK3IbAN7CmTH11FbGFiw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7659cb9c3b3so661882885a.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 03:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689157449; x=1691749449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16LsduwYFZpz+6uAILPKz1Rz7ytcW9Aohn733XoPS64=;
 b=gToyPn520j5GxUUTv4SdTZ0gSUy2k9mijqwCUuHFrPS9aysSL9Atds46O28Efq0dwr
 zJx8cWRqeJ1PuhuElcVhWqOZlumsGttHwEVKmFg7OzwPzCeXbotjYsuttRauDMJ3g1aO
 tjF/SPBMMMwDCYFFYDHgVE0rp3EC93b/jqnBfHvLX7r5UYlYk6Ow0XB6YqTkp0srbKFu
 bdYcA9s2nV7uHV4Y8SdZxCDJ/X2lOExdAmy+K4j+TEjnhDtfG3vFhy2GDBmow7gz94j8
 +kpAxQaEv0W2Sbkn+7sKFb87BJRJnHChPkbpmG/3eLm+MN7dSpuFNXT9xWiuYhE5S1OR
 0QaA==
X-Gm-Message-State: ABy/qLbgVgxhvldSeB3+h4oxRvm5Pd4pEFVr3bJmf0R3NL7wtbyeFISN
 VxaargyN3zKvtnv4CLTxTehOn6wNacHv+oYz9v2H/q++YRBPVAMdevIPDypSNOf/gh7dftZ9v5l
 07UT4pXJNY9yFjFDVpX0E5D7wiPDKp/lKzkkgjznpeg==
X-Received: by 2002:a05:620a:4548:b0:75b:23a1:8e3a with SMTP id
 u8-20020a05620a454800b0075b23a18e3amr22098175qkp.11.1689157449677; 
 Wed, 12 Jul 2023 03:24:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfqOsduTbhdiSYs6Y5PlmTPSCDqhCfSDijs7C3XZvcuWANMc6PF+7tyGF9W8eaGON9HkUJ7A==
X-Received: by 2002:a05:620a:4548:b0:75b:23a1:8e3a with SMTP id
 u8-20020a05620a454800b0075b23a18e3amr22098161qkp.11.1689157449453; 
 Wed, 12 Jul 2023 03:24:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-6.retail.telecomitalia.it.
 [82.53.134.6]) by smtp.gmail.com with ESMTPSA id
 p13-20020ae9f30d000000b007675bef6b0dsm2012163qkg.118.2023.07.12.03.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 03:24:08 -0700 (PDT)
Date: Wed, 12 Jul 2023 12:24:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <jkzogg62ewin2oa7px6gakhjwny3zyeftivoiaiavbbmwcgraz@5nnhucfswyn7>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <1406de7f-106f-9b88-1ce9-f0aa1c034561@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1406de7f-106f-9b88-1ce9-f0aa1c034561@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>
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

On Wed, Jul 12, 2023 at 10:35:48AM +0200, Paolo Bonzini wrote:
>On 7/11/23 19:06, Stefano Garzarella wrote:
>>CCing `./scripts/get_maintainer.pl -f drivers/scsi/virtio_scsi.c`,
>>since I found a few things in the virtio-scsi driver...
>>
>>FYI we have seen that Linux has problems with a QEMU patch for the
>>virtio-scsi device (details at the bottom of this email in the revert
>>commit message and BZ).
>>
>>
>>This is what I found when I looked at the Linux code:
>>
>>In scsi_report_sense() in linux/drivers/scsi/scsi_error.c linux calls
>>scsi_report_lun_change() that set `sdev_target->expecting_lun_change =
>>1` when we receive a UNIT ATTENTION with REPORT LUNS CHANGED
>>(sshdr->asc == 0x3f && sshdr->ascq == 0x0e).
>>
>>When `sdev_target->expecting_lun_change = 1` is set and we call
>>scsi_check_sense(), for example to check the next UNIT ATTENTION, it
>>will return NEEDS_RETRY, that I think will cause the issues we are
>>seeing.
>>
>>`sdev_target->expecting_lun_change` is reset only in
>>scsi_decide_disposition() when `REPORT_LUNS` command returns with
>>SAM_STAT_GOOD.
>>That command is issued in scsi_report_lun_scan() called by
>>__scsi_scan_target(), called for example by scsi_scan_target(),
>>scsi_scan_host(), etc.
>>
>>So, checking QEMU, we send VIRTIO_SCSI_EVT_RESET_RESCAN during hotplug
>>and VIRTIO_SCSI_EVT_RESET_REMOVED during hotunplug. In both cases now we
>>send also the UNIT ATTENTION.
>>
>>In the virtio-scsi driver, when we receive VIRTIO_SCSI_EVT_RESET_RESCAN
>>(hotplug) we call scsi_scan_target() or scsi_add_device(). Both of them
>>will call __scsi_scan_target() at some points, sending `REPORT_LUNS`
>>command to the device. This does not happen for
>>VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug). Indeed if I remove the
>>UNIT ATTENTION from the hotunplug in QEMU, everything works well.
>>
>>So, I tried to add a scan also for VIRTIO_SCSI_EVT_RESET_REMOVED:
>
>The point of having the event queue is to avoid expensive scans of the 
>entire host, so I don't think this is the right thing to do.

I see. I'll follow your advice for QEMU changes ;-)

>
>On the Linux side, one change we might do is to remove the printk for 

Do you mean the "LUN assignments on this target have changed.
The Linux SCSI layer does not automatically remap LUN assignments."?

>adapters that do process hotplug/hotunplug, using a new flag in 
>scsi_host_template.  There are several callers of scsi_add_device() and 
>scsi_remove_device() in adapter code, so at least these should not 
>issue the printk:

I guess it makes sense since that message could be confusing in this
case. I'll try to send a patch for that.

>
>drivers/scsi/aacraid/commsup.c
>drivers/scsi/arcmsr/arcmsr_hba.c
>drivers/scsi/esas2r/esas2r_main.c
>drivers/scsi/hpsa.c
>drivers/scsi/ipr.c
>drivers/scsi/megaraid/megaraid_sas_base.c
>drivers/scsi/mvumi.c
>drivers/scsi/pmcraid.c
>drivers/scsi/smartpqi/smartpqi_init.c
>drivers/scsi/virtio_scsi.c
>drivers/scsi/vmw_pvscsi.c
>drivers/scsi/xen-scsifront.c
>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
