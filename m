From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] RFC: Network Plugin Architecture (NPA) for vmxnet3
Date: Wed, 5 May 2010 13:36:31 -0700
Message-ID: <201005051336.32712.dtor__21733.7731075988$1273097832$gmane$org@vmware.com>
References: <20100504230225.GP8323@vmware.com>
	<F1354E79A137A24CBA60059AA65CB1B802A235C535@EXCH-MBX-2.vmware.com>
	<201005052209.48465.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201005052209.48465.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Pankaj Thakkar <pthakkar@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 05 May 2010 01:09:48 pm Arnd Bergmann wrote:
> > > If you have any interesting in developing this further, do:
> > > 
> > >  (1) move the limited VF drivers directly into the kernel tree,
> > >      talk to them through a normal ops vector
> > 
> > [PT] This assumes that all the VF drivers would always be available.
> > Also we have to support windows and our current design supports it
> > nicely in an OS agnostic manner.
> 
> Your approach assumes that the plugin is always available, which has
> exactly the same implications.

Since plugin[s] are carried by the host they are indeed always
available.

-- 
Dmitry
