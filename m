From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH v2 0/6] Collected vdso/vsyscall fixes for 3.1
Date: Thu, 11 Aug 2011 13:28:02 -0700
Message-ID: <4E443B52.3080609__48748.5981350348$1313095199$gmane$org@goop.org>
References: <cover.1312378163.git.luto@mit.edu>
	<20110803135322.GC29501@dumpdata.com>
	<20110803135604.GA29761@dumpdata.com>
	<CAObL_7FavQH29CENHptZphDDv7ja2P9MVM5Uj47G68ccDumBBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAObL_7FavQH29CENHptZphDDv7ja2P9MVM5Uj47G68ccDumBBg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com, hpa@zytor.com, mingo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 08/03/2011 06:59 AM, Andrew Lutomirski wrote:
> On Wed, Aug 3, 2011 at 9:56 AM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>> On Wed, Aug 03, 2011 at 09:53:22AM -0400, Konrad Rzeszutek Wilk wrote:
>>> On Wed, Aug 03, 2011 at 09:31:48AM -0400, Andy Lutomirski wrote:
>>>> This fixes various problems that cropped up with the vdso patches.
>>>>
>>>>  - Patch 1 fixes an information leak to userspace.
>>>>  - Patches 2 and 3 fix the kernel build on gold.
>>>>  - Patches 4 and 5 fix Xen (I hope).
>>>>  - Patch 6 (optional) adds a trace event to vsyscall emulation.  It will
>>>>    make it easier to handle performance regression reports :)
>>> Hm, you seemed to have the x86 maintainers on your email..
>> I definitly need some coffee. What I meant was that you missing putting
>> the x86 maintainers on this patchset. They are the ones that will handle this.
>>
>> I put them on the To list for you.
> Are you sure about that coffee?  I'm pretty sure I had x86@kernel.org in there.

What's the state of this series?  Has tip.git picked it up, or does it
need another go-around?

I just booted a Linus tree and got a backtrace that looks like this
issue, though I haven't looked into it in detail yet.

Thanks,
    J
