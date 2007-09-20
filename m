From: Satyam Sharma <satyam@infradead.org>
Subject: Re: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Thu, 20 Sep 2007 22:17:27 +0530 (IST)
Message-ID: <alpine.LFD.0.999.0709202207360.19354__22521.3779522621$1190306814$gmane$org@enigma.security.iitk.ac.in>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<200709181257.41530.ak@suse.de> <46F02F50.5000001@thewybles.com>
	<200709182220.27311.ak@suse.de> <46F034A8.2070801@thewybles.com>
	<alpine.LFD.0.999.0709202110150.18597@enigma.security.iitk.ac.in>
	<46F29B4B.2070200@thewybles.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F29B4B.2070200@thewybles.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On Thu, 20 Sep 2007, Charles N Wyble wrote:
> 
> Satyam Sharma wrote:
> > 
> > On Tue, 18 Sep 2007, Charles N Wyble wrote:
> >> Andi Kleen wrote:
> >>> Besides it's bad taste and taste is very important.
> >> Well it's bad taste for you (one person).
> > 
> > FWIW, my opinion is the same as Andi's here. Please, let's avoid this
> > disease -- unless *absolutely* required, stuff shouldn't be "default y".
> 
> I am curious why you think it shouldn't be default why? Bad taste? Can
> you provide data about how it will harm things?

Clear CONFIG_PARAVIRT from your .config and try "make oldconfig", and find
out for yourself :-)

You'll end up having to answer questions for all other config options
below it, that you never cared about, that you didn't know even existed.
You'd obviously (I would, at least) feel annoyed by it all ... this is
almost a regression :-)

And for those who automate the oldconfig process using "yes", well, this
"default y" *will* end up introducing a kernel text size regression --
all those config options they never had earlier, suddenly got enabled.

Besides, like Andi said, selecting or enabling CONFIG_PARAVIRT is quite
pointless in the first place -- it's just a menuconfig symbol, not a
"real" kconfig symbol that _actually_ controls code in the Makefiles.


Satyam
