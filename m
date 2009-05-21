From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 15:14:30 +0100
Message-ID: <200905211514.31059.paul__23977.0492808477$1242917035$gmane$org@codesourcery.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211453.14691.paul@codesourcery.com>
	<4A155EC6.6070501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A155EC6.6070501@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 21 May 2009, Avi Kivity wrote:
> Paul Brook wrote:
> >>> which is a trivial wrapper around stl_phys.
> >>
> >> OK, but I'm adding another level of indirection in the middle,
> >> to allow us to tie in a kvm backend.
> >
> > kvm has no business messing with the PCI device code.
>
> kvm has a fast path for irq injection.  If qemu wants to support it we
> need some abstraction here.

Fast path from where to where? Having the PCI layer bypass/re-implement the 
APIC and inject the interrupt directly into the cpu core sounds a particularly 
bad idea.

Paul
