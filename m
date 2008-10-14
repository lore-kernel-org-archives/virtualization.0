From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 6/8 v4] PCI: support the SR-IOV capability
Date: Tue, 14 Oct 2008 06:30:02 -0600
Message-ID: <20081014123002.GA15064__21104.869634337$1223987681$gmane$org@parisc-linux.org>
References: <20081014103424.GA1704@yzhao12-linux.sh.intel.com>
	<20081014105928.GF1734@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081014105928.GF1734@yzhao12-linux.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 14, 2008 at 06:59:28PM +0800, Yu Zhao wrote:
> +++ b/drivers/pci/pci.h
> @@ -176,4 +176,59 @@ static inline int pci_ari_enabled(struct pci_dev *dev)
> +struct pci_iov {
> +	int cap;		/* capability position */
> +	int align;		/* page size used to map memory space */
> +	int is_enabled;		/* status of SR-IOV */
> +	int nentries;		/* number of sysfs entries used by PF driver */
> +	u16 totalvfs;		/* total VFs associated with the PF */
> +	u16 initialvfs;		/* initial VFs associated with the PF */
> +	u16 numvfs;		/* number of VFs available */
> +	u16 offset;		/* first VF Routing ID offset */
> +	u16 stride;		/* following VF stride */
> +	struct mutex mutex;	/* lock for SR-IOV */
> +	struct kobject kobj;	/* koject for IOV */
> +	struct pci_dev *dev;	/* Physical Function */
> +	struct vf_entry *ve;	/* Virtual Function related */
> +	int (*notify)(struct pci_dev *, u32);	/* event callback function */
> +};

> +++ b/include/linux/pci.h
> @@ -87,6 +87,12 @@ enum {
>  	/* #6: expansion ROM */
>  	PCI_ROM_RESOURCE,
>  
> +	/* device specific resources */
> +#ifdef CONFIG_PCI_IOV
> +	PCI_IOV_RESOURCES,
> +	PCI_IOV_RESOURCES_END = PCI_IOV_RESOURCES + PCI_IOV_NUM_BAR - 1,
> +#endif
> +
>  	/* address space assigned to buses behind the bridge */
>  #ifndef PCI_BRIDGE_RES_NUM
>  #define PCI_BRIDGE_RES_NUM 4

Why expand the number of resources in struct pci_dev instead of putting
the new resources in struct pci_iov?

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
