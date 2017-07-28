From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Sat, 29 Jul 2017 02:01:35 +0300
Message-ID: <20170729020006-mutt-send-email-mst__2921.40376191146$1501282913$gmane$org@kernel.org>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
	<597AF4EF.4020705@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <597AF4EF.4020705@intel.com>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 28, 2017 at 04:25:19PM +0800, Wei Wang wrote:
> On 07/12/2017 08:40 PM, Wei Wang wrote:
> > Add a new feature, VIRTIO_BALLOON_F_SG, which enables to
> > transfer a chunk of ballooned (i.e. inflated/deflated) pages using
> > scatter-gather lists to the host.
> > 
> > The implementation of the previous virtio-balloon is not very
> > efficient, because the balloon pages are transferred to the
> > host one by one. Here is the breakdown of the time in percentage
> > spent on each step of the balloon inflating process (inflating
> > 7GB of an 8GB idle guest).
> > 
> > 1) allocating pages (6.5%)
> > 2) sending PFNs to host (68.3%)
> > 3) address translation (6.1%)
> > 4) madvise (19%)
> > 
> > It takes about 4126ms for the inflating process to complete.
> > The above profiling shows that the bottlenecks are stage 2)
> > and stage 4).
> > 
> > This patch optimizes step 2) by transferring pages to the host in
> > sgs. An sg describes a chunk of guest physically continuous pages.
> > With this mechanism, step 4) can also be optimized by doing address
> > translation and madvise() in chunks rather than page by page.
> > 
> > With this new feature, the above ballooning process takes ~491ms
> > resulting in an improvement of ~88%.
> > 
> 
> 
> I found a recent mm patch, bb01b64cfab7c22f3848cb73dc0c2b46b8d38499
> , zeros all the ballooned pages, which is very time consuming.
> 
> Tests show that the time to balloon 7G pages is increased from ~491 ms to
> 2.8 seconds with the above patch.

Sounds like it should be reverted. Post a revert pls and
we'll discuss.

> How about moving the zero operation to the hypervisor? In this way, we
> will have a much faster balloon process.
> 
> 
> Best,
> Wei

Or in other words hypervisors should not be stupid and
should not try to run ksm on DONTNEED pages.

-- 
MST
