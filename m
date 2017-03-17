From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH kernel v8 3/4] mm: add inerface to offer info about
	unused pages
Date: Fri, 17 Mar 2017 03:21:21 +0200
Message-ID: <20170317023556-mutt-send-email-mst__1678.35333054445$1489713698$gmane$org@kernel.org>
References: <1489648127-37282-1-git-send-email-wei.w.wang@intel.com>
	<1489648127-37282-4-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1489648127-37282-4-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 16, 2017 at 03:08:46PM +0800, Wei Wang wrote:
> +/*
> + * The record_unused_pages() function is used to record the system unused
> + * pages. The unused pages can be skipped to transfer during live migration.
> + * Though the unused pages are dynamically changing, dirty page logging
> + * mechanisms are able to capture the newly used pages though they were
> + * recorded as unused pages via this function.

You will keep confusing people as long as you keep using
this terminology which only makes sense in a very specific
use and a very specific implementation.

How does guest developer know this does the right thing wrt locking etc?
Look at hypervisor spec and try to figure it all out together?

So stop saying what caller should do, describe what does the *API* does.

You want something like this:

	Get a list of pages in the system that are unused at some point between
	record_unused_pages is called and before it returns, implying that any
	data that was present in these pages before record_unused_pages was
	called is safe to discard. Pages can be used immediately after
	this point and any data written after this point is not safe to discard,
	it is caller's responsibility to either prevent the use or
	detect such pages.

-- 
MST
