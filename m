From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 01/11] x86/paravirt: make paravirt_patch_call() and
	paravirt_patch_jmp() static
Date: Fri, 24 Aug 2018 16:00:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1808241600250.1550__20796.5796617374$1535119127$gmane$org@nanos.tec.linutronix.de>
References: <20180813073739.26108-1-jgross@suse.com>
	<20180813073739.26108-2-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180813073739.26108-2-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: rusty@rustcorp.com.au, peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, xen-devel@lists.xenproject.org, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Aug 2018, Juergen Gross wrote:

> paravirt_patch_call() and paravirt_patch_jmp() are used in paravirt.c
> only. Convert them to static.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
