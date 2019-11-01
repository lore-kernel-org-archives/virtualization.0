From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: presentation at kvm forum and pagefaults
Date: Fri, 1 Nov 2019 04:51:10 -0400
Message-ID: <20191101044700-mutt-send-email-mst__33396.5178624325$1572598290$gmane$org@kernel.org>
References: <20191031234601-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191031234601-mutt-send-email-mst@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 01, 2019 at 12:07:01AM -0400, Michael S. Tsirkin wrote:
> Regarding the presentation I gave at the kvm forum
> on pagefaults.
> 
> Two points:
> 
> 
> 1. pagefaults are important not just for migration.
> They are important for performance features such as
> autonuma and huge pages, since this relies on moving
> pages around.
> Migration can maybe be solved by switch to software but
> this is not a good solution for numa and thp  since
> at a given time some page is likely being moved.
> 

Also, pagefaults might allow iommu page table shadowing to scale better
to huge guests. As in, the host IOMMU page tables can be populated
lazily on fault. I'm not sure what the performance of such an approach
would be though, but this space might be worth exploring.


> 
> 
> 
> 2.  For devices such as networking RX order in which buffers are
> used *does not matter*.
> Thus if a device gets a fault in response to attempt to store a buffer
> into memory, it can just re-try, using the next buffer in queue instead.
> 
> This works because normally buffers can be used out of order by device.
> 
> The faulted buffer will be reused by another buffer when driver notifies
> device page has been faulted in.
> 
> Note buffers are processed by buffer in the order in which they have
> been used, *not* the order in which they have been put in the queue.  So
> this will *not* cause any packet reordering for the driver.
> 
> Packets will only get dropped if all buffers are swapped
> out, which should be rare with a large RX queue.
> 
> 
> As I said at the forum, a side buffer for X packets
> to be stored temporarily is also additionally possible. But with the above
> it is no longer strictly required.
> 
> 
> This conflicts with the IN_ORDER feature flag, I guess we will have to
> re-think this flag then. If we do feel we need to salvage IN_ORDER as is,
> maybe device can use the buffer with length 0 and driver will re-post it
> later, but I am not I am not sure about this since involving the VF
> driver seems inelegant.
> 
> -- 
> MST
