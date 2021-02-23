Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46FAC433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:53:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE80864DA1
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE80864DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EF1D605A6;
	Tue, 23 Feb 2021 09:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wrHNX4Mxk2jf; Tue, 23 Feb 2021 09:53:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C429605AF;
	Tue, 23 Feb 2021 09:53:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0ECBC000D;
	Tue, 23 Feb 2021 09:53:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74D9EC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56ED082E90
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aC45hmZVjlCK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:53:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD16682E57
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614074009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3iRlQAb8NR4S864/drBbnoAa/bgkuXinK7NYmx/5MxE=;
 b=Eg1mdIPWitUDfY4PsWPD19LO/KegCHlnypM+2C/urZSf4j2Be124JoWmDg1wrU4VAFjJMk
 I/4PbbnBjyvEeXDGCRVXPM93jwlYMAcT+dnPJ7MTWXD2bl66kfGfQENQ5ukLABYawejfVb
 eHgwkxEAdTrqnxa7uZM/pyEwwLvPcfI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-mhe1Gr2fM0a4ifSem8M1QA-1; Tue, 23 Feb 2021 04:53:26 -0500
X-MC-Unique: mhe1Gr2fM0a4ifSem8M1QA-1
Received: by mail-wm1-f70.google.com with SMTP id m6so495523wml.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 01:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3iRlQAb8NR4S864/drBbnoAa/bgkuXinK7NYmx/5MxE=;
 b=HqmlHHUvWu5TLaJLntf3nhcD5kIKq9rtncqPtegPkacI1C2MAF+ucAJ+Je2w6OrXOu
 1XBiWsnmaHWXywH5AEF1LZ9UKW4AHm9U7z31FmTfVWkMx0s7IZJq9KmGws4Dzog2KjkT
 0hzaa/MrlH+F+IQNhXWrUOb/Ywxzzoy4VcXHW2+Kxo+H2wbevdfsBTgxkAgRphmziZsq
 ZIxBaFj9D2v5Uy8tKKXA8FIJRiWHbFiGYNZVd0rr3xaOJKr2gmQkKF8YuVO1qk3YqWDa
 M4zjhsap8qtOK7KHCwc0W6/jzwAgSRQoSWrPGmdxv6hIfBXzSHjxSL1mVIf4rMClsMyz
 Kr4A==
X-Gm-Message-State: AOAM530F1Csk7sxBQcU2xkQqtsjeQ4ZDgBfqOMsLjdpKoUOdvg7Tb59y
 wpEaZQw1tz/xk5ccCuMNxm7y8NwNrEGct8mgpky+/Lcf98qssWkMUpmoJsTfVcwl0MZnwIi+q5/
 U9ImfU9LsTO2ohY1IlBwQ+KBcqbDEZfd9ciX0LYbWqw==
X-Received: by 2002:a1c:2947:: with SMTP id p68mr23729323wmp.90.1614074005619; 
 Tue, 23 Feb 2021 01:53:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwg27tf+yWW0ruRTXllg1dVIJuVcks4dmkrJA88zblsvgZbfLnq/dBGUD6LVTzryPrBZXmooA==
X-Received: by 2002:a1c:2947:: with SMTP id p68mr23729315wmp.90.1614074005460; 
 Tue, 23 Feb 2021 01:53:25 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id i8sm36891304wry.90.2021.02.23.01.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 01:53:25 -0800 (PST)
Date: Tue, 23 Feb 2021 04:53:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: vsock virtio: questions about supporting DGRAM type
Message-ID: <20210223045001-mutt-send-email-mst@kernel.org>
References: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 imbrenda@linux.vnet.ibm.com, xieyongji@bytedance.com, stefanha@redhat.com,
 asias@redhat.com, virtualization@lists.linux-foundation.org
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

On Thu, Feb 11, 2021 at 10:04:34PM -0800, Jiang Wang . wrote:
> Hi guys,
> 
> I am working on supporting DGRAM type for virtio/vhost vsock. I
> already did some work and a draft code is here (which passed my tests,
> but still need some cleanup and only works from host to guest as of
> now, will add host to guest soon):
> https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
> qemu changes are here:
> https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb
> 
> Today, I just noticed that the Asias had an old version of virtio
> which had both dgram and stream support, see this link:
> https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
> 
> But somehow, the dgram part seems never merged to upstream linux (the
> stream part is merged). If so, does anyone know what is the reason for
> this? Did we drop dgram support for some specific reason or the code
> needs some improvement?

It's not just code it's the spec that needs work.

See some issues pointed out here:

https://lists.oasis-open.org/archives/virtio-dev/201506/msg00003.html



> My current code differs from Asias' code in some ways. It does not use
> credit and does not support fragmentation.  It basically adds two virt
> queues and re-uses the existing functions for tx and rx ( there is
> somewhat duplicate code for now, but I will try to make common
> functions to reduce it). If we still want to support dgram in upstream
> linux, which way do you guys recommend? If necessary, I can try to
> base on Asias' old code and continue working on it. If there is
> anything unclear, just let me know. Thanks.
> 
> Regards,
> 
> Jiang

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
