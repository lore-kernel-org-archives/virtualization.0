Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53991EB64D8
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 16:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC6924055F;
	Thu, 22 Jun 2023 16:37:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC6924055F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YzBsHQCM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZNWPgy3nH-mt; Thu, 22 Jun 2023 16:37:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4CB1B40296;
	Thu, 22 Jun 2023 16:37:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CB1B40296
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30214C007A;
	Thu, 22 Jun 2023 16:37:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D897C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 16:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28B3F83CD8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 16:37:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28B3F83CD8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YzBsHQCM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3r8jrdzdFbcd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 16:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2788183CD3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2788183CD3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687451860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9JewwlfUhZBK+i/3ORJq58l+o9JnC1L/BGtep803e2U=;
 b=YzBsHQCM4Zbam3cktjUEP+9RhYzUkl5CF6XJI0GRQPT+NmSssJ2FlFEp7BQmeXjCe42vFY
 guPXwPCtZWIL9ShzdS6ybKWJ2oL+PhFX2/ASHzChr4U6+FXq5Kp//SwlcUdJJG52cSZksn
 PKHkh/g0QbH1GJ+gS7p16TeYssx08bA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-YvEj5YmCNxCftp4beLOMbA-1; Thu, 22 Jun 2023 12:37:34 -0400
X-MC-Unique: YvEj5YmCNxCftp4beLOMbA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a355cf318so544644066b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 09:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687451844; x=1690043844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JewwlfUhZBK+i/3ORJq58l+o9JnC1L/BGtep803e2U=;
 b=SH/w9Kps28BOXxSs/ickgC1oDthgcVF7Voj5EPlqoY1GTNwXba9VnvJ0a4T4BjfAjZ
 SXsJZRu1vFQcy/gESc1SKYTfX5aQ0AtzuIlu9aD7R+PzNu9ZUKuCVwoHQiKylHfV95Er
 kM6YI4bXWedkReV5Cg0vA3KKKMpkCw3IsA0DRsHm8utrqYwK4KmYZrw+iuAHu+7ZxQAy
 w9ySRTR1DNSvJzb8e6JO/OOiyqDNsN4qu/gjRFAqMrSSZPoL/5y+QuVhHLc3NjILCb/h
 G8tuqghmXQ/n1/b5cTvOZFHrlgWcuooyHeQcwUuOMNXKRGr0tTVUtwllHGL8jXshsjoC
 Mg/g==
X-Gm-Message-State: AC+VfDwiDu0lxUoWAIMeVHMEAbiVkv4q98QgljdEONAgslNZpH2i4Z1x
 aK20Fx0kfJp8vahAF0VVMbfXiK1UVP5Vcl/6OdxAMoYvNzjkBwMvxpWaX84AZXlJBiCBNrmzla8
 La11nH4Gct39QJV5PmbVc73zTKtOb5rx5/Rjw9xx6dw==
X-Received: by 2002:a17:906:1d05:b0:98d:3b40:eecf with SMTP id
 n5-20020a1709061d0500b0098d3b40eecfmr1372773ejh.4.1687451844708; 
 Thu, 22 Jun 2023 09:37:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6WBDrRLIvqjb1enN3k1BFXMWSMSHxFtm3j7J6yA27lcpfSf8BJASjPHEgLDkecnWxmEIbgwA==
X-Received: by 2002:a17:906:1d05:b0:98d:3b40:eecf with SMTP id
 n5-20020a1709061d0500b0098d3b40eecfmr1372763ejh.4.1687451844433; 
 Thu, 22 Jun 2023 09:37:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 e22-20020a1709067e1600b0096f675ce45csm4808601ejr.182.2023.06.22.09.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 09:37:23 -0700 (PDT)
Date: Thu, 22 Jun 2023 18:37:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v4 7/8] vsock: Add lockless sendmsg() support
Message-ID: <6aif4uoucg6fhqwg2fmx76jkt6542dt7cqsxrtnebpboihfjeb@akpxj3yd2xle>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-7-0cebbb2ae899@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230413-b4-vsock-dgram-v4-7-0cebbb2ae899@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Vishnu Dasa <vdasa@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
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

On Sat, Jun 10, 2023 at 12:58:34AM +0000, Bobby Eshleman wrote:
>Because the dgram sendmsg() path for AF_VSOCK acquires the socket lock
>it does not scale when many senders share a socket.
>
>Prior to this patch the socket lock is used to protect both reads and
>writes to the local_addr, remote_addr, transport, and buffer size
>variables of a vsock socket. What follows are the new protection schemes
>for these fields that ensure a race-free and usually lock-free
>multi-sender sendmsg() path for vsock dgrams.
>
>- local_addr
>local_addr changes as a result of binding a socket. The write path
>for local_addr is bind() and various vsock_auto_bind() call sites.
>After a socket has been bound via vsock_auto_bind() or bind(), subsequent
>calls to bind()/vsock_auto_bind() do not write to local_addr again. bind()
>rejects the user request and vsock_auto_bind() early exits.
>Therefore, the local addr can not change while a parallel thread is
>in sendmsg() and lock-free reads of local addr in sendmsg() are safe.
>Change: only acquire lock for auto-binding as-needed in sendmsg().
>
>- buffer size variables
>Not used by dgram, so they do not need protection. No change.
>
>- remote_addr and transport
>Because a remote_addr update may result in a changed transport, but we
>would like to be able to read these two fields lock-free but coherently
>in the vsock send path, this patch packages these two fields into a new
>struct vsock_remote_info that is referenced by an RCU-protected pointer.
>
>Writes are synchronized as usual by the socket lock. Reads only take
>place in RCU read-side critical sections. When remote_addr or transport
>is updated, a new remote info is allocated. Old readers still see the
>old coherent remote_addr/transport pair, and new readers will refer to
>the new coherent. The coherency between remote_addr and transport
>previously provided by the socket lock alone is now also preserved by
>RCU, except with the highly-scalable lock-free read-side.
>
>Helpers are introduced for accessing and updating the new pointer.
>
>The new structure is contains an rcu_head so that kfree_rcu() can be
>used. This removes the need of writers to use synchronize_rcu() after
>freeing old structures which is simply more efficient and reduces code
>churn where remote_addr/transport are already being updated inside RCU
>read-side sections.
>
>Only virtio has been tested, but updates were necessary to the VMCI and
>hyperv code. Unfortunately the author does not have access to
>VMCI/hyperv systems so those changes are untested.

@Dexuan, @Vishnu, @Bryan, can you test this?

>
>Perf Tests (results from patch v2)
>vCPUS: 16
>Threads: 16
>Payload: 4KB
>Test Runs: 5
>Type: SOCK_DGRAM
>
>Before: 245.2 MB/s
>After: 509.2 MB/s (+107%)
>
>Notably, on the same test system, vsock dgram even outperforms
>multi-threaded UDP over virtio-net with vhost and MQ support enabled.
>
>Throughput metrics for single-threaded SOCK_DGRAM and
>single/multi-threaded SOCK_STREAM showed no statistically signficant
>throughput changes (lowest p-value reaching 0.27), with the range of the
>mean difference ranging between -5% to +1%.
>

Quite nice. Did you see any improvements also on stream/seqpacket
sockets?

However this is a big change, maybe I would move it to another series,
because it takes time to be reviewed and tested properly.

WDYT?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
