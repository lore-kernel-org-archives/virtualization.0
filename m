From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v36 0/5] Virtio-balloon: support free page reporting
Date: Sun, 22 Jul 2018 11:11:59 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739702695__25360.1710698151$1532257804$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
	<20180720154922-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180720154922-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "riel@redhat.com" <riel@redhat.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "nilal@redhat.com" <nilal@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday, July 20, 2018 8:52 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 20, 2018 at 04:33:00PM +0800, Wei Wang wrote:
> > This patch series is separated from the previous "Virtio-balloon
> > Enhancement" series. The new feature,
> VIRTIO_BALLOON_F_FREE_PAGE_HINT,
> > implemented by this series enables the virtio-balloon driver to report
> > hints of guest free pages to the host. It can be used to accelerate
> > live migration of VMs. Here is an introduction of this usage:
> >
> > Live migration needs to transfer the VM's memory from the source
> > machine to the destination round by round. For the 1st round, all the
> > VM's memory is transferred. From the 2nd round, only the pieces of
> > memory that were written by the guest (after the 1st round) are
> > transferred. One method that is popularly used by the hypervisor to
> > track which part of memory is written is to write-protect all the guest
> memory.
> >
> > This feature enables the optimization by skipping the transfer of
> > guest free pages during VM live migration. It is not concerned that
> > the memory pages are used after they are given to the hypervisor as a
> > hint of the free pages, because they will be tracked by the hypervisor
> > and transferred in the subsequent round if they are used and written.
> >
> > * Tests
> > - Test Environment
> >     Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> >     Guest: 8G RAM, 4 vCPU
> >     Migration setup: migrate_set_speed 100G, migrate_set_downtime 2
> > second
> 
> Can we split out patches 1 and 2? They seem appropriate for this release ...

Sounds good to me. I'm not sure if there would be comments on the first 2 patches. If no, can you just take them here? Or you need me to repost them separately?

Best,
Wei
