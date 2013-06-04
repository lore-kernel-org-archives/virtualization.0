From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC V9 12/19]  xen: Enable PV ticketlocks on HVM Xen
Date: Tue, 4 Jun 2013 10:44:19 -0400
Message-ID: <20130604144419.GE7110@phenom.dumpdata.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<20130601192503.5966.70501.sendpatchset@codeblue>
	<20130603155759.GE4224@phenom.dumpdata.com>
	<51AD9465.6000508@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51AD9465.6000508@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 04, 2013 at 12:46:53PM +0530, Raghavendra K T wrote:
> On 06/03/2013 09:27 PM, Konrad Rzeszutek Wilk wrote:
> >On Sun, Jun 02, 2013 at 12:55:03AM +0530, Raghavendra K T wrote:
> >>xen: Enable PV ticketlocks on HVM Xen
> >
> >There is more to it. You should also revert 70dd4998cb85f0ecd6ac892cc7232abefa432efb
> >
> 
> Yes, true. Do you expect the revert to be folded into this patch itself?
> 

I can do them. I would drop this patch and just mention in
the cover letter that Konrad would have to revert two git commits
to re-enable it on PVHVM.
