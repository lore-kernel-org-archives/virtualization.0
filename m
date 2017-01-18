From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v6 kernel 0/5] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Wed, 18 Jan 2017 13:29:59 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C356F1B__33066.8158516803$1484746239$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<2a32f616-25a8-ba5a-f74c-d619fc8ab333@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2a32f616-25a8-ba5a-f74c-d619fc8ab333@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> Am 21.12.2016 um 07:52 schrieb Liang Li:
> > This patch set contains two parts of changes to the virtio-balloon.
> >
> > One is the change for speeding up the inflating & deflating process,
> > the main idea of this optimization is to use {pfn|length} to present
> > the page information instead of the PFNs, to reduce the overhead of
> > virtio data transmission, address translation and madvise(). This can
> > help to improve the performance by about 85%.
> >
> > Another change is for speeding up live migration. By skipping process
> > guest's unused pages in the first round of data copy, to reduce
> > needless data processing, this can help to save quite a lot of CPU
> > cycles and network bandwidth. We put guest's unused page information
> > in a {pfn|length} array and send it to host with the virt queue of
> > virtio-balloon. For an idle guest with 8GB RAM, this can help to
> > shorten the total live migration time from 2Sec to about 500ms in
> > 10Gbps network environment. For an guest with quite a lot of page
> > cache and with little unused pages, it's possible to let the guest
> > drop it's page cache before live migration, this case can benefit from this
> new feature too.
> 
> I agree that both changes make sense (although the second change just
> smells very racy, as you also pointed out in the patch description), however I
> am not sure if virtio-balloon is really the right place for the latter change.
> 
> virtio-balloon is all about ballooning, nothing else. What you're doing is using
> it as a way to communicate balloon-unrelated data from/to the hypervisor.
> Yes, it is also about guest memory, but completely unrelated to the purpose
> of the balloon device.
> 
> Maybe using virtio-balloon for this purpose is okay - I have mixed feelings
> (especially as I can't tell where else this could go). I would like to get a second
> opinion on this.
> 

We have ever discussed the implementation for a long time, making use the current
virtio balloon seems better than the other solutions and is recommended by Michael.

Thanks!
Liang
> --
> 
> David
