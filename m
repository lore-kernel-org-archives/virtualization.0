Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDA3EB64DD
	for <virtualization@archiver.kernel.org>; Tue, 18 Jul 2023 15:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29B7E60BC2;
	Tue, 18 Jul 2023 15:56:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29B7E60BC2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bYsTsBY1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-tYRg-sQxUS; Tue, 18 Jul 2023 15:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AFF8E60B5D;
	Tue, 18 Jul 2023 15:56:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFF8E60B5D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76310C0071;
	Tue, 18 Jul 2023 15:56:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 623FBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 15:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A7B781EF7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 15:56:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A7B781EF7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=bYsTsBY1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7lLSZSIrkKJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 15:56:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50AEA81ED4
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 50AEA81ED4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 15:56:41 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-403b6b7c0f7so42262731cf.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1689695800; x=1692287800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tjh+qVHNBsaCt+fpZytXbv4JtN2Kf+QfiKBiC+OQp3c=;
 b=bYsTsBY1ioUL9k8drjTPCTw/fEJ0EAlGX5g4owJLPMPxN2CHLKUwbHRdsGU8yNpkgq
 tSJhCUQojCe7iZMsDT/aY34J1oz2QHRzCjLM+KqEBEo9M8BD2KOp45IRPvgTMkckJ6dq
 H9fFQEgiHBZaevHiGZSqEfXqcoEtLjezHUCteBqtpUndGthYRfcrzEkhL4CGHaIFAcmx
 6wdKboUdDaPeOVdQT0aOEr8C1+gySsRWrc1UqrjcLLXuhZDet2FHUgbuPzKGfDMScL/V
 K78x7SFpD7MaWzPqAIp0HWYQyARw7uG7tneLlNjtBlR/Fv5UIeG6Vm/K9G6rR6HJEl7q
 8oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689695800; x=1692287800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tjh+qVHNBsaCt+fpZytXbv4JtN2Kf+QfiKBiC+OQp3c=;
 b=VKdfnN7VwmuUFOFBtjoVeXrTdde1nhjOmVABvoPsySAhQh6dKt2a1eFfTD7STEFgsR
 R77RQGUeZ532zklb3tHkovEZ72Q+UrIFYDf5s9aOx7EQkSt1njqoLhTHlcUpg3cXGEj3
 nFpqH2KVepPHjXJSCx9tN7bBjOFQy0X+enl1unJQFrj5bL6+LEZcyarhFiYaXi0vFkTe
 daFQcHpazaKHzoo1abRKtYu/HrXHDCy28IS15U5Yy9T96h+mecPRyXNsf0H3RRVOOX2r
 WEN2PcrTRsRzgvvIq+2BJQ2iM4P/ng07mNRddmtL6iZ9C5eeIg7CI8SAyLKbpL3Yjl46
 3fMg==
X-Gm-Message-State: ABy/qLYCE2DvAxlbKORX/9SwmdzqcxiHOtRciJF+EaR5ekbHvkVFPTAt
 z+doxckCkPPYvzrS3pgOs9ZBWA==
X-Google-Smtp-Source: APBJJlFA9677r6PhZxjwKlQ1fKWxhiNMVqP6N1YqyjTADbRS7wwnXs7xld1btAoYMOwt7mM3Vw+c9w==
X-Received: by 2002:ac8:7dd0:0:b0:403:a814:ef4d with SMTP id
 c16-20020ac87dd0000000b00403a814ef4dmr21293071qte.49.1689695800050; 
 Tue, 18 Jul 2023 08:56:40 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26]) by smtp.gmail.com with ESMTPSA id
 s21-20020ac87595000000b003e635f80e72sm727847qtq.48.2023.07.18.08.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 08:56:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qLn42-002YJT-5I;
 Tue, 18 Jul 2023 12:56:38 -0300
Date: Tue, 18 Jul 2023 12:56:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] eventfd: simplify signal helpers
Message-ID: <ZLa2NmwexoxPkS9a@ziepe.ca>
References: <20230630155936.3015595-1-jaz@semihalf.com>
 <20230714-gauner-unsolidarisch-fc51f96c61e8@brauner>
 <CAH76GKPF4BjJLrzLBW8k12ATaAGADeMYc2NQ9+j0KgRa0pomUw@mail.gmail.com>
 <20230717130831.0f18381a.alex.williamson@redhat.com>
 <ZLW8wEzkhBxd0O0L@ziepe.ca>
 <20230717165203.4ee6b1e6.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230717165203.4ee6b1e6.alex.williamson@redhat.com>
Cc: linux-aio@kvack.org, Muchun Song <muchun.song@linux.dev>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paul Durrant <paul@xen.org>, Tom Rix <trix@redhat.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, dri-devel@lists.freedesktop.org,
 Michal Hocko <mhocko@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 linux-mm@kvack.org, Kirti Wankhede <kwankhede@nvidia.com>,
 netdev@vger.kernel.org, Vineeth Vijayan <vneethv@linux.ibm.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Borislav Petkov <bp@alien8.de>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Fei Li <fei1.li@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marcin Wojtas <mw@semihalf.com>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>,
 Harald Freudenberger <freude@linux.ibm.com>, x86@kernel.org,
 Halil Pasic <pasic@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
 Zhi Wang <zhi.a.wang@intel.com>, Wu Hao <hao.wu@intel.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Dominik Behr <dbehr@chromium.org>,
 intel-gfx@lists.freedesktop.org, Sean Christopherson <seanjc@google.com>,
 Eric Auger <eric.auger@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shakeel Butt <shakeelb@google.com>, kvm@vger.kernel.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, cgroups@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, intel-gvt-dev@lists.freedesktop.org,
 io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, Grzegorz Jaszczyk <jaz@semihalf.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-usb@vger.kernel.org,
 Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, Pavel Begunkov <asml.silence@gmail.com>
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

On Mon, Jul 17, 2023 at 04:52:03PM -0600, Alex Williamson wrote:
> On Mon, 17 Jul 2023 19:12:16 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Mon, Jul 17, 2023 at 01:08:31PM -0600, Alex Williamson wrote:
> > 
> > > What would that mechanism be?  We've been iterating on getting the
> > > serialization and buffering correct, but I don't know of another means
> > > that combines the notification with a value, so we'd likely end up with
> > > an eventfd only for notification and a separate ring buffer for
> > > notification values.  
> > 
> > All FDs do this. You just have to make a FD with custom
> > file_operations that does what this wants. The uAPI shouldn't be able
> > to tell if the FD is backing it with an eventfd or otherwise. Have the
> > kernel return the FD instead of accepting it. Follow the basic design
> > of eg mlx5vf_save_fops
> 
> Sure, userspace could poll on any fd and read a value from it, but at
> that point we're essentially duplicating a lot of what eventfd provides
> for a minor(?) semantic difference over how the counter value is
> interpreted.  Using an actual eventfd allows the ACPI notification to
> work as just another interrupt index within the existing vfio IRQ
> uAPI.

Yes, duplicated, sort of, whatever the "ack" is to allow pushing a new
value can be revised to run as part of the read.

But I don't really view it as a minor difference. eventfd is a
counter. It should not be abused otherwise, even if it can be made to
work.

It really isn't an IRQ if it is pushing an async message w/data.

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
