From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patch 16/21] Xen-paravirt: Add code into head.S to handle being
	booted by Xen
Date: Wed, 14 Feb 2007 14:06:56 -0700
Message-ID: <m17iukphxr.fsf@ebiederm.dsl.xmission.com>
References: <20070213221729.772002682@goop.org>
	<20070213221830.707197267@goop.org> <20070213235424.GA1908@muc.de>
	<45D35ABE.1050504@goop.org> <m1zm7gpkjh.fsf@ebiederm.dsl.xmission.com>
	<45D3740A.4080600@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D3740A.4080600@goop.org> (Jeremy Fitzhardinge's message of
	"Wed, 14 Feb 2007 12:41:46 -0800")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ian Campbell <Ian.Campbell@XenSource.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Eric W. Biederman wrote:
>> Well I did a little by hand parsing and the not I parsed looked ok.
>>
>> How does the output differ from a what you get when xen-head.S is
>> included?
>>   =

> Ah!
>
> The .notes section gets SHT_NOTE in vmlinux when xen-head.S is included;
> PROGBITS when linked.  I tried putting @note on the .section in
> linux/elfnote.h, but that didn't seem to help (xen-note.o got a SHT_NOTE
> entry, but it didn't make it into vmlinux).  I couldn't see any way of
> forcing the section type in vmlinux.lds; my experiments all ended with
> ld dumping core.

Ok.  If that is all this may be a difference that makes no difference.
binutils has a bad habit of looking at sections (which are fully
optional) instead of segments on ET_EXEC and ET_DYN objects.  Only
ET_REL objects (.o files) are required to have sections.

It is worth checking but as long as something looking strictly at the
program headers can find the notes and read them we are in good shape.

That readelf -n has a problem there concerns me a little but as
usually that program is better than the rest of binutils.

So I recommend for testing write a 100 line program that includes
elf.h and reads out the note segment.  If all is well we can split
this code out.

Eric
