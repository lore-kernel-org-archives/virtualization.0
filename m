From: Juergen Gross <jgross@suse.com>
Subject: Re: [bug report] x86/paravirt: Use a single ops structure
Date: Tue, 10 Sep 2019 17:09:13 +0200
Message-ID: <82b0e36b-d6f6-3a5e-9ebe-9675a5764003@suse.com>
References: <20190910145320.GA1479@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190910145320.GA1479@mwanda>
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
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10.09.19 16:53, Dan Carpenter wrote:
> Hello Juergen Gross,
> 
> The patch 5c83511bdb98: "x86/paravirt: Use a single ops structure"
> from Aug 28, 2018, leads to the following static checker warning:
> 
> 	arch/x86/kernel/paravirt.c:123 paravirt_patch_default()
> 	warn: uncapped user index '*(&pv_ops + type)'
> 
> 	arch/x86/kernel/paravirt.c:124 paravirt_patch_default()
> 	error: buffer overflow '&pv_ops' 90 <= 255 user_rl='0-255'
> 
> arch/x86/kernel/paravirt.c
>     116  unsigned paravirt_patch_default(u8 type, void *insn_buff,
>     117                                  unsigned long addr, unsigned len)
>     118  {
>     119          /*
>     120           * Neat trick to map patch type back to the call within the
>     121           * corresponding structure.
>     122           */
>     123          void *opfunc = *((void **)&pv_ops + type);
>                                            ^^^^^^^^^^^^^^
> This code is actually pretty old...
> 
> This isn't a security issue, but the size of &pv_ops is variable but
> type isn't checked so we could be reading beyond the end.  We could do
> something like:
> 
>          if (type >= sizeof(pv_ops) / sizeof(void *))
>                  return -EINVAL;

No, not really. Please check how th return value is being used: it
specifies the length of the instruction to patch. Just returning
-EINVAL would probably clobber most of the kernel.

Please note that type is derived from the pv_ops field names, so
in reality the risk to read beyond the end of pv_ops is zero.


Juergen
