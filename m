Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14866C4167D
	for <virtualization@archiver.kernel.org>; Tue, 31 Oct 2023 16:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6EF9441947;
	Tue, 31 Oct 2023 16:35:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6EF9441947
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O+fs+Mo8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NNS99v8koBOB; Tue, 31 Oct 2023 16:35:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 85BEC411A2;
	Tue, 31 Oct 2023 16:35:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85BEC411A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A902C0039;
	Tue, 31 Oct 2023 16:35:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B95BAC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 16:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8795642F41
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 16:35:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8795642F41
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O+fs+Mo8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kmFEuGaZwBvS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 16:35:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C16A342F33
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 16:35:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C16A342F33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698770152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8RNrz/Yva6AAXDhSbIVEu5DSJqLVVmt8DdeJIQrB/I=;
 b=O+fs+Mo80bhrQggxMgtcz60kMh8MQOsCJs2aCTUZrUqQiEV0AQ7XMP6T5bsOSKdikImia1
 lRHtaBIA/SVFE0SCcqJ5T9xxbIKuUe7SNBLv0zPpyYR5bHjgYoaGAdZcSD3gXaALMEEEkv
 oefpHLe2NfUP5paBqG0vOXcHPvyrz5o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-dJ4ocneEObaBE3Lwaa9tJw-1; Tue, 31 Oct 2023 12:35:49 -0400
X-MC-Unique: dJ4ocneEObaBE3Lwaa9tJw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51da39aa6dcso4465777a12.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 09:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698770148; x=1699374948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8RNrz/Yva6AAXDhSbIVEu5DSJqLVVmt8DdeJIQrB/I=;
 b=a0otmd/1JVxkQfutqtHW3klr0XZ8njRvpqI4yKKB/NGCvPrnlWIwegFZe5CSOk+ZbW
 Cmas0FA0e8thYv/KvHl82/aHXS4UQCdwgyRkPtY+TCOHC3C9CulYx+xxg0z5aSB8zIiU
 tPuPe5jy6VBQHTMwmGRYeKT7aQW3IOWz95fh/m6EV1O3sCp3NabNzA6avlHQ4uo1ZmeD
 T/+lXxfw4Qv2lfJMm1nuLnvIWEA0BidovhmE0OoK2PI5JTOG+ytN+MrRSCyaZZt3qeQ7
 iG33NkqlCiwToS9ZkZLwxo/vqkG+hvOMYoidcAL8QaDSftLnectTqT9rpzbdMsrQ2HdI
 XoKQ==
X-Gm-Message-State: AOJu0YzVIJpvXvZGqjP5ddPzDODyrXHpvpO2QKs/wfZJ7MMdqy4gPcfx
 8UKRr7v7K52UX4Ym/RHhCNtZgDUYFEei6tO/utQDve81t1K7mbrItSPUr+I3cEyoGQseoAsP/c8
 6enBej+yEs4j9Aad9oRyVCgm9DhLUtlXBaTOrQu2JSw==
X-Received: by 2002:a05:6402:221a:b0:53e:3d9f:3c72 with SMTP id
 cq26-20020a056402221a00b0053e3d9f3c72mr10202186edb.18.1698770148021; 
 Tue, 31 Oct 2023 09:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG23z5vX3pCUte1bczUsVj5YelU4MviK3+Zf1D5qHUrCaDe+xind2RjKzLc9AzkbRpkpnJ+RA==
X-Received: by 2002:a05:6402:221a:b0:53e:3d9f:3c72 with SMTP id
 cq26-20020a056402221a00b0053e3d9f3c72mr10202159edb.18.1698770147712; 
 Tue, 31 Oct 2023 09:35:47 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.178.82])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a50cd07000000b0053e5a1bf77dsm1412398edi.88.2023.10.31.09.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 09:35:47 -0700 (PDT)
Date: Tue, 31 Oct 2023 17:35:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4] ALSA: virtio: use ack callback
Message-ID: <7agwvbpra7ywyeghawq6xs4l2rxyksyyarborezzndb73wfd6t@bxtb2n4dsrfa>
References: <ZTjkn1YAFz67yfqx@fedora> <87cyx0xvn7.wl-tiwai@suse.de>
 <jmuevryxo2nlqriqbwz6y2ttwzxwajfsnb5vaez2oqu7etkrd3@lu3pgnfushmr>
 <20231027100703-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231027100703-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org, mripard@redhat.com,
 Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, tiwai@suse.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 pbonzini@redhat.com, perex@perex.cz
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

On Fri, Oct 27, 2023 at 10:10:30AM -0400, Michael S. Tsirkin wrote:
>On Fri, Oct 27, 2023 at 12:18:00PM +0200, Stefano Garzarella wrote:
>> On Fri, Oct 27, 2023 at 11:27:40AM +0200, Takashi Iwai wrote:
>> > On Wed, 25 Oct 2023 11:49:19 +0200,
>> > Matias Ezequiel Vara Larsen wrote:
>> > >
>> > > This commit uses the ack() callback to determine when a buffer has been
>> > > updated, then exposes it to guest.
>> > >
>> > > The current mechanism splits a dma buffer into descriptors that are
>> > > exposed to the device. This dma buffer is shared with the user
>> > > application. When the device consumes a buffer, the driver moves the
>> > > request from the used ring to available ring.
>> > >
>> > > The driver exposes the buffer to the device without knowing if the
>> > > content has been updated from the user. The section 2.8.21.1 of the
>> > > virtio spec states that: "The device MAY access the descriptor chains
>> > > the driver created and the memory they refer to immediately". If the
>> > > device picks up buffers from the available ring just after it is
>> > > notified, it happens that the content may be old.
>> > >
>> > > When the ack() callback is invoked, the driver exposes only the buffers
>> > > that have already been updated, i.e., enqueued in the available ring.
>> > > Thus, the device always picks up a buffer that is updated.
>> > >
>> > > For capturing, the driver starts by exposing all the available buffers
>> > > to device. After device updates the content of a buffer, it enqueues it
>> > > in the used ring. It is only after the ack() for capturing is issued
>> > > that the driver re-enqueues the buffer in the available ring.
>> > >
>> > > Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> > > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> > > Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>> >
>> > Applied now to for-next branch.
>>
>> Cool, thanks for that!
>>
>> I just wonder if we should CC stable since we are fixing a virtio
>> specification violation.
>>
>> @Michael what do you think?
>>
>> Thanks,
>> Stefano
>
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>Fixes: de3a9980d8c3 ("ALSA: virtio: add virtio sound driver")
>
>
>The patch is too big for stable - more than 100 lines added. See:
>Documentation/process/stable-kernel-rules.rst

Yeah, I see, thanks for sharing!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
