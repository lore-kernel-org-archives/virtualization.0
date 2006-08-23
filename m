From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Translate asm version of ELFNOTE macro into	preprocessor
	macro
Date: Wed, 23 Aug 2006 10:47:46 -0700
Message-ID: <44EC94C2.9080608@goop.org>
References: <1156333761.12949.35.camel@localhost.localdomain>	<44EC6B12.4060909@goop.org>	<1156346074.12949.129.camel@localhost.localdomain>	<44EC72F3.70505@goop.org>
	<m1sljnml73.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <m1sljnml73.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Virtualization <virtualization@lists.osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Ian Campbell <Ian.Campbell@XenSource.com>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Jeremy Fitzhardinge <jeremy@goop.org> writes:
>
>   =

>> Ian Campbell wrote:
>>     =

>>>> OK, seems reasonable.  Eric Biederman solved this by having NOTE/ENDNO=
TE (or
>>>> something like that) in his "bzImage with ELF header" patch, but I don=
't
>>>> remember it being used in any way which is incompatible with using a C=
PP
>>>> macro.
>>>>
>>>>         =

>>> I can't find that patch, does NOTE/ENDNOTE just do the push/pop .note
>>> section?
>>>
>>> That would solve the problem with the first argument of the macro being
>>> a string but the final argument could still be for .asciz note contents.
>>>
>>>       =


I remember now why I decided to use the assembler macro rather than =

cpp.  The macro names the section after the note name (".note.NAME"), =

and it needs to be quoted so that the name can have spaces and other =

characters which would otherwise upset the assembler.  I couldn't work =

out a clean way to do this with the C preprocessor, since "as" doesn't =

support string concatenation like C does.


> I don't expect it to be much more cumbersome, as two pieces, and you need=
 the extra
> alignment at the end to ensure each not entry is 4 byte aligned. =


Isn't it enough that each entry start have the alignment?  But you need =

some kind of end marker to get the size of the desc field regardless.


>  Being able to
> push and pop a section wouldn't hurt either. =


Yes, I think having each note contain its own .pushsection/popsection is =

the cleaner way of doing it.


    J
