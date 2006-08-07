From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 4/4] x86 paravirt_ops: binary patching infrastructure
Date: Sun, 06 Aug 2006 22:56:26 -0700
Message-ID: <44D6D60A.5040108@goop.org>
References: <1154925835.21647.29.camel@localhost.localdomain>	<1154926048.21647.35.camel@localhost.localdomain>	<1154926114.21647.38.camel@localhost.localdomain>
	<200608070738.13768.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200608070738.13768.ak@muc.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>>  =

>> +#ifdef CONFIG_PARAVIRT
>> +void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch=
 *end)
>>     =

>
> It would be better to merge this with the existing LOCK prefix patching
> or perhaps the normal alternative() patcher (is there any particular
> reason you can't use it?)
>
> Three alternative patching mechanisms just seems to be too many

The difference is that every hypervisor wants its own patched =

instruction sequence, which may require a specialized patching =

mechanism.  If you're simply patching in calls, then it isn't a big =

deal, but you may also want to patch in real inlined code for some =

operations (like sti/cli equivalents).  The alternatives are to allow =

each backend to deal with its own patching (perhaps with common =

functions abstracted out as they appear), or have a common set of =

patching machinery which can deal with all users.  The former seems simpler.

    J
