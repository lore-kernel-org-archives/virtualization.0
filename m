From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] rfc: vhost user enhancements for vm2vm communication
Date: Mon, 14 Sep 2015 17:00:22 +0100
Message-ID: <20150914160022.GB15536@stefanha-thinkpad.redhat.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150831160655-mutt-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>, Claudio.Fontana@huawei.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, opnfv-tech-discuss@lists.opnfv.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 31, 2015 at 05:11:02PM +0300, Michael S. Tsirkin wrote:
> The resulting channel might look something like the following:
> 
> +-- VM1 --------------+  +---VM2-----------+
> | virtio-pci -- iommu +--+ vhost-pci -- VF | -- VFIO -- IOMMU -- NIC
> +---------------------+  +-----------------+
> 
> comparing the two diagrams, a vhost-user thread on the host is
> no longer required, reducing the host CPU utilization when
> polling is active.  At the same time, VM2 can not access all of VM1's
> memory - it is limited by the iommu configuration setup by VM1.

Can this use virtio's vring?  If standard virtio devices (net, blk, etc)
cannot be used because this scheme requires new descriptor rings or
memory layout, then this is more an "ivshmem 2.0" than "virtio".

I'm not clear on how vhost-pci works - is this a host kernel component
that updates VM2's memory mappings when VM1 changes iommu entries?

In VM2 there is a userspace network router.  It can mmap the VF's BARs
to access the physical network.  What about the virtual NIC to VM1, how
does the userspace network router access it?
