From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: RE: [PATCH 4/6 v3] PCI: support SR-IOV capability
Date: Wed, 8 Oct 2008 10:49:27 +0800
Message-ID: <D8078B8B3B09934AA9F8F2D5FB3F28CE08A3D24396__13031.6648436294$1223434341$gmane$org@pdsmsx502.ccr.corp.intel.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F4@pdsmsx502.ccr.corp.intel.com>
	<ada3ajhfeb4.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ada3ajhfeb4.fsf@cisco.com>
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
To: Roland Dreier <rdreier@cisco.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, Grant@smtp1.linux-foundation.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Wilcox <matthew@wil.cx>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Matthew@smtp1.linux-foundation.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday, October 01, 2008 6:40 AM, Roland Dreier wrote:
> > +       ctrl = pci_ari_enabled(dev) ? PCI_IOV_CTRL_ARI : 0;
> > +       pci_write_config_word(dev, pos + PCI_IOV_CTRL, ctrl);
> > +       ssleep(1);
>
>You seem to sleep for 1 second wherever you write the IOV_CTRL
>register.  Why is this?  Is this specified by PCI, or is it coming from
>somewhere else?

This is specified by on pp. 39 PCI SR-IOV specification 1.0. You can find it at: http://www.pcisig.com/members/downloads/specifications/iov/sr-iov1.0_11Sep07.pdf

Thanks.

>
> - R.
