From: "Kay Sievers" <kay.sievers@vrfy.org>
Subject: Re: [PATCH 15/16 v6] PCI: document the SR-IOV sysfs entries
Date: Tue, 18 Nov 2008 17:49:05 +0100
Message-ID: <ac3eb2510811180849g7cb2f9d2n8603d02ca130b01c__21529.6917631806$1227045971$gmane$org@mail.gmail.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084515.GO3773@yzhao12-linux.sh.intel.com>
	<20081106043318.GB30292@kroah.com> <20081106044613.GA30397@kroah.com>
	<4913AF89.2050504@intel.com> <20081107031837.GB30003@kroah.com>
	<20081113065024.GA3038@yzhao12-linux.sh.intel.com>
	<20081114005538.GA21161@kroah.com>
	<20081117080949.GA5247@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081117080949.GA5247@yzhao12-linux.sh.intel.com>
Content-Disposition: inline
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 17, 2008 at 09:09, Yu Zhao <yu.zhao@intel.com> wrote:
> On Fri, Nov 14, 2008 at 08:55:38AM +0800, Greg KH wrote:

>> There are also "conditional" attributes, which get only displayed if
>> some kind of condition is met, I think you want to use those.
>
> The problem is the sysfs directory of the PCI device is created by the
> kobject_add() in the device_add() as follows. And the static entries
> bundled with the 'pci_bus_type' are created by the bus_add_device().
> Between the kobject_add() and the kobject_uevent(), we don't have any
> other choice to add the dynamic entries.
>
> In device_add():
>
>        error = kobject_add(&dev->kobj, dev->kobj.parent, "%s", dev->bus_id);
>        ...
>        error = bus_add_device(dev);
>        ...
>        kobject_uevent(&dev->kobj, KOBJ_ADD);
>
>
> So looks like the only way is to make the dynamic entries bundled with
> the 'pci_bus_type', which means they would become static no matter the
> device supports the entries (i.e. corresponding capabilities) or not.

There is device_add_attrs() which is just called between the calls you
mention above. Like Greg said, it can add groups, and groups have an
is_visible() callback, which can be used to conditionally create
attributes out of of predefined list.

Kay
