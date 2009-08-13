From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 13 Aug 2009 15:45:00 +0200
Message-ID: <200908131545.00304.arnd__13212.1846582324$1250171437$gmane$org@arndb.de>
References: <cover.1249930169.git.mst@redhat.com>
	<20090812172141.GA29966@redhat.com>
	<4A83167E.2080701@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A83167E.2080701@codemonkey.ws>
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
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 12 August 2009, Anthony Liguori wrote:
> At any rate, I'd like to see performance results before we consider 
> trying to reuse virtio code.

Yes, I agree. I'd also like to do more work on the macvlan extensions
to see if it works out without involving a socket. Passing the socket
into the vhost_net device is a nice feature of the current implementation
that we'd have to give up for something else (e.g. making the vhost
a real network interface that you can hook up to a bridge) if it were
to use virtio.

Unless I can come up with a solution that is clearly superior, I'm
taking back my objections on that part for now.

	Arnd <><
