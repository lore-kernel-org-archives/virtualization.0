Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0DEC433FE
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 15:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7107B417CB;
	Thu, 24 Nov 2022 15:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7107B417CB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cnixH7Rp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id chCosTX_TI1I; Thu, 24 Nov 2022 15:28:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90E664034A;
	Thu, 24 Nov 2022 15:28:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90E664034A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AB6DC0033;
	Thu, 24 Nov 2022 15:28:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F2CFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 15:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6832C40233
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 15:28:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6832C40233
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a2Gt4S4WawRr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 15:28:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E66F40219
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E66F40219
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669303718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0SFnyMJt/QKXqNsYANy2CzhozYJsECW+F48X0zh0KA=;
 b=cnixH7RpMw9kyelfTfdxEZLW3//7Ug0As0ekoGCCqld759J5w4W9AW32L/KihaJZbwenjs
 hEzr6RJ+6jUqsmG5paMv3g/IOr6547J6MXyiC0AoZoeAWF6Hp4Y7Vowj6WVgAmitaOW4b9
 QoUhKq4ZmLgx4UOGipoHUootAyFyhYU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-281-TYw6iJw8P8GWKiDdiZHg9g-1; Thu, 24 Nov 2022 10:28:35 -0500
X-MC-Unique: TYw6iJw8P8GWKiDdiZHg9g-1
Received: by mail-wr1-f72.google.com with SMTP id
 o8-20020adfba08000000b00241e80f08e0so490993wrg.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 07:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0SFnyMJt/QKXqNsYANy2CzhozYJsECW+F48X0zh0KA=;
 b=PatltbVujNJcVfmjYYkQGwT6iXLVWftQyPCvUQc3zNfQdmNOiXpqnBOP3ZeNonPocv
 0zqD6kNF3Z7ic1cmsV6jS/5jORGlNs/D5NPI+NX9deOihmtki2acew0mcCG8goF7QkwQ
 lGJ6GpLR40QV7cpng86DFZvzwTPcjWey5W1DSbg5/uPCW1D823ZMXGaGV+kCGI8Xl8BL
 WDX2Eox9gsjLpFdcPimwvQqDDKt/V+YLfIV6Otm+UoVZrlYlCV1MXRwZpMzrBRX8kKm+
 fI6Fw257LNOPvEpyqFwN3NX+iEHaTt+W13QLjn5ETUcGoVGdVj/r0vuWtlCmr1wnVp2R
 VIIA==
X-Gm-Message-State: ANoB5pnxP10N4BnSAndouTFYUJCNoCINlgQxxdwh2oUNh4yTUELegn+K
 lVkIg3VCpLMd7/rRBHAFU9VMOpqUOwWB2ImCVRMoZSCz+9Z23JO+a6mSW/T5QAWVkv7G5AYGEJo
 0PNGp/p28t0bAu7W9DS7MsTKqi6q+zZXt+17IG7VJXg==
X-Received: by 2002:a05:600c:4f54:b0:3d0:2d56:eb55 with SMTP id
 m20-20020a05600c4f5400b003d02d56eb55mr9174236wmq.176.1669303713860; 
 Thu, 24 Nov 2022 07:28:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7SFNvqeKEPdLoVnHkMNhD+pT2srs/vzS8vYQq70+XvhHxAMEBPydOx0THF/3kwewwS66ozzQ==
X-Received: by 2002:a05:600c:4f54:b0:3d0:2d56:eb55 with SMTP id
 m20-20020a05600c4f5400b003d02d56eb55mr9174213wmq.176.1669303713559; 
 Thu, 24 Nov 2022 07:28:33 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 az26-20020a05600c601a00b003d01b84e9b2sm2207408wmb.27.2022.11.24.07.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Nov 2022 07:28:33 -0800 (PST)
Date: Thu, 24 Nov 2022 16:28:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <oxffffaa@gmail.com>
Subject: Re: [PATCH v4] virtio/vsock: replace virtio_vsock_pkt with sk_buff
Message-ID: <20221124152830.6qhbgujs6ssw2pqx@sgarzare-redhat>
References: <20221124060750.48223-1-bobby.eshleman@bytedance.com>
 <20221124150005.vchk6ieoacrcu2gb@sgarzare-redhat>
 <03d74a68-91a3-04dd-613b-33e232937cbc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <03d74a68-91a3-04dd-613b-33e232937cbc@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, AVKrasnov@sberdevices.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Nov 24, 2022 at 06:13:49PM +0300, Arseniy Krasnov wrote:
>Hello Stefano
>
>On 24.11.2022 18:00, Stefano Garzarella wrote:
>> This is a net-next material, please remember to use net-next tag:
>> https://www.kernel.org/doc/html/v6.0/process/maintainer-netdev.html#netd=
ev-faq
>>
>> On Wed, Nov 23, 2022 at 10:07:49PM -0800, Bobby Eshleman wrote:
>>> This commit changes virtio/vsock to use sk_buff instead of
>>> virtio_vsock_pkt. Beyond better conforming to other net code, using
>>> sk_buff allows vsock to use sk_buff-dependent features in the future
>>> (such as sockmap) and improves throughput.
>>>
>>> This patch introduces the following performance changes:
>>>
>>> Tool/Config: uperf w/ 64 threads, SOCK_STREAM
>>> Test Runs: 5, mean of results
>>> Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
>>>
>>> Test: 64KB, g2h
>>> Before: 21.63 Gb/s
>>> After: 25.59 Gb/s (+18%)
>>>
>>> Test: 16B, g2h
>>> Before: 11.86 Mb/s
>>> After: 17.41 Mb/s (+46%)
>>>
>>> Test: 64KB, h2g
>>> Before: 2.15 Gb/s
>>> After: 3.6 Gb/s (+67%)
>>>
>>> Test: 16B, h2g
>>> Before: 14.38 Mb/s
>>> After: 18.43 Mb/s (+28%)
>>>
>>> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>>> ---
>>
>> The patch LGTM. I run several tests (iperf3, vsock_test,
>> vsock_diag_test, vhost-user-vsock, tcpdump) and IMO we are okay.
>>
>> I found the following problems that I would like to report:
>>
>> - vhost-user-vsock [1] is failing, but it is not an issue of this patch,
>> =A0 but a spec violation in the rust-vmm/vm-virtio/virtio-vsock crate as=
 I
>> =A0 reported here [2]. We will fix it there, this patch is fine, indeed
>> =A0 trying a guest with the new layout (1 descriptor for both header and
>> =A0 data) with vhost-vsock in Linux 6.0, everything works perfectly.
>>
>> - the new "SOCK_SEQPACKET msg bounds" [3] reworked by Arseniy fails
>> =A0 intermittently with this patch.
>>
>> =A0 Using the tests currently in the kernel tree everything is fine, so
>> =A0 I don't understand if it's a problem in the new test or in this
>> =A0 patch. I've looked at the code again and don't seem to see any
>> =A0 criticisms.
>>
>> =A0 @Arseniy @Bobby can you take a look?
>Seems i've found this problem here:
>
>https://lkml.org/lkml/2022/11/24/708
>
>Being fixed - all tests passes

Good catch!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
