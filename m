From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH] xen/grant-table: Refactor gnttab_[un]map_refs to avoid
	m2p_override
Date: Mon, 10 Mar 2014 17:35:58 +0000
Message-ID: <531DF7FE.1000708@citrix.com>
References: <1393516530-9145-1-git-send-email-zoltan.kiss@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1393516530-9145-1-git-send-email-zoltan.kiss@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zoltan Kiss <zoltan.kiss@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Russell King <linux@arm.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Matt Wilson <msw@linux.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Anthony Liguori <aliguori@amazon.com>, "H.
	Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, =?ISO-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 27/02/14 15:55, Zoltan Kiss wrote:
> (This is a continuation of "[PATCH v9] xen/grant-table: Avoid m2p_override
> during mapping")
> 
> The grant mapping API does m2p_override unnecessarily: only gntdev needs it,
> for blkback and future netback patches it just cause a lock contention, as
> those pages never go to userspace. Therefore this series does the following:
> - the bulk of the original function (everything after the mapping hypercall)
>   is moved to arch-dependent set/clear_foreign_p2m_mapping
> - the "if (xen_feature(XENFEAT_auto_translated_physmap))" brach goes to ARM
> - therefore the ARM function could be much smaller, the m2p_override stubs
>   could be also removed
> - on x86 the set_phys_to_machine calls were moved up to this new funcion
>   from m2p_override functions
> - and m2p_override functions are only called when there is a kmap_ops param
> 
> It also removes a stray space from arch/x86/include/asm/xen/page.h.

Applied to devel/for-linus-3.15.

Thanks.

David
