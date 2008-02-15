From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCHv3 1/3] x86: use ELF format in compressed images.
Date: Fri, 15 Feb 2008 17:37:47 +1100
Message-ID: <47B5333B.5010804__22873.9544902512$1203057694$gmane$org@goop.org>
References: <1202936100-30859-1-git-send-email-ijc@hellion.org.uk>	<9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>	<1202988844.26435.4.camel@muff>	<1203008490.30818.69.camel@localhost.localdomain>
	<1203011834.30565.8.camel@cthulhu.hellion.org.uk>
	<47B4AE2A.6080300@goop.org> <47B4AF4A.2000806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47B4AF4A.2000806@zytor.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Ian Campbell <ijc@hellion.org.uk>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
>>
>> Do you also have a patch to update the boot protocol?
>>
>
> Looking for anything different than the root of this thread?

Yes, the patch for the Xen domain builder to boot a bzImage using the 
Linux boot protocol rather than the Xen one.  Ian's patch will extract 
the ELF file from the bzImage, but still boot it by finding the Xen 
entrypoint in the notes, with %esi pointing to the Xen start_info rather 
than the boot_params (unless I'm missing something).

    J
