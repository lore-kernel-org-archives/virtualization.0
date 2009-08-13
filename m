From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 13 Aug 2009 15:48:35 +0200
Message-ID: <200908131548.35199.arnd__31564.4304654144$1250171508$gmane$org@arndb.de>
References: <cover.1249930169.git.mst@redhat.com>
	<20090813060615.GC3029@redhat.com>
	<200908131538.44465.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200908131538.44465.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 13 August 2009, Arnd Bergmann wrote:
> Unfortunately, this also implies that you could no longer simply use the
> packet socket interface as you do currently, as I realized only now.
> This obviously has a significant impact on your user space interface.

Also, if we do the copy in the transport, it definitely means that we
can't get to zero-copy RX/TX from guest space any more. The current
vhost_net driver doesn't do that yet, but could be extended in the
same way that I'm hoping to do it for macvtap.

	Arnd <><
