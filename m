From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Wed, 02 May 2007 14:39:47 -0700
Message-ID: <46390523.5010809__4907.42985061861$1178149335$gmane$org@goop.org>
References: <20070428758.455116000@suse.de>	<20070428175909.1D09D151CA@wotan.suse.de>	<46338D72.70402@garzik.org>	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com>	<4634483E.9030307@goop.org>	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
	<46363A68.6080201@goop.org> <46385A8A.6070405@redhat.com>
	<4638AB55.20408@goop.org> <4638F9BE.8090508@zytor.com>
	<4638FC39.4010101@goop.org> <4638FE1B.9050901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4638FE1B.9050901@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
>   
>> Hm, that's unfortunate.  How about an ELF file wrapped in some other
>> container, so that we can easily extract a properly formed ELF file?
>>
>>     
>
> Effectively the same thing as changing the magic number.  Note that the
> format for bzImage is pretty rigid, and it would be *highly* undesirable
> to muck that up.

So the bzImage structure is currently:

   1. old-style boot sector
   2. old-style boot info, followed by 0xaa55 at the end of the sector
   3. the HdrS boot param block
   4. setup.S boot code
   5. the self-decompressing kernel

If we make 5 actually an ELF file, containing properly formed Ehdr,
Phdrs (for all the mappings required), and the actual kernel
decompressor, relocator and compressed kernel data, then it would be
easy for the Xen domain builder to find that and use it as a basis for
loading.  I think it would just require the bzImage boot param block to
contain an offset of the start of the ELF file.  The contents of the ELF
file would be in a form where the normal boot code could just jump over
the ELF headers, directly into the segment data itself.

ie:

   1. old-style boot sector
   2. old-style boot info, followed by 0xaa55 at the end of the sector
   3. the HdrS boot param block
   4. setup.S boot code (jumps directly into 5.3)
   5. 32-bit self-decompressing kernel:
         1. Ehdr
         2. Phdrs for all necessary mappings
         3. decompressor/relocator .text
         4. compressed kernel data


Does that sound reasonable?

    J
