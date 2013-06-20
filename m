From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] PCI: mark pci_scan_bus_parented() as __deprecated
Date: Thu, 20 Jun 2013 10:08:55 -0700
Message-ID: <20130620170855.GA21465@kroah.com>
References: <1371747665-12768-1-git-send-email-liuj97@gmail.com>
	<1371747665-12768-4-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1371747665-12768-4-git-send-email-liuj97@gmail.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Jiang Liu <jiang.liu@huawei.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, virtualization@lists.linux-foundation.org, Yijing Wang <wangyijing@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 21, 2013 at 01:01:05AM +0800, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> Mark pci_scan_bus_parented() as __deprecated and clean up outdated
> comments.

Why not just delete the function, if no in-kernel users are calling it,
it's no longer needed at all.

thanks,

greg k-h
