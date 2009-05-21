From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 16:46:50 +0300
Message-ID: <20090521134650.GI25309__38101.8457971097$1242913854$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211409.33325.paul@codesourcery.com>
	<20090521131231.GH25309@redhat.com>
	<200905211423.20843.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905211423.20843.paul@codesourcery.com>
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

On Thu, May 21, 2009 at 02:23:20PM +0100, Paul Brook wrote:
> > > MSI provides multiple edge triggered interrupts, whereas traditional mode
> > > provides a single level triggered interrupt. My guess is most devices
> > > will want to treat these differently anyway.
> >
> > So, is qemu_send_msi better than qemu_set_irq.
> 
> Neither. pci_send_msi,

Works for me.

> which is a trivial wrapper around stl_phys.

OK, but I'm adding another level of indirection in the middle,
to allow us to tie in a kvm backend.

-- 
MST
