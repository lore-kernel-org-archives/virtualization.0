From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/6] x86: Add VMWare Host Communication Macros
Date: Tue, 1 Dec 2015 14:49:11 -0800
Message-ID: <565E23E7.5090800__43095.4347983517$1449010177$gmane$org@zytor.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Sinclair Yeh <syeh@vmware.com>, x86@kernel.org
Cc: Xavier Deguillard <xdeguillard@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12/01/15 14:18, Sinclair Yeh wrote:
> These macros will be used by multiple VMWare modules for handling
> host communication.

> +	__asm__ __volatile__ ("inl %%dx" :                              \

This is odd at best; the standard assembly form of this instruction is:

	inl (%dx),%eax

Also, we don't need the underscored forms of asm and volatile for kernel
code.

> +	__asm__ __volatile__ ("movq %13, %%rbp;"        \
> +		"cld; rep outsb; "                      \
> +		"movq %%rbp, %6" :                      \

cld shouldn't be necessary here, DF=0 is part of the normal ABI environment.

You also don't save/restore %rbp here, but you do below?  Seems very odd.

It might be better do so something like:

+#define VMW_PORT_HB_OUT(in1, in2, port_num, magic,     \
+			eax, ebx, ecx, edx, si, di, bp) \
+({                                                     \
+	__asm__ __volatile__ ("xchgq %6, %%rbp;"        \
+		"cld; rep outsb; "                      \
+		"xchgq %%rbp, %6" :                     \
+		"=a"(eax),                              \
+		"=b"(ebx),                              \
+		"=c"(ecx),                              \
+		"=d"(edx),                              \
+		"+S"(si),                               \
+		"+D"(di),                               \
+		"+r"(bp) :                              \
+		"a"(magic),                             \
+		"b"(in1),                               \
+		"c"(in2),                               \
+		"d"(port_num) :                         \
+		"memory", "cc");                        \
+})
