From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Wed, 09 May 2007 04:52:08 -0600
Message-ID: <m1abwetgkn.fsf__42324.5444930673$1178729921$gmane$org@ebiederm.dsl.xmission.com>
References: <4634483E.9030307@goop.org> <4640FB2C.2060300@zytor.com>
	<86802c440705081541v7d0773cek2c5fae1854b68bbc@mail.gmail.com>
	<46410403.4050802@zytor.com>
	<m17irivkhy.fsf@ebiederm.dsl.xmission.com>
	<46413087.2020505@zytor.com>
	<m1tzumu10k.fsf@ebiederm.dsl.xmission.com>
	<86802c440705082152g49d4d3echf3eb165ce4feb2e9@mail.gmail.com>
	<46415640.6000600@zytor.com> <4641573C.1000205@zytor.com>
	<86802c440705082248r5248aa08s8299e03f615b984a@mail.gmail.com>
	<46416246.9090005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46416246.9090005@zytor.com> (H. Peter Anvin's message of "Tue,
	08 May 2007 22:55:18 -0700")
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
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, vgoyal@in.ibm.com, yhlu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> yhlu wrote:
>> so the kexec tools need to scan the pci devices list, and find out how
>> to set real_mode.isVGA and orig_video_mode, also need to parse the
>> comand line about vga console.
>
> BTW, welcome to the hell of bypassing setup.

Well in this case things are so very much better then attempting to
us setup.S it isn't a real option.

In general BIOS calls just don't work reliably after linux has
been running for a while.

As for YH's point it does look like there are a few ways
to poke the linux kernel to see what is happening.

We can look in /proc/ioports and see what has reserved
the video resources.  That should give us a reasonable
estimate of the video adapter.  We can do an ioctl to
the console and see how many lines and columns we have.

Reusing boot_params could be nice but if we have the information
available in other ways digging it out that way is quite possibly
better.


Eric
