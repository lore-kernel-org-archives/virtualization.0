From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] virtio_pci: fix macro exported in uapi
Date: Mon, 20 May 2013 10:06:56 +0100
Message-ID: <1032.1369040816@warthog.procyon.org.uk>
References: <87r4h2zf5y.fsf@rustcorp.com.au> <87wqqy8o2k.fsf@rustcorp.com.au>
	<20130516164446.GA32007@redhat.com>
	<32418.1368781063@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87r4h2zf5y.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dhowells@redhat.com, Dave Jones <davej@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stephen Hemminger <shemminger@vyatta.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> wrote:

> The point of the patch is that it's unusable:
> 
> #define VIRTIO_PCI_CONFIG(dev)		((dev)->msix_enabled ? 24 : 20)
> 
> ie. it's accessing a member of the kernel's virtio_pci_dev structure.

Ah, okay.  In that case, zap it and see if anyone complains.

David
