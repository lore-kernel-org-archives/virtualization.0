From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v7 kernel 5/5] This patch contains two parts:
Date: Mon, 6 Mar 2017 14:23:02 +0100
Message-ID: <d66a8e86-0ead-90fd-b943-f69449e78349__1377.22994336418$1488806600$gmane$org@redhat.com>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-6-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1488519630-89058-6-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Liang Li <liang.z.li@intel.com>, Dave Hansen <dave.hansen@intel.com>, Amit Shah <amit.shah@redhat.com>, Liang Li <liliang324@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

Am 03.03.2017 um 06:40 schrieb Wei Wang:
> From: Liang Li <liang.z.li@intel.com>

I'd prefer to split this into two parts then and to create proper subjects.

If I remember correctly, the general concept was accepted by most reviewers.

> 
> One is to add a new API to mm go get the unused page information.
> The virtio balloon driver will use this new API added to get the
> unused page info and send it to hypervisor(QEMU) to speed up live
> migration. During sending the bitmap, some the pages may be modified
> and are used by the guest, this inaccuracy can be corrected by the
> dirty page logging mechanism.
> 
> One is to add support the request for vm's unused page information,
> QEMU can make use of unused page information and the dirty page
> logging mechanism to skip the transportation of some of these unused
> pages, this is very helpful to reduce the network traffic and speed
> up the live migration process.

-- 
Thanks,

David
