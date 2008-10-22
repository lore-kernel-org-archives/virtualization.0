From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 8/15 v5] PCI: add boot options to reassign resources
Date: Wed, 22 Oct 2008 09:19:09 +0200
Message-ID: <20081022071909.GB27637__24458.6002700546$1224660121$gmane$org@elte.hu>
References: <20081021114056.GA3185@yzhao12-linux.sh.intel.com>
	<20081021114959.GI3185@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081021114959.GI3185@yzhao12-linux.sh.intel.com>
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


* Yu Zhao <yu.zhao@intel.com> wrote:

> +static char *pci_assign_pio;
> +static char *pci_assign_mmio;
> +
> +static int pcibios_bus_resource_needs_fixup(struct pci_bus *bus)
> +{
> +	int i;
> +	int type = 0;
> +	int domain, busnr;
> +
> +	if (!bus->self)
> +		return 0;
> +
> +	for (i = 0; i < 2; i++) {
> +		char *str = i ? pci_assign_pio : pci_assign_mmio;
> +		while (str && *str) {

please put a newline after local variable defitions.

> +	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
> +		struct resource *res = bus->resource[i];
> +		if (!res)

ditto.

nice debug feature!

	Ingo
