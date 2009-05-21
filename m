From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 14:31:26 +0100
Message-ID: <200905211431.27287.paul__35925.9024066434$1242916950$gmane$org@codesourcery.com>
References: <20090520162130.GA22109@redhat.com>
	<20090521131231.GH25309@redhat.com>
	<200905211423.20843.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905211423.20843.paul@codesourcery.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 21 May 2009, Paul Brook wrote:
> > > MSI provides multiple edge triggered interrupts, whereas traditional
> > > mode provides a single level triggered interrupt. My guess is most
> > > devices will want to treat these differently anyway.
> >
> > So, is qemu_send_msi better than qemu_set_irq.
>
> Neither. pci_send_msi, which is a trivial wrapper around stl_phys.

To clarify, you seem to be trying to fuse two largely separate features 
together.

MSI is a standard PCI device capability[1] that involves the device performing 
a 32-bit memory write when something interesting occurs. These writes may or 
may not be directed at a APIC.

The x86 APIC has a memory mapped interface that allows generation of CPU 
interrupts in response response to memory writes. These may or may not come 
from an MSI capable PCI device.

Paul

[1] Note a *device* capability, not a bus capability.
