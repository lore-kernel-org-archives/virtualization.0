From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [SR-IOV driver example 2/3] PF driver: integrate with SR-IOV core
Date: Wed, 26 Nov 2008 11:27:10 -0800
Message-ID: <0B53E02A2965CE4F9ADB38B34501A3A167E8BD7F__49456.0575265952$1227727790$gmane$org@orsmsx505.amr.corp.intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081126140303.GA13641@yzhao12-linux.sh.intel.com>
	<20081126142156.GB13668@yzhao12-linux.sh.intel.com>
	<20081126165859.GA28251@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081126165859.GA28251@kroah.com>
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
To: Greg KH <greg@kroah.com>, "Zhao, Yu" <yu.zhao@intel.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/26/2008 8:58:59 AM, Greg KH wrote:
> On Wed, Nov 26, 2008 at 10:21:56PM +0800, Yu Zhao wrote:
> > This patch integrates the IGB driver with the SR-IOV core. It shows
> > how the SR-IOV API is used to support the capability. Obviously
> > people does not need to put much effort to integrate the PF driver
> > with SR-IOV core. All SR-IOV standard stuff are handled by SR-IOV
> > core and PF driver once it gets the necessary information (i.e.
> > number of Virtual
> > Functions) from the callback function.
> >
> > ---
> >  drivers/net/igb/igb_main.c |   30 ++++++++++++++++++++++++++++++
> >  1 files changed, 30 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/net/igb/igb_main.c b/drivers/net/igb/igb_main.c
> > index bc063d4..b8c7dc6 100644
> > --- a/drivers/net/igb/igb_main.c
> > +++ b/drivers/net/igb/igb_main.c
> > @@ -139,6 +139,7 @@ void igb_set_mc_list_pools(struct igb_adapter *,
> > struct e1000_hw *, int, u16);  static int igb_vmm_control(struct
> > igb_adapter *, bool);  static int igb_set_vf_mac(struct net_device
> > *, int, u8*);  static void igb_mbox_handler(struct igb_adapter *);
> > +static int igb_virtual(struct pci_dev *, int);
> >  #endif
> >
> >  static int igb_suspend(struct pci_dev *, pm_message_t); @@ -184,6
> > +185,9 @@ static struct pci_driver igb_driver = {  #endif
> >     .shutdown = igb_shutdown,
> >     .err_handler = &igb_err_handler,
> > +#ifdef CONFIG_PCI_IOV
> > +   .virtual = igb_virtual
> > +#endif
>
> #ifdef should not be needed, right?
>

Good point. I think this is because the driver is expected to build on older kernels also, but the problem is that the driver (and probably others) is broken unless the kernel is built with CONFIG_PCI_IOV because of the following hunk, for example.

However, we don't want to use #ifdef for the (*virtual) field in the header. One option would be to define a constant like the following along with those changes.
#define PCI_DEV_IOV

Any better idea?

Thanks,
             .
Jun Nakajima | Intel Open Source Technology Center

----
@@ -259,6 +266,7 @@ struct pci_dev {
        struct list_head msi_list;
 #endif
        struct pci_vpd *vpd;
+       struct pci_iov *iov;
 };

 extern struct pci_dev *alloc_pci_dev(void); @@ -426,6 +434,7 @@ struct pci_driver {
        int  (*resume_early) (struct pci_dev *dev);
        int  (*resume) (struct pci_dev *dev);                   /* Device woken up */
        void (*shutdown) (struct pci_dev *dev);
+       int (*virtual) (struct pci_dev *dev, int nr_virtfn);
        struct pm_ext_ops *pm;
        struct pci_error_handlers *err_handler;
        struct device_driver    driver;
