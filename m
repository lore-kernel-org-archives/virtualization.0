From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Tue, 08 May 2007 22:58:27 -0600
Message-ID: <m1ejlqtwy4.fsf__34136.2018873498$1178729683$gmane$org@ebiederm.dsl.xmission.com>
References: <4638FC39.4010101@goop.org> <46390523.5010809@goop.org>
	<463909AF.9040205@zytor.com> <20070503045031.GA5794@in.ibm.com>
	<m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>
	<86802c440705080941y69ddd5d6lab170c5f3967f148@mail.gmail.com>
	<m1sla7i68s.fsf@ebiederm.dsl.xmission.com>
	<86802c440705081033s19365843i5b955ae175de73eb@mail.gmail.com>
	<86802c440705081151r6bfd82e4o50c6a34b2b2a833f@mail.gmail.com>
	<20070509033348.GA12361@in.ibm.com>
	<86802c440705082142u7ee2b402q9ae09edbed32766a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <86802c440705082142u7ee2b402q9ae09edbed32766a@mail.gmail.com>
	(yhlu.kernel@gmail.com's message of "Tue, 8 May 2007 21:42:02 -0700")
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

> On 5/8/07, Vivek Goyal <vgoyal@in.ibm.com> wrote:
>> On Tue, May 08, 2007 at 11:51:35AM -0700, yhlu wrote:
>> This message generally appears if you did not specify --args-linux
>> on kexec command line while loading vmlinux.
>>
> besides elf-x86_64, still need --args-linux to pass sth? but how to
> let it load ramdisk?

Same arguments just use --args-linux.

Basically the calling convention needs to be specified because
there isn't a universal one, and /sbin/kexec can't yet detect
vmlinux is linux.

Eric
