Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA3CD3443
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 06:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0B9161224;
	Tue, 19 Sep 2023 06:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0B9161224
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BPVWrZ51
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tQ60_-TAeTFA; Tue, 19 Sep 2023 06:58:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A076611EF;
	Tue, 19 Sep 2023 06:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A076611EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F418DC0071;
	Tue, 19 Sep 2023 06:58:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F5A7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 06:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EB5B408DA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 06:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EB5B408DA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BPVWrZ51
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vwUu_0nJNI1p
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 06:58:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 098A34087C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 06:58:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 098A34087C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695106717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oiz3xhs8yUJwx1oxjEQDtecnRNFKB2NCXCzRkYASGKA=;
 b=BPVWrZ51Dy7udSz05BGy6I3smrzpK8LkmR2FmDnjXcakY9vm8lzF9j0UCALKZgv4O2m3FW
 bnvfw2Pvzi5C0y0wNB8ayAm2arh/vc+aKAZOHVnMWk5OY2Heu/q1iDhr0praBIQuN7Yl5t
 yO2dnTw8yQx6229S7JKXDoYxfKhO7nU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-bu_qDtwhPqeVm5PrXyRyJA-1; Tue, 19 Sep 2023 02:58:36 -0400
X-MC-Unique: bu_qDtwhPqeVm5PrXyRyJA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401d8873904so42506085e9.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 23:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695106715; x=1695711515;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oiz3xhs8yUJwx1oxjEQDtecnRNFKB2NCXCzRkYASGKA=;
 b=H0Crs6fygo1g2/PZU0GiVhbcdr3PTIdDu5oPeuayZL89ItHLESfiomEUyowYlHk398
 noFdMSfoZVzWzDD6ZsO283h79uRVDGqZXo8Z1ziPzSK5QdcVjecm/E9twBHaHMu02qfi
 h8VG2rVwiccHOPdoq3GsTwiSrjQkn/+R+3/f04a+6ZVDPdM7QXyiWq/UzB2OoVcF2eiL
 797pfPjWTojtTXJ3vip2tv81IebmQqj0qaN0UVuAtmZ/VyuZwFgKW1Syp8SA4Wf//sOf
 1+v20DZ8pS0EtZ3LRhzs/t7A1gh3k1ZFBljm2XYHViCGxzQAVptolkeTndH5jdPtGpBP
 reIQ==
X-Gm-Message-State: AOJu0Yxa/7QgrfyOk/4uZbIeNhRujBdsJW3NgM9hRONtmpOERxZZcFi1
 8SPJefbBaubN+KJaK4gHK1Wf0/1b2gSkQA2kX1ijx2B1b2pA6yPp4rE0o4BdUfNbBbOAXcqbJUr
 rZEl8ZhLMODJ5ztU7WWVglSUTzVmhE2mM839w21LpoQ==
X-Received: by 2002:a1c:7419:0:b0:403:cc64:2dbf with SMTP id
 p25-20020a1c7419000000b00403cc642dbfmr9288347wmc.27.1695106715190; 
 Mon, 18 Sep 2023 23:58:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfrZ6JfsrZZDA0i+gwD/TumwJ0Jvnlwz1JmY/9HBL1N1ds0mga27C7Fa9qSJpFyixodMfrsQ==
X-Received: by 2002:a1c:7419:0:b0:403:cc64:2dbf with SMTP id
 p25-20020a1c7419000000b00403cc642dbfmr9288331wmc.27.1695106714832; 
 Mon, 18 Sep 2023 23:58:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 c4-20020a05600c0ac400b004030c778396sm17278428wmr.4.2023.09.18.23.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 23:58:34 -0700 (PDT)
Message-ID: <64adaae1-28a6-b175-9fb0-f4f2c26e696e@redhat.com>
Date: Tue, 19 Sep 2023 08:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <ed568bcf-0fc0-40f5-9cb3-14c2923f8bf7@opensynergy.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-comment] Re: virtio-sound linux driver conformance to spec
In-Reply-To: <ed568bcf-0fc0-40f5-9cb3-14c2923f8bf7@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: mst@redhat.com, stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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

On 9/19/23 02:35, Anton Yakovlev wrote:
> 
> If the Linux virtio sound driver violates a specification, then there 
> must be
> a conformance statement that the driver does not follow. As far as I know,
> there is no such thing at the moment.

There is one in 2.7.13.3: "The device MAY access the descriptor chains 
the driver created and the memory they refer to immediately"

And likewise for packed virtqueues in 2.8.21.1: "The device MAY access 
the descriptor and any following descriptors the driver created and the 
memory they refer to immediately"

I think it's a mistake to use MAY here, as opposed to "may".  This is 
not an optional feature, it's a MUST NOT requirement on the driver's 
part that should be in 2.7.13.3.1 and 2.8.21.1.1.

This does not prevent the virtio-snd spec from overriding this.  If an 
override is desirable (for example because other hardware behaves like 
this), there should be a provision in 2.7.13.3.1 and 2.8.21.1.1.  For 
example:

2.7.13.3.1 Unless the device specification specifies otherwise, the 
driver MUST NOT write to the descriptor chains and the memory they refer 
to, between the /idx/ update and the time the device places the driver 
on the used ring.

2.8.21.1.1 "Unless the device specification specifies otherwise, the 
driver MUST NOT write to the descriptor, to any following descriptors 
the driver created, nor to the memory the refer to, between the /flags/ 
update and the time the device places the driver on the used ring.


In the virtio-snd there would be a normative statement like

5.14.6.8.1.1  The device MUST NOT read from available device-readable 
buffers beyond the first buffer_bytes / period_bytes periods.

5.14.6.8.1.2  The driver MAY write to device-readable buffers beyond the 
first buffer_bytes / period_bytes periods, even after offering them to 
the device.



As an aside, here are two other statements that have a similar issue:

- 2.6.1.1.2 "the driver MAY release any resource associated with that
virtqueue" (instead 2.6.1.1.1 should have something like "After a queue 
has been reset by the driver, the device MUST NOT access any resource 
associated with a virtqueue").

- 2.7.5.1 "[the device] MAY do so for debugging or diagnostic purposes" 
(this is not normative and can be just "may")


Thanks,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
