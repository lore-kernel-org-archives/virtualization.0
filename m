From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Tue, 08 May 2007 21:30:35 -0600
Message-ID: <m1tzumu10k.fsf__13283.1541974612$1178729111$gmane$org@ebiederm.dsl.xmission.com>
References: <4634483E.9030307@goop.org>
	<m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>
	<86802c440705080941y69ddd5d6lab170c5f3967f148@mail.gmail.com>
	<m1sla7i68s.fsf@ebiederm.dsl.xmission.com>
	<86802c440705081033s19365843i5b955ae175de73eb@mail.gmail.com>
	<86802c440705081151r6bfd82e4o50c6a34b2b2a833f@mail.gmail.com>
	<m1k5vji107.fsf@ebiederm.dsl.xmission.com>
	<86802c440705081500x682ee098y7d51f7bb98dbcff6@mail.gmail.com>
	<4640F4B3.30408@goop.org> <4640FB2C.2060300@zytor.com>
	<86802c440705081541v7d0773cek2c5fae1854b68bbc@mail.gmail.com>
	<46410403.4050802@zytor.com>
	<m17irivkhy.fsf@ebiederm.dsl.xmission.com>
	<46413087.2020505@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46413087.2020505@zytor.com> (H. Peter Anvin's message of "Tue,
	08 May 2007 19:23:03 -0700")
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

> Eric W. Biederman wrote:
>> 
>> I expect I can find a few more examples where we specify
>> video_cols and video_lines but we use video_mode == 0.
>> 
>> Going farther mode 0x00 is a BIOS 40x25 mode.  So the patch below is
>> not always safe even if we boot the bzImage.  It is just highly
>> unlikely anyone would start the kernel in 40x25 text mode. 
>> 
>
> Mode 0x00 is, at least theoretically, BIOS 40x25 *grayscale*; this mode
> (and mode 0x02 which is the same thing in 80x25) were as far as I know
> only ever used with composite monitors off CGA cards, i.e. functionally
> never.  Actual monochrome monitors used mode 0x07.

I agree.  We are not at all likely to see it in practice.  Even
if my memory is correct and vga cards and non-monochrome cga
cards supported that mode.

That doesn't mean checking for 0x00 is sufficient to detect
an initialized struct screen_info, or a lack of a video screen.

We have in kernel historical precedent for using 0x00 as just meaning
a text mode.  I'm fairly certain that I looked I more closely I could
find this convention of using 0x00 to mean a text mode on ia64, mips,
and ppc, in addition to the instances I found on alpha, arm,

Since the whole point is to detect the case where we don't have
a screen at all it makes sense to check several additional variables
and make certain that they are all 0.  Agreed?

Eric
