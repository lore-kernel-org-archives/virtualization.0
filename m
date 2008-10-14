From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 6/8 v4] PCI: support the SR-IOV capability
Date: Tue, 14 Oct 2008 07:37:44 -0700
Message-ID: <20081014143744.GA12251__37848.9302275286$1223995713$gmane$org@kroah.com>
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 14, 2008 at 06:59:28PM +0800, Yu Zhao wrote:
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

Why isn't this a real struct device?

That way you get all of the proper userspace notification and the like,
with kobjects, you do not.

thanks,

greg k-h
