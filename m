Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B244EB64D9
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 10:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C710F81DEA;
	Wed, 12 Jul 2023 10:14:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C710F81DEA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BAIMWJgt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kwlTY6kVmn-H; Wed, 12 Jul 2023 10:14:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C30081DAB;
	Wed, 12 Jul 2023 10:14:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C30081DAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 224BBC0072;
	Wed, 12 Jul 2023 10:14:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90DABC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 10:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DD3A81DAB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 10:14:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DD3A81DAB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BBEoorqnnaFt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 10:14:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BBDE81D7C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BBDE81D7C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 10:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689156862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/4n1T4Di9dqAOFGS+inlBrET7BRHhbAxPcO28uG01Q=;
 b=BAIMWJgtG6VEtRGX9d515J6gvBbxcl+tp9jvWt/PJ0jpMnXFGtzaKaZ4FvxK64A8Hi8a21
 aiK+u01anSpdd+gZo5/Q1ZqLnQL87vdQOWVHf5P5xJtYXJVnXSAstQiMYPH0Vb8zF8PJ6p
 8+f8ZhH6012pbfZnEKZs2z/0bBFk5Ho=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-5zipJN8bOAO3LLDNKojdxA-1; Wed, 12 Jul 2023 06:14:21 -0400
X-MC-Unique: 5zipJN8bOAO3LLDNKojdxA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-635a4267cf5so64464676d6.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 03:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689156860; x=1691748860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/4n1T4Di9dqAOFGS+inlBrET7BRHhbAxPcO28uG01Q=;
 b=NsckC2UGQyRe8OWPmoBxxQk4RsBt1TPMY0gSSrFpmPnW9gc/PHPtK4XHbtlsW6or4w
 idK0X/Zc5aA/UCQdk+Fdl9SM6OIOX4mrtLZWyqeAFzUAMnqP+5b8fLsX3vxooa6Wl4uW
 UNkJjXnaExdWlQjR2XaYolWz2UIwvm84zwb9SMA2ic179fgBNDgMTKMjnIy32LyqR0vi
 16fCZC+ntgSxafctKev7Emws5kvr5VlqIBH3nsh0lGpb8z/whTMswIjJtgzGqmvr+kmX
 jsQdII3QYbGYqOkLfHGUG/97ITwqaDPZiA1X2STwsK1jUfNpz67VVvtfWGa99Vsqohfn
 qzcg==
X-Gm-Message-State: ABy/qLZ3vAjmVRomBEAXttzkqr3E94ivO7X7GjYtYNwVDOiD22ztAjvp
 2oFOyRidB1D5PgEocY+CvpGZPQH9By3NaW+a/UUnKLtFTTw5vCUhTePdWOyDONzYV7W4svWKz/A
 5ckCrdCKnOLx4bQmCl38gp0wedz2R/YNZruG+9J3SyA==
X-Received: by 2002:ac8:5b0b:0:b0:403:9f48:7ce1 with SMTP id
 m11-20020ac85b0b000000b004039f487ce1mr17970973qtw.53.1689156860695; 
 Wed, 12 Jul 2023 03:14:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlxbb8j7LshAiGKZNfsSGwJ4zTSF2mOzrqRvKk5LzC+D2tYuiNcSmvHeC6WLXDnQaz2YIMjw==
X-Received: by 2002:ac8:5b0b:0:b0:403:9f48:7ce1 with SMTP id
 m11-20020ac85b0b000000b004039f487ce1mr17970952qtw.53.1689156860434; 
 Wed, 12 Jul 2023 03:14:20 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-6.retail.telecomitalia.it.
 [82.53.134.6]) by smtp.gmail.com with ESMTPSA id
 c14-20020ac81e8e000000b0040331f93ee0sm2123644qtm.77.2023.07.12.03.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 03:14:20 -0700 (PDT)
Date: Wed, 12 Jul 2023 12:14:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <bnitgwesvbjdkbrvnykltherzddi3zvms3ckd5yk3w4whdplu3@tv43e42wjl55>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <765f14c5-a938-ebd9-6383-4fe3d5c812ca@oracle.com>
 <10a3d00f-a3a2-91d1-0f94-9758cdc4b969@redhat.com>
MIME-Version: 1.0
In-Reply-To: <10a3d00f-a3a2-91d1-0f94-9758cdc4b969@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Wed, Jul 12, 2023 at 10:06:56AM +0200, Paolo Bonzini wrote:
>On 7/11/23 22:21, Mike Christie wrote:
>>What was the issue you are seeing?
>>
>>Was it something like you get the UA. We retry then on one of the
>>retries the sense is not setup correctly, so the scsi error handler
>>runs? That fails and the device goes offline?
>>
>>If you turn on scsi debugging you would see:
>>
>>
>>[  335.445922] sd 0:0:0:0: [sda] tag#15 Add. Sense: Reported luns data has changed
>>[  335.445922] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445925] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445929] sd 0:0:0:0: [sda] tag#17 Done: FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>>[  335.445932] sd 0:0:0:0: [sda] tag#17 CDB: Write(10) 2a 00 00 db 4f c0 00 00 20 00
>>[  335.445934] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445936] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445938] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445940] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445942] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445945] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.451447] scsi host0: scsi_eh_0: waking up 0/2/2
>>[  335.451453] scsi host0: Total of 2 commands on 1 devices require eh work
>>[  335.451457] sd 0:0:0:0: [sda] tag#16 scsi_eh_0: requesting sense
>
>Does this log come from internal discussions within Oracle?
>
>>I don't know the qemu scsi code well, but I scanned the code for my co-worker
>>and my guess was commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2 had a race in it.
>>
>>How is locking done? when it is a bus level UA but there are multiple devices
>>on the bus?
>
>No locking should be necessary, the code is single threaded.  However, 
>what can happen is that two consecutive calls to 
>virtio_scsi_handle_cmd_req_prepare use the unit attention ReqOps, and 
>then the second virtio_scsi_handle_cmd_req_submit finds no unit 
>attention (see the loop in virtio_scsi_handle_cmd_vq).  That can 
>definitely explain the log above.

Yes, this seems to be the case!
Thank you both for the help!

Following Paolo's advice, I'm preparing a series for QEMU to solve the
problem!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
