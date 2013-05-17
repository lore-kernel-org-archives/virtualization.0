From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_pci: fix macro exported in uapi
Date: Fri, 17 May 2013 09:39:07 +0930
Message-ID: <87wqqy8o2k.fsf@rustcorp.com.au>
References: <20130516164446.GA32007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130516164446.GA32007@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stephen Hemminger <shemminger@vyatta.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> macro VIRTIO_PCI_CONFIG except in the unlikely event userspace
> actually has a structure with a field named msix_enabled.
> Get the msix_enabled by value instead, to make it useful
> for userspace.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Macro still isn't usable, because userspace can't know whether it's the
new or old.

We need to either remove it from UAPI, or rename it to
VIRTIO_PCI_CONFIG_OFF.

Cheers,
Rusty.
