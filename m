From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Fri, 15 Dec 2017 11:22:03 -0800
Message-ID: <20171215192203.GC27160__47905.3961848423$1513365783$gmane$org@bombadil.infradead.org>
References: <5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
	<20171215184915.GB27160@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171215184915.GB27160@bombadil.infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 15, 2017 at 10:49:15AM -0800, Matthew Wilcox wrote:
> Here's the API I'm looking at right now.  The user need take no lock;
> the locking (spinlock) is handled internally to the implementation.

I looked at the API some more and found some flaws:
 - how does xbit_alloc communicate back which bit it allocated?
 - What if xbit_find_set() is called on a completely empty array with
   a range of 0, ULONG_MAX -- there's no invalid number to return.
 - xbit_clear() can't return an error.  Neither can xbit_zero().
 - Need to add __must_check to various return values to discourage sloppy
   programming

So I modify the proposed API we compete with thusly:

bool xbit_test(struct xbitmap *, unsigned long bit);
int __must_check xbit_set(struct xbitmap *, unsigned long bit, gfp_t);
void xbit_clear(struct xbitmap *, unsigned long bit);
int __must_check xbit_alloc(struct xbitmap *, unsigned long *bit, gfp_t);

int __must_check xbit_fill(struct xbitmap *, unsigned long start,
                        unsigned long nbits, gfp_t);
void xbit_zero(struct xbitmap *, unsigned long start, unsigned long nbits);
int __must_check xbit_alloc_range(struct xbitmap *, unsigned long *bit,
                        unsigned long nbits, gfp_t);

bool xbit_find_clear(struct xbitmap *, unsigned long *start, unsigned long max);
bool xbit_find_set(struct xbitmap *, unsigned long *start, unsigned long max);

(I'm a little sceptical about the API accepting 'max' for the find
functions and 'nbits' in the fill/zero/alloc_range functions, but I think
that matches how people want to use it, and it matches how bitmap.h works)
