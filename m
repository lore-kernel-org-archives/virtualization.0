From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 6/9] x86: prevent inline distortion by paravirt ops
Date: Tue, 19 Jun 2018 17:09:22 +0200
Message-ID: <39832e4b-db6c-e3bc-1013-d9f1aaf19c83@suse.com>
References: <20180612115050.185112-1-namit@vmware.com>
	<20180612115050.185112-7-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180612115050.185112-7-namit@vmware.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12/06/18 13:50, Nadav Amit wrote:
> GCC considers the number of statements in inlined assembly blocks,
> according to new-lines and semicolons, as an indication to the cost of
> the block in time and space. This data is distorted by the kernel code,
> which puts information in alternative sections. As a result, the
> compiler may perform incorrect inlining and branch optimizations.
> 
> The solution is to set an assembly macro and call it from the inlined
> assembly block. As a result GCC considers the inline assembly block as
> a single instruction.
> 
> The effect of the patch is a more aggressive inlining, which also
> causes a size increase of kernel.
> 
>    text	   data	    bss	    dec	    hex	filename
> 18147336 10226688 2957312 31331336 1de1408 ./vmlinux before
> 18162555 10226288 2957312 31346155 1de4deb ./vmlinux after (+14819)
> 
> Static text symbols:
> Before:	40053
> After:	39942	(-111)
> 
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Alok Kataria <akataria@vmware.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: virtualization@lists.linux-foundation.org
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
