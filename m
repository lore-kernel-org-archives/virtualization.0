From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout
Date: Tue, 15 Jul 2008 08:09:24 +0200
Message-ID: <20080715060923.GA4669__18818.7538100921$1216102358$gmane$org@osiris.boeblingen.de.ibm.com>
References: <487B05CE.1050508@jp.fujitsu.com>
	<200807141351.25092.borntraeger@de.ibm.com>
	<200807142234.40700.rusty@rustcorp.com.au>
	<487BA152.1070102@goop.org>
	<20080714212026.GA6705@osiris.boeblingen.de.ibm.com>
	<487C0A76.8060401@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <487C0A76.8060401@qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

> >> So I think monotonic wallclock time actually makes the most sense here.
> > 
> > This is asking for trouble... a config option to disable this would be
> > nice. But as I don't know which problem this patch originally addresses
> > it might be that this is needed anyway. So lets see why we need it first.
> How about this. We'll make this a sysctl, as Rusty already did, and set the
> default to 0 which means "never timeout". That way crazy people like me who
> care about this scenario can enable this feature.

Yes, sounds like that should work for everyone and no additional config
option as well. Sounds good to me.
