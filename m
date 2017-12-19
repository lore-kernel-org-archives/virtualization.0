From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v20 1/7] xbitmap: Introduce xbitmap
Date: Tue, 19 Dec 2017 16:58:10 +0100
Message-ID: <CAOFm3uHJF1X93iALES6njXrkpsk5bSsuXqcKQMWP4HGT0S8qeg__41820.263877935$1513699073$gmane$org@mail.gmail.com>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<1513685879-21823-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1513685879-21823-2-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mawilcox@microsoft.com
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@i-love.sakura.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, willy@infradead.org, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, quan.xu0@gmail.com, LKML <linux-kernel@vger.kernel.org>, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

Matthew,

On Tue, Dec 19, 2017 at 1:17 PM, Wei Wang <wei.w.wang@intel.com> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> The eXtensible Bitmap is a sparse bitmap representation which is
> efficient for set bits which tend to cluster.  It supports up to
> 'unsigned long' worth of bits, and this commit adds the bare bones --
> xb_set_bit(), xb_clear_bit() and xb_test_bit().

<snip>

> --- /dev/null
> +++ b/include/linux/xbitmap.h
> @@ -0,0 +1,49 @@
> +/*
> + * eXtensible Bitmaps
> + * Copyright (c) 2017 Microsoft Corporation <mawilcox@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * eXtensible Bitmaps provide an unlimited-size sparse bitmap facility.
> + * All bits are initially zero.
> + */

Would you mind using the new SPDX tags documented in Thomas patch set
[1] rather than this fine but longer legalese?

And if you could spread the word to others in your team this would be very nice.

Thank you!

[1] https://lkml.org/lkml/2017/12/4/934

-- 
Cordially
Philippe Ombredanne
