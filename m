Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4B6C433F5
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 11:17:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861F961055
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 11:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 861F961055
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 42371403F6;
	Wed, 10 Nov 2021 11:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uWYYf9nv6nkJ; Wed, 10 Nov 2021 11:17:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9FF62403F4;
	Wed, 10 Nov 2021 11:17:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8041DC0019;
	Wed, 10 Nov 2021 11:17:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68132C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 11:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56B61818C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 11:17:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9jdQ7h_nlCh4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 11:17:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C0A0818BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636543046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KSYkdLrFMduO4+IhFpw7zHlUTHCpQ25RS8J86dyqNl4=;
 b=ez5+yhwxO8Lxz3g/tzEmy8AAdr/rfupLZ7sf6pq26LOqB3z2yS816FsNh4+M1SFl2XshTz
 cPbJASURRCrEj/FNyOR2PmNGK6iCH7CDMRkCWJfF8+4bQOC+dXAbUsvHX3WdlQoFxFWkvC
 S9kCeJotgUlQ0eqltDH3XVgDbM95A54=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-3nWdtUIQMki_hHuiWKBaWA-1; Wed, 10 Nov 2021 06:17:23 -0500
X-MC-Unique: 3nWdtUIQMki_hHuiWKBaWA-1
Received: by mail-ed1-f70.google.com with SMTP id
 i9-20020a508709000000b003dd4b55a3caso2010698edb.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 03:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KSYkdLrFMduO4+IhFpw7zHlUTHCpQ25RS8J86dyqNl4=;
 b=IU+TbidgZNGMemL0xiicyq0y4jxkbDAPqQ1ZuNtrpBw8UBa38VX7HGCXiRoqNIyk9e
 RbizdOJb6Ixc5s6gcvixZa8JtthS7j3Qj25JcQKnlqD3FtKD4WsqTJ8TF4b41tysGZQq
 zlVtFWfqj8j7BMKnuHvB7NFfrGE3BQxrcGDlTgHnXv6Bfx/4+dvGvJi2/sXaDYJWT2W5
 BG+Ocaq475xDNp4vzbkbCnFn6N24ThJa4fINm0Wg+LwVYeDpvgWhD9a1Ua+FvI+Y84PB
 8cjXeD921l2L5X6owmkRpmyQIp+6XrVm3gh35A2068/LLsTnj5yQTcqS7xMMgBXhVuF6
 wQvQ==
X-Gm-Message-State: AOAM532sn9Nn3aClDCUka+j+ShjSzlflRQML4YUsC3nDX0/uanTqqes8
 brm7pa+Jb5c3pWdGuN7OCq2q3AN0Uyl0QOaVcd/NKlByzrKF4oVeZ5LmZJ0YowNkvsCdik6408i
 qPLd+vdXlJOv5b0mdAIKzpKKWEBiRw4pBZ53+XtLzgQ==
X-Received: by 2002:a17:906:388f:: with SMTP id
 q15mr19532680ejd.145.1636543042059; 
 Wed, 10 Nov 2021 03:17:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9Hggt89KbVq2bTsmJS1g2xxslDPz/3razPWPk36zSHvvckMwsFjUm1BPRAhX95CFlXwAUng==
X-Received: by 2002:a17:906:388f:: with SMTP id
 q15mr19532650ejd.145.1636543041872; 
 Wed, 10 Nov 2021 03:17:21 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id ar2sm1973327ejc.20.2021.11.10.03.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Nov 2021 03:17:21 -0800 (PST)
Date: Wed, 10 Nov 2021 12:17:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <20211110111718.5cvt6vgory3fzqld@steredhat>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
MIME-Version: 1.0
In-Reply-To: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kleen, Andi" <andi.kleen@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Andra Paraschiv <andraprs@amazon.com>
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

On Wed, Nov 10, 2021 at 07:12:36AM +0000, Wang, Wei W wrote:
>Hi,
>
>We plan to add a new vsock transport based on hypercall (e.g. vmcall on Intel CPUs).
>It transports AF_VSOCK packets between the guest and host, which is similar to
>virtio-vsock, vmci-vsock and hyperv-vsock.
>
>Compared to the above listed vsock transports which are designed for high performance,
>the main advantages of hypercall-vsock are:
>
>1)       It is VMM agnostic. For example, one guest working on hypercall-vsock can run on
>
>either KVM, Hyperv, or VMware.
>
>2)       It is simpler. It doesn't rely on any complex bus enumeration
>
>(e.g. virtio-pci based vsock device may need the whole implementation of PCI).
>
>An example usage is the communication between MigTD and host (Page 8 at
>https://static.sched.com/hosted_files/kvmforum2021/ef/TDX%20Live%20Migration_Wei%20Wang.pdf).
>MigTD communicates to host to assist the migration of the target (user) 
>TD.
>MigTD is part of the TCB, so its implementation is expected to be as simple as possible
>(e.g. bare mental implementation without OS, no PCI driver support).

Adding Andra and Sergio, because IIRC Firecracker and libkrun emulates 
virtio-vsock with virtio-mmio so the implementation should be simple and 
also not directly tied to a specific VMM.

Maybe this fit for your use case too, in this way we don't have to 
maintain another driver.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
