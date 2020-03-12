From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] x86/vmware: Steal time accounting support
Date: Thu, 12 Mar 2020 20:05:14 +0100
Message-ID: <87blp1iec5.fsf@nanos.tec.linutronix.de>
References: <20200212200312.2033-1-amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200212200312.2033-1-amakhalov@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>, Jonathan Corbet <corbet@lwn.net>, "VMware, Inc." <pv-drivers@vmware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Alexey Makhalov <amakhalov@vmware.com> writes:
>
> Alexey Makhalov (5):
>   x86/vmware: Make vmware_select_hypercall() __init
>   x86/vmware: Remove vmware_sched_clock_setup()
>   x86/vmware: Steal time clock for VMware guest
>   x86/vmware: Enable steal time accounting
>   x86/vmware: Use bool type for vmw_sched_clock

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
