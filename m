From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH 0/5] Collected vdso/vsyscall fixes for 3.1
Date: Wed, 27 Jul 2011 11:04:44 -0400
Message-ID: <CAObL_7FT8QLg-wihasBahhAtS=pA7+KeU8E=E9x8NPZ0+QJ5iQ__8729.58863988078$1311779231$gmane$org@mail.gmail.com>
References: <cover.1311736366.git.luto@mit.edu>
	<20110727145745.GA11872@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110727145745.GA11872@dumpdata.com>
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
Cc: xen-devel@lists.xensource.com, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 27, 2011 at 10:57 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Tue, Jul 26, 2011 at 11:20:34PM -0400, Andy Lutomirski wrote:
>> This fixes various problems that cropped up with the vdso patches.
>>
>> =A0- Patch 1 fixes an information leak to userspace.
>> =A0- Patches 2 and 3 fix the kernel build on gold.
>> =A0- Patches 4 and 5 fix Xen (I hope).
>>
>> Konrad, could you could test these on Xen and run 'test_vsyscall test' [=
1]?
>
> They boot 64-bit guest succesfully.
>
> But I doesn't compile under 32-bit:
>
> home/konrad/ssd/linux/arch/x86/xen/enlighten.c:953: error: unknown field =
=91extra_user_64bit_cs=92 specified in initializer
> /home/konrad/ssd/linux/arch/x86/xen/enlighten.c:953: error: =91FLAT_USER_=
CS64=92 undeclared here (not in a function)
>
> Looks like it needs some #ifdef CONFIG_X86_64 magic.. and after
> applying that magic dust it compiles and it also boots as 32-bit
> (no surprise there).

Whoops!  I thought xen/enlighten.c was 64-bit only.

>
>> I don't have a usable Xen setup.
>
> It is pretty easy to setup. Google for PVops Wiki and you will find wealth
> of information. FYI: I am gone next week so won't be able to test these
> patches.
>
>>
>> Also, I'd appreciate a review of patches 4 and 5 from some Xen/paravirt
>> people.
>>
>> [1] https://gitorious.org/linux-test-utils/linux-clock-tests
>
> Grrrrr..
>
> g++ -o test_vsyscall -std=3Dgnu++0x -lrt -ldl -O2 -Wall -mavx -g test_vsy=
scall.cc
> test_vsyscall.cc: In function =91int bench(int, char**)=92:
> test_vsyscall.cc:205: error: expected primary-expression before =91[=92 t=
oken

[...]

>
> Is there a specific version of GCC I should be using? I seem to be
> using: g++ (GCC) 4.4.4 20100503 (Red Hat 4.4.4-2)

Apparently it needs g++ 4.5 for lambdas.

>
> Anyhow, removed the benchmark code and ran it on 64-bit:
>
> sh-4.1# /test_vsyscall =A0test
> Testing gettimeofday...
> [ =A0109.552261] test_vsyscall[2462] trap invalid opcode ip:400c8d sp:7ff=
f84fab470 error:0 in test_vsyscall[400000+2000]
> Illegal instruction
> sh-4.1# /test_vsyscall =A0intcc
> About to execute int 0xcc from RIP =3D 400959
> [ =A0114.137150] test_vsyscall[2463] illegal int 0xcc (exploit attempt?) =
ip:400959 cs:e033 sp:7fff8b328310 ax:2c si:0 di:7fff8b3280f0
> Caught SIGSEGV: Segmentation fault (Signal sent by the kernel [(nil)])RIP=
 =3D 400959
>
> [This is on git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git =
#testing, which
> has todays linus/master and your patchset]
>

I'll set up Xen.  Something's clearly still buggy.

--Andy
