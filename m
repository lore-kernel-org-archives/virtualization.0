From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH 2/3] Consolidate host virtualization support under
 Virtualization menu
Date: Fri, 14 Sep 2007 22:01:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709142201110.10168__13119.7877497927$1189801980$gmane$org@fbirervta.pbzchgretzou.qr>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<1189747124.7262.36.camel@localhost.localdomain>
	<20070914091921.73007c5a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070914091921.73007c5a.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


On Sep 14 2007 09:19, Randy Dunlap wrote:
>On Fri, 14 Sep 2007 15:18:44 +1000 Rusty Russell wrote:
>
>> We turn "Virtualization" into a menu, not a config option, since it's
>> actually only used as a menu.  Then we move lguest under that menu.

Whatever, keep it as menuconfig. I want to disable it _at once_
without having to enter the menu, which is the primary motivation
having it as 'menuconfig'.


	Jan
-- 
