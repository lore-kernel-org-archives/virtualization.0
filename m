Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D67CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 16:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04FEC4036A;
	Mon, 21 Feb 2022 16:44:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SlVtIwvHfQY4; Mon, 21 Feb 2022 16:44:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 71B8040125;
	Mon, 21 Feb 2022 16:44:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46519C0021;
	Mon, 21 Feb 2022 16:44:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1F2AC0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AC87606A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:44:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cSTag5INvhSm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:44:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE43960671
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645461869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VNieaTwekELLlfDmLcMtpN2ymnlly2vIEQ3lgNT3la0=;
 b=RlHDYW/oWNSOZabieGNo8Iaqd7Wv0Ig4jDoEYrEk6sehYqHgbe1MhfD4le0QGv/SRUJeYL
 QaJyMtR/5VxataocwbTrb9srd7fGIQHLpO1FBCO+fNSTfpXOyDPtKf8iBaOErLqBQeGmtk
 0Bk6xbabPkBLzFrocSipOUfam0eql0s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-dC8dP9uTPaGTQr1pAjfEQQ-1; Mon, 21 Feb 2022 11:44:28 -0500
X-MC-Unique: dC8dP9uTPaGTQr1pAjfEQQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 i10-20020a05620a144a00b00648d4fa059dso3880002qkl.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 08:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VNieaTwekELLlfDmLcMtpN2ymnlly2vIEQ3lgNT3la0=;
 b=IW7wkB3tl+ACPJ3CWlM9m/UQzhFnpvWWwFdkhRqhTwVqR1fDC1WL2PnV9vLHVOnY30
 g4enOB24YmmZXGEqiFF69O31218v08KU3yGFEsMwshyIH3VaqQPWErk8UGkV2EJf0Ei6
 GI1qrSEEhxIe8byt371+smx9rd0Od4hxTuReuOiFdQbmw8fUqf5ZUTT+dLioMUzX7OYQ
 eq+D+t/12Q1ewyI+EBbFRBY1t5VcqG2DDkdmZtszeKo7AQIPjxsUvpotmgOGp++BVY2Q
 puA6bPqTIENGVY79my8nYIYP9aYvcPFjNrSEOEILz4QAItTSrbkGaTw94Gq1rGaq+p8X
 TXzg==
X-Gm-Message-State: AOAM532nIOl6w8Hc2sD0zXBeSRSI4CP2/S2grmWPLDxfb8sKCa+nHKOo
 476pqTMmATqSFljMU8qGaQPaNucnLXFIimaId+MHbBRg2Ov08jwYgm8UnQ4xhDkmU6DVRhlgq3Z
 8Ny4P6jAiaJpBzpFP+X0FcBmGCHm2CvIR1rzo4oh1QQ==
X-Received: by 2002:a37:9cd6:0:b0:5dd:184f:a6a6 with SMTP id
 f205-20020a379cd6000000b005dd184fa6a6mr12426921qke.76.1645461867989; 
 Mon, 21 Feb 2022 08:44:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9+BSp31qAHOQzN7kKtZNi6gPPEeZ2f6xPuAzosuYqWftvxHapdtxcfYdSzcIVRhUHsRkkXA==
X-Received: by 2002:a37:9cd6:0:b0:5dd:184f:a6a6 with SMTP id
 f205-20020a379cd6000000b005dd184fa6a6mr12426906qke.76.1645461867775; 
 Mon, 21 Feb 2022 08:44:27 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id y15sm27100949qko.133.2022.02.21.08.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 08:44:27 -0800 (PST)
Date: Mon, 21 Feb 2022 17:44:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Anirudh Rayabharam <mail@anirudhrb.com>
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <20220221164420.cnhs6sgxizc6tcok@sgarzare-redhat>
References: <20220221114916.107045-1-sgarzare@redhat.com>
 <CAGxU2F6aMqTaNaeO7xChtf=veDJYtBjDRayRRYkZ_FOq4CYJWQ@mail.gmail.com>
 <YhO6bwu7iDtUFQGj@anirudhrb.com>
MIME-Version: 1.0
In-Reply-To: <YhO6bwu7iDtUFQGj@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Hillf Danton <hdanton@sina.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, Feb 21, 2022 at 09:44:39PM +0530, Anirudh Rayabharam wrote:
>On Mon, Feb 21, 2022 at 02:59:30PM +0100, Stefano Garzarella wrote:
>> On Mon, Feb 21, 2022 at 12:49 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >
>> > vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
>> > ownership. It expects current->mm to be valid.
>> >
>> > vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
>> > the user has not done close(), so when we are in do_exit(). In this
>> > case current->mm is invalid and we're releasing the device, so we
>> > should clean it anyway.
>> >
>> > Let's check the owner only when vhost_vsock_stop() is called
>> > by an ioctl.
>> >
>> > Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>> > Cc: stable@vger.kernel.org
>> > Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> >  drivers/vhost/vsock.c | 14 ++++++++------
>> >  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
>
>I don't think this patch fixes "INFO: task hung in vhost_work_dev_flush"
>even though syzbot says so. I am able to reproduce the issue locally
>even with this patch applied.

Are you using the sysbot reproducer or another test?
In that case, can you share it?

 From the stack trace it seemed to me that the worker accesses a zone 
that has been cleaned (iotlb), so it is invalid and fails.
That's why I had this patch tested which should stop the worker before 
cleaning.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
