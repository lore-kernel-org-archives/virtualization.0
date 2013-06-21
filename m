From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/3] deprecate usage of pci_scan_bus_parented()
Date: Fri, 21 Jun 2013 14:23:41 -0400
Message-ID: <20130621182341.GG15809@phenom.dumpdata.com>
References: <1371747665-12768-1-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1371747665-12768-1-git-send-email-liuj97@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Yijing Wang <wangyijing@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 21, 2013 at 01:01:02AM +0800, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> This patch tries to deprecate usage of pci_scan_bus_parented().
> It applies to
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next

They look OK to me, but let me double-test them in case some last
minute regression has reared its head.

> 
> Jiang Liu (3):
>   PCI: export three functions to support modular host bridge driver
>   PCI, xen-pcifront: use new PCI interfaces to simplify implementation
>   PCI: mark pci_scan_bus_parented() as __deprecated
> 
>  arch/tile/kernel/pci.c     |  3 --
>  drivers/pci/host-bridge.c  |  1 +
>  drivers/pci/probe.c        |  1 +
>  drivers/pci/remove.c       |  7 +++++
>  drivers/pci/xen-pcifront.c | 70 ++++++++++++++++++++--------------------------
>  include/linux/pci.h        |  5 ++--
>  6 files changed, 42 insertions(+), 45 deletions(-)
> 
> -- 
> 1.8.1.2
> 
