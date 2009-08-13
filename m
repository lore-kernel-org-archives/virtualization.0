From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 13 Aug 2009 16:53:46 +0200
Message-ID: <200908131653.47029.arnd__13794.1449917436$1250175387$gmane$org@arndb.de>
References: <cover.1249930169.git.mst@redhat.com>
	<200908131548.35199.arnd@arndb.de>
	<20090813144129.GB5080@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090813144129.GB5080@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 13 August 2009, Michael S. Tsirkin wrote:
> The best way to do this IMO would be to add zero copy support to raw
> sockets, vhost will then get it basically for free.

Yes, that would be nice. I wonder if that could lead to security
problems on TX though. I guess It will only bring significant performance
improvements if we leave the data writable in the user space or guest
during the operation. If the user finds the right timing, it could
modify the frame headers after they have been checked using netfilter,
or while the frames are being consumed in the kernel (e.g. an NFS
server running in a guest).

	Ardn <><
