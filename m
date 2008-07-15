From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout
Date: Tue, 15 Jul 2008 10:39:01 +0200
Message-ID: <20080715083901.GA25335__9745.10916644267$1216111389$gmane$org@osiris.boeblingen.de.ibm.com>
References: <487B05CE.1050508@jp.fujitsu.com>
	<20080714212026.GA6705@osiris.boeblingen.de.ibm.com>
	<487C0A76.8060401@qualcomm.com>
	<200807151810.00365.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807151810.00365.rusty@rustcorp.com.au>
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
Cc: linux-kernel@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Max Krasnyansky <maxk@qualcomm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 15, 2008 at 06:09:59PM +1000, Rusty Russell wrote:
> On Tuesday 15 July 2008 12:24:54 Max Krasnyansky wrote:
> > Heiko Carstens wrote:
> > > On Mon, Jul 14, 2008 at 11:56:18AM -0700, Jeremy Fitzhardinge wrote:
> > > This is asking for trouble... a config option to disable this would be
> > > nice. But as I don't know which problem this patch originally addresses
> > > it might be that this is needed anyway. So lets see why we need it first.
> >
> > How about this. We'll make this a sysctl, as Rusty already did, and set the
> > default to 0 which means "never timeout". That way crazy people like me who
> > care about this scenario can enable this feature.
> 
> Indeed, this was my thought too.  s390 can initialize it to zero somewhere in 
> their boot code.

Shouldn't we default to zero and let whowever wants something different
configure that via sysctl.conf?
Whatever default value > 0 you pick is likely wrong for whatever specific
usecase.
