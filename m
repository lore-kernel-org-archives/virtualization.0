From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] Consolidate host virtualization support under
	Virtualization menu
Date: Sun, 16 Sep 2007 17:43:37 +1000
Message-ID: <1189928617.7262.98.camel__2200.54518799788$1189928809$gmane$org@localhost.localdomain>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<1189747124.7262.36.camel@localhost.localdomain>
	<20070914091921.73007c5a.randy.dunlap@oracle.com>
	<1189825504.7262.75.camel@localhost.localdomain>
	<7fac565a0709150149kf55de62q92496cf74e7b0581@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7fac565a0709150149kf55de62q92496cf74e7b0581@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Eremenko <al4321@gmail.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-09-15 at 11:49 +0300, Alexey Eremenko wrote:
> > We turn "Virtualization" into a menu, not a config option, since it's
> > actually only used as a menu.  Then we move lguest under that menu.
> 
> What about containerization bits ?
> 
> IPC_Namespaces, *_Namespaces  - I think we should evaluate adding them
> too to this menu.

Well, containerization deserves its own menu, but the question is does i
it belong under this menu?

Rusty.
