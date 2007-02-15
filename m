From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patch 16/21] Xen-paravirt: Add code into head.S to handle being
	booted by Xen
Date: Wed, 14 Feb 2007 18:39:33 -0700
Message-ID: <m1ire4nqqy.fsf@ebiederm.dsl.xmission.com>
References: <20070213221729.772002682@goop.org>
	<20070213221830.707197267@goop.org> <20070213235424.GA1908@muc.de>
	<45D35ABE.1050504@goop.org> <m1zm7gpkjh.fsf@ebiederm.dsl.xmission.com>
	<45D3740A.4080600@goop.org> <m17iukphxr.fsf@ebiederm.dsl.xmission.com>
	<45D3A5A4.7080804@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D3A5A4.7080804@goop.org> (Jeremy Fitzhardinge's message of
	"Wed, 14 Feb 2007 16:13:24 -0800")
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
>> Ok.  If that is all this may be a difference that makes no difference.
>> binutils has a bad habit of looking at sections (which are fully
>> optional) instead of segments on ET_EXEC and ET_DYN objects.  Only
>> ET_REL objects (.o files) are required to have sections.
>>   =

>
> The Xen domain loader will have to be changed to deal with that, which
> isn't too much of a problem.

Ok.  Please fix the Xen domain loader to not look at sections.  It
is a bug for any kind of executable loader to look at anything other
then segments.

> My main concern is the randomness of it, and whether it will fail in
> some more harmful way on other versions of binutils.

Reasonable and it's probably worth letting the binutils developer know.
I do agree that it is weird.   It might be that something in binutils
doesn't like us dropping some of the notes.

>> So I recommend for testing write a 100 line program that includes
>> elf.h and reads out the note segment.  If all is well we can split
>> this code out.
>>   =

>
> The Xen readnotes utility is essentially that.  I'll hack it.

Sounds good.

Eric
