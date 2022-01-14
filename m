Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39234C4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 13:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC77184C48;
	Fri, 14 Jan 2022 13:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QDxFsJF9IDAT; Fri, 14 Jan 2022 13:38:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 502CA832DC;
	Fri, 14 Jan 2022 13:38:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 136AFC002F;
	Fri, 14 Jan 2022 13:38:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 979F5C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8560260B4D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3aIw8NUJJObt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:38:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDC8E60B4B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642167511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YhO8ftDsk4+jW9Ti1jjOdqgLJ1dfN2h8UN/qErYWEn4=;
 b=eqA6B3a5PWfUoSYxM4GrzF1IpSaoyDFfOsvUWLD/kJR1lBGnqpTde7QtSGc/1tE2f/xp+B
 w93Odnziw/vjvJ0NqWgzu+2GXFjtG2oi6F21vIlHsSYhQF/6PcgWbBlAPhbAy7oTbTX7vt
 /lpULM5b94ndDWWFNNa9jnIe15fKJOg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-qzXnneLZPEW5kp-JsBUVVw-1; Fri, 14 Jan 2022 08:38:30 -0500
X-MC-Unique: qzXnneLZPEW5kp-JsBUVVw-1
Received: by mail-pj1-f70.google.com with SMTP id
 i2-20020a17090a4b8200b001b426d8be4eso4130849pjh.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 05:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YhO8ftDsk4+jW9Ti1jjOdqgLJ1dfN2h8UN/qErYWEn4=;
 b=UyVf5cviO3mZQU1lzffEpfgpO6Aofdaewyu/J5vgOBiQtReRa5X48RWhpcl4DF5pPt
 iiNgolnS2aF/29d638U3PRAqBxiv/iMqX6NiVmCY/Jnpr3ljrTrWR/mMzTMPfcxviUEu
 soY5WqpwIVJrnqusfYMMZFuSuiTQZ84VWy1mrQbKznW0QGmVdi3aAIXiQ3S5AL6J6HUF
 uDaE2cTuak+ZGO2VIYmCnX1chlJsqzuNayU95G7SF0nIQp9K8XEarhNRjC59DTzsR3aY
 6pVvO9JbMHU/V5ldG0f7kNoGFh4ANQcykzbZ+m2/AoVAHsh06/wucA7eGZmoQWPi807H
 vsHw==
X-Gm-Message-State: AOAM531Qe755Pj3wRwEye81x/c3GkIzoIswPT1TG85X1tMBNq8kFz6CW
 o6UhUQNLMITzb2JBkLBoL0rboCOLQNvT5Op/B74kYJB6cnAvsZpN6AqgFUj+Ho6EIsjQDqPEeHT
 7A5F/orXo93u6rKcMxT+2YvkbLaIHa9JDFkNNgGLdLw==
X-Received: by 2002:a17:902:a502:b0:149:c5a5:5329 with SMTP id
 s2-20020a170902a50200b00149c5a55329mr9559626plq.164.1642167509365; 
 Fri, 14 Jan 2022 05:38:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxILsnBPX9TsvIa9qO8Uq+U+Jo4SOThql41KRmDC+m0uXyl0MuvIPYYRITKGIUaFyG3qpSUrA==
X-Received: by 2002:a17:902:a502:b0:149:c5a5:5329 with SMTP id
 s2-20020a170902a50200b00149c5a55329mr9559603plq.164.1642167509120; 
 Fri, 14 Jan 2022 05:38:29 -0800 (PST)
Received: from steredhat (host-95-238-125-214.retail.telecomitalia.it.
 [95.238.125.214])
 by smtp.gmail.com with ESMTPSA id g7sm5820333pfu.61.2022.01.14.05.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 05:38:28 -0800 (PST)
Date: Fri, 14 Jan 2022 14:38:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220114133816.7niyaqygvdveddmi@steredhat>
References: <20220114090508.36416-1-sgarzare@redhat.com>
 <20220114074454-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220114074454-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Fri, Jan 14, 2022 at 07:45:35AM -0500, Michael S. Tsirkin wrote:
>On Fri, Jan 14, 2022 at 10:05:08AM +0100, Stefano Garzarella wrote:
>> In vhost_enable_notify() we enable the notifications and we read
>> the avail index to check if new buffers have become available in
>> the meantime.
>>
>> We are not caching the avail index, so when the device will call
>> vhost_get_vq_desc(), it will find the old value in the cache and
>> it will read the avail index again.
>>
>> It would be better to refresh the cache every time we read avail
>> index, so let's change vhost_enable_notify() caching the value in
>> `avail_idx` and compare it with `last_avail_idx` to check if there
>> are new buffers available.
>>
>> Anyway, we don't expect a significant performance boost because
>> the above path is not very common, indeed vhost_enable_notify()
>> is often called with unlikely(), expecting that avail index has
>> not been updated.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>... and can in theory even hurt due to an extra memory write.
>So ... performance test restults pls?

Right, could be.

I'll run some perf test with vsock, about net, do you have a test suite 
or common step to follow to test it?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
