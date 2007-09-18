From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/3] Consolidate host virtualization
 support	under	Virtualization menu
Date: Mon, 17 Sep 2007 17:18:26 -0700
Message-ID: <46EF1952.3010604__41847.8221669377$1190074826$gmane$org@goop.org>
References: <1189747054.7262.34.camel@localhost.localdomain>	<1189747124.7262.36.camel@localhost.localdomain>	<20070914091921.73007c5a.randy.dunlap@oracle.com>	<1189825504.7262.75.camel@localhost.localdomain>	<7fac565a0709150149kf55de62q92496cf74e7b0581@mail.gmail.com>	<1189928617.7262.98.camel@localhost.localdomain>	<46ED440E.3020209@goop.org>
	<1190057480.5982.157.camel@bodhitayantram.eng.vmware.com>
	<46EF0E0A.2000804@thewybles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46EF0E0A.2000804@thewybles.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Charles N Wyble <charles@thewybles.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Charles N Wyble wrote:
>
>
> Zachary Amsden wrote:
> <snip>>
> > Virtualization is completely different, and probably needs separate
> > server (kvm, lguest) and client (kvm, lguest, xen, vmware) sections in
> > it's menu.
>
>
> So what is the differentiation between client and server above? Just
> curious what makes kvm and lguest server and client.

"Host" and "guest" are better terms, I think.  Kvm is all host, since
guests need no modification.  lguest turns the kernel into both host and
guest.  Xen Linux kernels are all guest, since the Xen hypervisor is the
host.

    J
