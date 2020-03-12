From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Date: Thu, 12 Mar 2020 04:47:11 -0400
Message-ID: <20200312043859-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane-mx.org@nongnu.org>
In-Reply-To: <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane-mx.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+gceq-qemu-devel2=m.gmane-mx.org@nongnu.org>
To: David Hildenbrand <david@redhat.com>
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>, qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, namit@vmware.com, Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org, jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> 2. You are essentially stealing THPs in the guest. So the fastest
> mapping (THP in guest and host) is gone. The guest won't be able to make
> use of THP where it previously was able to. I can imagine this implies a
> performance degradation for some workloads. This needs a proper
> performance evaluation.

I think the problem is more with the alloc_pages API.
That gives you exactly the given order, and if there's
a larger chunk available, it will split it up.

But for balloon - I suspect lots of other users,
we do not want to stress the system but if a large
chunk is available anyway, then we could handle
that more optimally by getting it all in one go.


So if we want to address this, IMHO this calls for a new API.
Along the lines of

=09struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
=09=09=09=09=09unsigned int max_order, unsigned int *order)

the idea would then be to return at a number of pages in the given
range.

What do you think? Want to try implementing that?

--=20
MST
