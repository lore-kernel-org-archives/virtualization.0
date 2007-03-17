From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: todo
Date: Fri, 16 Mar 2007 21:00:33 -0700
Message-ID: <45FB67E1.8040104@goop.org>
References: <20070317020011.GS10574@sequoia.sous-sol.org>
	<45FB5707.3010809@goop.org>
	<20070317033452.GU10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070317033452.GU10574@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
>   =

>> Chris Wright wrote:
>>     =

>>> Consistently wrap paravirt ops callsites
>>> 	"ugh" - mingo
>>>       =

>> Had a thought.  What if we do a kind of reverse/two-way module linkage? =

>> Somehow compile each pv-op implementation like a module, and then link
>> the appropriate one in at boot time.
>>     =

>
> This is very similar to something Steve was chatting with me about
> this morning.  The idea he was tossing around was something a bit like
> an initrd that a load_module analog could link up.  In a sense, it's
> similar to the VMI ROM, with the exceptions that the ABI is just created
> by the compiler from a normal mutable kernel API and it's linkage with
> symbols available on both sides.
>   =


Yeah.  It would have to happen a lot earlier than initrd.  It would be
more like a multiboot kernel module or something.

>> Tricky parts: it would need two-way unresolved references between kernel
>> and module, and it would need to be able to run very early in the
>> kernel's life.
>>     =

>
> This is the tricky part, and where Steve and I left off.
>   =


Fortunately the linker code should be pretty easy to make
self-contained.   It shouldn't need to do memory allocations or anything
complex like that, so I think its just a matter of grovelling around and
fixing up linkages.

> I suspect we could free the unused backends already.

We could; we just need to make sure they get their own section so
they're easily separable.

>   It also has one
> negative side-effect, which is promoting external module code that links
> with the kernel.  IOW, there's much less incentive to get code merged
> if it's just a matter of linking.

It wouldn't be something we'd promote by making it easy to bind
out-of-tree code to the interface.  And it would still be a
kernel-version-specific ABI; no guarantees of stability.

    J
