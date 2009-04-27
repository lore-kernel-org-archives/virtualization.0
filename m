From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Mon, 27 Apr 2009 17:32:56 +0300
Message-ID: <20090427143256.GD2504__14429.7149069191$1240856556$gmane$org@redhat.com>
References: <20090427123136.GA1152@redhat.com>
	<200904271600.30599.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904271600.30599.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 27, 2009 at 04:00:30PM +0200, Christian Borntraeger wrote:
> Am Monday 27 April 2009 14:31:36 schrieb Michael S. Tsirkin:
> > Add optional MSI-X support: use a vector per virtqueue with
> > fallback to a common vector and finally to regular interrupt.
> > Teach all drivers to use it.
> > 
> > I added 2 new virtio operations: request_vqs/free_vqs because MSI
> > needs to know the total number of vectors upfront.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I dont know, if that is feasible for MSI, but the transport(virtio_pci) should
> already know the number of virtqueues, which should match the number of
> vectors, no?

I think no, the transport can find out the max number of vectors the
device supports (pci_msix_table_size), but not how many virtqueues are
needed by the driver.
As  number of virtqueues <= number of vectors,
we could pre-allocate all vectors that host supports, but this seems
a bit drastic as an MSI-X device could support up to 2K vectors.

> In fact, the transport has to have a way of getting the number of virtqeues
> because find_vq returns ENOENT on invalid index numbers.
> 
> Christian

So again, I think this is an upper bound supported by host. Right?

-- 
MST
