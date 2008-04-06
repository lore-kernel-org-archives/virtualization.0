From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCHv3 1/3] x86: use ELF format in compressed images.
Date: Sun, 06 Apr 2008 10:25:28 -0700
Message-ID: <47F90788.90304__10050.3378817395$1207503152$gmane$org@zytor.com>
References: <1202936100-30859-1-git-send-email-ijc@hellion.org.uk>	
	<9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>	
	<86802c440804060003q43f14122vd527514daf77cb89@mail.gmail.com>	
	<47F8FC9C.9090603@zytor.com>
	<86802c440804061019t1cc0e66ejee69b5d90f052b0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <86802c440804061019t1cc0e66ejee69b5d90f052b0d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Ian Campbell <ijc@hellion.org.uk>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Yinghai Lu wrote:
> On Sun, Apr 6, 2008 at 9:38 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>> Yinghai Lu wrote:
>>
>>> so will cost every bzImage extra memory copy? that could be 18M or
>>> even more big.
>>>
>>  I wouldn't worry about that.  You will typically have several copies of the
>> images during the execution of the boot loader.
> 
> i put all drivers needed in kernel.
> 1. bootloader copy bzImage (6M) to memory
> 2. arch/x86/boot/compressed/head_32.S, will copy bzImage to end of
> buffer to do uncompress on possiton.
> 3. parse_elf will copy the vmlinux (the uncompressed, that is some big, 18M)
> 
> I suggest that could have special elf header, and will only have one
> PT_LOAD, and avoid the copy, and just offset start address of
> uncompressed kernel for jump later.

Once again, I think you will have a hard time measuring the time difference.

The start address of the uncompressed kernel is defined at compile time. 
  Typically it is set based on alignment constraints in the hardware; 
for x86-32 is is normally 1 MB but for reasonably large hardware 16 MB 
is better (in fact, I have proposed making 16 MB the default.)  Recovery 
kernels are frequently compiled with completely different addresses.

With your proposal, this would no longer be possible to be a 
configurable option, which would be a major loss -- a major loss of 
functionality for a small fraction of time at bootup time (which is 
almost certainly dwarfed by all the other copying and initialization 
that happens at boot time.)

	-hpa
