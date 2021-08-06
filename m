Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442B4C4338F
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 07:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E322B61179
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 07:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E322B61179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DAC283211;
	Fri,  6 Aug 2021 07:16:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qWFcMw-0f41s; Fri,  6 Aug 2021 07:16:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2641683183;
	Fri,  6 Aug 2021 07:16:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2062C001A;
	Fri,  6 Aug 2021 07:16:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 555E1C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BCAE402AC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:16:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ooLYn7jfa7PR
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:16:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86D3A400C9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628234210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4h9NXCahpaPwahhaO5hMLHu+0Sj92iJsupdJcdmnrx4=;
 b=IqJMpB2rysyezoO8jh33m24qEZ3vIm482v3NlnXcoh1a6du0gOCGVkETN9tW8zSzSwmoLe
 Y5ata5OTCNpPbDo9HJxEL1sLaN0tj3O/E23iIf/f2jPwbWbyW9ZMM832o9QGJsJDSByiN9
 KWhcUrl/zjGwkT/gxWGju9+QM8xpaT8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-lq0DxhHZPs2aWvlz-3j_Aw-1; Fri, 06 Aug 2021 03:16:48 -0400
X-MC-Unique: lq0DxhHZPs2aWvlz-3j_Aw-1
Received: by mail-ej1-f71.google.com with SMTP id
 ju25-20020a17090798b9b029058c24b55273so2880872ejc.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 Aug 2021 00:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4h9NXCahpaPwahhaO5hMLHu+0Sj92iJsupdJcdmnrx4=;
 b=sr/L08Suca4ijNSBeix/u7TdJRCj7r1f4+1PRRdlJF7GHY71W/AMMW65mkYjwJtyL6
 AA8yCkk8wEnOV4MF/XdCDOX+suhk/CuewlYBurNPfHoDvlU/lIXSuiekSsKIWabXKbIL
 AMgQ6D44/p237O3eP1anrCgiioOI9GQxzhL3aKNgzyq66KkvjY1EYRNCaSOyHhnndRIs
 Pbx8G6tCuw4YR/Ru9+RwBIvl8/dlUt608Xmi9vpJ6Jmk2jI9KpUDuwD+dA52bXVCLjhF
 AHJeT0zPjisFjvFl5HVC+Q2c5J5t45YNg98GNg1xvugAS12Rr6Es39G8YVDFIMLiQnpO
 Jwpw==
X-Gm-Message-State: AOAM530rSLyuBZRYlSepKCPygqthxTZtAu4350IQ7lsNKIIsF3yrFqji
 kXhjIYUg6Otq52hbM+Do+MMEDIa3yN+4rec39gLkW6FovL+zn2R4oKVY3Z99BqvHUrX6UsovB0o
 5OHWhKzaUgEq7YbYpR1oWTDcRKdpU1NETy6rwC+wSBA==
X-Received: by 2002:a05:6402:3552:: with SMTP id
 f18mr11179135edd.82.1628234206524; 
 Fri, 06 Aug 2021 00:16:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYURfrjKTFZrJHZ9Mcw5cT6VZwzIqZ9tPmHg4AX/+74PdKLsXxtkvp1Vnsgy4/vQl/I70njg==
X-Received: by 2002:a05:6402:3552:: with SMTP id
 f18mr11179120edd.82.1628234206380; 
 Fri, 06 Aug 2021 00:16:46 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id gv7sm2535932ejc.5.2021.08.06.00.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Aug 2021 00:16:46 -0700 (PDT)
Date: Fri, 6 Aug 2021 09:16:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [!!Mass Mail KSE][MASSMAIL KLMS] Re: [RFC PATCH v1 0/7]
 virtio/vsock: introduce MSG_EOR flag for SEQPACKET
Message-ID: <20210806071643.byebg4hmm3dtnb2x@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
 <20210804125737.kbgc6mg2v5lw25wu@steredhat>
 <8e44442c-4cac-dcbc-a88d-17d9878e7d32@kaspersky.com>
 <20210805090657.y2sz3pzhruuolncq@steredhat>
 <8bd80d3f-3e00-5e31-42a1-300ff29100ae@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <8bd80d3f-3e00-5e31-42a1-300ff29100ae@kaspersky.com>
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
 Jakub Kicinski <kuba@kernel.org>, Colin Ian King <colin.king@canonical.com>,
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

