From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 04/15] ia64/pv_ops: introduce pv_info which describes
	some random info.
Date: Tue, 22 Apr 2008 12:37:06 +0200
Message-ID: <480DBFD2.9060600__7541.84223847023$1208860832$gmane$org@sgi.com>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<12077165491881-git-send-email-yamahata@valinux.co.jp>
	<yq04p9ul05i.fsf@jaguar.mkp.net>
	<20080422100219.GG28863%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080422100219.GG28863%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: eddie.dong@intel.com, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata wrote:
> Our justification is as follows.
> The difference is its scope. pv_ops for virtualization and
> machine vector is for platform difference.
> 
> - pv_ops does cover the area which shouldn't belong to machine vector.
>   For example, ia64 intrinsics paravirtualization.
>   It shouldn't belong to the machine vector.
>   It must be initialized very early before platform detection.

Hi Isaku,

Ok this is a good point.

> - pv_ops covers some performance critical part (e.g. ia64 intrinsics)
>   so that in the future they should be optimized with binary patch like x86.
>   We had the experimental patch to do that, but they are dropped for
>   the merge. It reduced patch size greatly.
>   After merging the first patch series, we're planning to optimize
>   pv_ops with binary patch.
>   The optimization with binary patch is out of the machine vector scope.

Rather than making these binary patches, why not make them fast syscalls
and using a vdso page. Some of the priviledged instructions are simply
reads and we could have that information in a read-only data page, so
there is no need to do a context switch at all. Others could benefit
from a fast system call that doesn't do a full context switch.

It would be nice if we could come up with a generic implementation for
such a vdso style interface that could be shared between xen/kvm/lguest.


> - The current pv_ops implements only one for only domU, but in future
>   pv_ops will support dom0. It means dom0 linux would run with
>   the underlying machine vector + pv_ops, i.e.
>   {dig, hpzx1, hpzx1_swiotlb, ...} machine vector + xen pv_ops
> 
> Probably some hooks of pv_ops could be replaced with
> enhancing machine vector. But from the above separating pv_ops from
> machine vector looks reasonable.

Would it make sense to make the pv_ops pointer part of the machine
vector?

Cheers,
Jes
