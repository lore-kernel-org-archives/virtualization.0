From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH v3] virtio: Add platform bus driver for memory mapped
	virtio device
Date: Mon, 24 Oct 2011 14:06:00 +0100
Message-ID: <1319461560.3668.16.camel__43856.263443786$1321323078$gmane$org@hornet.cambridge.arm.com>
References: <1317841030-17758-1-git-send-email-pawel.moll@arm.com>
	<1317919843-8343-1-git-send-email-pawel.moll@arm.com>
	<1317921230.28696.102.camel@hornet.cambridge.arm.com>
	<87lisjq6tu.fsf@rustcorp.com.au>
	<1318931075.3146.285.camel@hornet.cambridge.arm.com>
	<87ty75adtb.fsf@rustcorp.com.au>
	<1319219844.5094.16.camel@hornet.cambridge.arm.com>
	<87wrbv15lp.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87wrbv15lp.fsf@rustcorp.com.au>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, "Michael S.Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2011-10-24 at 03:33 +0100, Rusty Russell wrote:
> No, that's it I think.  Please send a diff for the documentation, since
> I'm updating the LyX master and I've already applied your previous
> version.

Here it goes (below). Also do you think you would be able to merge the
driver (corresponding v4 patch follows) in the 3.2 merge window that
seems to have just opened? ;-)

Cheers!

Pawel

--- virtio-mmio.orig	2011-10-24 11:17:08.263907000 +0100
+++ virtio-mmio.tex	2011-10-24 13:58:29.752757000 +0100
@@ -59,9 +59,18 @@
 \item 0x050 | W | QueueNotify \\
 Queue notifier.\\
 Writing a queue index to this register notifies the Host that there are new buffers to process in the queue.
-\item 0x060 | W | InterruptACK \\
+\item 0x060 | R | InterruptStatus \\
+Interrupt status. \\
+Reading from this register returns a bit mask of interrupts asserted by the device. An interrupt is asserted if the corresponding bit is set, ie. equals one (1). \\
+\begin{itemize}
+\item Bit 0 | Used Ring update \\
+This interrupt is asserted when the Host has updated the Used Ring in at least one of the active virtual queues.
+\item Bit 1 | Configuration change \\
+This interrupt is asserted when configuration of the device has changed.
+\end{itemize}
+\item 0x064 | W | InterruptACK \\
 Interrupt acknowledge. \\
-Writing to this register notifies the Host that the Guest finished receiving used buffers from the device and therefore serviced an asserted interrupt. Values written to this register are currently not used, but for future extensions it must be set to one (0x1).
+Writing to this register notifies the Host that the Guest finished handling interrupts. Every bit of the value clears corresponding bit of the InterruptStatus register. \\
 \item 0x070 | RW | Status \\
 Device status. \\
 Reading from this register returns the current device status flags. \\
@@ -100,8 +109,7 @@
 The memory mapped virtio device behaves in the same way as described in p. 2.4 ``Device Operation'', with the following exceptions:
 \begin{enumerate}
 \item The device is notified about new buffers available in a queue by writing the queue index to register QueueNum instead of the virtio header in PCI I/O space (p. 2.4.1.4 ``Notifying The Device'').
-\item As the memory mapped virtio device is using single, dedicated interrupt signal, its handling is much simpler than in the PCI (MSI-X) case (p.  2.4.2 ``Receiving Used Buffer From The Device''). Therefore all the Guest interrupt handler should do after receiving used buffers is acknowledging the interrupt by writing a value to the InterruptACK register. Currently this value does not carry any meaning, but for future extensions it must be set to one (0x1).
-\item The dynamic configuration changes, as described in p. 2.4.3 ``Dealing With Configuration Changes'' are not permitted.
+\item The memory mapped virtio device is using single, dedicated interrupt signal. After receiving an interrupt, the driver must read the InterruptStatus register to check what caused the interrupt (see the register description). After the interrupt is handled, the driver must acknowledge it by writing a bit mask corresponding to the serviced interrupt to the InterruptACK register.
 \end{enumerate}
 
 \end{document}
