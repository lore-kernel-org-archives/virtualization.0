From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: [PATCH] x86/pvclock-xen: zero last_value on resume
Date: Wed, 27 Oct 2010 11:53:18 -0700
Message-ID: <4CC8751E.40306__12459.3107648709$1288205728$gmane$org@goop.org>
References: <4CC708DE.1070000@goop.org>
	<1288115334.3530.7.camel@mothafucka.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1288115334.3530.7.camel@mothafucka.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <glommer@redhat.com>
Cc: "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>, kvm-devel <kvm@vger.kernel.org>, Eelco Dolstra <e.dolstra@tudelft.nl>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Olivier Hanesse <olivier.hanesse@gmail.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

 On 10/26/2010 10:48 AM, Glauber Costa wrote:
> On Tue, 2010-10-26 at 09:59 -0700, Jeremy Fitzhardinge wrote:
>> If the guest domain has been suspend/resumed or migrated, then the
>> system clock backing the pvclock clocksource may revert to a smaller
>> value (ie, can be non-monotonic across the migration/save-restore).
>> Make sure we zero last_value in that case so that the domain
>> continues to see clock updates.
>>
>> [ I don't know if kvm needs an analogous fix or not. ]
> After migration, save/restore, etc, we issue an ioctl where we tell
> the host the last clock value. That (in theory) guarantees monotonicity.
>
> I am not opposed to this patch in any way, however.

Thanks.

HPA, do you want to take this, or shall I send it on?

Thanks,
    J
