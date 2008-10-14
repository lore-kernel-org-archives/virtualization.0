From: Yu Zhao <yu.zhao@intel.com>
Subject: Re: [PATCH 6/6 v3] PCI: document the change
Date: Tue, 14 Oct 2008 12:06:59 +0800
Message-ID: <20081014040659.GB1482__24118.1285506629$1223960773$gmane$org@yzhao12-linux.sh.intel.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F6@pdsmsx502.ccr.corp.intel.com>
	<20081001160706.GI13822@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CC69@pdsmsx415.ccr.corp.intel.com>
	<20081014010827.GX25780@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CE27@pdsmsx415.ccr.corp.intel.com>
	<20081014021435.GA1482@yzhao12-linux.sh.intel.com>
	<20081014040105.GA25780@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081014040105.GA25780@parisc-linux.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>, "Dong, Eddie" <eddie.dong@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 14, 2008 at 12:01:05PM +0800, Matthew Wilcox wrote:
> On Tue, Oct 14, 2008 at 10:14:35AM +0800, Yu Zhao wrote:
> > > BTW, the SR-IOV patch is not only for network, some other devices such as IDE will use same code base as well and we image it could have other parameter to set such as starting LBA of a IDE VF.
> >
> > As Eddie said, we have two problems here:
> > 1) User has to set device specific parameters of a VF when he wants to
> > use this VF with KVM (assign this device to KVM guest). In this case,
> > VF driver is not loaded in the host environment. So operations which
> > are implemented as driver callback (e.g. set_mac_address()) are not
> > supported.
> 
> I suspect what you want to do is create, then configure the device in
> the host, then assign it to the guest.
> 
> > 2) For security reason, some SR-IOV devices prohibit the VF driver
> > configuring the VF via its own register space. Instead, the configurations
> > must be done through the PF which the VF is associated with. This means PF
> > driver has to receive parameters that are used to configure its VFs. These
> > parameters obviously can be passed by traditional tools, if without
                         ^^^
Sorry, here I meant to say 'can not'.

> > modification for SR-IOV.
> 
> I think that idea also covers this point.

Can you please elaborate this?

Thanks a lot.

> 
> --
> Matthew Wilcox                          Intel Open Source Technology Centre
> "Bill, look, we understand that you're interested in selling us this
> operating system, but compare it to ours.  We can't possibly take such
> a retrograde step."
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
