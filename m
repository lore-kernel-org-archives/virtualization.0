From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V9 9/19]  Split out rate limiting from jump_label.h
Date: Tue, 04 Jun 2013 12:45:41 +0530
Message-ID: <51AD941D.906@linux.vnet.ibm.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<20130601192422.5966.44354.sendpatchset@codeblue>
	<20130603155612.GD4224@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130603155612.GD4224@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/03/2013 09:26 PM, Konrad Rzeszutek Wilk wrote:
> On Sun, Jun 02, 2013 at 12:54:22AM +0530, Raghavendra K T wrote:
>> Split jumplabel ratelimit
>
> I would change the title a bit, perhaps prefix it with: "jump_label: "
>>
>> From: Andrew Jones <drjones@redhat.com>
>>
>> Commit b202952075f62603bea9bfb6ebc6b0420db11949 introduced rate limiting
>
> Also please add right after the git id this:
>
> ("perf, core: Rate limit perf_sched_events jump_label patching")

Agreed.
