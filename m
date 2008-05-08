From: Dor Laor <dor.laor@qumranet.com>
Subject: Re: qemu/kvm: support for pci passthrough
Date: Thu, 08 May 2008 23:38:45 +0300
Message-ID: <1210279125.24261.323.camel@localhost.localdomain>
References: <a518fa500805080303p1efcba0y383ec711fe2f68f8@mail.gmail.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a518fa500805080303p1efcba0y383ec711fe2f68f8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicolas Daneau <nicolas.daneau@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 2008-05-08 at 12:03 +0200, Nicolas Daneau wrote:
> Hi,
> 
> I saw there was an active discussion about pci passthrough support in
> KVM. I'm not a Dev, only a sys admin that need this support. As i saw
> on the KVM home page that this feature is plan for 2H2008 in the
> roadmap, I wondered if you already have a more precise time frame for
> this release? Xen already have this feature but for the rest i prfer
> KVM. As this is a key point for the final decsion (we have a Digium
> TDM11B FXO/FXS pci card for an Asterisk VM), i'm waiting for an update
> about this feature.
> 

This is feature is indeed work in progress. We have floating patches for
several solutions:
1. Using Intel's VT-d - hw iommu support.
   Patches were sent, needs some more scrubbing. The good thing is that 
   it can live withing the kvm module and does not have to wait for 
   kernel inclusion like the two below.
2. PV dma - good only for Linux guests. Some locking issues needs to be 
   solved + get into mainline kernel (>=2.6.27)
3. 1-1 mapping of the guest-host addresses. 
   Will work for any guest, no need for special hw, good only for 
   single guest and not 100% secure.
   Needs a little more attention, worked in the past privately.

Bottom line, soon you'll have more than one option for pci pass through
using kvm. There is no assurance we'll make it exactly in Q2.
You can help by applying patches and sending results.
Cheers,
Dor

> Thanks for your answer
> 
