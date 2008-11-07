From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Thu, 6 Nov 2008 22:07:07 -0800
Message-ID: <20081107060707.GA3860__44262.2260227383$1226039553$gmane$org@kroah.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081106044828.GA30417@kroah.com> <4913CFBC.4040203@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4913CFBC.4040203@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhao, Yu" <yu.zhao@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 07, 2008 at 01:18:52PM +0800, Zhao, Yu wrote:
> Greg KH wrote:
>> On Wed, Oct 22, 2008 at 04:38:09PM +0800, Yu Zhao wrote:
>>> Greetings,
>>>
>>> Following patches are intended to support SR-IOV capability in the
>>> Linux kernel. With these patches, people can turn a PCI device with
>>> the capability into multiple ones from software perspective, which
>>> will benefit KVM and achieve other purposes such as QoS, security,
>>> and etc.
>> Is there any actual users of this API around yet?  How was it tested as
>> there is no hardware to test on?  Which drivers are going to have to be
>> rewritten to take advantage of this new interface?
>
> Yes, the API is used by Intel, HP, NextIO and some other anonymous 
> companies as they rise questions and send me feedback. I haven't seen their 
> works but I guess some of drivers using SR-IOV API are going to be released 
> soon.

Well, we can't merge infrastructure without seeing the users of that
infrastructure, right?

> My test was done with Intel 82576 Gigabit Ethernet Controller. The product 
> brief is at http://download.intel.com/design/network/ProdBrf/320025.pdf and 
> the spec is available at 
> http://download.intel.com/design/network/datashts/82576_Datasheet_v2p1.pdf

Cool, do you have that driver we can see?

How does it interact and handle the kvm and xen issues that have been
posted?

thanks,

greg k-h
