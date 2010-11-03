From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [Xen-devel] Re: [PATCH] x86/pvclock-xen: zero last_value on resume
Date: Wed, 03 Nov 2010 12:46:34 +0000
Message-ID: <1288788394.9309.2.camel__49368.0475083694$1288788492$gmane$org@cthulhu.hellion.org.uk>
References: <4CC708DE.1070000@goop.org>
	<1288115334.3530.7.camel@mothafucka.localdomain>
	<4CC8751E.40306@goop.org>
	<95805e88-b6d5-4ae2-9351-9e458656cfb8@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <95805e88-b6d5-4ae2-9351-9e458656cfb8@email.android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>, kvm-devel <kvm@vger.kernel.org>, Dolstra <e.dolstra@tudelft.nl>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Hanesse <olivier.hanesse@gmail.com>, Eelco@smtp1.linux-foundation.org, Olivier@smtp1.linux-foundation.org, Linux@smtp1.linux-foundation.org, Glauber Costa <glommer@redhat.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2010-10-27 at 13:59 -0700, H. Peter Anvin wrote:
> I'll check it this evening when I'm at a working network again :(

Did this get applied? It seems to affect 2.6.32.x too
(http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=602273) so can we tag
it for stable as well?

Thanks,
Ian.

> 
> "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
> 
> > On 10/26/2010 10:48 AM, Glauber Costa wrote:
> >> On Tue, 2010-10-26 at 09:59 -0700, Jeremy Fitzhardinge wrote:
> >>> If the guest domain has been suspend/resumed or migrated, then the
> >>> system clock backing the pvclock clocksource may revert to a smaller
> >>> value (ie, can be non-monotonic across the migration/save-restore).
> >>> Make sure we zero last_value in that case so that the domain
> >>> continues to see clock updates.
> >>>
> >>> [ I don't know if kvm needs an analogous fix or not. ]
> >> After migration, save/restore, etc, we issue an ioctl where we tell
> >> the host the last clock value. That (in theory) guarantees
> >monotonicity.
> >>
> >> I am not opposed to this patch in any way, however.
> >
> >Thanks.
> >
> >HPA, do you want to take this, or shall I send it on?
> >
> >Thanks,
> >    J
> 

-- 
Ian Campbell

BOFH excuse #191:

Just type 'mv * /dev/null'.
