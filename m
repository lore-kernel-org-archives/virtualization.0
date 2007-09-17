From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 2/3] Consolidate host virtualization support
	under	Virtualization menu
Date: Mon, 17 Sep 2007 12:31:20 -0700
Message-ID: <1190057480.5982.157.camel__42003.3562616029$1190057634$gmane$org@bodhitayantram.eng.vmware.com>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<1189747124.7262.36.camel@localhost.localdomain>
	<20070914091921.73007c5a.randy.dunlap@oracle.com>
	<1189825504.7262.75.camel@localhost.localdomain>
	<7fac565a0709150149kf55de62q92496cf74e7b0581@mail.gmail.com>
	<1189928617.7262.98.camel@localhost.localdomain>
	<46ED440E.3020209@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46ED440E.3020209@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-09-16 at 07:56 -0700, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > Well, containerization deserves its own menu, but the question is does i
> > it belong under this menu?
> 
> No, I don't think so.  While there are some broad similarities in
> effect, the technology is completely different, as are the capabilities
> and tradeoffs.  They're pretty much orthogonal.

It seems to me containerization is much more similar a feature to SYSV
IPC, process accounting / auditing, and should be an option under
General setup, possibly with its own submenu.  Nearly all the features
under general setup provide optional extensions to kernel services
available from userspace, and so it seems containerization falls
naturally into that category.

Virtualization is completely different, and probably needs separate
server (kvm, lguest) and client (kvm, lguest, xen, vmware) sections in
it's menu.

Zach
