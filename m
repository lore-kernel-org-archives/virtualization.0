From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 04/15] ia64/pv_ops: introduce pv_info which describes some
	random info.
Date: Tue, 22 Apr 2008 20:02:14 +0900
Message-ID: <20080422110214.GI28863%yamahata__14357.0831082345$1208862311$gmane$org@valinux.co.jp>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<12077165491881-git-send-email-yamahata@valinux.co.jp>
	<yq04p9ul05i.fsf@jaguar.mkp.net>
	<20080422100219.GG28863%yamahata@valinux.co.jp>
	<480DBFD2.9060600@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <480DBFD2.9060600@sgi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jes Sorensen <jes@sgi.com>
Cc: eddie.dong@intel.com, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 22, 2008 at 12:37:06PM +0200, Jes Sorensen wrote:
> >- pv_ops covers some performance critical part (e.g. ia64 intrinsics)
> >  so that in the future they should be optimized with binary patch like 
> >  x86.
> >  We had the experimental patch to do that, but they are dropped for
> >  the merge. It reduced patch size greatly.
> >  After merging the first patch series, we're planning to optimize
> >  pv_ops with binary patch.
> >  The optimization with binary patch is out of the machine vector scope.
> 
> Rather than making these binary patches, why not make them fast syscalls
> and using a vdso page. Some of the priviledged instructions are simply
> reads and we could have that information in a read-only data page, so
> there is no need to do a context switch at all. Others could benefit
> from a fast system call that doesn't do a full context switch.
> 
> It would be nice if we could come up with a generic implementation for
> such a vdso style interface that could be shared between xen/kvm/lguest.

Yes, the above is possible.
But what if native case? Probably the calling stub code should be
binary patched to eliminate the calling overhead completely.
Anyway binary patch doesn't prevent from implementing the above your proposal.
With binary patch, we can implement vdso page infrastructure in future.


> >- The current pv_ops implements only one for only domU, but in future
> >  pv_ops will support dom0. It means dom0 linux would run with
> >  the underlying machine vector + pv_ops, i.e.
> >  {dig, hpzx1, hpzx1_swiotlb, ...} machine vector + xen pv_ops
> >
> >Probably some hooks of pv_ops could be replaced with
> >enhancing machine vector. But from the above separating pv_ops from
> >machine vector looks reasonable.
> 
> Would it make sense to make the pv_ops pointer part of the machine
> vector?

I doubt it because it introduces just one more indirection
pv_ops->ops => machine_vector->pv_ops ->ops.
But it can be done if you like..

-- 
yamahata
