From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-blk: Fix kconfig option
Date: Wed, 5 Sep 2012 09:12:19 +0300
Message-ID: <20120905061219.GC7517@redhat.com>
References: <20120903044133.GA9980@moria.home.lan>
	<87wr0ae26e.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wr0ae26e.fsf@rustcorp.com.au>
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
Cc: Kent Overstreet <koverstreet@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 04, 2012 at 03:53:53PM +0930, Rusty Russell wrote:
> Kent Overstreet <koverstreet@google.com> writes:
> 
> > CONFIG_VIRTIO isn't exposed, everything else is supposed to select it
> > instead.
> 
> This is a slight mis-understanding.  It's supposed to be selected by
> the particular driver, probably virtio_pci in your case.
> 
> Cheers,
> Rusty.

Actually balloon selects VIRTIO, I think it's a bug.
Also isn't it time we dropped the experimental tag?
Leaving it in for now.

-->

virtio-balloon: dependency fix

Devices should depend on virtio, not select it.  It's supposed to be
selected by the particular driver, e.g. VIRTIO_PCI.
Make balloon depend on VIRTIO and EXPERIMENTAL
(to match description).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

--

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index f38b17a..564bb64 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -27,8 +27,7 @@ config VIRTIO_PCI
 
 config VIRTIO_BALLOON
 	tristate "Virtio balloon driver (EXPERIMENTAL)"
-	select VIRTIO
-	select VIRTIO_RING
+	depends on EXPERIMENTAL && VIRTIO
 	---help---
 	 This driver supports increasing and decreasing the amount
 	 of memory within a KVM guest.
