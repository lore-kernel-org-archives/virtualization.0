From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Fri, 28 Jul 2017 16:25:19 +0800
Message-ID: <597AF4EF.4020705__18931.7300254062$1501230174$gmane$org@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, mhocko@kernel.org, willy@infradead.org
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, quan.xu@aliyun.com
List-Id: virtualization@lists.linuxfoundation.org

On 07/12/2017 08:40 PM, Wei Wang wrote:
> Add a new feature, VIRTIO_BALLOON_F_SG, which enables to
> transfer a chunk of ballooned (i.e. inflated/deflated) pages using
> scatter-gather lists to the host.
>
> The implementation of the previous virtio-balloon is not very
> efficient, because the balloon pages are transferred to the
> host one by one. Here is the breakdown of the time in percentage
> spent on each step of the balloon inflating process (inflating
> 7GB of an 8GB idle guest).
>
> 1) allocating pages (6.5%)
> 2) sending PFNs to host (68.3%)
> 3) address translation (6.1%)
> 4) madvise (19%)
>
> It takes about 4126ms for the inflating process to complete.
> The above profiling shows that the bottlenecks are stage 2)
> and stage 4).
>
> This patch optimizes step 2) by transferring pages to the host in
> sgs. An sg describes a chunk of guest physically continuous pages.
> With this mechanism, step 4) can also be optimized by doing address
> translation and madvise() in chunks rather than page by page.
>
> With this new feature, the above ballooning process takes ~491ms
> resulting in an improvement of ~88%.
>


I found a recent mm patch, bb01b64cfab7c22f3848cb73dc0c2b46b8d38499
, zeros all the ballooned pages, which is very time consuming.

Tests show that the time to balloon 7G pages is increased from ~491 ms to
2.8 seconds with the above patch.

How about moving the zero operation to the hypervisor? In this way, we
will have a much faster balloon process.


Best,
Wei
