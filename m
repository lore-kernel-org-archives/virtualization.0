From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] virtio_pci: fix macro exported in uapi
Date: Fri, 17 May 2013 09:57:43 +0100
Message-ID: <32418.1368781063@warthog.procyon.org.uk>
References: <87wqqy8o2k.fsf@rustcorp.com.au>
	<20130516164446.GA32007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87wqqy8o2k.fsf@rustcorp.com.au>
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

> Macro still isn't usable, because userspace can't know whether it's the
> new or old.
> 
> We need to either remove it from UAPI, or rename it to
> VIRTIO_PCI_CONFIG_OFF.

Surely, if userspace is using it as is, you can't remove it, rename it or
alter it?

David
