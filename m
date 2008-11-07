From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Thu, 6 Nov 2008 18:08:31 -0800
Message-ID: <0B53E02A2965CE4F9ADB38B34501A3A1678F60DA__32067.7298507237$1226023952$gmane$org@orsmsx505.amr.corp.intel.com>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
	<0199E0D51A61344794750DC57738F58E5E26F996C4@GVW1118EXC.americas.hpqcorp.net>
	<20081106183630.GD11773@parisc-linux.org>
	<491371F0.7020805@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <491371F0.7020805@codemonkey.ws>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>, Matthew Wilcox <matthew@wil.cx>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "Chiang,
	Alexander" <achiang@hp.com>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 11/6/2008 2:38:40 PM, Anthony Liguori wrote:
> Matthew Wilcox wrote:
> > [Anna, can you fix your word-wrapping please?  Your lines appear to
> > be infinitely long which is most unpleasant to reply to]
> >
> > On Thu, Nov 06, 2008 at 05:38:16PM +0000, Fischer, Anna wrote:
> >
> > > > Where would the VF drivers have to be associated?  On the "pci_dev"
> > > > level or on a higher one?
> > > >
> > > A VF appears to the Linux OS as a standard (full, additional) PCI
> > > device. The driver is associated in the same way as for a normal
> > > PCI device. Ideally, you would use SR-IOV devices on a virtualized
> > > system, for example, using Xen. A VF can then be assigned to a
> > > guest domain as a full PCI device.
> > >
> >
> > It's not clear thats the right solution.  If the VF devices are
> > _only_ going to be used by the guest, then arguably, we don't want
> > to create pci_devs for them in the host.  (I think it _is_ the right
> > answer, but I want to make it clear there's multiple opinions on this).
> >
>
> The VFs shouldn't be limited to being used by the guest.
>
> SR-IOV is actually an incredibly painful thing.  You need to have a VF
> driver in the guest, do hardware pass through, have a PV driver stub
> in the guest that's hypervisor specific (a VF is not usable on it's
> own), have a device specific backend in the VMM, and if you want to do
> live migration, have another PV driver in the guest that you can do
> teaming with.  Just a mess.

Actually "a PV driver stub in the guest" _was_ correct; I admit that I stated so at a virt mini summit more than a half year ago ;-). But the things have changed, and such a stub is no longer required (at least in our implementation). The major benefit of VF drivers now is that they are VMM-agnostic.

>
> What we would rather do in KVM, is have the VFs appear in the host as
> standard network devices.  We would then like to back our existing PV
> driver to this VF directly bypassing the host networking stack.  A key
> feature here is being able to fill the VF's receive queue with guest
> memory instead of host kernel memory so that you can get zero-copy
> receive traffic.  This will perform just as well as doing passthrough
> (at
> least) and avoid all that ugliness of dealing with SR-IOV in the guest.
>
> This eliminates all of the mess of various drivers in the guest and
> all the associated baggage of doing hardware passthrough.
>
> So IMHO, having VFs be usable in the host is absolutely critical
> because I think it's the only reasonable usage model.

As Eddie said, VMDq is better for this model, and the feature is already available today. It is much simpler because it was designed for such purposes. It does not require hardware pass-through (e.g. VT-d) or VFs as a PCI device, either.

>
> Regards,
>
> Anthony Liguori
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
             .
Jun Nakajima | Intel Open Source Technology Center
