Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10286C5519F
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 11:24:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAA820853
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 11:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvDhga7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAA820853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2BBD686851;
	Mon, 16 Nov 2020 11:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gdbdgiZ8kgKh; Mon, 16 Nov 2020 11:24:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F5C18682F;
	Mon, 16 Nov 2020 11:24:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4621FC0891;
	Mon, 16 Nov 2020 11:24:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE4D3C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:24:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA22E870EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:24:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R-YxixJ7ypoT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:24:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2DBBC870E8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605525843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiZvfqwgppxhW4IM8Jvu0efXIHNIgO+wWL8qCIoswbY=;
 b=HvDhga7IRmPgEon7FtI+vW/zCv1qb+5noqfMBLu/Lhq9aLMKFJWyBlRMJI7kjaJsybYSa/
 ovocdshUk5K8uGCYaShOkxmAUgTYakas+83NrTUM8NHJ4ypEQ+WDgqEKMB6Rge+ptP/qdD
 6Y513cKL8mn3staFgA8YT8Per2zgmrk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-P53fUivlPaOiX2MVg2oc3Q-1; Mon, 16 Nov 2020 06:24:00 -0500
X-MC-Unique: P53fUivlPaOiX2MVg2oc3Q-1
Received: by mail-wr1-f69.google.com with SMTP id f4so10992112wru.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 03:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FiZvfqwgppxhW4IM8Jvu0efXIHNIgO+wWL8qCIoswbY=;
 b=FwGcogb+TKBzM8zVQ3cmiQnQScYwfrZ5eUqRg/WXP4TQcH1h4AbDf34md67FuSx33n
 Um+6HLJlARj/Y5rY4Z8sJl/szRDlsDKa47lYFUek144CQaFcjDmCizKWVzpfz17XIu77
 BLnYyOhlF8r0a+CY1HrOaLCL45jwBGMPY45cJI0IPofpBkEzU1E9R1NsKd4WFdpamRAn
 bqAuvbPWGEQHWi77j/nU3Bheey9XbqsUYXlGAz1ARjSU642eMvF+s6SjDcLXzrJksBb/
 gUWUY+DovCvB99tl8maS9fQL1fDuLu3Ib9ge7P+yHHctcDL7iH2u5nwJhXzB5MgAyhJN
 C88Q==
X-Gm-Message-State: AOAM531u7qnI2EUhV29ubH3BGiDSPvk3RDgSaNq8SMLJBCHRF9GsilpM
 xI0Sgy/bTQPU89N5FSO1FES8FTnAeqVpjFaMnHKxmFJed6bgCs4NeGCLg2/GgRvmwqj2kYCeKUS
 32md8GZ5r8fBolMeXv/HL3qlkKS7SwsrrBo/a4sR3bQ==
X-Received: by 2002:a1c:7e8e:: with SMTP id z136mr15456810wmc.46.1605525838885; 
 Mon, 16 Nov 2020 03:23:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyijXaCLKiuQIior2uUCDA8Exwaq67YsE7tAtnwOjZ8JmrvdfkGFcynUP8JyWVK9HRHnhbfFA==
X-Received: by 2002:a1c:7e8e:: with SMTP id z136mr15456793wmc.46.1605525838718; 
 Mon, 16 Nov 2020 03:23:58 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id g131sm20177257wma.35.2020.11.16.03.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 03:23:58 -0800 (PST)
Date: Mon, 16 Nov 2020 12:23:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20201116112355.vo6blezyrfh7kltl@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
 <20201116045029-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201116045029-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Mon, Nov 16, 2020 at 04:50:43AM -0500, Michael S. Tsirkin wrote:
>On Fri, Nov 13, 2020 at 02:47:12PM +0100, Stefano Garzarella wrote:
>> The previous implementation wrote only the status of each request.
>> This patch implements a more accurate block device simulator,
>> providing a ramdisk-like behavior.
>>
>> Also handle VIRTIO_BLK_T_GET_ID request, always answering the
>> "vdpa_blk_sim" string.
>
>Maybe an ioctl to specify the id makes more sense.

I agree that make sense to make it configurable from the user, but I'm 
not sure an ioctl() is the best interface with this device simulator.

Maybe we can use a module parameter as in the net simulator or even 
better using the new vdpa management tool recently proposed (I need to 
check better how we can extend it).

What do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
