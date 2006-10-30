From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Mon, 30 Oct 2006 12:54:55 -0800
Message-ID: <4546669F.8020706@vmware.com>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
	<20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com>
	<200610271416.12548.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200610271416.12548.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> no_timer_check. But it's only there on x86-64 in mainline - although there
> were some patches to add it to i386 too.
>   =


I can rename to match the x86-64 name.


>> That is what this patch is building towards, but the boot option is
>> "free", so why not?  In the meantime, it helps non-paravirt kernels
>> booted in a VM.
>>     =

>
> Hmm, you meant they paniced before?  If they just fail a few tests
> that is not particularly worrying (real hardware does that often too)
>   =


Yes, they sometimes fail to boot, and the failure message used to ask us =

to pester mingo.

Zach
