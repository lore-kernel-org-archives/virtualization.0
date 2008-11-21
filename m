From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Fri, 21 Nov 2008 12:57:46 -0800
Message-ID: <20081121205746.GA3639__20563.5792496198$1227301425$gmane$org@kroah.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
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
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, horms@verge.net.au, kvm@vger.kernel.org, mingo@elte.hu, yinghai@kernel.org, bjorn.helgaas@hp.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Nov 22, 2008 at 02:36:05AM +0800, Yu Zhao wrote:
> Greetings,
> 
> Following patches are intended to support SR-IOV capability in the
> Linux kernel. With these patches, people can turn a PCI device with
> the capability into multiple ones from software perspective, which
> will benefit KVM and achieve other purposes such as QoS, security,
> and etc.
> 
> The Physical Function and Virtual Function drivers using the SR-IOV
> APIs will come soon!

Thanks for respining these patches, but I think we really need to see a
driver using this in order to get an idea of how it will be used.

Also, the Xen and KVM people need to agree on the userspace interface
here, perhaps also getting some libvirt involvement as well, as they are
going to be the ones having to use this all the time.

thanks,

greg k-h
