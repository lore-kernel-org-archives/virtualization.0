From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Tue, 08 May 2007 13:11:36 -0600
Message-ID: <m1k5vji107.fsf__47269.7911937304$1178651616$gmane$org@ebiederm.dsl.xmission.com>
References: <4634483E.9030307@goop.org> <4638FC39.4010101@goop.org>
	<4638FE1B.9050901@zytor.com> <46390523.5010809@goop.org>
	<463909AF.9040205@zytor.com> <20070503045031.GA5794@in.ibm.com>
	<m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>
	<86802c440705080941y69ddd5d6lab170c5f3967f148@mail.gmail.com>
	<m1sla7i68s.fsf@ebiederm.dsl.xmission.com>
	<86802c440705081033s19365843i5b955ae175de73eb@mail.gmail.com>
	<86802c440705081151r6bfd82e4o50c6a34b2b2a833f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <86802c440705081151r6bfd82e4o50c6a34b2b2a833f@mail.gmail.com>
	(yhlu.kernel@gmail.com's message of "Tue, 8 May 2007 11:51:35 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: yhlu <yhlu.kernel@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, vgoyal@in.ibm.com, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

yhlu <yhlu.kernel@gmail.com> writes:

> Eric,
>
> i tried to load vmlinux with kexec and got
> Ramdisks not supported with generic elf arguments
>
> So i use mkelfImage with my patch ( convert elf64 to elf32) to make
> another elf32. and loaded with kexec and can not get vga console too.
> ---serial console works well.
>
> the mkelfImage 2.7 patch is at
> http://72.14.253.104/search?q=cache:fuxOvFw3ZIIJ:lists.osdl.org/pipermail/fastboot/attachments/20061108/009064a6/attachment.obj+mkelfImage+2.7+patch&hl=en&ct=clnk&cd=4&gl=us
>
> So the problem is not bzImage related, but in somewhere in vmlinux.

Odd.   Is it specifically these patches?
Or is it just the recent kernel from Linus?

You might try a git-bisect, or if it is just these patches
walking through them one-by-one.

Eric
