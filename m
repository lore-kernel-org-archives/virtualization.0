Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68A7C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 10:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E812606E3;
	Thu, 25 Nov 2021 10:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UoEXmba8v5kJ; Thu, 25 Nov 2021 10:40:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0AC9C60642;
	Thu, 25 Nov 2021 10:40:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B998CC002F;
	Thu, 25 Nov 2021 10:40:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E531DC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 10:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5C0C82662
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 10:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DOddpmcQRhWD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 10:40:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D3D3823E0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637836851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5he1m6t1NdCQczldB6T9Fxva3O0cBowXGHxSUlbIFDo=;
 b=ifPLRJzxVpNGXMXoSEQWJrl8vRcNLyf8e+H2WFp51leB9LHXOKuSA27zdGxUbRcP5TswmJ
 rgK9f9aZGl8JMFbWrpEtYnichmfT6JjbX6VCb0ngKg7fTq5liM9fdjzztC8amXizSipBgp
 XC4O1dtfDjyvkaLIZtLyEP77xx2E0aM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-o0VX6D8LNi-ouP5wAUCUiA-1; Thu, 25 Nov 2021 05:40:50 -0500
X-MC-Unique: o0VX6D8LNi-ouP5wAUCUiA-1
Received: by mail-ed1-f71.google.com with SMTP id
 r16-20020a056402019000b003e6cbb77ed2so5144223edv.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 02:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5he1m6t1NdCQczldB6T9Fxva3O0cBowXGHxSUlbIFDo=;
 b=hz+jCo5focl5g8sKwJexgsZAdBJo5NHUt6VO7UdYfUT6S7epr4lDSikPtwFBmcwh6u
 Na0a2+5UF6MMJkClD1I8uMtfR8qHE5bllDCerqUGOrx5Icmm7CUO/GvEyuHhupQL9Rkh
 mQthFilRb+SRZRoripO2rqS7vY2XmqrSOJSZHkosmjpy0jQHP7kdhqHweSBJzKG82cjg
 e8l0HM+PQdwyChxU1hxtN/pemC2J/p9CkO0WoRsFNsZwoQOk9ZJKoWHE8K5x8+LQIOgD
 WCXqek4lVwbFw6YBabXpSaQShgFkJ0fUlH1q4u4oQnfANkL+NWnB9sgDgKD8BKhOJkhg
 yhtg==
X-Gm-Message-State: AOAM532TzOESXYzv2wAPynNATlyFgS0HV5yrHUMJapAvuktJqOoFs9LN
 1uJ5SBF7f9ygI6ohOZ49AYpFALKmN3Ml82IcrItrdyC8XEUkAs2n3ySR45bX6Vc3WPpcljkJnCN
 bKToUeKwzHOZVbciHGYPCK5isEozH22sPLerhWtkeMA==
X-Received: by 2002:a50:d68e:: with SMTP id r14mr36818820edi.5.1637836849026; 
 Thu, 25 Nov 2021 02:40:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/TqPG4ycF6Z2EBWtkjQfr+eSy5n2rbj86EKdj5a+Yk7xMya6qCElb5hQyhaQ0YbKZ5BTbvA==
X-Received: by 2002:a50:d68e:: with SMTP id r14mr36818794edi.5.1637836848851; 
 Thu, 25 Nov 2021 02:40:48 -0800 (PST)
Received: from steredhat (host-79-46-195-175.retail.telecomitalia.it.
 [79.46.195.175])
 by smtp.gmail.com with ESMTPSA id ho30sm1297351ejc.30.2021.11.25.02.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 02:40:48 -0800 (PST)
Date: Thu, 25 Nov 2021 11:40:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Message-ID: <20211125104046.wxupkn6uogvohioi@steredhat>
References: <20211125071554.16969-1-wei.w.wang@intel.com>
 <7992566c682b46dc9ec2502e44a2fb04@intel.com>
MIME-Version: 1.0
In-Reply-To: <7992566c682b46dc9ec2502e44a2fb04@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "asias@redhat.com" <asias@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

On Thu, Nov 25, 2021 at 09:27:40AM +0000, Wang, Wei W wrote:
>On Thursday, November 25, 2021 3:16 PM, Wang, Wei W wrote:
>> -	/* Update CID in case it has changed after a transport reset event */
>> -	vsk->local_addr.svm_cid = dst.svm_cid;
>> -
>>  	if (space_available)
>>  		sk->sk_write_space(sk);
>>
>
>Not sure if anybody knows how this affects the transport reset.

I believe the primary use case is when a guest is migrated.

After the migration, the transport gets a reset event from the 
hypervisor and all connected sockets are closed. The ones in listen 
remain open though.

Also the guest's CID may have changed after migration. So if an 
application has open listening sockets, bound to the old CID, this 
should ensure that the socket continues to be usable.

The patch would then change this behavior.

So maybe to avoid problems, we could update the CID only if it is 
different from VMADDR_CID_ANY:

	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
		vsk->local_addr.svm_cid = dst.svm_cid;


When this code was written, a guest only supported a single transport, 
so it could only have one CID assigned, so that wasn't a problem.
For that reason I'll add this Fixes tag:
Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
