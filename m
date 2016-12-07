From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
	fast (de)inflating & fast live migration
Date: Wed, 7 Dec 2016 19:58:50 +0100
Message-ID: <20161207185850.GF28786__16750.0576972545$1481137141$gmane$org@redhat.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
	<0b18c636-ee67-cbb4-1ba3-81a06150db76@redhat.com>
	<0b83db29-ebad-2a70-8d61-756d33e33a48@intel.com>
	<2171e091-46ee-decd-7348-772555d3a5e3@redhat.com>
	<d3ff453c-56fa-19de-317c-1c82456f2831@intel.com>
	<20161207183817.GE28786@redhat.com>
	<3954fe69-15ac-43eb-e14b-e2bfe976be33@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3954fe69-15ac-43eb-e14b-e2bfe976be33@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: "mhocko@suse.com" <mhocko@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "Li, Liang Z" <liang.z.li@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 07, 2016 at 10:44:31AM -0800, Dave Hansen wrote:
> On 12/07/2016 10:38 AM, Andrea Arcangeli wrote:
> >> > and leaves room for the bitmap size to be encoded as well, if we decide
> >> > we need a bitmap in the future.
> > How would a bitmap ever be useful with very large page-order?
> 
> Please, guys.  Read the patches.  *Please*.

I did read the code but you didn't answer my question.

Why should a feature exist in the code that will never be useful. Why
do you think we could ever decide we'll need the bitmap in the future
for high order pages?

> The current code doesn't even _use_ a bitmap.

It's not using it right now, my question is exactly when it will ever
use it?

Leaving the bitmap only for order 0 allocations when you already wiped
all high pages orders from the buddy, doesn't seem very good idea
overall as the chance you got order 0 pages with close physical
address doesn't seem very high. It would be high if the loop that eat
into every possible higher order didn't run first, but such loop just
run and already wiped everything.

Also note, we need to call compaction very aggressive before falling
back from order 9 down to order 8. Ideally we should never use the
page_shift = PAGE_SHIFT case at all! Which leaves the bitmap as best
as an optimization for something that is suboptimal case already. If
the bitmap starts to payoff it means the admin did a mistake and
shrunk the guest too much.
