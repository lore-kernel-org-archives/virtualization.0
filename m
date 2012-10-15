From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] memory corruption in HYPERVISOR_physdev_op()
Date: Mon, 15 Oct 2012 11:58:16 +0100
Message-ID: <1350298696.18058.33.camel@zakaz.uk.xensource.com>
References: <20120914112427.GA1454@elgon.mountain>
	<1350296868.18058.24.camel@zakaz.uk.xensource.com>
	<507C062002000078000A1574@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <507C062002000078000A1574@nat28.tlf.novell.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel <xen-devel@lists.xen.org>, Tang Liang <liang.tang@oracle.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2012-10-15 at 11:48 +0100, Jan Beulich wrote:
> >>> On 15.10.12 at 12:27, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> > On Fri, 2012-09-14 at 14:24 +0300, Dan Carpenter wrote:
> >> My static analyzer complains about potential memory corruption in
> >> HYPERVISOR_physdev_op()
> >> 
> >> arch/x86/include/asm/xen/hypercall.h
> >>    389  static inline int
> >>    390  HYPERVISOR_physdev_op(int cmd, void *arg)
> >>    391  {
> >>    392          int rc = _hypercall2(int, physdev_op, cmd, arg);
> >>    393          if (unlikely(rc == -ENOSYS)) {
> >>    394                  struct physdev_op op;
> >>    395                  op.cmd = cmd;
> >>    396                  memcpy(&op.u, arg, sizeof(op.u));
> >>    397                  rc = _hypercall1(int, physdev_op_compat, &op);
> >>    398                  memcpy(arg, &op.u, sizeof(op.u));
> >>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> Some of the arg buffers are not as large as sizeof(op.u) which is either
> >> 12 or 16 depending on the size of longs in struct physdev_apic.
> > 
> > Nasty!
> 
> Wasn't it that pv-ops expects Xen 4.0.1 or newer anyway? If so,
> what does this code exist for in the first place (it's framed by
> #if CONFIG_XEN_COMPAT <= 0x030002 in the Xenified kernel)?

I think the 4.0.1 or newer requirement is for dom0 only. I guess physdev
op is only used in dom0 though? Or does passthrough need it?

> 
> >>    399          }
> >>    400          return rc;
> >>    401  }
> >> 
> >> One example of this is in xen_initdom_restore_msi_irqs().
> >> 
> >> arch/x86/pci/xen.c
> >>    337                  struct physdev_pci_device restore_ext;
> >>    338  
> >>    339                  restore_ext.seg = pci_domain_nr(dev->bus);
> >>    340                  restore_ext.bus = dev->bus->number;
> >>    341                  restore_ext.devfn = dev->devfn;
> >>    342                  ret = 
> > HYPERVISOR_physdev_op(PHYSDEVOP_restore_msi_ext,
> >>    343                                          &restore_ext);
> >>                                                 ^^^^^^^^^^^^
> >> There are only 4 bytes here.
> >> 
> >>    344                  if (ret == -ENOSYS)
> >>                             ^^^^^^^^^^^^^^
> >> If we hit this condition, we have corrupted some memory.
> > 
> > I can see the memory corruption but how does it relate to ret ==
> > -ENOSYS?
> 
> The (supposedly) corrupting code site inside an
> 
> 	if (unlikely(rc == -ENOSYS)) {

Ah, for some reason I assumed this was in the eventual caller, even
though it was staring me right in the face in the full quote.

> Supposedly because as long as the argument passed to the
> function is in memory accessed by the local CPU only and
> doesn't overlap with storage used for "rc" (e.g. living in a
> register), there's no corruption possible afaict - the second
> memcpy() would just copy back what the first one obtained
> from there.
> 
> Fixing this other than by removing the broken code would be
> pretty hard I'm afraid (and I tend to leave the code untouched
> altogether in the Xenified tree).

Given that it is compat code the list of subops which needs to supported
in this case is small and finite so a simple lookup table or even switch
stmt for the size might be an option.

Ian.
