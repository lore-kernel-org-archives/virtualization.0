From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Tue, 08 May 2007 11:18:27 -0600
Message-ID: <m1sla7i68s.fsf__12498.6284798526$1178645031$gmane$org@ebiederm.dsl.xmission.com>
References: <4634483E.9030307@goop.org> <46385A8A.6070405@redhat.com>
	<4638AB55.20408@goop.org> <4638F9BE.8090508@zytor.com>
	<4638FC39.4010101@goop.org> <4638FE1B.9050901@zytor.com>
	<46390523.5010809@goop.org> <463909AF.9040205@zytor.com>
	<20070503045031.GA5794@in.ibm.com>
	<m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>
	<86802c440705080941y69ddd5d6lab170c5f3967f148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <86802c440705080941y69ddd5d6lab170c5f3967f148@mail.gmail.com>
	(yhlu.kernel@gmail.com's message of "Tue, 8 May 2007 09:41:09 -0700")
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
> With the latest change that make vmlinux to be elf64 and make bzImage
> do switch to 64bit long mode, the kernel started via kexec can not get
> VGA console. but the serial console works well. I wonder if the
> setup.S is skipped in bzImage via kexec path.

Yes.  setup.S has always been skipped by bzImage via the kexec path
unless you explicitly tell /sbin/kexec to use the 16bit entry point.

Is not having a VGA console a new thing, or it something you just noticed?

Eric
