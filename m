From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 05/10] paravirt: add new PARAVIRT_FULL config item
Date: Wed, 24 May 2017 11:40:12 -0400
Message-ID: <260e7bc9-8cba-bc57-9fe8-0e437562229a@oracle.com>
References: <20170519154746.29389-1-jgross@suse.com>
	<20170519154746.29389-6-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170519154746.29389-6-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On 05/19/2017 11:47 AM, Juergen Gross wrote:
> Add a new config item PARAVIRT_FULL. It will be used to guard the
> pv_*_ops functions used by fully paravirtualized guests (Xen pv-guests
> and lguest) only.
>
> Kernels not meant to support those guest types will be able to use many
> operations without paravirt abstraction while still supporting all the
> other paravirt features.
>
> For now just add the new Kconfig option and select it for XEN_PV and
> LGUEST_GUEST. Add paravirt_full.c, paravirt_full.h and
> paravirt_types_full.h which will contain the necessary implementation
> parts of the pv guest specific paravirt functions.

Is it not possible to just 'ifdef CONFIG_PARAVIT_FULL' the (ir)relevant
parts of paravirt.[ch] and paravirt_types.c?

Separating structures and files into pv and pvfull seems somewhat
arbitrary (.flush_tlb_others in patch 8 being a good example of one type
of guest deciding to use something that normally would be considered
part of a pvfull-type structure).

-boris
