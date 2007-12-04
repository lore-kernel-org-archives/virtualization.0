From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/8] unify paravirt parts of system.h
Date: Tue, 4 Dec 2007 20:34:32 +0100
Message-ID: <20071204193432.GI11764__9600.99150329388$1196804238$gmane$org@bingen.suse.de>
References: <11967843881946-git-send-email-gcosta@redhat.com>
	<11967843943958-git-send-email-gcosta@redhat.com>
	<11967843983411-git-send-email-gcosta@redhat.com>
	<11967844032081-git-send-email-gcosta@redhat.com>
	<11967844071346-git-send-email-gcosta@redhat.com>
	<4755A809.4050305@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4755A809.4050305@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 04, 2007 at 09:18:33PM +0200, Avi Kivity wrote:
> Glauber de Oliveira Costa wrote:
>> This patch moves the i386 control registers manipulation functions,
>> wbinvd, and clts functions to system.h. They are essentially the same
>> as in x86_64, except for the cr8 register, which we add.
>>
>> +
>> +static inline unsigned long native_read_cr8(void)
>> +{
>> +	unsigned long cr8;
>> +	asm volatile("mov %%cr8,%0" : "=r" (cr8), "=m" (__force_order));
>> +	return cr8;
>> +}
>> +
>>   
>
> There is no cr8 register on i386.  This had better be protected by an 
> #ifdef.
>
> (you're likely not getting an error since it's a static inline, so the asm 
> is never emitted)

Linux never uses that register. The only user is suspend save/restore, 
but that' bogus because it wasn't ever initialized by Linux in the first
place. It could be probably all safely removed.

-Andi
