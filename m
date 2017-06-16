From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-mem: paravirtualized memory
Date: Fri, 16 Jun 2017 18:04:06 +0300
Message-ID: <20170616175748-mutt-send-email-mst__36947.4776475274$1497625459$gmane$org@kernel.org>
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 16, 2017 at 04:20:02PM +0200, David Hildenbrand wrote:
> Hi,
> 
> this is an idea that is based on Andrea Arcangeli's original idea to
> host enforce guest access to memory given up using virtio-balloon using
> userfaultfd in the hypervisor. While looking into the details, I
> realized that host-enforcing virtio-balloon would result in way too many
> problems (mainly backwards compatibility) and would also have some
> conceptual restrictions that I want to avoid. So I developed the idea of
> virtio-mem - "paravirtualized memory".

Thanks! I went over this quickly, will read some more in the
coming days. I would like to ask for some clarifications
on one part meanwhile:

> Q: Why not reuse virtio-balloon?
> 
> A: virtio-balloon is for cooperative memory management. It has a fixed
>    page size

We are fixing that with VIRTIO_BALLOON_F_PAGE_CHUNKS btw.
I would appreciate you looking into that patchset.

> and will deflate in certain situations.

What does this refer to?

> Any change we
>    introduce will break backwards compatibility.

Why does this have to be the case?

> virtio-balloon was not
>    designed to give guarantees. Nobody can hinder the guest from
>    deflating/reusing inflated memory.

Reusing without deflate is forbidden with TELL_HOST, right?

>    In addition, it might make perfect
>    sense to have both, virtio-balloon and virtio-mem at the same time,
>    especially looking at the DEFLATE_ON_OOM or STATS features of
>    virtio-balloon. While virtio-mem is all about guarantees, virtio-
>    balloon is about cooperation.

Thanks, and I intend to look more into this next week.

-- 
MST
