From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/3] Consolidate host virtualization support
 under	Virtualization menu
Date: Sun, 16 Sep 2007 07:56:14 -0700
Message-ID: <46ED440E.3020209__23342.9898195483$1189954704$gmane$org@goop.org>
References: <1189747054.7262.34.camel@localhost.localdomain>	<1189747124.7262.36.camel@localhost.localdomain>	<20070914091921.73007c5a.randy.dunlap@oracle.com>	<1189825504.7262.75.camel@localhost.localdomain>	<7fac565a0709150149kf55de62q92496cf74e7b0581@mail.gmail.com>
	<1189928617.7262.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1189928617.7262.98.camel@localhost.localdomain>
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
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Well, containerization deserves its own menu, but the question is does i
> it belong under this menu?

No, I don't think so.  While there are some broad similarities in
effect, the technology is completely different, as are the capabilities
and tradeoffs.  They're pretty much orthogonal.

    J
