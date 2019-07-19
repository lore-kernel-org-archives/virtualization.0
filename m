From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 0/9] x86: Concurrent TLB flushes
Date: Fri, 19 Jul 2019 14:36:00 -0700
Message-ID: <21b9c9f2-de63-71e9-34e3-8206b778f8b7__27675.966643595$1563572182$gmane$org@intel.com>
References: <20190719005837.4150-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190719005837.4150-1-namit@vmware.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>, Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Rik van Riel <riel@surriel.com>, Peter Zijlstra <peterz@infradead.org>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Thanks for doing this, it's something I've been hoping someone would do
for a long time.

While I kinda wish we had performance data for each individual patch (at
least the behavior-changing ones), this does look like a good
improvement.  That might, for instance, tell is a bit about how the
separating out "is_lazy" compares to the "check before setting"
optimization.  But, they're both sane enough on their own that I'm not
too worried.

I had some nits that I hope get covered in later revisions, if sent.
But, overall looks fine.  For the series:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
