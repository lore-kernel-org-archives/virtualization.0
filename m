From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio config_ops refactoring
Date: Sat, 10 Nov 2007 18:58:18 +1100
Message-ID: <200711101858.19069.rusty__4477.57922015644$1194681638$gmane$org@rustcorp.com.au>
References: <4730A8F3.6020008@us.ibm.com>
	<200711092254.08099.rusty@rustcorp.com.au>
	<4734F122.8000102@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4734F122.8000102@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 10 November 2007 10:45:38 Anthony Liguori wrote:
> The problem is the ABI.  We can either require that PCI configuration
> values are accessed with natural instructions, or it makes very little
> sense to use the PCI configuration space for virtio configuration
> information.

To me it seems logical and simplest to allow any accesses, lay out your 
structure and emulate it in the obvious way.

You can put the configuration information somewhere else, but the PCI config 
space seems the logical place.

> Either virtio config looks like a shared memory area (as lguest
> currently implements it), or it looks like hardware registers (like
> virtio-pci implements it).  After thinking about it for a while, I don't
> think the two can be reconciled.  There are subtle differences between
> the two that can't be hidden in the virtio interface.  For instance, in
> the PCI model, you get notified when values are read/written whereas in
> the lguest model, you don't and need explicit status bits.

No.  You need those status bits even if you have your register model, 
otherwise you can't tell when the configuration as a whole is stable.  
Consider the feature bits.  Worse, consider extending the feature bits beyond 
32 bits.

(We will have to deal with dynamic configuration changes in future; I was 
planning on using some status bits.  But it's pretty clear that it's going to 
require an explicit ack of some form.)

Hope that clarifies,
Rusty.
