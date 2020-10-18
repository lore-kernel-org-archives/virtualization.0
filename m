Return-Path: <SRS0=CB8P=DZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8548BC433DF
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 15:52:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C2321655
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 15:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXQNN2mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C2321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DFB687721;
	Sun, 18 Oct 2020 15:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ls+96l9LaBS; Sun, 18 Oct 2020 15:52:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6352387720;
	Sun, 18 Oct 2020 15:52:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 443F8C0052;
	Sun, 18 Oct 2020 15:52:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9100C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C68192107A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2I4afkJxG-YP
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:52:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 3AE092034D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603036334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=98NF5I6kW3PEIcXhLOKqmMDjTo2gmlFaETZTllsyzbc=;
 b=WXQNN2mPVRWDdzvXANuUB5qk8zN4Fwk9gTI+C52tU7MXmfJoZctS8tlJA20Mw0wtPZym3T
 iVk8eXGSykoca///imoJdRNpxmIjU6Nmnu00lM4nTvWaTXSFZh8971UA8+84XsOf8CpwpS
 Xui6hWUb+GCLXAji++FjeWGRlBbnkME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-BrjO9FcSM_mUyI8CB1F-sg-1; Sun, 18 Oct 2020 11:52:13 -0400
X-MC-Unique: BrjO9FcSM_mUyI8CB1F-sg-1
Received: by mail-wr1-f69.google.com with SMTP id k14so6271823wrd.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 08:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=98NF5I6kW3PEIcXhLOKqmMDjTo2gmlFaETZTllsyzbc=;
 b=d8EbFEsHg7/jxABbiFKjQXjPudFDB6mEWsbxZq7JqGvOUhbblA5qTcif+JKGFl0AxK
 q4ZWe/FwOQNiL5uLZU3GEiJUg0tRpnY9yeCyfvWqhpv4NY6BMx1qdMv4nDY2Y8awpmFd
 1p/RtNX1rd+3ucG3XpMe0PvKNl6ce7CFkgatGNbRkpzJ5ggcyekHDr/LYKKpL5f5Lg9Z
 g+JJBlI8+p4lhMQw/YqBTCEBm9hGatK3YiUysBYnzd3z49b0w9VPrOEHaecuPWjdbimi
 yu8nDwj8IrxP2F0NkqQnPUkueaJaqfsqb1T3K+iweCNjm55UwKWv1JUb5GIdDQRFs3yX
 2kMQ==
X-Gm-Message-State: AOAM530pHINQCL9L3vk/HbtCHE/bWYYTEwKDIpi/jxtt7EPoDipNlpKg
 pRsXSXR9joKukLod7AxX+3cULDjfMus3qUJt2botgCGwfo0Rjld+OoFjLrvz27geb+MKD3IimOO
 Z/J1McknMAiPXcCoG0C3oY7DR5Fnqi3ytyKx319Z7OA==
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr14633147wrw.138.1603036332033; 
 Sun, 18 Oct 2020 08:52:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDk0m1PaAgQbG5uGn8JDuTOpRDE6IZs81q1mD08uCdggM28IdBmZmD2H7MRJNdhDzXVGo/nQ==
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr14633124wrw.138.1603036331866; 
 Sun, 18 Oct 2020 08:52:11 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id i8sm12624962wmd.14.2020.10.18.08.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 08:52:11 -0700 (PDT)
Date: Sun, 18 Oct 2020 11:52:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201018114625-mutt-send-email-mst@kernel.org>
References: <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Colm MacCarthaigh <colmmacc@amazon.com>,
 Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, "Singh, Balbir" <sblbir@amazon.com>,
 bonzini@gnu.org, "Graf \(AWS\), Alexander" <graf@amazon.de>,
 Jann Horn <jannh@google.com>, oridgar@gmail.com, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, Willy Tarreau <w@1wt.eu>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Oct 17, 2020 at 03:24:08PM +0200, Jason A. Donenfeld wrote:
> 4c. The guest kernel maintains an array of physical addresses that are
> MADV_WIPEONFORK. The hypervisor knows about this array and its
> location through whatever protocol, and before resuming a
> moved/snapshotted/duplicated VM, it takes the responsibility for
> memzeroing this memory. The huge pro here would be that this
> eliminates all races, and reduces complexity quite a bit, because the
> hypervisor can perfectly synchronize its bringup (and SMP bringup)
> with this, and it can even optimize things like on-disk memory
> snapshots to simply not write out those pages to disk.
> 
> A 4c-like approach seems like it'd be a lot of bang for the buck -- we
> reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
> userspace API to deal with, and it'd be race free, and eliminate a lot
> of kernel complexity.

Clearly this has a chance to break applications, right?
If there's an app that uses this as a non-system-calls way
to find out whether there was a fork, it will break
when wipe triggers without a fork ...
For example, imagine:

MADV_WIPEONFORK
copy secret data to MADV_DONTFORK
fork


used to work, with this change it gets 0s instead of the secret data.


I am also not sure it's wise to expose each guest process
to the hypervisor like this. E.g. each process needs a
guest physical address of its own then. This is a finite resource.


The mmap interface proposed here is somewhat baroque, but it is
certainly simple to implement ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
