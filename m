From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [Xen-devel] linux-next: Tree for Oct 24 (xen)
Date: Thu, 25 Oct 2012 11:48:30 +0100
Message-ID: <alpine.DEB.2.02.1210251118010.2689__9131.71695215187$1351162777$gmane$org@kaball.uk.xensource.com>
References: <20121024151957.28a1626cd9a59c014e78c401@canb.auug.org.au>
	<50885EA8.3050007@xenotime.net>
	<508906CE02000078000A4553@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <508906CE02000078000A4553@nat28.tlf.novell.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, xen-devel <xen-devel@lists.xen.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 25 Oct 2012, Jan Beulich wrote:
> >>> On 24.10.12 at 23:33, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > On 10/23/2012 09:19 PM, Stephen Rothwell wrote:
> > 
> >> Hi all,
> >> 
> >> Changes since 201201023:
> >> 
> > 
> > on x86_64:
> > 
> > drivers/built-in.o: In function `dbgp_reset_prep':
> > (.text+0xb96b5): undefined reference to `xen_dbgp_reset_prep'
> > drivers/built-in.o: In function `dbgp_external_startup':
> > (.text+0xb9d95): undefined reference to `xen_dbgp_external_startup'
> > 
> > 
> > Full randconfig file is attached.
> 
> So this is because with !USB_SUPPORT but EARLY_PRINTK_DBGP
> dbgp_reset_prep() and dbgp_external_startup() get pointlessly
> defined and exported. This got broken by the merge
> recommendation for the ARM side changes (originally compilation
> of drivers/xen/dbgp.c depended on just CONFIG_XEN_DOM0).
> 
> >From my pov, fixing the USB side would be the clean solution (i.e.
> putting those function definitions inside a CONFIG_USB_SUPPORT
> conditional).
>
> The alternative of a smaller change would be to extend the
> conditional around the respective xen_dbgp_...() declarations
> in include/linux/usb/ehci_def.h to become
> 
> #if defined(CONFIG_XEN_DOM0) && defined(CONFIG_USB_SUPPORT)
> 
> Please advise towards your preference.

I think that your first suggestion is the right one.


Otherwise we could also make drivers/xen/dbgp.c compile if
CONFIG_EARLY_PRINTK_DBGP rather than CONFIG_USB_SUPPORT.
I think that it would create fewer maintenance pains if dbgp_reset_prep
and dbgp_external_startup had the same compile requirements as their xen
counterparts (aside from Xen support of course).
