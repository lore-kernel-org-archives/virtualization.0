From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 4/6 v3] PCI: support SR-IOV capability
Date: Fri, 10 Oct 2008 15:24:49 +0800
Message-ID: <48EF0341.9040703__40693.6419000433$1223623730$gmane$org@intel.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F4@pdsmsx502.ccr.corp.intel.com>
	<20080930223851.GC13611@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080930223851.GC13611@ldl.fc.hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Chiang <achiang@hp.com>, "Zhao, Yu" <yu.zhao@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, Gra
List-Id: virtualization@lists.linuxfoundation.org

Alex Chiang wrote:
> Do you want to emit a kobject_uevent here after success?
> 
> Alternatively, have you investigated making these virtual
> functions into real struct device's? You get a lot of sysfs stuff
> for free if you do so, including correct place in sysfs hierarchy
> and uevents, etc.

The virtual functions are rpresented by 'struct pci_dev', so same as 
real device, the standard sysfs entries are created by pci_bus_add_device.

> 
> My major complaints from last round (more documentation,
> shouldn't be a PCI hotplug driver) have been addressed. I'll let
> others comment about the other parts of your patch series.

Thanks, Alex.

> 
> Thanks.
> 
> /ac
> 
