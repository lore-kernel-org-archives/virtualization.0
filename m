From: Yu Zhao <yu.zhao@uniscape.net>
Subject: Re: [PATCH 6/6 v3] PCI: document the change
Date: Sat, 15 Nov 2008 20:38:55 +0800
Message-ID: <491EC2DF.2070704__25247.0306506895$1226752937$gmane$org@uniscape.net>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F6@pdsmsx502.ccr.corp.intel.com>
	<20081001160706.GI13822@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081001160706.GI13822@parisc-linux.org>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

Matthew Wilcox wrote:
> On Sat, Sep 27, 2008 at 04:28:45PM +0800, Zhao, Yu wrote:
>> +To register SR-IOV service, Physical Function device driver needs to call:
>> +       int pci_iov_register(struct pci_dev *dev,
>> +               int (*notify)(struct pci_dev *, u32), char **entries)
> 
> I think a better interface would put the 'notify' into the struct
> pci_driver.  That would make 'notify' a bad name .... how about
> 'virtual'?  There's also no documentation for the second parameter to
> 'notify'.

Yes, putting the callback function to the 'pci_driver' is better. Looks 
like the 'virtual' is not very descriptive (and it's a adj. while other 
callbacks are verb). Any other candidates?

Thanks,
Yu
