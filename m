From: Jiannan Ouyang <ouyang@cs.pitt.edu>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Sun, 02 Jun 2013 09:20:34 -0700
Message-ID: <CAJocwcf0oykyLv4B22pBf1A3H7+Cs6qu0vmTWp46Z=KwrTkXyQ__21958.1904741519$1370288563$gmane$org@mail.gmail.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<20130602080739.GA24773@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <20130602080739.GA24773@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Jones <drjones@redhat.com>, virtualization@lists.linux-foundation.org, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, konrad.wilk@oracle.com, Jiannan Ouyang <ouyang@cs.pitt.edu>, Avi Kivity <avi.kivity@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, chegu vinod <chegu_vinod@hp.com>, gregkh@suse.de, LKML <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhor
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 2, 2013 at 1:07 AM, Gleb Natapov <gleb@redhat.com> wrote:

> High level question here. We have a big hope for "Preemptable Ticket
> Spinlock" patch series by Jiannan Ouyang to solve most, if not all,
> ticketing spinlocks in overcommit scenarios problem without need for PV.
> So how this patch series compares with his patches on PLE enabled processors?
>

No experiment results yet.

An error is reported on a 20 core VM. I'm during an internship
relocation, and will start work on it next week.

--
Jiannan
