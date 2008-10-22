From: Yu Zhao <yu.zhao@uniscape.net>
Subject: Re: [PATCH 8/16 v6] PCI: add boot options to reassign resources
Date: Wed, 22 Oct 2008 22:49:56 +0800
Message-ID: <48FF3D94.5090001__16652.3619941019$1224687255$gmane$org@uniscape.net>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084303.GH3773@yzhao12-linux.sh.intel.com>
	<200810220835.35866.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200810220835.35866.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Bjorn Helgaas wrote:
> On Wednesday 22 October 2008 02:43:03 am Yu Zhao wrote:
>> This patch adds boot options so user can reassign device resources
>> of all devices under a bus.
>>
>> The boot options can be used as:
>> 	pci=assign-mmio=0000:01,assign-pio=0000:02
>> '[dddd:]bb' is the domain and bus number.
> 
> I think this example is incorrect because you look for ";" to
> separate options, not ",".

The semicolon is used to separate multiple parameters for assign-mmio 
and assign-pio. E.g., 'pci=assign-mmio=0000:01;0001:02;0004:03'. And the 
comma separates different parameters for 'pci='.
