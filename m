Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0AAC07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 15:23:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E29A61968
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 15:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E29A61968
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 05A6C402BC;
	Mon,  5 Jul 2021 15:23:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uLnrJbH9S6nC; Mon,  5 Jul 2021 15:23:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F6B740164;
	Mon,  5 Jul 2021 15:23:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72DDBC0010;
	Mon,  5 Jul 2021 15:23:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51957C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 15:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F7D840315
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 15:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XabgHIjuk73m
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 15:23:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D90D4030A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625498622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r2imsBDLHS8rC/hkSxHiuEVGdRV9OR2l0LhTihLqoT4=;
 b=Unwb6ET9HOjfTYIqza2Fw9Pi1JhaNNTIA/ORnuPmhnr5PoJJAZ7NnPugZVtjnMrlz9yCQe
 VrZPe1XM7+yx8AmnrBkqgl/EHBGIKZAT4MuuL/jxqgqt5CogRCvS77sM8rEpXvbHWscNJN
 ECvt9HwgAbKQHiec3hZVXgHXWMtGD7o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-IduiT0kFPfC_IOdOvXyrWw-1; Mon, 05 Jul 2021 11:23:41 -0400
X-MC-Unique: IduiT0kFPfC_IOdOvXyrWw-1
Received: by mail-wm1-f71.google.com with SMTP id
 t12-20020a7bc3cc0000b02901f290c9c44eso97676wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 08:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r2imsBDLHS8rC/hkSxHiuEVGdRV9OR2l0LhTihLqoT4=;
 b=mrbBLEOCZ5D4btAu5XYVxIXCJv37tMqhs945QAcJ57PFzLX288aRQuB7pDY48ZR6OR
 /bG+22azl3qvA/8EK4qGz7/MHTYirWiLOL3plv6iKGXfqplnvuHeOrcMQmud2lHGUYYW
 kqFVCScNw2tdEt/LbpzXYeBbGNDYhpdo3F1KR7Hmye9xz3m4XbgYi5wCaCo2OsHF9PI1
 5wsmgrj+WgIQN9jxvPGVFOCHpHi8lRGLdilfbKbwqOK3iZw7bs6gH/c4wu642Ua+loS6
 S3qM6ECLuHWPsNskcIMYSdNatZrZRJc/w+pzXpeG1aqrK8i9IxkO20b1QMzVDyGW0FNp
 r4bA==
X-Gm-Message-State: AOAM530jBgZ0DSzQsmjZMEYRd+jAbvJyMa2zYUYbW/4wODn0N/hN7LRM
 aMjsM5xfOtLCZCreWWweaazrcJEZYwvcEQA5qzNivbgQg32PJLiVBN4MJZp35NhBZJXYfC6ICjX
 7BAXAgrbyzy5bBuyRRBlgZAunZRuSUuKE1ag7PXlwiQ==
X-Received: by 2002:a1c:ed08:: with SMTP id l8mr15084306wmh.38.1625498620563; 
 Mon, 05 Jul 2021 08:23:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym7nxOUkrVOSJ373jn1gschu21kFntb7dSjS1xiqNy/Gh/kFjxLb5+nfUyvQAjU0bU2OESJg==
X-Received: by 2002:a1c:ed08:: with SMTP id l8mr15084280wmh.38.1625498620313; 
 Mon, 05 Jul 2021 08:23:40 -0700 (PDT)
Received: from steredhat (host-87-7-214-34.retail.telecomitalia.it.
 [87.7.214.34])
 by smtp.gmail.com with ESMTPSA id y8sm13359781wrr.76.2021.07.05.08.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 08:23:39 -0700 (PDT)
Date: Mon, 5 Jul 2021 17:23:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [MASSMAIL KLMS]Re: [RFC PATCH v2 0/6] Improve SOCK_SEQPACKET
 receive logic
Message-ID: <20210705152336.ibv4ret3d2dyhdpc@steredhat>
References: <20210704080820.88746-1-arseny.krasnov@kaspersky.com>
 <20210704042843-mutt-send-email-mst@kernel.org>
 <b427dee7-5c1b-9686-9004-05fa05d45b28@kaspersky.com>
 <20210704055037-mutt-send-email-mst@kernel.org>
 <c9f0d355-27a1-fb19-eac0-06a5d7648f5d@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <c9f0d355-27a1-fb19-eac0-06a5d7648f5d@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jul 05, 2021 at 01:48:28PM +0300, Arseny Krasnov wrote:
>
>On 04.07.2021 12:54, Michael S. Tsirkin wrote:
>> On Sun, Jul 04, 2021 at 12:23:03PM +0300, Arseny Krasnov wrote:
>>> On 04.07.2021 11:30, Michael S. Tsirkin wrote:
>>>> On Sun, Jul 04, 2021 at 11:08:13AM +0300, Arseny Krasnov wrote:
>>>>> 	This patchset modifies receive logic for SOCK_SEQPACKET.
>>>>> Difference between current implementation and this version is that
>>>>> now reader is woken up when there is at least one RW packet in rx
>>>>> queue of socket and data is copied to user's buffer, while merged
>>>>> approach wake up user only when whole message is received and kept
>>>>> in queue. New implementation has several advantages:
>>>>>  1) There is no limit for message length. Merged approach requires
>>>>>     that length must be smaller than 'peer_buf_alloc', otherwise
>>>>>     transmission will stuck.
>>>>>  2) There is no need to keep whole message in queue, thus no
>>>>>     'kmalloc()' memory will be wasted until EOR is received.
>>>>>
>>>>>     Also new approach has some feature: as fragments of message
>>>>> are copied until EOR is received, it is possible that part of
>>>>> message will be already in user's buffer, while rest of message
>>>>> still not received. And if user will be interrupted by signal or
>>>>> timeout with part of message in buffer, it will exit receive loop,
>>>>> leaving rest of message in queue. To solve this problem special
>>>>> callback was added to transport: it is called when user was forced
>>>>> to leave exit loop and tells transport to drop any packet until
>>>>> EOR met.
>>>> Sorry about commenting late in the game.  I'm a bit lost
>>>>
>>>>
>>>> SOCK_SEQPACKET
>>>> Provides sequenced, reliable, bidirectional, connection-mode transmission paths for records. A record can be sent using one or more output operations and received using one or more input operations, but a single operation never transfers part of more than one record. Record boundaries are visible to the receiver via the MSG_EOR flag.
>>>>
>>>> it's supposed to be reliable - how is it legal to drop packets?
>>> Sorry, seems i need to rephrase description. "Packet" here means fragment of record(message) at transport
>>>
>>> layer. As this is SEQPACKET mode, receiver could get only whole message or error, so if only several fragments
>>>
>>> of message was copied (if signal received for example) we can't return it to user - it breaks SEQPACKET sense. I think,
>>>
>>> in this case we can drop rest of record's fragments legally.
>>>
>>>
>>> Thank You
>> Would not that violate the reliable property? IIUC it's only ok to
>> return an error if socket gets closed. Just like e.g. TCP ...
>>
>Sorry for late answer, yes You're right, seems this is unwanted drop...
>
>Lets wait for Stefano Garzarella feedback

It was the same concern I had with the series that introduced SEQPACKET 
for vsock, which is why I suggested to wait until the message is 
complete, before copying it to the user's buffer.

IIUC, with the current upstream implementation, we don't have this 
problem, right?

I'm not sure how to fix this, other than by keeping all the fragments 
queued until we've successfully copied them to user space, which is what 
we should do without this series applied IIUC.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
