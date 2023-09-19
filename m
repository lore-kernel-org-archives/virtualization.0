Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CA0CD54A9
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 09:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8E1D40322;
	Tue, 19 Sep 2023 09:44:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8E1D40322
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfVLsiOU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Du99ENzPzbyp; Tue, 19 Sep 2023 09:44:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 13F8340318;
	Tue, 19 Sep 2023 09:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13F8340318
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB683C0039;
	Tue, 19 Sep 2023 09:44:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF13EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 09:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8698A615A2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 09:44:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8698A615A2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfVLsiOU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CG2Lap4HWuv9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 09:44:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E5F7615A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 09:44:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E5F7615A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695116644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vu8tgJc7XtYqldRwQrzM8br46Jv8/+7i7MeVb5Gsy6I=;
 b=NfVLsiOUT2FU7TxNuShUZaWGzIMIyeR8iPWKztp6TzBua/XbO/vDnNtkqZAV75bHWNmLg7
 53vMMmrbr7pmg9C0/T/l0jogAol5U4Nb+JP2EMs/FBJTMExU7bXWT8PSY+p3qMZW8aE1lp
 rQSOmV29fW2bjTIw9Jb+hFg+DW4FHpM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-tdEC_ilvNp-J0IKSo0v0tw-1; Tue, 19 Sep 2023 05:44:02 -0400
X-MC-Unique: tdEC_ilvNp-J0IKSo0v0tw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2bce272ebdfso68298241fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 02:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695116640; x=1695721440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vu8tgJc7XtYqldRwQrzM8br46Jv8/+7i7MeVb5Gsy6I=;
 b=gc6MTO5yGB8duxgrMd5esLdPaX6mJ8ZspH/kdkWXduNBe9XHE5GQ/aoj+tB3Qr+X37
 VWTcwl8QopR+XJw4YolOFwIvdKvL6YIPNCdNoCqEtjkP+adtmO2dRIFnAJYxcy7PNvuQ
 74EQb0ynW2/1hLV6/E+AIRSoNN0q2KpUm89WbCPtm2L2eHJ8gUzjd9bx+TCtaEOwgT6V
 9Hoof8oOmIT+Y7h8FQG3BeYPGWrG13Tk8rA8TWZnFvQ+H2Kjbfz+IObZWhQOg8d2nd4d
 Esd85yVqmDZ3gyI9MGMY/33pUavKNb/kYQGN9IshG/mDTgvcY7Ztgc1UcwZV0opZfLVH
 tRlw==
X-Gm-Message-State: AOJu0YyL+VPq/E4pWCO3K6FvMmuE8gz49BRVWqZwCLKUyR+lbH2eQ7X4
 hnmZVMgYsZ8mcsCeAsdrbmIi8cA7o9WYaG5HB6wbZBDrpRiqsPWexeDJjdY0cXp4UDwh/SI8YNu
 1MdAmVNoADYNB9cs7rapjnHQW1YIMGwouGqu2RjVvCw==
X-Received: by 2002:a05:651c:120f:b0:2b6:e958:5700 with SMTP id
 i15-20020a05651c120f00b002b6e9585700mr9841513lja.4.1695116640776; 
 Tue, 19 Sep 2023 02:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECDIbtWtvCO2ftih+O6eK9cTVxACQ5N6zMyqyehUAPmujMz2cmjb73vi4qTijKlbF52Hqz4Q==
X-Received: by 2002:a05:651c:120f:b0:2b6:e958:5700 with SMTP id
 i15-20020a05651c120f00b002b6e9585700mr9841496lja.4.1695116640436; 
 Tue, 19 Sep 2023 02:44:00 -0700 (PDT)
Received: from redhat.com ([2.52.26.122]) by smtp.gmail.com with ESMTPSA id
 rn5-20020a170906d92500b009a1e0349c4csm7520808ejb.23.2023.09.19.02.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 02:43:59 -0700 (PDT)
Date: Tue, 19 Sep 2023 05:43:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: Re: virtio-sound linux driver conformance to spec
Message-ID: <20230919054054-mutt-send-email-mst@kernel.org>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
MIME-Version: 1.0
In-Reply-To: <ZQHPeD0fds9sYzHO@pc-79.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-comment@lists.oasis-open.org, stefanha@redhat.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Sep 13, 2023 at 05:04:24PM +0200, Matias Ezequiel Vara Larsen wrote:
> Hello,
> 
> This email is to report a behavior of the Linux virtio-sound driver that
> looks like it is not conforming to the VirtIO specification. The kernel
> driver is moving buffers from the used ring to the available ring
> without knowing if the content has been updated from the user. If the
> device picks up buffers from the available ring just after it is
> notified, it happens that the content is old.

Then, what happens, exactly? Do things still work?

> This problem can be fixed
> by waiting a period of time after the device dequeues a buffer from the
> available ring. The driver should not be allowed to change the content
> of a buffer in the available ring. When buffers are enqueued in the
> available ring, the device can consume them immediately.
> 
> 1. Is the actual driver implementation following the spec?  
> 2. Shall the spec be extended to support such a use-case?
> 
> Thanks, Matias

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
