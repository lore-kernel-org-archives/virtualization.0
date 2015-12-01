From: Xavier Deguillard <xdeguillard@vmware.com>
Subject: Re: [PATCH 1/6] x86: Add VMWare Host Communication Macros
Date: Tue, 1 Dec 2015 14:32:38 -0800
Message-ID: <20151201223238.GM24642__14684.8288750791$1449075505$gmane$org@xdeguillard-ws.eng.vmware.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1449008332-9394-1-git-send-email-syeh@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sinclair Yeh <syeh@vmware.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Hey Sinclair,

On Tue, Dec 01, 2015 at 02:18:47PM -0800, Sinclair Yeh wrote:
> +/**
> + * Hypervisor-specific bi-directional communication channel.  Should never
> + * execute on bare metal hardware.  The caller must make sure to check for
> + * supported hypervisor before using these macros.
> + *
> + * Several of the parameters are both input and output and must be initialized.
> + *
> + * @in1: [IN] Message Len or Message Cmd (HB)
> + * @in2: [IN] Message Len (HB) or Message Cmd

Can you make in1 always be the "Message Cmd" and in2 always be the
"Message len"?

> + * @port_num: [IN] port number + [channel id]
> + * @magic: [IN] hypervisor magic value
> + * @eax: [OUT] value of EAX register
> + * @ebx: [OUT] e.g. status from an HB message status command
> + * @ecx: [OUT] e.g. status from a non-HB message status command
> + * @edx: [OUT] e.g. channel id
> + * @si: [INOUT] set to 0 if not used
> + * @di: [INOUT] set to 0 if not used
> + * @bp: [INOUT] set to 0 if not used
> + */
> +#define VMW_PORT(in1, in2, port_num, magic, eax, ebx, ecx, edx, si, di) \
> +({                                                                      \
> +	__asm__ __volatile__ ("inl %%dx" :                              \

Are those '\' aligned in the code?

> +
> +#define VMW_PORT_HB_OUT(in1, in2, port_num, magic,      \
> +			eax, ebx, ecx, edx, si, di, bp) \
> +({                                                      \
> +	__asm__ __volatile__ ("movq %13, %%rbp;"        \

Same here.

> +
> +#define VMW_PORT_HB_IN(in1, in2, port_num, magic,            \
> +		       eax, ebx, ecx, edx, si, di, bp)       \
> +({                                                           \
> +	__asm__ __volatile__ ("push %%rbp; movq %13, %%rbp;" \

Same.

Xavier
