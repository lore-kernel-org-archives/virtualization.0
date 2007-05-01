From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Tue, 01 May 2007 01:03:38 -0700
Message-ID: <4636F45A.50003__41970.617141533$1178006668$gmane$org@goop.org>
References: <20070428758.455116000@suse.de>	
	<20070428175909.1D09D151CA@wotan.suse.de>
	<46338D72.70402@garzik.org>	
	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com>
	<4634483E.9030307@goop.org>	
	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>	
	<1177902195.30071.203.camel@localhost.localdomain>	
	<463572B7.90202@zytor.com>	
	<1177909434.30071.216.camel@localhost.localdomain>	
	<m1ejm16flv.fsf@ebiederm.dsl.xmission.com>	
	<1177990722.28659.39.camel@localhost.localdomain>	
	<m18xc919im.fsf@ebiederm.dsl.xmission.com>
	<4636D200.3010406@goop.org>
	<1178004868.28659.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1178004868.28659.57.camel@localhost.localdomain>
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
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Well there aren't that many instructions between startup_32 and
> lguest_init at the moment, but I guess if we end up going through
> bzImage decompression it makes more sense...

Yes, that's what I was thinking.  If we boot compressed kernels in a
novel environment, there's going to be plenty of early debugging going
on.  Fortunately for me, I can just start it up under gdb, so it isn't
all that arduous.

    J
