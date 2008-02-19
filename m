From: Ravikiran Thirumalai <kiran@scalemp.com>
Subject: Re: [PATCH 4/5] [PATCH] introduce paravirt helpers
Date: Tue, 19 Feb 2008 11:59:52 -0800
Message-ID: <20080219195951.GU6209@localdomain>
References: <1202757365-18634-1-git-send-email-gcosta@redhat.com>
	<1202757365-18634-2-git-send-email-gcosta@redhat.com>
	<1202757365-18634-3-git-send-email-gcosta@redhat.com>
	<1202757365-18634-4-git-send-email-gcosta@redhat.com>
	<20080217180509.GW6006@elte.hu>
	<5d6222a80802171256l6e178eb8h1080bfd5a6b95ef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5d6222a80802171256l6e178eb8h1080bfd5a6b95ef3@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <glommer@gmail.com>
Cc: ehabkost@redhat.com, shai@scalemp.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Glauber Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, Ingo Molnar <mingo@elte.hu>, virtualization@lists.linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Feb 17, 2008 at 06:56:56PM -0200, Glauber Costa wrote:
>On Feb 17, 2008 4:05 PM, Ingo Molnar <mingo@elte.hu> wrote:
>>
>> * Glauber Costa <gcosta@redhat.com> wrote:
>>
>> >  config X86_VSMP
>> >       bool "Support for ScaleMP vSMP"
>> >       depends on X86_64 && PCI
>> > -      help
>> > +     select PARAVIRT
>> > +     help
>>
>> hm, what's the idea here?
>
>guys from scalemp can probably give a better picture if needed,
>but in a nutshell, there are two aspects involved with the vsmp
>support. The first one
>is special L1 alignments, and the second, specialized irq handling routines.
>
>Only the second one is paravirt in itself, and are the ones addressed
>in this patch.
>The specialized routines now goes through paravirt ops. So when using
>a vsmp machine,
>paravirt has to be selected, in order to enable such functions.

Thanks Glauber.  Well put.

That said, future revs of vSMP will have the ability to work optimally even
without the paravirtualized irq ops.  This is an upcoming feature, and did not
exist when we tested the paravirt ops 2-3 months ago.  So, it will be
better, now, not to select PARAVIRT while selecting X86_VSMP.  Then,
CONFIG_VSMP will just select the cacheline padding to be used and PARAVIRT
will be needed if irq operations need to be paravirtualized.

I shall submit a patch to that effect.

Thanks,
Kiran
