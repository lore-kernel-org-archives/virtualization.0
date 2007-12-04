From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 4/8] unify paravirt parts of system.h
Date: Tue, 04 Dec 2007 21:18:33 +0200
Message-ID: <4755A809.4050305__40532.6099404649$1196796293$gmane$org@qumranet.com>
References: <11967843881946-git-send-email-gcosta@redhat.com>
	<11967843943958-git-send-email-gcosta@redhat.com>
	<11967843983411-git-send-email-gcosta@redhat.com>
	<11967844032081-git-send-email-gcosta@redhat.com>
	<11967844071346-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11967844071346-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> This patch moves the i386 control registers manipulation functions,
> wbinvd, and clts functions to system.h. They are essentially the same
> as in x86_64, except for the cr8 register, which we add.
>
> +
> +static inline unsigned long native_read_cr8(void)
> +{
> +	unsigned long cr8;
> +	asm volatile("mov %%cr8,%0" : "=r" (cr8), "=m" (__force_order));
> +	return cr8;
> +}
> +
>   

There is no cr8 register on i386.  This had better be protected by an 
#ifdef.

(you're likely not getting an error since it's a static inline, so the 
asm is never emitted)

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
