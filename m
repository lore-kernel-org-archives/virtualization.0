From: Andy Lutomirski <luto@amacapital.net>
Subject: virtio DMA API?
Date: Mon, 25 Aug 2014 10:18:46 -0700
Message-ID: <CALCETrXaNYA=ffd1M0jUM+Z9Yz_Nhs7W=XCxe9N+0FYT558X6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Currently, a lot of the virtio code assumes that bus (i.e. hypervisor)
addresses are the same as physical address.  This is false on Xen, so
virtio is completely broken.  I wouldn't be surprised if it also
becomes a problem the first time that someone sticks a physical
"virtio" device on a 32-bit bus on an ARM SOC with more than 4G RAM.

Would you accept patches to convert virtio_ring and virtio_pci to use
the DMA APIs?  I think that the only real catch will be that
virtio_ring's approach to freeing indirect blocks is currently
incompatible with the DMA API -- it assumes that knowing the bus
address is enough to call kfree, and I don't think that the DMA API
provides a reverse mapping like that.

--Andy

-- 
Andy Lutomirski
AMA Capital Management, LLC
