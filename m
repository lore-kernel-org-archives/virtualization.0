From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 20 Aug 2009 16:31:36 +0200
Message-ID: <200908201631.37285.arnd__24288.4780899205$1250778976$gmane$org@arndb.de>
References: <cover.1250187913.git.mst@redhat.com>
	<200908201510.54482.arnd@arndb.de>
	<20090820133817.GA7834@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090820133817.GA7834@redhat.com>
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
> On Thu, Aug 20, 2009 at 03:10:54PM +0200, Arnd Bergmann wrote:
> > On Thursday 20 August 2009, Michael S. Tsirkin wrote:
>
> It doesn't matter that I don't want this: allowing 1 process corrupt
> another's memory is a security issue.  Once you get an fd, you want to
> be able to use it without worrying that a bug in another process will
> crash yours.

Ok, got it. Yes, that would be inacceptable.

> > > If you assume losing the code for the second error condition is OK, why
> > > is the first one so important?  That's why I used a counter (eventfd)
> > > per virtqueue, on error userspace can scan the ring and poll the socket
> > > and discover what's wrong, and counter ensures we can detect that error
> > > happened while we were not looking.
> > 
> > I guess we were talking about different kinds of errors here, and I'm
> > still not sure which one you are talking about.
> > 
> Non fatal errors. E.g. translation errors probably should be
> non-fatal. I can also imagine working around guest bugs in
> userspace.

Ah, so I guess the confusion was that I was worried about
errors coming from the socket file descriptor, while you
were thinking of errors from the guest side, which I did not
expect to happen.

The errors from the socket (or chardev, as that was the
start of the argument) should still fit into the categories
that I mentioned, either they can be handled by the host
kernel, or they are fatal.

I'll read up in your code to see how you handle asynchronous
non-fatal errors from the guest. Intuitively, I'd still
assume that returning the first error should be enough
because it will typically mean that you cannot continue
without fixing it up first, and you might get the next
error immediately after that.

	Arnd <><