On Thu, Aug 05, 2021 at 12:21:57PM +0300, Arseny Krasnov wrote:
>
>On 05.08.2021 12:06, Stefano Garzarella wrote:
>> Caution: This is an external email. Be cautious while opening links or attachments.
>>
>>
>>
>> On Thu, Aug 05, 2021 at 11:33:12AM +0300, Arseny Krasnov wrote:
>>> On 04.08.2021 15:57, Stefano Garzarella wrote:
>>>> Caution: This is an external email. Be cautious while opening links or attachments.
>>>>
>>>>
>>>>
>>>> Hi Arseny,
>>>>
>>>> On Mon, Jul 26, 2021 at 07:31:33PM +0300, Arseny Krasnov wrote:
>>>>>       This patchset implements support of MSG_EOR bit for SEQPACKET
>>>>> AF_VSOCK sockets over virtio transport.
>>>>>       Idea is to distinguish concepts of 'messages' and 'records'.
>>>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>>>>> etc. It has fixed maximum length, and it bounds are visible using
>>>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>>>>> Current implementation based on message definition above.
>>>> Okay, so the implementation we merged is wrong right?
>>>> Should we disable the feature bit in stable kernels that contain it? Or
>>>> maybe we can backport the fixes...
>>> Hi,
>>>
>>> No, this is correct and it is message boundary based. Idea of this
>>> patchset is to add extra boundaries marker which i think could be
>>> useful when we want to send data in seqpacket mode which length
>>> is bigger than maximum message length(this is limited by transport).
>>> Of course we can fragment big piece of data too small messages, but
>>> this
>>> requires to carry fragmentation info in data protocol. So In this case
>>> when we want to maintain boundaries receiver calls recvmsg() until
>>> MSG_EOR found.
>>> But when receiver knows, that data is fit in maximum datagram length,
>>> it doesn't care about checking MSG_EOR just calling recv() or
>>> read()(e.g.
>>> message based mode).
>> I'm not sure we should maintain boundaries of multiple send(), from
>> POSIX standard [1]:
>
>Yes, but also from POSIX: such calls like send() and sendmsg()
>
>operates with "message" and if we check recvmsg() we will
>
>find the following thing:
>
>
>For message-based sockets, such as SOCK_DGRAM and SOCK_SEQPACKET, the entire
>
>message shall be read in a single operation. If a message is too long to fit in the supplied
>
>buffers, and MSG_PEEK is not set in the flags argument, the excess bytes shall be discarded.
>
>
>I understand this, that send() boundaries also must be maintained.
>
>I've checked SEQPACKET in AF_UNIX and AX_25 - both doesn't support
>
>MSG_EOR, so send() boundaries must be supported.
>
>>
>>    SOCK_SEQPACKET
>>      Provides sequenced, reliable, bidirectional, connection-mode
>>      transmission paths for records. A record can be sent using one or
>>      more output operations and received using one or more input
>>      operations, but a single operation never transfers part of more than
>>      one record. Record boundaries are visible to the receiver via the
>>      MSG_EOR flag.
>>
>>  From my understanding a record could be sent with multiple send() 
>>  and
>> received, for example, with a single recvmsg().
>> The only boundary should be the MSG_EOR flag set by the user on the 
>> last
>> send() of a record.
>You are right, if we talking about "record".
>>
>>  From send() description [2]:
>>
>>    MSG_EOR
>>      Terminates a record (if supported by the protocol).
>>
>>  From recvmsg() description [3]:
>>
>>    MSG_EOR
>>      End-of-record was received (if supported by the protocol).
>>
>> Thanks,
>> Stefano
>>
>> [1]
>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/socket.html
>> [2] 
>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/send.html
>> [3]
>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/recvmsg.html
>
>P.S.: seems SEQPACKET is too exotic thing that everyone implements it 
>in
>
>own manner, because i've tested SCTP seqpacket implementation, and 
>found
>
>that:
>
>1) It doesn't support MSG_EOR bit at send side, but uses MSG_EOR at 
>receiver
>
>side to mark MESSAGE boundary.
>
>2) According POSIX any extra bytes that didn't fit in user's buffer 
>must be dropped,
>
>but SCTP doesn't drop it - you can read rest of datagram in next calls.
>

Thanks for this useful information, now I see the differences and why we 
should support both.

I think is better to include them in the cover letter.

I'm going to review the paches right now :-)

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
