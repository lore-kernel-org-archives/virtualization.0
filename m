From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86/pvclock-xen: zero last_value on resume
Date: Fri, 26 Nov 2010 11:40:47 +0100
Message-ID: <20101126104047.GA9798__17280.1987770528$1290768274$gmane$org@elte.hu>
References: <4CC708DE.1070000@goop.org>
 <4CEACFAB.90503@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4CEACFAB.90503@goop.org>
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
Cc: "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>, kvm-devel <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Olivier Hanesse <olivier.hanesse@gmail.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Eelco Dolstra <e.dolstra@tudelft.nl>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> On 10/26/2010 09:59 AM, Jeremy Fitzhardinge wrote:
> >
> > If the guest domain has been suspend/resumed or migrated, then the
> > system clock backing the pvclock clocksource may revert to a smaller
> > value (ie, can be non-monotonic across the migration/save-restore).
> > Make sure we zero last_value in that case so that the domain
> > continues to see clock updates.
> 
> Ping?  Looks like this fell through the gaps.

Does not apply cleanly here - mind resending the latest version?

Thanks,

	Ingo
