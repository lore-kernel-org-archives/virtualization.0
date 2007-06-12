From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Xen-devel] Re: More virtio users
Date: Tue, 12 Jun 2007 10:47:28 +1000
Message-ID: <1181609248.14818.244.camel@localhost.localdomain>
References: <466BA965.6050208@qumranet.com>
	<1181463220.16428.24.camel@localhost.localdomain>
	<466D04C2.8010403@redhat.com>
	<1181603983.16428.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181603983.16428.100.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-06-12 at 09:19 +1000, Rusty Russell wrote:
> > Rectangles work just fine for a framebuffer console.  They stop
> working 
> > once you plan to run any graphical stuff such as an X-Server on top
> of 
> > the framebuffer.  Only way to get notified about changes is page
> faults, 
> > i.e. 4k granularity on the linear framebuffer memory.
> 
> Yes, I discussed this with Ben Herrenschmidt a couple of months ago.
> It
> would be better to provide a fb ioctl which X could use to describe
> changed rectangles if available.  In the virtio case we could hand
> that
> information through, and other virtualized framebuffers would be able
> to
> use it similarly.

Yes, with the X damage extension, we can have precise notification of
changed areas.

Ben.
