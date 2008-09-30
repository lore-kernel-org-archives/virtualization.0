From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 4/6 v3] PCI: support SR-IOV capability
Date: Tue, 30 Sep 2008 15:40:15 -0700
Message-ID: <ada3ajhfeb4.fsf__23467.7583714531$1222814673$gmane$org@cisco.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F4@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F4@pdsmsx502.ccr.corp.intel.com>
	(Yu Zhao's message of "Sat, 27 Sep 2008 16:28:15 +0800")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhao, Yu" <yu.zhao@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

 > +       ctrl = pci_ari_enabled(dev) ? PCI_IOV_CTRL_ARI : 0;
 > +       pci_write_config_word(dev, pos + PCI_IOV_CTRL, ctrl);
 > +       ssleep(1);

You seem to sleep for 1 second wherever you write the IOV_CTRL
register.  Why is this?  Is this specified by PCI, or is it coming from
somewhere else?

 - R.
