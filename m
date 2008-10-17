From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 8/8 v4] PCI: document the changes
Date: Sat, 18 Oct 2008 00:54:41 +0200
Message-ID: <20081017225440.GA1467__10577.4406729781$1224285810$gmane$org@ucw.cz>
References: <20081014103424.GA1704@yzhao12-linux.sh.intel.com>
	<20081014110157.GH1734@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081014110157.GH1734@yzhao12-linux.sh.intel.com>
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi!

> Create how-to for SR-IOV user and device driver developer.
> 
> Signed-off-by: Yu Zhao <yu.zhao@intel.com>

> +1.1 What is SR-IOV
> +
> +Single Root I/O Virtualization (SR-IOV) is a PCI Express Extended
> +capability which makes one physical device appear as multiple virtual
> +devices. The physical device is referred to as Physical Function while
> +the virtual devices are referred to as Virtual Functions. Allocation
> +of Virtual Functions can be dynamically controlled by Physical Function
> +via registers encapsulated in the capability. By default, this feature
> +is not enabled and the Physical Function behaves as traditional PCIe
> +device. Once it's turned on, each Virtual Function's PCI configuration
> +space can be accessed by its own Bus, Device and Function Number (Routing
> +ID). And each Virtual Function also has PCI Memory Space, which is
> used

Ok, why is this optional? If intel cares about virtualization, it
should enable this by default. I dont see why this should be
configurable.

> +#ifdef CONFIG_PM
> +/*
> + * If Physical Function supports the power management, then the
> + * SR-IOV needs to be disabled before the adapter goes to sleep,
> + * because Virtual Functions will not work when the adapter is in
> + * the power-saving mode.
> + * The SR-IOV can be enabled again after the adapter wakes up.
> + */

How beatiful :-(.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
