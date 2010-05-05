From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Pv-drivers] RFC: Network Plugin Architecture (NPA) for vmxnet3
Date: Wed, 5 May 2010 22:09:48 +0200
Message-ID: <201005052209.48465.arnd__34072.0120970674$1273094683$gmane$org@arndb.de>
References: <20100504230225.GP8323@vmware.com>
	<20100505173951.GA8388@infradead.org>
	<F1354E79A137A24CBA60059AA65CB1B802A235C535@EXCH-MBX-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <F1354E79A137A24CBA60059AA65CB1B802A235C535@EXCH-MBX-2.vmware.com>
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
Cc: Christoph Hellwig <hch@infradead.org>, Dmitry Torokhov <dtor@vmware.com>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pankaj Thakkar <pthakkar@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 05 May 2010 19:47:10 Pankaj Thakkar wrote:
> > 
> > Forget about the licensing.  Loading binary blobs written to a shim
> > layer is a complete pain in the ass and totally unsupportable, and
> > also uninteresting because of the overhead.
> 
> [PT] Why do you think it is unsupportable? How different is it from any module
> written against a well maintained interface? What overhead are you talking about?

We have the right number of module loaders in the kernel: one. If you
add another one, you're doubling the amount of code that anyone
working on that code needs to know about.
 
> > If you have any interesting in developing this further, do:
> > 
> >  (1) move the limited VF drivers directly into the kernel tree,
> >      talk to them through a normal ops vector
> [PT] This assumes that all the VF drivers would always be available.
> Also we have to support windows and our current design supports it
> nicely in an OS agnostic manner.

Your approach assumes that the plugin is always available, which has
exactly the same implications.

> >  (2) get rid of the whole shim crap and instead integrate the limited
> >      VF driver with the full VF driver we already have, instead of
> >      duplicating the code
> [PT] Having a full VF driver adds a lot of dependency on the guest VM
> and this is what NPA tries to avoid.

If you have the limited driver for some hardware that does not have
the real thing, we could still ship just that. I would however guess
that most vendors are interested in not just running in vmware but
also other hypervisors that still require the full driver, so that
case would be rare, especially in the long run.

	Arnd
