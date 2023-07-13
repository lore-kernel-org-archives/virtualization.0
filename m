Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4829EC001DE
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 17:11:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD6E34178B;
	Thu, 13 Jul 2023 17:11:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD6E34178B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrTg0Gxe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DsJb1qIByczB; Thu, 13 Jul 2023 17:11:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F8E741783;
	Thu, 13 Jul 2023 17:11:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F8E741783
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15CCAC0071;
	Thu, 13 Jul 2023 17:11:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 910CBC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 17:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57E444032A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 17:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57E444032A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GIknmZXg-mo5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 17:11:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F00F74179D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F00F74179D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689268266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UPgPFBGvQHuZjwqO9ik4oPicS3MZwipCdBIqa3Pous=;
 b=OrTg0Gxep8b1FgfWpj+u322nyJltbbewHDrG0FvwJ4pg/O18xeMmBh6/wJ1AssXXLzXbnK
 XiTGgZSylvIhDgAhgvuqezQaJRHIGtGV1Jfqlniar1piTq8hMQEaWeNzDkRYdsD/0Oa+an
 7dopCH3esn84pQzpXjfRkvhv55LhNNI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-4V8WEtSMMFyPe-esFMXUHg-1; Thu, 13 Jul 2023 13:10:59 -0400
X-MC-Unique: 4V8WEtSMMFyPe-esFMXUHg-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-345c1f3dcc8so4533625ab.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 10:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689268257; x=1691860257;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+UPgPFBGvQHuZjwqO9ik4oPicS3MZwipCdBIqa3Pous=;
 b=evWkebXF1d8yq/gWMNz3qu/EIoi8rQ+M8wMEx/5kxpJFqLXmfYTE8MstBnkic5EZWX
 CcfXWoUpys2F39a9OlRK9mlGT19DIAVbW2Sqk/n2SNllWjVn2PhS5wpsFGTYiU4JHy99
 OS1YcO2BWrj9THSoPH6qejAYrv8e97Mymjwwg8V9med9XDVLV+YayBxIY28/n6fzhELJ
 L2+4RsOMriOWuAEXHah6AQ3rn6wOUp5LW0+z+0M5SNKFYj1EVLJgO6lZgYPL/9N8Ar9T
 AdvbIRVM2vILVBOPy5sCDyhKF5U/mVlMDxz8ZiZmgVz41mmuJ6l2dKBPxsc4FfodI4tp
 p38g==
X-Gm-Message-State: ABy/qLY7B6PJ+X/h9yn1YZUwuhrF3MEUuL11VZnR0eaRQhIrAw7S5WTf
 O0kbZ1f09+yMpYiOJaaehpx3DTEb/+7BsbAI8UWJqI0PQxj/tFxH+8+caRw5by8PbL3ytoUfoO/
 UoB2O/lLy8KOgzg4wWe2D5rcT8toHOb5gkIe06gHVVg==
X-Received: by 2002:a92:c105:0:b0:345:6ffa:63c5 with SMTP id
 p5-20020a92c105000000b003456ffa63c5mr1980599ile.32.1689268257121; 
 Thu, 13 Jul 2023 10:10:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYzBd2cy5+vbqrqBW5hcL0Nlt03XvoKU7EVc2Oqt6qt/39DAJLG7+eJes4a+aimrEVLy/slQ==
X-Received: by 2002:a92:c105:0:b0:345:6ffa:63c5 with SMTP id
 p5-20020a92c105000000b003456ffa63c5mr1980544ile.32.1689268256865; 
 Thu, 13 Jul 2023 10:10:56 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 el20-20020a0566384d9400b0042b61a5087csm1948085jab.132.2023.07.13.10.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 10:10:56 -0700 (PDT)
Date: Thu, 13 Jul 2023 11:10:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/2] eventfd: simplify signal helpers
Message-ID: <20230713111054.75cdf2b8.alex.williamson@redhat.com>
In-Reply-To: <20230713-vfs-eventfd-signal-v1-0-7fda6c5d212b@kernel.org>
References: <20230713-vfs-eventfd-signal-v1-0-7fda6c5d212b@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-aio@kvack.org, Muchun Song <muchun.song@linux.dev>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paul Durrant <paul@xen.org>, Tom Rix <trix@redhat.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-mm@kvack.org,
 Kirti Wankhede <kwankhede@nvidia.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Borislav Petkov <bp@alien8.de>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Fei Li <fei1.li@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Arnd Bergmann <arnd@arndb.de>,
 Leon Romanovsky <leon@kernel.org>, jaz@semihalf.com,
 linux-rdma@vger.kernel.org, x86@kernel.org, Halil Pasic <pasic@linux.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
 Zhi Wang <zhi.a.wang@intel.com>, Wu Hao <hao.wu@intel.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Sean Christopherson <seanjc@google.com>, Eric Auger <eric.auger@redhat.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Harald Freudenberger <freude@linux.ibm.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, cgroups@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, intel-gvt-dev@lists.freedesktop.org,
 io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, netdev@vger.kernel.org,
 Oded Gabbay <ogabbay@kernel.org>, linux-usb@vger.kernel.org,
 Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Benjamin LaHaise <bcrl@kvack.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org,
 Shakeel Butt <shakeelb@google.com>, David Woodhouse <dwmw2@infradead.org>,
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

On Thu, 13 Jul 2023 12:05:36 +0200
Christian Brauner <brauner@kernel.org> wrote:

> Hey everyone,
> 
> This simplifies the eventfd_signal() and eventfd_signal_mask() helpers
> by removing the count argument which is effectively unused.

We have a patch under review which does in fact make use of the
signaling value:

https://lore.kernel.org/all/20230630155936.3015595-1-jaz@semihalf.com/

Thanks,
Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
