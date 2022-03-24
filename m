Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A0AC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 11:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C52841043;
	Thu, 24 Mar 2022 11:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ikLxlv0Yna8; Thu, 24 Mar 2022 11:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 04C324103D;
	Thu, 24 Mar 2022 11:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2A4CC0012;
	Thu, 24 Mar 2022 11:31:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C0F6C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A885843DB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZHfV1hK7Ba8x
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:31:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A6051843D8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648121498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1NpkC2fEkSqd/CSAHTwNWACpSYPHkf2iIPZXWonefnU=;
 b=GZKV/DObYVj+9ZkpWe7tn3kzpW6/Xdr20hsD9gBy+38/MTWZgDtg7dChMVtGFW1PRyvbLk
 9WHYoWba4lZWgLNOjhZO7SeJED0rYQ0NhHOjaczIk7icy6XTawzcaGFBr19mdklQsAS/SP
 2KBy8sguZ3NhcarFnYhK6/hkeL8noag=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-Y_4i3b_iNL6MDBqTW2cFpg-1; Thu, 24 Mar 2022 07:31:35 -0400
X-MC-Unique: Y_4i3b_iNL6MDBqTW2cFpg-1
Received: by mail-qt1-f197.google.com with SMTP id
 t26-20020ac8739a000000b002e06aa03d4cso3417617qtp.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1NpkC2fEkSqd/CSAHTwNWACpSYPHkf2iIPZXWonefnU=;
 b=4b9yS4RE2vjoV2aMJPYETcQfT+7fV7pMRCs83ylUCLl9XfgZOnY5znC43hmkMGbfzA
 j3LVmvjMtxm7x78aM6cWH4nJ51VRHEsvNY+OgAZgG1KfF3DUv89ZajRMosHo19YA65Yc
 4SYvymAzvzkJ59TOn4+sVJjGpvN9UMRFXa2W+AFzA7pvhM8cmF5HMAqCNpNrGGp5zATX
 79sMuToSkBarvNVg8Zz0LYZsOo2fPJ29JwStGF8xmU4YeHc/gkfqlOkNLzoRmmcX/uDE
 V/nRdBVAQ6HnlRBkdaTkO6FLl7CG5rXgIxJmK2cyvng2rH8FB6SFdg+ITUdEG2S3WHM0
 vorA==
X-Gm-Message-State: AOAM532l4dJ67gy/OS+e9aJGDWu3SoKZ4FhBCvFor47IGfHOoaMuvUo/
 YbKGJrBKuz+kCyhg/4FJQFIQYwKxvFMcaEh/dOE8LFsdvMf0GTWSJ/5h9KxLZduNPeADCpik980
 u/R6CJnP6mHYFhdIgATFPpfUGoUsWq58lBoJZrLEWiQ==
X-Received: by 2002:ac8:5a8f:0:b0:2e1:b34b:30f3 with SMTP id
 c15-20020ac85a8f000000b002e1b34b30f3mr3808692qtc.77.1648121494729; 
 Thu, 24 Mar 2022 04:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjekPiDi3Ko7ojQ/j/aIK9Bc/hPbpL+E/dznL8qubjaItfkf0kyvau7TU4vOBNABxdpupVHg==
X-Received: by 2002:ac8:5a8f:0:b0:2e1:b34b:30f3 with SMTP id
 c15-20020ac85a8f000000b002e1b34b30f3mr3808671qtc.77.1648121494538; 
 Thu, 24 Mar 2022 04:31:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 b17-20020a05620a271100b00680a61f51c0sm298299qkp.16.2022.03.24.04.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 04:31:33 -0700 (PDT)
Date: Thu, 24 Mar 2022 12:31:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220324113126.f6f5hfabhqfyutix@sgarzare-redhat>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
 <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
 <20220324070612-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220324070612-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peterz@infradead.org, maz@kernel.org, keirf@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de
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

On Thu, Mar 24, 2022 at 07:07:09AM -0400, Michael S. Tsirkin wrote:
>On Thu, Mar 24, 2022 at 12:03:07PM +0100, Stefano Garzarella wrote:
>> On Thu, Mar 24, 2022 at 06:48:05AM -0400, Michael S. Tsirkin wrote:
>> > On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
>> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > >
>> > > This avoids setting DRIVER_OK twice for those drivers that call
>> > > virtio_device_ready() in the .restore
>> >
>> > Is this trying to say it's faster?
>>
>> Nope, I mean, when I wrote the original version, I meant to do the same
>> things that we do in virtio_dev_probe() where we called
>> virtio_device_ready() which not only set the state, but also called
>> .enable_cbs callback.
>>
>> Was this a side effect and maybe more compliant with the spec?
>
>
>Sorry I don't understand the question. it says "avoids setting DRIVER_OK twice" -
>why is that advantageous and worth calling out in the commit log?

I just wanted to say that it seems strange to set DRIVER_OK twice if we 
read the spec. I don't think it's wrong, but weird.

Yes, maybe we should rewrite the commit message saying that we want to 
use virtio_device_ready() everywhere to complete the setup before 
setting DRIVER_OK so we can do all the necessary operations inside (like 
in patch 3 or call enable_cbs).

Jason rewrote the commit log, so I don't know if he agrees.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
