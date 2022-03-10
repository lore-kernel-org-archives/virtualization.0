Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB25C433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 13:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2B1D8128C;
	Thu, 10 Mar 2022 13:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OSW2Wgwmy2Er; Thu, 10 Mar 2022 13:18:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 743CE8129A;
	Thu, 10 Mar 2022 13:18:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D933C001D;
	Thu, 10 Mar 2022 13:18:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9D36C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C905A40393
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-NbV1Qo5WdQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:18:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82C1440195
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646918326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AaTbB2RahE2iSsLEKGIK/+Kc7seBWLeb+3YRDkkqjx4=;
 b=Gv7Wvvc4nGZXCd/Op0hrgw5y+QsPwVwfmzrDWi60ojX1UThSrVFrYSObE8gDbzjNENE1rB
 7+LSQL4prO9zwtJrtWtYkPU+Jt9L8gQ0UFDlc7duHUZ32C/8Zt92xrQb+GZG61m+x0Ix+e
 F1iHdwrGEKyaZF1WCxtSf0owK+HETDA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-heHGhEdiNve8uuFVkXreUg-1; Thu, 10 Mar 2022 08:18:45 -0500
X-MC-Unique: heHGhEdiNve8uuFVkXreUg-1
Received: by mail-wr1-f72.google.com with SMTP id
 x15-20020a5d6b4f000000b001ee6c0aa287so1683429wrw.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 05:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AaTbB2RahE2iSsLEKGIK/+Kc7seBWLeb+3YRDkkqjx4=;
 b=t/OCT5hG9DwdKSk4dCNZNmrgHJl/8eMx+eJUl1xC5rCQoQR3eSVQhZBW57Yp1tqYux
 DWhhCEqp8zmJ0hg8rYnfhY1xtnoAmLB6MXu8OHgUqJRx6ZldJVEI9nXXw4VYZwMcsmcn
 I5IIE/7F1xT3GtIwMA+LM3kmINgxTNfjsODBzfXMzm6JihvZK5hqRdG7iy4dC8O7lmp+
 MqjALXO2/7Sc2W68WhELb4CKUi+bjXj3jIIm1RHDpoObdXvFcsMkLKbo2fhNlFaDWL5N
 TregK7gv6AMy9He007j1TNHP21HtomYt9V3BWH6f541YeuK+Z/vltfbjMwq6+Gamrw89
 V2PA==
X-Gm-Message-State: AOAM531kMCmIhZrwOosSLnE3Fvrj/WZ3Zi9yEosPW2cNef6ea8yy3Pss
 L1TtGCQsSqc0996Z7S1Gz6MrBZXKZLCy+w8C+66rVlXmf7ZnFOHTZMw/me0vCtRdwZrBMs5boTM
 fH59zq1QRWvE2gYrowjPeVpjwM7USucUEIw2qRtPIwA==
X-Received: by 2002:a7b:c950:0:b0:389:5328:aaa8 with SMTP id
 i16-20020a7bc950000000b003895328aaa8mr11586108wml.181.1646918323723; 
 Thu, 10 Mar 2022 05:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgKzmba4zXEK9HNLZC+24bVU+g+AF7pxzMEvmqeryAY76nPWFmYDcFtEAkBo6cbDhsgwwGRQ==
X-Received: by 2002:a7b:c950:0:b0:389:5328:aaa8 with SMTP id
 i16-20020a7bc950000000b003895328aaa8mr11586085wml.181.1646918323452; 
 Thu, 10 Mar 2022 05:18:43 -0800 (PST)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a056000108200b001f078fc13a7sm4335669wrw.73.2022.03.10.05.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 05:18:42 -0800 (PST)
Date: Thu, 10 Mar 2022 14:18:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] vsock: each transport cycles only on its own sockets
Message-ID: <20220310131840.274kduoa3tn4c7yy@sgarzare-redhat>
References: <20220310125425.4193879-1-jiyong@google.com>
 <20220310125425.4193879-2-jiyong@google.com>
 <20220310075933-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220310075933-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: adelva@google.com, Jiyong Park <jiyong@google.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 kuba@kernel.org, davem@davemloft.net
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

On Thu, Mar 10, 2022 at 08:01:53AM -0500, Michael S. Tsirkin wrote:
>On Thu, Mar 10, 2022 at 09:54:24PM +0900, Jiyong Park wrote:
>> When iterating over sockets using vsock_for_each_connected_socket, make
>> sure that a transport filters out sockets that don't belong to the
>> transport.
>>
>> There actually was an issue caused by this; in a nested VM
>> configuration, destroying the nested VM (which often involves the
>> closing of /dev/vhost-vsock if there was h2g connections to the nested
>> VM) kills not only the h2g connections, but also all existing g2h
>> connections to the (outmost) host which are totally unrelated.
>>
>> Tested: Executed the following steps on Cuttlefish (Android running on a
>> VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
>> connection inside the VM, (2) open and then close /dev/vhost-vsock by
>> `exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
>> session is not reset.
>>
>> [1] https://android.googlesource.com/device/google/cuttlefish/
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Signed-off-by: Jiyong Park <jiyong@google.com>
>> ---
>>  drivers/vhost/vsock.c            | 4 ++++
>>  net/vmw_vsock/virtio_transport.c | 7 +++++++
>>  net/vmw_vsock/vmci_transport.c   | 5 +++++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 37f0b4274113..853ddac00d5b 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -722,6 +722,10 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
>>  	 * executing.
>>  	 */
>>
>> +	/* Only handle our own sockets */
>> +	if (vsk->transport != &vhost_transport.transport)
>> +		return;
>> +
>>  	/* If the peer is still valid, no need to reset connection */
>>  	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
>>  		return;
>
>
>We know this is incomplete though. So I think it's the wrong thing to do
>when you backport, too. If all you worry about is breaking a binary
>module interface, how about simply exporting a new function when you
>backport. Thus you will have downstream both:
>
>void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
>
>void vsock_for_each_connected_socket_new(struct vsock_transport *transport,
>                                    void (*fn)(struct sock *sk));
>
>
>and then upstream we can squash these two patches.
>
>Hmm?
>

Yep, reading more of the kernel documentation [1] it seems that upstream 
we don't worry about this.

I agree with Michael, it's better to just have the final patch upstream 
and downstream will be handled accordingly.

This should make it easier upstream to backport into stable branches 
future patches that depend on this change.

Thanks,
Stefano

[1] 
https://www.kernel.org/doc/Documentation/process/stable-api-nonsense.rst

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
