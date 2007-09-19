From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Tue, 18 Sep 2007 20:59:29 -0700
Message-ID: <46F09EA1.7060606__44308.8984968655$1190174511$gmane$org@goop.org>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<200709181257.41530.ak@suse.de>
	<1190151272.7262.175.camel@localhost.localdomain>
	<200709182352.25118.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709182352.25118.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <aliguori@us.ibm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> At least the Xen port seems to have specific requirements
> and essentially only work on xen-unstable (?) [or at least
> some very new Xen version] which probably very few
> people use.
>   

Only on 64-bit hosts, because of bugs in the 64-bit compat layer. 
32-on-32 and 64-on-64 (when its done) should work fine.

BTW, what does "xm info" say on your system that fails?  I'll try to put
a more graceful failure in there.

    J
