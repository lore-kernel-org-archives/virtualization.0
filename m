From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v25 1/2 RESEND] mm: support reporting free page blocks
Date: Thu, 25 Jan 2018 14:41:24 -0800
Message-ID: <20180125144124.7e9f6e2156b1b940b07aecfc__36709.868690423$1516919975$gmane$org@linux-foundation.org>
References: <1516873107-34950-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1516873107-34950-1-git-send-email-wei.w.wang@intel.com>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, mst@redhat.com, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, pbonzini@redhat.com, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 25 Jan 2018 17:38:27 +0800 Wei Wang <wei.w.wang@intel.com> wrote:

> This patch adds support to walk through the free page blocks in the
> system and report them via a callback function. Some page blocks may
> leave the free list after zone->lock is released, so it is the caller's
> responsibility to either detect or prevent the use of such pages.
> 
> One use example of this patch is to accelerate live migration by skipping
> the transfer of free pages reported from the guest. A popular method used
> by the hypervisor to track which part of memory is written during live
> migration is to write-protect all the guest memory. So, those pages that
> are reported as free pages but are written after the report function
> returns will be captured by the hypervisor, and they will be added to the
> next round of memory transfer.

It would be useful if we had some quantitative testing results, so we
can see the real-world benefits from this change?
