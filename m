From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [PATCH v4 1/1] crypto: add virtio-crypto driver
Date: Thu, 1 Dec 2016 12:33:17 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA14FC5D__49210.8783605092$1480595738$gmane$org@DGGEMA505-MBX.china.huawei.com>
References: <1480423694-41736-1-git-send-email-arei.gonglei@huawei.com>
	<1480423694-41736-2-git-send-email-arei.gonglei@huawei.com>
	<20161130110932.GC2497@stefanha-x1.localdomain>
	<33183CC9F5247A488A2544077AF19020DA14EC02@DGGEMA505-MBX.china.huawei.com>
	<20161201115327.GB10441@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161201115327.GB10441@stefanha-x1.localdomain>
Content-Language: zh-CN
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>, Andy Whitcroft <apw@shadowen.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hanweidong (Randy)" <hanweidong@huawei.com>, Luonengjun <luonengjun@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "salvatore.benedetto@intel.com" <salvatore.benedetto@intel.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "Wubin (H)" <wu.wubin@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org

> 
> On Thu, Dec 01, 2016 at 02:27:19AM +0000, Gonglei (Arei) wrote:
> > > On Tue, Nov 29, 2016 at 08:48:14PM +0800, Gonglei wrote:
> > > > diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c
> > > b/drivers/crypto/virtio/virtio_crypto_algs.c
> > > > new file mode 100644
> > > > index 0000000..08b077f
> > > > --- /dev/null
> > > > +++ b/drivers/crypto/virtio/virtio_crypto_algs.c
> > > > @@ -0,0 +1,518 @@
> > > > + /* Algorithms supported by virtio crypto device
> > > > +  *
> > > > +  * Authors: Gonglei <arei.gonglei@huawei.com>
> > > > +  *
> > > > +  * Copyright 2016 HUAWEI TECHNOLOGIES CO., LTD.
> > > > +  *
> > > > +  * This program is free software; you can redistribute it and/or modify
> > > > +  * it under the terms of the GNU General Public License as published by
> > > > +  * the Free Software Foundation; either version 2 of the License, or
> > > > +  * (at your option) any later version.
> > > > +  *
> > > > +  * This program is distributed in the hope that it will be useful,
> > > > +  * but WITHOUT ANY WARRANTY; without even the implied warranty
> of
> > > > +  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> the
> > > > +  * GNU General Public License for more details.
> > > > +  *
> > > > +  * You should have received a copy of the GNU General Public License
> > > > +  * along with this program; if not, see
> <http://www.gnu.org/licenses/>.
> > > > +  */
> > > > +
> > > > +#include <linux/scatterlist.h>
> > > > +#include <crypto/algapi.h>
> > > > +#include <linux/err.h>
> > > > +#include <crypto/scatterwalk.h>
> > > > +#include <linux/atomic.h>
> > > > +
> > > > +#include <uapi/linux/virtio_crypto.h>
> > > > +#include "virtio_crypto_common.h"
> > > > +
> > > > +static DEFINE_MUTEX(algs_lock);
> > >
> > > Did you run checkpatch.pl?  I think it encourages you to document what
> > > the lock protects.
> > >
> > Sure. Basically I run checkpatch.py each time. :)
> >
> > # ./scripts/checkpatch.pl 0001-crypto-add-virtio-crypto-driver.patch
> > total: 0 errors, 0 warnings, 1873 lines checked
> >
> > 0001-crypto-add-virtio-crypto-driver.patch has no obvious style problems and
> is ready for submission.
> 
> Looks like a bug in checkpatch.pl:
> 
> # check for spinlock_t definitions without a comment.
> if ($line =~ /^.\s*(struct\s+mutex|spinlock_t)\s+\S+;/ ||
>     $line =~ /^.\s*(DEFINE_MUTEX)\s*\(/) {
>         my $which = $1;
>         if (!ctx_has_comment($first_line, $linenr)) {
>                 CHK("UNCOMMENTED_DEFINITION",
>                     "$1 definition without comment\n" . $herecurr);
>         }
> }
> 
> Since your mutex definition has the 'static' keyword in front of it
> checkpatch.pl misses it!
> 
Anyway I added the comments. Thanks :)


Regards,
-Gonglei

> Andy: Is this checkpatch.pl behavior intentional?
> 
> Stefan
