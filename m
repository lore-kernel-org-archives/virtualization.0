From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 13:50:10 +0300
Message-ID: <20090521105010.GC25309__14919.0510310747$1242903233$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211109.09844.paul@codesourcery.com>
	<4A152B8D.5020006@redhat.com>
	<200905211134.21184.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905211134.21184.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 21, 2009 at 11:34:11AM +0100, Paul Brook wrote:
> > The PCI bus doesn't need any special support (I think) but something on
> > the other end needs to interpret those writes.
> 
> Sure. But there's definitely nothing PCI specific about it. I assumed this 
> would all be contained within the APIC.

Exactly. APIC supplies callbacks to set up/free/mask/unmask MSI interrupts.
For kvm, we'll have another implementation that passes these requests
on to kernel.

> > In any case we need some internal API for this, and qemu_irq looks like
> > a good choice.
> 
> What do you expect to be using this API?
> 
> Paul

emulated PCI devices such as virtio.
Hope to send a patch shortly.

-- 
MST
