From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 1/3] virtio interface
Date: Tue, 25 Sep 2007 20:54:58 +1000
Message-ID: <1190717698.27805.328.camel__49946.1881853223$1190717848$gmane$org@localhost.localdomain>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<200709250018.12705.arnd@arndb.de>
	<1190677058.27805.225.camel@localhost.localdomain>
	<200709250836.29451.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709250836.29451.arnd@arndb.de>
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
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-09-25 at 08:36 +0200, Arnd Bergmann wrote:
> On Tuesday 25 September 2007, Rusty Russell wrote:
> > I don't mind: we could expose it.
> 
> What I mean with setting the parent appropriately is not to have a global
> device that is used by the hv-specific probing code, but to make sure
> that each of them provides their own one. The bus_type should either be
> global or provide the wrappers for device_register and driver_register
> that you have, but the host bridge device belongs with the code that
> probes it. E.g. when all virtio devices are behind PCI bridges, there
> does not need to be an empty /virtio or /lguest device node at all.

Right, that makes sense.  I'll shift this "virtio" device node out to
the lguest code.

Thanks!
Rusty.
