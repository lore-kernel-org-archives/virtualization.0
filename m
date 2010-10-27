From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Xen-devel] Re: [PATCH] x86/pvclock-xen: zero last_value on resume
Date: Wed, 27 Oct 2010 13:59:54 -0700
Message-ID: <95805e88-b6d5-4ae2-9351-9e458656cfb8__14678.236997179$1288213352$gmane$org@email.android.com>
References: <4CC708DE.1070000@goop.org>
	<1288115334.3530.7.camel@mothafucka.localdomain>
	<4CC8751E.40306@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CC8751E.40306@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Glauber Costa <glommer@redhat.com>
Cc: "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>, kvm-devel <kvm@vger.kernel.org>, Eelco Dolstra <e.dolstra@tudelft.nl>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Olivier Hanesse <olivier.hanesse@gmail.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

I'll check it this evening when I'm at a working network again :(

"Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

> On 10/26/2010 10:48 AM, Glauber Costa wrote:
>> On Tue, 2010-10-26 at 09:59 -0700, Jeremy Fitzhardinge wrote:
>>> If the guest domain has been suspend/resumed or migrated, then the
>>> system clock backing the pvclock clocksource may revert to a smaller
>>> value (ie, can be non-monotonic across the migration/save-restore).
>>> Make sure we zero last_value in that case so that the domain
>>> continues to see clock updates.
>>>
>>> [ I don't know if kvm needs an analogous fix or not. ]
>> After migration, save/restore, etc, we issue an ioctl where we tell
>> the host the last clock value. That (in theory) guarantees
>monotonicity.
>>
>> I am not opposed to this patch in any way, however.
>
>Thanks.
>
>HPA, do you want to take this, or shall I send it on?
>
>Thanks,
>    J

-- 
Sent from my mobile phone.  Please pardon any lack of formatting.
