From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 19/19] unify set_tss_desc
Date: Thu, 13 Dec 2007 12:50:03 -0200
Message-ID: <4761469B.9060507@redhat.com>
References: <1197511363887-git-send-email-gcosta@redhat.com>
	<11975113672937-git-send-email-gcosta@redhat.com>
	<11975113721808-git-send-email-gcosta@redhat.com>
	<11975113771692-git-send-email-gcosta@redhat.com>
	<11975113821418-git-send-email-gcosta@redhat.com>
	<11975113873364-git-send-email-gcosta@redhat.com>
	<11975113923422-git-send-email-gcosta@redhat.com>
	<11975113961144-git-send-email-gcosta@redhat.com>
	<1197511401733-git-send-email-gc!osta@redhat.com>
	<11975114062948-git-send-email-gcosta@redhat.com>
	<20071213124633.GG31699@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071213124633.GG31699@bingen.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> +static inline void pack_tss(tss_desc *tss, unsigned long addr,
>> +			   unsigned size, unsigned entry)
>> +{
>> +#ifdef CONFIG_X86_64
>> +		set_tssldt_descriptor(tss,
>> +			     addr, entry, size);
>> +#else
>> +		pack_descriptor(tss, (unsigned long)addr,
>> +				size,
>> +				0x80 | entry, 0);
> 
> It would be better if you just unified that first instead of ifdef'ing.
> I guess i386 could get a set_tssldt_descriptor() like wrapper
> around pack_descriptor(). 
Good point.

Thanks, Andi.
