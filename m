From: yhlu <yhlu.kernel@gmail.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Wed, 9 May 2007 09:31:48 -0700
Message-ID: <86802c440705090931v39cb355cma06ccbc90954baeb__46027.8154853315$1178731731$gmane$org@mail.gmail.com>
References: <4634483E.9030307@goop.org>
	<m17irivkhy.fsf@ebiederm.dsl.xmission.com>
	<46413087.2020505@zytor.com>
	<m1tzumu10k.fsf@ebiederm.dsl.xmission.com>
	<86802c440705082152g49d4d3echf3eb165ce4feb2e9@mail.gmail.com>
	<46415640.6000600@zytor.com> <4641573C.1000205@zytor.com>
	<86802c440705082248r5248aa08s8299e03f615b984a@mail.gmail.com>
	<46416246.9090005@zytor.com>
	<m1abwetgkn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1abwetgkn.fsf@ebiederm.dsl.xmission.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, vgoyal@in.ibm.com, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 5/9/07, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> We can look in /proc/ioports and see what has reserved
> the video resources.  That should give us a reasonable
> estimate of the video adapter.  We can do an ioctl to
> the console and see how many lines and columns we have.
>
> Reusing boot_params could be nice but if we have the information
> available in other ways digging it out that way is quite possibly
> better.

Another path:
LiuxBIOS+elfboot+payload, and payload is compressed elf
(vmlinux+initrd) via lzma.
and use kexec to boot final production kernel.
We don't need to use boot_params from the first tiny kernel.

YH
