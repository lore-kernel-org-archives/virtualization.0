From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH v2 0/6] Collected vdso/vsyscall fixes for 3.1
Date: Wed, 3 Aug 2011 09:59:43 -0400
Message-ID: <CAObL_7FavQH29CENHptZphDDv7ja2P9MVM5Uj47G68ccDumBBg__4292.31315288252$1312380137$gmane$org@mail.gmail.com>
References: <cover.1312378163.git.luto@mit.edu>
	<20110803135322.GC29501@dumpdata.com>
	<20110803135604.GA29761@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110803135604.GA29761@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, keir.xen@gmail.com, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 3, 2011 at 9:56 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Wed, Aug 03, 2011 at 09:53:22AM -0400, Konrad Rzeszutek Wilk wrote:
>> On Wed, Aug 03, 2011 at 09:31:48AM -0400, Andy Lutomirski wrote:
>> > This fixes various problems that cropped up with the vdso patches.
>> >
>> > =A0- Patch 1 fixes an information leak to userspace.
>> > =A0- Patches 2 and 3 fix the kernel build on gold.
>> > =A0- Patches 4 and 5 fix Xen (I hope).
>> > =A0- Patch 6 (optional) adds a trace event to vsyscall emulation. =A0I=
t will
>> > =A0 =A0make it easier to handle performance regression reports :)
>>
>> Hm, you seemed to have the x86 maintainers on your email..
>
> I definitly need some coffee. What I meant was that you missing putting
> the x86 maintainers on this patchset. They are the ones that will handle =
this.
>
> I put them on the To list for you.

Are you sure about that coffee?  I'm pretty sure I had x86@kernel.org in th=
ere.

--Andy
