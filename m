From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Fri, 07 Nov 2008 15:47:54 +0800
Message-ID: <4913F2AA.90405__7065.33359266377$1226044222$gmane$org@intel.com>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
	<20081106174741.GC11773@parisc-linux.org>
	<20081106175308.GA17027@kroah.com> <49137255.9010104@codemonkey.ws>
	<20081107061700.GD3860@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081107061700.GD3860@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>, Anthony Liguori <anthony@codemonkey.ws>, Leonid.Grossman@neterion.com
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, Chris Wright <chrisw@sous-sol.org>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:
> On Thu, Nov 06, 2008 at 04:40:21PM -0600, Anthony Liguori wrote:
>> Greg KH wrote:
>>> On Thu, Nov 06, 2008 at 10:47:41AM -0700, Matthew Wilcox wrote:
>>>   
>>>> I don't think we really know what the One True Usage model is for VF
>>>> devices.  Chris Wright has some ideas, I have some ideas and Yu Zhao has
>>>> some ideas.  I bet there's other people who have other ideas too.
>>>>     
>>> I'd love to hear those ideas.
>>>   
>> We've been talking about avoiding hardware passthrough entirely and
>> just backing a virtio-net backend driver by a dedicated VF in the
>> host.  That avoids a huge amount of guest-facing complexity, let's
>> migration Just Work, and should give the same level of performance.

This can be commonly used not only with VF -- devices that have multiple 
DMA queues (e.g., Intel VMDq, Neterion Xframe) and even traditional 
devices can also take the advantage of this.

CC Rusty Russel in case he has more comments.

> 
> Does that involve this patch set?  Or a different type of interface.

I think that is a different type of interface. We need to hook the DMA 
interface in the device driver to virtio-net backend so the hardware 
(normal device, VF, VMDq, etc.) can DMA data to/from the virtio-net backend.

Regards,
Yu
