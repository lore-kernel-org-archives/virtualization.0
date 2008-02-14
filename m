From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCHv3 1/3] x86: use ELF format in compressed images.
Date: Fri, 15 Feb 2008 08:10:02 +1100
Message-ID: <47B4AE2A.6080300__47878.3519975424$1203023671$gmane$org@goop.org>
References: <1202936100-30859-1-git-send-email-ijc@hellion.org.uk>	<9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>	<1202988844.26435.4.camel@muff>	<1203008490.30818.69.camel@localhost.localdomain>
	<1203011834.30565.8.camel@cthulhu.hellion.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1203011834.30565.8.camel@cthulhu.hellion.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Campbell <ijc@hellion.org.uk>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Ian Campbell wrote:
> On Thu, 2008-02-14 at 17:01 +0000, Ian Campbell wrote:
>   
>> I have a xen domain builder patch as well. I was waiting for the Linux
>> side to gain some traction before putting it forward (I'd attach it
>> now but it's at home on a laptop which is sleeping).
>>     
>
> Here it is:
>
> # HG changeset patch
> # User ijc@hellion.org.uk
> # Date 1203011758 0
> # Node ID 3079b4b3835e3aba52bb6548bbbced70471a9f32
> # Parent  42369d21641d6297dc369441c3bfd355880d28c0
> Support loading Linux bzImage v2.08 and up.
>   

Do you also have a patch to update the boot protocol?

    J
