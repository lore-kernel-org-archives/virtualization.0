From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
Date: Mon, 31 Mar 2014 12:50:26 +0200
Message-ID: <20140331125026.0120eef7__19747.2352222123$1396282318$gmane$org@hananiah.suse.cz>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
	<1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
	<87lidwtego.fsf@xmission.com>
	<20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
	<87txshx28b.fsf@xmission.com> <50AE6542.3020302@zytor.com>
	<50AE69EF.4060909@citrix.com>
	<09b41677-c9e7-4cd4-84a0-a1cb483d551d@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <09b41677-c9e7-4cd4-84a0-a1cb483d551d@email.android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 22 Nov 2012 14:26:10 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> Bullshit.  This should be a separate domain.

Thanks for top-posting, hpa...

> Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> 
> >On 22/11/12 17:47, H. Peter Anvin wrote:
> >> The other thing that should be considered here is how utterly 
> >> preposterous the notion of doing in-guest crash dumping is in a
> >system 
> >> that contains a hypervisor.  The reason for kdump is that on bare
> >metal 
> >> there are no other options, but in a hypervisor system the right
> >thing 
> >> should be for the hypervisor to do the dump (possibly spawning a
> >clean 
> >> I/O domain if the I/O domain is necessary to access the media.)
> >>
> >> There is absolutely no reason to have a crashkernel sitting around in
> >
> >> each guest, consuming memory, and possibly get corrupt.
> >>
> >> 	-hpa
> >>
> >
> >I agree that regular guests should not be using the kexec/kdump. 
> >However, this patch series is required for allowing a pvops kernel to
> >be
> >a crash kernel for Xen, which is very important from dom0/Xen's point
> >of
> >view.

In fact, a normal kernel is used for dumping, so it can handle both,
Dom0 crashes _and_ hypervisor crashes. If you wanted to address
hypervisor crashes, you'd have to allocate some space for that, too, so
you may view this "madness" as a way to conserve resources.

The memory area is reserved by the Xen hypervisor, and only the extents
are passed down to the Dom0 kernel. In other words, there is indeed no
physical mapping for this area.

Having said that, I see no reason why that physical mapping cannot be
created if it is needed.

Petr T
