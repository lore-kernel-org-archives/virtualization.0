From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v19 1/7] xbitmap: Introduce xbitmap
Date: Tue, 12 Dec 2017 13:53:53 +0100
Message-ID: <CAOFm3uH29ZQSo92c_JXcffsonwh3PscdRe1p6vZCwinfauiYBw__43053.6415814005$1513195179$gmane$org@mail.gmail.com>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
	<1513079759-14169-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1513079759-14169-2-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>, mawilcox@microsoft.com
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@i-love.sakura.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, willy@infradead.org, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, LKML <linux-kernel@vger.kernel.org>, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

Matthew, Wei,

On Tue, Dec 12, 2017 at 12:55 PM, Wei Wang <wei.w.wang@intel.com> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> The eXtensible Bitmap is a sparse bitmap representation which is
> efficient for set bits which tend to cluster.  It supports up to
> 'unsigned long' worth of bits, and this commit adds the bare bones --
> xb_set_bit(), xb_clear_bit() and xb_test_bit().
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[...]

> --- /dev/null
> +++ b/include/linux/xbitmap.h
> @@ -0,0 +1,52 @@
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

Have you considered using the new SPDX ids here instead? eg. this
would come out as a top line this way:

> +/* SPDX-License-Identifer: GPL-2.0+ */

Overall you get less boilerplate comment and more code, so this is a
win-win for everyone. This would nicely remove the legalese
boilerplate with the same effect, unless you are a legalese lover of
course. See Thomas doc patches for extra details.... and while you are
it if you could spread the words in your team and use it for all past,
present and future contributions, that would be much appreciated.

And as a side benefit to me, it will help me save on paper and ink
ribbons supplies for my dot matrix line printer each time I print the
source code of the whole kernel. ;)

Thanks for your consideration there.
-- 
Cordially
Philippe Ombredanne
