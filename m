From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Wed, 19 Sep 2007 11:43:00 +0100
Message-ID: <1190198580.13585.34.camel@localhost.localdomain>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<200709181257.41530.ak@suse.de>
	<1190151272.7262.175.camel@localhost.localdomain>
	<200709182352.25118.ak@suse.de>  <46F09EA1.7060606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F09EA1.7060606@goop.org>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-09-18 at 20:59 -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > At least the Xen port seems to have specific requirements
> > and essentially only work on xen-unstable (?) [or at least
> > some very new Xen version] which probably very few
> > people use.
> >   
> 
> Only on 64-bit hosts, because of bugs in the 64-bit compat layer. 
> 32-on-32 and 64-on-64 (when its done) should work fine.

All the required fixes for 32on64 are queued for Xen 3.1.1 too. The
proposed updates are at
http://xenbits.xensource.com/xen-3.1-testing.pq.hg

Ian.

-- 
Ian Campbell
Current Noise: Detonation - Sword-Carved Skin

The executioner is, I hear, very expert, and my neck is very slender.
		-- Anne Boleyn
