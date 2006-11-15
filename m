From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Wed, 15 Nov 2006 00:21:00 -0800
Message-ID: <455ACDEC.7010808@vmware.com>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
	<20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com>
	<200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com>
	<20061030225016.GA95732@muc.de>
	<20061115080323.GK1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061115080323.GK1397@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Andi Kleen (ak@muc.de) wrote:
>   =

>> On Mon, Oct 30, 2006 at 12:54:55PM -0800, Zachary Amsden wrote:
>>     =

>>> Andi Kleen wrote:
>>>       =

>>>> no_timer_check. But it's only there on x86-64 in mainline - although t=
here
>>>> were some patches to add it to i386 too.
>>>>  =

>>>>         =

>>> I can rename to match the x86-64 name.
>>>       =

>> I will do that in my tree.
>>     =

>
> Looks like this one might have been lost.  Here's the renamed version
> (it's against 2.6.19-rc5-mm2, which should have your tree in it).
>
> thanks,
> -chris
>   =


Thanks Chris, this is definitely a required patch for us.

I'm a little worried after seeing failures to apply and missed patches =

that we could have other things missing from the upstream path.  Is =

there an easy way for us to look at diffs between the trees?  Just a =

diff on arch/i386 and include/asm-i386 would tell me wonders, no matter =

how much extra activity has gone on there.

Namaste,

Zach
