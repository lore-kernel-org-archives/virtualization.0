From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [RFC PATCH v2, part 2 02/18] PCI, core: use hotplug-safe
	iterators to walk PCI buses
Date: Tue, 14 May 2013 11:55:16 -0700
Message-ID: <CAE9FiQWoi3J=oZ6Y2DqAeorMgknBZ+LwbFXLz+hYo=GwavqU6w@mail.gmail.com>
References: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
	<1368550322-1045-2-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1368550322-1045-2-git-send-email-jiang.liu@huawei.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Xen Devel <xen-devel@lists.xensource.com>, Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, Gu Zheng <guz.fnst@cn.fujitsu.com>, Yijing Wang <wangyijing@huawei.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 14, 2013 at 9:51 AM, Jiang Liu <liuj97@gmail.com> wrote:
> Enhance PCI core to use hotplug-safe iterators to walk PCI buses.
>
> In other words, replace pci_find_bus(), pci_find_next_bus() and
> pci_root_buses with pci_bus_exists(), pci_get_bus(), pci_get_next_bus()
> and pci_get_next_root_bus() etc.

good changes.

Acked-by:  Yinghai Lu <yinghai@kernel.org>
