From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 14/26] x86/alternatives: Handle native insns in
 text_poke_loc*()
Date: Wed, 8 Apr 2020 13:11:22 +0200
Message-ID: <20200408111122.GT20713@hirez.programming.kicks-ass.net>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408050323.4237-15-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200408050323.4237-15-ankur.a.arora@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: jgross@suse.com, hpa@zytor.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 07, 2020 at 10:03:11PM -0700, Ankur Arora wrote:
>  struct text_poke_loc {
>  	s32 rel_addr; /* addr := _stext + rel_addr */
> -	s32 rel32;
> -	u8 opcode;
> +	union {
> +		struct {
> +			s32 rel32;
> +			u8 opcode;
> +		} emulated;
> +		struct {
> +			u8 len;
> +		} native;
> +	};
>  	const u8 text[POKE_MAX_OPCODE_SIZE];
>  };

NAK, this grows the structure from 16 to 20 bytes.
