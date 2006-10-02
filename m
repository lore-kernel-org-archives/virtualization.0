From: Zachary Amsden <zach@vmware.com>
Subject: Re: paravirt patches in -mm
Date: Sun, 01 Oct 2006 23:48:59 -0700
Message-ID: <4520B65B.4030308@vmware.com>
References: <20060930210129.6ea99bd1.akpm@osdl.org>	<451F483A.6000202@vmware.com>
	<20060930221531.be7b4cfc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060930221531.be7b4cfc.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Sat, 30 Sep 2006 21:46:50 -0700
> Zachary Amsden <zach@vmware.com> wrote:
>
>   =

>> Andrew Morton wrote:
>>     =

>>> Guys, could you please confirm that these patches from -mm:
>>>
>>> paravirt-remove-read-hazard-from-cow.patch
>>> paravirt-pte-clear-not-present.patch
>>> paravirt-lazy-mmu-mode-hooks.patch
>>> paravirt-combine-flush-accessed-dirty.patch
>>> paravirt-kpte-flush.patch
>>> paravirt-optimize-ptep-establish-for-pae.patch
>>> paravirt-remove-set-pte-atomic.patch
>>> paravirt-pae-compile-fix.patch
>>> paravirt-update-pte-hook.patch
>>>
>>> are suitable for mainline inclusion?
>>>   =

>>>       =

>> Yes, these are all originally by me, and they are suitable for =

>> mainline.  They are either nops in mainline or are actually enhancements =

>> to mainline, simplifying or optimizing the pte accessors on i386 and =

>> have zero impact (or improved) impact on code generation and =

>> performance.
>>     =

>
> OK, thanks.
>
>   =

>>  The only regrettable fact is that I broke PAE somewhere in =

>> the middle of the series (thus requiring paravirt-pae-compile-fix as a =

>> separate patch, when I should have rolled the fix into the proper =

>> patch).
>>     =

>
> I can find no PAE compile error, and paravirt-pae-compile-fix.patch just
> removes a few config.h inclusions.
>
>   =

>>  But if you take the whole batch, there is no problem.
>>     =

>
> Well we don't like to break the build partway through a patch series
> because that makes git-bisecting a pain if you happen to land at a bad
> spot.
>   =


Yes, I know.

> <ten compiles later>
>
> It all looks good to me. =

>   =


Ah, ok, now I know what that was.  It was pre-emptively fixing a later =

PAE breakage caused by some include file manipulations that happen if =

you include pgtable.h in certain assembler files.

Zach
