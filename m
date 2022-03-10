Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D99C433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 08:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BB398416D;
	Thu, 10 Mar 2022 08:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ymiVVkGg3sKw; Thu, 10 Mar 2022 08:59:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 44D6983E75;
	Thu, 10 Mar 2022 08:59:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BCFDC0012;
	Thu, 10 Mar 2022 08:59:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99D00C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 08:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96DE284133
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 08:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7OTz6rniyZPm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 08:59:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 923F283E75
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646902778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQ/dYEhklhPcMo587rvR2qJ7KNlk74jXJG+JhU1AbRA=;
 b=EEF3IHPlc7wrkuAk82fLGBbc1Uza0LHR9aI81WrljXO+4wQ/mapZ4DjXepTCglljb/yw6/
 ni/piFF/CkX1LboEA09oPD8JnQibBUFR+1FgzxzIH7igxjxpG7GRQQguM4E3cMU8M4VAg1
 AI5InYSPLlepfxXs4f8FpPVl3ni+4x0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-bYfanafCPVCK0jSMSISlOw-1; Thu, 10 Mar 2022 03:59:36 -0500
X-MC-Unique: bYfanafCPVCK0jSMSISlOw-1
Received: by mail-ed1-f70.google.com with SMTP id
 i5-20020a056402054500b00415ce7443f4so2750441edx.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 00:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WQ/dYEhklhPcMo587rvR2qJ7KNlk74jXJG+JhU1AbRA=;
 b=kElvWjmN7NPooCMELdsA40xyE/ctaOtSm79rop49XUH8idFUJTFA3aDAA8x+WALbXV
 D6nWx+tz4reJyKry4Tu0j8VyE9FWF9sxQbs+lMl3g1git25FFUS/3fO+Z8MUYWFjRQaX
 +hTtM0Cbj8cOqu4b1eS0WLLbnzjYIzEnEdOAx7t8dRDylvGadcM0rf99KcD3sCyis5AW
 eQ4Yr9XCHCruZZWvQAIj3IL06NPAj/QzRiC1WfpcAJSedz32MWU3dzsTMocSH5lDJSG7
 g/O05t6KT9dpECH2RYQemF7hXlU95PIBYpV309/YupC5rZQYfL+UIw/fwlWV3dGAtM7y
 h/7A==
X-Gm-Message-State: AOAM531cQ6BVwKf1eZOWwjzyB591x8tedv3Eyqaf0uhjW77vAtRJegWJ
 0R8UUFUyzta9Qgt3OPeRzI00STNAwCjGDky9JU/iscVwqVStaYDtsJTyUqgM2AJZANoZy4QUeJu
 Gh3QfiLxK6OwP0hNk1zVdXKKjiWQj3St8yWMM8RN4oQ==
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id
 fe19-20020a1709072a5300b006cee4fe3f92mr3207209ejc.389.1646902774851; 
 Thu, 10 Mar 2022 00:59:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3lIVlYhT5pB9vGmIIkaBIM5FzigFqHE7Plk2kLwaMt42aBHUIWqvpJN1SkNr5CjX+UXVYzg==
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id
 fe19-20020a1709072a5300b006cee4fe3f92mr3207197ejc.389.1646902774597; 
 Thu, 10 Mar 2022 00:59:34 -0800 (PST)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a1709062bcd00b006cf71d46a1csm1546859ejg.136.2022.03.10.00.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 00:59:34 -0800 (PST)
Date: Thu, 10 Mar 2022 09:59:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiyong Park <jiyong@google.com>
Subject: Re: [PATCH] vhost/vsock: reset only the h2g connections upon release
Message-ID: <20220310085931.cpgc2cv4yg7sd4vu@sgarzare-redhat>
References: <20220310081854.2487280-1-jiyong@google.com>
MIME-Version: 1.0
In-Reply-To: <20220310081854.2487280-1-jiyong@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: adelva@google.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Hi Jiyong,

On Thu, Mar 10, 2022 at 05:18:54PM +0900, Jiyong Park wrote:
>Filtering non-h2g connections out when determining orphaned connections.
>Otherwise, in a nested VM configuration, destroying the nested VM (which
>often involves the closing of /dev/vhost-vsock if there was h2g
>connections to the nested VM) kills not only the h2g connections, but
>also all existing g2h connections to the (outmost) host which are
>totally unrelated.
>
>Tested: Executed the following steps on Cuttlefish (Android running on a
>VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
>connection inside the VM, (2) open and then close /dev/vhost-vsock by
>`exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
>session is not reset.
>
>[1] https://android.googlesource.com/device/google/cuttlefish/
>
>Signed-off-by: Jiyong Park <jiyong@google.com>
>---
> drivers/vhost/vsock.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 37f0b4274113..2f6d5d66f5ed 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -722,6 +722,10 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> 	 * executing.
> 	 */
>
>+	/* Only the h2g connections are reset */
>+	if (vsk->transport != &vhost_transport.transport)
>+		return;
>+
> 	/* If the peer is still valid, no need to reset connection */
> 	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
> 		return;
>-- 
>2.35.1.723.g4982287a31-goog
>

Thanks for your patch!

Yes, I see the problem and I think I introduced it with the 
multi-transports support (ooops).

So we should add this fixes tag:

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")


IIUC the problem is for all transports that should only cycle on their 
own sockets. Indeed I think there is the same problem if the g2h driver 
will be unloaded (or a reset event is received after a VM migration), it 
will close all sockets of the nested h2g.

So I suggest a more generic solution, modifying 
vsock_for_each_connected_socket() like this (not tested):

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 38baeb189d4e..f04abf662ec6 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -334,7 +334,8 @@ void vsock_remove_sock(struct vsock_sock *vsk)
  }
  EXPORT_SYMBOL_GPL(vsock_remove_sock);

-void vsock_for_each_connected_socket(void (*fn)(struct sock *sk))
+void vsock_for_each_connected_socket(struct vsock_transport *transport,
+                                    void (*fn)(struct sock *sk))
  {
         int i;

@@ -343,8 +344,12 @@ void vsock_for_each_connected_socket(void (*fn)(struct sock *sk))
         for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++) {
                 struct vsock_sock *vsk;
                 list_for_each_entry(vsk, &vsock_connected_table[i],
-                                   connected_table)
+                                   connected_table) {
+                       if (vsk->transport != transport)
+                               continue;
+
                         fn(sk_vsock(vsk));
+               }
         }


And all transports that call it.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
