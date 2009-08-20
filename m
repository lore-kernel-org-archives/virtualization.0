From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 20 Aug 2009 17:10:31 +0200
Message-ID: <200908201710.31723.arnd__27259.5048103996$1250781863$gmane$org@arndb.de>
References: <cover.1250187913.git.mst@redhat.com>
	<200908201631.37285.arnd@arndb.de>
	<20090820144256.GB8338@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090820144256.GB8338@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 20 August 2009, Michael S. Tsirkin wrote:
> 
> > The errors from the socket (or chardev, as that was the
> > start of the argument) should still fit into the categories
> > that I mentioned, either they can be handled by the host
> > kernel, or they are fatal.
> 
> Hmm, are you sure? Imagine a device going away while socket is bound to
> it.  You get -ENXIO. It's not fatal in a sense that you can bind the
> socket to another device and go on, right?

Right. Not fatal in that sense, but fatal in the sense that I
can no longer transmit other frames until you recover. I think
we both meant the same here.

	Arnd <><
