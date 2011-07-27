From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [Xen-devel] Re: [PATCH 0/5] Collected vdso/vsyscall fixes for 3.1
Date: Wed, 27 Jul 2011 13:05:18 -0400
Message-ID: <CAObL_7F4pqWGAFgrG8KiwCW4X+BOgvFfsdHNfkhhmVDqMOSuvQ__4441.29850152439$1311786377$gmane$org@mail.gmail.com>
References: <cover.1311736366.git.luto@mit.edu>
	<20110727145745.GA11872@dumpdata.com>
	<CAObL_7FT8QLg-wihasBahhAtS=pA7+KeU8E=E9x8NPZ0+QJ5iQ@mail.gmail.com>
	<20110727153015.GA16688@dumpdata.com>
	<CAObL_7GWGx4rYJFLpucEX=ozNpk+5ipyq0=vw16xcGetEXSuGQ@mail.gmail.com>
	<20110727154316.GA16909@dumpdata.com>
	<CAObL_7FncQ7DdNf2igFZW=ZzPFQLO3Vvp1c_y5EajA_KTt8iOg@mail.gmail.com>
	<20110727165844.GA8064@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110727165844.GA8064@dumpdata.com>
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

On Wed, Jul 27, 2011 at 12:58 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>> >> $ test_vsyscall test
>> >> Testing gettimeofday...
>> >> =A0 vDSO offset =3D 0.000001s
>> >> =A0 vsyscall offset =3D 0.000001s
>> >>
>> >> Testing time...
>> >> =A0 vDSO offset =3D 0
>> >> =A0 vsyscall offset =3D 0
>> >> Testing getcpu...
>> >> =A0 ok! =A0cpu=3D6 node=3D0
>
>> I bet if you pull a new copy or remove -mavx from Makefile it will
>> work. =A0I got a grossly hacked-up Xen domU booted and everything seems
>> to work.
>
> It did. Both Dom0 and DomU work on AMD and Intel.
>
> In regards to the last pv-ops patch - is there no better way? The reason =
I am asking
> is the pv-ops hook is just a bandaid for the problem. Is the Xen syscall =
suppose to
> be doingsomething extra with the stack perhaps?
>

The Xen code in question is:

restore_all_guest:
        ASSERT_INTERRUPTS_DISABLED
        RESTORE_ALL
        testw $TRAP_syscall,4(%rsp)
        jz    iret_exit_to_guest

        addq  $8,%rsp
        popq  %rcx                    # RIP
        popq  %r11                    # CS
        cmpw  $FLAT_USER_CS32,%r11
        popq  %r11                    # RFLAGS
        popq  %rsp                    # RSP
        je    1f
        sysretq
1:      sysretl


So with VCGF_in_syscall set, the ireq hypercall will return via
sysretq if the saved CS is __USER_CS or FLAT_USER_CS64.  This is
faster than iretq.

The hypervisor doesn't allow the guest OS to override the values in
MSR_STAR, so FLAT_USER_CS64 gets returned to userspace.  And sysretq
is probably much faster than iretq, so unsetting VCGF_in_syscall is
probably a bad idea.

The ideal solution would be to allow the kernel to change MSR_STAR,
but this would require changing the hypervisor and the kernel.

--Andy
