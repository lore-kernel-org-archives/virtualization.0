From: "Alexey Eremenko" <al4321@gmail.com>
Subject: Re: [PATCH 2/3] Consolidate host virtualization support under
	Virtualization menu
Date: Wed, 19 Sep 2007 07:38:23 -0200
Message-ID: <7fac565a0709190238i78a09ab1y1f935cf3023cbe5e__27888.1340208047$1190195224$gmane$org@mail.gmail.com>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<20070914091921.73007c5a.randy.dunlap@oracle.com>
	<1189825504.7262.75.camel@localhost.localdomain>
	<7fac565a0709150149kf55de62q92496cf74e7b0581@mail.gmail.com>
	<1189928617.7262.98.camel@localhost.localdomain>
	<46ED440E.3020209@goop.org>
	<1190057480.5982.157.camel@bodhitayantram.eng.vmware.com>
	<46EF0E0A.2000804@thewybles.com> <46EF1952.3010604@goop.org>
	<46F030DD.7080201@thewybles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F030DD.7080201@thewybles.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 9/18/07, Charles N Wyble <charles@thewybles.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> > "Host" and "guest" are better terms, I think.  Kvm is all host, since
> > guests need no modification.  lguest turns the kernel into both host and
> > guest.  Xen Linux kernels are all guest, since the Xen hypervisor is the
> > host.
> >

Yes, I also prefer terms like "Host" and "Guest". Those terms are more
correct than "Server" and "Client", which are often reffered to
TCP/UDP port listening and network connection.

-- 
-Alexey Eremenko "Technologov"
